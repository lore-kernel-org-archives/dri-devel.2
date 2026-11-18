Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B3606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZFPH0wkt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECD010FFFC;
	Wed, 18 Nov 2026 20:18:33 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E076A112017;
 Wed, 18 Nov 2026 20:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHrhapG3tEz6bqgaEF64n81MPvfUndeGAR94oxGeU5fjBYyp7aYew+5xa+3zUIP5t9eQoNzti1+HdbtWRw72u3bYMzKc6idQhrYISwQv2FbXWFveGcqPWnJWWk3DO+aZieMGLJx7ebXSBzMp1zDWDta3pv9dVKDXLw6ayKJLqpllotyN9RluUXYL61jd7SnJXiyxbboGJu9XxBFlTfe9llDmX0CxNdy8L2hNKyO3A7ELNWiknAzfmeDzIpdwe6FE46T2zYCd9CpqEKt2SUolIQ7nxV4g3Cn9m++Propwp8g3ymXRkYvVppP2+pQIjzwU7FdtfW1jG7b44x1cpxeycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GjZz7RMv6jAMV1iUvSRQa+mfDWDGZyhkh147lyQTVo=;
 b=nBq0mx0mBou8TG3IXSIdiyFpiYeajrDMkcC+Z3ZSyWWQ3fEC/X6AAZhdycSrteGB3WPPGKGr+VEWuTCkYE/167rtekUf70Gmf2kXl4hqaRBe2zgUm3axVy34eIOVRPmZQasfmZUOrTQAV3qefPabJjv0uY5jkiDrxPise5mRE3QBC+uG3SZ9xWQZWLO/9OsuRcNnOhsVLgRdwBvOO0tIqbJ+vyc3KHTj+oWJyVxNP9WaVckSsCx3gKsALZx8N5twGHf5rg6T9ev9km6kVqupOwr+FF/e/cyQ3HBU3TDOrp6eiuEoR6+NExnvQ8sN3Y9K4FH/Po8Gi6iLPM/FG1tfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GjZz7RMv6jAMV1iUvSRQa+mfDWDGZyhkh147lyQTVo=;
 b=ZFPH0wktaG9lss0Tv7GmLr25d4TWUbE0r330ouDLIFoz2MIU02TElK448n7KJwSxZaegL+Ra8id310LBN76lJLb50BuQz5wj8aEmrThXcn38baQP/y2VXbMIRRMDPstvEuQ90avcjBi49U0BzifvqvBoYAcps8MM7iRKQ1eGxtk=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:17:21 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::30) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 20:17:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 20:17:18 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 14:17:18 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v4 3/3] gpu/tests/buddy: add range-biased allocation tests
Date: Wed, 18 Nov 2026 15:17:01 -0500
Message-ID: <d13ac667cfd4b3d5c8557b0cdbec33f11877453b.1795032989.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795032989.git.William.Palacek@amd.com>
References: <cover.1795032989.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ce7a38-4214-4387-897d-08df45b0f234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261028144727099003|261102123227099003|261026140227099003|261026121527099003|5023799004|261022105027099003|261021121427099003|261021123027099003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Kn+9P977IrJ88Hz7qULwByZODnIvvPfY9A9fDW82C2KqmzKDcW8ZyOSonBS8lg0xZHz/Uh0ffWQMCUfw3xsQDI1o1NK0ljSF4M6LJTqhkdtf+UbuQCqnTpbjgPc3D8WxTU/gdh6l1umEXIAPhc8DgTPKXOB6ipCiYBDFBkk+R6yeChViliA2G+hSz+FVVXzTwT6xt8loN5KKTEnAL7aqTvknT274jsWe/bKmAI/FVZ3jV1aGoSAGkGWTzd3D3qzLdJpdJZxxy79jyN8zdSJL4BcAeKkJcRPKLnmn4teBNz8TS2dU+Bhn1LJhjcdAj8E+VCmgb/u1VV3FlLDNlPsYWho+2BKRJsf6b+cQAGKshbNIPQPcr1QIyndvaYNGk4VN/nrkHqyO0wzQmLkSspSxUc6mdpKmWnp0DHG2Up0GVfR2a3hDggooNk2g7AyoXhATiu93cYk3DRD8zafmVrGnXN4harYiOjG6SVSwpucvhGq/1gDwCDJlZD0iewIFpAETRe6zHjIFVOXgPOyzhhVsDsxsTtO+IpQiOe5EsJtz0NziC1OSjX+QPI/ZC8C6ZxPQEH7uvWm5ORnG8BTh+PnFMi489dulIE4x0EP7kT6a31hKr/1eCsRAWBiKP5IATxnW38SCwetvOnXRS+tDK+FlqAEFHjfjLMzW76XesY8j7zkSypVbS6oIFX+6XjvLP4I4tZXCBdPP7M7TzwMcKszeoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(5023799004)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y3h+4bUG2HSFweoACa8njZuNsh/zoBXLY0aYhqVLzU7JqXWbBdDSfHNl/m3ZkV3d2wbKIwkc7Afk9WJnBpe6w4xpG3lJecMhAr+AL+zOjHSqei5ro4r1of5+ZfGD5kietps2CjLvtm0ShLV5LXHiHpIQVUsiznKMM9y5s4LfMkFUetnDPIHrTx7+wIZ4VDFaG7wByjaE1ol+V7nNWPUfkxCAs6JSKxIr7KBUEvTG4g5QBMmh4c7wJS++6u2OcxfZfMh4fAQAR7oE8jx8dm7SQq247q1vR0STOCouKXqqzAiUnZ7rBRRY6tZVk5XE6mdWr4NqK1hA+c4/+Tyl6xnvJdrgDO+W7FUW4XCRKI9+zVFJJWw5IaeSzzA1siAM9T2WXQfT4ZV7tmotI5Iqx4UkFR2MUIxRydtYQUFLflvFd1IavnCfAQs7NgghuPFSsbxT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:17:18.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ce7a38-4214-4387-897d-08df45b0f234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

