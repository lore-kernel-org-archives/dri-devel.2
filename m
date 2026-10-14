Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA4ACC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878D110FACB;
	Wed, 14 Oct 2026 05:38:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0089210FACB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791956278; x=1823492278;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KLQLSwtwMfdActLLHb1t3B9g7TGrfNXupKshdeRihfw=;
 b=mbpWt4yqbMAbsBa1nF7PjLOu54516I4f5Wz8unpt+S3WvJj+6lGxmK8A
 zayP+nFBMIfjqozBe2S7rpzuBxc0hwLvNifMZw4oNwxFksLoKNWG5A9L8
 Coopx7PqyzPo8QBrgqZ51UucmVvV6TKN8cLWo6bPFiVdGlJoJTuSOiNgi
 BGdReRtXWTdsXv7nmuLB99wNaAuVwrLZYuCicxF9R5I7bFBElrclXL5sF
 BUL+WA5WvEKy9y68LZ9zT3MAa7G13OHM7d7z3LM1qr6uo0SuUHXFKgXwC
 it+KFqXdCOo96QZ2EtfLywyGPspErs0ogYWfXhcigFCtS7iDmS5CzqSUW A==;
X-CSE-ConnectionGUID: C4/OpeBPTF2GBnRjSdIscw==
X-CSE-MsgGUID: mAAuC/MSQsqmVIhhSGXrnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="594169"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="594169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 22:37:57 -0700
X-CSE-ConnectionGUID: hEgQPaK2R9aPLUUnvB+9hQ==
X-CSE-MsgGUID: YQNxwNdZRRSK8mdela4Ucw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1302075"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 13 Oct 2026 22:37:53 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xGrgT-00000000EB8-1TAl;
 Wed, 14 Oct 2026 05:37:49 +0000
Date: Wed, 14 Oct 2026 13:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ho Jie Feng <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, cyrozap@gmail.com,
 Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/trigger5: Add MCT Trigger 5 USB display driver
Message-ID: <202610141333.eWqPGRTA-lkp@intel.com>
References: <20261012131539.67790-1-hjf3108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012131539.67790-1-hjf3108@gmail.com>
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

Hi Ho,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 73df79cceb8c01f311055a61794e229dc81546cb]

url:    https://github.com/intel-lab-lkp/linux/commits/Ho-Jie-Feng/drm-trigger5-Add-MCT-Trigger-5-USB-display-driver/20261012-211537
base:   73df79cceb8c01f311055a61794e229dc81546cb
patch link:    https://lore.kernel.org/r/20261012131539.67790-1-hjf3108%40gmail.com
patch subject: [PATCH v4] drm/trigger5: Add MCT Trigger 5 USB display driver
config: powerpc-randconfig-1000-20261014 (https://download.01.org/0day-ci/archive/20261014/202610141333.eWqPGRTA-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261014/202610141333.eWqPGRTA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610141333.eWqPGRTA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tiny/trigger5.c:550:19: warning: result of comparison of constant 65536 with expression of type 'const u16' (aka 'const unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     550 |             mode->htotal > U16_MAX + 1)
         |             ~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   drivers/gpu/drm/tiny/trigger5.c:555:19: warning: result of comparison of constant 65536 with expression of type 'const u16' (aka 'const unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     555 |             mode->vtotal > U16_MAX + 1)
         |             ~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   2 warnings generated.


vim +550 drivers/gpu/drm/tiny/trigger5.c

   540	
   541	static enum drm_mode_status
   542	trigger5_crtc_mode_valid(struct drm_crtc *crtc,
   543				 const struct drm_display_mode *mode)
   544	{
   545		struct trigger5_pll pll;
   546		u64 err, ppm;
   547	
   548		if (mode->hsync_end <= mode->hsync_start ||
   549		    mode->htotal <= mode->hsync_end ||
 > 550		    mode->htotal > U16_MAX + 1)
   551			return MODE_H_ILLEGAL;
   552	
   553		if (mode->vsync_end <= mode->vsync_start ||
   554		    mode->vtotal <= mode->vsync_end ||
   555		    mode->vtotal > U16_MAX + 1)
   556			return MODE_V_ILLEGAL;
   557	
   558		if (trigger5_mode_buf_len(mode) > TRIGGER5_TRANSFER_BUF_SIZE)
   559			return MODE_MEM;
   560	
   561		err = trigger5_calculate_pll(&pll, mode->clock);
   562		ppm = div64_u64(err * 1000, mode->clock);
   563		if (ppm > 10000)
   564			return MODE_CLOCK_RANGE;
   565	
   566		return MODE_OK;
   567	}
   568	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
