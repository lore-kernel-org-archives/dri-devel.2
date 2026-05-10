Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3D2CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 11:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FCF10E0F5;
	Sun, 10 May 2026 11:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wj5f8A96";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFDD10E0F5
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778411323; x=1809947323;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8mi75fPhsaQvw1HU20UCrojZo7Ec5xue0QGTcQ2utCo=;
 b=Wj5f8A96/9USy7Av8PKwbstxS9cpzAVGEOg4qUhX6+seseA9eAlirqbn
 twT1xTtFzE8XIDqQZYKL3c3aHBpHZFqmx+IFTcOYk83ihxgANjUKB5zbx
 tjZrX/bMMcfHzvHHz8WcRJ44jaZ/jWR2ZJs8uHYtYfdQRDmZcrvTwsPxg
 eE39pw7lSWI8M34KAe4d6pqNorjXrAvc0Pmyc/THNYp4HBkrb7/A+xwF+
 MbrqMVpxkInDs8g5v4s1gp1fQnXJffgCinyKxx9wvwg0fT9J+V8FI0VYp
 xf1wQWnmBpZn+rmvkR8pGpsFFv7+sHMgOQ+p4B3b1/tC/uLvU5S0lqhDJ w==;
X-CSE-ConnectionGUID: tfLEkHOEQcWPO1COLKLZDw==
X-CSE-MsgGUID: ROjd9V0uQl+QBzSew5lQQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79424370"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="79424370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 04:08:42 -0700
X-CSE-ConnectionGUID: wozOUDh1TdKH6zr0whv3+Q==
X-CSE-MsgGUID: cA71tP/4SiqTcQ1+46CSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="242192373"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 10 May 2026 04:08:39 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wM21U-0000000024j-0uQH;
 Sun, 10 May 2026 11:08:36 +0000
Date: Sun, 10 May 2026 19:07:37 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] drm/repaper: simplify with
 spi_get_device_match_data()
Message-ID: <202605101800.3kkXjmOf-lkp@intel.com>
References: <20260508080243.1144046-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508080243.1144046-1-andriy.shevchenko@linux.intel.com>
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
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/drm-repaper-simplify-with-spi_get_device_match_data/20260510-091051
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260508080243.1144046-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] drm/repaper: simplify with spi_get_device_match_data()
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260510/202605101800.3kkXjmOf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101800.3kkXjmOf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101800.3kkXjmOf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tiny/repaper.c: In function 'repaper_probe':
>> drivers/gpu/drm/tiny/repaper.c:1016:74: error: passing argument 1 of 'spi_get_device_match_data' from incompatible pointer type [-Wincompatible-pointer-types]
    1016 |         model = (enum repaper_model)(uintptr_t)spi_get_device_match_data(dev);
         |                                                                          ^~~
         |                                                                          |
         |                                                                          struct device *
   In file included from drivers/gpu/drm/tiny/repaper.c:21:
   include/linux/spi/spi.h:1757:52: note: expected 'const struct spi_device *' but argument is of type 'struct device *'
    1757 | spi_get_device_match_data(const struct spi_device *sdev);
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/spi_get_device_match_data +1016 drivers/gpu/drm/tiny/repaper.c

   940	
   941	static int repaper_probe(struct spi_device *spi)
   942	{
   943		const struct drm_display_mode *mode;
   944		struct device *dev = &spi->dev;
   945		enum repaper_model model;
   946		const char *thermal_zone;
   947		struct repaper_epd *epd;
   948		size_t line_buffer_size;
   949		struct drm_device *drm;
   950		int ret;
   951	
   952		/* The SPI device is used to allocate dma memory */
   953		if (!dev->coherent_dma_mask) {
   954			ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
   955			if (ret) {
   956				dev_warn(dev, "Failed to set dma mask %d\n", ret);
   957				return ret;
   958			}
   959		}
   960	
   961		epd = devm_drm_dev_alloc(dev, &repaper_driver,
   962					 struct repaper_epd, drm);
   963		if (IS_ERR(epd))
   964			return PTR_ERR(epd);
   965	
   966		drm = &epd->drm;
   967	
   968		ret = drmm_mode_config_init(drm);
   969		if (ret)
   970			return ret;
   971		drm->mode_config.funcs = &repaper_mode_config_funcs;
   972	
   973		epd->spi = spi;
   974	
   975		epd->panel_on = devm_gpiod_get(dev, "panel-on", GPIOD_OUT_LOW);
   976		if (IS_ERR(epd->panel_on)) {
   977			ret = PTR_ERR(epd->panel_on);
   978			if (ret != -EPROBE_DEFER)
   979				DRM_DEV_ERROR(dev, "Failed to get gpio 'panel-on'\n");
   980			return ret;
   981		}
   982	
   983		epd->discharge = devm_gpiod_get(dev, "discharge", GPIOD_OUT_LOW);
   984		if (IS_ERR(epd->discharge)) {
   985			ret = PTR_ERR(epd->discharge);
   986			if (ret != -EPROBE_DEFER)
   987				DRM_DEV_ERROR(dev, "Failed to get gpio 'discharge'\n");
   988			return ret;
   989		}
   990	
   991		epd->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
   992		if (IS_ERR(epd->reset)) {
   993			ret = PTR_ERR(epd->reset);
   994			if (ret != -EPROBE_DEFER)
   995				DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
   996			return ret;
   997		}
   998	
   999		epd->busy = devm_gpiod_get(dev, "busy", GPIOD_IN);
  1000		if (IS_ERR(epd->busy)) {
  1001			ret = PTR_ERR(epd->busy);
  1002			if (ret != -EPROBE_DEFER)
  1003				DRM_DEV_ERROR(dev, "Failed to get gpio 'busy'\n");
  1004			return ret;
  1005		}
  1006	
  1007		if (!device_property_read_string(dev, "pervasive,thermal-zone",
  1008						 &thermal_zone)) {
  1009			epd->thermal = thermal_zone_get_zone_by_name(thermal_zone);
  1010			if (IS_ERR(epd->thermal)) {
  1011				DRM_DEV_ERROR(dev, "Failed to get thermal zone: %s\n", thermal_zone);
  1012				return PTR_ERR(epd->thermal);
  1013			}
  1014		}
  1015	
> 1016		model = (enum repaper_model)(uintptr_t)spi_get_device_match_data(dev);
  1017		switch (model) {
  1018		case E1144CS021:
  1019			mode = &repaper_e1144cs021_mode;
  1020			epd->channel_select = repaper_e1144cs021_cs;
  1021			epd->stage_time = 480;
  1022			epd->bytes_per_scan = 96 / 4;
  1023			epd->middle_scan = true; /* data-scan-data */
  1024			epd->pre_border_byte = false;
  1025			epd->border_byte = REPAPER_BORDER_BYTE_ZERO;
  1026			break;
  1027	
  1028		case E1190CS021:
  1029			mode = &repaper_e1190cs021_mode;
  1030			epd->channel_select = repaper_e1190cs021_cs;
  1031			epd->stage_time = 480;
  1032			epd->bytes_per_scan = 128 / 4 / 2;
  1033			epd->middle_scan = false; /* scan-data-scan */
  1034			epd->pre_border_byte = false;
  1035			epd->border_byte = REPAPER_BORDER_BYTE_SET;
  1036			break;
  1037	
  1038		case E2200CS021:
  1039			mode = &repaper_e2200cs021_mode;
  1040			epd->channel_select = repaper_e2200cs021_cs;
  1041			epd->stage_time = 480;
  1042			epd->bytes_per_scan = 96 / 4;
  1043			epd->middle_scan = true; /* data-scan-data */
  1044			epd->pre_border_byte = true;
  1045			epd->border_byte = REPAPER_BORDER_BYTE_NONE;
  1046			break;
  1047	
  1048		case E2271CS021:
  1049			epd->border = devm_gpiod_get(dev, "border", GPIOD_OUT_LOW);
  1050			if (IS_ERR(epd->border)) {
  1051				ret = PTR_ERR(epd->border);
  1052				if (ret != -EPROBE_DEFER)
  1053					DRM_DEV_ERROR(dev, "Failed to get gpio 'border'\n");
  1054				return ret;
  1055			}
  1056	
  1057			mode = &repaper_e2271cs021_mode;
  1058			epd->channel_select = repaper_e2271cs021_cs;
  1059			epd->stage_time = 630;
  1060			epd->bytes_per_scan = 176 / 4;
  1061			epd->middle_scan = true; /* data-scan-data */
  1062			epd->pre_border_byte = true;
  1063			epd->border_byte = REPAPER_BORDER_BYTE_NONE;
  1064			break;
  1065	
  1066		default:
  1067			return -ENODEV;
  1068		}
  1069	
  1070		epd->mode = mode;
  1071		epd->width = mode->hdisplay;
  1072		epd->height = mode->vdisplay;
  1073		epd->factored_stage_time = epd->stage_time;
  1074	
  1075		line_buffer_size = 2 * epd->width / 8 + epd->bytes_per_scan + 2;
  1076		epd->line_buffer = devm_kzalloc(dev, line_buffer_size, GFP_KERNEL);
  1077		if (!epd->line_buffer)
  1078			return -ENOMEM;
  1079	
  1080		epd->current_frame = devm_kzalloc(dev, epd->width * epd->height / 8,
  1081						  GFP_KERNEL);
  1082		if (!epd->current_frame)
  1083			return -ENOMEM;
  1084	
  1085		drm->mode_config.min_width = mode->hdisplay;
  1086		drm->mode_config.max_width = mode->hdisplay;
  1087		drm->mode_config.min_height = mode->vdisplay;
  1088		drm->mode_config.max_height = mode->vdisplay;
  1089	
  1090		drm_connector_helper_add(&epd->connector, &repaper_connector_hfuncs);
  1091		ret = drm_connector_init(drm, &epd->connector, &repaper_connector_funcs,
  1092					 DRM_MODE_CONNECTOR_SPI);
  1093		if (ret)
  1094			return ret;
  1095	
  1096		ret = drm_simple_display_pipe_init(drm, &epd->pipe, &repaper_pipe_funcs,
  1097						   repaper_formats, ARRAY_SIZE(repaper_formats),
  1098						   NULL, &epd->connector);
  1099		if (ret)
  1100			return ret;
  1101	
  1102		drm_mode_config_reset(drm);
  1103	
  1104		ret = drm_dev_register(drm, 0);
  1105		if (ret)
  1106			return ret;
  1107	
  1108		spi_set_drvdata(spi, drm);
  1109	
  1110		DRM_DEBUG_DRIVER("SPI speed: %uMHz\n", spi->max_speed_hz / 1000000);
  1111	
  1112		drm_client_setup(drm, NULL);
  1113	
  1114		return 0;
  1115	}
  1116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
