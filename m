Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2293C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC01710EA5B;
	Tue,  4 Aug 2026 13:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iG/dtdeh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C0D10EA47;
 Tue,  4 Aug 2026 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785851483; x=1817387483;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7bIG1HRzvtOfObjOdqK6+arct743T/lTsJzgChsHWhw=;
 b=iG/dtdehjMGFMIZGEZnPuWyugRemFU42RIlYCchgRbJp58NJClJ0gU2r
 hPjZY6ZgdBWQyA89QBt7UmnUxI4lfxOPg+2prMG/GreSOS1A1J8wlcltY
 sgybcGKy0gGGm//EbGJCscI+WBGed9lXysNgvVMckvqy9ZmGkNT2p10Kd
 4y2kCzehEM6vnvjmYWT12eRjke5XMAqp1fBn0lbrcCZAUZ8jyUR7PSh+f
 2T2/ixhHhp2Z6TfyAWL49ywLACWtoWtPK3bkWC6kwjEZ9K2n6kNeLuezb
 umOZKsT2AvPEb1wGlIHTztiQT431TAxj8IK9nywMRnfH/dWNvifySdDz8 Q==;
X-CSE-ConnectionGUID: qJrWzddTSVejyiuiv8CZ2w==
X-CSE-MsgGUID: bLnaMMlcQdGNNcUfX/H1Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97908589"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="97908589"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 06:51:23 -0700
X-CSE-ConnectionGUID: 4ayE50L8Q467R/GCSfrsow==
X-CSE-MsgGUID: JWwjPt+6QwaOi0m5bfeSEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="257185788"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 06:51:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wrFXr-000000009zx-3ZFX;
 Tue, 04 Aug 2026 13:51:03 +0000
Date: Tue, 4 Aug 2026 21:50:09 +0800
From: kernel test robot <lkp@intel.com>
To: yaolu@kylinos.cn, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
Cc: oe-kbuild-all@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lu Yao <yaolu@kylinos.cn>
Subject: Re: [PATCH] drm/i915/display: fix error handling in
 intel_display_driver_probe_noirq
Message-ID: <202608042133.a0zParAB-lkp@intel.com>
References: <20260630031652.67747-1-yaolu@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630031652.67747-1-yaolu@kylinos.cn>
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

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-i915/for-linux-next]
[also build test WARNING on drm-i915/for-linux-next-fixes linus/master v7.2-rc6 next-20260803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yaolu-kylinos-cn/drm-i915-display-fix-error-handling-in-intel_display_driver_probe_noirq/20260804-144429
base:   https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next
patch link:    https://lore.kernel.org/r/20260630031652.67747-1-yaolu%40kylinos.cn
patch subject: [PATCH] drm/i915/display: fix error handling in intel_display_driver_probe_noirq
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260804/202608042133.a0zParAB-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260804/202608042133.a0zParAB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608042133.a0zParAB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/display/intel_display_driver.c: In function 'intel_display_driver_probe_noirq':
>> drivers/gpu/drm/i915/display/intel_display_driver.c:309:1: warning: label 'cleanup_wq_unordered' defined but not used [-Wunused-label]
     309 | cleanup_wq_unordered:
         | ^~~~~~~~~~~~~~~~~~~~


vim +/cleanup_wq_unordered +309 drivers/gpu/drm/i915/display/intel_display_driver.c

62bb6b4920ce9d Jani Nikula         2023-04-14  201  
40053823baadce Jani Nikula         2023-04-14  202  /* part #1: call before irq install */
f5d38d4fa88441 Jani Nikula         2024-12-04  203  int intel_display_driver_probe_noirq(struct intel_display *display)
40053823baadce Jani Nikula         2023-04-14  204  {
40053823baadce Jani Nikula         2023-04-14  205  	int ret;
40053823baadce Jani Nikula         2023-04-14  206  
ff8c73b7bfb547 Jani Nikula         2026-06-15  207  	intel_opregion_setup(display);
ff8c73b7bfb547 Jani Nikula         2026-06-15  208  
ff8c73b7bfb547 Jani Nikula         2026-06-15  209  	/*
ff8c73b7bfb547 Jani Nikula         2026-06-15  210  	 * Fill the dram structure to get the system dram info. This will be
ff8c73b7bfb547 Jani Nikula         2026-06-15  211  	 * used for memory latency calculation.
ff8c73b7bfb547 Jani Nikula         2026-06-15  212  	 */
ff8c73b7bfb547 Jani Nikula         2026-06-15  213  	ret = intel_dram_detect(display);
ff8c73b7bfb547 Jani Nikula         2026-06-15  214  	if (ret)
ff8c73b7bfb547 Jani Nikula         2026-06-15  215  		goto cleanup_opregion;
ff8c73b7bfb547 Jani Nikula         2026-06-15  216  
ff8c73b7bfb547 Jani Nikula         2026-06-15  217  	intel_bw_init_hw(display);
ff8c73b7bfb547 Jani Nikula         2026-06-15  218  
f5d38d4fa88441 Jani Nikula         2024-12-04  219  	if (HAS_DISPLAY(display)) {
f5d38d4fa88441 Jani Nikula         2024-12-04  220  		ret = drm_vblank_init(display->drm,
f5d38d4fa88441 Jani Nikula         2024-12-04  221  				      INTEL_NUM_PIPES(display));
40053823baadce Jani Nikula         2023-04-14  222  		if (ret)
ff8c73b7bfb547 Jani Nikula         2026-06-15  223  			goto cleanup_opregion;
40053823baadce Jani Nikula         2023-04-14  224  	}
40053823baadce Jani Nikula         2023-04-14  225  
9aec6f76a28cd6 Jani Nikula         2024-08-09  226  	intel_bios_init(display);
40053823baadce Jani Nikula         2023-04-14  227  
39e4d3c2f89ab8 Jouni Högander      2025-04-14  228  	intel_psr_dc5_dc6_wa_init(display);
39e4d3c2f89ab8 Jouni Högander      2025-04-14  229  
40053823baadce Jani Nikula         2023-04-14  230  	/* FIXME: completely on the wrong abstraction layer */
ad5190d6f35db6 Jani Nikula         2026-05-26  231  	ret = intel_display_power_init(display);
40053823baadce Jani Nikula         2023-04-14  232  	if (ret < 0)
70ea362b84449b Ville Syrjälä       2025-12-08  233  		goto cleanup_bios;
40053823baadce Jani Nikula         2023-04-14  234  
445fc685498bbb Jani Nikula         2024-12-31  235  	intel_pmdemand_init_early(display);
4c4cc7ac207f56 Mika Kahola         2023-06-06  236  
771394b4fb6d7d Jani Nikula         2026-05-26  237  	intel_display_power_init_hw(display);
40053823baadce Jani Nikula         2023-04-14  238  
f5d38d4fa88441 Jani Nikula         2024-12-04  239  	if (!HAS_DISPLAY(display))
40053823baadce Jani Nikula         2023-04-14  240  		return 0;
40053823baadce Jani Nikula         2023-04-14  241  
41837232b83874 Lu Yao              2026-06-30  242  	intel_dmc_init(display);
41837232b83874 Lu Yao              2026-06-30  243  
ed23224b3f5e5e Jani Nikula         2025-05-16  244  	display->hotplug.dp_wq = alloc_ordered_workqueue("intel-dp", 0);
ed23224b3f5e5e Jani Nikula         2025-05-16  245  	if (!display->hotplug.dp_wq) {
ed23224b3f5e5e Jani Nikula         2025-05-16  246  		ret = -ENOMEM;
70ea362b84449b Ville Syrjälä       2025-12-08  247  		goto cleanup_pw_domain_dmc;
ed23224b3f5e5e Jani Nikula         2025-05-16  248  	}
ed23224b3f5e5e Jani Nikula         2025-05-16  249  
f5d38d4fa88441 Jani Nikula         2024-12-04  250  	display->wq.modeset = alloc_ordered_workqueue("i915_modeset", 0);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  251  	if (!display->wq.modeset) {
dcab7a228f4ea9 Haoxiang Li         2025-05-16  252  		ret = -ENOMEM;
ed23224b3f5e5e Jani Nikula         2025-05-16  253  		goto cleanup_wq_dp;
dcab7a228f4ea9 Haoxiang Li         2025-05-16  254  	}
dcab7a228f4ea9 Haoxiang Li         2025-05-16  255  
f5d38d4fa88441 Jani Nikula         2024-12-04  256  	display->wq.flip = alloc_workqueue("i915_flip", WQ_HIGHPRI |
40053823baadce Jani Nikula         2023-04-14  257  						WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  258  	if (!display->wq.flip) {
dcab7a228f4ea9 Haoxiang Li         2025-05-16  259  		ret = -ENOMEM;
dcab7a228f4ea9 Haoxiang Li         2025-05-16  260  		goto cleanup_wq_modeset;
dcab7a228f4ea9 Haoxiang Li         2025-05-16  261  	}
dcab7a228f4ea9 Haoxiang Li         2025-05-16  262  
c15d0056fb74d6 Marco Crivellari    2025-11-04  263  	display->wq.cleanup = alloc_workqueue("i915_cleanup", WQ_HIGHPRI | WQ_PERCPU, 0);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  264  	if (!display->wq.cleanup) {
dcab7a228f4ea9 Haoxiang Li         2025-05-16  265  		ret = -ENOMEM;
dcab7a228f4ea9 Haoxiang Li         2025-05-16  266  		goto cleanup_wq_flip;
dcab7a228f4ea9 Haoxiang Li         2025-05-16  267  	}
40053823baadce Jani Nikula         2023-04-14  268  
c15d0056fb74d6 Marco Crivellari    2025-11-04  269  	display->wq.unordered = alloc_workqueue("display_unordered", WQ_PERCPU, 0);
7c377900772d8f Luca Coelho         2025-06-20  270  	if (!display->wq.unordered) {
7c377900772d8f Luca Coelho         2025-06-20  271  		ret = -ENOMEM;
7c377900772d8f Luca Coelho         2025-06-20  272  		goto cleanup_wq_cleanup;
7c377900772d8f Luca Coelho         2025-06-20  273  	}
7c377900772d8f Luca Coelho         2025-06-20  274  
f5d38d4fa88441 Jani Nikula         2024-12-04  275  	intel_mode_config_init(display);
40053823baadce Jani Nikula         2023-04-14  276  
d34927acff9150 Ville Syrjälä       2024-09-06  277  	ret = intel_cdclk_init(display);
40053823baadce Jani Nikula         2023-04-14  278  	if (ret)
41837232b83874 Lu Yao              2026-06-30  279  		goto cleanup_mode_config;
40053823baadce Jani Nikula         2023-04-14  280  
9d476ce24f72fc Ville Syrjälä       2024-10-24  281  	ret = intel_color_init(display);
40053823baadce Jani Nikula         2023-04-14  282  	if (ret)
41837232b83874 Lu Yao              2026-06-30  283  		goto cleanup_mode_config;
40053823baadce Jani Nikula         2023-04-14  284  
6fe8f9c1388b53 Jani Nikula         2025-04-08  285  	ret = intel_dbuf_init(display);
40053823baadce Jani Nikula         2023-04-14  286  	if (ret)
41837232b83874 Lu Yao              2026-06-30  287  		goto cleanup_mode_config;
40053823baadce Jani Nikula         2023-04-14  288  
ac930bab1c8985 Ville Syrjälä       2025-10-13  289  	ret = intel_dbuf_bw_init(display);
ac930bab1c8985 Ville Syrjälä       2025-10-13  290  	if (ret)
41837232b83874 Lu Yao              2026-06-30  291  		goto cleanup_mode_config;
ac930bab1c8985 Ville Syrjälä       2025-10-13  292  
d706998b6da687 Gustavo Sousa       2025-03-11  293  	ret = intel_bw_init(display);
40053823baadce Jani Nikula         2023-04-14  294  	if (ret)
41837232b83874 Lu Yao              2026-06-30  295  		goto cleanup_mode_config;
40053823baadce Jani Nikula         2023-04-14  296  
445fc685498bbb Jani Nikula         2024-12-31  297  	ret = intel_pmdemand_init(display);
4c4cc7ac207f56 Mika Kahola         2023-06-06  298  	if (ret)
41837232b83874 Lu Yao              2026-06-30  299  		goto cleanup_mode_config;
4c4cc7ac207f56 Mika Kahola         2023-06-06  300  
409c23ae6735cf Jani Nikula         2024-04-17  301  	intel_init_quirks(display);
40053823baadce Jani Nikula         2023-04-14  302  
fd5a9b950ea8ba Ville Syrjälä       2024-07-05  303  	intel_fbc_init(display);
40053823baadce Jani Nikula         2023-04-14  304  
40053823baadce Jani Nikula         2023-04-14  305  	return 0;
40053823baadce Jani Nikula         2023-04-14  306  
41837232b83874 Lu Yao              2026-06-30  307  cleanup_mode_config:
41837232b83874 Lu Yao              2026-06-30  308  	intel_mode_config_cleanup(display);
7c377900772d8f Luca Coelho         2025-06-20 @309  cleanup_wq_unordered:
7c377900772d8f Luca Coelho         2025-06-20  310  	destroy_workqueue(display->wq.unordered);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  311  cleanup_wq_cleanup:
dcab7a228f4ea9 Haoxiang Li         2025-05-16  312  	destroy_workqueue(display->wq.cleanup);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  313  cleanup_wq_flip:
dcab7a228f4ea9 Haoxiang Li         2025-05-16  314  	destroy_workqueue(display->wq.flip);
dcab7a228f4ea9 Haoxiang Li         2025-05-16  315  cleanup_wq_modeset:
dcab7a228f4ea9 Haoxiang Li         2025-05-16  316  	destroy_workqueue(display->wq.modeset);
ed23224b3f5e5e Jani Nikula         2025-05-16  317  cleanup_wq_dp:
ed23224b3f5e5e Jani Nikula         2025-05-16  318  	destroy_workqueue(display->hotplug.dp_wq);
70ea362b84449b Ville Syrjälä       2025-12-08  319  cleanup_pw_domain_dmc:
5c30cfa295ccbf Ville Syrjälä       2024-09-06  320  	intel_dmc_fini(display);
ad5190d6f35db6 Jani Nikula         2026-05-26  321  	intel_display_power_driver_remove(display);
40053823baadce Jani Nikula         2023-04-14  322  cleanup_bios:
9aec6f76a28cd6 Jani Nikula         2024-08-09  323  	intel_bios_driver_remove(display);
ff8c73b7bfb547 Jani Nikula         2026-06-15  324  cleanup_opregion:
ff8c73b7bfb547 Jani Nikula         2026-06-15  325  	intel_opregion_cleanup(display);
40053823baadce Jani Nikula         2023-04-14  326  
40053823baadce Jani Nikula         2023-04-14  327  	return ret;
40053823baadce Jani Nikula         2023-04-14  328  }
5e2e6b595d9d4c Juha-Pekka Heikkila 2025-12-16  329  ALLOW_ERROR_INJECTION(intel_display_driver_probe_noirq, ERRNO);
40053823baadce Jani Nikula         2023-04-14  330  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
