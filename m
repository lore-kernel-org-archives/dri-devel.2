Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E5606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q98ompO2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A0210F922;
	Tue,  3 Nov 2026 23:19:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84BC610F922;
 Tue,  3 Nov 2026 23:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793747983; x=1825283983;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yGcM0U/fiCfGKTJxpm31vDx9xIx3ErmFbd839Kd62eI=;
 b=Q98ompO2K9WhgNxkhVtPeq/KaJCWDrX4narxeK9eyokGBB0MFhMVduC0
 Zy8rYXIPZIuZTA4y0voskJROpIUBEyD+MLGGYdBvKzLyIs4SzLWU1zQ67
 uCkGsSDaFckrK/zKAoBin7+f3Nppa+qtdGNBxy9q/tZrP+xMdXjIhCJdG
 6jhy7tQhBrEwoQ9G570Gx1hsD76fOa05au3Ue8M0lwGvdZQyCDHaDkzED
 tOBDSmaM1nnESxWLhR95HiLn5lfOK4hc/UHi7K2aWbshiM4Jl9ZY15llu
 ZKl+0oSpAJ7+WyLA6O8OMsGATpkvSu5z4Rh6KFbsz/NFoklwM39ZL54g3 Q==;
X-CSE-ConnectionGUID: eIsa+n9jTCi/6S/bBsiLew==
X-CSE-MsgGUID: uEt9oHSiSaealW6Xkw5j1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2489842"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2489842"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 15:19:43 -0800
X-CSE-ConnectionGUID: ztogfQyQSRyK1fZcohZdLg==
X-CSE-MsgGUID: 0eJy8HeXQcywk+AUu8ktRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6570453"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 15:19:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xONmx-00000000jRz-3F88;
 Tue, 03 Nov 2026 23:19:35 +0000
Date: Wed, 4 Nov 2026 07:19:00 +0800
From: kernel test robot <lkp@intel.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/15] drm/msm/a8xx: devcoredump state capture support
Message-ID: <202611040652.1Wy2glVj-lkp@intel.com>
References: <20261102220405.30730-12-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102220405.30730-12-robin.clark@oss.qualcomm.com>
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

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-tip/drm-tip linus/master next-20261030]
[cannot apply to drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/drm-msm-Import-adreno_snapshot-h/20261102-140245
base:   https://gitlab.freedesktop.org/drm/kernel.git drm-next
patch link:    https://lore.kernel.org/r/20261102220405.30730-12-robin.clark%40oss.qualcomm.com
patch subject: [PATCH v5 11/15] drm/msm/a8xx: devcoredump state capture support
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261104/202611040652.1Wy2glVj-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611040652.1Wy2glVj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611040652.1Wy2glVj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:9:
>> drivers/gpu/drm/msm/adreno/adreno_snapshot.h:506:15: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     506 |         *(p->in++) = FIELD_PREP(GENMASK_U64(63, 44), reg) | BIT(21) | BIT(0);
         |                      ^
   drivers/gpu/drm/msm/adreno/adreno_snapshot.h:513:15: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     513 |         *(p->in++) = FIELD_PREP(GENMASK_U64(63, 44), reg) | dwords;
         |                      ^
>> drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:920:14: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     920 |         side_data = FIELD_GET(GENMASK(27, 24), reg);
         |                     ^
   drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:1135:14: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1135 |         side_data = FIELD_GET(GENMASK(27, 24), reg);
         |                     ^
>> drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:1271:4: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1271 |                         FIELD_PREP(GENMASK(7, 4), a6xx_gpu->slice_mask));
         |                         ^
   5 errors generated.


vim +/FIELD_PREP +506 drivers/gpu/drm/msm/adreno/adreno_snapshot.h

   502	
   503	static inline void CD_WRITE(struct cd_script *p, u32 reg, u32 val)
   504	{
   505		*(p->in++) = val;
 > 506		*(p->in++) = FIELD_PREP(GENMASK_U64(63, 44), reg) | BIT(21) | BIT(0);
   507		__cd_check_overflow(p);
   508	}
   509	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
