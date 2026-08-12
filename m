Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10B7C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1F510E366;
	Wed, 12 Aug 2026 20:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SFBh3XaB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE4110E3CA
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 20:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZVzY0qhewydpvId4tUKsGIrLkk5hQkmRKEWstuHCBqALRQVqY63PWzyrvVjpCGzL7orWWaO7EwcLxfaMbXcnWmRpzqjqHnEzLl7VeZDEg4eqrfEd2XlL9JOaQscjVW67lhTVK/ApDNxJB3EXJ2KaSGsVwSe8WibdemDBPduSZIVCoKak76+F+wJq9hWBIi4FRnFKMTeBNMH33j0I/nFFpVo9RmTaVi+d6yapAP+W8RJEYQj2ipSCksHFv1EvRcaNE+kx+krZkK3/hLNe7YWi2p7NQewXvs1CXrVNqVd2gGP3DTGaA9s8ANiN8KTCYYeXCZ2a6pq6UGyauOwhPi90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5KL8vJDlwAXoOQ/ort2iZMVaaVR8kg0co/E5SfSXV4=;
 b=LDMctkI2aRm0lpmjSJ+Z58a9puI3wouEo3vjYtX4Gynr1Jj01Ihx25Fw5tqXHcHJy8ySTY7iNpmDKAtqq3BsehNR8GwBxGGpUnUvGD0epKafXpZ5crLUzXBP7stwY/WhaSy27YPakixRTd5O51zek+E6k0nUEuSWqmFA62rObnFb1cv2gpVuDbwwmOWzZc1fJ2d2z6zdFcS1cdBlTDHD87mSYlYak1GI7BzfSStjgFfG8bLifjxhHanbzNNL/DD1FQ2zyVlCbxDytdaF+3WdtQPXQvAnE+r8MkJwRzYfjMRTu/AtuXikLrINDjpfVFJ674fOvaSh4H9Z3QMQzkZC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5KL8vJDlwAXoOQ/ort2iZMVaaVR8kg0co/E5SfSXV4=;
 b=SFBh3XaB7nGolyQj8VuIxEXZMtRyBls2HRAY4y/l3424AQde1z/mMmphPoHYO7+MQZd9tGSNaK1BDroOmTFrfr07HwbM3vGi3w7vSJFbwbUNf/wc7luuLJ0zmF4XazHYehWa4dBd+F1JFC8L2vZR9NNY+CVjBocfzH0eq5vVZmg=
Received: from PH8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:510:2d1::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 20:56:38 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::40) by PH8PR22CA0001.outlook.office365.com
 (2603:10b6:510:2d1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:56:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:56:37 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 15:56:36 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Skip unmapped range in aie2_populate_range()
Date: Wed, 12 Aug 2026 13:56:28 -0700
Message-ID: <20260812205628.810816-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 37180e4c-b4c2-4c5d-6fdf-08def8b4338d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|18002099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8uzan4uHRpyGIsi8UAR41bP+RNJkDt0Gx0ajc3INd4b9Y2g5zdh4mvf6Li6yMs5jkBMeaTu0TfYpTIF0g4c6jeUULV8AGDgBok2p+N1T3/y3FgpBS/YQJ8ds1HNbUgLMuumRhxKBSP1r9iQ/NlesvmO3n+jBcVQGZ5I5lYgprD2yD7YIIolkUM85pbn9Xv/AdltoxgQNcL/2LqEgtXBvMxUi2SrSV/9USe1nB2EtwgiI94aVeyQDW/wPcsFnM2cpTlnorFjH2g60JMO0LB/sFZ+t6gpO1NN6Z/mvFXVTDnvxt4LtEqqGzpotqKLafaC45wWbPc9xqbCriZxojmywaubyNWJXHCTR5n2HaH+pSsN6NzPi6JOJo8cp22xHs5574pdv81I6+7bxgYuLrZUJ7GscW/wVZ38EFug8AN6878OMpLlH3NyCmhRHHDLJZGSFh44ikGpyFau2VsJSHKuSnoX/Mwkj8sA7Zv/WVEObORoVR3f2puSFLiI+kmCUcRk13FleY+uk1IFouz7xdLpRAUauOS0I/1BOwoh1sHupAH9xcRz4wXvBW2Sn/E3PpdKvh5zg80ZufIsp92g3MwlxGpiLPenyLSA/o3d4GfTguVdpuZ2mOTqJfZvPudN1m4k7JttQKjXPHQ8meoL5/d9Pg6Q85VKgNbn2hwBMei0Fmvxu068Ei/L5UaVt74jKZYj8ShuTTlCkIh4gam3US96tiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(18002099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K3eozy4w59ViF7S2uyRqYXidbCfBD3Pct9xycO96ABE+GLFTgGbqAWN5zgfhRoD7IS+ALiqappHw51GijyxX8QJMZPBD/qfyR6sXxUP478DyqeqQG9AWPM0gWA0qEbNwfYabv/C/Jei0wyB0gHewoz14aWwLIT9t1Er2w/01qS1fBV9uYHoVNiGyzBlXY+1NenN34B69WV7jDSCycYSARObKVkcRlRBaTafUoQCLA5N6X9CX5pueEW2s28MYzFLJt8vHI0V0iuYPrC1TRzKd9BFZaYAbs3AMbbiwvTofg2RKxUcQw8FVBOpI2rSl1c2TlKR9gSCZadyQDsm5uAKqMjvO+5QfV8omKlNdLeA9aU3RCAwTdwXwxDGUKCHax94iBajdktkbd15v+6L1iJcxhjyVd+aRa8PruFyZ4hEx/8rSg+1rvSlFWGh344alw9SZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:56:37.5256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37180e4c-b4c2-4c5d-6fdf-08def8b4338d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

aie2_populate_range() incorrectly failed jobs for BOs with multiple
mmaps: if the unmapped entry appeared first in umap_list, the loop would
pick it up, call hmm_range_fault() on a gone VMA, and return -EFAULT
without ever trying the remaining valid mapps.

Fix it by skipping unmapped entries. After the loop, if the map list is
empty or all maps are valid, map_invalid can be cleared normally.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 4b3a62aa8798..8d9c283f606a 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1052,6 +1052,16 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	found = false;
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
+		/*
+		 * Skip entries that have already been unmapped.
+		 *
+		 * If userspace unmaps the address and later submits I/O using
+		 * it, the IOMMU will reject the access and report a fault.
+		 * Ignore such entries here.
+		 */
+		if (mapp->unmapped)
+			continue;
+
 		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
 			found = true;
 			break;
@@ -1059,6 +1069,12 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	}
 
 	if (!found) {
+		/*
+		 * This also covers the case where all mappings have been
+		 * removed. There are no invalid mappings left to process.
+		 * Any subsequent I/O using the unmapped address will be
+		 * rejected by the IOMMU.
+		 */
 		abo->mem.map_invalid = false;
 		up_write(&xdna->notifier_lock);
 		return 0;
-- 
2.34.1

