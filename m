Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C2C88E53
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 00:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305FD10E7A3;
	Sun, 13 Sep 2026 00:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ou5gAjfB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E519C10E7A1;
 Sun, 13 Sep 2026 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789257978; x=1820793978;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZLnw49gKs05+08T6u7Y6BTWTd4oIBSYI6qdEDF3gZLI=;
 b=Ou5gAjfBQ3qyN2DHwZnXLP633M81aLAJeSiWIdYxBNqhg6ljBxHjzVrm
 b+sjndwGQF3pb6rrBzh25rMRrS7achN6H9Mt8sQCEo8eObJbUhgrUNje9
 9Zh6tVkw1UdbWFbWw5sfWTBbYf+t0+/cDx/MHCX9QPY3usGKdxQ0JdHCF
 ZzY3IsW0vbJU4yRP9rW+lro+yFsiOC7MNK8Kv4qj6YVzi8GRsIsUPEtZA
 X87Zt+FkThTK8XxoO9VHpvl261n2v6FEpTiQ2dTxbCLUkuZzAa3AjWyY0
 XXxvd9VcGiEVRJ6vVCjeAgxyrVG0+Imu6gxKB3rxwrpNTUAO8SVzfZV6i A==;
X-CSE-ConnectionGUID: cm2x+prnQF68Lh4hhUbz8A==
X-CSE-MsgGUID: zjJ8ggeRRBeGxRuvsfBoIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="88815043"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="88815043"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2026 17:06:17 -0700
X-CSE-ConnectionGUID: nDhxSNVAQCSC7ntaZgHpww==
X-CSE-MsgGUID: Pg2fjvf0SUWFcgbAHBgKTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; d="scan'208";a="271782991"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
 by orviesa008.jf.intel.com with ESMTP; 12 Sep 2026 17:06:14 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x5XjX-000000003Rv-0N8k;
 Sun, 13 Sep 2026 00:06:11 +0000
Date: Sun, 13 Sep 2026 08:05:35 +0800
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
Message-ID: <202609130700.PDgnlEpm-lkp@intel.com>
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
config: arm64-randconfig-r133-20260912 (https://download.01.org/0day-ci/archive/20260913/202609130700.PDgnlEpm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260913/202609130700.PDgnlEpm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609130700.PDgnlEpm-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/gpu/drm/msm/msm_drv.o: in function `msm_separate_gpu_kms_components':
>> msm_drv.c:(.text+0x1938): undefined reference to `msm_count_mdp4'
>> aarch64-linux-ld: msm_drv.c:(.text+0x1940): undefined reference to `msm_count_mdp5'
>> aarch64-linux-ld: msm_drv.c:(.text+0x1978): undefined reference to `msm_count_mdp4'
   aarch64-linux-ld: msm_drv.c:(.text+0x197c): undefined reference to `msm_count_mdp5'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
