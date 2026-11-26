Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CA606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnsDG8pu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13E810E0D8;
	Thu, 26 Nov 2026 01:16:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12C610E0D8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795655796; x=1827191796;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XVFTqBo+CJwzxoZI7Biy1XZPco1nvpzQl5ITb3ynK6I=;
 b=FnsDG8pu20D0AimuDbb1qnB4Uxo5+5m2sbfaYiw9O0oZgBQMg0mj5s7Y
 zFoiNFN6wmJddOJtcbMPz6dcIOhqV0jRkLJgPXy0mrGWka3pZwli9GuRK
 g/nZ35kizVLgHwaDJEckbFF7z7D3x096Ps10cWS3fUMgs0FF06Kbfb5fo
 6pqtzabsz5WosPcA3NncfRFO5tU73RlqqsUZd9Z6cRKC5qKpYBOx+gGfs
 neP4j/nLzk1oWm1e7QU9JwRbZ9kb2+Fox6OTLsDHRAh9osHWef/wBUjFm
 l8X36rniRY1nNIfCtcepQJ3YWIf7n+2k1tMtsZviwBfoXQqOWU3wNIqwL w==;
X-CSE-ConnectionGUID: 1auh8z+hQ2aHhvhgMFux2w==
X-CSE-MsgGUID: OE51iarVSJuUCsQvGFAYfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4397883"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4397883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 17:16:35 -0800
X-CSE-ConnectionGUID: LqTCoUBlQUOS/SHgfyex9g==
X-CSE-MsgGUID: gZ8/MW6fTzuWPfQ5eMAQFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12159304"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa005.fm.intel.com with ESMTP; 25 Nov 2026 17:16:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xWO63-00000001T2U-3AGp;
 Thu, 26 Nov 2026 01:16:23 +0000
Date: Thu, 26 Nov 2026 09:15:52 +0800
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
Subject: Re: [PATCH v4 09/32] drm/display: bridge-connector: use a dynamic
 connector
Message-ID: <20261126090631.mLSCvuCb-lkp@intel.com>
References: <20261125-drm-bridge-hotplug-v4-9-822722850492@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-drm-bridge-hotplug-v4-9-822722850492@bootlin.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 479e381e77dcde0dfcc9d51e89ff3273da199804]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Ceresoli/drm-display-hdmi-cec-helper-use-drmm_-prefix-for-drmm-action/20261125-185014
base:   479e381e77dcde0dfcc9d51e89ff3273da199804
patch link:    https://lore.kernel.org/r/20261125-drm-bridge-hotplug-v4-9-822722850492%40bootlin.com
patch subject: [PATCH v4 09/32] drm/display: bridge-connector: use a dynamic connector
config: sh-randconfig-1001-20261126 (https://download.01.org/0day-ci/archive/20261126/20261126090631.mLSCvuCb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126090631.mLSCvuCb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126090631.mLSCvuCb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/display/drm_bridge_connector.c:138 struct member 'has_cec_notifier' not described in 'drm_bridge_connector'
>> Warning: drivers/gpu/drm/display/drm_bridge_connector.c:138 struct member 'has_cec_notifier' not described in 'drm_bridge_connector'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
