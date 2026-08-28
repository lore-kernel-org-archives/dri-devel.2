Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24AAC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDD810F2D6;
	Fri, 28 Aug 2026 08:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LDYIOkmz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5606D10F2D4;
 Fri, 28 Aug 2026 08:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk0Ugxl2QYbI0nSuHOmet1XmzeFfjX7zUSxBvyXvStGeCJUD0laVi7XJNN8BsF6FT5HnXkhiDqCVnRs3Z2Kr1LfUPSTD7M1O37tSKsHMFh2pKRrJ4VX8Gw8EICmod5YrlNJVZXdTbMcysZDYhPfkAim75opfV6ilNpC14P1BAZ4Gp1bZLxK/Po8pVXfkENxj7hZ+LeEz6KsYXVnSRrmIMS4SALjyhm/yiOglKaSn4QhcHi8kFnzT+f6g2DDKT03LXHBbXPxrdXQ+fyr5Osi9I+1Wf9GFzEiOGnocWFj5JP1pE7gFJ1Y99fPUACwP+4tQbOSNAS/kz1sVtfxEJVoooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kGU+ZigJGG9uJh4fGMMozUdg+sUojpHQnGePYbXVyc=;
 b=PdMsXFKHIY3CSTe65ikjAUs/OP0xv2CkKANdFsvcbXTkK3otE8um2jdEoy15//OoqEVMsfwYQiKfawtUnj7IZOWM+eGcG4H7H5ec4OL67PFktPlbhe8GArBPJRMNFINxZBLL14wxs6l2oPNkIeMfie+AVLKIRZg2zj80gemHOoafnihJDexuiBmvxHK0yg2d2L4Iev7S1+KHbCw22+IMzgGJG0FLpfoXa0pGuKfXjL0v9O0AI48fdjyD4RCw8OZ+8DC6HqjRulR9s5L59W++TGEr/7eNMM7kXi6/7t/Rvi8sftb61JKZNSL4S5I1sfp94e1B42HbuEo1F/WSX//RNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kGU+ZigJGG9uJh4fGMMozUdg+sUojpHQnGePYbXVyc=;
 b=LDYIOkmzmOCQehTbSaPWQjaQoAbGVjl2lkzEa8EsJ1viuajM1ht2IpUNVRBEO9UDeojWKANnWxpE1EjOrCYW2iDDO+XTU5HPD59Ssj6JT/hUH0fA41wzl8/08jLPXdXLuEBh+xkWfWdQda461eEms50YW8e+Uy8kgdKC81nIor4=
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 28 Aug
 2026 08:37:01 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::4c) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 08:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 08:37:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 03:37:00 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 28 Aug 2026 03:36:57 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <dri-devel@lists.freedesktop.org>, Matt Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
CC: Junhua Shen <Junhua.Shen@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <amd-gfx@lists.freedesktop.org>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <Honglei1.Huang@amd.com>, Yiru Ma <Yiru.Ma@amd.com>
Subject: [PATCH] drm/pagemap: centralize migrate src base-page counting
Date: Fri, 28 Aug 2026 16:36:52 +0800
Message-ID: <20260828083652.40855-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9cb1b8-0156-4322-9065-08df04df87fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 3//lFFwGnDR662QX9rI+uJ7cUsP2RBpKTXvWf1mkJAOaMTBXsf+N9uOuF8jd1YECI5IaFR72K7hhYoHlqOyW+NpLcdQaNdYiR1W7SPn+XizNsfyCWuaJgQfDBV+1Op8c7g6cgssHM50K1ptrjUcoX1NdTvXy9J40xHFLGkCkZqIbFAiLzt5BU8hpI74xRpHCyEG8/TMyNpVZKuE4lvTEF3BEVku0/7hHm+Xc07f9jjO2Cv9IoX7CKXedOTMI29CcakKZDQ3N0pzUIY0sfOLrYPEt/u3IXc8238ZZyHzkkBzqNwLW3mVWTeXN0xp+M3WCmzQRhWc0yu4rr56CFH0NsIZNX+3aofkE/JFAW2JRRfATVF1RFiHgNRCOKTeba5v+RJrRePwFaejale5Pr3kgbb+dnycGMkBuclOiHgejaQOMQsj+kpjiEuH4YnO6MzCpPj28LD9xz/lwico0uIOMuWUUffd89xwoCOpOa7gOfz2ziSaojSn0c8x87vAR0eCh1fSfCFdC8oi3UTuS+94zBJak+RVR8Iru2E9FMkT3gULGTrUpUVXj48Xb5fP09eQNqSLbu99BHkDVCIF344ugn/yPV0O2mEvT6NMmicjvZCnLUYgEbIwvcamhdYc/u2ZlbEA/4REajT/DYsq5I7JJIKI+Aw5qLxEnerivZcQKLirtYSjoIq0YcULpLMm7QTEt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ES4ktblw0gHDpRmAaOJVoiBcZJ5v71uYbY8qPluRa+CmVNJH0jlLKbhEKi+CBLl3AotMmUYtFg//03onRYRa+kfsVQu1XnxbqUQ5C8MupwxNq6alH0XXc3/l/qcos0BmN9N6JsZA0tIenZlGV/+0R87JE6BpEjgkIrFVNHTMXavv2U2/RqmStuyDQJHP5bN2uAqK5b1QcEtuOgxzCpoLn/FmqBhM7Pgyhqy4GtcC97lh+8X4djrsLzUBwMj/kg66vJHP3S2OqBQhiDq5In0sLIj3NiMJZIr6Pi+Js7Avgt4hCDt+1oeTzcO7R2QBeIfUJoILBaPMynunmY5CA9WiQnhC+1jkBlDzivNc35p+2g7hV/3NpQZvxk8r/ytFF76Pm3idCpK04Px0yOyEVbvXZ9j9HATihBoHwbJRcvbllFNfP/Or2lwjpuvwoj1dh+Nh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:37:01.4930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9cb1b8-0156-4322-9065-08df04df87fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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


The base-page count for a migrate.src[] entry was open-coded in several
places along the migration path, and these variants handled
MIGRATE_PFN_COMPOUND entries inconsistently.

Factor it out into drm_pagemap_src_pfn_nr_pages() and use it in
drm_pagemap_cpages() and both accounting loops of
drm_pagemap_migrate_to_devmem(), so every site agrees on the base-page
count and iteration stride.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/drm_pagemap.c | 60 +++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..a31cc4f0af68 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -554,6 +554,37 @@ static int drm_pagemap_migrate_range(struct drm_pagemap_devmem *devmem,
 	return ret;
 }
 
+/**
+ * drm_pagemap_src_pfn_nr_pages() - Decode src entry and return base-page count
+ * @src_pfn: Source migrate entry
+ * @src_page: Optional decoded source page when MIGRATE_PFN_VALID is set
+ *
+ * Decode @src_pfn to compute how many base pages it represents: use folio
+ * page count for valid entries, HPAGE_PMD_NR for COMPOUND-only entries,
+ * otherwise 1.
+ *
+ * Return: Number of base pages represented by @src_pfn.
+ */
+static unsigned long drm_pagemap_src_pfn_nr_pages(unsigned long src_pfn,
+						   struct page **src_page)
+{
+	struct page *page = NULL;
+	unsigned long nr_pages = 1;
+
+	if (src_pfn & MIGRATE_PFN_VALID) {
+		page = migrate_pfn_to_page(src_pfn);
+		if (page)
+			nr_pages = NR_PAGES(folio_order(page_folio(page)));
+	} else if (src_pfn & MIGRATE_PFN_COMPOUND) {
+		nr_pages = HPAGE_PMD_NR;
+	}
+
+	if (src_page)
+		*src_page = page;
+
+	return nr_pages;
+}
+
 /**
  * drm_pagemap_cpages() - Count collected pages
  * @migrate_pfn: Array of migrate_pfn entries to account
@@ -570,20 +601,14 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
 	unsigned long i, cpages = 0;
 
 	for (i = 0; i < npages;) {
-		struct page *page = migrate_pfn_to_page(migrate_pfn[i]);
-		struct folio *folio;
-		unsigned int order = 0;
+		unsigned long src_pfn = migrate_pfn[i];
+		struct page *page;
+		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &page);
 
-		if (page) {
-			folio = page_folio(page);
-			order = folio_order(folio);
-			cpages += NR_PAGES(order);
-		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
-			order = HPAGE_PMD_ORDER;
-			cpages += NR_PAGES(order);
-		}
+		if (page || (src_pfn & MIGRATE_PFN_COMPOUND))
+			cpages += nr_pages;
 
-		i += NR_PAGES(order);
+		i += nr_pages;
 	}
 
 	return cpages;
@@ -703,8 +728,9 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 
 	/* Count device-private pages to migrate */
 	for (i = 0; i < npages;) {
-		struct page *src_page = migrate_pfn_to_page(migrate.src[i]);
-		unsigned long nr_pages = src_page ? NR_PAGES(folio_order(page_folio(src_page))) : 1;
+		unsigned long src_pfn = migrate.src[i];
+		struct page *src_page;
+		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, &src_page);
 
 		if (src_page && is_zone_device_page(src_page)) {
 			if (page_pgmap(src_page) == pagemap)
@@ -818,10 +844,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	migrate_vma_pages(&migrate);
 
 	for (i = 0; !err && i < npages;) {
-		struct page *page = migrate_pfn_to_page(migrate.src[i]);
-		unsigned long nr_pages = page ? NR_PAGES(folio_order(page_folio(page))) : 1;
+		unsigned long src_pfn = migrate.src[i];
+		unsigned long nr_pages = drm_pagemap_src_pfn_nr_pages(src_pfn, NULL);
 
-		if (migrate.src[i] & MIGRATE_PFN_MIGRATE)
+		if (src_pfn & MIGRATE_PFN_MIGRATE)
 			migrated_pages += nr_pages;
 
 		i += nr_pages;
-- 
2.34.1

