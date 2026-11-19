Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB03606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xdffMdxJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6660E10E89E;
	Thu, 19 Nov 2026 13:18:46 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C679810E893;
 Thu, 19 Nov 2026 13:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+xARIoWtbFAcZWLsWw9nqjELhTCdscH0csdteLhaKrgGxNqQztNneH6D6lzMe5fLX6FslOdjOi/BhGUm4mVTxrmbCqBAaEL44p4AvEQFV7rn20fM/k/ItdbwISNmQPZptcDEroPm1frpjJ/RXzCQteUKOcVEBqwyOqtuZS0fBJgL1Fb9/vVmLQjWwaQCMpasTPWcc0py0ip7yz4ChcxfAdc5g1Ioh/zRU4q9WeFv6ll5rULDsAxEPcOARJ3gJxacZVQ5VKTsVBrnINc538Ja6wEYsEMdStDpWA37iv+te9ivNtjGQ5U9TSm2lZA84QD53zDFb5UMtHaDOgwcBBCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT+W0aa1oo0dH/H/B/aMkO6vL40WjjQ/RHReNg2EJSU=;
 b=hQQbVeqBt5JkTx5tDhHxqVOTFJxZh7/MChdJgRlvSOhLfBQS0I7vWyu/cGWhNccQEQQWQFhzdJyAvDFOa0PjOYqjmIRD+Qs3xyIIfIiTwWBFHJn15PoLrDp66CVLgAg9HcriJgBL+MpmNjHdpAAzJK8lqq36CMCl6bwc0XHMNvNQgVFZnC2zskA4u+ME0sSeby2DeVlE47ApJkw9MpbAA2azJ1vYKXQ6ZsXZibSF3zsuWws9FuGuqb2NKpTkIWvB/NENeWL9nFEaAtYdCa1RoA7qOyiLucCRkrAKRqSMS5b9m28u7VWM5DFS4LEF3Ku3qHE1w6WJQScTWZg7Yhbzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT+W0aa1oo0dH/H/B/aMkO6vL40WjjQ/RHReNg2EJSU=;
 b=xdffMdxJ3O8E/rWEaa+2TQVX8fv6buX0OfwOhD37Mq2vChpE47y7U5tEZk8GtT8F+tUj3YVmrZHbABmibdd+R6YFtvQEBDcdW5i0EQoLsMp43xBeA++VoifOxqFqtj3lR244gjolX9PIeHqzQYqbzGQqVDjPJwDQERwFWNs9s2k=
Received: from CH5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:1f1::20)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:18:24 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::19) by CH5PR03CA0010.outlook.office365.com
 (2603:10b6:610:1f1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 13:18:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 13:18:24 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 07:18:23 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v5 2/2] gpu/tests/buddy: add range-biased allocation tests
Date: Thu, 19 Nov 2026 08:18:10 -0500
Message-ID: <f9ad0194d3e7af095fe98addff94aba208cf7fb4.1795094029.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094029.git.William.Palacek@amd.com>
References: <cover.1795094029.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f527dcc-dd65-41a5-890b-08df463f9780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|22082099003|18002099003|261009223027099003|11063799006|5023799004|56012099006|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: WiqNhh9kHhwU9FIm0j4MZQXXL6A0E5puIRLTYLg94+1maJXod3C1nRFC2CrhJxYEthfrfa9R4lchaZ8lGEEQmDFLWpPMmslJF4BDP7Xa28WsMzIkms4F11WTNWLCtRSoozX581JgAFxomRThWujCj5JCyGDl0PhtEfig5uflyked1dpLrNqj3xzZDVD8m7RZVO5+6/lMfHC76KDQVdyrDOacP/slHejLLxb4uw+em9qlTYDAbfrfNlFdvzRaD/qlf5sV44jp3KpZ712YBvAlyXYiuZC7KEUECTHmeqmvAAeV9+uVZLOxbwvAbmTYwUSZ+qy+CRaf7jQKCiLy07UXQ2TfF/1ic3QxnXIetc+dneZBkCq57sJy4H+QYgmNrUcpELAlcT9i9+S9D6GkeFKq1rK1l5h3RpvKDaPu94sbqr10A3e9MuomVFQQvRn7htBXVFxHb/2EZ56gXb/3tIl3ZOrsdMXKbc7ch8iRdZIs9IymIWDlh5p2o95DE6iLTCFxRUhSqq8e4hZQNDRuFhid90fsLgwuf1rAMUtiEvZl07Jwu//PDFtOyOVZWOC0s6LS/yPvym4J5sLs1ST1hEUbint9xzrlihlKAT2yQEGHUSKgUd7Fihtm13Cjzq6aHdXKRlzloMFkSGfnWfr8phBaibmFw9g3H4k4BuUMTlfZaTtJ8ltFTKMQdHy6UvIyEGYm9RgzumDmHiPgtBepSlT35Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L0sl6wKd5on9KPyqcIhFAmLXnDqbAUKK0btN9nfu60gUxcYCjPRhkGftsoiURjm2MYngOZt+45IZQTj5fXOszQzGjXOVWdKNo1z1yba3Flu2+2/0okjyUCNfx5w2Q2ec9Bc1FfCRygIBZn1LfVt+mxA59Z+hhySt4VvTZyKTmUGTuG+/4sCP5Z9iKdJjFyyh9uAfhnfZdMAgO2+qf+vV2BccCoHb5wQmtB8r/wIQxUiY8IaD3cmbpiZy1BYjzplIVMEuHOemsgNKzAItwKDoRSQlYJKAyUbjFiDUgAV5YabMCGhcX3TP0nULInrhTeSEh5V0cYe4Pami5iIoAHEso77zy4+tPydzXrz0/f7xGcGmb8uYCSFYpWV+OvkdVdA9Y+8pkhkSJfp6jyUeihXpqa2liie/CqpwcNpm1kbHmaW+4zEDP3RNw4GL7qkTdDnn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:18:24.7934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f527dcc-dd65-41a5-890b-08df463f9780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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

Check that a range-biased allocation with start > end fails with
-ENOSPC.

Fill a 1 GiB range of a 4 GiB manager top-down with 64 KiB range-biased
allocations that request cleared memory, as amdgpu does for KFD VRAM on
NPS4 partitions, check that each one is placed directly below the
previous one, and report the time taken.

Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: William Palacek <William.Palacek@amd.com>
---

Notes:
    v5:
    - no change
    
    v4:
    - add the start > end test
    - drop the before/after times; with Sanjay's pruning the old walk is
      already fast on this test
    
    v3:
    - times for the new base and lookup (1103 ms, 2 ms)
    
    v2:
    - check top-down placement

 drivers/gpu/tests/gpu_buddy_test.c | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 9aaca2fc6a02..374f576c91f5 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -283,6 +283,32 @@ static void gpu_test_buddy_fragmentation_performance(struct kunit *test)
 	gpu_buddy_fini(&mm);
 }
 
+static void gpu_test_buddy_range_bias_performance(struct kunit *test)
+{
+	struct gpu_buddy_block *block;
+	LIST_HEAD(allocated);
+	struct gpu_buddy mm;
+	ktime_t t0;
+	u64 i;
+
+	/* Fill one NPS4-like quarter top-down with cleared 64 KiB allocations. */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K));
+	t0 = ktime_get();
+	for (i = 1; i <= SZ_1G / SZ_64K; i++) {
+		KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_1G, SZ_2G, SZ_64K,
+								SZ_64K, &allocated,
+								GPU_BUDDY_RANGE_ALLOCATION |
+								GPU_BUDDY_CLEAR_ALLOCATION |
+								GPU_BUDDY_TOPDOWN_ALLOCATION));
+		block = list_last_entry(&allocated, struct gpu_buddy_block, link);
+		KUNIT_ASSERT_EQ(test, gpu_buddy_block_offset(block), SZ_2G - i * SZ_64K);
+	}
+	kunit_info(test, "Range-biased fill took %lld ms\n",
+		   ktime_ms_delta(ktime_get(), t0));
+	gpu_buddy_free_list(&mm, &allocated, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
 {
 	struct gpu_buddy_block *block, *tmp;
@@ -1606,6 +1632,45 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
 	return 0;
 }
 
+static void gpu_test_buddy_alloc_range_inverted(struct kunit *test)
+{
+	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
+	LIST_HEAD(low_dirty);
+	LIST_HEAD(barrier);
+	LIST_HEAD(high);
+	LIST_HEAD(res);
+	struct gpu_buddy mm;
+
+	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
+			       "buddy_init failed\n");
+
+	/*
+	 *   [0,  1M)   dirty free
+	 *   [1M, 2M)   allocated
+	 *   [2M, 4M)   clear free, one order-1 block larger than @end below
+	 */
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
+							&low_dirty, GPU_BUDDY_RANGE_ALLOCATION));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, chunk, chunk,
+							&barrier, GPU_BUDDY_RANGE_ALLOCATION));
+	KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 2 * chunk, mm_size,
+							2 * chunk, 2 * chunk, &high,
+							GPU_BUDDY_RANGE_ALLOCATION));
+	gpu_buddy_free_list(&mm, &low_dirty, 0);
+	gpu_buddy_free_list(&mm, &high, GPU_BUDDY_CLEARED);
+
+	/* start > end: nothing lies in the range, so expect -ENOSPC */
+	KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 2 * chunk, chunk, chunk, chunk, &res,
+						     GPU_BUDDY_RANGE_ALLOCATION |
+						     GPU_BUDDY_CLEAR_ALLOCATION),
+			-ENOSPC);
+	KUNIT_EXPECT_TRUE(test, list_empty(&res));
+
+	gpu_buddy_free_list(&mm, &res, 0);
+	gpu_buddy_free_list(&mm, &barrier, 0);
+	gpu_buddy_fini(&mm);
+}
+
 static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
 {
 	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
@@ -1699,8 +1764,10 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
+	KUNIT_CASE(gpu_test_buddy_alloc_range_inverted),
 	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
 	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
+	KUNIT_CASE_SLOW(gpu_test_buddy_range_bias_performance),
 	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
 	KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
 	KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
-- 
2.43.0

