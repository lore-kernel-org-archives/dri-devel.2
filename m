Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47F2C44538
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351FB10EC4A;
	Wed, 22 Jul 2026 06:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NrT8VqbB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D0E10EC48;
 Wed, 22 Jul 2026 06:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9aJ8FPmN49Lx9ZRtklKhrGataNxI7n4yV36j9cI6+qisJn/GMIj578tN2Ph+oog48sHqHw2zVLvLhRP3qPPgrceYr4EUDNysv3dWDWXUT3v0tNQRQTPzPvKV52JZD7artgNqIUfOGq/9YHzIASbPLm3IRMYRsWqmGwSfB0T+FytvifPFcNZHNnsP2xbWp23dCO16CQLw+L5iGMkCiLNUQHjzLywtxctTHeF1YZpiW5ELWCcAGoZjX0kQFYwXmy7t5ktHHFyhB4OR9+boCXLqQBXfmioIgaPR06Ei1XcievMePigmfD3J+GD6oI+rBC/DP1CGzJwDRHV4Ssojf3HkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuKUm54TNy0wNNgGfi3EBFGoe/C61x1AtpWCgTdscO4=;
 b=YEC45obPUCJumeH657Slf2tvEYgaKQ4nHJRpxDsIw/Ip9X6x6/LZRVJxQXtQC+1bu0iugAmrsm6QKzeDhIZVK02OEd/m4yxziw+p+nkC8DQTOPqL7s6WyU/TXavMOoiibATu3YVp696dg7zEWgxAISARQtYet+OCsTC4Wr/KU/sCcX4DQGHRAXzhhwwabXYkgHziOuMrsO7V3lg3Lv2bmIfGn/GVmoRzn71hWCiegWHXIyOMK4AYwTE0qyGtBY/aSjS2ikp8YmT3XN5pD52Yr/ua2DEKKp17QMrYBGjD1hhmrQ7N51IeA6TFeUMqPNtNZgbV+pHQU+KNV4RAl3uKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuKUm54TNy0wNNgGfi3EBFGoe/C61x1AtpWCgTdscO4=;
 b=NrT8VqbB4mKF7ibMA4yD8iBtkMOr1heGyAoykhNhKEK5yhL1/C2brRCzEbtVTFcs0XkSc2K7D/g5aWamE1vU/8OZApc350Qpgpd+yT11Ayad6jZsCRltbPgzHAmLLSLGmptcUe0KhoMwDyCdiOTQzK7yH6hK8/B/Pfff5CBecxQ=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 06:17:37 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::55) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 06:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 06:17:36 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 01:17:33 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/tests/gpu_buddy: fix interleaving in buffer clearance test
Date: Wed, 22 Jul 2026 11:47:18 +0530
Message-ID: <20260722061718.629966-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 24324da7-f056-476c-3588-08dee7b8ece3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|13003099007|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: jzKk3p4s4rkmLh8UPa9g986YK3LMGLMGBu5/O3W0/Ki1y8PJ2fYL2E88KWg7a4uhemZYquAudWkT0MGWoH9lG1S040gsVTGWV3KcIUEMrpHuw0TrZEFxm1QItTf0BY/qor53if82KiGJVBWhCIGf+4d8YbYItMjOw5ZD59mDYE5CgnQcNWZHL6GblXWkuf/WyUnWI4uw96rpy7+p91d9yOE1yg7gKjum24KI6jYDQp7OJjgjuOjo/yChSO5lR2LB4bQ0Ayc8Bbz0+2p7+O145GtsOu/C5xzNXM1Tff9cWo4wMwf6gTE1P92oPizEWr/ohJrxoWA3EYCqcqnkC3/8pG3PFsB8sIGDV7lj5A1ATnp2IDwdkWdlScyl3ziVPwhU6Ov2OYAr9BrYPnpjgOXWmu4vUNRmxvbqR5jQlhtaWVJFHjMvErmLqT0zGITC/ARkct9fLFgjeioCp8tReDR8fs46KSAIXOK5GgikVYEHdvuhFAw/+1KaVGNWpuAFl4TD2s/5BXhSkaWVA+QwGZWdbIxpP7eimEatcPV/Pau08BYUaf1uHmRzS9L7uLwa3uSVRcNcGDAdiPBfjA1bNSLDZ3d7PzqF4WOisGdCcvtUJc9QThR+HbCWcOKASfn1B5LHYWcI0uQawG9h6DSSMbyJdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8wC3Y+UcVsQcT8CbELjxEmMtUuhU+VqaKrmcAaT5iXeXFdu3x0ej7IQ8Yws6/jVRy2Zlosw2PR+maS4+LjetUS6BqYCEelr6+TOak0xyw+EOY9aarVUPYmYhupomWxbVIxBV297FuvSXsLwB8iR1ak6xFkvxb6XPWTz+yJO8ogeMpGgkgp/cqKSPF296y1kger5HU56RP/wjQN4a7gFOzAuiPjdquMZLkVV7G9H/mcFekW8nAarui6L/OH6RdMTvA1f3k85ec5mRXv0vQDD8fTciGkJrQ5gG62mH5mBuJWoRf8lHq5nSfC4I3G5aG7pGo4BeqzN+C23YPTeynIXJt5uXNqL3Rm898bfPXw+oSiqhDgmXaZ91FkM3REE1HD4+PZ2iW8SqtBfDuKnA6i8T0FxiCAaz8s597Pl3sdKUDmd5Kq3IVkeW+5K/a312jhD4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:17:36.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24324da7-f056-476c-3588-08dee7b8ece3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

Fixes: e3335ccbf4da ("drm/tests/gpu_buddy: add a new test case for buffer clearance during resume")
Closes: https://sashiko.dev/#/patchset/20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com?part=1
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/tests/gpu_buddy_test.c | 47 ++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index 89698563c61b..b793aa441424 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1004,10 +1004,13 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
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
@@ -1015,31 +1018,39 @@ static void gpu_test_buddy_alloc_clear(struct kunit *test)
 	i = 0;
 	n_pages = mm_size / ps;
 	do {
-		if (i % 2 == 0)
-			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
-									    ps, ps, &allocated, 0),
-					"buddy_alloc hit an error size=%lu\n", ps);
+		struct list_head *list = (i % 2) ? &clean : &dirty;
+
+		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+								    ps, ps, list, 0),
+				"buddy_alloc hit an error size=%lu\n", ps);
 	} while (++i < n_pages);
 
-	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
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
+	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
+
 	i = 0;
 	do {
-		if (i % 2 != 0)
-			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
-									    ps, ps, &allocated, 0),
-					"buddy_alloc hit an error size=%lu\n", ps);
+		struct list_head *list = (i % 2) ? &clean : &dirty;
+
+		KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+								    ps, ps, list, 0),
+				"buddy_alloc hit an error size=%lu\n", ps);
 	} while (++i < n_pages);
 
-	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &clean, GPU_BUDDY_CLEARED);
+	gpu_buddy_free_list(&mm, &dirty, 0);
 	gpu_buddy_reset_clear(&mm, true);
 	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
 	gpu_buddy_fini(&mm);
-- 
2.34.1

