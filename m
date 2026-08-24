Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEACC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F76B10E02D;
	Mon, 24 Aug 2026 20:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KHf3GXfc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3342910E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787603663; x=1819139663;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2MrkHVT10I+ikXQqQrjMRHXvIvGgZfTC4WyLFmPpgsE=;
 b=KHf3GXfcHiLk9Cm1QXVLIedVUAUS6aLL4ojjEte4OB3OWP+hLPWXLCyM
 RVYNEaJg8gNdiliI09F4GHay5HUrba1oFHSNcoxl6jthapkfU+qWTaTSj
 JHhsQiPuyAhRhB+uKCqXpMVN/QqQm8A8gUWvkMO883C2SDv6/kgxnsJi4
 V6GqxxlLiCljS2U9UfbRJCX5JHnewfdwZ/+t2bKh2gNUfxTYcTIW0dbhO
 IjEYu98dwhi0VekACW/5DwWSmVYKa3HE4EwnVmWUoCEzyf+Pjk30FYW3V
 MmlGbXKr1ch6iSlfXPDDsE38Gh22pfJRvX09tQAJLpVHzoaumtRaHVqVN w==;
X-CSE-ConnectionGUID: rpWMnji/Rry1oJfpAOEU3w==
X-CSE-MsgGUID: 1RWjHhGGSLugsXQYhZNMFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88080375"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="88080375"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 13:34:22 -0700
X-CSE-ConnectionGUID: zJbr1P3hRuaBtCHtXYXuNg==
X-CSE-MsgGUID: +2KsQ0I8QACC9QeIeu7urA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="266574027"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 24 Aug 2026 13:34:19 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wybMv-0000000044t-27oL;
 Mon, 24 Aug 2026 20:34:11 +0000
Date: Tue, 25 Aug 2026 04:33:37 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Igor Paunovic <royalnet026@gmail.com>,
 Alexey Charkov <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] drm/connector: Cache out-of-band hotplug events
Message-ID: <202608250407.a5fV5DFE-lkp@intel.com>
References: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b@collabora.com>
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

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d3d1e0c4343385fb343a552e4f3b6b97d5762fc2]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/drm-connector-Cache-out-of-band-hotplug-events/20260821-165525
base:   d3d1e0c4343385fb343a552e4f3b6b97d5762fc2
patch link:    https://lore.kernel.org/r/20260821-drm-connector-oob-hotplug-cache-v1-1-e92e146fdc7b%40collabora.com
patch subject: [PATCH] drm/connector: Cache out-of-band hotplug events
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260825/202608250407.a5fV5DFE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250407.a5fV5DFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250407.a5fV5DFE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_connector.c:3750 function parameter 'fwnode' not described in 'drm_connector_record_oob_hotplug_status'
>> Warning: drivers/gpu/drm/drm_connector.c:3750 function parameter 'status' not described in 'drm_connector_record_oob_hotplug_status'
>> Warning: drivers/gpu/drm/drm_connector.c:3750 function parameter 'fwnode' not described in 'drm_connector_record_oob_hotplug_status'
>> Warning: drivers/gpu/drm/drm_connector.c:3750 function parameter 'status' not described in 'drm_connector_record_oob_hotplug_status'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
