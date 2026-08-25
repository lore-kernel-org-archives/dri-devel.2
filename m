Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5872C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030FB10EB0F;
	Tue, 25 Aug 2026 17:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yEjLbIWE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209AF10EB0F;
 Tue, 25 Aug 2026 17:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svtQaPio5Ugosd2sT5VV0WqVUoudb2tQujdCKbp47gyhKVRgccpk/RUmgZSw+Ykc6j6VZwtCxYJRy0x8R6jPHs49Jj6uMzkUcaL96gBiiyYlVRpsU06O64uQbFlA7jrm7Y3tzhZofchZQ8n8HvBhF8/76pQDEpwGTUGgwRrjcksf/fXOqNfjSyRHPdtMrGPV48PyOB2/WCmlDaXBQntBa0FHgTqmN7hTafJlfroSdcsUMN+I8LnVazb6fxAfjmAM2ZgKoqcocQOH+5QA12pf3I94SfCkudFzuHpLi6a50HSguypzWYaq1sO6GxhAOcTavz4UhRLwpl7a3XN+PPzH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MK18PQCHjifwZ0kKMf3QEDpMFMbTmOYFX7TQBRtO+s=;
 b=lh/HYeXFRisD5LuJIJOnD3QNf1LNjYLTnjneKySieC49b2QEk/cUi7L2xVkzEx5vNrXI13wVq94hqKO1oCIbqSwjSyy5cXK9ElubuhUK87UhPhS4IVzUhy41H4jCuqG/p4c+w4dYYdfphOkY1Rb5wi9Q00CkMmMyavwqHHyMbpeKdf9lqw+sjky0ABqgNgT7e7vDGk/+zgYD4nBDlBdEVW2Esk+o+TErf9lXjU6HJX0bNTGbxRJPDCek7Uy+ab7AmaSGmxiAH+79wK+Y9eIUQf8QLaKgbLnOlCrikoMh2MIlGu4HVaf6InXnvjPmHsR/iW0aycaGIWpBopvLc8AhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MK18PQCHjifwZ0kKMf3QEDpMFMbTmOYFX7TQBRtO+s=;
 b=yEjLbIWE7FoozlPZ6wzglIWxtd/u8F3sUviuQjAMa+jGA21VoUl30FeGsDbnHvtLTfsfFcpTK+Xj6Ks+Mzdk90JdJVwHgjSYib7bIyYUewbZAQrGMzUgI3e8AZ7r9cXFTDDKhdZcLZVQ1wm8jCy+/G97cl1rxyUE2snAG6LfKH0=
Received: from BL1PR13CA0369.namprd13.prod.outlook.com (2603:10b6:208:2c0::14)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:25:06 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5e) by BL1PR13CA0369.outlook.office365.com
 (2603:10b6:208:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Tue, 25
 Aug 2026 17:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:25:04 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:24:59 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v11 2/2] gpu/tests/buddy: add dirty tracker performance KUnit
 test
Date: Tue, 25 Aug 2026 22:54:32 +0530
Message-ID: <20260825172432.80355-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825172432.80355-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260825172432.80355-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 23808aea-ad22-4b73-ce93-08df02cdcd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: leQmaVUGBrl0ZEV7YXXC86R78skNc8IfMqQDqdAsx3q+QRCcsWIFE8xdyjy3kmBOSfHfRSpjLnQ2O9GNDlCJvJjgcYPvE/ZzkicDasI/1i8CODFeiyZ1jA6Ij5StxIMe9cPqLOL83Wu386e53hwWnu8wraMTxWRjAHmQqNLy2MsOA/pKMrxEpB4IJSC8iOtHNz5hrynr51gb0r1EmhLSjQCOnGVarEft0Ay8jI1zNU5c14nfPEWFO6e6stt4AaDGAtwURD75FkdVqZ66AViSGeiK4ZZizfBfMoAGJf4g8+zwrePrbm96NxPsOjyHAoIUmGNE6QAFFeYBaYWw+oNSWEv+0Dw5F6FIX8OZnPnqPN/H6Be6i4m8UZSn062p5xt7o+24WvT/OZMVXd+jt1UMmse7d4lL8ov4OFC+eL4v18RtpajrP+fuLjGT8xfeyPbkpGrx1veHQsZvoyWJR8tSRmb8pwekjxHwIVFhXinOGj8f7/jCyi4TznhPCRb5r5FHOQ4SVKaJxVufv7yTEJkRY4hW28tKP+1Y5muItbng8YWI9/vzgK3b2fBXRj1D8V8X1Qql0g56h+c7kr4nhIwXz9We/0HZPcngcGCbEjiRvRUNklxEZILHeEObVFtuccxz0KYTOJJ9BNoP6joktP1sTcoOVdXJ0bsfiz4VL9l3ZTK+CaJ8ZBq5zVgtF4icdW+JZf0ufC1/MgpO7A9ZEk6sxg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vWNyM1l2h7chzMwlBA+4cBB3iAcbu/LxprW7v8bbkRtyVXX5YBYxPzXoXLnytT7UD9M2+/0IKOuFhcRWYO1ZWAMUHBPbsRHFZdgBZm/h1lszXIOVSTE02fkXbYsJupLUTkNfoR0d3BxemeAUiUkdZx6GTuO6T+p+uvbJE7JlT0lK7srk+/+6gmaquhsHv7ck9SadNhL2BOjZbdIr054JkPzrA19nYaozejXSJmpNkKbpJmau2C6ys6o9mUKwT67G1bmcv3k8ThGv0pmJBuURmCpavmDGB2lEwDoNDQAA18VA4ig0F10FWtYrDtqXlAIsM3lNhUajYVhETyNZX+YraNNaBnDYYDuPDR2OpUz6L+MwyR72rLH7+pNVaRVXqj1W/10VNQ2nMfy4v0Ugkfx3DN8wkBnuDoMjezX9nw3PwBgmO9DAiucfS+bqaWiF+i/n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:25:04.3507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23808aea-ad22-4b73-ce93-08df02cdcd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

  1. Contiguous 2 GiB alloc: smaller than the 4 GiB span so it routes
     through the contiguous allocator rather than the exact-range fast
     path.  The old design requires __force_merge() to rebuild the
     block; the new design coalesces during free() so the alloc is
     O(log N).

       old (force_merge) - 45 ms
       dirty tracker design - 11 ms

  2. Repeated 256 KiB alloc throughput: the old design pays
     __force_merge() on every alloc; the new design does not.

       old (force_merge) - 86 ms
       dirty tracker design - 20 ms

v2:
 - Force a contiguous 256 KiB allocation in the repeated-alloc loop so
   the baseline actually exercises __force_merge(). (sashiko)

v3:
 - Make the first test allocate 2 GiB instead of the full 4 GiB pool,
   so it really uses the contiguous path; update the numbers. (sashiko)

Assisted-by: Claude:claude-opus-4-8
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 116 +++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 6ce485eae83e..b75d32ca6ca0 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -283,6 +283,121 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
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
+	 * stays fully fragmented and the subsequent contiguous 2 GiB allocation
+	 * (smaller than the 4 GiB span so it routes through the contiguous
+	 * allocator rather than the exact-range fast path) has to invoke
+	 * __force_merge() to rebuild a 2 GiB block before it can succeed.  With
+	 * the dirty-tracker design buddy pairs coalesce unconditionally during
+	 * free(), so the pool is already at max_order before the timed alloc
+	 * begins and __force_merge() is not needed.
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
+			       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_2G, SZ_2G,
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
@@ -1492,6 +1607,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.34.1

