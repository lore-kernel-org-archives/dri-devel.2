Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0AACD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DBF10E904;
	Wed, 17 Jun 2026 03:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JwqV24rS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BFE10E904
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781666138; x=1813202138;
 h=date:from:to:cc:subject:message-id;
 bh=+cjkUbTer5PQ4dLTvg05cU85pEOLstvgJpESME0kM7U=;
 b=JwqV24rSIpMICJmep7Z6dXNVi4C/i7I2ZSh/yxgtbjQgwnCGOZ055gEJ
 EeyH/565wGnKWVSuYid26aM+svaLNwt1X8CREMA8DokKN7lVGbdi5jJ5J
 dnBiMg1xCaG9I95NukR3LUwweexA6Agy/XxmIeV4dLXHH84oORt09sMJK
 VopVXYF8QEBm+r8eCdIa7dfNvoW1CXdvnKDYpxztBdHvSBfg22ZnPHz2S
 yztZeezPuey2XW/B1jp8TeEY+QhLy0tV23pBRiZ+TiG5xal4t9JwOtzX5
 QgkcnHD41HlobQMzKU3w1gxRVPVDFbK+ncprk3tpe+Z8ht7IpvkUgyD2w A==;
X-CSE-ConnectionGUID: 0Kms5lY9SOKUglJPEz3amw==
X-CSE-MsgGUID: IixCa5SJSA6d1+lAuNEQtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="107913883"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="107913883"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 20:15:38 -0700
X-CSE-ConnectionGUID: zZIfroVrTD25aN6mI1SW8Q==
X-CSE-MsgGUID: Zfpuw+j0RQ2mvr29Q/wplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="248017026"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 16 Jun 2026 20:15:36 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wZgkX-00000000U3a-0OU7;
 Wed, 17 Jun 2026 03:15:33 +0000
Date: Wed, 17 Jun 2026 11:14:42 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Subject: [linux-next:master] BUILD REGRESSION
 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
Message-ID: <202606171129.j9nQcOHz-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9  Add linux-next specific files for 20260616

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202606170744.FUStcWaB-lkp@intel.com

    (.text+0x494): undefined reference to `__udivdi3'

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/usb/cdns3/cdnsp-gadget.c:168:16: sparse: sparse: incorrect type in argument 1 (different base types)

Error/Warning ids grouped by kconfigs:

recent_errors
|-- microblaze-randconfig-r054-20260617
|   `-- (.text):undefined-reference-to-__udivdi3
|-- sparc64-randconfig-r133-20260617
|   `-- drivers-gpu-drm-bridge-of-display-mode-bridge.c:sparse:sparse:symbol-of_display_mode_bridge_funcs-was-not-declared.-Should-it-be-static
`-- x86_64-randconfig-122-20260616
    `-- drivers-usb-cdns3-cdnsp-gadget.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-val-got-restricted-__le32-usertype

elapsed time: 722m

configs tested: 287
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260616    gcc-9.5.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-002-20260616    gcc-8.5.0
arc                   randconfig-002-20260617    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260616    gcc-15.2.0
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-002-20260616    clang-23
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-003-20260616    gcc-8.5.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-004-20260616    clang-20
arm                   randconfig-004-20260617    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260617    clang-23
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                 randconfig-002-20260617    gcc-10.5.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                 randconfig-003-20260617    clang-17
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                 randconfig-004-20260617    gcc-12.5.0
arm64                 randconfig-004-20260617    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260617    gcc-10.5.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                  randconfig-002-20260617    gcc-12.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260616    clang-23
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-002-20260616    clang-23
hexagon               randconfig-002-20260617    clang-17
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260617    clang-22
i386        buildonly-randconfig-001-20260617    gcc-14
i386        buildonly-randconfig-002-20260617    gcc-14
i386        buildonly-randconfig-003-20260617    gcc-13
i386        buildonly-randconfig-003-20260617    gcc-14
i386        buildonly-randconfig-004-20260617    clang-22
i386        buildonly-randconfig-004-20260617    gcc-14
i386        buildonly-randconfig-005-20260617    gcc-14
i386        buildonly-randconfig-006-20260617    clang-22
i386        buildonly-randconfig-006-20260617    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260616    clang-22
i386                  randconfig-001-20260617    gcc-13
i386                  randconfig-002-20260616    gcc-14
i386                  randconfig-002-20260617    gcc-13
i386                  randconfig-003-20260616    clang-22
i386                  randconfig-003-20260617    gcc-13
i386                  randconfig-004-20260616    gcc-14
i386                  randconfig-004-20260617    gcc-13
i386                  randconfig-005-20260616    gcc-14
i386                  randconfig-005-20260617    gcc-13
i386                  randconfig-006-20260616    clang-22
i386                  randconfig-006-20260617    gcc-13
i386                  randconfig-007-20260616    gcc-14
i386                  randconfig-007-20260617    gcc-13
i386                  randconfig-011-20260617    clang-22
i386                  randconfig-011-20260617    gcc-12
i386                  randconfig-012-20260617    clang-22
i386                  randconfig-012-20260617    gcc-14
i386                  randconfig-013-20260617    clang-22
i386                  randconfig-013-20260617    gcc-14
i386                  randconfig-014-20260617    clang-22
i386                  randconfig-014-20260617    gcc-14
i386                  randconfig-015-20260617    clang-22
i386                  randconfig-015-20260617    gcc-14
i386                  randconfig-016-20260617    clang-22
i386                  randconfig-016-20260617    gcc-14
i386                  randconfig-017-20260617    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260616    gcc-13.4.0
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-002-20260616    clang-18
loongarch             randconfig-002-20260617    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
m68k                          hp300_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260616    gcc-9.5.0
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-002-20260616    gcc-8.5.0
nios2                 randconfig-002-20260617    clang-17
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260617    gcc-13.4.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260617    gcc-14.3.0
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc               randconfig-002-20260617    clang-17
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260617    gcc-8.5.0
powerpc64             randconfig-002-20260617    gcc-10.5.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260617    clang-17
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-002-20260617    clang-23
riscv                 randconfig-002-20260617    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-9.5.0
s390                  randconfig-002-20260617    clang-23
s390                  randconfig-002-20260617    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-12.5.0
sh                    randconfig-002-20260617    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260616    gcc-16.1.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                 randconfig-002-20260616    gcc-8.5.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260616    gcc-8.5.0
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64               randconfig-002-20260616    gcc-8.5.0
sparc64               randconfig-002-20260617    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260616    gcc-14
um                    randconfig-001-20260617    gcc-16.1.0
um                    randconfig-002-20260616    gcc-12
um                    randconfig-002-20260617    gcc-16.1.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260616    gcc-14
x86_64                randconfig-011-20260617    clang-22
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260616    gcc-14
x86_64                randconfig-012-20260617    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260616    clang-22
x86_64                randconfig-013-20260617    clang-22
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260616    clang-22
x86_64                randconfig-014-20260617    clang-22
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260616    clang-22
x86_64                randconfig-015-20260617    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260616    gcc-14
x86_64                randconfig-016-20260617    clang-22
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260616    gcc-14
x86_64                randconfig-071-20260617    clang-22
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260616    clang-22
x86_64                randconfig-072-20260617    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260616    gcc-14
x86_64                randconfig-073-20260617    clang-22
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260616    gcc-14
x86_64                randconfig-074-20260617    clang-22
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260616    gcc-12
x86_64                randconfig-075-20260617    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260616    gcc-14
x86_64                randconfig-076-20260617    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260616    gcc-14.3.0
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                randconfig-002-20260616    gcc-8.5.0
xtensa                randconfig-002-20260617    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
