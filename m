Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185A606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eQ4nyJZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0772C10EC49;
	Thu,  5 Nov 2026 04:50:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3BF10EC49;
 Thu,  5 Nov 2026 04:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793854253; x=1825390253;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mayL5uxjA06wbOsebndl7WWQByciFzyi8puZ0FzXVeo=;
 b=eQ4nyJZgW4VohMzOJrV8LeSIDhLAovMlRq2WhUxbuBaslTpFwiijqVAH
 1Hn7HPFLJRtYu6ABVMI/tITaIE2XwpDyKvhe31sgSL/1gRuDU+s8DdnZ0
 KRodoyU0Ilh+Sym1qETGoK9tgozjsRetSaTYvYeEfNAvzdfx9DgCp6xrn
 JYdK4VZz+1/TXk9zk6OWI5iKnfuz5jYjVwxoN7A3EAJ2q76uaWdEOOTWp
 UgNsEGB1iTHyblvwc+EBstwilx1lH0MXFJM9BJLmxXXyedr4JR4WrfX+4
 Of9FkNHCc/zWfMjQbmiV4Bdue8MlQpOFjA0N4tJ+RbrSrfUXviqjh8yG0 g==;
X-CSE-ConnectionGUID: KQJ/0tJcS66mqUPuKbwF7Q==
X-CSE-MsgGUID: EqbCEkUYSrqz2tbWI3AtEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2514736"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2514736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 20:50:53 -0800
X-CSE-ConnectionGUID: 9TMHlpgmTKub36UmJXnIEQ==
X-CSE-MsgGUID: 42NBspJERJCUUbkNeJcLTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6747481"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa008.jf.intel.com with ESMTP; 04 Nov 2026 20:50:50 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xOpR1-00000000lfL-3JJn;
 Thu, 05 Nov 2026 04:50:47 +0000
Date: Thu, 5 Nov 2026 12:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/ttm, drm/xe: Introduce TTM_TT_FLAG_PARTIAL for
 partially backed-up tts
Message-ID: <202611051209.k3623JDY-lkp@intel.com>
References: <20261104201331.2462-4-thomas.hellstrom@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104201331.2462-4-thomas.hellstrom@linux.intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on drm-tip/drm-tip next-20261030]
[cannot apply to drm-misc/drm-misc-next daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes linus/master v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Hellstr-m/drm-ttm-Don-t-mark-backed-up-shmem-folios-accessed/20261104-211328
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20261104201331.2462-4-thomas.hellstrom%40linux.intel.com
patch subject: [PATCH 3/4] drm/ttm, drm/xe: Introduce TTM_TT_FLAG_PARTIAL for partially backed-up tts
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261105/202611051209.k3623JDY-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051209.k3623JDY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051209.k3623JDY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/ttm/ttm_pool.c:1076:17: warning: variable 'mid' set but not used [-Wunused-but-set-variable]
    1076 |         pgoff_t i, nr, mid;
         |                        ^
>> drivers/gpu/drm/ttm/ttm_pool.c:1177:7: warning: unused variable 'partial' [-Wunused-variable]
    1177 |         bool partial = ttm_tt_is_partial(tt);
         |              ^~~~~~~
   2 warnings generated.


vim +/mid +1076 drivers/gpu/drm/ttm/ttm_pool.c

  1059	
  1060	/**
  1061	 * ttm_pool_restore_abort() - Abort an ongoing restore of a partial tt
  1062	 * @tt: The struct ttm_tt with an active restore.
  1063	 *
  1064	 * Abort a partially completed restore, leaving the tt in a consistent
  1065	 * state for a subsequent backup. The uncommitted in-flight page is
  1066	 * DMA-unmapped and split; restored sub-pages are kept, unused ones freed.
  1067	 * Non-cached committed pages are converted to write-back so the
  1068	 * partial-backup invariant (all resident pages are cached) is maintained.
  1069	 * Committed pages are left DMA-mapped for the backup path to handle.
  1070	 * Since restored pages are now resident, &ttm_tt.remaining_pages is
  1071	 * updated to reflect the number of resident pages.
  1072	 */
  1073	static void ttm_pool_restore_abort(struct ttm_tt *tt)
  1074	{
  1075		struct ttm_pool_tt_restore *restore = tt->restore;
> 1076		pgoff_t i, nr, mid;
  1077	
  1078		if (!restore)
  1079			return;
  1080	
  1081		/* Handle the uncommitted in-flight page. */
  1082		if (ttm_pool_restore_valid(restore)) {
  1083			struct page *page = restore->alloced_page;
  1084	
  1085			nr = 1UL << restore->order;
  1086	
  1087			if (tt->dma_address)
  1088				ttm_pool_unmap(restore->pool, restore->first_dma, nr);
  1089	
  1090	#ifdef CONFIG_X86
  1091			if (restore->page_caching != ttm_cached && !PageHighMem(page))
  1092				set_pages_wb(page, nr);
  1093	#endif
  1094			ttm_pool_split_for_swap(restore->pool, page);
  1095	
  1096			for (i = 0; i < restore->restored_pages; i++)
  1097				restore->snapshot_alloc.pages[i] = page + i;
  1098	
  1099			/*
  1100			 * Clear stale DMA addresses for the in-flight sub-pages.
  1101			 * These pages were never committed via
  1102			 * ttm_pool_allocated_page_commit(), so tt->dma_address[]
  1103			 * contains stale values that the backup path would
  1104			 * incorrectly try to unmap. All @nr entries are stale,
  1105			 * including restored ones: commit is all-or-nothing per
  1106			 * compound, and the whole compound was unmapped above.
  1107			 */
  1108			if (tt->dma_address) {
  1109				pgoff_t off = restore->snapshot_alloc.pages -
  1110					      tt->pages;
  1111	
  1112				memset(&tt->dma_address[off], 0,
  1113				       nr * sizeof(*tt->dma_address));
  1114			}
  1115	
  1116			for (i = restore->restored_pages; i < nr; i++)
  1117				__free_pages_gpu_account(page + i, 0, false);
  1118		}
  1119	
  1120		/*
  1121		 * Don't DMA-unmap committed restored pages here; their DMA
  1122		 * addresses are in tt->dma_address[] and the backup path
  1123		 * will unmap them.
  1124		 */
  1125	
  1126		/* Convert non-cached committed pages to write-back. */
  1127		mid = restore->snapshot_alloc.caching_divide - tt->pages;
  1128	#ifdef CONFIG_X86
  1129		if (mid > 0 && tt->caching != ttm_cached)
  1130			set_pages_array_wb(tt->pages, mid);
  1131	#endif
  1132	
  1133		kfree(restore);
  1134		tt->restore = NULL;
  1135	
  1136		for (i = 0, nr = 0; i < tt->num_pages; i++) {
  1137			struct page *p = tt->pages[i];
  1138	
  1139			if (p && !ttm_backup_page_ptr_is_handle(p))
  1140				nr++;
  1141		}
  1142		tt->remaining_pages = nr;
  1143	}
  1144	
  1145	/**
  1146	 * ttm_pool_backup() - Back up or purge a struct ttm_tt
  1147	 * @pool: The pool used when allocating the struct ttm_tt.
  1148	 * @tt: The struct ttm_tt.
  1149	 * @flags: Flags to govern the backup behaviour.
  1150	 *
  1151	 * Back up or purge a struct ttm_tt. If @purge is true, then
  1152	 * all pages will be freed directly to the system rather than to the pool
  1153	 * they were allocated from, making the function behave similarly to
  1154	 * ttm_pool_free(). If @purge is false the pages will be backed up instead,
  1155	 * exchanged for handles.
  1156	 * A subsequent call to ttm_pool_restore_and_alloc() will then read back the content and
  1157	 * a subsequent call to ttm_pool_drop_backed_up() will drop it.
  1158	 * If backup of a page fails for whatever reason, @ttm will still be
  1159	 * partially backed up, retaining those pages for which backup fails.
  1160	 * In that case, this function can be retried, possibly after freeing up
  1161	 * memory resources.
  1162	 *
  1163	 * Return: Number of pages actually backed up or freed, or negative
  1164	 * error code on error.
  1165	 */
  1166	long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
  1167			     const struct ttm_backup_flags *flags)
  1168	{
  1169		struct file *backup = tt->backup;
  1170		struct page *page;
  1171		gfp_t alloc_gfp;
  1172		gfp_t gfp;
  1173		int ret = 0;
  1174		pgoff_t shrunken = 0;
  1175		pgoff_t i, j, num_pages, npages;
  1176		pgoff_t nr_backed;
> 1177		bool partial = ttm_tt_is_partial(tt);
  1178	
  1179		if (WARN_ON(ttm_tt_is_backed_up(tt)))
  1180			return -EINVAL;
  1181	
  1182		ttm_pool_restore_abort(tt);
  1183	
  1184		if ((!ttm_backup_bytes_avail() && !flags->purge) ||
  1185		    ttm_pool_uses_dma_alloc(pool) || ttm_tt_is_backed_up(tt))
  1186			return -EBUSY;
  1187	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
