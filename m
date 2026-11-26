Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D50606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FpemP8Ku
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7430610E253;
	Thu, 26 Nov 2026 05:13:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A996510E253
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795669980; x=1827205980;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tFnAXjoyu6xvvKvqfz4pnz+erMB8nXx1rsV4XpMr9mo=;
 b=FpemP8Ku978zb/cGO+9dUE0JpBy915/u1pB8Pm8hWosGBmU6nj41cL7D
 Cx6tx65TW7w2n9uBiVt4PTC6rm1X14NYvT9z5f+0VBVbEZ822TDSghK06
 Ecd0aH0SLPH2myynmeOerEdCfG1haPATOkQVH/TwlbBgnwVAfWU3QKz2S
 aJKy/N9TBRB3wGsgdp0jP7JqazywDhNBnI0oZqT9N7mjha1Df4IF7Z30n
 7JPXiUdM+tLmSSv/Qiom4/ACq147xHpT6UNAwfm+Sn6JC+kmeu01HOtZC
 aUuEdNgf43omBjQxDtlhFIcR1Iv+yVzWKngKz44WMycS5X0Va2SCQkYIe w==;
X-CSE-ConnectionGUID: UUvDoFu8Q/meKBKoG08snQ==
X-CSE-MsgGUID: sK0nQtPFS6aWX1Ju+a70PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4632451"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4632451"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 21:13:00 -0800
X-CSE-ConnectionGUID: LW6fTMmRQ+WAbpO6kbVJxA==
X-CSE-MsgGUID: ifldHr/pQ3iUjmkaQoTfcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="14112093"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 25 Nov 2026 21:12:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWRmr-00000001TJk-3Mok;
 Thu, 26 Nov 2026 05:12:49 +0000
Date: Thu, 26 Nov 2026 13:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 32/32] drm/mxsfb/lcdif: enable bridge hotplug
Message-ID: <20261126130346.sISldSGf-lkp@intel.com>
References: <20261125-drm-bridge-hotplug-v4-32-822722850492@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-drm-bridge-hotplug-v4-32-822722850492@bootlin.com>
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

Hi Luca,

kernel test robot noticed the following build errors:

[auto build test ERROR on 479e381e77dcde0dfcc9d51e89ff3273da199804]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Ceresoli/drm-display-hdmi-cec-helper-use-drmm_-prefix-for-drmm-action/20261125-185014
base:   479e381e77dcde0dfcc9d51e89ff3273da199804
patch link:    https://lore.kernel.org/r/20261125-drm-bridge-hotplug-v4-32-822722850492%40bootlin.com
patch subject: [PATCH v4 32/32] drm/mxsfb/lcdif: enable bridge hotplug
config: arc-randconfig-1000-20261126 (https://download.01.org/0day-ci/archive/20261126/20261126130346.sISldSGf-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126130346.sISldSGf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126130346.sISldSGf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/display/drm_hotplug_helper.c: In function 'drm_hotplug_helper_handle_event':
>> drivers/gpu/drm/display/drm_hotplug_helper.c:234:2: error: label at end of compound statement
     default:
     ^~~~~~~


vim +234 drivers/gpu/drm/display/drm_hotplug_helper.c

6ee877a9b7f826b Luca Ceresoli 2026-11-25  200  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  201  static int drm_hotplug_helper_handle_event(struct notifier_block *nb,
6ee877a9b7f826b Luca Ceresoli 2026-11-25  202  					   unsigned long event, void *data)
6ee877a9b7f826b Luca Ceresoli 2026-11-25  203  {
6ee877a9b7f826b Luca Ceresoli 2026-11-25  204  	struct drm_hotplug_helper *hotplug_helper =
6ee877a9b7f826b Luca Ceresoli 2026-11-25  205  		container_of(nb, struct drm_hotplug_helper, drm_event_nb);
6ee877a9b7f826b Luca Ceresoli 2026-11-25  206  	struct device *dev = hotplug_helper->encoder->dev->dev;
6ee877a9b7f826b Luca Ceresoli 2026-11-25  207  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  208  	guard(mutex)(&hotplug_helper->event_mutex);
6ee877a9b7f826b Luca Ceresoli 2026-11-25  209  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  210  	dev_dbg(dev, "received event %lu\n", event);
6ee877a9b7f826b Luca Ceresoli 2026-11-25  211  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  212  	switch (event) {
6ee877a9b7f826b Luca Ceresoli 2026-11-25  213  	case DRM_BRIDGE_ADDED:
6ee877a9b7f826b Luca Ceresoli 2026-11-25  214  	case DRM_MIPI_DSI_ATTACHED:
6ee877a9b7f826b Luca Ceresoli 2026-11-25  215  		/*
6ee877a9b7f826b Luca Ceresoli 2026-11-25  216  		 * A bridges hot-plugged, try adding the
6ee877a9b7f826b Luca Ceresoli 2026-11-25  217  		 * drm_bridge_connector
6ee877a9b7f826b Luca Ceresoli 2026-11-25  218  		 */
6ee877a9b7f826b Luca Ceresoli 2026-11-25  219  		drm_hotplug_helper_try_complete(hotplug_helper);
6ee877a9b7f826b Luca Ceresoli 2026-11-25  220  		break;
6ee877a9b7f826b Luca Ceresoli 2026-11-25  221  	case DRM_BRIDGE_DETACHED:
6ee877a9b7f826b Luca Ceresoli 2026-11-25  222  	{
6ee877a9b7f826b Luca Ceresoli 2026-11-25  223  		/*
6ee877a9b7f826b Luca Ceresoli 2026-11-25  224  		 * A bridge was unplugged, remove the drm_bridge_connector
6ee877a9b7f826b Luca Ceresoli 2026-11-25  225  		 * if it's part of the same pipeline
6ee877a9b7f826b Luca Ceresoli 2026-11-25  226  		 */
6ee877a9b7f826b Luca Ceresoli 2026-11-25  227  		struct drm_bridge *bridge = (struct drm_bridge *)data;
6ee877a9b7f826b Luca Ceresoli 2026-11-25  228  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  229  		if (hotplug_helper->connector &&
6ee877a9b7f826b Luca Ceresoli 2026-11-25  230  		    bridge->encoder == hotplug_helper->encoder)
6ee877a9b7f826b Luca Ceresoli 2026-11-25  231  			drm_hotplug_helper_connector_remove(hotplug_helper);
6ee877a9b7f826b Luca Ceresoli 2026-11-25  232  		break;
6ee877a9b7f826b Luca Ceresoli 2026-11-25  233  	}
6ee877a9b7f826b Luca Ceresoli 2026-11-25 @234  	default:
6ee877a9b7f826b Luca Ceresoli 2026-11-25  235  	}
6ee877a9b7f826b Luca Ceresoli 2026-11-25  236  
6ee877a9b7f826b Luca Ceresoli 2026-11-25  237  	return NOTIFY_DONE;
6ee877a9b7f826b Luca Ceresoli 2026-11-25  238  }
6ee877a9b7f826b Luca Ceresoli 2026-11-25  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
