Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A777CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97FF10E009;
	Wed, 29 Apr 2026 19:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QJfJTrkG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA63810E009
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 19:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777490265; x=1809026265;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NdpsqONRcUyfFA6AEfEks0J8pgr3wqXMW8S2nukC6KA=;
 b=QJfJTrkGN1o9vqsEgW/RizyZklWxGINInpleazYe91q1IbA8Li6eduA5
 K5iw1uajM/8HQdDe0DjUUSeHTC39dQ8K36qhpJqmu/So1B47b9yXFJCYq
 AtzU3JCYVhpm4EOjRcfK9GKGpWXpTRXenEF1dQalbPX6JM+ci2xSadeOK
 3lbLKEGU3rIAwKwKwqL1caNmG4ewXsNf0gnA+VVyO4TBvtXfKcjBBIx7P
 bXuxNKIkC8caNXbJkU/tWs9yoHG34U6bKothSKBwCPwKwbOypFj2Sr/QI
 nzVjnL2qDsZoVmG0ZlcAJhPHGjiv9CcF8Adh+FNqGmJq2naK2uYeVVioL w==;
X-CSE-ConnectionGUID: c6Y64/DCS9ecD1DQAOiOdg==
X-CSE-MsgGUID: CBshppDcRKGCrT2Uf+CNCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88740402"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88740402"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 12:17:44 -0700
X-CSE-ConnectionGUID: aK74WFK+QzebuweuuQA/3A==
X-CSE-MsgGUID: 6yJPyYGCSE6P+PZJKdWO/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="238684543"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 29 Apr 2026 12:17:42 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wIAPi-00000000BRk-2oCL;
 Wed, 29 Apr 2026 19:17:38 +0000
Date: Thu, 30 Apr 2026 03:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?B?67CV66qF7ZuI?= <mhun512@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Myeonghun Pak <mhun512@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] drm/panel: tdo-tl070wsh30: Use devm_drm_panel_add()
Message-ID: <202604300328.1HVE9S0R-lkp@intel.com>
References: <20260428131855.3501-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428131855.3501-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
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

Hi 박명훈,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.1-rc1 next-20260428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/drm-panel-tdo-tl070wsh30-Use-devm_drm_panel_add/20260428-215942
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260428131855.3501-1-pakmyeonghun%40bagmyeonghun-ui-MacBookPro.local
patch subject: [PATCH] drm/panel: tdo-tl070wsh30: Use devm_drm_panel_add()
config: nios2-randconfig-001-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300328.1HVE9S0R-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300328.1HVE9S0R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300328.1HVE9S0R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c: In function 'tdo_tl070wsh30_panel_remove':
>> drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c:201:38: warning: unused variable 'tdo_tl070wsh30' [-Wunused-variable]
     201 |         struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
         |                                      ^~~~~~~~~~~~~~


vim +/tdo_tl070wsh30 +201 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c

cf40c66005920a Neil Armstrong   2020-09-15  198  
79abca2b399009 Uwe Kleine-König 2022-07-08  199  static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
cf40c66005920a Neil Armstrong   2020-09-15  200  {
cf40c66005920a Neil Armstrong   2020-09-15 @201  	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
cf40c66005920a Neil Armstrong   2020-09-15  202  	int err;
cf40c66005920a Neil Armstrong   2020-09-15  203  
cf40c66005920a Neil Armstrong   2020-09-15  204  	err = mipi_dsi_detach(dsi);
cf40c66005920a Neil Armstrong   2020-09-15  205  	if (err < 0)
cf40c66005920a Neil Armstrong   2020-09-15  206  		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
cf40c66005920a Neil Armstrong   2020-09-15  207  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
