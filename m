Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1688CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 17:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0754010E238;
	Sun, 10 May 2026 17:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dYAQfX9D";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2151C10E227;
 Sun, 10 May 2026 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778432930; x=1809968930;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qRNzFoTiVCuTfnV1dvVwuxpnSZC4N4oqVoZPWCtyFWo=;
 b=dYAQfX9DuKb+NYyzkizaO/3xxAtiEOHlGg2fEm+2RRaeelWsHhvVjT/X
 WR1xywTb6XMiELZd8VrDN/Ku6GHQMn3Q0T45ZPV4IJIfyeaR1SmXwF2Cr
 bF8DClMyjKAHRQDp8kLxFereU2IWeGcpJmbgypBOBHU8MpiSP/WUzHSZF
 rkUUKza+Eikg0NBF0sLgohQy+S9BQpC1Ir0BCv9gjjalNfqZPoaOSalb2
 8+8qWnh9/vianoH6U+yPhtCyj0jqeDnx3lTegPfNkakvHsYo8b83+VOMh
 NJtnTlwQC0Y5EGpmf7cFSRXNKPHIYsexRfE/0CQ3ERR8NwNdlbndikpjd g==;
X-CSE-ConnectionGUID: wGHcZxwWTkeAYG3b2wpXDA==
X-CSE-MsgGUID: 7e9eX723Rlm0QiO8liERew==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="89919908"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="89919908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 10:08:49 -0700
X-CSE-ConnectionGUID: 4da33C/STDqvjN1LR2bH1A==
X-CSE-MsgGUID: HgtiYq5bTaueCMH+NREZeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="234589511"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 10 May 2026 10:08:46 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wM7dz-000000002S1-0RmW;
 Sun, 10 May 2026 17:08:43 +0000
Date: Mon, 11 May 2026 01:08:02 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel J Blueman <daniel@quora.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Daniel J Blueman <daniel@quora.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix shrinker deadlock
Message-ID: <202605110127.kDfyU1Oh-lkp@intel.com>
References: <20260508065722.18785-1-daniel@quora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508065722.18785-1-daniel@quora.org>
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

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-J-Blueman/drm-msm-Fix-shrinker-deadlock/20260510-132942
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260508065722.18785-1-daniel%40quora.org
patch subject: [PATCH] drm/msm: Fix shrinker deadlock
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260511/202605110127.kDfyU1Oh-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260511/202605110127.kDfyU1Oh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605110127.kDfyU1Oh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'evict':
>> drivers/gpu/drm/msm/msm_gem_shrinker.c:125:30: error: passing argument 1 of 'with_vm_locks' from incompatible pointer type [-Wincompatible-pointer-types]
     125 |         return with_vm_locks(ticket, msm_gem_evict, obj);
         |                              ^~~~~~
         |                              |
         |                              struct ww_acquire_ctx *
   drivers/gpu/drm/msm/msm_gem_shrinker.c:46:22: note: expected 'void (*)(struct drm_gem_object *)' but argument is of type 'struct ww_acquire_ctx *'
      46 | with_vm_locks(void (*fn)(struct drm_gem_object *obj),
         |               ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/msm/msm_gem_shrinker.c:125:38: error: passing argument 2 of 'with_vm_locks' from incompatible pointer type [-Wincompatible-pointer-types]
     125 |         return with_vm_locks(ticket, msm_gem_evict, obj);
         |                                      ^~~~~~~~~~~~~
         |                                      |
         |                                      void (*)(struct drm_gem_object *)
   drivers/gpu/drm/msm/msm_gem_shrinker.c:47:38: note: expected 'struct drm_gem_object *' but argument is of type 'void (*)(struct drm_gem_object *)'
      47 |               struct drm_gem_object *obj)
         |               ~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/gpu/drm/msm/msm_gem_shrinker.c:125:16: error: too many arguments to function 'with_vm_locks'
     125 |         return with_vm_locks(ticket, msm_gem_evict, obj);
         |                ^~~~~~~~~~~~~
   drivers/gpu/drm/msm/msm_gem_shrinker.c:46:1: note: declared here
      46 | with_vm_locks(void (*fn)(struct drm_gem_object *obj),
         | ^~~~~~~~~~~~~


vim +/with_vm_locks +125 drivers/gpu/drm/msm/msm_gem_shrinker.c

6afb0750dba05c Rob Clark 2021-04-05  115  
63f17ef834284d Rob Clark 2021-04-05  116  static bool
02070f04987524 Rob Clark 2025-06-29  117  evict(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
63f17ef834284d Rob Clark 2021-04-05  118  {
b352ba54a82072 Rob Clark 2022-08-02  119  	if (is_unevictable(to_msm_bo(obj)))
63f17ef834284d Rob Clark 2021-04-05  120  		return false;
63f17ef834284d Rob Clark 2021-04-05  121  
b352ba54a82072 Rob Clark 2022-08-02  122  	if (msm_gem_active(obj))
01780d02634a3a Rob Clark 2022-08-02  123  		return false;
01780d02634a3a Rob Clark 2022-08-02  124  
fe4952b5f27cca Rob Clark 2025-06-29 @125  	return with_vm_locks(ticket, msm_gem_evict, obj);
63f17ef834284d Rob Clark 2021-04-05  126  }
63f17ef834284d Rob Clark 2021-04-05  127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
