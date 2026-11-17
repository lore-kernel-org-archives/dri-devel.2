Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853C606A88E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1YnCqm9D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DFD10E092;
	Tue, 17 Nov 2026 19:22:36 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9AA010F89D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUcEHB/FR/MkrIZ0RyHpvTUpTEdW52tKE75Uj4sADEQc/Zr+WFa5SewIyujhK1DgtbTzRCxxEGMWdSpb7NUf79GAeCWFIk1GiHaiepL3KlOruaII5JmslmAvr4mOkOUAyI1ABAaQjt84pVmyx5HXaKk02lpYHAReA8CLP9LGbPQ2TLf6IhwVraPI+b4JLvZcoJtWFXxvsEtpcTSrj8x9jL5mDmnv1RNvYtgCji+d7EOYq8vSZ6X1C4XLslbPtUMgsSnQp/uA4GvPTlDo6SlzQu4K+PdLtxOozDHWMFZLz1HmFoFIJHhZih1/a4UyGOpW64+jqz3i9JMW2ZVE/S+tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoAM/xXTlPmIRxbSvvKKF+dsS0OxFzgkCaPWclY5MNw=;
 b=sxD9w7hD7XBn7XATdJ9alD8Spe9cBB65DyTU7996Cv5re5XPsm/T8dHgLZhevqRrzZ9RYcfqEiNVdyydiDfzRAPqf25HS70bZScUUD+fB8nLemV7rq8XVpFLJ/E0kUr8E8vZY132o1KM8NNaCJrXVC9kBVFt75jJ3xT6e7iRKHBITk2WsaanTFTS8BKE36Od1Use4bzc85AmF965h9TbJtRW9DLgnXcdVm/tRzFwV4KmDSGw1BQmk+TMiCqG8/NV1zvtmr0bLVV0nmrFbVPn02WRsvN2fXU8YB5HBXSzDiJj0OAK+G+IqedagBqIH5O8S5SMVWCTC7muZiYBfNcfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoAM/xXTlPmIRxbSvvKKF+dsS0OxFzgkCaPWclY5MNw=;
 b=1YnCqm9Dg99SFvEO4m+UKI0udXyrrniXixPcYoAq1hBK1Xl3kEgVMeR9CbzWCxwH/1su0T4rjNjqgWRtwiVpghNKFfn3czsTZBg7MmS76RZAFrktk9I34qBDUyifLAEFjQaBScksusPl0ecLT1mJQ3Z22YmI1DRdKVedWIjvO5o=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:18 +0000
Received: from BN7PEPF00000095.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::4) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:22:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000095.mail.protection.outlook.com (10.167.245.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 19:22:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:22:10 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:22:10 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1 1/2] accel/amdxdna: Check the fence error after waiting for
 a driver command
Date: Tue, 17 Nov 2026 11:21:56 -0800
Message-ID: <20261117192157.154516-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000095:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: a44348d5-3bf4-4aef-0eca-08df44e01414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: JikjYR2Ox/qAM75+A/NGs+rCPYTucGGqJga5zK+IT+pHME9C+fYTf4DYd5Sb6T2lYQ4izDfOAPOZGT6NbxwQDDa4jmX320mZuRdjvwuJoYpdMghdtwtVw+11IbQBh5yJ+dd83MdkFeMViH0ICJk3nDE7i85FIXTiM0I+b6x52ZJWvT6lAfwhWqcDuxSBcXWcGSXUW1RkzquEUloUmjjLHwr5oTncuHEgVose4Hv85iqbMrp+iTnFpXDIsBcLw3JICTk9f5l8Ic5dFcYyzEBoez0NrdqSh7ajWoVwNP87n5U6EhUGSjfRNFa72SVunDULlY+4uUYJbjvPk1jUmr63X0nudwKvQsiVd6Hh1oi112gk9KbLfybV9VWSIuiEX4c8MV3//9W1UwB+Hn/eon9ewNLd2EmqjTtNRAeIrYsV6S+mPQ3Fo0e6gFNUCWG/Wm7ENe4P2r4n2wc3ix4kfu9rP35fXbAInQPuLWTyGp4WrCDowV8azTmcMaiHnpaTVP/aNyyjsTREL8oelbyEsU2uAZOdwE8sd3q98F/zf7EdZ0HvNyBhK7S3Tifnld4HNP0CpYfyWZuxxbcbXE7ORILSQjEap0CDPWLa8RB/sJ9WVhx7S2GRWBtvtk+GkpSFzh1BNqHVHvAu3lNlyerGwWNhSBYWCY5DA4ilLjujxnYafvLd9u7ZgSq4ZS+0OezDr15TUZhjwpvyBhCA1PuZionWJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pRXDk1zb/9eJ1Vc5H5J4EebHIHVcAUfbJeu2VfwnhJq1Ps6Cmjt6wltDejpyDaOBjdDbppFV3WBOvghBcaQ2NEHe/iB/S5pwMqyncOEocoCr5GMqMNZIQKg6BqqpP71dz/0ZWZ+I9JM3u8PGBLWALoG7Dpr6iGTfc6zYs8yDbLd+ca5zyJwkxeBs9s7TFWeiZuj6QIE0cn1QxuwLAJ59d5+pbQSmE8pD6sU7090VaQ+a2UtfWge+i9MGT5rRNa4Z/eHIodzQpV9hR/QoMpIA84niRuIwtcG0S4oHC9Ls66eNTnMlNBDCAGkNXl6l46bgY38nCSDjM4sPC94LpkHxhj9ImWyL1OohQQFH/uz+MPxm4GV7aAtHIkbQzW4kEX1Ln90AGEJ7lQHOtxbB5qyjoN7A8q42QSYJH/Kbaef8fOARQs3PeNT7OpWuMNXsrHmC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:10.9728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44348d5-3bf4-4aef-0eca-08df44e01414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aie2_cmd_wait() discarded the result of the wait, and both callers,
aie2_hwctx_cfg_debug_bo() and aie2_hwctx_sync_debug_bo(), decided
success solely from cmd->result.

cmd->result is only written by aie2_sched_drvcmd_resp_handler(), which
runs when firmware responds. If the job fails before it reaches
firmware, for example aie2_sync_bo() or aie2_config_debug_bo() fail to
send the mailbox message, the error is recorded on the fence and no
response handler runs. cmd is zero allocated, so cmd->result stays 0 and
the caller treats the failed command as successful.
aie2_hwctx_cfg_debug_bo() then goes on to update abo->assigned_hwctx.

Return the fence error from aie2_cmd_wait() and check it in both
callers. This also covers a fence errored after the command was posted,
and the case where aie2_cmd_get_out_fence() finds no fence at all, which
previously fell through to the same false success.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 11f5421e497a..0a1914f0f1c0 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -984,20 +984,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
 	return ret;
 }
 
-static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
+static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
 {
 	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	int ret;
 
 	if (!out_fence) {
 		XDNA_ERR(xdna, "Failed to get fence");
-		return;
+		return -EINVAL;
 	}
 
 	mutex_unlock(&xdna->dev_lock);
 	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
 	mutex_lock(&xdna->dev_lock);
+	/*
+	 * The job may never reach firmware, for example the submission to
+	 * the mailbox failed. In that case there is no response and
+	 * cmd->result stays untouched, so the fence error is the only way
+	 * to tell the command did not complete.
+	 */
+	ret = out_fence->error;
 	dma_fence_put(out_fence);
+
+	return ret;
 }
 
 static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
@@ -1044,7 +1054,12 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 		goto put_cmd;
 	}
 
-	aie2_cmd_wait(hwctx, seq);
+	ret = aie2_cmd_wait(hwctx, seq);
+	if (ret) {
+		XDNA_ERR(xdna, "Command failed, ret %d", ret);
+		goto put_cmd;
+	}
+
 	if (cmd->result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
@@ -1104,7 +1119,12 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
 		goto put_cmd;
 	}
 
-	aie2_cmd_wait(hwctx, seq);
+	ret = aie2_cmd_wait(hwctx, seq);
+	if (ret) {
+		XDNA_ERR(xdna, "Command failed, ret %d", ret);
+		goto put_cmd;
+	}
+
 	if (cmd->result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
-- 
2.34.1

