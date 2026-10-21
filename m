Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDE606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bR1xnCgn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65E210F8B6;
	Wed, 21 Oct 2026 03:01:09 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB92F10F8AA;
 Wed, 21 Oct 2026 03:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyZACvHawBgH0AC7lUgIpYeo4ABmqhS1uoCAclRLggJgMEP/AMXkjaxzqSxB/cdlYf+VZh9dYabggmizmzeXXazb3sUOR0BE5/R8KHFGBzQDtoRU/b7i7jb5ZMYXtOZkI0drSiRFa9h3QQ4mUsdJ8zv0B1JGcwgfGPw8eBOFhcv+g8j6kgO/E4h/Gg3uHFbu+VxPmzxdrx6aNzMLBXt5OsqjZ3QhOZtSzhIwyFp4YG0yIR6OMbfTBnAZr09twdm0C2z76GD8bzTgPyDuj5GwH8RV+uAhtELVz05vu0ZvI/CDDjLzBgVhAiY1rwGLxm0Fm1Dngk8ISD87PRKAgSWsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48iAzqcCzqmHnVRMlo2Ov3Jj9wQ3nO2o+/JvBuiWIsQ=;
 b=kC8m+589YV8vmhfEeqyIputxR8awpAuiTFUSODYwmVdvNhcYGGrkHEFQnypUYmy+uyJ5y9BjnMdVmI4YR1yNlch1mlwy6FqOsuQOucKUe+trGygtlrm4eN8jCbO003i3nlsq5IpnmMv59vMlYJuZuwSr/fNImKVtgJY79jUgaHEHCOu8foBHfhWhGFIjDbKVqTS2MtRwDNF8hOy/9ygt37/raXVRT7jHWj9BUy+5aqNGy32twNXH8n9HSL9p5KhsKgWG9EDX/PTLK5vs3pE7ED1snLHF+yY5sBptPjXKYax2a4fPK0aKfr++iK6VWSBIO41pRDMfjEnWKaY+KNtJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48iAzqcCzqmHnVRMlo2Ov3Jj9wQ3nO2o+/JvBuiWIsQ=;
 b=bR1xnCgnnS208BKZOoRgfRdpVacVyTwKa0VsptqeJednfrzMVFPiCDtMtQAPnP/xdI5RPzpg1ISsLckvR3pDX5MNF07TYoduks12GywjvgCesnEbuahjBumRTmD/LNwkljvfdJCzhm4qVj2/yDHlqivtNmBS3G+WQAnGcZAO3+M=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 03:00:49 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::2a) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 03:00:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:00:49 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:00:41 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Francois Dugast
 <francois.dugast@intel.com>
Subject: [PATCH v10 16/22] drm/pagemap: fix page undercount for compound src
 entries
Date: Wed, 21 Oct 2026 10:58:55 +0800
Message-ID: <20261021025915.2433837-17-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d53c8b6-d75d-477a-7b9a-08df2f1f82d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|921020|11063799006|56012099006|22082099003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: D4ONTWVN9gigE5KPb7ARYb7/8z8k13xrKBhEpmJvP8ndTZENZn8gUBGmHbSRe01+/ppfNJ5hzUIuSdcapWUYFTSiEiAXvihx+TM4gCHiWq0Y2/QqXIC5o4/r4Tw9sUQuePLnOtOA+uno1Wdez3SYZvafC+qbP/ISGNPhOzEsu5GgjjOfxPnGCN9AoD1DK0QGAFRjsWXRDP8kU08NkUHRvAPK5bYWfOk2VkY2ZBFUwgz7oY6P6SB4tFoa4OtBcnW7BctOmCSuxo1TaQorC7DTqv8sJBu1R4PFdfLz/1EDgzeD1ZerMObkGdiJiigWaqq5MB/3NjG6MEKrJYdyiF2wgxUJ1E6CifW0GcOAUhwKft2EU6TA6muPAOL+oVt5bw5ZUXj//t/9hjKeB3Otp9hHXbOGh3AEPmIMmectgCW0rVTDPo/LtOeSyodngiboKUAGf8ms1pSArf22KKbfjAZTZ7CadJSUPjigXmgOjfxYVPe4wX8GUFRd4pauj4LRmrDegR3V/lTMY4iZp4GH4ONk9sT3P/0fiaSjTAlUE7MN1pBXNifCBYEdKzt77Tu9jWenQmBOspAY0pdA0F+T6lA36sopSoft52YXFtK4RX8x3R/no/I95gPoHBq+bXw8VGNLioeQADCmWjfPYYKbN+gtaefNBR5JoC8ectwCo67eT7569GRU/Gkpz8/hXuNXIRUCxreqIeqADHJb046ruHot2eBwlyu1zwvpEsOpJ2OZUEjyU9M0/2Ib9AZa189GOg7M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(22082099003)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qrPXZGQNOO9PixQ7WAAlRNn+QuJ50IDkLf/ENo1UQOn1Fnt0eLbk/UmUPH5t3WdIwc0YwGlrU59e1/pKZoUtk5l/PkMKMXU+4cek2QqqCHMywSoNIpcNzVC+rpD5Q1uue2XFHOSuZVl1tOVFiwZmBkhoFLEDfwlAY/rMoUOmYwrzx2IGEE4yAq78Pup++lx0Uj3HZhRbDOVjOseF+od/SnKcQiH7uVoaYs6WlAWplWeaR6f17FQ1A7RnQcmg28QdPxJJW2WZ7jwXocMLRmCPbYLmH3w7+hIp5zAE8+cJ+FEAk5MQXEsZn8JRY+38n7yfJeB794gjo99summis+sDwdK+uEXpPpznKem42cQOvlRyj9+K31R7EH7fLbehmv7t32cTJisrEWCX9bFkB+T9a9BdwUi2tPS6I4w5v/EgzoFz4zbY9i1Sd39ntXqcKnEe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:00:49.4756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d53c8b6-d75d-477a-7b9a-08df2f1f82d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 15c78eca180b7..df23721434d88 100644
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
@@ -813,10 +839,10 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
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

