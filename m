Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41666C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8188210F085;
	Thu, 17 Sep 2026 20:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y/O9H4/J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B46510F085
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789677013; x=1821213013;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O4E/r/TO4Ia/0BjZxJmv84fyinvl9/+1ynT1NWdhvas=;
 b=Y/O9H4/JvHtY233JWEPekKTQrT47IzeBjH2m2xL0I4gZeAarqOYsKruj
 tW2acy7rx8ifiOxI+LWOxmoAhsaTsJZTI/bGoUaZMcMtaqd6omlCUGdRS
 8GVKrupUQ0JcC5hzhrTG8IebXj7LS33kOPzxKft7/Z9GHiCDnlw8xvWzs
 6IpIHgnWvvo2ZMgWjbhcrkdyXeORb5QdOx02gBmp9dZZRW8P05r4kJu1B
 cEAfnN/AsbYafHz5OKofO91wUxW7MGBVZfJg9YqsgGIxci8SMwIvvc07f
 gmAokr81FsUUug0dyCkw9JJTU/NbjdqF8KXC3qKfPFFhmUWSUlPFTuybD g==;
X-CSE-ConnectionGUID: KE2oUUt0QPuOimJYsug3Cw==
X-CSE-MsgGUID: zvCzULHYRomQMEsOGr/h8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90007927"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90007927"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 13:30:12 -0700
X-CSE-ConnectionGUID: dSxZsrCVRm6JjrCxhaBwiw==
X-CSE-MsgGUID: LwfJGjC0QIGxUw/0hFem2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="267777446"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 13:30:08 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7Ik9-000000008TJ-42b7;
 Thu, 17 Sep 2026 20:30:05 +0000
Date: Fri, 18 Sep 2026 04:29:06 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, samuel@sholland.org, simona@ffwll.ch,
 tzimmermann@suse.de, wens@kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Fix pdev reference leak in
 sun8i_r40_tcon_tv_set_mux()
Message-ID: <202609180443.vTkwAZL6-lkp@intel.com>
References: <20260916182412.2091681-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182412.2091681-1-vulab@iscas.ac.cn>
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

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-sun4i-Fix-pdev-reference-leak-in-sun8i_r40_tcon_tv_set_mux/20260916-182412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20260916182412.2091681-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/sun4i: Fix pdev reference leak in sun8i_r40_tcon_tv_set_mux()
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260918/202609180443.vTkwAZL6-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 7252edd9aa82ef1c570ff6694ef7f4763a8a5d2f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609180443.vTkwAZL6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609180443.vTkwAZL6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/sun4i/sun4i_tcon.c:811:14: error: use of undeclared identifier 'pdev'; did you mean 'dev'?
     811 |         put_device(&pdev->dev);
         |                     ^~~~
         |                     dev
   drivers/gpu/drm/sun4i/sun4i_tcon.c:786:50: note: 'dev' declared here
     786 | static int sun4i_tcon_init_clocks(struct device *dev,
         |                                                  ^
>> drivers/gpu/drm/sun4i/sun4i_tcon.c:811:20: error: no member named 'dev' in 'struct device'
     811 |         put_device(&pdev->dev);
         |                     ~~~~  ^
   2 errors generated.


vim +811 drivers/gpu/drm/sun4i/sun4i_tcon.c

   785	
   786	static int sun4i_tcon_init_clocks(struct device *dev,
   787					  struct sun4i_tcon *tcon)
   788	{
   789		tcon->clk = devm_clk_get_enabled(dev, "ahb");
   790		if (IS_ERR(tcon->clk)) {
   791			dev_err(dev, "Couldn't get the TCON bus clock\n");
   792			return PTR_ERR(tcon->clk);
   793		}
   794	
   795		if (tcon->quirks->has_channel_0) {
   796			tcon->sclk0 = devm_clk_get_enabled(dev, "tcon-ch0");
   797			if (IS_ERR(tcon->sclk0)) {
   798				dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
   799				return PTR_ERR(tcon->sclk0);
   800			}
   801		}
   802	
   803		if (tcon->quirks->has_channel_1) {
   804			tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
   805			if (IS_ERR(tcon->sclk1)) {
   806				dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
   807				return PTR_ERR(tcon->sclk1);
   808			}
   809		}
   810	
 > 811		put_device(&pdev->dev);
   812	
   813		return 0;
   814	}
   815	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
