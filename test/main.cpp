#include <tablog.h>
#include <tabcrypt.h>

#include <string>
#include <memory>
#include <vector>

int main() {
    std::shared_ptr<tablog::Tablog> logger = std::make_shared<tablog::Tablog>();
    logger->configure("Tabcrypt-Test");
    
    const std::string secret = "test";
    const std::vector<unsigned char> message = {'H', 'E', 'L', 'L', 'O'};
    const std::vector<unsigned char> encryptedMessage = tabcrypt::encrypt(secret, message);

    const std::vector<unsigned char> decryptedMessage = tabcrypt::decrypt(secret, encryptedMessage);

    if (message == decryptedMessage) {
        logger->log(tablog::INFO, "Encryption/Decryption successful!");
        return 0;   
    } else {
        logger->log(tablog::ERROR, "Encryption/Decryption failed!");
        return -1;
    }    
}
