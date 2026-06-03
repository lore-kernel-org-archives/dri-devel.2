Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4F9CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B3610F905;
	Wed,  3 Jun 2026 06:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOsRo4xs";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922B910F904;
 Wed,  3 Jun 2026 06:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBxYngs3LbTZKpXPGpm1uWmLPnpQR4w8UoR7Sm8BEvx7/eF3zqMlugzMdt8QL15utsy1HBroNkBU4wQTyj3uHE7e98d4Esp1tU271KK9e7jpzednbiYPbMA0IE6hPCSCxRV8HTO2zDB7MNSzOxXriGVH5SuYLw2Ewe+z48ipoDJP/QjrQi2lioaifoIhgQkXQqyEq0vl+EctV9SYmf8dyAmV9p2QmfT5kU8/OqwsAyEnv151L33T9bZOCZ3mCmIzTSU2duVA349ZwhGooMQJIMzIUIKlKLuO6VirdPyunhZWOl3sSfR11g1obU0VA0+IMuo1MJOj8UKcrA0ldipzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiNfheiQ5iCxvhO3ypXnnQIabDNd+MAcl2PpXpZcw58=;
 b=DqbDDQEf0fSfHiyhlwp88VQzrEFHXmBqAK7grvsbEdOyTtn37D5XXqqEwg4+FnhoXBD8xv9azAmogaOOdftIcXJ009SM2sc5mt3FcsVjQaKwPAXrkpHVDVDa0lRnBRmrLWT775GSPl5Zbta/1IQJxrXcrPKGylQPOUvy8c9Ymrl8Z//UtbAS4vyv7h7hWsWQA4joShRi2bNET09Hdy0jy3g+vtBJotIGRCxzpRxGB3SmiM0FI+Yjapx2ufhsyGLdyEnPX1GF7zdwk+ZEXHM3bk6j+XqCiSRfXPavxCfJ9A5XOizi1ZdQh7bwTVLDp/TakGeQTgmstVKvGQXRQZtz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiNfheiQ5iCxvhO3ypXnnQIabDNd+MAcl2PpXpZcw58=;
 b=yOsRo4xsFFjF2M9CtSXsSHTNIdSvs8Fje95yYk5GcRqxclsj2uZb3qc8zSiw4AYdwFhudnOQ7nbComA8+YyW3L8i2XyVQgJkEhZQpzDYwp4Q2o7bCO+67IJMswxz7aLYsj/TCJw4gmJZ5NuvPD+O/77X9EjzF12oX1BkqDx9ELo=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:56:48 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:56:48 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:56:43 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [RFC 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Date: Wed, 3 Jun 2026 14:56:16 +0800
Message-ID: <20260603065620.2555316-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603065620.2555316-1-honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 72701b70-f205-49af-9974-08dec13d4850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7a5TUv3/OVcxuSSIBm7yylI3BrDMBDsizVvP0UOubXVE+twpregpqD6be9Dbgq9BNjFupIRxanMPwIxGIrjM5zGk/2j1Rbjshd0+H3hq9+1sKoYU6TEF9bLAqAPyHJo+ZfZK51BhzGB5emOe4XfTKEf+2mytVuVy1WN7rM1RG2X5CMaMGqG7dQqvjMVjEHoIEEF3D1dT3pLYK19iG9kDz06PXMAmbHNhUQqLdFzeFw7TW/8ZstV9o+uZ+4b+WsCMCUHafEpldyUjBITQ5xKufRMI/zdKQ3pTSCKXMPItbwMOSpokX4F07VXtn+cWUrI1+OBt5jTXxumyjG6nDVg1i/Zz4jNI7pkGwaC1kF9S4ZG32llTVPppkA00DG7hkvxZH90xGSRYj6NIlyFiowrt31h6OcgIsA2wimNZg9fwSUNmVpdl02PCgPclf31uLUswOd5TE+jwE6wrdNJyBR7sXXa0EVrRQ2/jQK433I97M5jdguLlDbO1agmXk7s2/zbnqPQpzgTbR38nl1cqF61QeqHOhV69ej36jBrCDXzgbnUhIv7PynrzpLuAfrq9RLM0VqamqV71xqPgzL3LB4Hnii4MLBHzN0m8FgEMfr/+8EpnuLboJqJuLUnRs6VXALXVK84tIgbPo9XxeGeZ0A5zUZuj9LgOELead9zjlFJnM6Xa8fIoFYGC4cakQDViwq4+lN2HTTXZSqEFb22QaU8YhcOBRuJRkYBSb1dNOxD5inM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jje7yUUA70DXLTruiTcAdQWHX699cqRcALLczioF8d6ypIQlUZ10VJCRNOnK+maKM0/U5/Mq3Kuj9mykgvd+5oCviTntmjQHGxo3KSWl8LLNzj3Tt037eMrFMfk3XczkRgsb/SWTXNPnTr3cXLmCss2GKUHojPBFPf0Fk3578os2vNHSXS5dQoOPuZVpHeFjXtZ3J8L3N0gQ5DTNOQR//vTFtA1DfMVkEB54ANeF5OB+gE5b5vWOBpS+j0s/M3lENcKfwk8yjrBhkqec299qep4XZBmMJIR4kpV/hU5DlCW1QA1p7iMv396ONgMSGazGlLDBz9FO/gnkvomLoCoFhTyCrtdQAZoPYO14qTsxUGUXcivjjDjPwQR0CDs1/fcMyEFT9yCqiCRzMt6OWuroziGTyvh8PWZ4PvjFFvqUC2jBdsCK2rfNrGTFfeG2Gho1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:56:48.2695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72701b70-f205-49af-9974-08dec13d4850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

From: Honglei Huang <honghuan@amd.com>

drm_gpusvm_pages_flags currently mixes two status:
  - MM / virtual-address state: whether the range has been (partially)
    unmapped by the Linux MM, these follow the lifetime of the VMA and
    are a single per VA range fact.
  - Device mapping state: has_devmem_pages and has_dma_mapping,
    which describe the current page mapping status held by device
    itself.

Keeping both on the pages object blurs the semantics of the
abstraction of pages and VA range. So move the MM state falgs onto the
range, and keep drm_gpusvm_pages_flags strictly for mapping state.

  - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
    partial_unmap } on drm_gpusvm_range.
  - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
    has_dma_mapping.

Side effect: drivers now need to check unmap flages in driver it self
to avoid handling the unmapped pages.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 11 +++--------
 drivers/gpu/drm/xe/xe_svm.c  | 11 +++++++----
 include/drm/drm_gpusvm.h     | 28 +++++++++++++++++++++-------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aed..6000d587cf2 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
 	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
 	INIT_LIST_HEAD(&range->entry);
 	range->pages.notifier_seq = LONG_MAX;
-	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
+	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
 
 	return range;
 }
@@ -1470,11 +1470,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	drm_gpusvm_notifier_lock(gpusvm);
 
 	flags.__flags = svm_pages->flags.__flags;
-	if (flags.unmapped) {
-		drm_gpusvm_notifier_unlock(gpusvm);
-		err = -EFAULT;
-		goto err_free;
-	}
 
 	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
 		drm_gpusvm_notifier_unlock(gpusvm);
@@ -1794,10 +1789,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
 {
 	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
 
-	range->pages.flags.unmapped = true;
+	range->flags.unmapped = true;
 	if (drm_gpusvm_range_start(range) < mmu_range->start ||
 	    drm_gpusvm_range_end(range) > mmu_range->end)
-		range->pages.flags.partial_unmap = true;
+		range->flags.partial_unmap = true;
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
 
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e1651e70c8f..3acfddb7c5b 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -166,7 +166,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
 	range_debug(range, "NOTIFIER");
 
 	/* Skip if already unmapped or if no binding exist */
-	if (range->base.pages.flags.unmapped || !range->tile_present)
+	if (range->base.flags.unmapped || !range->tile_present)
 		return 0;
 
 	range_debug(range, "NOTIFIER - EXECUTE");
@@ -1136,7 +1136,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
 	struct xe_vm *vm = range_to_vm(&range->base);
 	u64 range_size = xe_svm_range_size(range);
 
-	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
+	if (!range->base.flags.migrate_devmem || !dpagemap)
 		return false;
 
 	xe_assert(vm->xe, IS_DGFX(vm->xe));
@@ -1248,7 +1248,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
 
 	xe_svm_range_fault_count_stats_incr(gt, range);
 
-	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
+	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
 		err = -EACCES;
 		goto out;
 	}
@@ -1507,6 +1507,9 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
 {
 	int err = 0;
 
+	if (READ_ONCE(range->base.flags.unmapped))
+		return -EFAULT;
+
 	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
 	if (err == -EOPNOTSUPP) {
 		range_debug(range, "PAGE FAULT - EVICT PAGES");
@@ -1623,7 +1626,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
 	int err, retries = 1;
 	bool write_locked = false;
 
-	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
+	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
 	range_debug(range, "ALLOCATE VRAM");
 
 	migration_state = drm_gpusvm_scan_mm(&range->base,
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 8a4d7134a9a..3dba4b9516f 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -109,9 +109,6 @@ struct drm_gpusvm_notifier {
 /**
  * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
  *
- * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
- * @unmapped: Flag indicating if the pages has been unmapped
- * @partial_unmap: Flag indicating if the pages has been partially unmapped
  * @has_devmem_pages: Flag indicating if the pages has devmem pages
  * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
  * @__flags: Flags for pages in u16 form (used for READ_ONCE)
@@ -119,11 +116,7 @@ struct drm_gpusvm_notifier {
 struct drm_gpusvm_pages_flags {
 	union {
 		struct {
-			/* All flags below must be set upon creation */
-			u16 migrate_devmem : 1;
 			/* All flags below must be set / cleared under notifier lock */
-			u16 unmapped : 1;
-			u16 partial_unmap : 1;
 			u16 has_devmem_pages : 1;
 			u16 has_dma_mapping : 1;
 		};
@@ -151,6 +144,25 @@ struct drm_gpusvm_pages {
 	struct drm_gpusvm_pages_flags flags;
 };
 
+/**
+ * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
+ *
+ * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
+ * @unmapped: Flag indicating if the range has been unmapped
+ * @partial_unmap: Flag indicating if the range has been partially unmapped
+ * @__flags: All flags in u16 form (used for READ_ONCE)
+ */
+struct drm_gpusvm_range_flags {
+	union {
+		struct {
+			u16 migrate_devmem	: 1;
+			u16 unmapped		: 1;
+			u16 partial_unmap	: 1;
+		};
+		u16 __flags;
+	};
+};
+
 /**
  * struct drm_gpusvm_range - Structure representing a GPU SVM range
  *
@@ -160,6 +172,7 @@ struct drm_gpusvm_pages {
  * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
  * @entry: List entry to fast interval tree traversal
  * @pages: The pages for this range.
+ * @flags: Flags for range see &struct drm_gpusvm_range_flags
  *
  * This structure represents a GPU SVM range used for tracking memory ranges
  * mapped in a DRM device.
@@ -171,6 +184,7 @@ struct drm_gpusvm_range {
 	struct interval_tree_node itree;
 	struct list_head entry;
 	struct drm_gpusvm_pages pages;
+	struct drm_gpusvm_range_flags flags;
 };
 
 /**
-- 
2.34.1

