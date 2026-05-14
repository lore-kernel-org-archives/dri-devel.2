Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B81CD4F21
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 00:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDAB10F0F4;
	Thu, 14 May 2026 00:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LDEltaer";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293B710F0F0;
 Thu, 14 May 2026 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778720217; x=1810256217;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vyu57ovXPjleRJ4YGZDfKQBeE3LjznYEnTFJmwS3NkA=;
 b=LDEltaer7gtxMnMWal+L5LbgJz2lYSeW0kCkVm3AuAysbqDMg6koG1cM
 1hORC2ut/WnR59YZqVJEgDgodDa3hSxCsD7cCEp7tLyNMn3lJmXvDGghS
 t3bH2OmkXjIwv4La3qoNALHC+P6r3zB36nFoU3ao7qx8vt4BIaLDU0dB8
 pV+4s2NiG5LORzBEoqjZbOPkHXswbwJXxR9teARH/PcpjdBpnsEhaJjTc
 /psTyP5VTlBHxv+NYJ/H104YaQT3ngW+DOcmetHQH5H4M9Dk+Xqxh1fyC
 2GW5gsWdpK2gN3rlAH9/Ilr3E3DNyKZLohhsZ2lQ2K2PFKUes2SBxS1LI g==;
X-CSE-ConnectionGUID: R4+2DsDFRZGlRDeOtop1vw==
X-CSE-MsgGUID: JXthNee2TreYBEAL1a+4Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83507947"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; d="scan'208";a="83507947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 17:56:56 -0700
X-CSE-ConnectionGUID: IB6DiO87RHO8nISzs2kFBg==
X-CSE-MsgGUID: Y7bWg4vrTXaryqD/8ip2/Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 13 May 2026 17:56:52 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wNKNd-000000005S3-0imQ;
 Thu, 14 May 2026 00:56:49 +0000
Date: Thu, 14 May 2026 08:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <202605140848.SHAmSWp0-lkp@intel.com>
References: <20260512-panthor-shrinker-fixes-v3-1-3bf066259471@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-panthor-shrinker-fixes-v3-1-3bf066259471@collabora.com>
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

Hi Boris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b2ed01e7ad3de80333e9b962a44024b094bc0b2b]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Brezillon/drm-gem-Make-the-GEM-LRU-lock-part-of-drm_device/20260514-051749
base:   b2ed01e7ad3de80333e9b962a44024b094bc0b2b
patch link:    https://lore.kernel.org/r/20260512-panthor-shrinker-fixes-v3-1-3bf066259471%40collabora.com
patch subject: [PATCH v3] drm/gem: Make the GEM LRU lock part of drm_device
config: csky-randconfig-r071-20260514 (https://download.01.org/0day-ci/archive/20260514/202605140848.SHAmSWp0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605140848.SHAmSWp0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605140848.SHAmSWp0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/gpu/drm/drm_gem.c:1643 function parameter 'dev' not described in 'drm_gem_lru_scan'
>> Warning: drivers/gpu/drm/drm_gem.c:1643 function parameter 'dev' not described in 'drm_gem_lru_scan'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
