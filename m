Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VzNtIYQH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142BF10FBDD;
	Thu, 12 Nov 2026 20:10:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA65610E663;
 Thu, 12 Nov 2026 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794514195; x=1826050195;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o0Jmt3RGWgn8b3wNzBOG3FMike2nuQx+tirONUWZoXQ=;
 b=VzNtIYQHwlz1Y6NVnRqUzQw0z/UVmyprT13N2MQ3wBbUzFufbeyT5WAB
 ptdpx8dGS1YxDQf5UxKj8GqbjHk0JK3J4tfYIprApWjn4NUKIKB1A6SrK
 3M01PFEwM1uPQOqdL8meoTHHuTMiI/MWZ72HFwPtfMO3h3i/8uUmAkQgl
 wq34Fb6ek8tawZ8tWT9wCOTQwEpbgryTgamJ2URTPtGZsMcgmY3JR495e
 VM/D4fTbJ9L1sd9GY7DEm9e4hQQNz7wZFTofTLrKYwl7YLAjoBnthRUtS
 fDPiq+MFN+Pq3jdWy3NUIQwmfVxCnV8H0PUyGRlKZkfIYGkYxhGYxwGqb A==;
X-CSE-ConnectionGUID: LDS6lLLPSKahIVc6nGORwg==
X-CSE-MsgGUID: V7m/6MHxT9iObWVSALoeBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3315827"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3315827"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 12:09:55 -0800
X-CSE-ConnectionGUID: XJP+f/0XSauhbTSsG5X+HQ==
X-CSE-MsgGUID: YAaFgH0hQYKPDDCj9imqfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9074008"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa001.fm.intel.com with ESMTP; 12 Nov 2026 12:09:51 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xRb7E-000000011zv-3F9X;
 Thu, 12 Nov 2026 20:09:48 +0000
Date: Fri, 13 Nov 2026 04:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/2] drm: Remove drm_crtc_init()
Message-ID: <202611130335.vCIEnRqF-lkp@intel.com>
References: <20261112125039.66082-3-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112125039.66082-3-tzimmermann@suse.de>
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

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.4-rc2 next-20261111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/drm-radeon-Inline-drm_crtc_init/20261112-134508
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20261112125039.66082-3-tzimmermann%40suse.de
patch subject: [PATCH v2 2/2] drm: Remove drm_crtc_init()
config: arc-randconfig-1001-20261112 (https://download.01.org/0day-ci/archive/20261113/202611130335.vCIEnRqF-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261113/202611130335.vCIEnRqF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611130335.vCIEnRqF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c: In function 'dce_v10_0_crtc_init':
>> drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:2677:9: error: implicit declaration of function 'drm_crtc_init'; did you mean 'drm_exec_init'? [-Werror=implicit-function-declaration]
    2677 |         drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v10_0_crtc_funcs);
         |         ^~~~~~~~~~~~~
         |         drm_exec_init
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c: In function 'dce_v8_0_crtc_init':
>> drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:2603:9: error: implicit declaration of function 'drm_crtc_init'; did you mean 'drm_exec_init'? [-Werror=implicit-function-declaration]
    2603 |         drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v8_0_crtc_funcs);
         |         ^~~~~~~~~~~~~
         |         drm_exec_init
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c: In function 'dce_v6_0_crtc_init':
>> drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:2645:9: error: implicit declaration of function 'drm_crtc_init'; did you mean 'drm_exec_init'? [-Werror=implicit-function-declaration]
    2645 |         drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v6_0_crtc_funcs);
         |         ^~~~~~~~~~~~~
         |         drm_exec_init
   cc1: some warnings being treated as errors


vim +2677 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c

7e50642d41050c Alex Deucher 2024-10-31  2667  
aaa36a976bbb9b Alex Deucher 2015-04-20  2668  static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
aaa36a976bbb9b Alex Deucher 2015-04-20  2669  {
aaa36a976bbb9b Alex Deucher 2015-04-20  2670  	struct amdgpu_crtc *amdgpu_crtc;
aaa36a976bbb9b Alex Deucher 2015-04-20  2671  
aaa36a976bbb9b Alex Deucher 2015-04-20  2672  	amdgpu_crtc = kzalloc(sizeof(struct amdgpu_crtc) +
aaa36a976bbb9b Alex Deucher 2015-04-20  2673  			      (AMDGPUFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
aaa36a976bbb9b Alex Deucher 2015-04-20  2674  	if (amdgpu_crtc == NULL)
aaa36a976bbb9b Alex Deucher 2015-04-20  2675  		return -ENOMEM;
aaa36a976bbb9b Alex Deucher 2015-04-20  2676  
4a580877bdcb83 Luben Tuikov 2020-08-24 @2677  	drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base, &dce_v10_0_crtc_funcs);
aaa36a976bbb9b Alex Deucher 2015-04-20  2678  
aaa36a976bbb9b Alex Deucher 2015-04-20  2679  	drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
aaa36a976bbb9b Alex Deucher 2015-04-20  2680  	amdgpu_crtc->crtc_id = index;
aaa36a976bbb9b Alex Deucher 2015-04-20  2681  	adev->mode_info.crtcs[index] = amdgpu_crtc;
aaa36a976bbb9b Alex Deucher 2015-04-20  2682  
aaa36a976bbb9b Alex Deucher 2015-04-20  2683  	amdgpu_crtc->max_cursor_width = 128;
aaa36a976bbb9b Alex Deucher 2015-04-20  2684  	amdgpu_crtc->max_cursor_height = 128;
4a580877bdcb83 Luben Tuikov 2020-08-24  2685  	adev_to_drm(adev)->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
4a580877bdcb83 Luben Tuikov 2020-08-24  2686  	adev_to_drm(adev)->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
aaa36a976bbb9b Alex Deucher 2015-04-20  2687  
aaa36a976bbb9b Alex Deucher 2015-04-20  2688  	switch (amdgpu_crtc->crtc_id) {
aaa36a976bbb9b Alex Deucher 2015-04-20  2689  	case 0:
aaa36a976bbb9b Alex Deucher 2015-04-20  2690  	default:
aaa36a976bbb9b Alex Deucher 2015-04-20  2691  		amdgpu_crtc->crtc_offset = CRTC0_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2692  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2693  	case 1:
aaa36a976bbb9b Alex Deucher 2015-04-20  2694  		amdgpu_crtc->crtc_offset = CRTC1_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2695  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2696  	case 2:
aaa36a976bbb9b Alex Deucher 2015-04-20  2697  		amdgpu_crtc->crtc_offset = CRTC2_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2698  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2699  	case 3:
aaa36a976bbb9b Alex Deucher 2015-04-20  2700  		amdgpu_crtc->crtc_offset = CRTC3_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2701  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2702  	case 4:
aaa36a976bbb9b Alex Deucher 2015-04-20  2703  		amdgpu_crtc->crtc_offset = CRTC4_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2704  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2705  	case 5:
aaa36a976bbb9b Alex Deucher 2015-04-20  2706  		amdgpu_crtc->crtc_offset = CRTC5_REGISTER_OFFSET;
aaa36a976bbb9b Alex Deucher 2015-04-20  2707  		break;
aaa36a976bbb9b Alex Deucher 2015-04-20  2708  	}
aaa36a976bbb9b Alex Deucher 2015-04-20  2709  
aaa36a976bbb9b Alex Deucher 2015-04-20  2710  	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
aaa36a976bbb9b Alex Deucher 2015-04-20  2711  	amdgpu_crtc->adjusted_clock = 0;
aaa36a976bbb9b Alex Deucher 2015-04-20  2712  	amdgpu_crtc->encoder = NULL;
aaa36a976bbb9b Alex Deucher 2015-04-20  2713  	amdgpu_crtc->connector = NULL;
aaa36a976bbb9b Alex Deucher 2015-04-20  2714  	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v10_0_crtc_helper_funcs);
7e50642d41050c Alex Deucher 2024-10-31  2715  	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v10_0_drm_primary_plane_helper_funcs);
aaa36a976bbb9b Alex Deucher 2015-04-20  2716  
aaa36a976bbb9b Alex Deucher 2015-04-20  2717  	return 0;
aaa36a976bbb9b Alex Deucher 2015-04-20  2718  }
aaa36a976bbb9b Alex Deucher 2015-04-20  2719  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
