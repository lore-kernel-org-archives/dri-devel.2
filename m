Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81077C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 08:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B89410E0D0;
	Sat, 18 Jul 2026 08:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xp+UdVTA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3424810E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 08:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0HFC40xp5eMYbCAybSUMfL3js+vV7AcuIUJq15AbRX89I1zutZ5vbU8OrDmsfQXplZ1jJM4z9zhzf4swTc+saO1s0puE7ftWgZno99kPszAFUsYZMug9SzWEej/aTnqk8xzSvRXAeosaBnV/MxD9+WLRanmol+s1B3FAP5JuigEshNek3w3V+c4b3+B34RA7F1f8ofvP0nPMAQgt1QtNV8auO83QywjUbP4e/BrHXzglrZt0qJ2533UYoRkK0HHP3xR1TxZ/R5yKGQR3wLtqn1IstBPBW8IsOpVX73mklBDqgsWF73qo3IBSg4mOOaN6o8hf1mQQJr9b+srPpg3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PhWs2P6pJr/77H1sxasyiqgZi0EP35tNo95JsQM9ak=;
 b=CqExH+5HeRvT7CIiMiKGzoU7lSTxbppK48IBCDjqn5RdHfBZqqbAx5wV65nsxOh6MCSIotr4D6MgHugwHnGyyj4IsCG8hMCQaQFDkxfzXEQK60gmHeb7Zq1coqo458NXhnGTjkHUT8Oq8TQqugiKbaEwe98oe5gzZEN6BEZ0gLht0LSmugWCMbSINi98RmzH/kqpiLTsVPgl1XjxS8I5BAUOYJIoIM2XyL2ETZR5qSz/0lm7w0a/D+cO5FaRnGjHoBb1HpR5MDLAZoRDeU2PgcDcgEzN6e8twFVvM9maXite794cnzVQvse+uzYweC9cr9fqAu6TU9qhOUKbhHIFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PhWs2P6pJr/77H1sxasyiqgZi0EP35tNo95JsQM9ak=;
 b=Xp+UdVTArMFUNLDvxDJRd1YcZ9SsmjZsF8vm7eizJdI1v07sC/U6vnxt1b1EzMWz3Sh7bQJ/ulWB8zHY0ILieIegVNCy+VA1+ZtMmV7443pVhnI5VrGdbhn6PH6nmZp7vWcFDUg98PkfgyMDWY9/97zv+ssYKaWRTi99r0RHKCE=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Sat, 18 Jul
 2026 08:34:17 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::90) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.14 via Frontend Transport; Sat,
 18 Jul 2026 08:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sat, 18 Jul 2026 08:34:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 18 Jul
 2026 03:34:16 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 18 Jul 2026 03:34:16 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Wendy Liang <wendy.liang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix command timeout race
Date: Sat, 18 Jul 2026 01:34:09 -0700
Message-ID: <20260718083409.1825940-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: eb88578a-1e54-4ab7-bc24-08dee4a75b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: jwSFPN3Rn2ouy3psEb8VRN1x1Z+LTETKoijP/XKuoQsVZPtfcwQImitwyMl10DRXwAFqMM31nOzagQpCWTqwkvBxrSCpoe0EdJ65Ec/NPHyVzhJbPCJ8NctqEmvRfpZjJaYxOh/IgysdvFrz5Eyh5nPVM4e+q2Fxjpfod8kt+xI+QO3HCZL+806njV0a77YbV51xEplvRf4X6YlAeX/8sHHEzSMU+yzl4apbbSR7OXtFEQNPs7RB2czK2i0UePQcAU853rGbO3DREvvoR+f1h9J32nF8wFttm3SD9Ii4lyHCm6X5SnncK5LinCgbl+z1aUAVLDfSFd59BKC5zAPMS9XKCPhqY5EG98+nEpz5W1/xnkk6QbAknMsj3zPLvPbg2uz/Qsnhxl1ceLNeXuX3Y4sTgr2CU2HyyjCKdkS0elxlZQqSR+cWfUEuhjLPe7PMHoFkUgQN0vDrV0lEJcm6oNdeaeuVshxV0SOdT72CJaMhsRRoUrgH0m8+OBmgAvpzX6VPER5pu+01y1At99hT0aZbgG0ZefH5D+uwU1fXEsTPrqhXpZsBbeyf3ewLOHdIQejCJfT06jfvbf+sErVJVv89NnVm/hRPvEDw1ba57tN6eS4pasQzj+h3md3kDcrJ9NY/ZZu6UFry6CAReoiWJgy2fXy3SkhEx3e8+RrpoHEETYWiWNCXLM+1eW52NEM7IIgXEVcPuF6ZkaAX/1f08w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G7tB3TEZ275i9Ll1pvIZx3gxcTpn/AIUWSmyvV6bo38GwTomcAiUXzwA4Mi6fIxhWzAd+APABZtsO+htwGemwTlaoP5a7h2JVfceHO2cOH1uFzw6yEp3FbUo//ejowMRYIogONe2FY6mqMEluvjs5uGY8Dj3edGauMpn3ui6l1QeAYRkdcatwhK61CeA7sVIUOJcy1RR1fHwg81aZjX4/BRTdHtjzcnRWujTqPmZcl9bGZP3fMfWYlc4crgiRj/weiiP7jz+qZ+JIxgZQFfAIgVZUXjcEQl1XufLqsb5X2Ig5K2lX2TKW/rNAuW5IPYXsAdpKPsI9e3nBe+TUi9MFWVbJBj/P43RiQiWTSweLZ7fkM8jmn6nbE9QmdVsc7jxr9fRxsoQWQENtuoKzI6Lw3gINtghHRnt7odIFsDJCI7FTnCEdRdPCv5X/qrdCS3v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 08:34:17.0244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb88578a-1e54-4ab7-bc24-08dee4a75b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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

From: Wendy Liang <wendy.liang@amd.com>

When two commands enter aie2_sched_job_timedout() concurrently, both
check the timeout detection state. The first scheduler thread observes
tdr_status as SIGNALED and updates it to WAIT. The second thread then
observes the updated state instead of the original SIGNALED state, which
may cause the command timeout to be handled incorrectly.

Replace tdr_status with last_signal_ts, which records the timestamp of
the last driver signal. Timeout detection now only reads
last_signal_ts and never modifies it, allowing multiple serialized
detect() calls under dev_lock to evaluate the same signal timestamp
independently. If there is not any new job scheduled or completed
within tdr_timeout_ms, the command will timeout.

Fixes: 9022f010977f ("accel/amdxdna: Check for device hang on job timeout")
Signed-off-by: Wendy Liang <wendy.liang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 22 +++++++++++++++-------
 drivers/accel/amdxdna/aie2_pci.c |  1 +
 drivers/accel/amdxdna/aie2_pci.h |  7 +------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 101f324ee178..94dfee7263bd 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -43,20 +43,22 @@ struct aie2_ctx_health {
 
 static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
 {
-	WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
+	WRITE_ONCE(xdna->dev_handle->last_signal_ts, jiffies);
 }
 
 static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
 {
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	unsigned long last = READ_ONCE(ndev->last_signal_ts);
 
-	if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
-		XDNA_ERR(xdna, "TDR timeout detected");
-		return true;
-	}
+	if (!tdr_timeout_ms)
+		return false;
+
+	if (!time_after(jiffies, last + msecs_to_jiffies(tdr_timeout_ms)))
+		return false;
 
-	WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
-	return false;
+	XDNA_ERR(xdna, "TDR timeout detected");
+	return true;
 }
 
 static void aie2_cmd_release(struct kref *ref)
@@ -434,6 +436,12 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 		mmput(job->mm);
 		fence = ERR_PTR(ret);
 	} else {
+		/*
+		 * Command is successfully posted to hardware, update the
+		 * tdr timestamp. The total pending commands are limited.
+		 * So there will not be a case that driver keeps posting
+		 * commands without getting any hardware respond.
+		 */
 		aie2_tdr_signal(hwctx->client->xdna);
 	}
 	trace_xdna_job(sched_job, hwctx->name, "sent to device",
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 22f66c7f534d..daec1f6b4907 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -420,6 +420,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		goto stop_fw;
 	}
 
+	WRITE_ONCE(ndev->last_signal_ts, jiffies);
 	ndev->dev_status = AIE2_DEV_START;
 
 	return 0;
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 77648cc548b6..ea1dac106400 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -143,11 +143,6 @@ struct aie2_exec_msg_ops {
 	u32 (*get_chain_msg_op)(u32 cmd_op);
 };
 
-enum aie2_tdr_status {
-	AIE2_TDR_WAIT,
-	AIE2_TDR_SIGNALED,
-};
-
 struct amdxdna_dev_hdl {
 	struct aie_device		aie;
 	const struct amdxdna_dev_priv	*priv;
@@ -179,7 +174,7 @@ struct amdxdna_dev_hdl {
 	u32				hwctx_num;
 
 	struct amdxdna_async_error	last_async_err;
-	enum aie2_tdr_status		tdr_status;
+	unsigned long			last_signal_ts;
 };
 
 struct aie2_hw_ops {
-- 
2.34.1

