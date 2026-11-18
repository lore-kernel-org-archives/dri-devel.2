Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121C606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fb+R1fTb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1388112059;
	Wed, 18 Nov 2026 21:47:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C0B112059;
 Wed, 18 Nov 2026 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038411; x=1826574411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W9SLhINTz8zbb3wkCyS8l4omIeFnMSYhVnKphdcUHYs=;
 b=fb+R1fTb0zSFBNE9LfPGJLdnnEfvCmn23M2tWzax2q6MBHL9X2UVebS6
 djgeQ7ulgJfhL1badESmKArlN3eCQxyc75YIE8iu2B0MfGK6TEstnIyTU
 +UDgyQOam3t2I3QbkfsfUYjpWjgjcSfBpFpEJjJOpzr9JZoaPXkuSZiZH
 tdTbgFfB692Fe2s1IhjFAS485fOffo4/oEriPhyM5jitrnDBP+ZHtJW9K
 a59oOu6jb6Tx9zHidnIcKdCPIgCueoWVRc4jSw9KaZ6G9RXhpeLIsJ8sD
 fb+rKM1Ojq3GKRkhFuubjnFB9nWQfmDzkFcOBrM+kOWBFyC+/zj7cj9/b Q==;
X-CSE-ConnectionGUID: hiTZIpsrSwe22rLLjm9SUQ==
X-CSE-MsgGUID: oOAzuwrFQ0Wpvqi2BFPfNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3763783"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3763783"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:50 -0800
X-CSE-ConnectionGUID: VnY3AzEbQu2u6V+VKXsWjg==
X-CSE-MsgGUID: L6ithV56Tnq9WhqC+IfYAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10142809"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:47 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 imagination@lists.freedesktop.org
Subject: [PATCH v4 16/20] drm/imagination: Drop stale kernel-doc for
 pvr_mmu_backing_page.pvr_dev
Date: Wed, 18 Nov 2026 23:45:13 +0200
Message-ID: <20261118214518.29317-17-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

W=1 builds warn about the documented @pvr_dev member of struct
pvr_mmu_backing_page, which is below the "private:" marker and so is
not part of the documented interface. Drop the stale entry.

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: imagination@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index d1442515553b..494436e673bf 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -219,8 +219,6 @@ static_assert(PAGE_SIZE >= PVR_MMU_BACKING_PAGE_SIZE);
  *                              table of any level.
  * @dma_addr: DMA address of this page.
  * @host_ptr: CPU address of this page.
- * @pvr_dev: The PowerVR device to which this page is associated. **For
- *           internal use only.**
  */
 struct pvr_mmu_backing_page {
 	dma_addr_t dma_addr;
-- 
2.56.0

