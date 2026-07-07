Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3EEC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D767210E430;
	Tue,  7 Jul 2026 05:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ivox7UOD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A2B10E430
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArnLq3viCuWUXgjbkvEffgbc9moIimAz+LA2dHVSbDX+h3L5JuPdTzuuht3P8HPCrwf8t0KKCiRzejze20qOjW+a2Sd2tVerZLOX060jt+vOIViN0X0TdsaQnorQPCgwhef/sWdk926nT1INdTC56q5nZhKA7hQYXW/rAFeZGo/CAnjZcZmq9Cl0VW0/zm6URDHLg8Gl7EO8UGeqKX1i0rrMya1ammz8Gk9HJI21venYzc+Dm6HSw8lf7mVCX+Y69cljeEWSlhyFOsIkMcxS1Gm9SsYxXW8g9Wq9Dqklcx2ja6d4j/v3OlQxJTrZnjOdQziMxDKa625BQA24L0cfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyPGWiniGyof7QSfxIcVt7/1+2cUMiLZ82F5ANgEKKg=;
 b=XE1ulSbXv2AlJcHLpW3GxsX5KQ2h36VYglfhglVjVJaeauisV8HbnxjZapuBJfvP8iny/UxHlMYJ9Bug83pG/zAtgHulTvOOaydBo3T1npqHqApGYnCrHDttGlvSffzgvlij1u/MOgLTyHvWJr1Di+304gLG+f/fRJpsSmbgrUif9SCjxUvElHTjrWQm5kqo+AiI7cVNcWwEvXJ/C/aHNTSxNlfj94nBMLFGoFTzBx3V6QC3STgq7NhQ+1yPUYxO4oU6bY9SXdG60r46JiXuDJJO2M35AizmlcpOFn8UrrpT7lx7PG6aoNUhABfKggOQqkOlFCCdpoHDjoxHw7tsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyPGWiniGyof7QSfxIcVt7/1+2cUMiLZ82F5ANgEKKg=;
 b=ivox7UODIEPjey932vlgUvAx1lndWbZiV4Y2IO5+VGxk4EgGBqRjmQ/TLSuY+Mnc2qF3Pa7+zPxmj4B4q9ny8Rs0Uwhg/XLG4DzBDlgWI0s7qsE0V5kCoC/LyVVtmSGu+aKoq2bfBUVrwAL+fz4RNox9wCfIW0g1PiEIAc9taws=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:57:09 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::90) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 05:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:57:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:57:08 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:57:08 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: fix open_ref leak and stale client pointer
 on dma map failure
Date: Mon, 6 Jul 2026 22:56:58 -0700
Message-ID: <20260707055658.479049-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ce481b-2b47-4242-de94-08dedbec954d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Swl64M+H8lzjjF4pR4Lb3OUko1CyNOVr1hPEqNF5iZrxrlIPKTBNxvvJGEqNLEztxkJfNQbS5eLvl3ymei884pX5rLeBQLRFc7qZtSG7Gy2eXmzdWGIYFJk+XeJcY2aDIA+RZesq6VPcp/+fuAtYNg6zCSijwN3H+piwl7t+PV1HyFPgUN9b/6pMLkvw3dXR4iknmy5U2Yz4Lg9T5TiEpA/AiyOn8VSHyHEz65vDcu9iYOn5NW4FfYKAoncpChDnpbsZmCjNvkF1o32V2XQ4HjBkzqPX7/CLn7r+jSNadB5UwxQP6MJo8rWlHoC6zvJu4/ouVP0nuZeHHycQBhWp4uGUBqzVmsuClumvNzVGHiw/ak0YXtY3ILTvh8Z8n8YYt3kYXPQE5R0d6XHmXADYtCbrbQVDcGmTnaOl6FeUsyHK6whLku/DhleOQS8vPejqo9ekBgpKDPI33rCurq8pSG3+l+saz5J9DbaeFFzdrAalGP4xs+znexSj5NaaXr9h8A5XyPf0SEXvfmTku3oy+jQvf7xH97h5WFLW/xH3gW5Uo26854nUA/OPB+ib+3xatAbr8KWmnVDZfUIH0hH23W31gLe7ehHC/0VspbSq2/P+0Tgj7ysO9YsBhHfzWPIjmFriZpwKhqI43Uh6Y2yU5pxOBZJkemcXICBZiM58AOHBA4pJ7au0yyVYeuBFKEgC2cwwVBQGIIr3fzfTKROMSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DeooxKPrdSGAJ3lx0Em+LZsE8NqQft5fYSzVJ2gejtFmtPW9V6R3oXqXJ6FP9qZLIp9Zyhu6bXp+Ox486FV9uSCgaqczr0oOb2pu+PxByIWu4gxPvBQ92Y7j14CjxqYCle8GAdw/l8hOAWwcZiqYbLRhRhCLvBTXcIE6m0DBtl/if4swubvlwalpvYUN+ZatkcDZBR6ljj3nE8PWyVLH69Ky63Zn0GA+GRmFlonWhkfxigP5dcuptaed6eABmxrXcso1pEL6lGBvEB2Zj+lVVxT83gzcb/puBEznTDwLof8LfL3Dg/UucXRGvBWXYikUyUCThjcvPKTmI/WJGSJpYOxRU75cst0Zc24w+LC61Uk3sVLSQDyH9GnRzSbPotWERgExsAHKmAaScJxU62FzXUjYKax7EirivqH/lNXXEwYHXCec+9lnulv6fnycqllc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:57:09.5523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ce481b-2b47-4242-de94-08dedbec954d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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

amdxdna_gem_obj_open() increments open_ref before attempting to set up
the DMA address mapping.  When amdxdna_dma_map_bo() fails, the function
returned immediately without rolling back either change made on the first
open (open_ref == 1 path).

Fix it by decrementing open_ref and clearing abo->client on the error path.

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index a4bd9e86bc8d..3f03d2db1603 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -663,8 +663,11 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	/* No need to set up dma addr mapping in PASID mode. */
 	if (!amdxdna_pasid_on(abo->client)) {
 		ret = amdxdna_dma_map_bo(xdna, abo);
-		if (ret)
+		if (ret) {
+			abo->open_ref--;
+			abo->client = NULL;
 			return ret;
+		}
 	}
 
 	amdxdna_gem_add_bo_usage(abo);
-- 
2.34.1

