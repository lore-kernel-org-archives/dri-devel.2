Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA688E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DED210F3F4;
	Fri,  3 Apr 2026 08:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FCv3qQtg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E210F10F3F4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775205603; x=1806741603;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qE1aYuqUlE93FXWNkFbP62ja+EW3XA/Ya4PvU2wlXOI=;
 b=FCv3qQtgjVZxPwCcuHf0A3FVtC6jCrnVXTJmR8YEJZCj61hqNvXeCU1d
 cJNhJ4gFEbxFQGbRri/1lSQrs5Dw/SlptXtwIMEWtmBSPT0oKD6aTWGby
 tGbtS9l3K9EWXJ9RhTpzuQ8sbolLqwcz7o08GFOdjkSXoomyYknMG8OOK
 KrHifrbh7EbG50Y1lN3vFL3o5cDGMGeMIOn+nUZZmpNmpOQyA6mtPRoMh
 umBLdwYadOl0QzpqmESAiTk5bFJdMyytYhHlSmBGixlcFNrbRxaKl7INX
 rXvl8fe0tjFYoIgWiMqiEAyAftCVthsnlz/bbYPWXLVbLW7UvFWsVgtwp A==;
X-CSE-ConnectionGUID: 3MqBNP3GSpaH+dKLjsJSAA==
X-CSE-MsgGUID: LnCQk0fiSYCnI0LQlBdZ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76156571"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76156571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 01:40:02 -0700
X-CSE-ConnectionGUID: NcQzPotSTqOM77lF7ZnhxQ==
X-CSE-MsgGUID: bOdGHcWoQYmSAvVkpedJdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="220570309"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 03 Apr 2026 01:39:57 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w8a4H-0000000011Z-3Noi;
 Fri, 03 Apr 2026 08:39:53 +0000
Date: Fri, 3 Apr 2026 16:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 02/12] drm/bridge: tc358762: Improce SYSCTRL register
 defines
Message-ID: <202604021223.FtCNpGqO-lkp@intel.com>
References: <20260327-tc358762-fixes-v2-2-3589d3c45f4a@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-tc358762-fixes-v2-2-3589d3c45f4a@ideasonboard.com>
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

Hi Tomi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomi-Valkeinen/drm-bridge-tc358762-Clean-up-register-defines/20260328-164947
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260327-tc358762-fixes-v2-2-3589d3c45f4a%40ideasonboard.com
patch subject: [PATCH v2 02/12] drm/bridge: tc358762: Improce SYSCTRL register defines
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260402/202604021223.FtCNpGqO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260402/202604021223.FtCNpGqO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604021223.FtCNpGqO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/tc358762.c:154:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     154 |                        FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
         |                        ^
   1 error generated.


vim +/FIELD_PREP +154 drivers/gpu/drm/bridge/tc358762.c

   127	
   128	static int tc358762_init(struct tc358762 *ctx)
   129	{
   130		u32 lcdctrl;
   131	
   132		tc358762_write(ctx, DSI_LANEENABLE,
   133			       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
   134		tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
   135		tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
   136		tc358762_write(ctx, PPI_D0S_ATMR, 0);
   137		tc358762_write(ctx, PPI_D1S_ATMR, 0);
   138		tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
   139	
   140		tc358762_write(ctx, SPICMR, 0x00);
   141	
   142		lcdctrl = LCDCTRL_VSDELAY(1) | LCDCTRL_RGB888 |
   143			  LCDCTRL_UNK6 | LCDCTRL_VTGEN;
   144	
   145		if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
   146			lcdctrl |= LCDCTRL_HSPOL;
   147	
   148		if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
   149			lcdctrl |= LCDCTRL_VSPOL;
   150	
   151		tc358762_write(ctx, LCDCTRL, lcdctrl);
   152	
   153		tc358762_write(ctx, SYSCTRL,
 > 154			       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
   155			       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
   156			       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
   157	
   158		msleep(100);
   159	
   160		tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);
   161		tc358762_write(ctx, DSI_STARTDSI, DSI_STARTDSI_STARTDSI);
   162	
   163		msleep(100);
   164	
   165		return tc358762_clear_error(ctx);
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
