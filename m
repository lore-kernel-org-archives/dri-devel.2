Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B784606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Xv3fn6kb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96588112885;
	Fri, 27 Nov 2026 08:43:24 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B0B112884;
 Fri, 27 Nov 2026 08:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCvGP8fqcTXSWcFReJo2Sx1qhZHjcKBgh+4xGTP0IAQF71Z4ADLv3aGo9pKe1TEZi73RxzQlN36rhh8088W1Wyik3W+nY3FIS1TLcRpd9ITSHvEQA4qXOl9Qb9ZOi/ADluri6ptYOiyBoEFwpw7g0vCu/GeULF9ngt3X2NcYbeIZhfCp1VzqtybIBq7nsWPyrfzihWprJJoRzBaPEchlQgODCgL87+nZuI5rea1YIZUc/y39p9Bf5DJYknoB9eh9+Qul2YVIr0wMylVVDFg2qBSmtBKeaLd6weCFfrW0uGhA/BXwz6QhxpBiQfHsCWu6rInAidR8PAtOf0quH8++yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Kkjm9gCtQsmY99hs9Ay0FQx0gG5KkAoCOqn94Efpg=;
 b=hhnl6vvU2QPckxoZidozTnalpXOv2n5uFjUNitVJ5tsc4cPOR6pt0N/9cgzWkCEbyvNMhRiAwR8j1eSI9mu0Tsq+SjysnMdwgVS6+OOyEJHnetEgkM21Fiy8Gv32DKWvJnf+tfjvTXTVMHnDkkmp6QzpDEEI8mMvvQyeIxpReOwLxmUmdbL0vsAO9rBiMfAh9XRiU2/MxXx0+TJIOTGzu7q1w7wLBaiQnE3GTlrrqa+jMzd1B40vVZKdOn+r8fE7qpIp4158hUc43Whj0kNbW5cb7oJo+XixvJpvZY1lQ1TmQXBrqY+8Mo7AeXUlTTMOQNhENZ21rfF6rprbTgKlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Kkjm9gCtQsmY99hs9Ay0FQx0gG5KkAoCOqn94Efpg=;
 b=Xv3fn6kbPWHB9E6U0vzwwBsGvnbw1IekzLbZcMyANgJchJu+fcT0AybRqs2gFVMgtxTzlgPPwJEfDJYZCmbvQy82xWf6mQqQHhFH5hH8PnxYYFHnxmp2MH/ol1ELNbMbPv5SfVSQiDhRQ9cnVeFoLUPYY11CGpBNbJqhxcAnGEk=
Received: from CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::15)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 08:43:11 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::2f) by CH5P220CA0014.outlook.office365.com
 (2603:10b6:610:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 27 Nov 2026 08:43:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:43:10 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:43:05 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Francois Dugast
 <francois.dugast@intel.com>
Subject: [PATCH v11 16/22] drm/pagemap: fix page undercount for compound src
 entries
Date: Fri, 27 Nov 2026 16:41:39 +0800
Message-ID: <20261127084149.925625-17-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 445a3432-e52a-4eaa-902b-08df4c6277ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|23010399003|22082099003|261009223027099003|18002099003|921020|10067099003|56012099006|11063799006|261102123227099003|261022075727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: N8n38KBJsM2nJ9SnEgdaGEM+CnuBx7tulstyROl+6BLzOHNHpK1yIY5I/rQ6SHGpkHr09ZaQ8SLCyTih7ajz4Ktoi5Gz0wJ+NvQTeMsTGGBQfoFDL77gmlrHn7pwLFf9CuIDV03ZtFF4LcJnIa5PyV+P9bfX5Fab5LKjjaXLBUBtEeLd0YrguvfnGB8heWOWoxxAieaLAR4PWcip9CIxzOgmGS1OSWCgxoAdNbDyFtX+lIBDEzLiL7IqgueFgp+RgV1NIRDlWw0T9DGDRT5NnVjG/avKGPJWHq02cnCvtpsPWW0FtzfXvRbCK/z/P9vf0eWylVlRElEmqOedW9cyoqxLxLko5F6wlLdIgGqpY992AhEMk8KerZE93UrnwjJjzllaX5qx/9UhPwzW7MJrZ9QqoUd0ltVHV6P2avOryxj0HL84NxQj4SdT5nWQnNfcdw2qoDdybujTV8EglKBlT51wTDRKavfDRcA55Pq/HC0sj9F7N11ldr4W579CH8aBvisDZw7RN+HttIHvDU99biweDRZ8cCDp8FNc1TMHIu05Lg1rpEnyZxOWtkqm0FjSQH3L8K24MN/LKnb27hTNFcGgMhtTH51M/C13yybsKK/7Vm5bSwMFpuowAGbLXiVmFqvMXbbUNUOFag/IwU7Il3I7FiNT8owCCgCoTcInc8hZ91fbJvV9+6VMap85cBSoyPth4smnEcgnVtk6hVj7SI9IAbn1ZbTxX3XlhcRESdSZfBbyaGLmwuJfgA9Cwy4J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(261009223027099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sjF/8TKHMf3J+FOTCePoGsNn+uE+sBVeqWFKNGRJRe+zBYXkD1lpeRJa6+3Pnn/bAkx/NsEmqT/jcbb/gb6XaHBalkWIm2Agufq7SuHKISksmjCNrE+IzvL5Ou2hYaFgufJ1xo9DaAfFZbNdYOLW+HPlXiTXWDDQG+4NFqxfsnhebV1DhucS1U41lqsX+eL7jk9fj3Z8GpLWBaDyQfH0OjBLT1C0O4jVsnoRa+a/ID1VnTFuLG+G3CkFu+04Wubtt7zAe2V/6IXOFPPPYmfhmlQ/12u5DT6B7zYLPtZXOJzUq3Xna4tpst1LpGj51+oqD2c3+6ZRQUzLIoJPMlv4uG309f7xDokdXaxeclD5YajXQsSh8whLDiOFw/UWm7y7uYFEWdex5xikFSOidM17/qyt5YnERfyA9OcUhFu891BLZUfv3a+5kVfOd4ykKcgv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:43:10.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445a3432-e52a-4eaa-902b-08df4c6277ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junhua Shen <Junhua.Shen@amd.com>

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
 drivers/gpu/drm/drm_pagemap.c | 60 +++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b8..a31cc4f0af68c 100644
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
2.53.0

