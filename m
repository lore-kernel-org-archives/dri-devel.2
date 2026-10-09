Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB80ECA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE3E112028;
	Fri,  9 Oct 2026 10:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0VfFwa0w";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4A910E113;
 Fri,  9 Oct 2026 10:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMncaMbjzP9pXlNe5RMeB/XXGvEe1zAKdmJR2fRwDbcD1DE05qdY9ToKqVH6rdUf/itej2Pw7vW9EImsHJsyUUMpzaV134/aOPc83FLtMaSWQAftcgwf07NK+Tv60JFdY/x8Mewow+uaIActa8Hks79c0n3KrMio62BiFcAzYI/tsIIxqx4lmX03SwWoB9ooBIXZSPVo0UuWKA4f8MPtEgH/n8ITWY5Nwlw6ZIZMYfbJmydiJLDxhaOX34KyoWibFXoNUyfCGSYgJ5CPNKidzbkxTe3f7dm2asd2esIi2F+euC3BDjKD/AsWL+yAG7SFr3UeLLd/ZziDKStd59k2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1r5f/BZh74Zas4/xFRye8M2FIjCOP/Kjv2x7Kxfs6c=;
 b=D4kdFw2AktHvaig8TBP0Zqyncmzmql/v+NtEMb2Oynn35SxXZ0PPcyTxPRvLAVMgqAze9wSbAWzKr1RkuFb6wg5lrrwXXf5VlipFNXPUizCp9fljU+XP29SNPT0Ygt9SwCwa7B+LOL9Tw2jqpuSVAkf+cj6E6e5MyF87/1mwD9fecCRMzc8Q/TXHuDrygcmf8Cj4dbV1ag8479TnDBeKNVSaUSBETUfI+QlGOIOxK8cDGdbauqjZrbhNUnYIRjhTC8FwEX8EgweOMavanUTzCpyJdMy54WE4oEqWfOnvXHg2+jj8bCUqbuEyk/2KS1GPOOKLnTUS1wJnnR5ECntKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1r5f/BZh74Zas4/xFRye8M2FIjCOP/Kjv2x7Kxfs6c=;
 b=0VfFwa0wyJuquGIbByTyy+0pmgnlMjWaReg+eNQKV8CEbfKluLJvmoRUhdO1vLL+lxEQyGxXmCt3CPr8E1+kb9QX5rhGMnkXAcJzv/OaYyrLJE3TyNsvOOqlElXlDOojNQm4M+FRA9+R/g1iSe/JsnY7c3uDQLRHIDr4Zk9s+u4=
Received: from PH7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::8)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 10:06:08 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:510:326:cafe::74) by PH7P220CA0020.outlook.office365.com
 (2603:10b6:510:326::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 10:06:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 10:06:07 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:06:00 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 3/3] gpu/buddy: search lower orders in contiguous
 try-harder fallback
Date: Fri, 9 Oct 2026 15:35:46 +0530
Message-ID: <20261009100546.1103622-3-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 369bf21e-3e1a-4110-a597-08df25ecf000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zWpGQ5yd3tAzz5erf0bL/AydBBt7On53kipidiSdGqAnU5anXO8jpBiko9Y/Yo5rEtAJJlWAggTbk+cQZz7dvZ23+yvRqJSncyGAJRLxddZ/HoHsPhezwMBA/EBc0nFCJKYk5otMD6j4TF4d5Epk4ZlJWd7OFHmK+IKo7GRwimzwDjzETkMQQpUxVWZxbcyrwIDAcXcdOQJIcny754X8bhK6PClxGEvAAw/HnbeJOqD/EgLV2HC4YCgdzfBSGimuTSyZGHN47vLPkS+VNQgSpnKgOHV0KXLBtSBylGrB9aaNzOw5BuoQbJSuaFhUaB9Ut5HeCLYspbfLeaw7jhutGCtE717por6T/BPS9pGMYi8gctzpU19ez8qtPpkXrlCego1NrzvLCvkM0um6WSoW+4HHZpDlLjBEP5f82PtWLpNvetnMaDnz2IpqDsHq5eKiuBqBIp/dPfKou/gEfPEpxlH+NS9GNyAiMLBDCJuO1xRoQaFIsGTV+jxoadPBTy/nhBHDVh4fSFjDHuhhMNUx+yf7UAyE953PecKAdCRS8g/98mYhJZtqFkoASwx0UTE/HyVlibCtjpjUPcOlLfIbzTGzeUf8hajmtW/5WqETU/wcHTEe2KKOKgdYxhlp/MY3xaESXgi9JCTEYXHnds+ledieF0cQ7QQyaTCXoqpJVgic61Y21O3csxJEs4OO0rB2mwpUWnbrKrIDROpPxIjgBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2mICiNKshgKIqA7/vTWWL+lmCnXK4rKmLYMS5Q8sXX7zoip7a5ltf202sGqQnibMqg9jiKcBkQESXragiqoWp8EXoxwxaitbhoH52Xi7NDqOpm9p431xuKbVH6CxKTJkn8eOMjsVZ2MqQZEQUWKg0r9zOjud8D4xjlMCc7l75Mt4od6JuH6PKwocC4MSF2387AKc2caliSn6lZhllAWERkr6TSB2xnzZ+XdyGgxbl0ki6nsMW3hhC2ReB1+Nagc/c109txrU4eTV4d2OryzahikyCdRuRxVuLsKmLIqXECq6rMK6OSu9uv+ZDxANpBWq5klI6tc3EJaJB4fz65nKskniC4vDqiNvMD1wBJDQo4tgHomocQ+s2zGgm03ISioHA5wyTiY8d6k44vzsDPoLORPyD+O92QkjPVsOFVAwYBKBFKF5SioxQxNfeQ/L9djX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:06:07.8369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369bf21e-3e1a-4110-a597-08df25ecf000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

__alloc_contig_try_harder() anchors on a single buddy order and bails
when that order is empty. But a contiguous run can still exist as
adjacent lower-order blocks that never coalesce (their buddies are
allocated), which a single order misses, so callers passing
min_block_size < size get a spurious -ENOSPC. Descend the anchor search
from the size order down to min_order and let the existing stitch build
the span. A KUnit test fails without this and passes with it.

Assisted-by: LLM
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c                | 15 +++++--
 drivers/gpu/tests/gpu_buddy_test.c | 65 ++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 1f648bcfce57..86cc1193ac64 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1691,22 +1691,23 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 {
 	u64 rhs_offset, lhs_offset, filled, aligned;
 	struct gpu_buddy_block *block;
+	unsigned int min_order, order;
 	struct rb_root *root;
 	struct rb_node *iter;
 	unsigned long pages;
-	unsigned int order;
 	u64 modify_size;
 	int err;
 
+	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
+
 	modify_size = rounddown_pow_of_two(size);
 	pages = modify_size >> ilog2(mm->chunk_size);
 	order = fls(pages) - 1;
-	if (order == 0)
-		return -ENOSPC;
 
+retry_order:
 	root = &mm->free_tree[order];
 	if (RB_EMPTY_ROOT(root))
-		return -ENOSPC;
+		goto next_order;
 
 	iter = rb_last(root);
 	while (iter) {
@@ -1772,6 +1773,12 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 		iter = rb_prev(iter);
 	}
 
+next_order:
+	if (order > min_order) {
+		order--;
+		goto retry_order;
+	}
+
 	return -ENOSPC;
 }
 
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index ec37c11877ed..144ab17b114a 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1660,6 +1660,70 @@ static void gpu_test_buddy_addr_to_block(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_alloc_contiguous_descent(struct kunit *test)
+{
+	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
+	struct gpu_buddy_block *block, *prev;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(pin_lo);
+	LIST_HEAD(pin_hi);
+	u64 total;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
+			       "buddy_init failed\n");
+
+	/*
+	 * Pin [0, 16K) and [48K, 64K). The remaining [16K, 48K) is free as two
+	 * adjacent 16K halves under different parents; being un-mergeable
+	 * buddies they never coalesce, so free_tree[3] (32K) stays empty. A
+	 * contiguous 32K request with min_block_size 4K therefore has no 32K
+	 * anchor and must descend to order 2 and stitch [16K, 48K).
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, 4 * ps, 4 * ps,
+						      ps, &pin_lo, 0),
+			       "failed to pin low block\n");
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 12 * ps, 16 * ps,
+						      4 * ps, ps, &pin_hi, 0),
+			       "failed to pin high block\n");
+
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, 8 * ps,
+						      ps, &allocated,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
+			       "contiguous alloc failed to descend\n");
+
+	/* The result must be exactly 8*ps, contiguous, within [16K, 48K). */
+	total = 0;
+	prev = NULL;
+	list_for_each_entry(block, &allocated, link) {
+		u64 offset = gpu_buddy_block_offset(block);
+		u64 bsize = gpu_buddy_block_size(&mm, block);
+
+		KUNIT_EXPECT_TRUE_MSG(test, offset >= 4 * ps &&
+				      offset + bsize <= 12 * ps,
+				      "block [%llx, %llx) outside stitched span\n",
+				      offset, offset + bsize);
+		if (prev)
+			KUNIT_EXPECT_EQ_MSG(test,
+					    gpu_buddy_block_offset(prev) +
+					    gpu_buddy_block_size(&mm, prev),
+					    offset,
+					    "block at %llx not contiguous\n",
+					    offset);
+		prev = block;
+		total += bsize;
+	}
+	KUNIT_EXPECT_EQ(test, total, 8 * ps);
+
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_free_list(&mm, &pin_lo, 0);
+	gpu_buddy_free_list(&mm, &pin_hi, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static int gpu_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
@@ -1742,6 +1806,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_contiguous_descent),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
-- 
2.43.0

