Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B0C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A855F10E610;
	Mon, 31 Aug 2026 06:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1iW5m/lw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE1910E610;
 Mon, 31 Aug 2026 06:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZkjED7p41ll4kfADM1iyRK0C3/x1M9RbVzqXYI/Edw3rxMnPqL8X5x3qgWBvCcl45oodUKGWnh+PUe2k0pdqJhdBBDCph3Ram09Va7pkkHUpt5hCOfXrJhJoLbsId+8Khb3oYPRP4XF4vbIHeCuF7PMGhkyS5iGfKcxMdjaMj5qwjcuUVMqA4EHGWplko6hubpppCAphRoWLtb1Xu7VoGjt0CTvYy/9yjv1xo9DS4HvuS5OIwSfYBKo4gQloTmpwtwO/Tkw6EnKIOD6zGGgzMjmgL+nk5uh0MZJQiFseqQCNuaKs3cvJd0TmHJZoUb2y+L3xOywRqBDFrOxf7xL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n366onUsD/kxQ+Ua0eL+8DZv1sWaMbjrB0GxiK6m7WI=;
 b=Y5/j2G9zZ1lWdwKWZmWIehNdjxoxU3FC8H89pPlm/xljf5CrH+Q9YQXa0yhVmkkt20TXLfXeCe4be6pIm0MGAgSW41oTP8mizYJ8+7cZk/32cMX4Fygg/crFjJDHCi8xm596nZu/TSmZH2+pXinmWgV/2wkpkzA2s+ifVodbkepWFbnP272RBdbj7eG3eOQ8UvmaLRkRSX8MYb8rlOhGyweQ5Off4zw3U7MdPsw6dj50FZzgs7fRpct9hBpUi4ZKtAEVScWkJPANT3QtLTvibcp3HyGBBU6X6vGFoxOrilNOHjUqNKBBIoSPuQsEEOL73fWx+Aw/UNLdPM14+bpskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n366onUsD/kxQ+Ua0eL+8DZv1sWaMbjrB0GxiK6m7WI=;
 b=1iW5m/lwU2u7oumbsmMC7EEN/H/y498OreXSEsGoM2vX7fE/deCLkSY+NFgOfFIQec/q6uCKstfKXYjeU46PD7Gl+J5XZojJHkb5iB0OUwjW3At1KisaTDmHhm3QpHBMcg1QlJBxzbRpnm02Y/vzBJ+fZMKdh3rQ9obh8QavAmQ=
Received: from CH2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:610:50::29)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:07:53 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::80) by CH2PR16CA0019.outlook.office365.com
 (2603:10b6:610:50::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 06:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 06:07:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 01:07:52 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 01:07:49 -0500
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
Subject: [PATCH v2] drm/pagemap: fix page undercount for compound src entries
Date: Mon, 31 Aug 2026 14:07:43 +0800
Message-ID: <20260831060743.70024-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260828083652.40855-1-Junhua.Shen@amd.com>
References: <20260828083652.40855-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 8624cb1d-6b84-4dcc-b840-08df0726317f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OXUr0Ncg/+Anl/WtOA7LDQfRWULg6G0MoFFQZ8eZDPnIPihdqlS6/o0pu4FM3nRcG8v6PqFQm13ezRJXWX1nvydxl2nMXoux2RhM9senVAR2P1G9wCoYPt+YAsyvHf5E78yMoB9/yyNr1/HcLSi4zWebn3E5yg3sfjzstZO8wKkt4KKW8qLrItGa1407ZRFHxNoczPm0ynZhw9VhrLf4LRjQGtknODimh0TyHMYzUOfAdpsITadbH8h0qboMebcR8oRgU4O3fVMeXyqqaj+C66JNMDeX9BgFwxJj9LRe9fypRsFL8SqtzqyDTcUMKhOIRUfT5xz6oZvXp1yn/qt6Q5mf2ZJkTH4Tu/AzR2rtRmf3Wp60GqTwiM7+vKe0CYTSIsSALTig315+4rDESnQCVQJg8T966KOkFUuxwmBipQnkf8ssZZiSm/GOB1I0Dm5gBR2hJ8f0wun2/e1T+DudR+3zuo0uPbwAf+yMgVhjVDIXI3BttzWc9v2DQxL6XSyZpO2rqrGox7RQeObRrr254t8Xb7zOnmFcKxRKm4s6nhaq9V5cj7t/X0wCZPSr9t+ZCqw73ffsQuVI7uY+sFnxzrkNeQ9KdGtt+QvwEOAvEUVIAqAL/97Lq5edZ0V9Gbrco8dW3uVJDF1ce8YFt6WKxxelDqq38qUUH3a62IgVAmDN/jRod4dyL37quTHSvRdhdDwRJFLNWV2WORlAAS+zJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UcA2k0Hukd3moEAHMMFGkgAom0WVQ1k3sp8DaV7Rm0AeEyiSiQ/TrlQb3uR3rL347x1x8hjzxD6yJDg0t+Y5H+bsWAhuGOEzWb1a+r105JH/MoXnI0LPuv84+obCOqoC9khLYrAnb6ZTprVmjCxsvY0luoJE/TEt7mJM+7ZjR7vR8fTtFADjtwccDqHF21W8goyJvO0U9jVdfWBtP5gAPV3Jv+dAQyAmrXBufxa3jFRi0gxXW8eJxawnTjZD67B/0SbvMEW7wFWRhwKiHdbI4ljjL7EcKwEKZL0LcZ3EfPsOWjFKbstHH4GwV5liDx8UB0YdLwWla1un4qCXyFjzAYJ0yycztbujnzVKi297g9LbQkDOPwq+QOo09Lwe5wmBHCKfzzdhmo/CUfIVgS86dGy6lagvyzLFh/PvIFqHNZns0BPm2s7GyMLmqthoMDdh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:07:53.0119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8624cb1d-6b84-4dcc-b840-08df0726317f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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

A migrate.src[] entry with MIGRATE_PFN_VALID=0 && MIGRATE_PFN_COMPOUND=1
represents a compound (THP) source page, but migrate_pfn_to_page() returns
NULL for it. Both accounting loops in drm_pagemap_migrate_to_devmem()
derive the count from that NULL page and fall back to nr_pages = 1 instead
of HPAGE_PMD_NR, undercounting migrated_pages and risking a spurious
-EBUSY in the final migration race check. drm_pagemap_cpages() already
handles this case, so the open-coded sites disagree.

Factor the decoding out into drm_pagemap_src_pfn_nr_pages() and use it in
drm_pagemap_cpages() and both accounting loops of
drm_pagemap_migrate_to_devmem(), so a COMPOUND-only entry is consistently
counted as HPAGE_PMD_NR base pages.

Fixes: 192cb1f5cb16 ("drm/pagemap: Enable THP support for GPU memory migration")
Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
Reviewed-by: Francois Dugast <francois.dugast@intel.com>
---
v2:
- Reframe as a bug fix: a MIGRATE_PFN_VALID=0 && MIGRATE_PFN_COMPOUND=1
  entry was undercounted as 1 base page instead of HPAGE_PMD_NR, risking a
  spurious -EBUSY. Rewrite the commit message accordingly and add a Fixes
  tag.
- Add Reviewed-by: Francois Dugast.
- No functional change to the diff since v1.

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

