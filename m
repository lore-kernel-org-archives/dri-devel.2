Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6113DCCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC8D10E00D;
	Thu, 15 Oct 2026 18:33:05 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D5910E00D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3U7XY5dPE5TEmU2/o+7IzR6lVf4FXC5lhaM+cGNYXKNO/xd41VZOGx3JxGfAPji18rzpR5z5+ho6dstd2S3nmAyAJJuhaaDn4dlcP9ZGf+2ZuwCfoXxzv7sQfDLBpzHpHJihIhfQg9dRcHpCCdM81K6ntlFNVNbMNjafCtUnknXvoAGWt5s3x9V/Hgvg/9WYtv3No94oNhUlgcO6ak61ONmvybKsVyuBpQ9Os3PtfBmMzFhaT6OrgP+W5aV9nsxJPD4sVcqjIUwcrd//EmjgqG7OtgEEOe7Zq/3Y4WuBjagKdDQTvLJObG8dfSdmJT6rcswnZ3kTbFXcU6UlzXqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6qFKRwAhjotP5aqfFkVOoQXELPr6zAty9pOVeLCbzU=;
 b=J1gpZd28w7BTYFdGnd8RqJX4J4TKWX+gZkkJsNEjgFaWZZwEJoaLeXXbN0A+RnGy3agSYawwzZKOLqtuYCi4aQ3qBRq1rsyvrIvT4akBDQaVdXoUQk3zL77hdFDCCaTdVhSXVhPQTXoX1n2hVW+dweLFg2SMZthgDGovEtDxH9EXqrLf+HJE5qpn1o7FrJsC8PU8PL73Y21YQqogCgJhKyxmz3e8eseM19Gj63jNSR3s9kJdJ7g/imUwzcdB1/VoqeEjowoWgyUslwXuQKxGyQ1f1A7FAmqgkn+TEoa73ufW4T43of/6ByQhZpoY8EPp6QCDC/srtIdxsVErW2qySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6qFKRwAhjotP5aqfFkVOoQXELPr6zAty9pOVeLCbzU=;
 b=KklCDjub3DCUEl/UhoWY7BAX4JRm/oHCRai3fUYxLsqo2dF5i0Q4atZvchbqWjt0oAg3CwjHP82aSGE5GNWASgcATrj6Bw6X98+KsLDGanjptV2bKixxSK9G1Byl8fKZTEp4uQmzdM4R51Kzl6bYJhAbVWreOSx4eFTwWPQl7zg=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 18:32:50 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::9f) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 18:32:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 18:32:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 13:32:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 13:32:43 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 13:32:42 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Matthew Brost <matthew.brost@intel.com>, Copilot
 <223556219+Copilot@users.noreply.github.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: wait uninterruptibly for jobs in the HMM
 invalidate callback
Date: Thu, 15 Oct 2026 11:32:48 -0700
Message-ID: <20261015183248.3414119-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e93882-dee3-4cd9-dd15-08df2aeab798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8cc/hEBYps7/h3sxOYmj8y8cuCJ6Dfgts6fhHPe6O5tS99Kbs0AqKI1RxT9r3vMBAP/gDEPDboQGjpumdg9ntVJACRxJNuBiQfp+Y/RvwU1KFNZiWgzp15FARcQjlakR26p5/WItUx/tjyDeH1+WnJ2pD20NZs97jon1roxhht9bueDsjZW8CdrRKlTg5eSlISYpi4aJi7PLZa1Q7h5QELHTPWdJQtgRPtZASElSGM0iY8+4lBm3iAUV1bY09pbnbQZRTab4uWswageh0TkiR+nY6Sf8EjkVXzK0UwKT8o0WnWwArMsoloIYtLW229t0BFHhqGlXjZ1S3liuKfuzrzkOnXKdmaakdhiZMEx1Yywsf9RF1Cyxc6AEAeHIcpq2cI96Q3vXV2hpyjzIOiibYmZIsYK9VlXJ2sG1y8Jcp6z2siedltwjB3bDMSdzEouPGp3qtEx7Lqg8Njpask86kJP7aNYY+DMz4qZkA+aBbMZrnWvdQVXpLR4iFj2nCEVF6v0p1G2kOOKoNLXPSuBQ0FZluE0JvkusYbL1+x8WUkH8zi1zhKJiydhBIAuJ+9T568qB5YvCacoF4SrD35hyJjHRGQrJWa8SebzlqxV1iquXyfVcGJLG50AM3gY8R1rXrgvFtVf7EezJsMw6xcyGRQLePMlyjdpcqPAv6KFmB9PK7jyi0t5LP+0HrgdlEdU/uMvDv3D66loT/IRgWI7/nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4p58lJqgcJXu9/XmG+ZJHHCEXOJJFOWy6fnNjxkwjmhlEwH7/VkmkgCBUC5XlGAfaoWB7t0Zs3JjLmnuxWcXYYSGbb5jMHZOQOaRcWDlB0VZovuFyImmq2Tu7HUlMD2s1p3GPZtzMvwtnqeGwrDpHW0e58UlkFxAOCqI9JF4UuvEYWSI1r4PW46J83K8uwxpL4RCZKIk1KWO6L+6E7u9xtwVTSy0eLC0UVdNDtd4+5RZWOwAU9MKwGsSEZbrUSMMbBWy0MTAZbrFpeEP/EYBvcLl5ecdY2IPI7JyTBV5j3MIT/ZBrzh+6DeOyWoIkIAb0N3wiifr8QwCKldtcHVqs2M9NG+/EF8D7kM4t3czWZtuD3Xywlk0DTafSma4gMV2JslimmbXp3+RJFXNjwlZiXhU9Adbb7Wxwju13urd47CKQwJsR2VvsYnzoa9OUC0T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:32:50.0080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e93882-dee3-4cd9-dd15-08df2aeab798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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

From: Matthew Brost <matthew.brost@intel.com>

aie2_hmm_invalidate() waits for the jobs using a BO before the CPU pages
behind it are released, but does so interruptibly. When the task
triggering the invalidation has a signal pending the wait returns
-ERESTARTSYS immediately, the notifier completes and the pages can be
freed or migrated while the device is still accessing them through the
PASID.

An MMU notifier cannot fail a blockable invalidation, so wait
uninterruptibly. With MAX_SCHEDULE_TIMEOUT an uninterruptible wait
cannot time out either, so drop the now dead error handling.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 9c6b7353cbe9..84ab8a55b7ab 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1286,16 +1286,12 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
 			 unsigned long cur_seq)
 {
-	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
-	struct drm_gem_object *gobj = to_gobj(abo);
-	long ret;
-
-	ret = dma_resv_wait_timeout(gobj->resv, DMA_RESV_USAGE_BOOKKEEP,
-				    true, MAX_SCHEDULE_TIMEOUT);
-	if (!ret)
-		XDNA_ERR(xdna, "Failed to wait for bo, ret %ld", ret);
-	else if (ret == -ERESTARTSYS)
-		XDNA_DBG(xdna, "Wait for bo interrupted by signal");
+	/*
+	 * The pages must not be released while the device may still access
+	 * them, so this wait must be neither interruptible nor time limited.
+	 */
+	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
+			      false, MAX_SCHEDULE_TIMEOUT);
 }
 
 int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
-- 
2.34.1

