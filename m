Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3218C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E0410E4EA;
	Mon,  3 Aug 2026 06:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RisObE0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE75C10E4C0;
 Mon,  3 Aug 2026 06:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTlhDOmSZ9kV+ulf/vuN+KmcxN0xGB8nDpNzpt6vsl7pt34TLwF5HuALbJIWTeF/iZiy25Vd8EhyhGVvjtRvtz5bF17wPJio6/qJOp5o7+uU+lO9mi04xliZ7+SuiD/ECrnGjM3zreiSGqMofynqH2vW2kYIIdlNvfKALTSxY0nbuPxEG4eD9Yu88icXhEAcjhP3hEgSE20RMhH3qRNoXTDlOMXKfK6J2lfllgcFSIlblYJ+voe1o1dL+FBgM45dRrIDlnQ0iXawxygrDvygnOcA4e9scVI2K57YF5LF3+LtQxmAIcjiH6fx7sftioSYr5f/IHFFMFMLKNdtPn9ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q38+ZJL61zUr6+Ls4KCPppt/ia3nvjGi/MWvKCeAMEI=;
 b=hbkCPOexpvVvxNPJYk848KnmxhbAO2fURV1ykbCTpdi+RTa3ucrGcAxnixJ2OUZT4ikNMo1B3aU/lvGCJi+fveWgIruDvfN0b+G4RuJviN7p+XVCV3iUhlG2ZYrJC2teSSOezqkA0T7KLt132XlE6Qb56EKDnBkyPTRLVruGEVNLMBO9jh+88QH0dlrwrRNjxZk00kaOr7SoWmfv20jgbXz+M/kgts1UhOCI88kiuWuFcqUt7IrTNpVIXi+tInVrA59EC6MtSkzFZuXEKrcwxeGhsZWB7STPyCa1KSQw+l5YawKSdJ/WpMvt1RJptga60lQRFB8VjVyKU+onq6RU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q38+ZJL61zUr6+Ls4KCPppt/ia3nvjGi/MWvKCeAMEI=;
 b=3RisObE0y2mVekpje64nimSCv3hL/Bl/LsxSfD5bAl5Lt2ExDE4xFI+ErYj9U0F8iAxFCoVS1UunFvgh2qxE89mH8C2UMPglICB8iDvsSTV+JaTNUOlBMg6GewDM6p2MzdVdizQ+1swUu032WS6z1jDHIUnpHCYKJaXnoqdw1cc=
Received: from CH2PR10CA0011.namprd10.prod.outlook.com (2603:10b6:610:4c::21)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:57:27 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::39) by CH2PR10CA0011.outlook.office365.com
 (2603:10b6:610:4c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 06:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 06:57:26 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 01:57:23 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <jani.nikula@linux.intel.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/tests/gpu_buddy: fix interleaving in buffer clearance
 test
Date: Mon, 3 Aug 2026 12:26:56 +0530
Message-ID: <20260803065656.2960810-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 456652bb-7c77-4098-4d41-08def12c7a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: CmgzC9eeJvP0b2wqE8KmrETj1/d4K1YBJtHJfQTH+l9s7KcDHDhoYVXHdR1+AZctupWQAqkroRfhmvoiWrJWS3+0u/b75ECT4TsBvu32QtUn9zjPN3WsmZTqyqD+pisT5lhb2VTgPFm1Kv1bpcVol8x6Qbow/R79AW3ly2Y+b0jO9joMk/hqa5XQD/HmxkAfuyKI6/P92d7Hs0CvVlqqCPmaYM/kLfl1aYjstH5LELfOzH+reEqAfESruWYkh/b1T9+jk/EOO4LzbQoUmqOdI+CT8UiGGpiQnwSvwgzRyB00umHeoqWX35zVpK3t5snmOqHuziitd5MAf/y1H/zftglh1QmE5U4l5UBX70E6GzdbN97pU+kjPi6ZsC2PlJ3XKNUNCcymIJTDWQUVqHNxmHdZvyfRY8aWM1kTjZe2IKxrBgah9vNb1J6tavffqimoGqvzHHPJloQU4XQg2jHePNwXGaOkI72rdX3qkLxBT7UY4875/m8YIzaF1tqiUb7sllBiO/hZy08nFe1E9wQL0H+XCx7oBUCqMf6IaSlpSzuG8eiZYeFnzh8GO19qVe5/vYONWqAdiKkmp5YJZnx+ZwPS8irmkxHTVWP8uOGfA1C4Xj+mn7PaT5/emeBleLa+FSp/m5lXDY7n0yNbdlNOzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: heuOhyG89gWWz/C+r8q4FBOxmwZ6ASXcsy3m/+krogZniTbqwN4py2eVAZhWq9qWLrlm4HKTy1gDsehyBu6aQqcvIo/NBctT8o+yfJyNM24v+EmlCPWKeid8AXnOAOVze3tvIRDe5Sogzgs8xtW1yQDbR++QcKI+zda48uA4JptTcFVvBZ4SPgXEiKWgZwTQkdpMxxMVEaUK0wXYj8CR3v98KiuFZHJqUSJkQ+EcweBIlXbq2kLqQAC34Vwu7M70NDsFDtU9RwARFrdr38P6rlf3o8Np+ihXCyZ4HyqCFUhou7AqbMdlGWCEmtOABo/ukXRShLJ+b0IEtsVeHfQNx0YrR9+zw+46MzzgjOKTMHj6iU/mPXaeLZuXWcp8ySlSbtY/5brcKG9P+8UBp7tCwAbxe4AvbMQm2koEDtFYcSJW+ayoeXsPO353PHqyJAnm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:57:26.9185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456652bb-7c77-4098-4d41-08def12c7a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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

The resume clearance test skipped every other allocation, expecting an
interleaved clear/dirty layout. But the buddy allocator hands out blocks
contiguously, so this just allocated half the pages in one chunk and never
exercised gpu_buddy_reset_clear()'s force-merge of opposite-state buddies.
Allocate all pages into two lists instead and free one cleared, one dirty,
to build a truly interleaved pattern.

v2: Use for loops instead of do-while for the allocation loops (Jani Nikula)

Fixes: e3335ccbf4da ("drm/tests/gpu_buddy: add a new test case for buffer clearance during resume")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com?part=1
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 57 +++++++++++++++++-------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 89698563c61b..e258bf1fa0fb 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1004,42 +1004,51 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	gpu_buddy_fini(&mm);
 
 	/*
-	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
-	 * even sequence and free them as cleared. All blocks should be marked as
-	 * dirty and the split blocks should be merged back to their original
-	 * size when the blocks clear reset function is called.
+	 * Using a non-power-of-two mm size, allocate all 4KiB blocks and split
+	 * them across two alternating lists, then free one list as cleared and
+	 * the other as dirty. This interleaves cleared and dirty blocks so that
+	 * neighbouring buddies cannot be merged, fragmenting the address space.
+	 * After gpu_buddy_reset_clear(false) every block should be marked dirty
+	 * and the split blocks should be merged back to their original size, so
+	 * clear_avail must drop to 0.
 	 */
 	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
 	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 
-	i = 0;
 	n_pages = mm_size / ps;
-	do {
-		if (i % 2 == 0)
-			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
-									    ps, ps, &allocated, 0),
-					"buddy_alloc hit an error size=%lu\n", ps);
-	} while (++i < n_pages);
+	for (i = 0; i < n_pages; i++) {
+		struct list_head *list = (i % 2) ? &clean : &dirty;
 
-	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
+		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+								    ps, ps, list, 0),
+				"buddy_alloc hit an error size=%lu\n", ps);
+	}
+
+	gpu_buddy_free_list(&mm, &clean, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty, 0);
 	gpu_buddy_reset_clear(&mm, false);
 	KUNIT_EXPECT_EQ(test, mm.clear_avail, 0);
+	gpu_buddy_fini(&mm);
 
 	/*
-	 * Using a non-power-of-two mm size, allocate alternating blocks of 4KiB in an
-	 * odd sequence and free them as cleared. All blocks should be marked as
-	 * cleared and the split blocks should be merged back to their original
-	 * size when the blocks clear reset function is called.
+	 * Repeat the same fragmented setup, but this time call
+	 * gpu_buddy_reset_clear(true). Every block should be marked cleared and
+	 * the split blocks should be merged back to their original size, so the
+	 * whole address space (clear_avail) must equal mm_size.
 	 */
-	i = 0;
-	do {
-		if (i % 2 != 0)
-			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
-									    ps, ps, &allocated, 0),
-					"buddy_alloc hit an error size=%lu\n", ps);
-	} while (++i < n_pages);
+	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
 
-	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
+	for (i = 0; i < n_pages; i++) {
+		struct list_head *list = (i % 2) ? &clean : &dirty;
+
+		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+								    ps, ps, list, 0),
+				"buddy_alloc hit an error size=%lu\n", ps);
+	}
+
+	gpu_buddy_free_list(&mm, &clean, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty, 0);
 	gpu_buddy_reset_clear(&mm, true);
 	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
 	gpu_buddy_fini(&mm);

base-commit: bc47d5937f21c5fc94504f03e18f1adb56d97634
-- 
2.34.1

