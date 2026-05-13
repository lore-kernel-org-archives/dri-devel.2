Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C307CCD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 10:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0744D10E2F7;
	Wed, 13 May 2026 10:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jNA1jK3r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FB310E2F7;
 Wed, 13 May 2026 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778667859; x=1810203859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4wefMVkZ2b1CWXY9jD02Xn87mvdkQbPY1jMc+Kksl2U=;
 b=jNA1jK3rYq9OlXgXsq9xEGOfRAKk6WMfNi2+z0pK3M2y7GIshe/6b+6n
 c14mhjjpQBhog8cFvHPByMWok5qTm8DAifp+7b3i5uzDPTvoVJQ4PJFwy
 CX+HUEjXRv9ISoaqmAzrXPpwLiWZ3R2laWAJ9cOd4aA+/vNydqOuxKT/b
 /VZW6/Tqf/hEkkLkIumOn6zuTPqpWXuiPzPryLf6Ody28+GprbSvnL1ig
 2HQhV7aYlkK8t/IF9TdM+ht7l90T4qTFsJXItvYe8NqFUVZuj10g+QGxc
 qMtBDRfa/qku5+i3Q9R+22jpFuyb5eXPwdpdIjqEGVv9b+grgxME9lYOA g==;
X-CSE-ConnectionGUID: ak6OBCN8SoSliL/7OMaMwg==
X-CSE-MsgGUID: KWNvP5FIQL2/9MnWbB1F7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="102257683"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="102257683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 03:24:19 -0700
X-CSE-ConnectionGUID: w58b6nA/QrCbcOi/jOowPA==
X-CSE-MsgGUID: 7zU/hjTiQMmeDGSx5RVxpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="242056400"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 13 May 2026 03:24:17 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wN6lB-000000003v9-2N10;
 Wed, 13 May 2026 10:24:13 +0000
Date: Wed, 13 May 2026 18:24:00 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure
Message-ID: <202605131824.SbQ7agaE-lkp@intel.com>
References: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
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

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Hellstr-m/drm-ttm-Fix-ttm_bo_shrink-infinite-LRU-walk-on-backup-failure/20260513-095356
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260511162443.24352-1-thomas.hellstrom%40linux.intel.com
patch subject: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20260513/202605131824.SbQ7agaE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131824.SbQ7agaE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131824.SbQ7agaE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/ttm/ttm_bo_util.c:1121:3: error: call to undeclared function 'ttm_resource_del_bulk_move_unevictable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1121 |                 ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
         |                 ^
   drivers/gpu/drm/ttm/ttm_bo_util.c:1121:3: note: did you mean 'ttm_resource_del_bulk_move'?
   include/drm/ttm/ttm_resource.h:449:6: note: 'ttm_resource_del_bulk_move' declared here
     449 | void ttm_resource_del_bulk_move(struct ttm_resource *res,
         |      ^
   1 error generated.


vim +/ttm_resource_del_bulk_move_unevictable +1121 drivers/gpu/drm/ttm/ttm_bo_util.c

  1067	
  1068	/**
  1069	 * ttm_bo_shrink() - Helper to shrink a ttm buffer object.
  1070	 * @ctx: The struct ttm_operation_ctx used for the shrinking operation.
  1071	 * @bo: The buffer object.
  1072	 * @flags: Flags governing the shrinking behaviour.
  1073	 *
  1074	 * The function uses the ttm_tt_back_up functionality to back up or
  1075	 * purge a struct ttm_tt. If the bo is not in system, it's first
  1076	 * moved there.
  1077	 *
  1078	 * Return: The number of pages shrunken or purged, or
  1079	 * negative error code on failure.
  1080	 */
  1081	long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
  1082			   const struct ttm_bo_shrink_flags flags)
  1083	{
  1084		static const struct ttm_place sys_placement_flags = {
  1085			.fpfn = 0,
  1086			.lpfn = 0,
  1087			.mem_type = TTM_PL_SYSTEM,
  1088			.flags = 0,
  1089		};
  1090		static struct ttm_placement sys_placement = {
  1091			.num_placement = 1,
  1092			.placement = &sys_placement_flags,
  1093		};
  1094		struct ttm_device *bdev = bo->bdev;
  1095		long lret;
  1096	
  1097		dma_resv_assert_held(bo->base.resv);
  1098	
  1099		if (flags.allow_move && bo->resource->mem_type != TTM_PL_SYSTEM) {
  1100			int ret = ttm_bo_validate(bo, &sys_placement, ctx);
  1101	
  1102			/* Consider -ENOMEM and -ENOSPC non-fatal. */
  1103			if (ret) {
  1104				if (ret == -ENOMEM || ret == -ENOSPC)
  1105					ret = -EBUSY;
  1106				return ret;
  1107			}
  1108		}
  1109	
  1110		ttm_bo_unmap_virtual(bo);
  1111		lret = ttm_bo_wait_ctx(bo, ctx);
  1112		if (lret < 0)
  1113			return lret;
  1114	
  1115		lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
  1116				     {.purge = flags.purge,
  1117				      .writeback = flags.writeback});
  1118	
  1119		if (lret > 0) {
  1120			spin_lock(&bdev->lru_lock);
> 1121			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
  1122			ttm_resource_move_to_lru_tail(bo->resource);
  1123			spin_unlock(&bdev->lru_lock);
  1124		}
  1125	
  1126		if (lret < 0 && lret != -EINTR)
  1127			return -EBUSY;
  1128	
  1129		return lret;
  1130	}
  1131	EXPORT_SYMBOL(ttm_bo_shrink);
  1132	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
