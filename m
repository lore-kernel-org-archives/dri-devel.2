Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE84CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 04:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33BE10EC92;
	Wed, 13 May 2026 04:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nRTcOdCO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B539910E5AA;
 Wed, 13 May 2026 04:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778647241; x=1810183241;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=A2MYt6X3AceVB5ddiyNXVfZfTRAFZeN+VNfDQfv/GNw=;
 b=nRTcOdCORfHucLlL6VO64tD1HjSREQKTJZYOi5kuWNWxZdX6HZ0QKCTT
 5qFVCMP6IYUDVrH20VArAFq8BpRGLcA5SYS0sj/qMo3IPVUbK03TmhTHU
 kStKjcdwxId5EzdBuAb5tqFD/mez07gGhNRNO881lJ8ZFrmFYkIGovfv7
 k0P4a1hciUrtc6vvsQf4h9bYpwMRUzOH1sOEH/qwtBeavG4L8NhspnmgU
 DbLluLnc9JCpsAvSUPfn1P7X03Etej8iINFbXuPAN09bv1iCrrGd8tTpV
 SgKwTuyGSFe6RNZF139j+T8YR/zE3fOXi1541EyZDpvdg/m6QZNFCeUoa w==;
X-CSE-ConnectionGUID: kQoEYHZLRXuCjB8XWM8c7w==
X-CSE-MsgGUID: Z/uGHlKXRNiGUGjMmf/qnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79462079"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79462079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 21:40:41 -0700
X-CSE-ConnectionGUID: wJUJkKPQR9a8WkJp+seoag==
X-CSE-MsgGUID: rUSZELysTEKf/ihRRoWgHA==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f)
 ([10.211.93.152])
 by fmviesa003.fm.intel.com with ESMTP; 12 May 2026 21:40:37 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wN1Od-000000008Sv-1QeJ;
 Wed, 13 May 2026 04:40:35 +0000
Date: Wed, 13 May 2026 06:39:53 +0200
From: kernel test robot <lkp@intel.com>
To: Andre Jun Hirata <andrejhirata@usp.br>, kenneth.feng@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabriel.dimant@usp.br,
 guilhermesangabriel@usp.br, Andre Jun Hirata <andrejhirata@usp.br>
Subject: Re: [PATCH v5] drm/amd/pm: Use guard(mutex) instead of manual
 lock+unlock
Message-ID: <202605130638.LqIgORiV-lkp@intel.com>
References: <20260508230312.6108-1-andrejhirata@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508230312.6108-1-andrejhirata@usp.br>
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

Hi Andre,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andre-Jun-Hirata/drm-amd-pm-Use-guard-mutex-instead-of-manual-lock-unlock/20260513-040937
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260508230312.6108-1-andrejhirata%40usp.br
patch subject: [PATCH v5] drm/amd/pm: Use guard(mutex) instead of manual lock+unlock
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260513/202605130638.LqIgORiV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130638.LqIgORiV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130638.LqIgORiV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c: In function 'amdgpu_dpm_is_mode1_reset_supported':
>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c:247:47: error: expected ';' before '}' token
     247 |         return smu_mode1_reset_is_support(smu)
         |                                               ^
         |                                               ;
     248 | }
         | ~                                              
   drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c: In function 'amdgpu_dpm_get_vce_clock_state':
>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c:833:31: warning: unused variable 'vstate' [-Wunused-variable]
     833 |         struct amd_vce_state *vstate = NULL;
         |                               ^~~~~~


vim +247 drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm.c

   238	
   239	bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
   240	{
   241		struct smu_context *smu = adev->powerplay.pp_handle;
   242	
   243		if (!is_support_sw_smu(adev))
   244			return false;
   245	
   246		guard(mutex)(&adev->pm.mutex);
 > 247		return smu_mode1_reset_is_support(smu)
   248	}
   249	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
