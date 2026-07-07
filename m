Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52228C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5CF10E431;
	Tue,  7 Jul 2026 05:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zyx7o43S";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9798010E431
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfIp0gF2rGRgvxYSjQrHAX7VsS+rVT2FvV9G21ZyoppKo3e6CA8EHcZOs3ZfKt6i4zP5Ks0Sb4vj0Zfae4hDpBi3BmcTFTki4579NhbD8Hb5k4v5HPSlfxkMFfuSQtjewR5fh4xIxqkQGGSvJQZ5Z+yDowBasRUjxb+srBnQhaREXEWzpZ20j4hPvGQpMElFa+y6aQV667PqRXVUW3Wq229G3mlL9yQ6Iq6F8oxuhZkaylP23sfDbvkpeljnq9c6ZRcUHtcT2TgrHNAzCcyaw8lVRyNraHrEoC4iEzB5kHQPeUmUJmUd4BRxBZ3GMWaPXQ6G4hrnShuYTcKvoPtG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtFGz8+myM3HYJWkq/cvqmjCKkmhlbCZHzm5v9aEtbA=;
 b=eJzduiM75kW9OBwkFmN94ITANsnBD2wI2n8JrAIEOSUyC0F1UXRIqyo8jh84MC5RidYOrGVCpjwkLzqpmQoDDPGRhnMYQW4hRgVY0W/wDAadPzs/pujRSxTC04P5H94r9X//Im9Fc3vI2+Ab2lO8NirZ11JRldCKDhdGeSPHl3cSiIMrVbRNDtdv7q/iVH3Q1e3mexChPGY0OQ4DLo2fm0oPXYVFP75X+qvfaNG9XFeX9PTRmIMztGDecR4ysc+fX7ZDOyEoqL58nIA/skTM8B21Rxa1vE6B+qJDdhmJcs5FVOfahYcuFpYD8WUMqJj1jGpu1b8N87+kTe0lT5zJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtFGz8+myM3HYJWkq/cvqmjCKkmhlbCZHzm5v9aEtbA=;
 b=Zyx7o43SCS34cQJn07TMOz72xtZ6KIzYHriaGBp05hzIFPU5u1ECPLkZNmcEgmoqaRg8r6o6vhBIfF9tCziNhZETJoSV1mskZEvA6LnrvB/HZzH6WPYIIMHkoKjjYT4Nvul0b1cs0uVMrbzjNCFpb0YFx727b/nnmkP6wJEJIcw=
Received: from CH0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:610:e7::7)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:58:21 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::4b) by CH0PR03CA0212.outlook.office365.com
 (2603:10b6:610:e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue, 7
 Jul 2026 05:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:58:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:58:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:58:20 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:58:20 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix hardware context race in
 amdxdna_update_heap()
Date: Mon, 6 Jul 2026 22:58:18 -0700
Message-ID: <20260707055818.479165-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 098704aa-2448-4673-e5b1-08dedbecc012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: oM4Cqf9KZG+ccKfMKzMaHVaUNPTqarf9+8DDSBZiPrcMQo+yZQQuyOEBkc3dvR/HNgl1081+hByxQm6C5ZdU4AZ5eRTCGua6R95JpHDMO63UM2ZRveHl059edrx0UwvrGaMU3T22s8P85OLIhZMQ4IfF/26H0Gvr4m6jNbVgOw/rIclT531U1LZQFYC2fShz96GmRLkwwVytfWDDJ1y8E2f11z/ObMCKQ3tWUjQjvoH4h8INySHqDCavwqz71UQj5RodQ/qOn35Pjoqva7Nx7Gi6jN2sS+FJl8zPSM5sRLWW5kY37lxNyCss3cEaZyhru1VvwY4fXwyn75G5XFlaGyQhtLX6vq+hnQUt37z+YQPcztSCwQR8jnaW5n+0RkBRoZ/EWoOopMSUv27VoMvzkUQVKtUAvpSlamct3t+n4Js73TW0YErgQ6Bgw6+BoXKdvgpxYTwlrjPKpkYlsMRMNm1WUxrocJTX/NtiLuhD/0ILBw0+kmToZEFbyrbFg/92jSofDP0nIcVLrU+VL2BvwScoE77TZCoUo+1niGO/AJTg3f0YAIfkWPyfZv6/WC2sBZMVaNwD5mNDgTCE20nDQDB6UbJVz/ijlfCdr+WHMb9sZRXvp87D34UjNhww906lH1EKzNhn3pHfUeGi28teJ5pFYeqHEh/ig6BsEVXCwHjuu2CUoIKUybyIyyn/lexoLvrIcRnsl352/ylZu+dQNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JnvGYsO/wQOaDS83xjqYM4pvTg+sGJfgUQ7Xwzd2ewjAhO8fAJDmYXI6StvQI3lKwzRs7aCBKk0PqJGxZWAW6q/OtXLokTYtqboYU6zq99gMWyRWV3YFfLa50V32QkrijEH9dZYGLUC/JZ7AbdWYouV3E9G7AtGEmrmXJ89dLWLK6bvOM32aZq5H45LxOU/9c991iC6YvughXsyWydl6xlTUsaHlziSl3O/uLpQLZngtG+TTn/nU+U9RJsZsWgV6MdwzdiOsvVZoL5V3RpBIBERj1govu9Gihedx/jYhv0g2pmeoqIyA4v9rwLoiHNO8iZZONeSoaWukUDOZSGlywwMf1yul6YNOWOPPzdXF/cskU/Rt8UFsqsesPAqXprGfR+2WGbTSpCjW4gunaR6SAaqtRNa1TK2ZRcQKMY++mKIFK4eL/voO22bIQTdg7Toi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:58:21.3866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098704aa-2448-4673-e5b1-08dedbecc012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708
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

amdxdna_update_heap() iterates over hardware contexts while holding
xdna->dev_lock. During the iteration, amdxdna_pm_resume_get_locked() may
temporarily release and reacquire the lock, allowing hardware contexts to
be modified concurrently.

Fix the race by calling amdxdna_pm_resume_get_locked() before
iterating over hardware contexts.

Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap support")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    |  6 ------
 drivers/accel/amdxdna/amdxdna_ctx.c | 24 +++++++++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 30ccb8d5e23d..101f324ee178 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1222,10 +1222,6 @@ int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
 	u64 addr;
 	int ret;
 
-	ret = amdxdna_pm_resume_get_locked(xdna);
-	if (ret)
-		return ret;
-
 	addr = amdxdna_obj_dma_addr(heap);
 	ret = aie2_add_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
 				addr, heap->mem.size);
@@ -1234,7 +1230,5 @@ int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
 			 hwctx->name, heap->mem.size, ret);
 	}
 
-	amdxdna_pm_suspend_put(xdna);
-
 	return ret;
 }
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 9ae19393e488..8f8df9d04ec5 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -472,9 +472,7 @@ static int amdxdna_hwctx_expand_heap(struct amdxdna_hwctx *hwctx)
 			break;
 		}
 
-		mutex_unlock(&client->mm_lock);
 		ret = xdna->dev_info->ops->hwctx_heap_expand(hwctx, heap);
-		mutex_lock(&client->mm_lock);
 		if (ret) {
 			amdxdna_gem_unpin(heap);
 			drm_gem_object_put(to_gobj(heap));
@@ -493,18 +491,26 @@ int amdxdna_update_heap(struct amdxdna_client *client, struct amdxdna_hwctx *hwc
 	unsigned long hwctx_id;
 	int ret;
 
-	guard(mutex)(&client->mm_lock);
+	ret = amdxdna_pm_resume_get_locked(client->xdna);
+	if (ret)
+		return ret;
 
-	if (hwctx)
-		return amdxdna_hwctx_expand_heap(hwctx);
+	mutex_lock(&client->mm_lock);
 
-	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+	if (hwctx) {
 		ret = amdxdna_hwctx_expand_heap(hwctx);
-		if (ret)
-			return ret;
+	} else {
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
+			ret = amdxdna_hwctx_expand_heap(hwctx);
+			if (ret)
+				break;
+		}
 	}
+	mutex_unlock(&client->mm_lock);
 
-	return 0;
+	amdxdna_pm_suspend_put(client->xdna);
+
+	return ret;
 }
 
 static void
-- 
2.34.1

