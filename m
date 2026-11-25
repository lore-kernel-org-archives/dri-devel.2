Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD778606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6v++aS9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0729F10FC74;
	Wed, 25 Nov 2026 14:07:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA1810FC74
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795615634; x=1827151634;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KeYOf75Z/8+vjZolThFV16xZ7f4fxMRhbKAxsweSYkM=;
 b=X6v++aS9PERupo+CSYs6URyFfVUc3z0lBq11qkOGDVOl2OsKSA15wQjJ
 aflxUosMg27iAYKNKZ+aXeGTQA3s67Hdveo2Ce32ySnAv84vpc4t96QqU
 beWbjl1UKecabXdtmVJvStC3DCTRYuWXg0gMr9nxVyE8NuzIo3gKhxM9V
 nCrEL+4HYMsQ0FXuqkHLf9lJY7SvYqB2bxsiFwx9YokWlXTmjoUOCC1EN
 jtwCBWbiP4+S+UW1iqgedff0ggLKk10tiV+f10GzYc8rm7zGJJMvommqc
 sw3stYB/5KC20o5sLo3wlRilNhnJAlVnyvwlXubXFyOUFDYKzXoGzjHA/ w==;
X-CSE-ConnectionGUID: x5EhtKoNRhq5lh6m1pppZw==
X-CSE-MsgGUID: TJ/+HsvES+qWqF6gJRmRXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4486630"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4486630"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 06:07:13 -0800
X-CSE-ConnectionGUID: GPuoG+ptSeGdvPSSmoXnIw==
X-CSE-MsgGUID: l4qBFp6CTraX+JlcpmsW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="11873266"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 25 Nov 2026 06:07:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWDeO-00000001Rnq-2t50;
 Wed, 25 Nov 2026 14:07:08 +0000
Date: Wed, 25 Nov 2026 22:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, conor@kernel.org, Hefei <3066883572@qq.com>
Subject: Re: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Message-ID: <20261125220244.8Pj15HWb-lkp@intel.com>
References: <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07@qq.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hefei,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on dtor-input/next dtor-input/for-linus lee-backlight/for-backlight-next lee-backlight/for-backlight-fixes linus/master v7.4-rc4 next-20261124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hefei/dt-bindings-input-add-Jadard-JD9365TX-touchscreen-binding/20261125-101123
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/tencent_3D3EC29E27E9DF37D4C9F1A60F2F2BA3EF07%40qq.com
patch subject: [PATCH v3 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261125/20261125220244.8Pj15HWb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125220244.8Pj15HWb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125220244.8Pj15HWb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-viewe-jd9365tx.c: In function 'jd9365tx_probe':
   drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:304:15: error: implicit declaration of function 'of_drm_get_panel_orientation' [-Werror=implicit-function-declaration]
     304 |         ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panel/panel-viewe-jd9365tx.c:308:9: error: implicit declaration of function 'drm_panel_init'; did you mean 'drm_panel_put'? [-Werror=implicit-function-declaration]
     308 |         drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
         |         ^~~~~~~~~~~~~~
         |         drm_panel_put
   cc1: some warnings being treated as errors


vim +308 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

   273	
   274	static int jd9365tx_probe(struct mipi_dsi_device *dsi)
   275	{
   276		struct device *dev = &dsi->dev;
   277		struct jd9365tx_panel *ctx;
   278		int ret;
   279	
   280		ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
   281		if (!ctx)
   282			return -ENOMEM;
   283	
   284		ctx->dsi = dsi;
   285		mipi_dsi_set_drvdata(dsi, ctx);
   286	
   287		dsi->lanes = 2;
   288		dsi->format = MIPI_DSI_FMT_RGB888;
   289		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
   290				  MIPI_DSI_MODE_LPM;
   291	
   292		ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
   293		if (IS_ERR(ctx->reset))
   294			return PTR_ERR(ctx->reset);
   295	
   296		ctx->vdd = devm_regulator_get(dev, "vdd");
   297		if (IS_ERR(ctx->vdd))
   298			return PTR_ERR(ctx->vdd);
   299	
   300		ctx->iovcc = devm_regulator_get(dev, "iovcc");
   301		if (IS_ERR(ctx->iovcc))
   302			return PTR_ERR(ctx->iovcc);
   303	
   304		ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
   305		if (ret)
   306			return ret;
   307	
 > 308		drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
   309		ctx->panel.prepare_prev_first = true;
   310	
   311		ret = drm_panel_of_backlight(&ctx->panel);
   312		if (ret)
   313			return ret;
   314	
   315		drm_panel_add(&ctx->panel);
   316	
   317		ret = mipi_dsi_attach(dsi);
   318		if (ret < 0) {
   319			drm_panel_remove(&ctx->panel);
   320			return ret;
   321		}
   322	
   323		return 0;
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
