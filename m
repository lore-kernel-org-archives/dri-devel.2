Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8B606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H9HdWJ/j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0868C10E132;
	Sat, 31 Oct 2026 13:05:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939C010E132
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793451918; x=1824987918;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=X048RFPL6FBAYFdYPQEF+MltE6ZmFJe8Xrj4opzqCsQ=;
 b=H9HdWJ/jy1WFT1ponmJ27ExiOxLiv04X3h0XoPW+aVDQnP7LfmvdC10X
 su6CibkNsjb5gkop9yzNLL5cxRf5ZSroVxwTHI6D9wierORsCBIPgyDWV
 j4/sEH47P+SjiqOKYK5blAylFM1c/18fnpjI6xkoBDXTwHnTM39DEMb8f
 AQNtKLno+Y8VFB1AieKIixWMs1t5oXAC1KUQMG+YIV3DOpvWH2bHQeVhB
 5bK8x1KLdinOG1Y8NbgPLxwyMK3gq00GYvxUf67dllVR8PX8CvB3ntCLL
 EsM2JZe6VdnrWeZwdM8RRBMty6Z32JpZDvK2Kyp+Krdo0tH3MUP8Mg3+L Q==;
X-CSE-ConnectionGUID: fLT06HfHQoyhDmrIJx9yoQ==
X-CSE-MsgGUID: Qx1lnMwwQhOwniPaHZkb2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2231348"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2231348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2026 06:05:17 -0700
X-CSE-ConnectionGUID: jA2056AJRn+XlAMKTsIClA==
X-CSE-MsgGUID: 9p1YMogzTweMiRmjFcGZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="6049157"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 31 Oct 2026 06:05:13 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xN8li-00000000cqG-3vSm;
 Sat, 31 Oct 2026 13:05:10 +0000
Date: Sat, 31 Oct 2026 21:04:17 +0800
From: kernel test robot <lkp@intel.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH RESEND 3/3] drm/verisilicon: stop to reuse atomic_disable
 for invisible planes
Message-ID: <202610312040.VpGybfak-lkp@intel.com>
References: <20261030133233.197189-4-zhengxingda@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030133233.197189-4-zhengxingda@iscas.ac.cn>
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

Hi Icenowy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Icenowy-Zheng/drm-verisilicon-fix-DC8200-primary-plane-disable-clearing-FB_EN/20261030-213231
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261030133233.197189-4-zhengxingda%40iscas.ac.cn
patch subject: [PATCH RESEND 3/3] drm/verisilicon: stop to reuse atomic_disable for invisible planes
config: arm64-randconfig-1001-20261031 (https://download.01.org/0day-ci/archive/20261031/202610312040.VpGybfak-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project c2ea4440d4b64c148de4fdfca1fc2c437a0701e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610312040.VpGybfak-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610312040.VpGybfak-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/verisilicon/vs_primary_plane.c:117:28: warning: variable 'dc' is uninitialized when used here [-Wuninitialized]
     117 |                 vs_primary_plane_disable(dc, output);
         |                                          ^~
   drivers/gpu/drm/verisilicon/vs_primary_plane.c:111:18: note: initialize the variable 'dc' to silence this warning
     111 |         struct vs_dc *dc;
         |                         ^
         |                          = NULL
>> drivers/gpu/drm/verisilicon/vs_primary_plane.c:117:32: warning: variable 'output' is uninitialized when used here [-Wuninitialized]
     117 |                 vs_primary_plane_disable(dc, output);
         |                                              ^~~~~~
   drivers/gpu/drm/verisilicon/vs_primary_plane.c:113:21: note: initialize the variable 'output' to silence this warning
     113 |         unsigned int output;
         |                            ^
         |                             = 0
   2 warnings generated.
--
>> drivers/gpu/drm/verisilicon/vs_cursor_plane.c:154:27: warning: variable 'dc' is uninitialized when used here [-Wuninitialized]
     154 |                 vs_cursor_plane_disable(dc, output);
         |                                         ^~
   drivers/gpu/drm/verisilicon/vs_cursor_plane.c:148:18: note: initialize the variable 'dc' to silence this warning
     148 |         struct vs_dc *dc;
         |                         ^
         |                          = NULL
>> drivers/gpu/drm/verisilicon/vs_cursor_plane.c:154:31: warning: variable 'output' is uninitialized when used here [-Wuninitialized]
     154 |                 vs_cursor_plane_disable(dc, output);
         |                                             ^~~~~~
   drivers/gpu/drm/verisilicon/vs_cursor_plane.c:150:21: note: initialize the variable 'output' to silence this warning
     150 |         unsigned int output;
         |                            ^
         |                             = 0
   2 warnings generated.


vim +/dc +117 drivers/gpu/drm/verisilicon/vs_primary_plane.c

   102	
   103	static void vs_primary_plane_atomic_update(struct drm_plane *plane,
   104						   struct drm_atomic_commit *atomic_state)
   105	{
   106		struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
   107									       plane);
   108		struct vs_plane_state *vs_state = to_vs_plane_state(state);
   109		struct drm_framebuffer *fb = state->fb;
   110		struct drm_crtc *crtc = state->crtc;
   111		struct vs_dc *dc;
   112		struct vs_crtc *vcrtc;
   113		unsigned int output;
   114		dma_addr_t dma_addr;
   115	
   116		if (!state->visible) {
 > 117			vs_primary_plane_disable(dc, output);
   118			return;
   119		}
   120	
   121		vcrtc = drm_crtc_to_vs_crtc(crtc);
   122		output = vcrtc->id;
   123		dc = vcrtc->dc;
   124	
   125		regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
   126				   VSDC_FB_CONFIG_FMT_MASK,
   127				   VSDC_FB_CONFIG_FMT(vs_state->format.color));
   128		regmap_update_bits(dc->regs, VSDC_FB_CONFIG(output),
   129				   VSDC_FB_CONFIG_SWIZZLE_MASK,
   130				   VSDC_FB_CONFIG_SWIZZLE(vs_state->format.swizzle));
   131		regmap_assign_bits(dc->regs, VSDC_FB_CONFIG(output),
   132				   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
   133				   vs_state->format.uv_swizzle);
   134	
   135		/*
   136		 * Primary plane cannot be moved, no clipping is involved,
   137		 * so the non-clipped framebuffer address can be used.
   138		 */
   139		dma_addr = drm_fb_dma_get_gem_addr(fb, state, 0);
   140	
   141		regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
   142			     lower_32_bits(dma_addr));
   143		regmap_write(dc->regs, VSDC_FB_STRIDE(output),
   144			     fb->pitches[0]);
   145	
   146		regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
   147			     VSDC_MAKE_PLANE_POS(state->crtc_x, state->crtc_y));
   148		regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
   149			     VSDC_MAKE_PLANE_POS(state->crtc_x + state->crtc_w,
   150						 state->crtc_y + state->crtc_h));
   151		regmap_write(dc->regs, VSDC_FB_SIZE(output),
   152			     VSDC_MAKE_PLANE_SIZE(state->crtc_w, state->crtc_h));
   153	
   154		regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
   155			     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
   156	
   157		vs_primary_plane_commit(dc, output);
   158	}
   159	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
