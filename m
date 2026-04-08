Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27999FD5F6E
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F6610E028;
	Wed,  8 Apr 2026 05:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ort4Dwwd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E40410E028
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775625295; x=1807161295;
 h=date:from:to:cc:subject:message-id;
 bh=o57cu5zIDmikxYZ4YIPbWaC5tzT1ix4Yf3Jpx91nq0g=;
 b=Ort4DwwdCD9S15NaEeAwq8+SM2yebkdIT/A3/K/FIeErqZ4QH/B5Twag
 VykhASfhOpKKKElLIUTJdml0lLNL2MaO4H/SbiGFJta/J3tmc8FqeFhzL
 b2AdF6w6rNh6EgM/xc1jLazBMt/6csSSZeyQOIIY30sCsaVJBgn9f7TBt
 kTxiRWuTpwACAMIdM1/qcjU91m3xcgNuoSer/LeAYmHF0+4Cm21RSZrTA
 t6Fnr8kFsqhR32CCV6WUCHG2R3PNMiZH5JehDLg2b9alT8xi5IPIT7Da2
 R1ZQo7Aghn2nE/HBxGo5AkIVrDUP71AGMKU97Neb/YT1QLKWTKyj/UjkV g==;
X-CSE-ConnectionGUID: ZYsRqE1JR+mqqtJvGd7g/w==
X-CSE-MsgGUID: B6bH70OWSsWRndpZg9saew==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75636473"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="75636473"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:14:55 -0700
X-CSE-ConnectionGUID: U2QnI/BRQXG1PDmwG5Rh5Q==
X-CSE-MsgGUID: 4ub5Qqq8RQqUuPY4BjUsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228263753"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
 by orviesa009.jf.intel.com with ESMTP; 07 Apr 2026 22:14:53 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wALFZ-000000001SH-44B9;
 Wed, 08 Apr 2026 05:14:49 +0000
Date: Wed, 08 Apr 2026 13:14:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Inki Dae <inki.dae@samsung.com>
Subject: [daeinki-drm-exynos:exynos-drm-next 3/4]
 drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: warning: format '%lx' expects
 argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka
 'unsigned int'}
Message-ID: <202604081331.jSJQSVmg-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260408/202604081331.jSJQSVmg-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081331.jSJQSVmg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081331.jSJQSVmg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
   drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_alloc_buf':
>> drivers/gpu/drm/exynos/exynos_drm_gem.c:69:49: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      70 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
         |                                                              ~~~~~~~~~~~~~~~~~~~~~
         |                                                                              |
         |                                                                              size_t {aka unsigned int}
   include/drm/drm_print.h:563:39: note: in definition of macro 'drm_dev_dbg'
     563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
         |                                       ^~~
   drivers/gpu/drm/exynos/exynos_drm_gem.c:69:9: note: in expansion of macro 'DRM_DEV_DEBUG_KMS'
      69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/exynos/exynos_drm_gem.c:69:76: note: format string is defined here
      69 |         DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
         |                                                                          ~~^
         |                                                                            |
         |                                                                            long unsigned int
         |                                                                          %x
   In file included from drivers/gpu/drm/exynos/exynos_drm_gem.c:16:
   drivers/gpu/drm/exynos/exynos_drm_gem.c: In function 'exynos_drm_free_buf':
   drivers/gpu/drm/exynos/exynos_drm_gem.c:83:37: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      84 |                         (unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
         |                                                              ~~~~~~~~~~~~~~~~~~~~~
         |                                                                              |
         |                                                                              size_t {aka unsigned int}
   include/drm/drm_print.h:563:39: note: in definition of macro 'drm_dev_dbg'
     563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
         |                                       ^~~
   drivers/gpu/drm/exynos/exynos_drm_gem.c:83:9: note: in expansion of macro 'DRM_DEV_DEBUG_KMS'
      83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/exynos/exynos_drm_gem.c:83:64: note: format string is defined here
      83 |         DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
         |                                                              ~~^
         |                                                                |
         |                                                                long unsigned int
         |                                                              %x


vim +69 drivers/gpu/drm/exynos/exynos_drm_gem.c

2043e6f6d5c5fb0 Thomas Zimmermann   2021-11-08  26  
9940d9d93406f41 Marek Szyprowski    2020-04-23  27  static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
2a8cb4894540898 Joonyoung Shim      2015-08-16  28  {
813fd67b57ffca0 Joonyoung Shim      2015-10-02  29  	struct drm_device *dev = exynos_gem->base.dev;
9940d9d93406f41 Marek Szyprowski    2020-04-23  30  	unsigned long attr = 0;
2a8cb4894540898 Joonyoung Shim      2015-08-16  31  
813fd67b57ffca0 Joonyoung Shim      2015-10-02  32  	if (exynos_gem->dma_addr) {
e457a1a9585b941 Chen-Yu Tsai        2026-03-26  33  		DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "already allocated.\n");
2a8cb4894540898 Joonyoung Shim      2015-08-16  34  		return 0;
2a8cb4894540898 Joonyoung Shim      2015-08-16  35  	}
2a8cb4894540898 Joonyoung Shim      2015-08-16  36  
2a8cb4894540898 Joonyoung Shim      2015-08-16  37  	/*
2a8cb4894540898 Joonyoung Shim      2015-08-16  38  	 * if EXYNOS_BO_CONTIG, fully physically contiguous memory
2a8cb4894540898 Joonyoung Shim      2015-08-16  39  	 * region will be allocated else physically contiguous
2a8cb4894540898 Joonyoung Shim      2015-08-16  40  	 * as possible.
2a8cb4894540898 Joonyoung Shim      2015-08-16  41  	 */
813fd67b57ffca0 Joonyoung Shim      2015-10-02  42  	if (!(exynos_gem->flags & EXYNOS_BO_NONCONTIG))
9940d9d93406f41 Marek Szyprowski    2020-04-23  43  		attr |= DMA_ATTR_FORCE_CONTIGUOUS;
2a8cb4894540898 Joonyoung Shim      2015-08-16  44  
2a8cb4894540898 Joonyoung Shim      2015-08-16  45  	/*
2a8cb4894540898 Joonyoung Shim      2015-08-16  46  	 * if EXYNOS_BO_WC or EXYNOS_BO_NONCACHABLE, writecombine mapping
2a8cb4894540898 Joonyoung Shim      2015-08-16  47  	 * else cachable mapping.
2a8cb4894540898 Joonyoung Shim      2015-08-16  48  	 */
813fd67b57ffca0 Joonyoung Shim      2015-10-02  49  	if (exynos_gem->flags & EXYNOS_BO_WC ||
813fd67b57ffca0 Joonyoung Shim      2015-10-02  50  			!(exynos_gem->flags & EXYNOS_BO_CACHABLE))
9940d9d93406f41 Marek Szyprowski    2020-04-23  51  		attr |= DMA_ATTR_WRITE_COMBINE;
2a8cb4894540898 Joonyoung Shim      2015-08-16  52  
9940d9d93406f41 Marek Szyprowski    2020-04-23  53  	/* FBDev emulation requires kernel mapping */
9940d9d93406f41 Marek Szyprowski    2020-04-23  54  	if (!kvmap)
9940d9d93406f41 Marek Szyprowski    2020-04-23  55  		attr |= DMA_ATTR_NO_KERNEL_MAPPING;
2a8cb4894540898 Joonyoung Shim      2015-08-16  56  
9940d9d93406f41 Marek Szyprowski    2020-04-23  57  	exynos_gem->dma_attrs = attr;
11e898373fba6b1 Chen-Yu Tsai        2026-03-26  58  	exynos_gem->cookie = dma_alloc_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size,
813fd67b57ffca0 Joonyoung Shim      2015-10-02  59  					     &exynos_gem->dma_addr, GFP_KERNEL,
00085f1efa387a8 Krzysztof Kozlowski 2016-08-03  60  					     exynos_gem->dma_attrs);
813fd67b57ffca0 Joonyoung Shim      2015-10-02  61  	if (!exynos_gem->cookie) {
e457a1a9585b941 Chen-Yu Tsai        2026-03-26  62  		DRM_DEV_ERROR(drm_dev_dma_dev(dev), "failed to allocate buffer.\n");
9940d9d93406f41 Marek Szyprowski    2020-04-23  63  		return -ENOMEM;
2a8cb4894540898 Joonyoung Shim      2015-08-16  64  	}
2a8cb4894540898 Joonyoung Shim      2015-08-16  65  
9940d9d93406f41 Marek Szyprowski    2020-04-23  66  	if (kvmap)
9940d9d93406f41 Marek Szyprowski    2020-04-23  67  		exynos_gem->kvaddr = exynos_gem->cookie;
df547bf7735a623 Marek Szyprowski    2015-10-13  68  
e457a1a9585b941 Chen-Yu Tsai        2026-03-26 @69  	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
11e898373fba6b1 Chen-Yu Tsai        2026-03-26  70  			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
2a8cb4894540898 Joonyoung Shim      2015-08-16  71  	return 0;
2a8cb4894540898 Joonyoung Shim      2015-08-16  72  }
2a8cb4894540898 Joonyoung Shim      2015-08-16  73  

:::::: The code at line 69 was first introduced by commit
:::::: e457a1a9585b941e2aa771142b63c951f6a3d54e drm/exynos: Use DRM core dedicated DMA device tracking facility

:::::: TO: Chen-Yu Tsai <wenst@chromium.org>
:::::: CC: Inki Dae <inki.dae@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
