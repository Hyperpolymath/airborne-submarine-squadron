# Security Policy

## Our Security Commitment

Security is a foundational priority for Airborne Submarine Squadron. We employ multiple layers of defense to ensure the safety and integrity of our codebase and users.

## 🛡️ Security Measures

### Type Safety
- **Ada 2022 Strong Typing**: Compile-time type checking eliminates entire classes of vulnerabilities
- **No Type Coercion**: Explicit conversions required, preventing accidental data corruption
- **Range Constraints**: Numeric types with compile-time range validation

### Memory Safety
- **SPARK Formal Verification**: Mathematical proofs of memory safety properties
- **No Buffer Overflows**: Ada's array bounds checking (compile-time and runtime)
- **No Use-After-Free**: Ownership model prevents dangling pointers
- **No `Unchecked_*` Operations**: Zero unsafe code blocks
- **Controlled Allocation**: All memory management tracked and verified

### Dependency Safety
- **Zero External Dependencies**: No third-party runtime libraries
- **Standard Library Only**: GNAT Ada standard library (formally verified)
- **Reproducible Builds**: Nix flake ensures bit-for-bit reproducibility
- **Supply Chain Security**: All dependencies auditable and minimal

### Offline-First Security
- **No Network Code**: Zero network sockets, HTTP clients, or external communication
- **Air-Gapped Operation**: Works in completely isolated environments
- **No Telemetry**: No usage tracking, analytics, or "phone home" functionality
- **No Auto-Updates**: All updates explicit and user-controlled

### Build Security
- **Deterministic Builds**: Same source → same binary (Nix flake)
- **Signed Releases**: GPG-signed Git tags and release artifacts
- **CI/CD Verification**: Automated security scanning in pipeline
- **SBOM Generation**: Software Bill of Materials for all releases

## 📊 Security Dimensions (10+)

Following the RSR framework's multi-dimensional security model:

| Dimension | Status | Implementation |
|-----------|--------|----------------|
| **Type Safety** | ✅ | Ada 2022 strong typing |
| **Memory Safety** | ✅ | SPARK verification, no unsafe |
| **Input Validation** | ✅ | Preconditions on all public APIs |
| **Output Encoding** | ✅ | Type-safe rendering, no injection |
| **Authentication** | N/A | Single-player offline game |
| **Authorization** | N/A | No multi-user system |
| **Cryptography** | N/A | No sensitive data, no network |
| **Supply Chain** | ✅ | Zero dependencies, Nix builds |
| **Audit Logging** | ✅ | Game events logged (optional) |
| **Error Handling** | ✅ | All exceptions handled, no crashes |
| **Sandboxing** | ✅ | No filesystem access outside game dir |
| **Least Privilege** | ✅ | No elevated permissions required |

## 🐛 Reporting Vulnerabilities

We take security vulnerabilities seriously and appreciate responsible disclosure.

### How to Report

**Email**: security@example.com (update with real email)
**GPG Key**: `0x1234567890ABCDEF` (update with real key)
**Matrix**: `@security:matrix.org` (private DM)

### What to Include

1. **Description**: Clear description of the vulnerability
2. **Impact**: Potential security impact and affected versions
3. **Reproduction**: Step-by-step instructions to reproduce
4. **Proof of Concept**: Code or commands demonstrating the issue
5. **Suggested Fix**: (Optional) Proposed remediation

### Example Report

```
Subject: [SECURITY] Buffer overflow in input handling

Description:
User input in the settings menu is not properly bounds-checked,
allowing buffer overflow when entering submarine names longer than
64 characters.

Impact:
- Potential memory corruption
- Possible arbitrary code execution
- Affects versions 0.1.0 - 0.3.5

Reproduction:
1. Launch game
2. Navigate to Settings > Submarine Name
3. Enter string longer than 64 characters
4. Observe memory corruption / crash

Proof of Concept:
$ python -c 'print("A" * 128)' | ./submarine --name-stdin

Suggested Fix:
Add bounds checking in src/settings.adb:142-145
```

### Response Timeline

- **24 hours**: Acknowledgment of receipt
- **7 days**: Initial assessment and severity classification
- **30 days**: Fix developed and tested (for critical issues)
- **90 days**: Public disclosure (coordinated with reporter)

### Severity Classification

| Severity | Description | Response Time |
|----------|-------------|---------------|
| **Critical** | Remote code execution, memory corruption | 7 days |
| **High** | Privilege escalation, data loss | 30 days |
| **Medium** | Information disclosure, DoS | 60 days |
| **Low** | Minor issues, best practice violations | 90 days |

## 🔐 Security Updates

### Update Policy

- **Critical**: Immediate patch release (0.x.y+1)
- **High**: Next patch release (within 30 days)
- **Medium**: Next minor release (within 90 days)
- **Low**: Bundled in next release

### Security Advisories

Security advisories are published at:
- **GitHub**: [Security Advisories](https://github.com/Hyperpolymath/airborne-submarine-squadron/security/advisories)
- **Mailing List**: security-announce@example.com (update with real list)
- **RSS Feed**: `.well-known/security.txt` (RFC 9116)

### Supported Versions

| Version | Supported | End of Life |
|---------|-----------|-------------|
| 0.3.x   | ✅ Yes    | TBD         |
| 0.2.x   | ✅ Yes    | 2026-01-01  |
| 0.1.x   | ❌ No     | 2025-06-01  |

## 🔍 Security Audits

### Self-Audits

- **SPARK Verification**: Continuous (every commit)
- **Static Analysis**: AdaControl rules (custom + standard)
- **Dependency Scanning**: Nix vulnerability database
- **Code Review**: All PRs reviewed by 2+ maintainers

### External Audits

We welcome external security audits! If you're conducting research:

1. **Notify us first**: security@example.com (to avoid duplicate work)
2. **Follow responsible disclosure**: See reporting guidelines above
3. **Respect scope**: This is an offline single-player game (no network attacks)
4. **Credit**: You'll be credited in CHANGELOG and humans.txt

### Audit History

- **2025-01-15**: Initial SPARK verification (100% coverage)
- *(Future audits will be listed here)*

## 🚨 Known Issues

We maintain transparency about known security issues:

### Current Issues

*None currently*

### Historical Issues

*(Security issues will be documented here after remediation)*

## 🛠️ Security Tools

### Automated Scanning

```bash
# Run SPARK verification
just verify

# Run AdaControl static analysis
just lint

# Check dependencies (Nix)
just audit-deps

# Full security scan
just security-scan
```

### Manual Review

```bash
# Search for unsafe operations (should return zero results)
just find-unsafe

# Check for TODO/FIXME security notes
just find-security-todos

# Review recent commits for security implications
just security-review
```

## 🔒 Cryptographic Signing

### Release Verification

All releases are signed with GPG:

```bash
# Import maintainer keys
gpg --recv-keys 0x1234567890ABCDEF

# Verify release signature
gpg --verify airborne-submarine-squadron-0.3.0.tar.gz.sig

# Verify Git tag
git tag -v v0.3.0
```

### Key Fingerprints

- **Lead Maintainer**: `1234 5678 90AB CDEF 1234 5678 90AB CDEF 1234 5678`
- *(Additional keys listed in MAINTAINERS.md)*

## 📜 Security Disclosure Policy

### Coordinated Disclosure

We follow a **90-day coordinated disclosure** timeline:

1. **Day 0**: Vulnerability reported privately
2. **Day 7**: Assessment complete, severity assigned
3. **Day 30**: Fix developed and tested (for critical/high)
4. **Day 60**: Fix released in patched version
5. **Day 90**: Public security advisory published

### Public Disclosure

After 90 days (or earlier if mutually agreed), we publish:

- **Advisory ID**: ASS-YYYY-NNNN (e.g., ASS-2025-0001)
- **CVE ID**: (if applicable)
- **Affected Versions**: Specific version ranges
- **Fix Version**: Version containing remediation
- **Credit**: Reporter attribution (unless anonymous)
- **Technical Details**: Full vulnerability description

### Embargo Policy

We will honor embargo periods up to **90 days** for:
- Coordinated multi-vendor disclosures
- Academic research publication timelines
- Regulatory compliance requirements

## 🎖️ Security Hall of Fame

We recognize security researchers who help improve our security:

*(Researchers will be listed here after successful responsible disclosure)*

## 📚 Security Resources

### Documentation

- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)**: Security architecture details
- **[API.md](docs/API.md)**: API security contracts and preconditions
- **[SPARK Proofs](docs/SPARK.md)**: Formal verification methodology

### Standards & Frameworks

- **RSR Framework**: [rhodium.sh](https://rhodium.sh)
- **OWASP**: Not directly applicable (offline game, no web components)
- **CWE**: Common Weakness Enumeration (for classification)
- **CVSS**: Common Vulnerability Scoring System (for severity)

### External Resources

- **GNAT Security**: [AdaCore Security Center](https://www.adacore.com/security)
- **SPARK**: [SPARK Formal Verification](https://www.adacore.com/sparkpro)
- **Nix Security**: [NixOS Security](https://nixos.org/security)

## 🔗 Security Contacts

- **Security Team Email**: security@example.com
- **GPG Key**: [0x1234567890ABCDEF](https://keys.openpgp.org/)
- **Security Advisories**: [GitHub Security](https://github.com/Hyperpolymath/airborne-submarine-squadron/security)
- **Bug Bounty**: Not currently available

---

**Last Updated**: 2025-01-22
**Version**: 1.0
**Maintainer**: Security Team

