Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B0BC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469F910E607;
	Thu, 17 Sep 2026 07:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gfjNXBl+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54210E607
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789630576; x=1821166576;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fFsXsdJmM+T4Frta7q8+ZDhdN43sXhlIZkM4hMO7Tzo=;
 b=gfjNXBl+m2QW0iL79eHdj2QuBLlvOkYPvOut1qmZLhI3ZZSA4qZ9hUUY
 JD7ZB37/zgFSJ2w4Ba7AHsmn+vh4a9N8kNMJzKMtlJNTN5L3DxAxz3ZtZ
 GFct1nFTnCeWU16oBxcBu8VGO2YOtsb3YIR6GSrajI59+1lZjJBzy3yGV
 j5HobUpUL0b+76nz/Bame0eHazQHsgLg/R56wBJ89kHNdSk4/M5e+mEr8
 ZI1Jh32r5+EYHUv8a72YRHM3heWY3C8a+PQHda7xCqAkYtnFYPhyJcJ7i
 /HyLan60jWVMZEa+Xr/5SUTAi/x1QWi8eBWvaJlLaDvKKYfzw1ahzAF+J w==;
X-CSE-ConnectionGUID: xJJ+LvY1TsOOY7ekFHPHkA==
X-CSE-MsgGUID: Tmb2EWzdQ6q1oihzXhKErQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93851406"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93851406"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 00:36:16 -0700
X-CSE-ConnectionGUID: +aL9pj8+TmC9blf2PDAP1A==
X-CSE-MsgGUID: b9575PWxRCCOdcnOvfVcvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297122013"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 00:36:13 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x76fB-000000007GH-3VKM;
 Thu, 17 Sep 2026 07:36:09 +0000
Date: Thu, 17 Sep 2026 15:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, mperttunen@nvidia.com, simona@ffwll.ch,
 thierry.reding@kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Fix bo reference leak in
 host1x_reloc_copy_from_user()
Message-ID: <202609171531.CIG2e49k-lkp@intel.com>
References: <20260916182550.2091797-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182550.2091797-1-vulab@iscas.ac.cn>
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

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-tegra-Fix-bo-reference-leak-in-host1x_reloc_copy_from_user/20260916-182550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20260916182550.2091797-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/tegra: Fix bo reference leak in host1x_reloc_copy_from_user()
config: arc-randconfig-1001-20260917 (https://download.01.org/0day-ci/archive/20260917/202609171531.CIG2e49k-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171531.CIG2e49k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171531.CIG2e49k-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tegra/drm.c: In function 'host1x_reloc_copy_from_user':
>> drivers/gpu/drm/tegra/drm.c:163:48: error: passing argument 1 of 'drm_gem_object_put' from incompatible pointer type [-Wincompatible-pointer-types]
     163 |                 drm_gem_object_put(dest->cmdbuf.bo);
         |                                    ~~~~~~~~~~~~^~~
         |                                                |
         |                                                struct host1x_bo *
   In file included from include/drm/drm_gpuvm.h:35,
                    from include/drm/drm_debugfs.h:38,
                    from drivers/gpu/drm/tegra/drm.c:19:
   include/drm/drm_gem.h:572:43: note: expected 'struct drm_gem_object *' but argument is of type 'struct host1x_bo *'
     572 | drm_gem_object_put(struct drm_gem_object *obj)
         |                    ~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +/drm_gem_object_put +163 drivers/gpu/drm/tegra/drm.c

   126	
   127	static int host1x_reloc_copy_from_user(struct host1x_reloc *dest,
   128					       struct drm_tegra_reloc __user *src,
   129					       struct drm_device *drm,
   130					       struct drm_file *file)
   131	{
   132		u32 cmdbuf, target;
   133		int err;
   134	
   135		err = get_user(cmdbuf, &src->cmdbuf.handle);
   136		if (err < 0)
   137			return err;
   138	
   139		err = get_user(dest->cmdbuf.offset, &src->cmdbuf.offset);
   140		if (err < 0)
   141			return err;
   142	
   143		err = get_user(target, &src->target.handle);
   144		if (err < 0)
   145			return err;
   146	
   147		err = get_user(dest->target.offset, &src->target.offset);
   148		if (err < 0)
   149			return err;
   150	
   151		err = get_user(dest->shift, &src->shift);
   152		if (err < 0)
   153			return err;
   154	
   155		dest->flags = HOST1X_RELOC_READ | HOST1X_RELOC_WRITE;
   156	
   157		dest->cmdbuf.bo = tegra_gem_lookup(file, cmdbuf);
   158		if (!dest->cmdbuf.bo)
   159			return -ENOENT;
   160	
   161		dest->target.bo = tegra_gem_lookup(file, target);
   162		if (!dest->target.bo) {
 > 163			drm_gem_object_put(dest->cmdbuf.bo);
   164			return -ENOENT;
   165		}
   166	
   167		return 0;
   168	}
   169	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
