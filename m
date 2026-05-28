Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D57CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F7410EF9E;
	Thu, 28 May 2026 10:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AwFcc2T1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAD810EF9E
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779963801; x=1811499801;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ka4dqkKXiaoSIrqEW/co4iBfNrpr3bkYU5jiBBI6700=;
 b=AwFcc2T1AIitwMIss7UBAU2uihXyHjc1hkCmm0TNC/gCLOezzOJCv0Km
 h3/o79i0nMl9OKYbVdAEQuvZL88LTN9fhi7dKxT/Sfd1yFfQJvm8VNqlu
 CsflqX+Z9vUB3XL4D3ZckhipEb1tMcYT5pUqJ0+141OXcjhjCuDa+9wGr
 HFFzKl2QJFsKgcnRWS+KIG6Tn6WAQy63AtdGMVMswvYmFmQJgd9K/JfUM
 bQFgcBE76RIRP3I0Q34Avhe+dcdxZw8WCoafxN0uBDpVfUkU1tYHgrrDu
 ymKqqoGGaIPiP7ZI6a16Lg/ziTlBVAeVu6KYcRX1RLySH3pUiL2x+FcUS g==;
X-CSE-ConnectionGUID: xoe3wzXKS5+qIbBU/xzpcg==
X-CSE-MsgGUID: SMSNa3RGTGqJ1AbsjBWpIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80831212"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="80831212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 03:23:20 -0700
X-CSE-ConnectionGUID: 4e6Lg948ScyWBGo3dD7oTg==
X-CSE-MsgGUID: FYhj2vLeSWarY/Tzszl07g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="238090938"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 28 May 2026 03:23:15 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wSXtP-000000005q6-1If0;
 Thu, 28 May 2026 10:23:11 +0000
Date: Thu, 28 May 2026 18:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 syzbot <syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 apopple@nvidia.com, byungchul@sk.com, david@kernel.org,
 gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, matthew.brost@intel.com,
 rakie.kim@sk.com, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/lease: Limit amount of maximum objects per lease.
Message-ID: <202605281856.LeAMyg6G-lkp@intel.com>
References: <b3390013-f0de-4e23-a915-23340594fb49@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3390013-f0de-4e23-a915-23340594fb49@linux.intel.com>
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

Hi Maarten,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on akpm-mm/mm-everything daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.1-rc5 next-20260527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/drm-lease-Limit-amount-of-maximum-objects-per-lease/20260527-180216
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/b3390013-f0de-4e23-a915-23340594fb49%40linux.intel.com
patch subject: [PATCH] drm/lease: Limit amount of maximum objects per lease.
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260528/202605281856.LeAMyg6G-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281856.LeAMyg6G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281856.LeAMyg6G-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_lease.c:13:
   drivers/gpu/drm/drm_lease.c: In function 'drm_mode_create_lease_ioctl':
>> drivers/gpu/drm/drm_lease.c:513:36: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     513 |                 drm_dbg_lease(dev, "too many objects (%ld)\n", object_count);
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~
         |                                                                |
         |                                                                size_t {aka unsigned int}
   include/drm/drm_print.h:563:39: note: in definition of macro 'drm_dev_dbg'
     563 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
         |                                       ^~~
   drivers/gpu/drm/drm_lease.c:513:17: note: in expansion of macro 'drm_dbg_lease'
     513 |                 drm_dbg_lease(dev, "too many objects (%ld)\n", object_count);
         |                 ^~~~~~~~~~~~~
   drivers/gpu/drm/drm_lease.c:513:57: note: format string is defined here
     513 |                 drm_dbg_lease(dev, "too many objects (%ld)\n", object_count);
         |                                                       ~~^
         |                                                         |
         |                                                         long int
         |                                                       %d


vim +513 drivers/gpu/drm/drm_lease.c

   468	
   469	/*
   470	 * The master associated with the specified file will have a lease
   471	 * created containing the objects specified in the ioctl structure.
   472	 * A file descriptor will be allocated for that and returned to the
   473	 * application.
   474	 */
   475	int drm_mode_create_lease_ioctl(struct drm_device *dev,
   476					void *data, struct drm_file *lessor_priv)
   477	{
   478		struct drm_mode_create_lease *cl = data;
   479		size_t object_count;
   480		int ret = 0;
   481		struct idr leases;
   482		struct drm_master *lessor;
   483		struct drm_master *lessee = NULL;
   484		struct file *lessee_file = NULL;
   485		struct file *lessor_file = lessor_priv->filp;
   486		struct drm_file *lessee_priv;
   487		int fd = -1;
   488		uint32_t *object_ids;
   489		static const size_t max_objects =
   490			8 * sizeof(drm_crtc_mask(NULL)) +
   491			8 * sizeof(drm_plane_mask(NULL)) +
   492			8 * sizeof(drm_connector_mask(NULL));
   493	
   494		/* Can't lease without MODESET */
   495		if (!drm_core_check_feature(dev, DRIVER_MODESET))
   496			return -EOPNOTSUPP;
   497	
   498		if (cl->flags && (cl->flags & ~(O_CLOEXEC | O_NONBLOCK))) {
   499			drm_dbg_lease(dev, "invalid flags\n");
   500			return -EINVAL;
   501		}
   502	
   503		lessor = drm_file_get_master(lessor_priv);
   504		/* Do not allow sub-leases */
   505		if (lessor->lessor) {
   506			drm_dbg_lease(dev, "recursive leasing not allowed\n");
   507			ret = -EINVAL;
   508			goto out_lessor;
   509		}
   510	
   511		object_count = cl->object_count;
   512		if (object_count > max_objects) {
 > 513			drm_dbg_lease(dev, "too many objects (%ld)\n", object_count);
   514			ret = -EINVAL;
   515			goto out_lessor;
   516		}
   517	
   518		/* Handle leased objects, if any */
   519		idr_init(&leases);
   520		if (object_count != 0) {
   521			object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
   522						       object_count, sizeof(__u32));
   523			if (IS_ERR(object_ids)) {
   524				ret = PTR_ERR(object_ids);
   525				idr_destroy(&leases);
   526				goto out_lessor;
   527			}
   528	
   529			/* fill and validate the object idr */
   530			ret = fill_object_idr(dev, lessor_priv, &leases,
   531					      object_count, object_ids);
   532			kfree(object_ids);
   533			if (ret) {
   534				drm_dbg_lease(dev, "lease object lookup failed: %i\n", ret);
   535				idr_destroy(&leases);
   536				goto out_lessor;
   537			}
   538		}
   539	
   540		/* Allocate a file descriptor for the lease */
   541		fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
   542		if (fd < 0) {
   543			idr_destroy(&leases);
   544			ret = fd;
   545			goto out_lessor;
   546		}
   547	
   548		drm_dbg_lease(dev, "Creating lease\n");
   549		/* lessee will take the ownership of leases */
   550		lessee = drm_lease_create(lessor, &leases);
   551	
   552		if (IS_ERR(lessee)) {
   553			ret = PTR_ERR(lessee);
   554			idr_destroy(&leases);
   555			goto out_leases;
   556		}
   557	
   558		/* Clone the lessor file to create a new file for us */
   559		drm_dbg_lease(dev, "Allocating lease file\n");
   560		lessee_file = file_clone_open(lessor_file);
   561		if (IS_ERR(lessee_file)) {
   562			ret = PTR_ERR(lessee_file);
   563			goto out_lessee;
   564		}
   565	
   566		lessee_priv = lessee_file->private_data;
   567		/* Change the file to a master one */
   568		drm_master_put(&lessee_priv->master);
   569		lessee_priv->master = lessee;
   570		lessee_priv->is_master = 1;
   571		lessee_priv->authenticated = 1;
   572	
   573		/* Pass fd back to userspace */
   574		drm_dbg_lease(dev, "Returning fd %d id %d\n", fd, lessee->lessee_id);
   575		cl->fd = fd;
   576		cl->lessee_id = lessee->lessee_id;
   577	
   578		/* Hook up the fd */
   579		fd_install(fd, lessee_file);
   580	
   581		drm_master_put(&lessor);
   582		drm_dbg_lease(dev, "drm_mode_create_lease_ioctl succeeded\n");
   583		return 0;
   584	
   585	out_lessee:
   586		drm_master_put(&lessee);
   587	
   588	out_leases:
   589		put_unused_fd(fd);
   590	
   591	out_lessor:
   592		drm_master_put(&lessor);
   593		drm_dbg_lease(dev, "drm_mode_create_lease_ioctl failed: %d\n", ret);
   594		return ret;
   595	}
   596	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
