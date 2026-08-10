Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54E1C5B569
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106C510E75E;
	Mon, 10 Aug 2026 09:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTAXF7xo";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A69F10E756;
 Mon, 10 Aug 2026 09:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc/KhzSzY7x9iCWEmT8ruXsp+k6nXoOcEal/VOfpz4VQzHV/PgWEcFKmkNiigXTG3UILacOy+qsDffkvzKUokkiq9DdW+cbwh3Bg08AfjB82eYkT2Ul/ANaPy+EbyqaLcWQ2NWAoQHT/0N8NhNQLS6aHRhzroh0WrHaLZgm0m6DvZKGX0PaFta6Paq7ovMa8iapHoT0KUacCOqIt0ebEahqTsS6OTVuYtCDkTGoPPO2ReqC4c0aRwAtE/8Dm5NISddM9SGbjawI40HwsvbCI5ISGIy1bPQB+XLhREMJNlETDzhlANN3hZ0oCc9sPBPJj9hqHt3Rcn2vdvf29JabHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxaveEQGp+h/rJHZ2P+sFo0B/bBq0GhEtQPmS/OlokQ=;
 b=AsaPjperwP9Kr0TDQ8MIESNOGT/kggE6pqHsaRnHmCIlcKdKzFkupCgdnTnYZlg915s4QqQBSaCa6eQwA64at/A2PryshUV29Hwc2n6e8ygYItdORNoFuD4lQYkSqaK6UKrEgZ9hJqD8/1HIjiJBEESoJr4vy9Kcd63s8vWbnMjxbuC6zzvhNmNFKHY3zXfE2hICzJJsT27OoF6HqLPm0xvNQkdn95Hv26RHJbOyj+FgCC8nridiZb/2IumNdUN7TpkyO3NJ8xJS33k8rpara819L4UOZCOSWyg33iBiI6ZkHFcWe9nDvlCt8JQGl8pkkVxBAES/u4x4STgHq2GxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxaveEQGp+h/rJHZ2P+sFo0B/bBq0GhEtQPmS/OlokQ=;
 b=RTAXF7xor26xxYVnOzvXmovmj5OJa+ZQPTgJa5io9ymxJLdnP24FULD4swcFhXd+GxnQE2/+bDGaaYGHSAZuvabalem8Riw5v7sss8G2Dn6yGWzFX8PhYBVKhK00JHvSD3C/n82TFEPaKL6Mvv9Mu8jR/B/OJ8M3sdnBMFLeXE8=
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:12:50 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::68) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 09:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 09:12:50 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 04:12:47 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v8 2/2] gpu/tests/buddy: add dirty tracker performance KUnit
 test
Date: Mon, 10 Aug 2026 14:42:31 +0530
Message-ID: <20260810091231.11936-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810091231.11936-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260810091231.11936-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: ed56c984-92cd-490d-90eb-08def6bf8d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|11063799006|56012099006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oZfxxG+U2j+9r2bv7KehGDSH+6WD8yA8HRxJwgCZxJAX6sr7LNb4WRJn/eV5F4TfYajiwNfDUQb6vDtHq9jiUkoOFwVsCepM5EQBhQjYkJrdkraKMulDU6w2Wztx/fB+kU/G7Nd9IS5Y7R9xjsa8G6qHZu6pM1hubC8I68eUp1wmygJmF3KYO6BAZqIq0JstUhUYt0jn7m66vzpYpfu3m3r6isr4rcJHMxavy3VODDecr04CAPu2qAYcVEvllkiP8jUJM0a4BhvdzOcKxqIv+IcXv0OgJHOz9cV4kYLlGQFLqAviGm//ywSZAlJk4/PTTPBp6LdajX6ipm3Gt1GMFTGbPuqK08XpcGtpZfENjK7V3a931+nmM9ZR+aUgu8kYP7IsK+TZTUe1u3E2KZEOYXzvpjpKyfJKF5i+P2OLkgouBHfGMN+9k3HkeJAex/8mqECihlsPF3qkQcUGnZjDwOpXvtX7/H9U8YoyzhIE4jivRh/DGim+RIUshXZWddqbwnq4dBI5enPnVujpHrJFOd5YopN346vdpHHZLJ6Vu8WhBGAvCIKuLkNNwhUx03Vp33HbBkuu0y6T4XzvGJXa/H4I1Lx/sC0SlIlReIs0mvctu96ZNPzPFLtqlsefckvZi08snHqy3hF8/EAz8Hc6SQi4KCq0gpKtfuvWeeQYL9rnigb+QhYuWEjs4zM/dI7DL4WVrYA1bU0CjOCVIYdziQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKt+YGkoN5HidR1BV4bAt47WeKDRA3Pq0VKHhW+O2UZ87Dca5eQBvFl0ubx1pGzM+V/v8zxA+w9PsejaCTxFkdzOtiDW/CI/dXFJwD3qphJSKOxreBaiwnoxLtiq8pmWfpPcrxureDmy0M8RQYT/mVP9nnP0A1vkTjiHi37WOWlrgHVqq92DGq4Ktzc/dpT0ssJuyt9e5pfAqaBI57g437U/L6JPVcaISZCZKvFh5+956PiwpFgEekrAaZlzwVBQiBMSS0M+gURPwzcZnZ4ljrsP3x6vtbBzH1qcrt1PronwdgOAc4Znl6ZJ2lIexbejI4zRa3rW0BKSU8xyNmTtoIGWS20h4QyBYaFHatIfbuJyvp9dQUW8J1AI9+mvnok4Dn9yyGx/sDmIl+k6knjeXtc6f4higD2oF0IPGntboo6hOWIl+UJ7f8LDY7B19jKX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:12:50.0573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed56c984-92cd-490d-90eb-08def6bf8d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

Add gpu_test_buddy_dirty_tracker_performance to demonstrate the key
advantage of the decoupled dirty-tracker design over the old dual-tree
/ force_merge approach.

The test runs two scenarios on a 4 GiB pool after alternating
clear/dirty fragmentation at 4 KiB granularity:

  1. Contiguous 4 GiB alloc: the old design requires __force_merge()
     to rebuild max_order from scratch; the new design coalesces during
     free() so the alloc is O(log N).

       old (force_merge) - 71 ms
       dirty tracker design - 17 ms

  2. Repeated 256 KiB alloc throughput: the old design pays
     __force_merge() on every alloc; the new design does not.

       old (force_merge) - 95 ms
       dirty tracker design - 24 ms

v2:
 - Force a contiguous 256 KiB allocation in the repeated-alloc loop so
   the baseline actually exercises __force_merge(). (sashiko)

Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 114 +++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 198d8dc4e3f0..4dc54ed33269 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -283,6 +283,119 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
+{
+	struct gpu_buddy_block *block, *tmp;
+	unsigned long elapsed_ms;
+	LIST_HEAD(clear_blocks);
+	LIST_HEAD(dirty_blocks);
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	LIST_HEAD(results);
+	ktime_t start, end;
+	int i, count;
+
+	/*
+	 * Contiguous alloc latency after alternating clear/dirty fragmentation
+	 *
+	 * Fill a 4 GiB pool with 4 KiB allocations, partition them into
+	 * alternating cleared and dirty sets, then free both.  In the old
+	 * dual-tree design every adjacent buddy pair has one cleared half and
+	 * one dirty half, so the pair sits on opposite sides of the clear/dirty
+	 * merge barrier and cannot be coalesced at free() time.  The pool
+	 * stays fully fragmented and the subsequent contiguous 4 GiB allocation
+	 * has to invoke __force_merge() to climb back up to max_order before
+	 * it can succeed.  With the dirty-tracker design buddy pairs coalesce
+	 * unconditionally during free(), so the pool is already at max_order
+	 * before the timed alloc begins and __force_merge() is not needed.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
+			       "buddy_init failed\n");
+
+	for (i = 0; i < SZ_4G / SZ_4K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4K, SZ_4K,
+							      &allocated, 0),
+				       "buddy_alloc hit an error size=%u\n", SZ_4K);
+
+	count = 0;
+	list_for_each_entry_safe(block, tmp, &allocated, link) {
+		if (count++ % 2 == 0)
+			list_move_tail(&block->link, &clear_blocks);
+		else
+			list_move_tail(&block->link, &dirty_blocks);
+	}
+
+	gpu_buddy_free_list(&mm, &clear_blocks, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty_blocks, 0);
+
+	start = ktime_get();
+	KUNIT_ASSERT_FALSE_MSG(test,
+			       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4G, SZ_4K,
+						      &results,
+						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
+			       "contiguous alloc failed\n");
+	end = ktime_get();
+	elapsed_ms = ktime_to_ms(ktime_sub(end, start));
+
+	kunit_info(test, "Contiguous alloc after fragmentation: %lu ms\n",
+		   elapsed_ms);
+
+	gpu_buddy_free_list(&mm, &results, 0);
+	gpu_buddy_fini(&mm);
+
+	/*
+	 * Repeated alloc throughput from a maximally fragmented pool
+	 *
+	 * Fill a 4 GiB pool with 4 KiB allocations, free even-indexed blocks
+	 * as cleared and odd-indexed blocks as dirty.  The alternating pattern
+	 * ensures every adjacent buddy pair has one cleared half and one dirty
+	 * half, so each pair lands on opposite sides of the old merge barrier.
+	 * Each of the 16 384 x 256 KiB allocations in the timed loop asks for a
+	 * single contiguous block (size == min_block_size, CONTIGUOUS flag), so
+	 * it cannot be satisfied by 64 stray 4 KiB blocks: under the old design
+	 * every alloc has to pay the __force_merge() cost to rebuild a 256 KiB
+	 * block.  With the dirty-tracker design the pool collapses to one
+	 * max_order block during free(), so each alloc is a simple O(log N)
+	 * split.
+	 */
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
+			       "buddy_init failed\n");
+
+	for (i = 0; i < SZ_4G / SZ_4K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4K, SZ_4K,
+							      &allocated, 0),
+				       "buddy_alloc hit an error size=%u\n", SZ_4K);
+
+	count = 0;
+	list_for_each_entry_safe(block, tmp, &allocated, link) {
+		if (count++ % 2 == 0)
+			list_move_tail(&block->link, &clear_blocks);
+		else
+			list_move_tail(&block->link, &dirty_blocks);
+	}
+
+	gpu_buddy_free_list(&mm, &clear_blocks, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty_blocks, 0);
+
+	start = ktime_get();
+	for (i = 0; i < SZ_4G / SZ_256K; i++)
+		KUNIT_ASSERT_FALSE_MSG(test,
+				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_256K, SZ_256K,
+							      &results,
+							      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
+				       "buddy_alloc hit an error size=%u\n", SZ_256K);
+	end = ktime_get();
+	elapsed_ms = ktime_to_ms(ktime_sub(end, start));
+
+	kunit_info(test, "Repeated 256 KiB allocs from fragmented pool: %lu ms\n",
+		   elapsed_ms);
+
+	gpu_buddy_free_list(&mm, &results, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_range_bias(struct kunit *test)
 {
 	u32 mm_size, size, ps, bias_size, bias_start, bias_end, bias_rem;
@@ -1490,6 +1603,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.34.1

