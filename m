Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B4CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB9B10E2C8;
	Tue, 12 May 2026 21:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QIEZg6vF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4C510E2C8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778622610; x=1810158610;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7TCUYNaAC8cK2hOC7Q7WOO0KP2o92/Q696cJKWNFRlc=;
 b=QIEZg6vFXVyAbOmqKoLxPrtgaSLBxoSvs00uMP3WDx8HMnlq9KHyAVHb
 LEGMeqUovTVlT3XrDBO0HWL9EBbFUHwEVyo5fHGFNEqNEw6YtumBUnyIx
 vdthbvLI3EbR076bL0jByZnSmqgWb71VRmAs0tf1wl1SDaxwLjmzG3ARV
 KOVWRDMLfhftH3b45LaFNSjp23dsYor7iajppS5o2Xu1iIN4SCmpn4jOt
 fjTtIz4czkYWDjNZQAHN8HKC06Jllu1JGJsze8QtB/KjMnWqgBGMxqP00
 HfeJyTz3eQRV3M70+hhE0MsKCiujXKUbGdRebqePww9YDwyT9mgxAkcl8 A==;
X-CSE-ConnectionGUID: XB1kOzx5T3y8a+dVxg9CTQ==
X-CSE-MsgGUID: SMjQ1YpvSemzDfY3ZfgJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67068886"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="67068886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 14:50:09 -0700
X-CSE-ConnectionGUID: VPrZie23RMGzMDiK/XRSuQ==
X-CSE-MsgGUID: BKF1IlxvQzKfXBptR1wqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="239700291"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 14:50:07 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wMuzM-000000002s3-3tIf;
 Tue, 12 May 2026 21:50:04 +0000
Date: Wed, 13 May 2026 05:49:50 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, linux@armlinux.org.uk,
 airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/armada: fix device_node reference leak in
 armada_lcd_bind()
Message-ID: <202605130528.fPiFL3HJ-lkp@intel.com>
References: <20260509091821.963513-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509091821.963513-1-vulab@iscas.ac.cn>
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

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on daeinki-drm-exynos/exynos-drm-next]
[also build test WARNING on drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master rmk-arm/drm-armada-devel v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-armada-fix-device_node-reference-leak-in-armada_lcd_bind/20260512-194755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20260509091821.963513-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/armada: fix device_node reference leak in armada_lcd_bind()
config: arm-randconfig-002-20260513 (https://download.01.org/0day-ci/archive/20260513/202605130528.fPiFL3HJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130528.fPiFL3HJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130528.fPiFL3HJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/armada/armada_crtc.c: In function 'armada_lcd_bind':
   drivers/gpu/drm/armada/armada_crtc.c:1039:9: error: 'ret' undeclared (first use in this function); did you mean 'res'?
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |         ^~~
         |         res
   drivers/gpu/drm/armada/armada_crtc.c:1039:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/armada/armada_crtc.c:1043:1: warning: control reaches end of non-void function [-Wreturn-type]
    1043 | }
         | ^


vim +1043 drivers/gpu/drm/armada/armada_crtc.c

d8c96083cf5e4a Russell King 2014-04-22  1007  
d8c96083cf5e4a Russell King 2014-04-22  1008  static int
d8c96083cf5e4a Russell King 2014-04-22  1009  armada_lcd_bind(struct device *dev, struct device *master, void *data)
d8c96083cf5e4a Russell King 2014-04-22  1010  {
d8c96083cf5e4a Russell King 2014-04-22  1011  	struct platform_device *pdev = to_platform_device(dev);
d8c96083cf5e4a Russell King 2014-04-22  1012  	struct drm_device *drm = data;
d8c96083cf5e4a Russell King 2014-04-22  1013  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
d8c96083cf5e4a Russell King 2014-04-22  1014  	int irq = platform_get_irq(pdev, 0);
d8c96083cf5e4a Russell King 2014-04-22  1015  	const struct armada_variant *variant;
9611cb93fa65dd Russell King 2014-06-15  1016  	struct device_node *port = NULL;
e1704914867872 Rob Herring  2023-10-20  1017  	struct device_node *np, *parent = dev->of_node;
d8c96083cf5e4a Russell King 2014-04-22  1018  
d8c96083cf5e4a Russell King 2014-04-22  1019  	if (irq < 0)
d8c96083cf5e4a Russell King 2014-04-22  1020  		return irq;
d8c96083cf5e4a Russell King 2014-04-22  1021  
d8c96083cf5e4a Russell King 2014-04-22  1022  
e1704914867872 Rob Herring  2023-10-20  1023  	variant = device_get_match_data(dev);
e1704914867872 Rob Herring  2023-10-20  1024  	if (!variant)
d8c96083cf5e4a Russell King 2014-04-22  1025  		return -ENXIO;
d8c96083cf5e4a Russell King 2014-04-22  1026  
e1704914867872 Rob Herring  2023-10-20  1027  	if (parent) {
9611cb93fa65dd Russell King 2014-06-15  1028  		np = of_get_child_by_name(parent, "ports");
9611cb93fa65dd Russell King 2014-06-15  1029  		if (np)
9611cb93fa65dd Russell King 2014-06-15  1030  			parent = np;
9611cb93fa65dd Russell King 2014-06-15  1031  		port = of_get_child_by_name(parent, "port");
9611cb93fa65dd Russell King 2014-06-15  1032  		of_node_put(np);
9611cb93fa65dd Russell King 2014-06-15  1033  		if (!port) {
4bf99144d2b407 Rob Herring  2017-07-18  1034  			dev_err(dev, "no port node found in %pOF\n", parent);
9611cb93fa65dd Russell King 2014-06-15  1035  			return -ENXIO;
9611cb93fa65dd Russell King 2014-06-15  1036  		}
d8c96083cf5e4a Russell King 2014-04-22  1037  	}
d8c96083cf5e4a Russell King 2014-04-22  1038  
2627b8898b0e61 Wentao Liang 2026-05-09  1039  	ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
2627b8898b0e61 Wentao Liang 2026-05-09  1040  	if (ret)
2627b8898b0e61 Wentao Liang 2026-05-09  1041  		of_node_put(port);
2627b8898b0e61 Wentao Liang 2026-05-09  1042  	return ret;
d8c96083cf5e4a Russell King 2014-04-22 @1043  }
d8c96083cf5e4a Russell King 2014-04-22  1044  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
