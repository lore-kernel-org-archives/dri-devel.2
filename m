Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874CDCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE08C10E058;
	Tue, 12 May 2026 14:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R5PRBz0+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F099710E28E
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778596532; x=1810132532;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/EgujSwo4+NHKVZ0W2F9XQfFsxhe1kbhwPxQwScMQu8=;
 b=R5PRBz0+vx3TyW+xNLHdetPBDRI6xiYGtpwN4WBaPwEA9A9sQhWPPEo3
 HMrq47zVhPXY/xrPNsqYDbpigKIr7T3QI8GgSefbImJwCt8vQbbHG+veW
 avsyELsWqmILn76R0k9ZfMqlvQ5DTxpayOH4OJfc0O8Axd6w5p5I8T4iJ
 feB+ffWKiYqYYKkBJ6rfaHGK4Z5hVTtE6V+PCGnwGawLLwh+WjSR2hnUE
 A8k9WWwXMhSVeX1HMGVgLRV0NMR9QDq58uJ51+zGEgBng8aEwMGrgJ4Fn
 9XNBvZk4oqUsOZ7/Hd71GGRXm/sPHWGOBLHSp8s/2sqpI29ihJRKxh+9T Q==;
X-CSE-ConnectionGUID: o1DK3uN3RNOYxCi64pfmsA==
X-CSE-MsgGUID: thws4frWRo66Xg3zxttpIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79490223"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="79490223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 07:35:32 -0700
X-CSE-ConnectionGUID: f9UlSokqTWWwQzHTMw0lmg==
X-CSE-MsgGUID: ddF2dzviQOSsBX28o/dqcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="242782767"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 12 May 2026 07:35:29 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wMoCj-000000002H5-0KdD;
 Tue, 12 May 2026 14:35:25 +0000
Date: Tue, 12 May 2026 22:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 David Lechner <david@lechnology.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] drm/st7735r: simplify with
 spi_get_device_match_data()
Message-ID: <202605122242.rk2LQyeW-lkp@intel.com>
References: <20260508080004.1143774-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508080004.1143774-1-andriy.shevchenko@linux.intel.com>
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

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/drm-st7735r-simplify-with-spi_get_device_match_data/20260512-161814
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260508080004.1143774-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] drm/st7735r: simplify with spi_get_device_match_data()
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260512/202605122242.rk2LQyeW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605122242.rk2LQyeW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605122242.rk2LQyeW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/sitronix/st7735r.c:255:34: error: incompatible pointer types passing 'struct device *' to parameter of type 'const struct spi_device *' [-Werror,-Wincompatible-pointer-types]
     255 |         cfg = spi_get_device_match_data(&spi->dev);
         |                                         ^~~~~~~~~
   include/linux/spi/spi.h:1757:52: note: passing argument to parameter 'sdev' here
    1757 | spi_get_device_match_data(const struct spi_device *sdev);
         |                                                    ^
   1 error generated.


vim +255 drivers/gpu/drm/sitronix/st7735r.c

   234	
   235	static int st7735r_probe(struct spi_device *spi)
   236	{
   237		struct device *dev = &spi->dev;
   238		const struct st7735r_cfg *cfg;
   239		struct mipi_dbi_dev *dbidev;
   240		struct st7735r_device *st7735r;
   241		struct drm_device *drm;
   242		struct mipi_dbi *dbi;
   243		struct gpio_desc *dc;
   244		struct drm_plane *plane;
   245		struct drm_crtc *crtc;
   246		struct drm_encoder *encoder;
   247		struct drm_connector *connector;
   248		u32 rotation = 0;
   249		int ret;
   250	
   251		st7735r = devm_drm_dev_alloc(dev, &st7735r_driver, struct st7735r_device, dbidev.drm);
   252		if (IS_ERR(st7735r))
   253			return PTR_ERR(st7735r);
   254	
 > 255		cfg = spi_get_device_match_data(&spi->dev);
   256		st7735r->cfg = cfg;
   257	
   258		dbidev = &st7735r->dbidev;
   259		dbi = &dbidev->dbi;
   260		drm = &dbidev->drm;
   261	
   262		dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
   263		if (IS_ERR(dbi->reset))
   264			return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
   265	
   266		dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
   267		if (IS_ERR(dc))
   268			return dev_err_probe(dev, PTR_ERR(dc), "Failed to get GPIO 'dc'\n");
   269	
   270		dbidev->backlight = devm_of_find_backlight(dev);
   271		if (IS_ERR(dbidev->backlight))
   272			return PTR_ERR(dbidev->backlight);
   273	
   274		device_property_read_u32(dev, "rotation", &rotation);
   275	
   276		ret = mipi_dbi_spi_init(spi, dbi, dc);
   277		if (ret)
   278			return ret;
   279	
   280		if (cfg->write_only)
   281			dbi->read_commands = NULL;
   282	
   283		dbidev->left_offset = cfg->left_offset;
   284		dbidev->top_offset = cfg->top_offset;
   285	
   286		ret = drm_mipi_dbi_dev_init(dbidev, &cfg->mode, st7735r_plane_formats[0], rotation, 0);
   287		if (ret)
   288			return ret;
   289	
   290		ret = drmm_mode_config_init(drm);
   291		if (ret)
   292			return ret;
   293	
   294		drm->mode_config.min_width = dbidev->mode.hdisplay;
   295		drm->mode_config.max_width = dbidev->mode.hdisplay;
   296		drm->mode_config.min_height = dbidev->mode.vdisplay;
   297		drm->mode_config.max_height = dbidev->mode.vdisplay;
   298		drm->mode_config.funcs = &st7735r_mode_config_funcs;
   299		drm->mode_config.preferred_depth = 16;
   300		drm->mode_config.helper_private = &st7735r_mode_config_helper_funcs;
   301	
   302		plane = &st7735r->plane;
   303		ret = drm_universal_plane_init(drm, plane, 0, &st7735r_plane_funcs,
   304					       st7735r_plane_formats, ARRAY_SIZE(st7735r_plane_formats),
   305					       st7735r_plane_format_modifiers,
   306					       DRM_PLANE_TYPE_PRIMARY, NULL);
   307		if (ret)
   308			return ret;
   309		drm_plane_helper_add(plane, &st7735r_plane_helper_funcs);
   310		drm_plane_enable_fb_damage_clips(plane);
   311	
   312		crtc = &st7735r->crtc;
   313		ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL, &st7735r_crtc_funcs, NULL);
   314		if (ret)
   315			return ret;
   316		drm_crtc_helper_add(crtc, &st7735r_crtc_helper_funcs);
   317	
   318		encoder = &st7735r->encoder;
   319		ret = drm_encoder_init(drm, encoder, &st7735r_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
   320		if (ret)
   321			return ret;
   322		encoder->possible_crtcs = drm_crtc_mask(crtc);
   323	
   324		connector = &st7735r->connector;
   325		ret = drm_connector_init(drm, connector, &st7735r_connector_funcs,
   326					 DRM_MODE_CONNECTOR_SPI);
   327		if (ret)
   328			return ret;
   329		drm_connector_helper_add(connector, &st7735r_connector_helper_funcs);
   330	
   331		ret = drm_connector_attach_encoder(connector, encoder);
   332		if (ret)
   333			return ret;
   334	
   335		drm_mode_config_reset(drm);
   336	
   337		ret = drm_dev_register(drm, 0);
   338		if (ret)
   339			return ret;
   340	
   341		spi_set_drvdata(spi, drm);
   342	
   343		drm_client_setup(drm, NULL);
   344	
   345		return 0;
   346	}
   347	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
