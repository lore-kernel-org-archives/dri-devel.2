Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491A606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k8jsSQEz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82E510E7C7;
	Tue, 20 Oct 2026 05:37:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB0610E7C7
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792474616; x=1824010616;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NaJiqPkqH2nAedLRE+95pl1WPOXe5cB3p9iVy/Z4kMI=;
 b=k8jsSQEzd+SVS9XFaOgOSSnnFUi+adP4QJ9X/u6FgdCauxX4Jf0gCo62
 wP1g4KOT5V8HgrNWgEYpmGkOfamRnm7TCDnaXn8VapZGzpDzSiIHBLf+P
 fTKDkAybZxxDgEQpS3d8dPgUMIlWJG4Tw7xPgjd8fknWsi6qSFlTw7izF
 1IRnfOUg7bWyHOKUotQPr1aP5+Nc/gImEBAPmdjqDCj8DKqH8Gar9WAaw
 RWIHxDHiKki+EkKvz720tbtzpUKaT3dflItG/nE4FPcb/2587ko2uAV1Y
 /cHvBaEXFMobQaW36ByOcn0mqKfd/d45U7YS9HdW+7iVPlSiat12YXFSc Q==;
X-CSE-ConnectionGUID: CWkC1q5XRaiLeaktJ+7YaQ==
X-CSE-MsgGUID: Oa/O5XVRRCGfP2iPFUhNVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1059268"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1059268"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 22:36:55 -0700
X-CSE-ConnectionGUID: 9G3YAZlkQj2waR4JmZbv1A==
X-CSE-MsgGUID: MzXHmm7cTBqL5aMo89B8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2784862"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 19 Oct 2026 22:36:50 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xJ2Wj-00000000Mxa-3KkM;
 Tue, 20 Oct 2026 05:36:45 +0000
Date: Tue, 20 Oct 2026 13:36:21 +0800
From: kernel test robot <lkp@intel.com>
To: Damon Ding <damon.ding@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>
Cc: oe-kbuild-all@lists.linux.dev,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v4 11/14] drm/bridge: analogix_dp: Use
 bridge->next_bridge instead of plat_data field
Message-ID: <202610201309.w3JSXlP5-lkp@intel.com>
References: <20261019085836.3065008-12-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019085836.3065008-12-damon.ding@rock-chips.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Damon,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next next-20261019]
[cannot apply to daeinki-drm-exynos/exynos-drm-next linus/master v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damon-Ding/drm-bridge-analogix_dp-Return-bitmask-from-analogix_dp_get_irq_type/20261019-165823
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261019085836.3065008-12-damon.ding%40rock-chips.com
patch subject: [PATCH v4 11/14] drm/bridge: analogix_dp: Use bridge->next_bridge instead of plat_data field
config: nios2-randconfig-1000-20261020 (https://download.01.org/0day-ci/archive/20261020/202610201309.w3JSXlP5-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610201309.w3JSXlP5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610201309.w3JSXlP5-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_aux_done_probing':
>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1669:(.text+0xb80): undefined reference to `devm_drm_of_display_mode_bridge'
>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1669:(.text+0xb80): relocation truncated to fit: R_NIOS2_CALL26 against `devm_drm_of_display_mode_bridge'


vim +1669 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

  1660	
  1661	static int analogix_dp_aux_done_probing(struct drm_dp_aux *aux)
  1662	{
  1663		struct analogix_dp_device *dp = to_dp(aux);
  1664		struct analogix_dp_plat_data *plat_data = dp->plat_data;
  1665		struct drm_bridge *bridge = &dp->bridge, *next_bridge;
  1666		int port = plat_data->dev_type == EXYNOS_DP ? 0 : 1;
  1667	
  1668		if (plat_data->dev_type == EXYNOS_DP && of_get_display_timings(dp->dev->of_node)) {
> 1669			next_bridge = devm_drm_of_display_mode_bridge(dp->dev, dp->dev->of_node,
  1670								      DRM_MODE_CONNECTOR_eDP);
  1671			if (IS_ERR(next_bridge))
  1672				return PTR_ERR(next_bridge);
  1673			bridge->next_bridge = drm_bridge_get(next_bridge);
  1674	
  1675			return component_add(dp->dev, plat_data->ops);
  1676		}
  1677	
  1678		/*
  1679		 * If of_drm_get_bridge_by_endpoint() returns -ENODEV, there may be no
  1680		 * valid panel or bridge nodes. The driver should go on for the
  1681		 * driver-free bridge or the DP mode applications.
  1682		 */
  1683		bridge->next_bridge = of_drm_get_bridge_by_endpoint(dp->dev->of_node, port, 0);
  1684		if (IS_ERR(bridge->next_bridge)) {
  1685			if (PTR_ERR(bridge->next_bridge) == -ENODEV)
  1686				bridge->next_bridge = NULL;
  1687			else
  1688				return PTR_ERR(bridge->next_bridge);
  1689		}
  1690	
  1691		return component_add(dp->dev, plat_data->ops);
  1692	}
  1693	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
