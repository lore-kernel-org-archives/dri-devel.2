Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CCAC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559E610E055;
	Sat, 12 Sep 2026 21:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JSp9KBjx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8717B10E055;
 Sat, 12 Sep 2026 21:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789246893; x=1820782893;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7ZQN5wP2Tr32dcu0+4sTe/s8OVZZ03PGEAKVgDQMBHA=;
 b=JSp9KBjxv++tgVFm24EQEqp8I0dGrh1gnIXPVhHeY0ZLiBrs3624NzU6
 53tPSZMtGoV9aVc+HVT6p6hqh6ebdLKKfEWwMmX8jsofjJDw+aQoHDdiL
 4+M8A/CfulDS1ss59OvLDerWjmTtla/0b8z6DYOGjtQ6+8JWaiaofaQZd
 Dz35bummjhFxeWgbJOszdIvfUkkbkQ72c2ur0RJtMi7LRcB5ta+G1lgfO
 +eXJxpzoaPLpcHycfbWkevX3qj7uuxVSne/hlUwWnyFFsd+scGGJqxUH7
 mYs0TytTf+nDpdd/dlOmgOmibBzuOP5Qm5SMcGQsNfpqp8NZvR8UiSgQf A==;
X-CSE-ConnectionGUID: esZDTXeqSwizxVbDjXcx4w==
X-CSE-MsgGUID: mH/51zhXSq+H/c3hjOsOdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="99999226"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="99999226"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2026 14:01:32 -0700
X-CSE-ConnectionGUID: y1H8xjhfSQSHK8+6BQQbZg==
X-CSE-MsgGUID: CsWxyjvLSNu+9+6D8lV6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="489175"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by fmviesa012.fm.intel.com with ESMTP; 12 Sep 2026 14:01:29 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x5UqA-000000003Ff-3jZR;
 Sat, 12 Sep 2026 21:00:55 +0000
Date: Sun, 13 Sep 2026 05:00:04 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3] drm/msm: default separate_gpu_kms to auto
 selection
Message-ID: <202609130459.lk2sYtiT-lkp@intel.com>
References: <20260909-separate_gpu_kms-v3-1-eae64dfbb635@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-separate_gpu_kms-v3-1-eae64dfbb635@oss.qualcomm.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Mahadevan-P/drm-msm-default-separate_gpu_kms-to-auto-selection/20260909-191834
base:   b84a0ebe421ca56995ff78b66307667b62b3a900
patch link:    https://lore.kernel.org/r/20260909-separate_gpu_kms-v3-1-eae64dfbb635%40oss.qualcomm.com
patch subject: [PATCH RESEND v3] drm/msm: default separate_gpu_kms to auto selection
config: powerpc-randconfig-001-20260912 (https://download.01.org/0day-ci/archive/20260913/202609130459.lk2sYtiT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260913/202609130459.lk2sYtiT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609130459.lk2sYtiT-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "msm_count_mdp5" [drivers/gpu/drm/msm/msm.ko] undefined!
>> ERROR: modpost: "msm_count_mdss" [drivers/gpu/drm/msm/msm.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
