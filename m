Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD1ECA6004
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B2410F217;
	Tue,  6 Oct 2026 07:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NB30EIbL";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA9510F218;
 Tue,  6 Oct 2026 07:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/g4Ynv0vDvnytGDyuNYeD4oVh5507szz+ip348s6yRvdf6x+szrg9urTC4QyVeXOlFwhPmpelLV22bUEvOgy7C1Zu/PpeRUOsKq2OCNxb7OpTB9igjqFqEvJ6//AYI54NFVjj7FEjHnM4t7QWPIuaYrWimrWzqI+Hkin5Ehe7Q3IicxguGJvDEIgXdzjMM9MX6KJReNi+MpwsCGdrChw2nZYAYjBWSYoTj4E6tQCIdSKjI/3azHixxhj+f2GOFFltImIyBmAKw7T0wWbe4e+s4S6V3x01FNN8WC0m7HqBetrxhdyDcXCRmwXrZM4L3TIbsXXX6+Qj//OlO5JB3u5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srn4AtNkIw9Xwt2K75tXJbvxSXazhcLUUZ07ugAFuls=;
 b=FBRWP3zMEBCUOqS1/QJFSmz8WE/LghLt2NupfPEhMJkbbyydwwGV1w89gp36s2zQRs1RSyET5OXXMFiJybHAm+cSwFGBL9wD7yHIJq9rL8FJ+y5jmj2dIQAnIk0/TONU1GFexPxVS+EsX4xnA6RNFeRnH6tdE7CU2h74oSS5h1Zy9WafGmNg4l0a6zIIebknjNjczstujq3IFdmF+K/rvvr19Uu3dBf1bfj2AUnK6GI4+/MP12sMVoTNtDuD/I7nmMAk4N99HU4xD6yuap+TqfA7ljXLQ3WBJILUimsIh/eRr9bx4gP5HtYKmMobrsVZvlaJi2EU+4QApECMxUnTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srn4AtNkIw9Xwt2K75tXJbvxSXazhcLUUZ07ugAFuls=;
 b=NB30EIbLcxc2u2OSea3Gc4ermrNzP9M3sY1j/vSpsd9GnQ2pFCIkIya/TJ2AHoNh11Uphp1bncsCCe36UCnxtHHMgTsbHbgMadbDXoXnP/09AD2cZZRYgxJGxNjEVvVAgOYTNidViGkE/s5vDkfFxArWASdr4/hGNsXFmt19tyg=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 07:27:08 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::43) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:27:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:27:07 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:26:58 -0500
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
To: <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <Anand.Raghavendra@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 2/2] gpu/buddy: search lower orders in contiguous
 try-harder fallback
Date: Tue, 6 Oct 2026 12:56:43 +0530
Message-ID: <20261006072643.211568-2-arunpravin.paneerselvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006072643.211568-1-arunpravin.paneerselvam@amd.com>
References: <20261006072643.211568-1-arunpravin.paneerselvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f2c795-7be5-4d5e-9bc4-08df237b3a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yT5DwK0eeCH9d3u8zCEAJlaNFdJsNqxlStfyQrp8HTrRZfPCWKFsVlof2US5hTrPI3b5I4+e/Bof+Ctd4L41JCDoc9obJqxUvHNgsAxwe1TWXRTsgzNZQ8Xvpx4cM/QZcEAAc231f4cwjyvIrYLiokFCKRzhqqF0ErN/3RTno2V48qHXPjRxtuWOUCCKMkzkqhqmdXHY/O2pSzR/FAXseErVn97TbgcWCx37BKsnSwHwnEqAZDNJ2hLNZ/TnQEWpdqdw4DExac5gD9vFke3WngZiF9N9P+R+wM+wRosCfpTxMtTT1ltBj3GnqpX3Oaa9uNd+jLOO8zc/RSv2ZX9OvU2k54ZFHNJ/j9B17HWwU7s8D6GdCnDs9hYhfsUPkmGTasZSaNhpBnr1LR0+zZFPI3U+VczDMWZ9cPhNr1US+gChFhotBpJAppogWVLCPyCeS2V26fieeFt+iUXZj60x1xB+g3mIILvIFCRfmwGpqaIOwFp530FAAaAP6XkM8iAbsSVzFbYQYW50cO74aeT1kgKoCcU547x7rtd0g5mU1acAaeeEHuxIYjT5DA3AqeRS0Qz5SnujyaFzJbL+N3WuBLGwe75iYE60tlRkaFzJrbvJl78Vulcod2ZM3EqCwgMUyBr1SGJei3K4phV47bYQMItZDIVJTmImiqZFEQbLAgAYBvfSB4WYi1vn6Kw+YximhyhAvvz4816QmxO37jM0nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GA6fZ+mQYl99idgzBUUEURUu/bjBLU9nkpDbk5tsIX9tjgI39l4hE3IhofLh5E3uEHloHguDXPmv23TLKy5W0ZcwT1VVsRWI+YJJWjY6NQUAFsP3TkKOJfZDrjN9nnQLirG2tvqM60PwJCNiIvFPaJjnwCdCUmkYV7YoX+t8FbkiNaimt2MjmcN/izLlYwcn9ODY5yZrbCPsLf/OX/subLhJFaoAk5jDgXpJSUUtiDYoFyi+7ECloayrhXwkH0bMgDOGtVppkO5YOWFGSepsZShBtqrJvrHHW2M+/cJgHzHbpHBXApGszBMmYlMTqUvmXy9LZv1ER3QkfHZmdH8nuuoT3y68MLSAJOBl4sdkyJ2NFYUFlq+3WeqNqpV6zIauKD9IvG2ANiIlXBmONnJA2oL1ymLGqUw0EhL3q0RENlqXb/CZGtT/wORx5jl9NGBK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:27:07.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f2c795-7be5-4d5e-9bc4-08df237b3a6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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
index d8e7b7990715..239249362c9e 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1694,22 +1694,23 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
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
@@ -1775,6 +1776,12 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
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
index 2c445870b808..2e8f69a9a283 100644
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
@@ -1678,6 +1742,7 @@ static struct kunit_case gpu_buddy_tests[] = {
 	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
 	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
+	KUNIT_CASE(gpu_test_buddy_alloc_contiguous_descent),
 	KUNIT_CASE(gpu_test_buddy_alloc_clear),
 	KUNIT_CASE(gpu_test_buddy_alloc_range),
 	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
-- 
2.43.0

