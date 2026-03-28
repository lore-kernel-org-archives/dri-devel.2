Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E910F3DF8
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 20:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260DC10E3BC;
	Sat, 28 Mar 2026 20:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YVgKxpiD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3E810E3BC
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774728541; x=1806264541;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Zp9Dxd4PmK1+0RXuo19KeVYFCQr5tYZE8oQlIlccaGA=;
 b=YVgKxpiDajKrpcvxYPttvv1bWoxBRObEmcWv318VKA/FZ9nUIQP9Mhah
 4aJD5rWLHBzuUkPSyXcr/wB/2Q0Jw1cMOSrv7EXtWF6jHMDw30Q516gGr
 G92oHwwBL6i6kzas1l3b77fWvk6IerYBxCYGAOOkKkAJus3j9ZRU9bbvR
 /1lc1lZWigV/NtMVYeLdyBGvDSYvsWrPccyXh1M7aX49VvhaYzQgWvazk
 P/AyvUPkgbozNOSs3VT9IVRrT5ZM46ZBUJd+CXo/UlOraDmJdyVIGTmgG
 XPlruYNDJpBaltFUfVmkVmb98wkU1vVITEswD4ZJ8hPXAPKUqeNwVCtze A==;
X-CSE-ConnectionGUID: vZTFpJTFSF2UJTKpxPFPYg==
X-CSE-MsgGUID: /7C6zIIBQFqrwFgkgVaQrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="87158757"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="87158757"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2026 13:09:00 -0700
X-CSE-ConnectionGUID: 2P3+ksYtQx+PJgUnMnMsKg==
X-CSE-MsgGUID: 8sC0RSNVRjaHZpdvDnQjIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="225883955"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa007.jf.intel.com with ESMTP; 28 Mar 2026 13:08:55 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w6Zxk-00000000Bjd-1D26;
 Sat, 28 Mar 2026 20:08:52 +0000
Date: Sun, 29 Mar 2026 04:08:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jay Liu <jay.liu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jay Liu <jay.liu@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH v4 6/6] drm/mediatek: Add TDSHP component support for
 MT8196
Message-ID: <202603290406.4CTuDfmw-lkp@intel.com>
References: <20260324125315.4715-7-jay.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324125315.4715-7-jay.liu@mediatek.com>
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

Hi Jay,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next pza/reset/next linus/master v7.0-rc5 next-20260327]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jay-Liu/dt-bindings-display-mediatek-gamma-Add-support-for-MT8196/20260328-083359
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260324125315.4715-7-jay.liu%40mediatek.com
patch subject: [PATCH v4 6/6] drm/mediatek: Add TDSHP component support for MT8196
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260329/202603290406.4CTuDfmw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290406.4CTuDfmw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290406.4CTuDfmw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:509:10: error: 'DDP_COMPONENT_CCORR0' undeclared here (not in a function); did you mean 'DDP_COMPONENT_CCORR'?
     509 |         [DDP_COMPONENT_CCORR0]          = { MTK_DISP_CCORR,             0, &ddp_ccorr },
         |          ^~~~~~~~~~~~~~~~~~~~
         |          DDP_COMPONENT_CCORR
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:509:10: error: array index in initializer not of integer type
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:509:10: note: (near initialization for 'mtk_ddp_matches')
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:510:10: error: 'DDP_COMPONENT_CCORR1' undeclared here (not in a function); did you mean 'DDP_COMPONENT_CCORR'?
     510 |         [DDP_COMPONENT_CCORR1]          = { MTK_DISP_CCORR,             1, &ddp_ccorr },
         |          ^~~~~~~~~~~~~~~~~~~~
         |          DDP_COMPONENT_CCORR
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:510:10: error: array index in initializer not of integer type
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:510:10: note: (near initialization for 'mtk_ddp_matches')
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:511:43: warning: initialized field overwritten [-Woverride-init]
     511 |         [DDP_COMPONENT_COLOR0]          = { MTK_DISP_COLOR,             0, &ddp_color },
         |                                           ^
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:511:43: note: (near initialization for 'mtk_ddp_matches[4]')
>> drivers/gpu/drm/mediatek/mtk_ddp_comp.c:547:10: error: 'DDP_COMPONENT_TDSHP0' undeclared here (not in a function); did you mean 'DDP_COMPONENT_DSI0'?
     547 |         [DDP_COMPONENT_TDSHP0]          = { MTK_DISP_TDSHP,             0, &ddp_tdshp },
         |          ^~~~~~~~~~~~~~~~~~~~
         |          DDP_COMPONENT_DSI0
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:547:10: error: array index in initializer not of integer type
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:547:10: note: (near initialization for 'mtk_ddp_matches')
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:548:43: warning: initialized field overwritten [-Woverride-init]
     548 |         [DDP_COMPONENT_UFOE]            = { MTK_DISP_UFOE,              0, &ddp_ufoe },
         |                                           ^
   drivers/gpu/drm/mediatek/mtk_ddp_comp.c:548:43: note: (near initialization for 'mtk_ddp_matches[57]')


vim +547 drivers/gpu/drm/mediatek/mtk_ddp_comp.c

   504	
   505	static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX] = {
   506		[DDP_COMPONENT_AAL0]		= { MTK_DISP_AAL,		0, &ddp_aal },
   507		[DDP_COMPONENT_AAL1]		= { MTK_DISP_AAL,		1, &ddp_aal },
   508		[DDP_COMPONENT_BLS]		= { MTK_DISP_BLS,		0, NULL },
   509		[DDP_COMPONENT_CCORR0]		= { MTK_DISP_CCORR,		0, &ddp_ccorr },
 > 510		[DDP_COMPONENT_CCORR1]		= { MTK_DISP_CCORR,		1, &ddp_ccorr },
   511		[DDP_COMPONENT_COLOR0]		= { MTK_DISP_COLOR,		0, &ddp_color },
   512		[DDP_COMPONENT_COLOR1]		= { MTK_DISP_COLOR,		1, &ddp_color },
   513		[DDP_COMPONENT_DITHER0]		= { MTK_DISP_DITHER,		0, &ddp_dither },
   514		[DDP_COMPONENT_DP_INTF0]	= { MTK_DP_INTF,		0, &ddp_dpi },
   515		[DDP_COMPONENT_DP_INTF1]	= { MTK_DP_INTF,		1, &ddp_dpi },
   516		[DDP_COMPONENT_DPI0]		= { MTK_DPI,			0, &ddp_dpi },
   517		[DDP_COMPONENT_DPI1]		= { MTK_DPI,			1, &ddp_dpi },
   518		[DDP_COMPONENT_DRM_OVL_ADAPTOR]	= { MTK_DISP_OVL_ADAPTOR,	0, &ddp_ovl_adaptor },
   519		[DDP_COMPONENT_DSC0]		= { MTK_DISP_DSC,		0, &ddp_dsc },
   520		[DDP_COMPONENT_DSC1]		= { MTK_DISP_DSC,		1, &ddp_dsc },
   521		[DDP_COMPONENT_DSI0]		= { MTK_DSI,			0, &ddp_dsi },
   522		[DDP_COMPONENT_DSI1]		= { MTK_DSI,			1, &ddp_dsi },
   523		[DDP_COMPONENT_DSI2]		= { MTK_DSI,			2, &ddp_dsi },
   524		[DDP_COMPONENT_DSI3]		= { MTK_DSI,			3, &ddp_dsi },
   525		[DDP_COMPONENT_GAMMA]		= { MTK_DISP_GAMMA,		0, &ddp_gamma },
   526		[DDP_COMPONENT_MERGE0]		= { MTK_DISP_MERGE,		0, &ddp_merge },
   527		[DDP_COMPONENT_MERGE1]		= { MTK_DISP_MERGE,		1, &ddp_merge },
   528		[DDP_COMPONENT_MERGE2]		= { MTK_DISP_MERGE,		2, &ddp_merge },
   529		[DDP_COMPONENT_MERGE3]		= { MTK_DISP_MERGE,		3, &ddp_merge },
   530		[DDP_COMPONENT_MERGE4]		= { MTK_DISP_MERGE,		4, &ddp_merge },
   531		[DDP_COMPONENT_MERGE5]		= { MTK_DISP_MERGE,		5, &ddp_merge },
   532		[DDP_COMPONENT_OD0]		= { MTK_DISP_OD,		0, &ddp_od },
   533		[DDP_COMPONENT_OD1]		= { MTK_DISP_OD,		1, &ddp_od },
   534		[DDP_COMPONENT_OVL0]		= { MTK_DISP_OVL,		0, &ddp_ovl },
   535		[DDP_COMPONENT_OVL1]		= { MTK_DISP_OVL,		1, &ddp_ovl },
   536		[DDP_COMPONENT_OVL_2L0]		= { MTK_DISP_OVL_2L,		0, &ddp_ovl },
   537		[DDP_COMPONENT_OVL_2L1]		= { MTK_DISP_OVL_2L,		1, &ddp_ovl },
   538		[DDP_COMPONENT_OVL_2L2]		= { MTK_DISP_OVL_2L,		2, &ddp_ovl },
   539		[DDP_COMPONENT_POSTMASK0]	= { MTK_DISP_POSTMASK,		0, &ddp_postmask },
   540		[DDP_COMPONENT_PWM0]		= { MTK_DISP_PWM,		0, NULL },
   541		[DDP_COMPONENT_PWM1]		= { MTK_DISP_PWM,		1, NULL },
   542		[DDP_COMPONENT_PWM2]		= { MTK_DISP_PWM,		2, NULL },
   543		[DDP_COMPONENT_RDMA0]		= { MTK_DISP_RDMA,		0, &ddp_rdma },
   544		[DDP_COMPONENT_RDMA1]		= { MTK_DISP_RDMA,		1, &ddp_rdma },
   545		[DDP_COMPONENT_RDMA2]		= { MTK_DISP_RDMA,		2, &ddp_rdma },
   546		[DDP_COMPONENT_RDMA4]		= { MTK_DISP_RDMA,		4, &ddp_rdma },
 > 547		[DDP_COMPONENT_TDSHP0]		= { MTK_DISP_TDSHP,		0, &ddp_tdshp },
   548		[DDP_COMPONENT_UFOE]		= { MTK_DISP_UFOE,		0, &ddp_ufoe },
   549		[DDP_COMPONENT_WDMA0]		= { MTK_DISP_WDMA,		0, NULL },
   550		[DDP_COMPONENT_WDMA1]		= { MTK_DISP_WDMA,		1, NULL },
   551	};
   552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
