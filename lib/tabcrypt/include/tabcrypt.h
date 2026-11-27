#ifndef TABCRYPT_H
#define TABCRYPT_H

#include <string>
#include <vector>

namespace tabcrypt {
    std::vector<unsigned char> encrypt(const std::string &secret, const std::vector<unsigned char> message);

    std::vector<unsigned char> decrypt(const std::string &secret, const std::vector<unsigned char> message);
}

#endif
