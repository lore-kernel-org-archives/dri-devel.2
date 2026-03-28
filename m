Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5849910ED67B
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 14:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFEE10E0AD;
	Sat, 28 Mar 2026 14:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NBEufRl2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B1D10E0AD
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774709564; x=1806245564;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Di17zwN0Sm7uYjGVksCdE9bLHhI6vS1pfX/DA+RrmbU=;
 b=NBEufRl2pS4NDJ/+Fk9uehVjEF8bx6mAAIuM4PMDMJBfGDVVw3ytlG2o
 HzWiuDhwd/AUoaRENxw0+fiEJdrTjyNgpz6lcDlOkFqg+a/ENUST4sJ0/
 yaU1e/vY5tfnHuqGGfmfuHqPg+FQEp12rhftd9wfV1M6r7ZveJwl4QSZz
 WMseRDTo5x/9pvJHk2o189nuwFFKAQbwq1qsPXKSooDLL5mXjcXW/VEme
 ezkCAgf4N9SLcyNvKqSBv3iR4niVBenDdAOSEvW5oY+9sXmMoCMZXQD3m
 dlW0lm7GA92LrAC+EbrzTfWqIrIfACF0bRiVoaU6VdAsiCxU9Yep5ewvf w==;
X-CSE-ConnectionGUID: mZg6OOYuQB+lxt2Tm00h1Q==
X-CSE-MsgGUID: ANMuM0pYT0W1ugft0pKn4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86453615"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="86453615"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2026 07:52:43 -0700
X-CSE-ConnectionGUID: /v9fj2iUR06nl6/nyFoVtQ==
X-CSE-MsgGUID: F2NZwqAiSkCH73MKxMdGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; d="scan'208";a="225589029"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 28 Mar 2026 07:52:37 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w6V1d-00000000BVB-0Wia;
 Sat, 28 Mar 2026 14:52:33 +0000
Date: Sat, 28 Mar 2026 22:52:15 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Janne Grunau <j@jannau.net>, Liviu Dudau <liviu.dudau@arm.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v3 3/3] drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag
Message-ID: <202603282230.Yz4kBrTt-lkp@intel.com>
References: <20260326100248.1171828-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326100248.1171828-4-wenst@chromium.org>
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

Hi Chen-Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on next-20260327]
[cannot apply to sunxi/sunxi/for-next linus/master v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/drm-Introduce-DRM_MODE_DUMB_KERNEL_MAP-flag/20260328-141115
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260326100248.1171828-4-wenst%40chromium.org
patch subject: [PATCH v3 3/3] drm/gem-dma: Support DRM_MODE_DUMB_KERNEL_MAP flag
config: arm-randconfig-001-20260328 (https://download.01.org/0day-ci/archive/20260328/202603282230.Yz4kBrTt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260328/202603282230.Yz4kBrTt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603282230.Yz4kBrTt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/stm/drv.c: In function 'stm_gem_dma_dumb_create':
>> drivers/gpu/drm/stm/drv.c:55:23: error: 'DRM_MODE_DUMB_KERNEL_MAP' undeclared (first use in this function)
      55 |         args->flags = DRM_MODE_DUMB_KERNEL_MAP;
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/stm/drv.c:55:23: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/gpu/drm/arm/malidp_drv.c: In function 'malidp_dumb_create':
>> drivers/gpu/drm/arm/malidp_drv.c:467:23: error: 'DRM_MODE_DUMB_KERNEL_MAP' undeclared (first use in this function)
     467 |         args->flags = DRM_MODE_DUMB_KERNEL_MAP;
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/arm/malidp_drv.c:467:23: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/gpu/drm/arm/display/komeda/komeda_kms.c: In function 'komeda_gem_dma_dumb_create':
>> drivers/gpu/drm/arm/display/komeda/komeda_kms.c:32:23: error: 'DRM_MODE_DUMB_KERNEL_MAP' undeclared (first use in this function)
      32 |         args->flags = DRM_MODE_DUMB_KERNEL_MAP;
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/arm/display/komeda/komeda_kms.c:32:23: note: each undeclared identifier is reported only once for each function it appears in


vim +/DRM_MODE_DUMB_KERNEL_MAP +55 drivers/gpu/drm/stm/drv.c

    43	
    44	static int stm_gem_dma_dumb_create(struct drm_file *file,
    45					   struct drm_device *dev,
    46					   struct drm_mode_create_dumb *args)
    47	{
    48		unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
    49	
    50		/*
    51		 * in order to optimize data transfer, pitch is aligned on
    52		 * 128 bytes, height is aligned on 4 bytes
    53		 */
    54		args->height = roundup(args->height, 4);
  > 55		args->flags = DRM_MODE_DUMB_KERNEL_MAP;
    56		args->pitch = roundup(min_pitch, 128);
    57	
    58		return drm_gem_dma_dumb_create_internal(file, dev, args);
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
