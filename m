Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ctDJi7BS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C7010E692;
	Tue, 17 Nov 2026 21:28:06 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAA310F92C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxEqD14bsBAy91UwMhSAdHgAdifim3pyjrRtfndFMKXaqJVzGIwpn98RLm5SWEkD7zozFcdt+6JplH3lWBJn2RdhSmRXIHsWTW7I1DxyPvoF6VqiwyxscVbhiglKOqOiou6opFiEwJ8k0K0u4GYxpTRQu2GfTPrLkoQpV5HEI7S2D8TzJMPAQxn3/psazrat6axO2+o5Yyn8cvzsl9H+vwcfloils+tQABNE0kgZIRbHyGWFOxVu/l4ZGGTaDWysRnnkLBzyYN598UCphZapdeywrUEdkcFQZ3GpNkg6O9O+bAbboEo5zoi0Ixeap0OLx2jKz7TzTxX2Y/wjzElUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/3RUfY7sckZjBSKqI7pEG+6cdQIjxZIjyCeuo7RkcI=;
 b=rKAUcwjs7vsJjPwRROoJytVaQwXSGLXtSv0ioSHZeo0rPXa5FSmnNQ3mZxH6AOHiD6XM31eZB1pZLVpix3ST6K67Zn9UjL5yWmr5zllRzhPeZiWXcPEAKTSwt0eBQs40d3zgl7U4Se1Y3Gro4QfMJ27pmpe2OFOFhSjwaNCJT+aOsAXza58AagRSzOgS9fr7FD7tGW99Z1Ay0S1st2ddXUvSgP7+a6C+icn1210WLEOVKDQXc3wwCoDNy8aPGJEyBvXrZRyzSlIm+ybWU/Zmc5RbpLZ9Tehg38a5uvEcWG9Zi/TmNcureDs+K8DlOiZEsRcfG2l93+O4pjktVO5rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/3RUfY7sckZjBSKqI7pEG+6cdQIjxZIjyCeuo7RkcI=;
 b=ctDJi7BSO/B4kypM5qCvk5KNt2fjIhwiotzL1VhAMKaPuOVsVnrlDEW3ctN2JAP7pjxowBfMNs6FeqFNWGcvApYj1i0BHaJwW469XJAopd7+yUZv+trxMmcPHUArVC3FdyI721VAOFGtQMNfnoLVSjpFH/v0xvwpoaREqZWdT/4=
Received: from MN0P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::34)
 by CH9PR12MB721654.namprd12.prod.outlook.com (2603:10b6:610:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:27:42 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::50) by MN0P222CA0029.outlook.office365.com
 (2603:10b6:208:531::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 21:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:27:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:27:42 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 15:27:41 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V2 2/2] accel/amdxdna: Abort jobs when the firmware context is
 gone
Date: Tue, 17 Nov 2026 13:27:33 -0800
Message-ID: <20261117212733.172074-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117212733.172074-1-lizhi.hou@amd.com>
References: <20261117212733.172074-1-lizhi.hou@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|CH9PR12MB721654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d12b7f1-f5e3-4978-a3a3-08df44f19d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: k0OuTNTEsWTuZFM9OldwLlLIbCSa7k69mw9L12DAiWZo1vraw6xm1B62nTBpgOQaDmDHGpIPABxuAOicgCBDxjNM0BIpZ4FRWYjl5oyN9pd+Y+w8XEfBHO9FlD9SLL+QtOINFJSXVF+eFSEhtYgQOz87cmA9CRHqUOypI9UMXVkSO4LJwYOCYItq9TYSMMXMVkCvJVs3Avs1H+jFWSdoHFPw/BIM8IfWI2ykoA2gBlhfywPZdr8BToxfUIdOKdmbhmEeCwRGKCF7WMH5mmJp9bzS9MzYfFQY/U5b8rEOBHnZq0dnorr2nRvkBeNR9AqYpdTOkPqyCuaN4d5KYAxh9p5SFuekzE52XMEKix8aIutOUrVhrGPfMpzNiDHWBoDCQGEmuyR7TWR3FK6r/KmVxwQUaBhFNOjZau+yA6xcF/6DKUbl7UDdTI+0HKlHt6bGxF4yDvA4x/SeaAebKNdCKi2IkrmuLdxpypidTHn39vsshmCWGD9O94XV5jYwzG+Om0kdds8B4G1Z+gFiBtDmiR0Dv1BFm166xSbZjW6GmLmW7I1nxun2TYLFSl0ao4yDC5zu/PPZ3Q/1qb5ntv60YbBkbe602BMPypWLl7jmV26+2s4jT1VNsQ39qAlVp7A/E+06lMW7z1al0w0EMVmasMEHahIWAaX/Y5qmNjQNNXRQFdrfeUJjz2juaVFhLb/hjHwcyXQ9wKtsTcOh4Th3cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2HVx/gmIDJkUAHqZys77Hl21VNl71cWIe50qQkn+EAOnjM+yRiYUPgUQO6qOi94TeyxbourRM0lUeECLIPbSKa7ZQVdrNVAmcK2Q/95d1evd+aJTNEW7xNI6EfZFUaQ2hwoyAuIAQN7oUWbmDtWaOY/5lhKR1lg34xbfy+5EwP3+CAAsNye9i4Le1HHeZUMMWjLZRJ0Z2IG4LHSD0zxN2WqCf0YbhFM24DSgKsATnY2XEpPfk7f3f/zlNLVAJrL6D252SWDNEUyH5LAKg54MDqB2KdLA3zYRxny6OOrwObvclZGVm7zpI5UUCy8gkGYsXEl0540+EiOHb5/y7litCmIODkfxC/nMJkBBPf75nE+7p4ikN08bhdvo7bZXAdgwdOrJD+DqdoI/l/gDkyiHXZs17FLKGIsmLr1XZ+WQSI2wot+WkmI3bUH6K+QSgI6Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:27:42.3980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d12b7f1-f5e3-4978-a3a3-08df44f19d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB721654
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

aie2_sched_job_run() returned NULL when the firmware context is gone
(mbox_chann pointer is NULL). The DRM scheduler treats a NULL return as
a job that completed without an error.

Return ERR_PTR(-ECANCELED) so the error is recorded on the fence, and mark
the command BO aborted.

Fixes: 6b13cb8f48a4 ("accel/amdxdna: Fix runtime suspend deadlock when there is pending job")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 32458d05635f9..c42ea1b4e08d2 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -404,8 +404,18 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 	trace_xdna_job(sched_job, hwctx->name, "job run",
 		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
 
-	if (!hwctx->priv->mbox_chann)
-		return NULL;
+	/*
+	 * The firmware context is gone, but the scheduler keeps draining the
+	 * entity, for example from drm_sched_entity_destroy(). Returning NULL
+	 * would make the DRM scheduler signal the job fence without an error
+	 * and user space would see the command as successfully completed.
+	 * Abort the job instead. Driver internal commands have no command BO.
+	 */
+	if (!hwctx->priv->mbox_chann) {
+		if (cmd_abo)
+			amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
+		return ERR_PTR(-ECANCELED);
+	}
 
 	if (!mmget_not_zero(job->mm))
 		return ERR_PTR(-ESRCH);
-- 
2.34.1

