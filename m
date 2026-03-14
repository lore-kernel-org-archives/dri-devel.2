Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE41810706FF
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 19:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E497110E072;
	Sat, 14 Mar 2026 19:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Woeug8/L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B23A10E22A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 19:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773515173; x=1805051173;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=v3EoKgm2ivNf66z0g0GCk/Ytkkn5QAkZzV+I0bQuEH8=;
 b=Woeug8/LqZ7XbeCm1baQfb7HQ3Gf1H+4YCuxFbtygdNl4r97aImZ53r8
 1JnIPIp+LJ7ptAPiWgrWQOHkzmZrgvUaV6sGQckI8AiwwistJHaFuWepl
 SOtxMWblsHBPiz2ZGnWoG39mBdg3gqpzgsu8MkGtmsXPg2PYjaTKcOyWf
 uo4qWLhvfvBXgNVv1q6FBROiiLbqd6r2GdKr0psIaeqOY54POEjjrr9i4
 2Znxim3oM6XHioe5qcu+tGa0GE4U/tXKeRnOgtmEqZdrvrFVYsIbXQUlh
 Q7LrHi0Wxtuhea7gzT9jOhDhpP2r0i62d5tfsoCzEZhzU9laeryDIBS5A Q==;
X-CSE-ConnectionGUID: ZtAP3HKeQqaVNIDvLglRAQ==
X-CSE-MsgGUID: ejkcrtG6Qki64ZZJGpe2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74481183"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="74481183"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2026 12:06:12 -0700
X-CSE-ConnectionGUID: ms0u+3/UR6C4NdXbWExiAA==
X-CSE-MsgGUID: 8saqSGTVQ8SsZEq7EF3uog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; d="scan'208";a="226478118"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
 by orviesa005.jf.intel.com with ESMTP; 14 Mar 2026 12:06:10 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w1UJK-000000005b1-0w8v;
 Sat, 14 Mar 2026 19:06:06 +0000
Date: Sun, 15 Mar 2026 03:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Loic Molinari <loic.molinari@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: Re: [PATCH] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <202603150233.7ZFf6Fsm-lkp@intel.com>
References: <20260312155027.1682606-1-pedrodemargomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155027.1682606-1-pedrodemargomes@gmail.com>
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

Hi Pedro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc3]
[cannot apply to drm-misc/drm-misc-next next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pedro-Demarchi-Gomes/drm-shmem-helper-Fix-Map-huge-page-mapping-in-fault-handler/20260314-094433
base:   linus/master
patch link:    https://lore.kernel.org/r/20260312155027.1682606-1-pedrodemargomes%40gmail.com
patch subject: [PATCH] drm/shmem-helper: Fix Map huge page mapping in fault handler
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260315/202603150233.7ZFf6Fsm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150233.7ZFf6Fsm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150233.7ZFf6Fsm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gem_shmem_helper.c:554:19: warning: 'drm_gem_shmem_huge_fault' defined but not used [-Wunused-function]
     554 | static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/drm_gem_shmem_huge_fault +554 drivers/gpu/drm/drm_gem_shmem_helper.c

   552	
   553	
 > 554	static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
   555						   unsigned int order)
   556	{
   557		struct vm_area_struct *vma = vmf->vma;
   558		struct drm_gem_object *obj = vma->vm_private_data;
   559		struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
   560		loff_t num_pages = obj->size >> PAGE_SHIFT;
   561		vm_fault_t ret = VM_FAULT_FALLBACK;
   562		struct page **pages = shmem->pages;
   563		pgoff_t page_offset;
   564		unsigned long pfn;
   565		unsigned long paddr;
   566		bool aligned;
   567		struct page *page;
   568	
   569		if (order != PMD_ORDER)
   570			goto out_unlocked;
   571	
   572		/* Offset to faulty address in the VMA. */
   573		page_offset = vmf->pgoff - vma->vm_pgoff;
   574	
   575		dma_resv_lock(shmem->base.resv, NULL);
   576	
   577		if (page_offset >= num_pages ||
   578		    drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
   579		    shmem->madv < 0) {
   580			ret = VM_FAULT_SIGBUS;
   581			goto out;
   582		}
   583	
   584		page = pages[page_offset];
   585		pfn = page_to_pfn(page);
   586		paddr = pfn << PAGE_SHIFT;
   587		aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
   588	
   589		if (aligned &&
   590		    folio_test_pmd_mappable(page_folio(page))) {
   591			pfn &= PMD_MASK >> PAGE_SHIFT;
   592			ret = vmf_insert_pfn_pmd(vmf, pfn, false);
   593		}
   594	
   595	 out:
   596		dma_resv_unlock(shmem->base.resv);
   597	
   598	 out_unlocked:
   599		return ret;
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
