Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C4FD58B17
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 12:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63F810E14C;
	Sun, 15 Mar 2026 12:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FYBYrVMW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C3E10E14C;
 Sun, 15 Mar 2026 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773577944; x=1805113944;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oI6MMjdrRiaCAiLm+4uAHBkh86Uge9u2mrxFB1RgqEA=;
 b=FYBYrVMWVLoCXY1bQb6Wqmx6pAReHf2vld/znmhExgl/5uUQS2JlxG87
 J7Yh8eHE20Pro4AqDqINtUCKX9htJVwSvCId9BA1wWmebnt8fq2IN5PoE
 ymS9uozo8iforCH8clHuIZ9VoWWXq/6dp45YJnpWSfx42JvsPusJB9OQE
 hn7oo0ML4pMngvfPYMpMdu6VJcrBherOaoaXjyqawmoUtjzxN3mMoX3g5
 9ufhaBklnsZ+saCKnTEp4UpwP+2Nrcs4z3aomcBaKlTe4QNr1DXOHoMjj
 EfHwjupTGENw2wAhYeRqi6QFm6Ip6bCxvYkFaYBOM7UM137PKh9U/dNEL g==;
X-CSE-ConnectionGUID: 7IrYrytDSSezOk2IFbyUXA==
X-CSE-MsgGUID: ZM8qw4xbRAq2nWTQgi9xBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74583986"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; d="scan'208";a="74583986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 05:32:24 -0700
X-CSE-ConnectionGUID: OvcvSN/VRY6kcg8sUlkdvA==
X-CSE-MsgGUID: bNt8mSvJTS+UeALy/t88Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; d="scan'208";a="259528675"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
 by orviesa001.jf.intel.com with ESMTP; 15 Mar 2026 05:32:22 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w1kdn-000000006WR-39ic;
 Sun, 15 Mar 2026 12:32:19 +0000
Date: Sun, 15 Mar 2026 20:31:47 +0800
From: kernel test robot <lkp@intel.com>
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 2/4] drm/pagemap: Add helper to access zone_device_data
Message-ID: <202603152031.EJj7lRw4-lkp@intel.com>
References: <20260312151726.1779566-3-francois.dugast@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312151726.1779566-3-francois.dugast@intel.com>
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

Hi Francois,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.0-rc3 next-20260311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francois-Dugast/drm-pagemap-Unlock-and-put-folios-when-possible/20260314-185018
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260312151726.1779566-3-francois.dugast%40intel.com
patch subject: [PATCH v8 2/4] drm/pagemap: Add helper to access zone_device_data
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260315/202603152031.EJj7lRw4-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 7d47b695929cc7f85eeb0f87d0189adc04c1c629)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603152031.EJj7lRw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603152031.EJj7lRw4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpusvm.c:1492:5: error: call to undeclared function 'drm_pagemap_page_zone_device_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1492 |                                 drm_pagemap_page_zone_device_data(page);
         |                                 ^
   drivers/gpu/drm/drm_gpusvm.c:1492:5: note: did you mean 'drm_pagemap_page_to_dpagemap'?
   include/drm/drm_pagemap.h:264:35: note: 'drm_pagemap_page_to_dpagemap' declared here
     264 | static inline struct drm_pagemap *drm_pagemap_page_to_dpagemap(struct page *page)
         |                                   ^
>> drivers/gpu/drm/drm_gpusvm.c:1491:28: error: incompatible integer to pointer conversion initializing 'struct drm_pagemap_zdd *' with an expression of type 'int' [-Wint-conversion]
    1491 |                         struct drm_pagemap_zdd *__zdd =
         |                                                 ^
    1492 |                                 drm_pagemap_page_zone_device_data(page);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/drm_pagemap_page_zone_device_data +1492 drivers/gpu/drm/drm_gpusvm.c

  1366	
  1367	/**
  1368	 * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
  1369	 * @gpusvm: Pointer to the GPU SVM structure
  1370	 * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
  1371	 * @mm: The mm corresponding to the CPU range
  1372	 * @notifier: The corresponding notifier for the given CPU range
  1373	 * @pages_start: Start CPU address for the pages
  1374	 * @pages_end: End CPU address for the pages (exclusive)
  1375	 * @ctx: GPU SVM context
  1376	 *
  1377	 * This function gets and maps pages for CPU range and ensures they are
  1378	 * mapped for DMA access.
  1379	 *
  1380	 * Return: 0 on success, negative error code on failure.
  1381	 */
  1382	int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
  1383				 struct drm_gpusvm_pages *svm_pages,
  1384				 struct mm_struct *mm,
  1385				 struct mmu_interval_notifier *notifier,
  1386				 unsigned long pages_start, unsigned long pages_end,
  1387				 const struct drm_gpusvm_ctx *ctx)
  1388	{
  1389		struct hmm_range hmm_range = {
  1390			.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
  1391				HMM_PFN_REQ_WRITE),
  1392			.notifier = notifier,
  1393			.start = pages_start,
  1394			.end = pages_end,
  1395			.dev_private_owner = ctx->device_private_page_owner,
  1396		};
  1397		void *zdd;
  1398		unsigned long timeout =
  1399			jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
  1400		unsigned long i, j;
  1401		unsigned long npages = npages_in_range(pages_start, pages_end);
  1402		unsigned long num_dma_mapped;
  1403		unsigned int order = 0;
  1404		unsigned long *pfns;
  1405		int err = 0;
  1406		struct dev_pagemap *pagemap;
  1407		struct drm_pagemap *dpagemap;
  1408		struct drm_gpusvm_pages_flags flags;
  1409		enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
  1410								   DMA_BIDIRECTIONAL;
  1411	
  1412	retry:
  1413		if (time_after(jiffies, timeout))
  1414			return -EBUSY;
  1415	
  1416		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
  1417		if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
  1418			goto set_seqno;
  1419	
  1420		pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
  1421		if (!pfns)
  1422			return -ENOMEM;
  1423	
  1424		if (!mmget_not_zero(mm)) {
  1425			err = -EFAULT;
  1426			goto err_free;
  1427		}
  1428	
  1429		hmm_range.hmm_pfns = pfns;
  1430		while (true) {
  1431			mmap_read_lock(mm);
  1432			err = hmm_range_fault(&hmm_range);
  1433			mmap_read_unlock(mm);
  1434	
  1435			if (err == -EBUSY) {
  1436				if (time_after(jiffies, timeout))
  1437					break;
  1438	
  1439				hmm_range.notifier_seq =
  1440					mmu_interval_read_begin(notifier);
  1441				continue;
  1442			}
  1443			break;
  1444		}
  1445		mmput(mm);
  1446		if (err)
  1447			goto err_free;
  1448	
  1449	map_pages:
  1450		/*
  1451		 * Perform all dma mappings under the notifier lock to not
  1452		 * access freed pages. A notifier will either block on
  1453		 * the notifier lock or unmap dma.
  1454		 */
  1455		drm_gpusvm_notifier_lock(gpusvm);
  1456	
  1457		flags.__flags = svm_pages->flags.__flags;
  1458		if (flags.unmapped) {
  1459			drm_gpusvm_notifier_unlock(gpusvm);
  1460			err = -EFAULT;
  1461			goto err_free;
  1462		}
  1463	
  1464		if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
  1465			drm_gpusvm_notifier_unlock(gpusvm);
  1466			kvfree(pfns);
  1467			goto retry;
  1468		}
  1469	
  1470		if (!svm_pages->dma_addr) {
  1471			/* Unlock and restart mapping to allocate memory. */
  1472			drm_gpusvm_notifier_unlock(gpusvm);
  1473			svm_pages->dma_addr =
  1474				kvmalloc_objs(*svm_pages->dma_addr, npages);
  1475			if (!svm_pages->dma_addr) {
  1476				err = -ENOMEM;
  1477				goto err_free;
  1478			}
  1479			goto map_pages;
  1480		}
  1481	
  1482		zdd = NULL;
  1483		pagemap = NULL;
  1484		num_dma_mapped = 0;
  1485		for (i = 0, j = 0; i < npages; ++j) {
  1486			struct page *page = hmm_pfn_to_page(pfns[i]);
  1487	
  1488			order = drm_gpusvm_hmm_pfn_to_order(pfns[i], i, npages);
  1489			if (is_device_private_page(page) ||
  1490			    is_device_coherent_page(page)) {
> 1491				struct drm_pagemap_zdd *__zdd =
> 1492					drm_pagemap_page_zone_device_data(page);
  1493	
  1494				if (!ctx->allow_mixed &&
  1495				    zdd != __zdd && i > 0) {
  1496					err = -EOPNOTSUPP;
  1497					goto err_unmap;
  1498				}
  1499				zdd = __zdd;
  1500				if (pagemap != page_pgmap(page)) {
  1501					if (pagemap) {
  1502						err = -EOPNOTSUPP;
  1503						goto err_unmap;
  1504					}
  1505	
  1506					pagemap = page_pgmap(page);
  1507					dpagemap = drm_pagemap_page_to_dpagemap(page);
  1508					if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
  1509						/*
  1510						 * Raced. This is not supposed to happen
  1511						 * since hmm_range_fault() should've migrated
  1512						 * this page to system.
  1513						 */
  1514						err = -EAGAIN;
  1515						goto err_unmap;
  1516					}
  1517				}
  1518				svm_pages->dma_addr[j] =
  1519					dpagemap->ops->device_map(dpagemap,
  1520								  gpusvm->drm->dev,
  1521								  page, order,
  1522								  dma_dir);
  1523				if (dma_mapping_error(gpusvm->drm->dev,
  1524						      svm_pages->dma_addr[j].addr)) {
  1525					err = -EFAULT;
  1526					goto err_unmap;
  1527				}
  1528			} else {
  1529				dma_addr_t addr;
  1530	
  1531				if (is_zone_device_page(page) ||
  1532				    (pagemap && !ctx->allow_mixed)) {
  1533					err = -EOPNOTSUPP;
  1534					goto err_unmap;
  1535				}
  1536	
  1537				if (ctx->devmem_only) {
  1538					err = -EFAULT;
  1539					goto err_unmap;
  1540				}
  1541	
  1542				addr = dma_map_page(gpusvm->drm->dev,
  1543						    page, 0,
  1544						    PAGE_SIZE << order,
  1545						    dma_dir);
  1546				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
  1547					err = -EFAULT;
  1548					goto err_unmap;
  1549				}
  1550	
  1551				svm_pages->dma_addr[j] = drm_pagemap_addr_encode
  1552					(addr, DRM_INTERCONNECT_SYSTEM, order,
  1553					 dma_dir);
  1554			}
  1555			i += 1 << order;
  1556			num_dma_mapped = i;
  1557			flags.has_dma_mapping = true;
  1558		}
  1559	
  1560		if (pagemap) {
  1561			flags.has_devmem_pages = true;
  1562			drm_pagemap_get(dpagemap);
  1563			drm_pagemap_put(svm_pages->dpagemap);
  1564			svm_pages->dpagemap = dpagemap;
  1565		}
  1566	
  1567		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
  1568		WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
  1569	
  1570		drm_gpusvm_notifier_unlock(gpusvm);
  1571		kvfree(pfns);
  1572	set_seqno:
  1573		svm_pages->notifier_seq = hmm_range.notifier_seq;
  1574	
  1575		return 0;
  1576	
  1577	err_unmap:
  1578		svm_pages->flags.has_dma_mapping = true;
  1579		__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
  1580		drm_gpusvm_notifier_unlock(gpusvm);
  1581	err_free:
  1582		kvfree(pfns);
  1583		if (err == -EAGAIN)
  1584			goto retry;
  1585		return err;
  1586	}
  1587	EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
  1588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
