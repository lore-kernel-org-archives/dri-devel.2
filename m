Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCA2C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222A610E437;
	Tue,  7 Jul 2026 05:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5n77HNA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8C910E437
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+DbE0vInewhvzlE3uOPfGP6Hqb2bqPGgv6rgi1qXWc20oGZrOVfHUW4haxtbZBBlMa5vf+jUrWu0ZyT41v61bVDGIaEdYzlowGlt7N1YlafS4gVxEfi+kI0mWXovNqgRmm7lActieh62xHIGVDtgBHW5MAhwh9tb95AD/DwdFgcbn1WG+fPF4LENv9b/Cw1GW/0fR4KGsiau/IPWUXGSKjWnqZxbyrfESwo8dFSHpFmy1qSvQZulrnYNvVx5RVbi5KijQXVockR28HP7Syj98+Mohu2TfI6Ofm1P+dKv2rOS9ubCUmt1vp9EqCQO851LPzaP4wgL6wOvWmkUpcvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uKYMEPmJaCmRlJBetDDmUqWrV3byY+uw43SbmCTYcc=;
 b=NQLqrEXuOifMO6hQHlepbV8m/znGS8hZXZjZmE1aquAVULGPobBlx1GI2LUSL0e/8dXRalVUBA+iDc068BMYo5HIh9GsKNNU/JSxhQYCN2Vzzapx3bj2icZnSelpgJhIXKCb2o/zX98rQfihM2FeKPsEudXF+4MbUbp6NKsUKSiAzaFGbYRN4dfcNLPDqAK/Nk4pcgT+6gCZLpkBxaMc5b9zSUQJRYAGg3LYrga2NFrbFNU7G0YOBHRpQPjm5csvZIoHAGifuCWNF2yxeKaFayz9hzd63S0eHKiSR23hfCU9xcfPQeR+iJlBQnnnvbDh7Ze7lSp2DDCONJX/T6iT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uKYMEPmJaCmRlJBetDDmUqWrV3byY+uw43SbmCTYcc=;
 b=U5n77HNAZsw0TS9RxOraRnneOn+rfzQhrGdk679m7XQ9w/qqlljUG3QFE8iA6I24MCP1pR/UZ26aSS62sy0pJrbrPWDgZ4x14GC1LipDQRNqE1FGbQrNxi7z9cTTTS2sVsY+xMNkLalRHF+sTmBwm1dYEe82GABISXiodNqtST0=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 05:57:35 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::17) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Tue, 7
 Jul 2026 05:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:57:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:57:34 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:57:34 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix deadlock on debug BO command timeout
Date: Mon, 6 Jul 2026 22:57:32 -0700
Message-ID: <20260707055732.479103-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5778c5-8323-4a56-5ca2-08dedbeca4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|5023799004|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 7SZLHBnRHraLoT3TSOEBhpkqRaPg6YbZNVfbrEFJ/DoTmQ4nMD4AhH9j53X6VANWDEII7Qra5Mm2LsoThmIPLQMJs60bzprbJTsTaqwArEBnIL2QbaXaQ5/uVMf8fM4F50+UC+Wfr4CNXFljFbEvMD0IVKHH1Xo5FW8dOC45UVFEdjOD0vMN57WVY2mzMCsTUDc4nNAzu95h31HtQHJ4iFucErmaRVl8lB08mhG1hqQQEySu+AzvG7JZjs768sDxG58+byfQI5rvI77s+h//U4v3yh+AVuDjaAQlrOvUxFGWUYDIK9ixh2Nm2Jq/VvD97/4RDRLEk4JAMLB8zxYs5QgC++drsD+DDdbmf+MWBJCAG0nteRHUzo8JV5WIvXHjkQyorR4aCKadIIBH1Nt4GIepOROUxQxpeneOmGnCvKxHktx2Oc+Z1ii68a2Uuqz5Jy5yk12++5cxPLcyBHEuoXScVhy0DOsFKZsfDpTLstFuo7gKbUekBgApDW1XjlII25UzPwDImyoe7sKbe9A0PtidvwfbG1o9FK3RCzOzHgHB53IswkiADxamZjoVtTCteNNuQ5LDSC7qzk8Gh0dOu1QSGnRg52Qxk4kT5FtTUucJimqyUwuQurDHDHBK264lRfGa2yfe86ZNd5mMpCWBzYI1HNVm6bHxrhl+5aPMKL8VIJCBnr+TyCJCvG7fYj3gJZBreXNx7RG1oyqcOw0xNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(5023799004)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wuPq0lCGPXTsHFGctkD41cUjCVubEhENE6Lvnp7Kab6Pn6zAQcz+E1iW/NnPCgMnZTWCNhOR92aGm1DC0ze9QoccAWaCY4G5SkI8mQUQeamxyNzR6pA+FcRaa3LNwYMYa2x6j6x6CCupR/Fpe75qDe9vXWaCHlol9JspI/J5EDEODmv4HC53SVsU7Vuei8DPLbK4n4nifgf8/RbLoJ5hTxM30okqgFFa88vWm3uaSsOGVm5iguBGNpqVC2Vu2ivj8hbqakZkY3cU6iWO2AaRj/r2Ow9qe2A7+VQA1/aOvR6EQFq0FWk5xHfOvcYizQPTaQmxSPCdrcax/U4NONwSzv4SRTKhfaFgF5h9jWII3gnWl+uOq7Y6awhoJQ2YpyO78e9OqnhDOXcEHeyN+ucOaSjATJ6qJj7x1RLjv8U4r3F2JalRJXCU7K1tCzJkXua2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:57:35.4809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5778c5-8323-4a56-5ca2-08dedbeca4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

Both amdxdna_hwctx_sync_debug_bo() and amdxdna_drm_config_hwctx_ioctl()
hold xdna->dev_lock while invoking backend operations. If the hardware
hangs, aie2_cmd_wait() blocks waiting for a firmware response. When the
DRM scheduler timeout expires, aie2_sched_job_timedout() is invoked to
reset the hardware. However, the timeout handler also attempts to acquire
dev_lock, resulting in a deadlock.

Avoid this by releasing dev_lock before waiting for the firmware
response and reacquiring it after the wait completes. This allows the
timeout handler to proceed with device recovery when a debug BO command
times out.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 5 ++++-
 drivers/accel/amdxdna/amdxdna_ctx.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 7bf635634e64..30ccb8d5e23d 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -900,13 +900,16 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
 static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
 {
 	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
 
 	if (!out_fence) {
-		XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
+		XDNA_ERR(xdna, "Failed to get fence");
 		return;
 	}
 
+	mutex_unlock(&xdna->dev_lock);
 	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
+	mutex_lock(&xdna->dev_lock);
 	dma_fence_put(out_fence);
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 67a2abcf173e..9ae19393e488 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -310,6 +310,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_erase(&client->hwctx_xa, args->handle);
 	if (!hwctx) {
@@ -328,6 +329,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
 	XDNA_DBG(xdna, "PID %d destroyed HW context %d", client->pid, args->handle);
 out:
 	mutex_unlock(&xdna->dev_lock);
+	mutex_unlock(&xdna->client_lock);
 	drm_dev_exit(idx);
 	return ret;
 }
@@ -388,6 +390,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 		goto free_buf;
 	}
 
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, args->handle);
 	if (!hwctx) {
@@ -400,6 +403,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 
 unlock:
 	mutex_unlock(&xdna->dev_lock);
+	mutex_unlock(&xdna->client_lock);
 	amdxdna_pm_suspend_put(xdna);
 free_buf:
 	kfree(buf);
@@ -428,6 +432,7 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 	}
 
 	abo = to_xdna_obj(gobj);
+	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
 	if (!hwctx) {
@@ -439,6 +444,7 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 
 unlock:
 	mutex_unlock(&xdna->dev_lock);
+	mutex_unlock(&xdna->client_lock);
 	amdxdna_pm_suspend_put(xdna);
 put_obj:
 	drm_gem_object_put(gobj);
-- 
2.34.1

