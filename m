Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364A8CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723E310E51F;
	Tue, 29 Sep 2026 21:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BHEVbImS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481C710E1F9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:42:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D6EE41972;
 Tue, 29 Sep 2026 21:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C711F000FF;
 Tue, 29 Sep 2026 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1790718134;
 bh=K/yzJ7VDqnpk00dHp+/jme7+Nhb5NqHs2BdV51dsIto=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BHEVbImSwMlHW1eNgK3t3SsQ3XyHFWRMuiU6tJzI6GKfJNrpx2sUkJplC2CpTynEA
 vei1Bv9F3/oyYxQ7QcUAYeX84gdU6LAZIj/W1xW3TWfyMTedtfsAknxpORObE1sFMR
 fP7dd/QNEMbiej2DstsDMf0PKzvhlaKPV1+drl1o=
Date: Tue, 29 Sep 2026 14:42:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Mark Brown
 <broonie@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 6375e61c01e93e35ee7acd336a689ac1fae4b509
Message-Id: <20260929144213.94ba64f93121887c2a599d9f@linux-foundation.org>
In-Reply-To: <202609300341.XNENLUI0-lkp@intel.com>
References: <202609300341.XNENLUI0-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 30 Sep 2026 03:09:45 +0800 kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 6375e61c01e93e35ee7acd336a689ac1fae4b509  Add linux-next specific files for 20260928
> 
> Error/Warning (recently discovered and may have been fixed):
> 
>     https://lore.kernel.org/oe-kbuild-all/202609290155.PQiaOalK-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild-all/202609290349.4ad3d90o-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild-all/202609290408.BOs7sk55-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild-all/202609291109.9RGna4XZ-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild-all/202609291109.OIsGTysr-lkp@intel.com
> 
>     Documentation/filesystems/api-summary:20: ./fs/dcache.c:2010: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
>     arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dtb: clock-controller@100000 (qcom,gcc-sdm670): 'power-domains' is a required property
>     arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb: clock-controller@100000 (qcom,gcc-sdm670): 'power-domains' is a required property
>     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:11: error: call to undeclared function 'devm_drm_of_get_bridge'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:16: error: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:18: error: implicit declaration of function 'devm_drm_of_get_bridge'; did you mean 'devm_drm_put_bridge'? [-Wimplicit-function-declaration]
>     drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c:336:9: error: incompatible integer to pointer conversion assigning to 'struct drm_bridge *' from 'int' [-Wint-conversion]
>     drivers/gpu/drm/verisilicon/vs_bridge.c:306:14: error: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>     drivers/gpu/drm/verisilicon/vs_bridge.c:306:16: error: implicit declaration of function 'devm_drm_of_get_bridge'; did you mean 'devm_drm_put_bridge'? [-Wimplicit-function-declaration]
>     drivers/gpu/drm/verisilicon/vs_bridge.c:306:7: error: incompatible integer to pointer conversion assigning to 'struct drm_bridge *' from 'int' [-Wint-conversion]
>     drivers/gpu/drm/verisilicon/vs_bridge.c:306:9: error: call to undeclared function 'devm_drm_of_get_bridge'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

(cc dri-devel for the above)

> Unverified Error/Warning (likely false positive, kindly check if interested):
> 
>     drivers/gpu/drm/xe/xe_guc_pc.c:1400:17: sparse: sparse: Trying to use reserved word 'break' as identifier
>     drivers/gpu/drm/xe/xe_guc_pc.c:1400:17: sparse: sparse: Trying to use reserved word 'switch' as identifier

I can't find any code in there which could cause this.  Using the correct HEAD.

> Error/Warning ids grouped by kconfigs
> 
> recent_errors
> |-- arm64-randconfig-2404-20260927
> |   |-- arch-arm64-boot-dts-qcom-sdm670-google-bonito-tianma.dtb:clock-controller-(qcom-gcc-sdm670):power-domains-is-a-required-property
> |   `-- arch-arm64-boot-dts-qcom-sdm670-google-sargo.dtb:clock-controller-(qcom-gcc-sdm670):power-domains-is-a-required-property
> |-- arm64-randconfig-r2306-20260929
> |   |-- drivers-gpu-drm-xe-xe_guc_pc.c:sparse:sparse:Trying-to-use-reserved-word-break-as-identifier
> |   `-- drivers-gpu-drm-xe-xe_guc_pc.c:sparse:sparse:Trying-to-use-reserved-word-switch-as-identifier
> |-- i386-buildonly-randconfig-1001-20260929
> |   |-- drivers-gpu-drm-bridge-synopsys-dw-mipi-dsi.c:error:assignment-to-struct-drm_bridge-from-int-makes-pointer-from-integer-without-a-cast
> |   `-- drivers-gpu-drm-bridge-synopsys-dw-mipi-dsi.c:error:implicit-declaration-of-function-devm_drm_of_get_bridge
> |-- i386-buildonly-randconfig-1005-20260929
> |   |-- drivers-gpu-drm-bridge-synopsys-dw-mipi-dsi.c:error:call-to-undeclared-function-devm_drm_of_get_bridge-ISO-C99-and-later-do-not-support-implicit-function-declarations
> |   |-- drivers-gpu-drm-bridge-synopsys-dw-mipi-dsi.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-drm_bridge-from-int
> |   |-- drivers-gpu-drm-verisilicon-vs_bridge.c:error:call-to-undeclared-function-devm_drm_of_get_bridge-ISO-C99-and-later-do-not-support-implicit-function-declarations
> |   `-- drivers-gpu-drm-verisilicon-vs_bridge.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-drm_bridge-from-int
> |-- parisc-randconfig-r2200-20260929
> |   |-- drivers-gpu-drm-verisilicon-vs_bridge.c:error:assignment-to-struct-drm_bridge-from-int-makes-pointer-from-integer-without-a-cast
> |   `-- drivers-gpu-drm-verisilicon-vs_bridge.c:error:implicit-declaration-of-function-devm_drm_of_get_bridge
> `-- x86_64-allnoconfig
>     `-- Documentation-filesystems-api-summary:.-fs-dcache.c:WARNING:Block-quote-ends-without-a-blank-line-unexpected-unindent.-docutils
> 
> elapsed time: 976m
> 
> configs tested: 343
> configs skipped: 11
> 
> tested configs:
> alpha                              allnoconfig    gcc-16.1.0
> alpha                             allyesconfig    gcc-16.1.0
> alpha                                defconfig    gcc-16.1.0
> arc                               allmodconfig    clang-24
> arc                               allmodconfig    gcc-16.1.0
> arc                                allnoconfig    gcc-16.1.0
> arc                               allyesconfig    clang-24
> arc                               allyesconfig    gcc-16.1.0
> arc                                  defconfig    gcc-16.1.0
> arc                   randconfig-1000-20260929    clang-17
> arc                   randconfig-1000-20260929    gcc-13.4.0
> arc                   randconfig-1000-20260930    gcc-11.5.0
> arc                   randconfig-1001-20260929    clang-17
> arc                   randconfig-1001-20260929    gcc-8.5.0
> arc                   randconfig-1001-20260930    gcc-11.5.0
> arc                  randconfig-r2106-20260928    gcc-16.1.0 cocci
> arc                  randconfig-r2201-20260929    gcc-10.5.0 smatch
> arc                  randconfig-r2309-20260929    gcc-9.5.0  sparse
> arc                     vdk_hs38_smp_defconfig    gcc-16.1.0
> arm                                allnoconfig    clang-17
> arm                                allnoconfig    gcc-16.1.0
> arm                               allyesconfig    clang-24
> arm                               allyesconfig    gcc-16.1.0
> arm                         clps711x_defconfig    gcc-16.1.0
> arm                                  defconfig    gcc-16.1.0
> arm                          lpc32xx_defconfig    clang-17
> arm                              mxs_defconfig    gcc-16.1.0
> arm                          orion5x_defconfig    gcc-16.1.0
> arm                   randconfig-1000-20260929    clang-17
> arm                   randconfig-1000-20260929    gcc-11.5.0
> arm                   randconfig-1000-20260930    gcc-11.5.0
> arm                   randconfig-1001-20260929    clang-17
> arm                   randconfig-1001-20260930    gcc-11.5.0
> arm                   randconfig-1002-20260929    clang-17
> arm                   randconfig-1002-20260929    clang-24
> arm                   randconfig-1002-20260930    gcc-11.5.0
> arm                   randconfig-1003-20260929    clang-17
> arm                   randconfig-1003-20260929    gcc-10.5.0
> arm                   randconfig-1003-20260930    gcc-11.5.0
> arm                  randconfig-r2106-20260929    gcc-10.5.0 cocci
> arm                  randconfig-r2303-20260928    gcc-16.1.0 sparse
> arm                         spear6xx_defconfig    clang-17
> arm64                             allmodconfig    clang-24
> arm64                              allnoconfig    gcc-16.1.0
> arm64                                defconfig    gcc-16.1.0
> arm64                 randconfig-1000-20260929    clang-24
> arm64                 randconfig-1001-20260929    clang-24
> arm64                 randconfig-1002-20260929    clang-24
> arm64                 randconfig-1003-20260929    clang-22
> arm64                 randconfig-1003-20260929    clang-24
> arm64                randconfig-r2306-20260928    gcc-14.3.0 sparse
> csky                              allmodconfig    gcc-16.1.0
> csky                               allnoconfig    gcc-16.1.0
> csky                                 defconfig    gcc-16.1.0
> csky                  randconfig-1000-20260929    clang-24
> csky                  randconfig-1000-20260929    gcc-16.1.0
> csky                  randconfig-1001-20260929    clang-24
> csky                  randconfig-1001-20260929    gcc-15.2.0
> csky                 randconfig-r2107-20260928    gcc-12.5.0 cocci
> hexagon                           allmodconfig    gcc-16.1.0
> hexagon                            allnoconfig    clang-24
> hexagon                            allnoconfig    gcc-16.1.0
> hexagon                              defconfig    gcc-16.1.0
> hexagon               randconfig-1000-20260929    gcc-8.5.0
> hexagon               randconfig-1001-20260929    gcc-8.5.0
> hexagon              randconfig-r2102-20260928    clang-22   cocci
> i386                               allnoconfig    gcc-14
> i386                               allnoconfig    gcc-16.1.0
> i386        buildonly-randconfig-1000-20260929    clang-22
> i386        buildonly-randconfig-1001-20260929    clang-22
> i386        buildonly-randconfig-1001-20260929    gcc-14
> i386        buildonly-randconfig-1002-20260929    clang-22
> i386        buildonly-randconfig-1002-20260929    gcc-14
> i386        buildonly-randconfig-1003-20260929    clang-22
> i386        buildonly-randconfig-1004-20260929    clang-22
> i386        buildonly-randconfig-1005-20260929    clang-22
> i386                                 defconfig    gcc-16.1.0
> i386                  randconfig-1000-20260929    clang-22
> i386                  randconfig-1000-20260929    gcc-13
> i386                  randconfig-1001-20260929    clang-22
> i386                  randconfig-1001-20260929    gcc-13
> i386                  randconfig-1002-20260929    gcc-13
> i386                  randconfig-1003-20260929    gcc-13
> i386                  randconfig-1003-20260929    gcc-14
> i386                  randconfig-1004-20260929    gcc-13
> i386                  randconfig-1004-20260929    gcc-14
> i386                  randconfig-1005-20260929    clang-22
> i386                  randconfig-1005-20260929    gcc-13
> i386                  randconfig-1006-20260929    clang-22
> i386                  randconfig-1006-20260929    gcc-13
> i386                  randconfig-1007-20260929    gcc-14
> i386                  randconfig-1008-20260929    gcc-14
> i386                  randconfig-1009-20260929    gcc-14
> i386                  randconfig-1010-20260929    gcc-14
> i386                  randconfig-1011-20260929    gcc-14
> i386                  randconfig-1012-20260929    gcc-14
> i386                  randconfig-1013-20260929    gcc-14
> i386                  randconfig-2100-20260928    clang-22   cocci
> i386                  randconfig-2100-20260929    gcc-13     cocci
> i386                  randconfig-2101-20260928    gcc-14     cocci
> i386                  randconfig-2101-20260929    clang-22   cocci
> i386                  randconfig-2102-20260928    gcc-12     cocci
> i386                  randconfig-2102-20260929    clang-22   cocci
> i386                  randconfig-2103-20260928    clang-22   cocci
> i386                  randconfig-2103-20260929    clang-22   cocci
> i386                  randconfig-2200-20260928    clang-22   smatch
> i386                  randconfig-2200-20260929    gcc-14     smatch
> i386                  randconfig-2300-20260928    gcc-14     sparse
> i386                  randconfig-2301-20260928    gcc-12     sparse
> i386                  randconfig-2302-20260928    clang-22   sparse
> i386                 randconfig-r2100-20260929    gcc-14     cocci
> i386                 randconfig-r2104-20260929    gcc-14     cocci
> i386                 randconfig-r2202-20260928    gcc-14     smatch
> loongarch                         allmodconfig    clang-19
> loongarch                         allmodconfig    clang-24
> loongarch                          allnoconfig    clang-20
> loongarch                          allnoconfig    gcc-16.1.0
> loongarch                            defconfig    clang-24
> loongarch                 loongson64_defconfig    clang-17
> loongarch             randconfig-1000-20260929    gcc-8.5.0
> loongarch             randconfig-1001-20260929    gcc-8.5.0
> m68k                              allmodconfig    gcc-16.1.0
> m68k                               allnoconfig    gcc-16.1.0
> m68k                              allyesconfig    clang-24
> m68k                              allyesconfig    gcc-16.1.0
> m68k                        bvme6000_defconfig    gcc-16.1.0
> m68k                                 defconfig    clang-24
> m68k                           hp300_defconfig    clang-17
> m68k                             q40_defconfig    clang-17
> m68k                 randconfig-r2201-20260928    gcc-12.5.0 smatch
> microblaze                         allnoconfig    gcc-16.1.0
> microblaze                        allyesconfig    gcc-16.1.0
> microblaze                           defconfig    clang-24
> microblaze           randconfig-r2103-20260928    gcc-13.4.0 cocci
> microblaze           randconfig-r2309-20260928    gcc-15.2.0 sparse
> mips                              allmodconfig    gcc-16.1.0
> mips                               allnoconfig    gcc-16.1.0
> mips                              allyesconfig    gcc-16.1.0
> mips                            ip30_defconfig    gcc-16.1.0
> mips                 randconfig-r2302-20260928    clang-24   sparse
> mips                 randconfig-r2306-20260929    gcc-15.2.0 sparse
> nios2                             allmodconfig    gcc-11.5.0
> nios2                              allnoconfig    clang-24
> nios2                              allnoconfig    gcc-11.5.0
> nios2                                defconfig    clang-24
> nios2                 randconfig-1000-20260929    gcc-8.5.0
> nios2                 randconfig-1001-20260929    gcc-8.5.0
> nios2                randconfig-r2304-20260928    gcc-8.5.0  sparse
> openrisc                          alldefconfig    gcc-16.1.0
> openrisc                          allmodconfig    gcc-16.1.0
> openrisc                           allnoconfig    clang-24
> openrisc                           allnoconfig    gcc-16.1.0
> openrisc                             defconfig    gcc-16.1.0
> openrisc             randconfig-r2104-20260928    gcc-16.1.0 cocci
> openrisc             randconfig-r2107-20260929    gcc-15.2.0 cocci
> parisc                            allmodconfig    gcc-16.1.0
> parisc                             allnoconfig    clang-24
> parisc                             allnoconfig    gcc-16.1.0
> parisc                            allyesconfig    clang-17
> parisc                               defconfig    gcc-16.1.0
> parisc                randconfig-1000-20260929    gcc-15.2.0
> parisc                randconfig-1000-20260929    gcc-8.5.0
> parisc                randconfig-1000-20260930    gcc-8.5.0
> parisc                randconfig-1001-20260929    gcc-13.4.0
> parisc                randconfig-1001-20260929    gcc-8.5.0
> parisc                randconfig-1001-20260930    gcc-8.5.0
> parisc               randconfig-r2200-20260928    gcc-8.5.0  smatch
> parisc               randconfig-r2200-20260929    gcc-14.3.0 smatch
> parisc               randconfig-r2300-20260928    gcc-16.1.0 sparse
> parisc64                             defconfig    clang-24
> powerpc                           allmodconfig    gcc-16.1.0
> powerpc                            allnoconfig    clang-24
> powerpc                            allnoconfig    gcc-16.1.0
> powerpc                     gamecube_defconfig    gcc-16.1.0
> powerpc                      ksi8560_defconfig    gcc-16.1.0
> powerpc                    motionpro_defconfig    gcc-16.1.0
> powerpc                  mpc837x_rdb_defconfig    gcc-16.1.0
> powerpc               randconfig-1000-20260929    clang-17
> powerpc               randconfig-1000-20260929    gcc-8.5.0
> powerpc               randconfig-1000-20260930    gcc-8.5.0
> powerpc               randconfig-1001-20260929    gcc-14.3.0
> powerpc               randconfig-1001-20260929    gcc-8.5.0
> powerpc               randconfig-1001-20260930    gcc-8.5.0
> powerpc              randconfig-r2307-20260928    clang-24   sparse
> powerpc              randconfig-r2308-20260929    clang-24   sparse
> powerpc                      redwood_defconfig    clang-17
> powerpc64             randconfig-1000-20260929    gcc-8.5.0
> powerpc64             randconfig-1000-20260930    gcc-8.5.0
> powerpc64             randconfig-1001-20260929    gcc-12.5.0
> powerpc64             randconfig-1001-20260929    gcc-8.5.0
> powerpc64             randconfig-1001-20260930    gcc-8.5.0
> powerpc64            randconfig-r2101-20260929    gcc-10.5.0 cocci
> powerpc64            randconfig-r2103-20260929    gcc-13.4.0 cocci
> powerpc64            randconfig-r2105-20260928    clang-17   cocci
> powerpc64            randconfig-r2305-20260928    gcc-8.5.0  sparse
> powerpc64            randconfig-r2307-20260929    clang-24   sparse
> riscv                             allmodconfig    clang-24
> riscv                              allnoconfig    clang-24
> riscv                              allnoconfig    gcc-16.1.0
> riscv                             allyesconfig    clang-24
> riscv                                defconfig    clang-24
> riscv                                defconfig    gcc-16.1.0
> riscv                 randconfig-1000-20260929    clang-24
> riscv                 randconfig-1001-20260929    clang-24
> riscv                 randconfig-2000-20260928    gcc-8.5.0
> riscv                 randconfig-2000-20260929    gcc-11.5.0
> riscv                 randconfig-2001-20260928    gcc-8.5.0
> riscv                 randconfig-2001-20260929    gcc-9.5.0
> s390                              allmodconfig    clang-17
> s390                               allnoconfig    clang-24
> s390                              allyesconfig    gcc-16.1.0
> s390                                 defconfig    clang-18
> s390                                 defconfig    gcc-16.1.0
> s390                  randconfig-1000-20260929    clang-24
> s390                  randconfig-1001-20260929    clang-24
> s390                  randconfig-2000-20260928    clang-22
> s390                  randconfig-2000-20260929    clang-24
> s390                  randconfig-2001-20260928    gcc-16.1.0
> s390                  randconfig-2001-20260929    gcc-8.5.0
> s390                 randconfig-r2105-20260929    gcc-13.4.0 cocci
> sh                                allmodconfig    gcc-16.1.0
> sh                                 allnoconfig    clang-24
> sh                                 allnoconfig    gcc-16.1.0
> sh                                allyesconfig    clang-17
> sh                                   defconfig    gcc-14
> sh                                   defconfig    gcc-16.1.0
> sh                         dreamcast_defconfig    clang-17
> sh                           kfr2r09_defconfig    gcc-16.1.0
> sh                    randconfig-1000-20260929    clang-24
> sh                    randconfig-1001-20260929    clang-24
> sh                    randconfig-2000-20260928    gcc-15.2.0
> sh                    randconfig-2000-20260929    gcc-14.3.0
> sh                    randconfig-2001-20260928    gcc-13.4.0
> sh                    randconfig-2001-20260929    gcc-16.1.0
> sh                   randconfig-r2202-20260929    gcc-16.1.0 smatch
> sh                            se7721_defconfig    gcc-16.1.0
> sh                            se7722_defconfig    gcc-16.1.0
> sh                    secureedge5410_defconfig    gcc-16.1.0
> sh                              shx3_defconfig    gcc-16.1.0
> sparc                              allnoconfig    clang-24
> sparc                              allnoconfig    gcc-16.1.0
> sparc                                defconfig    gcc-16.1.0
> sparc                 randconfig-1000-20260929    gcc-14
> sparc                 randconfig-1001-20260929    gcc-14
> sparc                 randconfig-2000-20260928    gcc-15.2.0
> sparc                 randconfig-2000-20260929    gcc-14.3.0
> sparc                 randconfig-2001-20260928    gcc-13.4.0
> sparc                 randconfig-2001-20260929    gcc-12.5.0
> sparc                randconfig-r2100-20260928    gcc-11.5.0 cocci
> sparc64                           allmodconfig    clang-20
> sparc64                              defconfig    clang-24
> sparc64                              defconfig    gcc-14
> sparc64               randconfig-1000-20260929    gcc-14
> sparc64               randconfig-1001-20260929    gcc-14
> sparc64               randconfig-2000-20260928    clang-20
> sparc64               randconfig-2000-20260929    gcc-8.5.0
> sparc64               randconfig-2001-20260928    clang-24
> sparc64               randconfig-2001-20260929    clang-24
> sparc64              randconfig-r2308-20260928    gcc-8.5.0  sparse
> um                                allmodconfig    clang-17
> um                                 allnoconfig    clang-17
> um                                 allnoconfig    clang-24
> um                                allyesconfig    gcc-16.1.0
> um                                   defconfig    clang-24
> um                                   defconfig    gcc-14
> um                              i386_defconfig    gcc-14
> um                    randconfig-1000-20260929    gcc-14
> um                    randconfig-1001-20260929    gcc-14
> um                    randconfig-2000-20260928    gcc-14
> um                    randconfig-2000-20260929    clang-17
> um                    randconfig-2001-20260928    gcc-14
> um                    randconfig-2001-20260929    gcc-14
> um                            x86_64_defconfig    clang-17
> um                            x86_64_defconfig    clang-24
> um                            x86_64_defconfig    gcc-14
> x86_64                             allnoconfig    clang-22
> x86_64                             allnoconfig    clang-24
> x86_64      buildonly-randconfig-1000-20260929    clang-22
> x86_64      buildonly-randconfig-1001-20260929    clang-22
> x86_64      buildonly-randconfig-1002-20260929    clang-22
> x86_64      buildonly-randconfig-1002-20260929    gcc-14
> x86_64      buildonly-randconfig-1003-20260929    clang-22
> x86_64      buildonly-randconfig-1003-20260929    gcc-14
> x86_64      buildonly-randconfig-1004-20260929    clang-22
> x86_64      buildonly-randconfig-1005-20260929    clang-22
> x86_64                               defconfig    gcc-14
> x86_64                                   kexec    clang-22
> x86_64                randconfig-1000-20260929    clang-22
> x86_64                randconfig-1000-20260929    gcc-13
> x86_64                randconfig-1001-20260929    clang-22
> x86_64                randconfig-1002-20260929    clang-22
> x86_64                randconfig-1002-20260929    gcc-14
> x86_64                randconfig-1003-20260929    clang-22
> x86_64                randconfig-1004-20260929    clang-22
> x86_64                randconfig-1005-20260929    clang-22
> x86_64                randconfig-1006-20260929    gcc-13
> x86_64                randconfig-1007-20260929    gcc-13
> x86_64                randconfig-1008-20260929    gcc-13
> x86_64                randconfig-1009-20260929    gcc-13
> x86_64                randconfig-1010-20260929    gcc-13
> x86_64                randconfig-1011-20260929    gcc-13
> x86_64                randconfig-1012-20260929    clang-22
> x86_64                randconfig-1013-20260929    clang-22
> x86_64                randconfig-1014-20260929    clang-22
> x86_64                randconfig-1015-20260929    clang-22
> x86_64                randconfig-1016-20260929    clang-22
> x86_64                randconfig-1017-20260929    clang-22
> x86_64                randconfig-2100-20260928    gcc-14     cocci
> x86_64                randconfig-2100-20260929    clang-22   cocci
> x86_64                randconfig-2101-20260928    clang-22   cocci
> x86_64                randconfig-2101-20260929    gcc-14     cocci
> x86_64                randconfig-2102-20260928    gcc-14     cocci
> x86_64                randconfig-2102-20260929    gcc-14     cocci
> x86_64                randconfig-2103-20260928    gcc-12     cocci
> x86_64                randconfig-2103-20260929    clang-22   cocci
> x86_64                randconfig-2200-20260928    gcc-14     smatch
> x86_64                randconfig-2200-20260929    clang-22   smatch
> x86_64                randconfig-2300-20260928    gcc-14     sparse
> x86_64                randconfig-2301-20260928    gcc-14     sparse
> x86_64                randconfig-2302-20260928    clang-22   sparse
> x86_64               randconfig-r2102-20260929    clang-22   cocci
> x86_64               randconfig-r2301-20260928    clang-22   sparse
> x86_64                                rhel-9.4    clang-22
> x86_64                                rhel-9.4    gcc-14
> x86_64                            rhel-9.4-bpf    gcc-14
> x86_64                           rhel-9.4-func    clang-22
> x86_64                           rhel-9.4-func    gcc-14
> x86_64                     rhel-9.4-kselftests    clang-22
> x86_64                     rhel-9.4-kselftests    gcc-14
> x86_64                          rhel-9.4-kunit    gcc-14
> x86_64                            rhel-9.4-ltp    gcc-14
> x86_64                           rhel-9.4-rust    clang-22
> x86_64                           rhel-9.4-rust    clang-22
> xtensa                             allnoconfig    clang-24
> xtensa                             allnoconfig    gcc-16.1.0
> xtensa                            allyesconfig    gcc-16.1.0
> xtensa                randconfig-1000-20260929    gcc-14
> xtensa                randconfig-1001-20260929    gcc-14
> xtensa                randconfig-2000-20260928    gcc-13.4.0
> xtensa                randconfig-2000-20260929    gcc-16.1.0
> xtensa                randconfig-2001-20260928    gcc-11.5.0
> xtensa                randconfig-2001-20260929    gcc-10.5.0
> xtensa               randconfig-r2101-20260928    gcc-14.3.0 cocci
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
