# Maintainers

This document lists the current maintainers of the Airborne Submarine Squadron project and describes the governance model.

## Current Maintainers

### Lead Maintainer

- **Name**: [To be assigned]
- **GitHub**: [@username](https://github.com/username)
- **Email**: lead@example.com
- **GPG**: `1234 5678 90AB CDEF 1234 5678 90AB CDEF 1234 5678`
- **Responsibilities**: Overall project direction, breaking changes, releases
- **Since**: 2025-01-22

### Core Maintainers

- **Name**: [To be assigned]
  - **GitHub**: [@username2](https://github.com/username2)
  - **Focus**: Game engine, physics
  - **Since**: 2025-01-22

- **Name**: [To be assigned]
  - **GitHub**: [@username3](https://github.com/username3)
  - **Focus**: SPARK verification, security
  - **Since**: 2025-01-22

### Emeritus Maintainers

*(Retired maintainers who contributed significantly)*

- None yet

## Governance Model

### TPCF Structure

This project uses **TPCF (Tri-Perimeter Contribution Framework)** with three contribution perimeters:

```
┌─────────────────────────────────────────┐
│   Perimeter 1: Trusted Core             │
│   - Maintainers                         │
│   - Direct commit access                │
│   - High trust                          │
│                                         │
│   ┌──────────────────────────────────┐  │
│   │ Perimeter 2: Contributor Circle  │  │
│   │ - Vetted contributors            │  │
│   │ - Streamlined review             │  │
│   │ - Elevated permissions           │  │
│   │                                  │  │
│   │  ┌────────────────────────────┐  │  │
│   │  │ Perimeter 3: Community     │  │  │
│   │  │ Sandbox                    │  │  │
│   │  │ - Public contributions     │  │  │
│   │  │ - Anyone can contribute    │  │  │
│   │  │ - Review required          │  │  │
│   │  └────────────────────────────┘  │  │
│   └──────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

**Current Perimeter**: Perimeter 3 (Community Sandbox)

### Decision-Making Process

#### Consensus Model

- **Default**: Decisions made by consensus among maintainers
- **Timeline**: 7-day comment period for major decisions
- **Lazy Consensus**: Silence = agreement after comment period

#### RFC Process (Breaking Changes)

For breaking changes or major features:

1. **Propose**: Create RFC (Request for Comments) issue
2. **Discuss**: 14-day public comment period
3. **Revise**: Incorporate feedback
4. **Vote**: Maintainers vote (2/3 majority required)
5. **Implement**: If approved, proceed with implementation

**RFC Template**: See [.github/ISSUE_TEMPLATE/rfc.md](.github/ISSUE_TEMPLATE/rfc.md)

#### Veto Rights

- **Lead Maintainer**: Can veto any decision (rarely used)
- **Security Team**: Can veto security-sensitive changes
- **Veto Process**: Must provide written rationale within 48 hours

### Roles and Responsibilities

#### All Maintainers

- Review pull requests
- Triage issues
- Respond to security reports
- Maintain code quality
- Uphold Code of Conduct
- Mentor contributors

#### Lead Maintainer

- Final decision on disputes
- Release management
- Maintainer appointments
- Project vision and roadmap
- External representation

#### Core Maintainers

- Area-specific expertise
- Architectural decisions in focus area
- Review complex changes
- Mentor new contributors

### Becoming a Maintainer

#### Path to Maintainer

1. **Contribute Regularly**: Demonstrate consistent, quality contributions
2. **Build Trust**: Show good judgment and community values
3. **Nomination**: Existing maintainer nominates you
4. **Discussion**: Maintainers discuss for 7 days
5. **Vote**: Unanimous approval required
6. **Onboarding**: Shadow existing maintainer for 1 month

#### Criteria

- ✅ **Technical Excellence**: High-quality code contributions
- ✅ **Community Values**: Upholds Code of Conduct
- ✅ **Communication**: Clear, respectful interaction
- ✅ **Reliability**: Consistent availability and follow-through
- ✅ **Judgment**: Sound decision-making
- ✅ **Mentorship**: Helps other contributors

#### Maintainer Agreement

New maintainers agree to:
- Dedicate time to project maintenance
- Respond to issues/PRs within 7 days
- Participate in governance discussions
- Uphold project values and CoC
- Disclose conflicts of interest

### Stepping Down

Maintainers may step down by:
1. **Notify**: Email other maintainers
2. **Transition**: 30-day handoff period (if possible)
3. **Emeritus Status**: Listed as emeritus maintainer
4. **Return**: Welcome to return at any time

### Removal

In rare cases, maintainers may be removed:

**Grounds**:
- Severe Code of Conduct violations
- Extended inactivity (6+ months, no response)
- Loss of trust (security breach, etc.)

**Process**:
1. **Private Discussion**: Attempt to resolve
2. **Vote**: 2/3 majority of remaining maintainers
3. **Notification**: Written explanation provided
4. **Appeal**: 14-day appeal window

## Permissions

### GitHub Access Levels

| Role | Access |
|------|--------|
| **Lead Maintainer** | Admin |
| **Core Maintainers** | Maintain |
| **Contributor Circle** | Triage |
| **Community** | Read |

### Responsibilities by Access

**Admin**:
- Manage repository settings
- Add/remove collaborators
- Manage releases
- Configure CI/CD

**Maintain**:
- Merge pull requests
- Push to protected branches
- Manage issues and PRs
- Create releases (with approval)

**Triage**:
- Label issues
- Close duplicate issues
- Request reviews
- Mark issues as spam

## Conflict Resolution

### Process

1. **Direct Resolution**: Parties discuss privately
2. **Mediation**: Neutral maintainer mediates
3. **Escalation**: Lead maintainer decides
4. **Last Resort**: CoC enforcement process

### Principles

- **Assume Good Faith**: Start from positive intent
- **Focus on Issues**: Not personalities
- **Seek Understanding**: Listen actively
- **Find Common Ground**: Win-win solutions preferred

## Communication

### Regular Meetings

- **Maintainer Sync**: Monthly (private)
- **Community Calls**: Quarterly (public)
- **Planning Sessions**: As needed

### Channels

- **Maintainer Chat**: `#maintainers:matrix.org` (private)
- **Public Discussions**: GitHub Discussions
- **Email**: maintainers@example.com

### Transparency

- **Public by Default**: Most discussions public
- **Private When Needed**: Security, CoC, personal matters
- **Meeting Minutes**: Published after maintainer syncs

## Maintainer Resources

### Onboarding Checklist

- [ ] Added to GitHub organization
- [ ] GPG key on file
- [ ] Access to maintainer chat
- [ ] Read all governance docs
- [ ] Shadowed experienced maintainer
- [ ] First PR review (mentored)
- [ ] Introduced to community

### Tools

- **GitHub**: Repository management
- **Matrix**: Real-time chat
- **GPG**: Commit and release signing
- **justfile**: Build automation
- **Nix**: Reproducible builds

### Best Practices

- **Review Promptly**: Within 7 days
- **Sign Commits**: GPG signature on all commits
- **Test Locally**: Verify changes before merging
- **Update Docs**: Keep documentation current
- **Communicate**: Explain decisions clearly

## Changes to Governance

This governance model may be updated:

1. **Propose**: RFC issue with changes
2. **Discuss**: 30-day comment period
3. **Vote**: Unanimous maintainer approval required
4. **Document**: Update MAINTAINERS.md

**Version History**:
- v1.0 (2025-01-22): Initial governance model

## Contact

- **General**: maintainers@example.com
- **Security**: security@example.com
- **Conduct**: conduct@example.com

---

**Serving the Community Since 2025**

