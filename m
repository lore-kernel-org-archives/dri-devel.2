Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D05C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55A010E355;
	Sun, 13 Sep 2026 19:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FYT7KFHp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EEA10E355
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789328823; x=1820864823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L9ptgWMKdF9clEGjm+eLWytpT08sJO4eJ+AHkhKinV4=;
 b=FYT7KFHpRGZ+3h4gZ5SLh9TemBehpZdAchEwTBj3XNOC29gggmkAoiOT
 2iOpT26KOvcM9lhmGIiOC1gyOwH2rzpBO8IvOvOB0GyN+8UqRCcGTMmju
 3o3lZYPy/kIIC73BOzrdaN9LsjJ63C2udyYC5Pb/tLaaQIeTJi+32RMRa
 TDRY7jP/J2VINfDP6vT01vZTYrV2WCvNAMivuLvlar2QUbYcXvMSpTSOC
 kGSsuh2SEOCafjBNorod8NMIZWKkqLd1hjO1QQRce/uoY5Sx6CpjEMMyj
 g9sYX2AvnbUSORXYVXjyQytpJtg5wE5DjDf7QeKf6jxDHALwR0/4EcS7o w==;
X-CSE-ConnectionGUID: g3BWsdYZTASchOdzBF7u3g==
X-CSE-MsgGUID: 1ILgFI/gSNK1Hvr0W7fqeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93394380"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; d="scan'208";a="93394380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2026 12:47:02 -0700
X-CSE-ConnectionGUID: IuxGWnPnRMesp44EnmZauA==
X-CSE-MsgGUID: qz51yXVzRleYGI+WAU+5DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; d="scan'208";a="270660574"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 13 Sep 2026 12:46:59 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x5qAC-000000001Gj-1fzV;
 Sun, 13 Sep 2026 19:46:56 +0000
Date: Mon, 14 Sep 2026 03:46:17 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Guangshuo Li <lgs201920130244@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach
 failure
Message-ID: <202609140335.bubtlivW-lkp@intel.com>
References: <20260913102608.1526916-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913102608.1526916-1-lgs201920130244@gmail.com>
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

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.3-rc2]
[cannot apply to drm-misc/drm-misc-next next-20260911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/drm-panel-ilitek-ili9881c-fix-panel-cleanup-on-attach-failure/20260913-182608
base:   linus/master
patch link:    https://lore.kernel.org/r/20260913102608.1526916-1-lgs201920130244%40gmail.com
patch subject: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach failure
config: parisc-randconfig-002-20260914 (https://download.01.org/0day-ci/archive/20260914/202609140335.bubtlivW-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260914/202609140335.bubtlivW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609140335.bubtlivW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c: In function 'ili9881c_dsi_probe':
>> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:2599:78: error: expected ';' before 'dsi'
    2599 |                 return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
         |                                                                              ^
         |                                                                              ;
    2600 | 
    2601 |         dsi->mode_flags = ctx->desc->mode_flags;
         |         ~~~                                                                   


vim +2599 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

  2545	
  2546	static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
  2547	{
  2548		struct ili9881c *ctx;
  2549		int ret;
  2550	
  2551		ctx = devm_drm_panel_alloc(&dsi->dev, struct ili9881c, panel, &ili9881c_funcs,
  2552					   DRM_MODE_CONNECTOR_DSI);
  2553		if (IS_ERR(ctx))
  2554			return PTR_ERR(ctx);
  2555	
  2556		mipi_dsi_set_drvdata(dsi, ctx);
  2557		ctx->dsi = dsi;
  2558		ctx->desc = of_device_get_match_data(&dsi->dev);
  2559	
  2560		ctx->power = devm_regulator_get(&dsi->dev, "power");
  2561		if (IS_ERR(ctx->power))
  2562			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->power),
  2563					     "Couldn't get our power regulator\n");
  2564	
  2565		ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
  2566		if (IS_ERR(ctx->iovcc)) {
  2567			if (PTR_ERR(ctx->iovcc) != -ENODEV)
  2568				return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
  2569					     "Couldn't get our iovcc regulator\n");
  2570			ctx->iovcc = NULL;
  2571		}
  2572	
  2573		ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
  2574		if (IS_ERR(ctx->reset))
  2575			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
  2576					     "Couldn't get our reset GPIO\n");
  2577	
  2578		ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
  2579		if (ret) {
  2580			dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
  2581				dsi->dev.of_node, ret);
  2582			return ret;
  2583		}
  2584	
  2585		ctx->address_mode = ctx->desc->default_address_mode;
  2586		if (ctx->orientation == DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP) {
  2587			ctx->address_mode ^= 0x03;
  2588			ctx->orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
  2589		}
  2590	
  2591		ctx->panel.prepare_prev_first = true;
  2592	
  2593		ret = drm_panel_of_backlight(&ctx->panel);
  2594		if (ret)
  2595			return ret;
  2596	
  2597		ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
  2598		if (ret)
> 2599			return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
  2600	
  2601		dsi->mode_flags = ctx->desc->mode_flags;
  2602		dsi->format = MIPI_DSI_FMT_RGB888;
  2603		dsi->lanes = ctx->desc->lanes;
  2604	
  2605		return mipi_dsi_attach(dsi);
  2606	}
  2607	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
