Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBF606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gQ8e5a6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0581C112061;
	Wed, 18 Nov 2026 21:47:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2116112061;
 Wed, 18 Nov 2026 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038414; x=1826574414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wuf1yMe2TG4MNLn5baEMN9Ct4CTlt0Rb1e5VhYkkBwI=;
 b=gQ8e5a6QAGSVYreSXHl+45Tm9JSNg7l+D0zuUjTQHalkR93ROyLw58YM
 wC7J+TdoPXULRZL6AZqQ4IvQns8e/8WXsmSMw/E89OvUopF45MLup1+do
 LOoFhC0QoEngBdvixsBERgEvoDDpnkiV6h5nNVMNJN6J5vcNCIhFjVRbr
 NZsAujDrI7z9MI1WDDsjkemjyj3Wr4vx+ipv9rbuwdpu340HiSbrjeebQ
 99uwM0qUJIsGt72hopo0wbH4guExv3XfMBP+1BUiVBKd2+eqjJ8pljSWS
 gKXMF4m3zgDzr5jBamXRMMV1ERs3DYYEX7rVb/8SlIPTpHdCc/V4U8Tg2 g==;
X-CSE-ConnectionGUID: WchbYigkQtibVMyxQgd1Xw==
X-CSE-MsgGUID: 8Q/F+svuQpynLlhcoCaTaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3881010"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3881010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:54 -0800
X-CSE-ConnectionGUID: bO6gamUxS6CK2AHzBzzE4w==
X-CSE-MsgGUID: CaIMKSHiQ+CYh6qkZCKKew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10258573"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:52 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 imagination@lists.freedesktop.org
Subject: [PATCH v4 17/20] drm/imagination: Fix kernel-doc for
 pvr_mmu_op_context anonymous structs
Date: Wed, 18 Nov 2026 23:45:14 +0200
Message-ID: <20261118214518.29317-18-ville.syrjala@linux.intel.com>
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

W=1 builds warn because struct pvr_mmu_op_context documents the
members of its anonymous map and unmap structs without the struct
name prefix. Use @map.<member> and @unmap.<member> so kernel-doc can
match them.

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: imagination@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 494436e673bf..c2e1bffa014c 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -1388,24 +1388,24 @@ struct pvr_mmu_op_context {
 	/** @map: Data specifically for map operations. */
 	struct {
 		/**
-		 * @sgt: Scatter gather table containing pages pinned for use by
+		 * @map.sgt: Scatter gather table containing pages pinned for use by
 		 * this context - these are currently pinned when initialising
 		 * the VM bind operation.
 		 */
 		struct sg_table *sgt;
 
-		/** @sgt_offset: Offset into @sgt of the start of the mapping. */
+		/** @map.sgt_offset: Offset into @map.sgt of the start of the mapping. */
 		u64 sgt_offset;
 
 		/**
-		 * @l1_prealloc_tables: Preallocated l1 page table objects
+		 * @map.l1_prealloc_tables: Preallocated l1 page table objects
 		 * use by this context when creating a page mapping. Linked list
 		 * fully created during initialisation.
 		 */
 		struct pvr_page_table_l1 *l1_prealloc_tables;
 
 		/**
-		 * @l0_prealloc_tables: Preallocated l0 page table objects
+		 * @map.l0_prealloc_tables: Preallocated l0 page table objects
 		 * use by this context when creating a page mapping. Linked list
 		 * fully created during initialisation.
 		 */
@@ -1415,13 +1415,13 @@ struct pvr_mmu_op_context {
 	/** @unmap: Data specifically for unmap operations. */
 	struct {
 		/**
-		 * @l1_free_tables: Collects page table objects freed by unmap
+		 * @unmap.l1_free_tables: Collects page table objects freed by unmap
 		 * ops. Linked list empty at creation.
 		 */
 		struct pvr_page_table_l1 *l1_free_tables;
 
 		/**
-		 * @l0_free_tables: Collects page table objects freed by unmap
+		 * @unmap.l0_free_tables: Collects page table objects freed by unmap
 		 * ops. Linked list empty at creation.
 		 */
 		struct pvr_page_table_l0 *l0_free_tables;
-- 
2.56.0

