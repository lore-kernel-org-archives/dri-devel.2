Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB33606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MOvPBZGY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EED610F232;
	Tue, 20 Oct 2026 05:38:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D0310F213
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792474677; x=1824010677;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CgbzEe28G1zTrLdrNfJYfgWctwC1jg4tju9+nzpN6Co=;
 b=MOvPBZGYccieztwg8Ojp2EGbyhD3P2Sfs87x99Lx/vCPdgulwXXVYFoZ
 NeT9IkJmdD5CKVlKxK6k253T/JCvs9VDg4PXPMD4ZTcphRWHoRRuepBTS
 aubyhAiAjtBZTo2wNc+vGjKlDbmXJsErj8eAITYEElXYMb0wzKs8NYUBU
 cJdMaM5l7RbJggwxMHsEB2emvZvNhCKjY4b3p5//Y08OFTBmSHAjSsnzu
 eLnrhp3Yw/gh1Dt45OiNIW9BR25h4zoLvXbygvCPYRKU7ME8OHqkW6XPT
 +g/2rIMvuail9ZS+9Lsc/0A1wmxL/2kWEwUtb3zzmMEuryYaLOtI7Tn2f A==;
X-CSE-ConnectionGUID: JsgqN3gnRFyAqBL2AuR8BA==
X-CSE-MsgGUID: HEgpSTaCTpuLRXRDWe7B8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1059037"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1059037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 22:37:57 -0700
X-CSE-ConnectionGUID: LV6bCR60Sxa6Yc/YIXoDCg==
X-CSE-MsgGUID: WFK0iYt7RvyviF8oI28nAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2691338"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 19 Oct 2026 22:37:50 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xJ2Xh-00000000Mxi-3lzb;
 Tue, 20 Oct 2026 05:37:45 +0000
Date: Tue, 20 Oct 2026 13:37:26 +0800
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
Message-ID: <202610201323.RdqouIbq-lkp@intel.com>
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
[also build test ERROR on drm/drm-next]
[cannot apply to daeinki-drm-exynos/exynos-drm-next linus/master v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damon-Ding/drm-bridge-analogix_dp-Return-bitmask-from-analogix_dp_get_irq_type/20261019-165823
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261019085836.3065008-12-damon.ding%40rock-chips.com
patch subject: [PATCH v4 11/14] drm/bridge: analogix_dp: Use bridge->next_bridge instead of plat_data field
config: parisc-randconfig-1001-20261020 (https://download.01.org/0day-ci/archive/20261020/202610201323.RdqouIbq-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610201323.RdqouIbq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610201323.RdqouIbq-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/bridge/analogix/analogix_dp.ko: symbol 'devm_drm_of_display_mode_bridge' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
