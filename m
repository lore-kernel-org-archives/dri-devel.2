Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86251C5DF8A
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24EB10EDB4;
	Wed, 19 Aug 2026 10:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mb69/SAY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A956A10EDB8;
 Wed, 19 Aug 2026 10:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4oMeMRPshF7phz1uARSE+kUs9ajcuKphpmu7o4X9N530kgE1B0qbF+qDF/nigMZe6sgNH3KHhEVX8K9cDc2vF2WBWAVorr9zdNccWgwCTttEr3qAA5lK5qMYKH2DKs4TK3jJM4K3F767ksjyHtTEVDr5hYvijK8zhqxP8U2cDlR3Nq5gzblpUfFVao8+fiWS426aW3UJh6fn0Ale0P/9vPAvmcEG4sTSK7Mt5zRZ029AGO2EqH/6jZ24SyLpXV0MOKiOjn7gsKAbzrl5pgQh/EwYEer2k9kW+egygr2c16hk6R3/Pzudg4Wgwkd/HLSVJU6LuwFaUC6xlSzKrMC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhXMP1bQPEdWWSxlwIRVLQt/YNE/HjKxPO9ZcmAInjg=;
 b=SElP/bFTQiPI6XRdxJ9Lv+rAYssbue903IlNnMsasA80wQ4kmYHh9D8EqlGBXDo99Lc3Qc1a2w3ws78fQEEam7SJNecENf9Fy50CFBmFRHLYWa/foeL3O+rfq9MZhkiaguHwJJP/IOIWzI3jLZ18rpblkJcfOvOL4oRZKq1TA6A5km97HPOjK9l6Krrms3S6RMtErj63D7Besj47uX8EWdYk+90hjcs6EiTmFb1bnb+Xapp8vv7h7zGtRggqyIHBacGeMYrBYCNSs1vT57fKEeW2Jk5YzIMUK8BaxzTdFEdfrCoXI+Omtjc3IB4x/IrTa4JcyWvVrLU1+WloQo0epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhXMP1bQPEdWWSxlwIRVLQt/YNE/HjKxPO9ZcmAInjg=;
 b=Mb69/SAY8UVBnBnmRaeuEonk2BrJLg1gVy59p9TRgi5yQ9LV5wDdoTIRz8dYMD5/gzSHZ6AvS8Oohp5jKlF2aJfxl3aFrrhnNPK/B+wiNCjSAmu+WwaYlQWN0Vop9KpjakS7LsU35uJPAX0VNUWTJQFUPGn8hwlUvPItRJebyFQ=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:43:07 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::27) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 10:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:43:07 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:43:04 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 2/2] gpu/tests/buddy: add dirty tracker performance KUnit
 test
Date: Wed, 19 Aug 2026 16:12:42 +0530
Message-ID: <20260819104242.10703-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e84e8f6-017e-4e70-9cf8-08defddea7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: nwkgpGd2cBOmm0M1ky2ryA/5PDkDklGWiqd5Y5nNH5xmAvDRg6Fiz7X+/GjSfXcO4J27ianOcHX3eSpqaPg6L0seAgCE1eTUMAvrdf96dVuwiHjfNEAzssuIOZ28o5x5llkju3hzfY455X6fjBUlyZbJR4hbCxsr56GUDJaVVNvZZXGPFKCXXNinxMLA08pjNzS146rmRR5WGNZFNyQoHNA7bzAc+oGJqW5lvhzJI7Wm4u97xtKva9tjeTNiMGTXMvENhLeyBePvnOOki0AJZ98lzqkdga2blN/2ikDxbdE1IwGvr8pZeEo7VQvmyHteePywus6KFppBt67fl84IRFDB1k4vXmwsGt0/wvyGgTqFEvSTGrzHWqRNXdwruH/6ZCfTllfIpXwfpt7sz5JpsjO8jShGM36loVK5MVmdsFhMGtbF5VX6tzYuJn1NqFQ/Djpsga/WiH9BrXKcrQc/9EaohYt9b7IBINAmcFSop4dxa39wBz59kir/60jZwOKFkRrgZRfF1cT5oEqsNRBdfuDP89/oIayeNAoo9yXgZblR3jaj4Mvg/t/4P5U+BkXITz9Q/9vuSS3rA2Akqb5dKxJiAg4rLN3z55yG6tSk+HDpHV3nGsZEHyVXsJhpqVLlj3ccxEPx7UZjGi7D11nGwyG4rtPPIOf/2vMykyIHZ6rsw1wJ4nR4EY9arqv8VPYmefjRutyl4Y/iRtwSXXTFSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lEaxpnEOhSudX2/lI5p5BOdPOSp4rWOV2Du7qS7815+9K/HID6MjqCB96QBgKR54c/qbuzc1a3bVLxArg6wapIalWiaX0r2CNyQp1yFy/AE+zeIMIYceARbNtI65M5+rlxuYzSWYJKw97zZckjVQaweZW5nr8vKanIYPE6ooyK3X566UHnA9l0uDw2+GraAWRTS2gF38s2JdsCjHpx4P8XoEp6Cf92Jh1IhC5q8zsNm4h0uRZfo9zEkprJ97wuxEua+wEco6hEbyNTrDSynwWi65I0LCbFeLirschagtwBxZkORs8z9pZ11lNuw57SL0KP4mgXvY0ITxbhvSw3CTrn7ldCE0+618hIsxYRqNmb+eaSPoht0s10rBA7TFc/814FIvtxu6O8cGpTlc2xJjT1pcjVbVJd9dygHNfmTkK9PMQ72asOupj3ZAXKJntDBT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:43:07.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e84e8f6-017e-4e70-9cf8-08defddea7dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
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
index 6ce485eae83e..04344468ab6b 100644
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
@@ -1492,6 +1605,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.34.1

