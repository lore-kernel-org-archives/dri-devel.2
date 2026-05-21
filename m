Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B12CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82DF10F221;
	Thu, 21 May 2026 09:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QqmRKPn7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3C210E439;
 Thu, 21 May 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779356759; x=1810892759;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TCZTrJrBdgiRh4gqQvmMTY8x6g99ouQ5GXQCNVm/HPI=;
 b=QqmRKPn7Q8Yp2mOfX5TRWpXc6bhiGJbpS3ZJ8ZGQDE0HDJGQNwvI2xCG
 KIde2su7VGYbHR3PLpW9UAaOQxJcaDu2lzjByLO9/5fUECGh9lcxdmfyQ
 a3WqkIoGSocJOnOYTVLXCYnggHlroV5fBtfQKmpcK9IeC0vINV5qiGCIO
 iIyyqmjCjiEImdGqZISHOQMcgdTx4ZuRcCLvonIaIL3z2JIj4qG/xsiKT
 b9X0UTtw9yRllv4GBvP1ehcE67f0yM091IhKtffaSVdekOUBAUyaauZrE
 5wU+Lv8iGE8Dx1DLXae+jhc0Cvx2tvcRw3pJ3xlEXSguvBhVCiQH1j3+4 A==;
X-CSE-ConnectionGUID: PpgjXtRHSUW2AN2adiSoPA==
X-CSE-MsgGUID: 4QZpncGfRyGVVmKQ2jXb6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80450414"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="80450414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 02:45:59 -0700
X-CSE-ConnectionGUID: +rUo7ROgQlyofsz/e5I0oA==
X-CSE-MsgGUID: /nQHP1Q7QSCozMJLtKgr9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="240347284"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f)
 ([10.211.93.152])
 by orviesa008.jf.intel.com with ESMTP; 21 May 2026 02:45:55 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wPzyT-00000000Aq7-0tKX;
 Thu, 21 May 2026 09:45:53 +0000
Date: Thu, 21 May 2026 11:45:42 +0200
From: kernel test robot <lkp@intel.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
Message-ID: <202605211112.xlUYDZeM-lkp@intel.com>
References: <20260520151741.50575-3-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520151741.50575-3-mikhail.v.gavrilov@gmail.com>
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

Hi Mikhail,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip next-20260520]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikhail-Gavrilov/drm-amdgpu-convert-amdgpu_vm_lock_by_pasid-to-drm_exec/20260520-231931
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260520151741.50575-3-mikhail.v.gavrilov%40gmail.com
patch subject: [PATCH v3 2/2] drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_format
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260521/202605211112.xlUYDZeM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211112.xlUYDZeM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   AMD plane color pipeline
   ------------------------ [docutils]
>> Documentation/gpu/amdgpu/driver-core:225: ./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2958: WARNING: Inline emphasis start-string without end-string. [docutils]
   Documentation/gpu/driver-uapi:31: ./include/uapi/drm/xe_drm.h:2538: ERROR: Unexpected section title.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
