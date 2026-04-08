Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12691073C9E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 11:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC6910E61B;
	Wed,  8 Apr 2026 11:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zqrneg0l";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BA610E619
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775648396; x=1807184396;
 h=date:from:to:cc:subject:message-id;
 bh=b+RecTKEamqmyLaTPX3iCg4q4fZ77CppkFB3CIgG9qw=;
 b=Zqrneg0lWazIJJJzXEW3bqel7s7AUcCChGf6RbHfR3xETNY3mbp6S8zj
 QSZkrKMC7PwBbVcw7y2DxHZKtHkeqJwRdMMxg7C8Zy5iurY2AUSeEzkku
 YyrMiGf6g7BT5KjdO5ZT437XV1jple+6YWueRxgk5VY5cEgvc2ScEq6Hd
 UWQWHWu5KpivIGOXxHm1nco1l5/RnWa4z64uQsPzToPmH/KkLMUeWb7bl
 lniwCURxfCGDWCs5DO5ZIKL2Q7XRQdmBl259c2hczCHvIufLLRK4L3wez
 xekXS0m7O/ubxPNWdCAPeMj7G+lRRAa1/kPVLHbZQeEUKVd1grN8kxpe+ w==;
X-CSE-ConnectionGUID: 6tSCo81rR7OAwSV0EaQdkQ==
X-CSE-MsgGUID: EoGoxx//TS+jCmjIbAx6wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76520517"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76520517"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 04:39:55 -0700
X-CSE-ConnectionGUID: UIJ01+qERzqtIMNMCKd7Iw==
X-CSE-MsgGUID: XpxJCpgGTrGUlTeN6AHcuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="223684346"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 08 Apr 2026 04:39:53 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wARGA-000000001nN-3hUZ;
 Wed, 08 Apr 2026 11:39:50 +0000
Date: Wed, 08 Apr 2026 19:39:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>
Subject: [daeinki-drm-exynos:exynos-drm-next 3/4]
 drivers/gpu/drm/exynos/exynos_drm_gem.c:70:41: warning: format specifies type
 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int')
Message-ID: <202604081946.qVUp1v71-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
head:   0867757f1eec0a246c70b2407a1bbed949170821
commit: 11e898373fba6b1d27b15ab4beff592701a57293 [3/4] drm/exynos: Drop exynos_drm_gem.size field
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260408/202604081946.qVUp1v71-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081946.qVUp1v71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081946.qVUp1v71-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/exynos/exynos_drm_gem.c:70:41: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
      69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
         |                                                                          ~~~
         |                                                                          %zx
      70 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
         |                                                              ^~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:599:38: note: expanded from macro 'DRM_DEV_DEBUG_KMS'
     599 |         drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
         |                                      ~~~    ^~~~~~~~~~~
   include/drm/drm_print.h:563:39: note: expanded from macro 'drm_dev_dbg'
     563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
         |                                       ~~~    ^~~~~~~~~~~
   drivers/gpu/drm/exynos/exynos_drm_gem.c:84:41: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
      83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
         |                                                              ~~~
         |                                                              %zx
      84 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
         |                                                              ^~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:599:38: note: expanded from macro 'DRM_DEV_DEBUG_KMS'
     599 |         drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
         |                                      ~~~    ^~~~~~~~~~~
   include/drm/drm_print.h:563:39: note: expanded from macro 'drm_dev_dbg'
     563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
         |                                       ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +70 drivers/gpu/drm/exynos/exynos_drm_gem.c

    26	
    27	static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
    28	{
    29		struct drm_device *dev = exynos_gem->base.dev;
    30		unsigned long attr = 0;
    31	
    32		if (exynos_gem->dma_addr) {
    33			DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "already allocated.\n");
    34			return 0;
    35		}
    36	
    37		/*
    38		 * if EXYNOS_BO_CONTIG, fully physically contiguous memory
    39		 * region will be allocated else physically contiguous
    40		 * as possible.
    41		 */
    42		if (!(exynos_gem->flags & EXYNOS_BO_NONCONTIG))
    43			attr |= DMA_ATTR_FORCE_CONTIGUOUS;
    44	
    45		/*
    46		 * if EXYNOS_BO_WC or EXYNOS_BO_NONCACHABLE, writecombine mapping
    47		 * else cachable mapping.
    48		 */
    49		if (exynos_gem->flags & EXYNOS_BO_WC ||
    50				!(exynos_gem->flags & EXYNOS_BO_CACHABLE))
    51			attr |= DMA_ATTR_WRITE_COMBINE;
    52	
    53		/* FBDev emulation requires kernel mapping */
    54		if (!kvmap)
    55			attr |= DMA_ATTR_NO_KERNEL_MAPPING;
    56	
    57		exynos_gem->dma_attrs = attr;
    58		exynos_gem->cookie = dma_alloc_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size,
    59						     &exynos_gem->dma_addr, GFP_KERNEL,
    60						     exynos_gem->dma_attrs);
    61		if (!exynos_gem->cookie) {
    62			DRM_DEV_ERROR(drm_dev_dma_dev(dev), "failed to allocate buffer.\n");
    63			return -ENOMEM;
    64		}
    65	
    66		if (kvmap)
    67			exynos_gem->kvaddr = exynos_gem->cookie;
    68	
    69		DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
  > 70				(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
    71		return 0;
    72	}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
