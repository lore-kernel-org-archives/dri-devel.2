Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232D606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XcPPuqyK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC3310E925;
	Thu,  5 Nov 2026 04:39:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8F910E910;
 Thu,  5 Nov 2026 04:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793853593; x=1825389593;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=EZ6zco1K1tAz8v13jDM/MgKfVILftAbDKiAEr4ycyCc=;
 b=XcPPuqyKWz7Xcmua5uyh4cQscLLveNvD7Car2g2tbSwFeRLP8WwBcCRX
 AZypicQqiJvnARYUnZ2KiH96QEQkoR/ELkWLBBABt4O0RKyI69lkicvyc
 q9PbAuH6QZOWIh3fmpyZ6uPJVopb08SaVFTt+WBhDZgPhveOw/Od+9b8g
 MgkcCKLxuf5/jlgCPZEstbUOlXd0jvjw3uESHzyxkozGTaQ3wEiLQZWSU
 VDAjnFkvT9mHP1wtr9Zp6eksqHI7sAc00Gmj2spBR8d1SAvEBj6rUh9lL
 jHK7eaolAVe8VV87EV1FEbIEyJVE2tXtqOa5aFomfA7WnFXpmGD615KZX w==;
X-CSE-ConnectionGUID: Bi3FdHp5SxGFXMQbaZAgvw==
X-CSE-MsgGUID: rvZ4DQJFQvmIIucR6S5ffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2721205"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2721205"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 20:39:53 -0800
X-CSE-ConnectionGUID: azbN95y1Tj+RCA6RxL/jEw==
X-CSE-MsgGUID: brRElNI+Sn2mvd0OtqX5Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8669849"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 04 Nov 2026 20:39:50 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xOpGM-00000000leF-3eaK;
 Thu, 05 Nov 2026 04:39:46 +0000
Date: Thu, 5 Nov 2026 12:39:45 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
Message-ID: <202611051237.oXlTZ7GB-lkp@intel.com>
References: <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
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

Hi Pierre-Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20261028]
[cannot apply to drm-misc/drm-misc-next linus/master v7.3 v7.3-rc7 v7.3-rc6 v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pierre-Eric-Pelloux-Prayer/drm-amdgpu-add-gpu_recovery_enabled-flag-to-amdgpu_device/20261029-161949
base:   next-20261028
patch link:    https://lore.kernel.org/r/20261029152000.22001-4-pierre-eric.pelloux-prayer%40amd.com
patch subject: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261105/202611051237.oXlTZ7GB-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051237.oXlTZ7GB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051237.oXlTZ7GB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:956:3: error: cannot jump from this goto statement to its label
     956 |                 goto error_put_gobj;
         |                 ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:959:54: note: jump bypasses initialization of variable with __attribute__((cleanup))
     959 |         PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
         |                                                             ^
   1 error generated.


vim +956 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c

   869	
   870	int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
   871				  struct drm_file *filp)
   872	{
   873		const uint32_t valid_flags = AMDGPU_VM_DELAY_UPDATE |
   874			AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
   875			AMDGPU_VM_PAGE_EXECUTABLE | AMDGPU_VM_MTYPE_MASK |
   876			AMDGPU_VM_PAGE_NOALLOC;
   877		const uint32_t prt_flags = AMDGPU_VM_DELAY_UPDATE |
   878			AMDGPU_VM_PAGE_PRT;
   879	
   880		struct drm_amdgpu_gem_va *args = data;
   881		struct drm_gem_object *gobj;
   882		struct amdgpu_device *adev = drm_to_adev(dev);
   883		struct amdgpu_fpriv *fpriv = filp->driver_priv;
   884		struct amdgpu_bo *abo;
   885		struct amdgpu_bo_va *bo_va;
   886		struct drm_syncobj *timeline_syncobj = NULL;
   887		struct dma_fence_chain *timeline_chain = NULL;
   888		struct drm_exec exec;
   889		uint64_t vm_size, tmp;
   890		int r = 0;
   891	
   892		/* Validate virtual address range against reserved regions. */
   893		if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
   894			dev_dbg(dev->dev,
   895				"va_address 0x%llx is in reserved area 0x%llx\n",
   896				args->va_address, AMDGPU_VA_RESERVED_BOTTOM);
   897			return -EINVAL;
   898		}
   899	
   900		if (args->va_address >= AMDGPU_GMC_HOLE_START &&
   901		    args->va_address < AMDGPU_GMC_HOLE_END) {
   902			dev_dbg(dev->dev,
   903				"va_address 0x%llx is in VA hole 0x%llx-0x%llx\n",
   904				args->va_address, AMDGPU_GMC_HOLE_START,
   905				AMDGPU_GMC_HOLE_END);
   906			return -EINVAL;
   907		}
   908	
   909		args->va_address &= AMDGPU_GMC_HOLE_MASK;
   910	
   911		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
   912		vm_size -= AMDGPU_VA_RESERVED_TOP;
   913		if (check_add_overflow(args->va_address, args->map_size, &tmp) || tmp > vm_size) {
   914			dev_dbg(dev->dev,
   915				"va_address 0x%llx is in top reserved area 0x%llx\n",
   916				args->va_address + args->map_size, vm_size);
   917			return -EINVAL;
   918		}
   919	
   920		if ((args->flags & ~valid_flags) && (args->flags & ~prt_flags)) {
   921			dev_dbg(dev->dev, "invalid flags combination 0x%08X\n",
   922				args->flags);
   923			return -EINVAL;
   924		}
   925	
   926		/* Validate operation type. */
   927		switch (args->operation) {
   928		case AMDGPU_VA_OP_MAP:
   929		case AMDGPU_VA_OP_UNMAP:
   930		case AMDGPU_VA_OP_CLEAR:
   931		case AMDGPU_VA_OP_REPLACE:
   932			break;
   933		default:
   934			dev_dbg(dev->dev, "unsupported operation %d\n",
   935				args->operation);
   936			return -EINVAL;
   937		}
   938	
   939		if (args->flags & AMDGPU_VM_DELAY_UPDATE &&
   940		    args->vm_timeline_syncobj_out)
   941			return -EINVAL;
   942	
   943		if ((args->operation != AMDGPU_VA_OP_CLEAR) &&
   944		    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
   945			gobj = drm_gem_object_lookup(filp, args->handle);
   946			if (gobj == NULL)
   947				return -ENOENT;
   948			abo = gem_to_amdgpu_bo(gobj);
   949		} else {
   950			gobj = NULL;
   951			abo = NULL;
   952		}
   953	
   954		if (amdgpu_device_is_wedged(adev)) {
   955			r = -ENODEV;
 > 956			goto error_put_gobj;
   957		}
   958	
   959		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
   960	
   961		r = PM_RUNTIME_ACQUIRE_ERR(&lock);
   962		if (r)
   963			goto error_put_gobj;
   964	
   965		/* Add input syncobj fences (if any) for synchronization. */
   966		r = amdgpu_gem_add_input_fence(filp,
   967					       args->input_fence_syncobj_handles,
   968					       args->num_syncobj_handles);
   969		if (r)
   970			goto error_put_gobj;
   971	
   972		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
   973			      DRM_EXEC_IGNORE_DUPLICATES, 0);
   974		drm_exec_until_all_locked(&exec) {
   975			if (gobj) {
   976				r = drm_exec_lock_obj(&exec, gobj);
   977				drm_exec_retry_on_contention(&exec);
   978				if (unlikely(r))
   979					goto error;
   980			}
   981	
   982			r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
   983			drm_exec_retry_on_contention(&exec);
   984			if (unlikely(r))
   985				goto error;
   986		}
   987	
   988		/* Resolve the BO-VA mapping for this VM/BO combination. */
   989		if (abo) {
   990			bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
   991			if (!bo_va) {
   992				r = -ENOENT;
   993				goto error;
   994			}
   995		} else if (args->operation != AMDGPU_VA_OP_CLEAR) {
   996			bo_va = fpriv->prt_va;
   997		} else {
   998			bo_va = NULL;
   999		}
  1000	
  1001		/*
  1002		 * Prepare the timeline syncobj node if the user requested a VM
  1003		 * timeline update. This only allocates/looks up the syncobj and
  1004		 * chain node; the actual fence is attached later.
  1005		 */
  1006		r = amdgpu_gem_update_timeline_node(filp,
  1007						    args->vm_timeline_syncobj_out,
  1008						    args->vm_timeline_point,
  1009						    &timeline_syncobj,
  1010						    &timeline_chain);
  1011		if (r)
  1012			goto error;
  1013	
  1014		switch (args->operation) {
  1015		case AMDGPU_VA_OP_MAP:
  1016			r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
  1017					     args->offset_in_bo, args->map_size,
  1018					     args->flags);
  1019			break;
  1020		case AMDGPU_VA_OP_UNMAP:
  1021			r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
  1022			break;
  1023	
  1024		case AMDGPU_VA_OP_CLEAR:
  1025			r = amdgpu_vm_bo_clear_mappings(adev, &fpriv->vm,
  1026							args->va_address,
  1027							args->map_size);
  1028			break;
  1029		case AMDGPU_VA_OP_REPLACE:
  1030			r = amdgpu_vm_bo_replace_map(adev, bo_va, args->va_address,
  1031						     args->offset_in_bo, args->map_size,
  1032						     args->flags);
  1033			break;
  1034		default:
  1035			break;
  1036		}
  1037	
  1038		/*
  1039		 * Once the VA operation is done, update the VM and obtain the fence
  1040		 * that represents the last relevant update for this mapping. This
  1041		 * fence can then be exported to the user-visible VM timeline.
  1042		 */
  1043		if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) &&
  1044		    (!adev->debug_vm || timeline_syncobj)) {
  1045			struct dma_fence *fence;
  1046	
  1047			fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
  1048							args->operation);
  1049			if (timeline_syncobj) {
  1050				if (!args->vm_timeline_point) {
  1051					/* Replace the existing fence when no point is given. */
  1052					drm_syncobj_replace_fence(timeline_syncobj,
  1053								  fence);
  1054				} else {
  1055					/* Attach the last-update fence at a specific point. */
  1056					drm_syncobj_add_point(timeline_syncobj,
  1057							      timeline_chain,
  1058							      fence,
  1059							      args->vm_timeline_point);
  1060					timeline_chain = NULL;
  1061				}
  1062			}
  1063			dma_fence_put(fence);
  1064	
  1065		}
  1066	
  1067	error:
  1068		dma_fence_chain_free(timeline_chain);
  1069		if (timeline_syncobj)
  1070			drm_syncobj_put(timeline_syncobj);
  1071		drm_exec_fini(&exec);
  1072	error_put_gobj:
  1073		drm_gem_object_put(gobj);
  1074		return r;
  1075	}
  1076	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
