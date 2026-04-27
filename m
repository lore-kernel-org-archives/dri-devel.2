Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A8AFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE1410E811;
	Mon, 27 Apr 2026 16:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2uK6k4K";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA8610E811
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuJ5JpzuQ8b+TOHwE71PrhqGAoHHYvd3FmOvNc3JzfWmoaieaIALzdpPXhsPQPd/p46qwmcauBt+VfWVBczp8gGFG54PV0Hwb84uyXpKDWCVsdyHXzT1VrdU6JwEMIN1oZeEvDa39iUcNZnqLwnrNRs1NX3ZkcpSTtHaJlwWc8TzBQArfIzei54HE1GdeVid8ZBWPuUV7VR7YiHhND7pSZECDABbQJIUC5ykfr98zYuCQgUawv+S9lHeFF0FEOQeeXd2t+Ksv8dw/F/7zogz/PI4Bv7tU+um45qe+6LPcrRE97LAnnXbmV5u1NTqdJvM+yhBYSUEsfBm4RD8ahU6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZEYBo+Gn7OdPR71L1iAtyGAAKze3B5rl/serWeGF+c=;
 b=t9unYIxsSEz4pLoc1XnT4dv2AIHrf1Gspqntsydyu+ZW6tsjrYEVG/xKC/0rwZQgXG1fgq9tJVAMYqcseo+SChU68xz4vFoeYPUL6qSMd+R32s+mWGXvHBCtlBJDCIHrNuyObXS38FQf4LySIBe7epX2KJe2DRh85mFTkiKQVzFCybZUdXVvvl3XLBsNWF/RvanSwVjyhBBOxBcgRetNs81kqimBYxCGj+YffSEuj0754JzpuOMQZU3QO9ynE2JVpR//5JnC6rCjs65KPEgDr6pH4eMG/Yg6w0DL07WRWw7blW1mtRKELdH9wnBlUr7zUCYg2BnYty71QcebFzqnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZEYBo+Gn7OdPR71L1iAtyGAAKze3B5rl/serWeGF+c=;
 b=i2uK6k4KYoCtcD1K2EYIbipEZci2zUtJeM/QNkhF7WngaWmKqsRUEX3HrscNdF0CvikmTvOcUg1304IYaCaivcEb7VntpLO1sUIpywCsv/LWi+RKk/dtu8ywXuunAZAdaThi8eTCYwDAmtoVzFWh46f8rlJCjEB55+RkAxQWvaw=
Received: from BLAPR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:335::7)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 16:23:16 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::78) by BLAPR05CA0027.outlook.office365.com
 (2603:10b6:208:335::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 16:23:15 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 11:23:02 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] ttm/pool: Use sentinels in debugfs
Date: Mon, 27 Apr 2026 11:22:53 -0500
Message-ID: <20260427162253.682415-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a6bfe6-5441-4b6e-7e07-08dea4794907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8CZ6u4l28RyMvQ1z/evZ9Pc3v1dHGCCKfHqm3BjVi6YCI3FK+K5B/bzFlVKglZcPL8C9NCitxHhAsMC8EP3Ib7tJYspDtE4SM2l/fKBHgZ1tC2KOKMJ0FgW6mkRNO6pv35pwCouXgrXgzb/dFnVF+YU0Uij0VcCT+Bu8B1Lbq+b3wKHSbWUkTFcRqBjVjJsHDRw8sKbZRTUi6G9XZDKbw5Ndee412+sLOXxghPYri+if9hc9Sy32A1RPZXiOA2Szbzq9Qcfe65McqlZeh4MtAFoWTm3gqq2mUUOi7DGTZstx1F1oItSc6D/Lj18yw9zNtG/kxfOJCVL4IS/EN40yrsTDtFYWuuFX4xCQw66yERQX3h3YhaxnWhBQWw7nAxIk4UqpQGDTsLFrgtZNTzimHBAWD6S2Ww909snhIR9klJHfYXrJYkwopZzStE0gQLuL6Xfb8EXflueMHgGOaViOqayXteQt3srs0cXkpSS3sc69TLp52ebbLrBA43VQV5gSxh2p57SIp8SyEmZvnCzwp+4cS1/Us3o0+4GI9j97IuHSKLyRuL/apDkem8ARj5/d2V2Hf6r864HWEi3LJoZwvcw1BDWWwCbYf42pphVAEzVWBRXLbnVZEA3npyg4eXl3FOGyy5WYgYFp5hKcFbGq+99Ca06zupEXP5Tp+9Dx1DGvTih40rjxUGSiT2w1ToCAX+4BhTiCFM1F+xWTUZOEdhrbG6hEwlZ2x5Vy/JxO7Js=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o7RDAK7g7mJR1CShyxijTjHRN//wbXAd2z9FHweF5XhiL56YwJcLvBly2CvndoxkB2zyo6GS0JOCB89Sv+0NW6DQR/gwzN7kkXVoCd1rNySEz3lnQhopq2jcMkEGam77ukMSRhIePf10RLDUPIlMEOaNVIsGBXLixsr6i2eZh6PQp0wV3Umu1c5B/OvpsJr2h5xoMkoTWnl0cHQ237Qu/bUiX9PsMIRgfcIUAwbPS7qZVBx85oMMbsSzsNvO3YU15dZ08XPHZS+tVIRLw8FXCKt1fXXmMOk7+lw71KuwG88Th6pUBoYYd+qK5U3mb24HGf46VzJM343bTIxBTC38+sXEAhxMVezJwFXgvB+z6xBZXcGIi5g/cgX3jjQUl77MS6cdHLfCh93Fwfx/D238Dl91amsvxQs5/en9xnT+KUDxcV2MgYB49Z5rS+tImZw6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:23:15.6012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6bfe6-5441-4b6e-7e07-08dea4794907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
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

The values in the `page_pool_shrink` debugfs file should recognize
the sentinels rather than causing an underflow.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5218
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 26a3689e5fd90..4e83f4978b136 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1335,15 +1335,22 @@ static int ttm_pool_debugfs_shrink_show(struct seq_file *m, void *data)
 		.gfp_mask = GFP_NOFS,
 		.nr_to_scan = TTM_SHRINKER_BATCH,
 	};
-	unsigned long count;
+	unsigned long count, scanned;
 	int nid;
 
 	fs_reclaim_acquire(GFP_KERNEL);
 	for_each_node(nid) {
 		sc.nid = nid;
 		count = ttm_pool_shrinker_count(mm_shrinker, &sc);
-		seq_printf(m, "%d: %lu/%lu\n", nid, count,
-			   ttm_pool_shrinker_scan(mm_shrinker, &sc));
+		scanned = ttm_pool_shrinker_scan(mm_shrinker, &sc);
+
+		/* Convert shrinker API sentinel values to 0 for debugfs output */
+		if (count == SHRINK_EMPTY)
+			count = 0;
+		if (scanned == SHRINK_STOP)
+			scanned = 0;
+
+		seq_printf(m, "%d: %lu/%lu\n", nid, count, scanned);
 	}
 	fs_reclaim_release(GFP_KERNEL);
 
-- 
2.43.0

