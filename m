Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DC0CD343F
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 02:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6F610E2DA;
	Wed, 13 May 2026 02:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SQ96snBU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7840810E2DA
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778640820; x=1810176820;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gktVRTQwx0kuPYssen49JKdkggZ0ZSpaMiBgWqEuarg=;
 b=SQ96snBUrXD4Qm7BG2LZW2Vl0qma1OO+TLRoMpJOLYrZM7KWWfeV8w9h
 xvxNn8RP54z9SbZB+1lRSS1xena8MnVcWKskIC8+v5dolyb9gWQ6R3uN+
 7eHZEAxeGy3zLDtOnufyIwXKOTQzK4sq8I+F33XiinQVBxN2VQ6nWIOi3
 ZJm3i7uRCDp3bF2CNx3jHjK627HVwC74zv/cWyUohKNGebqh1p3g6Qr+D
 lOuJolMk8CARSmhS9atzd6muHgfTiWPtmtdwF98fMK++025TrzSLByWiR
 OeC9lYBdgaMDGCm5LoGMaZs8WJk9NKgxDyoQ6xwx71RCFLY/ZWq1rZU2C w==;
X-CSE-ConnectionGUID: XZBw45njQwWNOCcmLdCvQQ==
X-CSE-MsgGUID: UM3Nq0klR5innyu/PexURA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79738485"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79738485"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 19:53:39 -0700
X-CSE-ConnectionGUID: ZtxaRZz2TcOFTzfqBh/Dpg==
X-CSE-MsgGUID: YNhP+ZQbRe2VbetB28kmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="235282242"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 12 May 2026 19:53:36 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wMzj3-000000003G7-07sR;
 Wed, 13 May 2026 02:53:33 +0000
Date: Wed, 13 May 2026 10:52:57 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, linux@armlinux.org.uk,
 airlied@gmail.com, simona@ffwll.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/armada: fix device_node reference leak in
 armada_lcd_bind()
Message-ID: <202605131053.Tvq0phKC-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on daeinki-drm-exynos/exynos-drm-next]
[also build test ERROR on drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master rmk-arm/drm-armada-devel v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-armada-fix-device_node-reference-leak-in-armada_lcd_bind/20260512-194755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20260509091821.963513-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/armada: fix device_node reference leak in armada_lcd_bind()
config: arm-randconfig-003-20260512 (https://download.01.org/0day-ci/archive/20260513/202605131053.Tvq0phKC-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131053.Tvq0phKC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131053.Tvq0phKC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/armada/armada_crtc.c:1039:2: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |         ^~~
         |         res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
>> drivers/gpu/drm/armada/armada_crtc.c:1039:6: error: incompatible integer to pointer conversion assigning to 'struct resource *' from 'int' [-Wint-conversion]
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/armada/armada_crtc.c:1040:6: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1040 |         if (ret)
         |             ^~~
         |             res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
   drivers/gpu/drm/armada/armada_crtc.c:1042:9: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1042 |         return ret;
         |                ^~~
         |                res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
>> drivers/gpu/drm/armada/armada_crtc.c:1042:9: error: incompatible pointer to integer conversion returning 'struct resource *' from a function with result type 'int' [-Wint-conversion]
    1042 |         return ret;
         |                ^~~
   5 errors generated.


vim +1039 drivers/gpu/drm/armada/armada_crtc.c

  1007	
  1008	static int
  1009	armada_lcd_bind(struct device *dev, struct device *master, void *data)
  1010	{
  1011		struct platform_device *pdev = to_platform_device(dev);
  1012		struct drm_device *drm = data;
  1013		struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1014		int irq = platform_get_irq(pdev, 0);
  1015		const struct armada_variant *variant;
  1016		struct device_node *port = NULL;
  1017		struct device_node *np, *parent = dev->of_node;
  1018	
  1019		if (irq < 0)
  1020			return irq;
  1021	
  1022	
  1023		variant = device_get_match_data(dev);
  1024		if (!variant)
  1025			return -ENXIO;
  1026	
  1027		if (parent) {
  1028			np = of_get_child_by_name(parent, "ports");
  1029			if (np)
  1030				parent = np;
  1031			port = of_get_child_by_name(parent, "port");
  1032			of_node_put(np);
  1033			if (!port) {
  1034				dev_err(dev, "no port node found in %pOF\n", parent);
  1035				return -ENXIO;
  1036			}
  1037		}
  1038	
> 1039		ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
  1040		if (ret)
  1041			of_node_put(port);
> 1042		return ret;
  1043	}
  1044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
