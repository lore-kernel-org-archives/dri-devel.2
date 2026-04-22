Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD43F9B5FE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517C010E9C2;
	Wed, 22 Apr 2026 09:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ndXRCiFF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C15D010E9C2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776850708; x=1808386708;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zaC+o3hHTDa7/hz7nLBobboom0XVJ935Z1rRDvGJyDE=;
 b=ndXRCiFFqS9fhH4J6d9zNvmmizSg7qL2OivmIlW9AEFvDL2ZTwWH7453
 ckEacYrQEqp8+QZZzj9ndT72eQXS+ysMS7PwJPveSl51Ib/XK+/w+QXBm
 SuozdVQZNfpjYU1iMpag1WTojraV9KzH84VjRt2ua6KRrgMcEpK/C8bsg
 yP5D2lVjODiVl0cBSJ0SvrAWxCFd3feZc1RTfdRo5CGpX09xJNw90I/ux
 icdNvbcGYTU8E4FSKK4uWI0NPSbL/dwqM8lI3s/2/bTwbs99dMatgfcQr
 rF18l5NFVuq3PQ1crwjfNGbP8dSKu5AfG9tEWtVnli1AOF+5Fwso87Anv g==;
X-CSE-ConnectionGUID: rVN5bLdYR0W3/7m57dolrw==
X-CSE-MsgGUID: 5IVlXAdMS+K2Gus7uYHIdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65335596"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="65335596"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:38:27 -0700
X-CSE-ConnectionGUID: CRvZqfYTSRK4FnY9Y9JEpg==
X-CSE-MsgGUID: 4JzoVTKER2SAcm2xuYB1jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="231417451"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
 by orviesa010.jf.intel.com with ESMTP; 22 Apr 2026 02:38:22 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wFU2B-000000000Nx-1ubz;
 Wed, 22 Apr 2026 09:38:15 +0000
Date: Wed, 22 Apr 2026 17:37:29 +0800
From: kernel test robot <lkp@intel.com>
To: Biju <biju.das.au@gmail.com>, Liu Ying <victor.liu@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it6263: Add basic resume support
Message-ID: <202604221736.zHLIEw3V-lkp@intel.com>
References: <20260415113954.179006-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415113954.179006-1-biju.das.jz@bp.renesas.com>
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

Hi Biju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.0 next-20260421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju/drm-bridge-ite-it6263-Add-basic-resume-support/20260421-073706
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260415113954.179006-1-biju.das.jz%40bp.renesas.com
patch subject: [PATCH] drm/bridge: ite-it6263: Add basic resume support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260422/202604221736.zHLIEw3V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260422/202604221736.zHLIEw3V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604221736.zHLIEw3V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/ite-it6263.c:909:12: warning: 'it6263_resume' defined but not used [-Wunused-function]
     909 | static int it6263_resume(struct device *dev)
         |            ^~~~~~~~~~~~~


vim +/it6263_resume +909 drivers/gpu/drm/bridge/ite-it6263.c

   908	
 > 909	static int it6263_resume(struct device *dev)
   910	{
   911		struct it6263 *it = dev_get_drvdata(dev);
   912		int ret;
   913	
   914		ret = it6263_lvds_set_i2c_addr(it);
   915		if (ret)
   916			return ret;
   917	
   918		it6263_lvds_config(it);
   919	
   920		return 0;
   921	}
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
