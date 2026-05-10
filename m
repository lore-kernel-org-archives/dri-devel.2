Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88B5CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 12:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1447B10E105;
	Sun, 10 May 2026 12:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a4PZeRyV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF2710E105;
 Sun, 10 May 2026 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778416324; x=1809952324;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W2lnjd0EEjY95FWLS/VU+8zZVQxhrlAyAYdoXojkgTg=;
 b=a4PZeRyV04yV/AKq5esU57XnABx9ICDZSVknrUFtWAdqylbT62rVGwzc
 gOGvR0KAf4OCM2q23OK1FxpyRwO/FIIqJkjint7we3v+ezdw8MbPM0oHa
 Vy29sRSxe1tTpUYRk+RlLurzMNUy7wbI/ZxT3wgjJ0mMLWkY+PVFxH7ZG
 LAww0VAm8zDUA3iQ3vI3T1Mnvj6CF2rukN8jg1pGOXausAnpvGMFN2ERi
 Ps9mwbNciB84mmc+tuBOSoj/Issqg+0B59xdV8kzDbp5kNy9QKyRDGp+9
 LEroyZIgKL+Dk/IDTKxAZOBBaLvtgKI/DTLjiQCgsB0wKkPJ4T2LIGbRV Q==;
X-CSE-ConnectionGUID: 4+ngMViqQVOtlXVBSaeHHw==
X-CSE-MsgGUID: u+k4dL8iSQK4axr4QmP4Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83174439"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="83174439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2026 05:32:04 -0700
X-CSE-ConnectionGUID: O+4Fc+NiTR6GKBhPTah8HQ==
X-CSE-MsgGUID: cEwYlgaAQFCggNTGzUHM2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; d="scan'208";a="275345921"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 10 May 2026 05:32:00 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wM3K8-0000000028T-49cF;
 Sun, 10 May 2026 12:31:56 +0000
Date: Sun, 10 May 2026 20:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel J Blueman <daniel@quora.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Daniel J Blueman <daniel@quora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix shrinker deadlock
Message-ID: <202605102047.JRDq9587-lkp@intel.com>
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
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260510/202605102047.JRDq9587-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605102047.JRDq9587-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605102047.JRDq9587-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/msm_gem_shrinker.c:10:
   In file included from drivers/gpu/drm/msm/msm_drv.h:22:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/gpu/drm/msm/msm_gem_shrinker.c:125:46: error: too many arguments to function call, expected 2, have 3
     125 |         return with_vm_locks(ticket, msm_gem_evict, obj);
         |                ~~~~~~~~~~~~~                        ^~~
   drivers/gpu/drm/msm/msm_gem_shrinker.c:46:1: note: 'with_vm_locks' declared here
      46 | with_vm_locks(void (*fn)(struct drm_gem_object *obj),
         | ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      47 |               struct drm_gem_object *obj)
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +125 drivers/gpu/drm/msm/msm_gem_shrinker.c

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
