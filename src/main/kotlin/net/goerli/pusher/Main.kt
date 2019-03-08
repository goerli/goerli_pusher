package net.goerli.pusher

import org.kethereum.crypto.createEthereumKeyPair
import org.kethereum.eip155.signViaEIP155
import org.kethereum.erc681.ERC681
import org.kethereum.erc681.generateURL
import org.kethereum.functions.encodeRLP
import org.kethereum.keystore.api.InitializingFileKeyStore
import org.kethereum.model.*
import org.kethereum.rpc.EthereumRPC
import org.kethereum.rpc.model.BlockInformation
import org.walleth.console.barcodes.printQR
import org.walleth.khex.clean0xPrefix
import org.walleth.khex.hexToByteArray
import org.walleth.khex.toHexString
import java.io.File
import java.lang.Thread.sleep
import java.math.BigInteger
import java.math.BigInteger.ZERO

private val FAUCET_ADDRESS = listOf(
    "0x8ced5ad0d8da4ec211c17355ed3dbfec4cf0e5b9", // simple
    "0x8c1e1e5b47980d214965f3bd8ea34c413e120ae4" // social
)

fun main() {

    val rpc = EthereumRPC("https://in3.slock.it/goerli/nd-3")

    val keyStore = InitializingFileKeyStore(File("keystore")).apply {
        if (getAddresses().isEmpty()) {
            println("creating new keypair")
            addKey(createEthereumKeyPair())
        }
    }

    val address = keyStore.getAddresses().first()
    val keyPair = keyStore.getKeyForAddress(address)!!

    val erc681 = ERC681(address = address.hex)
    printQR(erc681.generateURL())
    println(address.cleanHex)

    var lastBlock = rpc.blockNumber()?.result
    var currentBlock: BlockInformation?

    while (true) {
        val newBlock = rpc.blockNumber()?.result
        if (newBlock != null && newBlock != lastBlock) {

            currentBlock = rpc.getBlockByNumber(newBlock)

            print(".")
            val transactionsFromFaucet: List<SignedTransaction> =
                currentBlock?.transactions?.filter { tx ->
                    FAUCET_ADDRESS.any { address -> tx.transaction.from.toString().toLowerCase() == address }
                } ?: emptyList()

            transactionsFromFaucet.forEach {
                print("\n")
                println("tx from faucet: " + it.transaction.to)

                it.transaction.to?.let { toAddress ->

                    val txCount = rpc.getTransactionCount(address.hex, "latest")
                    val chain = ChainDefinition(ChainId(5), "GOR")
                    val transaction = Transaction().copy(
                        chain = chain,
                        from = address,
                        to = Address("0x7af963cF6D228E564e2A0aA0DdBF06210B38615D"),
                        value = ZERO,
                        gasLimit = BigInteger("100000"),
                        nonce = BigInteger(txCount?.result?.clean0xPrefix(), 16),
                        input = ("40c10f19"
                                + "0".repeat(24) + toAddress.cleanHex
                                + "000000000000000000000000000000000000000000000016c4abbebea0100000"
                                ).hexToByteArray().toList()
                    )
                    val signature = transaction.signViaEIP155(keyPair, chain)

                    val tx = transaction.encodeRLP(signature).toHexString()

                    val sendTx = rpc.sendRawTransaction(tx)

                    if (sendTx?.result != null) {
                        println("send tx " + sendTx.result)
                    } else {
                        println("send tx error " + sendTx?.error)
                    }
                }
            }

            lastBlock = newBlock
        }

        sleep(2000)
    }
}
