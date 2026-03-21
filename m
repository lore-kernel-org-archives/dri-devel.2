Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE881099B5C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 02:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C67810E20F;
	Sat, 21 Mar 2026 02:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KEDrpmRY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7435010E20F;
 Sat, 21 Mar 2026 02:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774059968; x=1805595968;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eG5LkS+9cCOeVxm20ZTUca9k3IWxWt9/hMQ4+PWUen0=;
 b=KEDrpmRYGnk47KmvBP+RxVPHu3tVA4jTkIMyhTIdBT2l5Vh92KAyOUuZ
 O+oxolBEIYLvOT55uXJ8JT88qs4X2RaQb2zmJH/Jl1cOXNJCecME1MgN6
 YPcObsj14GsutF82tCjYzX+SvHXpBGpEagl9FSUVeZa4Ck8qr43xgbQZt
 qDxZayKELlE4hQG4BzDN9uRZKnOZHwCauOvhWVp3TMwwC52Bo2CF3dikk
 pVNzfpgMo9EWEzIRaocDxgIn6ABruxy2ckULcIZLE70K0d3fOydsgVrBd
 r1k5lQ8C2a0iSITFXnN+pvzJHQMzWcVco9yCZi5J2z3SxXYI6fkwRpInZ Q==;
X-CSE-ConnectionGUID: 1k9S7t9NT3GOhSAUf2Jl+A==
X-CSE-MsgGUID: 0VH5qJGUT5ywFn+0/5yK3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86513220"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; d="scan'208";a="86513220"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 19:26:08 -0700
X-CSE-ConnectionGUID: o0WWiGR5QOOQvsToiLyxHg==
X-CSE-MsgGUID: wLO7713QQmCTMFZ6fN/fgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; d="scan'208";a="223679709"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2026 19:26:04 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w3m2C-000000000CD-0ohq;
 Sat, 21 Mar 2026 02:25:53 +0000
Date: Sat, 21 Mar 2026 10:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm: default separate_gpu_kms to auto selection
Message-ID: <202603211049.NkgQVReV-lkp@intel.com>
References: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-separate_gpu_kms-v2-1-b027ca97b9fe@oss.qualcomm.com>
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

Hi Mahadevan,

kernel test robot noticed the following build errors:

[auto build test ERROR on b84a0ebe421ca56995ff78b66307667b62b3a900]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahadevan-P/drm-msm-default-separate_gpu_kms-to-auto-selection/20260318-063854
base:   b84a0ebe421ca56995ff78b66307667b62b3a900
patch link:    https://lore.kernel.org/r/20260317-separate_gpu_kms-v2-1-b027ca97b9fe%40oss.qualcomm.com
patch subject: [PATCH v2] drm/msm: default separate_gpu_kms to auto selection
config: loongarch-randconfig-002-20260321 (https://download.01.org/0day-ci/archive/20260321/202603211049.NkgQVReV-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211049.NkgQVReV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211049.NkgQVReV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "msm_mdss_count_masters" [drivers/gpu/drm/msm/msm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
