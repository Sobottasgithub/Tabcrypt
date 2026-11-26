#include <tablog.h>
#include <tabcrypt.h>

#include <string>
#include <memory>

int main() {
    std::shared_ptr<tablog::Tablog> logger = std::make_shared<tablog::Tablog>();
    logger->configure("Tabcrypt-Test");
    
    const std::string secret = "test";
    const std::string message = "HelloWorld";
    const std::string encryptedMessage = tabcrypt::encrypt(secret, message);

    const std::string decryptedMessage = tabcrypt::decrypt(secret, encryptedMessage);

    if (!message.compare(decryptedMessage)) {
        logger->log(tablog::INFO, "Encryption/Decryption successful!");
        return 0;   
    } else {
        logger->log(tablog::ERROR, "Encryption/Decryption failed!");
        return -1;
    }    
}
