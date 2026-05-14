Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB87CD4846
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 03:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F8B10E16E;
	Thu, 14 May 2026 03:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HYZ+A3Ew";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3041A10E0C2;
 Thu, 14 May 2026 03:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778731000; x=1810267000;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nNXzELtutpEq+OmJxmrD51XitSjV4T7MrHzTWpLXGqs=;
 b=HYZ+A3EwF52lVNkBtMJjiUPbi4kwcKUltDHunEyzMIQHF11CiqXyQWv2
 lpy0J/JenKlAxjZKTVSt34aPuhD+bwn3KvhiKBXms45FE3N8/i4EI8A2C
 hyEKLOUXMTls/fXQt+jN/rcWgQ3WofG8yJ9C0RQ7BafD1+JyoidhQcggQ
 OPSFpWxTsjBEyx6XV8MHdt0Ao2GHCdHDTB1/UmfwNsEZCAzini6+7iX+L
 A5TfBnqUe1eQYZwc1pTwGAlaYZ+CmBDfjO6BnTwUwcrd+hsiGlcajRPe6
 wRsEoSi0VhRZOsPwq3o0tpBsZvRFcfZIyUA/n6GFtLRny28tSOogINkqs g==;
X-CSE-ConnectionGUID: +Ms7QPjcR7uPtjoGVsXl2g==
X-CSE-MsgGUID: e6M/VWqPQIaG/3/+Eo86MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79564425"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79564425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 20:56:39 -0700
X-CSE-ConnectionGUID: ZFJEVrqUR0CG+RnG12WEVg==
X-CSE-MsgGUID: DhVLug9hRyiwfjGsvKVn5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="243251014"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 13 May 2026 20:56:35 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wNNBX-000000005mN-0hyq;
 Thu, 14 May 2026 03:56:31 +0000
Date: Thu, 14 May 2026 11:56:05 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <202605141138.kI3vechU-lkp@intel.com>
References: <20260512-panthor-shrinker-fixes-v3-1-3bf066259471@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-panthor-shrinker-fixes-v3-1-3bf066259471@collabora.com>
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

Hi Boris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b2ed01e7ad3de80333e9b962a44024b094bc0b2b]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Brezillon/drm-gem-Make-the-GEM-LRU-lock-part-of-drm_device/20260514-051749
base:   b2ed01e7ad3de80333e9b962a44024b094bc0b2b
patch link:    https://lore.kernel.org/r/20260512-panthor-shrinker-fixes-v3-1-3bf066259471%40collabora.com
patch subject: [PATCH v3] drm/gem: Make the GEM LRU lock part of drm_device
config: arm-randconfig-002-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141138.kI3vechU-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141138.kI3vechU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141138.kI3vechU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/msm_gem.c:827:26: warning: unused variable 'priv' [-Wunused-variable]
     827 |         struct msm_drm_private *priv = obj->dev->dev_private;
         |                                 ^~~~
   1 warning generated.


vim +/priv +827 drivers/gpu/drm/msm/msm_gem.c

4cd33c48ea25ba1 Rob Clark             2016-05-17  823  
599089c6af68300 Rob Clark             2020-10-23  824  void msm_gem_purge(struct drm_gem_object *obj)
68209390f116034 Rob Clark             2016-05-17  825  {
68209390f116034 Rob Clark             2016-05-17  826  	struct drm_device *dev = obj->dev;
6c7c8fb863f7c31 Rob Clark             2023-03-20 @827  	struct msm_drm_private *priv = obj->dev->dev_private;
68209390f116034 Rob Clark             2016-05-17  828  	struct msm_gem_object *msm_obj = to_msm_bo(obj);
68209390f116034 Rob Clark             2016-05-17  829  
d4d7d3630d703ff Rob Clark             2022-08-02  830  	msm_gem_assert_locked(obj);
90643a24a7bfbe9 Rob Clark             2021-04-05  831  	GEM_WARN_ON(!is_purgeable(msm_obj));
68209390f116034 Rob Clark             2016-05-17  832  
20d0ae2f8c72e36 Rob Clark             2021-04-05  833  	/* Get rid of any iommu mapping(s): */
0b4339c55ef59ff Rob Clark             2025-06-29  834  	put_iova_spaces(obj, NULL, false, "purge");
0e08270a1f01bce Sushmita Susheelendra 2017-06-13  835  
599089c6af68300 Rob Clark             2020-10-23  836  	msm_gem_vunmap(obj);
68209390f116034 Rob Clark             2016-05-17  837  
81d4d597d4faadb Rob Clark             2021-04-05  838  	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
81d4d597d4faadb Rob Clark             2021-04-05  839  
68209390f116034 Rob Clark             2016-05-17  840  	put_pages(obj);
68209390f116034 Rob Clark             2016-05-17  841  
c20ad1ee88c074c Boris Brezillon       2026-05-12  842  	mutex_lock(&dev->gem_lru_mutex);
6c7c8fb863f7c31 Rob Clark             2023-03-20  843  	/* A one-way transition: */
68209390f116034 Rob Clark             2016-05-17  844  	msm_obj->madv = __MSM_MADV_PURGED;
c20ad1ee88c074c Boris Brezillon       2026-05-12  845  	mutex_unlock(&dev->gem_lru_mutex);
68209390f116034 Rob Clark             2016-05-17  846  
68209390f116034 Rob Clark             2016-05-17  847  	drm_gem_free_mmap_offset(obj);
68209390f116034 Rob Clark             2016-05-17  848  
68209390f116034 Rob Clark             2016-05-17  849  	/* Our goal here is to return as much of the memory as
68209390f116034 Rob Clark             2016-05-17  850  	 * is possible back to the system as we are called from OOM.
68209390f116034 Rob Clark             2016-05-17  851  	 * To do this we must instruct the shmfs to drop all of its
68209390f116034 Rob Clark             2016-05-17  852  	 * backing pages, *now*.
68209390f116034 Rob Clark             2016-05-17  853  	 */
68209390f116034 Rob Clark             2016-05-17  854  	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1);
68209390f116034 Rob Clark             2016-05-17  855  
68209390f116034 Rob Clark             2016-05-17  856  	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping,
68209390f116034 Rob Clark             2016-05-17  857  			0, (loff_t)-1);
68209390f116034 Rob Clark             2016-05-17  858  }
68209390f116034 Rob Clark             2016-05-17  859  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
