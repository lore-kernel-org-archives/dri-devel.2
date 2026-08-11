Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E43C5DF60
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA20810EBE6;
	Tue, 11 Aug 2026 13:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BcI6TMou";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B2410EBF6;
 Tue, 11 Aug 2026 13:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMs/IR3b3N9JDlYhnK6+dJiXEcsXSxWpLfQ1Nvav5lqHnKlS8ABtLgV/S66UWyyKCb9TTrOpI3xZKRB5qvdEG6++fqE/qEU19moVjFcRPIMVd6Yodm4/3pgUGRNoj8JHNbYnOKPV1QDuQIeGgYSYIm657ufQ87NHI4ysDIuswAA88B/seZbsXVO0rLGCs31qoxohExZswg/joHQvKwqbctUimAeEewOHDYl9f6GaJ2UWhURa0WyugCmV5RsgcTM+aw9oF7XrYgeDb0LYKeOjMz9f6GVgQQBGaSey/KZpzMH+vjkUaq9a/t4fbqNUQ1p/l/to8u8BD4EEqOn9g2oKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxaveEQGp+h/rJHZ2P+sFo0B/bBq0GhEtQPmS/OlokQ=;
 b=Y82scz4fmyNKjPzRgSfGwM4UbRQVcE6DtSNN2aCXC8ng70YsXT90PEhHQSDXUNZy/zWajW9V76oSP1iKmOdn+7XzLJa9/m1jiDWea8oVAEnBlCYvKLg9kfltnEJuaKHwYb9ayj3xytih367HAJzxubp2rgKALsRwy5V3yeDkWiS69nrDPJ8dqZF0ZNI84K105bgrhg8Yz+rMCJtjEkRQ7zUJwmmg6tb3J1jDpzsSDGva5r8SWJL/9bNAkj+26CKPTUS8Me8GrrdKFu9LnpXqhezz01VrEQaKsfATchsPjLqKt0s5ieInDlGfkXDNKF1S9Gy88HRGnXI5UXSmtWLEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxaveEQGp+h/rJHZ2P+sFo0B/bBq0GhEtQPmS/OlokQ=;
 b=BcI6TMouqn6BV5poLyxCQy665t272XhsJRKbXhCYu/a5a53+Q6suxpIYfHTjW/+MR0e8hl9vKQ3XqAKv/9XbzNZ3l0afnnngoNp5/prdT4YBr0xw2BK2aEgQMmT73BC5a//PSV3ot7aY9RJ+h7OhJnJpMVdB3wrI8hXNYcVgdfQ=
Received: from BN0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:141::7)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 13:34:54 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::b) by BN0PR07CA0014.outlook.office365.com
 (2603:10b6:408:141::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 13:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 13:34:54 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 08:34:51 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v9 2/2] gpu/tests/buddy: add dirty tracker performance KUnit
 test
Date: Tue, 11 Aug 2026 19:04:35 +0530
Message-ID: <20260811133435.1027099-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811133435.1027099-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260811133435.1027099-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4478d5-9bb5-4e1d-83f7-08def7ad53ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eKNq1jPYmhtTFkj6ImY40DOjg3gVrLkQ+0MEgkpWJk/wVUeot3uCZ59NguCzH0wkezvTAlzDk6+zR7PShDSbzq4y5jJZfdfipDtDnw1k4J/XEIPdcbVg9PFHMQQK/41LmWizXwPn4olDzLIZEz2G4r8ixvH3DpKfSO+xL+MYYdkJZw1w/dMVN1jWvFSo47hCUfYdYXU/Tmh+ts71CgZo3HV5YzxuoTM+LQtQowzu0BKoNLRdTGrpKYQRMbN/DQxk+jh+mtfL+P4l4XTJ38oQg7YkNm7TZAvgJi3VKrrm4oymhOMI2SFxKTDZPYRaK2OxNrUfWXqQdbKwrxBhNaP8xuA2y9YwGB9h3ZnmNlrhf1iROKxWQQtjg2MBtIQpVUCyh7aDCe+9NFtvG8lMdV34NXsQvlOWcrzYdcet6W8JVFZRcC3RBoTLvL+QWhGrW+ftrf7ifqxkCaWhPSg8efyvYgiXCgVJoiDkd4gCD2CXRizOCtFicND8UKPsKSyJCuKxDnVgiRejq1rtVxdYK3rIhhNHCyiCmmNTFUj1S1GDYMHKo9bRYggB7iEv8fIvSQDT2w7tmFbD18LUuKQ2BtmsAAoEBl7+F6jOI3zIsI2qVAPttn0R85YvaaAA3qefLhaQhdBi7BePVmqSYJoKoMD9tycoyCoy0HaJ5xJirYMSp3GJfifuny8JJgcwKVDhHWwzvED7IjhlivgdVwQGmeiYfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H5oxeo7uNf/RaKv5ucwSeFTF7GXO6/tTZdvw5Q1F8gsZssjDapdtIeJGrdUyc0eYbeF1zDyyDnh19tuJaH8fKVqYW0U4IRfJ2wIHmRzOuanJBSeo/BaUg8bQlCz1fB//9r5pxC/g13gAfND+3sEgWu4BkSkiTZ6kMdJXkFOUwcM5jPQWvgby4Rg8KbwV1jrKmZAS9I7VHZURajlYh0lT1j76SGX3Zh8mLow3oN+ztPZvqrKN9dYvF0sXMioA+heg14tmCN/zzk8CPuWNfETwtQz9kyZkVDUoUv85y8kxerQNHs4FWg+6U+HqgTRvk2QVmHBHzF+/r03DHbF3E76a5NEm6cR4mOYirMK3NH3T6hLGx4YiopREA80Br9eVoBWXySjABKLW73cv86OIXRtwV9BQQzmE8mw1zB+1wDhLN3wS8I1SFnKKv/U2OiEfEzK+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:34:54.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4478d5-9bb5-4e1d-83f7-08def7ad53ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
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

