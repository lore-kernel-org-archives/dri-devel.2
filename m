Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58560606A325
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PEQMfmJ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8370810E6E0;
	Fri, 30 Oct 2026 15:25:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E6310E254;
 Fri, 30 Oct 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793373929; x=1824909929;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sPmRebhi39B1GLuucQ7j9mUgxJfeUGZv2Q2/PJX0BEc=;
 b=PEQMfmJ83dfkP0184gsLQUlf6NAg36Q3zY5+vgDVdcIw1ay1su6x7Sij
 vPZLBLNSUZPq7+gTtcmeBwAHuCJXmDtyG+Vp1cDVqsU+x6uUs7mEI1jKh
 47h99vN9a5f/SdD/gpIFOYCeCRgoz5rb1rgrs2hYdYSME8OPpEK/Qk2nU
 mfHVTuukacZUSHxct4yelEx/akanezG44gW+rf8740tO38yL8t8UYED86
 lxC268s6pI1N6ebnPrYzynb3RsBEutLcnA2AE7DPP15UcssUV1L5smY0D
 cnjR/Re4zXYL5Hnviz5MSjfnTeLePlVW1316jQ2gA/JK9Lb7E5QjLCkMe A==;
X-CSE-ConnectionGUID: qKtg8ZB6T9iwqnlkvujRPw==
X-CSE-MsgGUID: kTBeiIH0Q7izv6dgiq6dKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2053006"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2053006"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 08:25:29 -0700
X-CSE-ConnectionGUID: MDuDD1URQEWjvNZCZllP+g==
X-CSE-MsgGUID: Q5pIwnPGS1you6hQSWVD1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5475048"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2026 08:25:26 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMoTq-00000000bu0-2c8j;
 Fri, 30 Oct 2026 15:25:22 +0000
Date: Fri, 30 Oct 2026 23:24:25 +0800
From: kernel test robot <lkp@intel.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm: preemption aware hangcheck
Message-ID: <202610302317.4PKDvDwV-lkp@intel.com>
References: <20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com>
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

Hi Anna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d024361c631b3f020a26c07d683e5103404b0fbf]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Maniscalco/drm-msm-preemption-aware-hangcheck/20261029-194101
base:   d024361c631b3f020a26c07d683e5103404b0fbf
patch link:    https://lore.kernel.org/r/20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d%40gmail.com
patch subject: [PATCH v2] drm/msm: preemption aware hangcheck
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261030/202610302317.4PKDvDwV-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project c2ea4440d4b64c148de4fdfca1fc2c437a0701e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261030/202610302317.4PKDvDwV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610302317.4PKDvDwV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/msm_gpu.c:660:6: warning: unused variable 'ret' [-Wunused-variable]
     660 |         int ret;
         |             ^~~
   1 warning generated.
--
>> drivers/gpu/drm/msm/adreno/a6xx_preempt.c:18:21: warning: unused variable 'dev' [-Wunused-variable]
      18 |         struct drm_device *dev = gpu->dev;
         |                            ^~~
>> drivers/gpu/drm/msm/adreno/a6xx_preempt.c:32:6: warning: variable 'last_active_ctxcycles' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      32 |         if (ring)
         |             ^~~~
   drivers/gpu/drm/msm/adreno/a6xx_preempt.c:55:37: note: uninitialized use occurs here
      55 |         postamble[count++] = lower_32_bits(last_active_ctxcycles);
         |                                            ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/adreno/a6xx_preempt.c:32:2: note: remove the 'if' if its condition is always true
      32 |         if (ring)
         |         ^~~~~~~~~
      33 |                 last_active_ctxcycles = rbmemptr(ring, last_active_ctxcycles);
   drivers/gpu/drm/msm/adreno/a6xx_preempt.c:29:32: note: initialize the variable 'last_active_ctxcycles' to silence this warning
      29 |         uint64_t last_active_ctxcycles;
         |                                       ^
         |                                        = 0
   2 warnings generated.


vim +/ret +660 drivers/gpu/drm/msm/msm_gpu.c

   655	
   656	static bool check_ring_timeout(struct msm_ringbuffer *ring, unsigned long timeout)
   657	{
   658		struct msm_gpu *gpu = ring->gpu;
   659		u64 start, end;
 > 660		int ret;
   661	
   662		if (!gpu->funcs->get_ctx_timestamp)
   663			return !made_progress(gpu, ring);
   664	
   665		start = ring->memptrs->last_job_start_ctx;
   666	
   667		if (gpu->funcs->get_ctx_timestamp(ring, &end))
   668			end = ring->memptrs->last_active_ctxcycles;
   669	
   670		if (end >= start)
   671			return (end - start) > timeout;
   672		else
   673			return false;
   674	}
   675	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
