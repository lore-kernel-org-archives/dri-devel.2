Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053A0FF8860
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BD310E15E;
	Sat, 25 Apr 2026 15:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="atAf5mYC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1CE10E137;
 Sat, 25 Apr 2026 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777132722; x=1808668722;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=d7YGNiqgSx7E17Fhg5GpF35421BdBBAoOnfImJvpxJ8=;
 b=atAf5mYCKuiwXg3Emnz9frHMgCR8yMeaDsspHtBbv5w8x8JB1byEOBor
 Mlcq7sxsRLIc05QCRJnmGQ0JqXN8YsKUwpZzl+g90dB1AHiXxXku4FaIY
 1/PY2316yvhF6EAARQ0WF+ZLyXypbpr7MJTzDkJpijz4tygq7U5duUiTy
 IeXtRn9Tl4uaIOfGpzLsSJvvh9HudEFY3Sk5YJ3tBQGwFQzZ2ZlOKwB9u
 Da+KxJFahUppfXijNGUZq0AwFZ1724Pif/+gR5WpOJb2O3z5Mla1PLZE2
 pACCNTGKmbrJMooOvou/tPC4mT88arp1oXmQoJF3hq8P129myL9z1qg5e w==;
X-CSE-ConnectionGUID: Gxbhd2iYTXylpY3dvJtkgA==
X-CSE-MsgGUID: G6nWbVVLShKZKpsxtEoESw==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="88398001"
X-IronPort-AV: E=Sophos;i="6.23,198,1770624000"; d="scan'208";a="88398001"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2026 08:58:41 -0700
X-CSE-ConnectionGUID: hBfsDdj1Qs+7DLbBwxK4nA==
X-CSE-MsgGUID: SJwIh4K8Q9GKlr0t3y3i2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,198,1770624000"; d="scan'208";a="226694395"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 25 Apr 2026 08:58:38 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wGfOt-000000006q1-2AOT;
 Sat, 25 Apr 2026 15:58:35 +0000
Date: Sat, 25 Apr 2026 23:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <ynorov@nvidia.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH] drm/amdgpu: use bitmap_clear() in
 amdgpu_amdkfd_device_init()
Message-ID: <202604252305.5nmLNigU-lkp@intel.com>
References: <20260424005218.147961-1-ynorov@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424005218.147961-1-ynorov@nvidia.com>
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

Hi Yury,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.0 next-20260424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/drm-amdgpu-use-bitmap_clear-in-amdgpu_amdkfd_device_init/20260424-111821
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260424005218.147961-1-ynorov%40nvidia.com
patch subject: [PATCH] drm/amdgpu: use bitmap_clear() in amdgpu_amdkfd_device_init()
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260425/202604252305.5nmLNigU-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260425/202604252305.5nmLNigU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604252305.5nmLNigU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c: In function 'amdgpu_amdkfd_device_init':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:170:13: warning: unused variable 'i' [-Wunused-variable]
     170 |         int i;
         |             ^


vim +/i +170 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c

c0125b848abecf Le Ma             2024-01-25  167  
dc102c436f1238 Andres Rodriguez  2017-02-01  168  void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
130e0371b7d454 Oded Gabbay       2015-06-12  169  {
234441dd49bcd9 Yong Zhao         2019-01-09 @170  	int i;
d0b63bb3385c56 Andres Rodriguez  2017-02-03  171  	int last_valid_bit;
611736d8447c0c Felix Kuehling    2018-11-19  172  
27fb73a0e3aa74 Mukul Joshi       2023-04-25  173  	amdgpu_amdkfd_gpuvm_init_mem_limits();
27fb73a0e3aa74 Mukul Joshi       2023-04-25  174  
611736d8447c0c Felix Kuehling    2018-11-19  175  	if (adev->kfd.dev) {
130e0371b7d454 Oded Gabbay       2015-06-12  176  		struct kgd2kfd_shared_resources gpu_resources = {
40111ec2298f44 Felix Kuehling    2020-06-24  177  			.compute_vmid_bitmap =
40111ec2298f44 Felix Kuehling    2020-06-24  178  				((1 << AMDGPU_NUM_VMID) - 1) -
40111ec2298f44 Felix Kuehling    2020-06-24  179  				((1 << adev->vm_manager.first_kfd_vmid) - 1),
d0b63bb3385c56 Andres Rodriguez  2017-02-03  180  			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
155494dbbbf4d6 Felix Kuehling    2018-02-06  181  			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
155494dbbbf4d6 Felix Kuehling    2018-02-06  182  			.gpuvm_size = min(adev->vm_manager.max_pfn
155494dbbbf4d6 Felix Kuehling    2018-02-06  183  					  << AMDGPU_GPU_PAGE_SHIFT,
ad9a5b78f585e9 Christian König   2018-08-27  184  					  AMDGPU_GMC_HOLE_START),
4a580877bdcb83 Luben Tuikov      2020-08-24  185  			.drm_render_minor = adev_to_drm(adev)->render->index,
234441dd49bcd9 Yong Zhao         2019-01-09  186  			.sdma_doorbell_idx = adev->doorbell_index.sdma_engine,
cc009e613de656 Mukul Joshi       2022-04-26  187  			.enable_mes = adev->enable_mes,
130e0371b7d454 Oded Gabbay       2015-06-12  188  		};
130e0371b7d454 Oded Gabbay       2015-06-12  189  
d0b63bb3385c56 Andres Rodriguez  2017-02-03  190  		/* this is going to have a few of the MSBs set that we need to
0d87c9cfc08e15 Kent Russell      2019-05-01  191  		 * clear
0d87c9cfc08e15 Kent Russell      2019-05-01  192  		 */
e6945304187dea Yong Zhao         2020-01-30  193  		bitmap_complement(gpu_resources.cp_queue_bitmap,
be697aa3a78ef8 Le Ma             2022-07-27  194  				  adev->gfx.mec_bitmap[0].queue_bitmap,
68fa72a437ea3b Mukul Joshi       2023-09-06  195  				  AMDGPU_MAX_QUEUES);
d0b63bb3385c56 Andres Rodriguez  2017-02-03  196  
3447d220155bd9 Jay Cornwall      2017-07-13  197  		last_valid_bit = 1 /* only first MEC can have compute queues */
d0b63bb3385c56 Andres Rodriguez  2017-02-03  198  				* adev->gfx.mec.num_pipe_per_mec
d0b63bb3385c56 Andres Rodriguez  2017-02-03  199  				* adev->gfx.mec.num_queue_per_pipe;
25259687589365 Yury Norov        2026-04-23  200  		bitmap_clear(gpu_resources.cp_queue_bitmap, last_valid_bit,
25259687589365 Yury Norov        2026-04-23  201  					AMDGPU_MAX_QUEUES - last_valid_bit);
d0b63bb3385c56 Andres Rodriguez  2017-02-03  202  
dc102c436f1238 Andres Rodriguez  2017-02-01  203  		amdgpu_doorbell_get_kfd_info(adev,
130e0371b7d454 Oded Gabbay       2015-06-12  204  				&gpu_resources.doorbell_physical_address,
130e0371b7d454 Oded Gabbay       2015-06-12  205  				&gpu_resources.doorbell_aperture_size,
130e0371b7d454 Oded Gabbay       2015-06-12  206  				&gpu_resources.doorbell_start_offset);
c5892230d98b04 Shaoyun Liu       2018-03-23  207  
1f86805adc3432 Yong Zhao         2019-02-13  208  		/* Since SOC15, BIF starts to statically use the
1f86805adc3432 Yong Zhao         2019-02-13  209  		 * lower 12 bits of doorbell addresses for routing
1f86805adc3432 Yong Zhao         2019-02-13  210  		 * based on settings in registers like
1f86805adc3432 Yong Zhao         2019-02-13  211  		 * SDMA0_DOORBELL_RANGE etc..
1f86805adc3432 Yong Zhao         2019-02-13  212  		 * In order to route a doorbell to CP engine, the lower
1f86805adc3432 Yong Zhao         2019-02-13  213  		 * 12 bits of its address has to be outside the range
1f86805adc3432 Yong Zhao         2019-02-13  214  		 * set for SDMA, VCN, and IH blocks.
642a0e80262af8 Felix Kuehling    2018-04-10  215  		 */
234441dd49bcd9 Yong Zhao         2019-01-09  216  		if (adev->asic_type >= CHIP_VEGA10) {
1f86805adc3432 Yong Zhao         2019-02-13  217  			gpu_resources.non_cp_doorbells_start =
1f86805adc3432 Yong Zhao         2019-02-13  218  					adev->doorbell_index.first_non_cp;
1f86805adc3432 Yong Zhao         2019-02-13  219  			gpu_resources.non_cp_doorbells_end =
1f86805adc3432 Yong Zhao         2019-02-13  220  					adev->doorbell_index.last_non_cp;
234441dd49bcd9 Yong Zhao         2019-01-09  221  		}
130e0371b7d454 Oded Gabbay       2015-06-12  222  
8e2712e71bfc97 shaoyunl          2021-02-16  223  		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
d69a3b762dc4c9 Mukul Joshi       2022-05-09  224  							&gpu_resources);
b5fd0cf3ea377a Andrey Grodzovsky 2022-05-17  225  
2302d507149f0a Philip Yang       2022-10-03  226  		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
2302d507149f0a Philip Yang       2022-10-03  227  
b5fd0cf3ea377a Andrey Grodzovsky 2022-05-17  228  		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
130e0371b7d454 Oded Gabbay       2015-06-12  229  	}
130e0371b7d454 Oded Gabbay       2015-06-12  230  }
130e0371b7d454 Oded Gabbay       2015-06-12  231  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
