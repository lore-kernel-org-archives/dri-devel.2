Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C1606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YO+b5MNK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A67C10E613;
	Tue, 17 Nov 2026 16:58:20 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDAA10E613
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjW1bMFbkGlVJairH2Sc+9wWx7OM+kZMIUw1pazJBGDIu+ufdYX2Q6HjFQ4WkY/rmcW7LxYTTWZQU5S4moWxPflwX8x8XcpedMTq5tPiONqtwOb56USfY5AJG9jKhBqDbbw+cpWsdyKdjhjONDZN+qmV1xOipG/1HWEtimMriM8otb5q2Yf393ukZv7xLmEVcadtTQPmGaZJW9tuu5KYpdB2D68IAwo6bDAOH0egBLo/0XvFJYCTIA60Z3u5zK2GinCVDUElYgq7XU88F889r1TAcioFtH7gEvC5ropEyam+uGCPknPETgTb/lprY5o5Wnt/8vpGQtbw+IbLeZAo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhRJ4NGtyw96ZOw0mxcsrZMlNK8Syf8yN7Q2KVXAKtw=;
 b=r8mQnswcTC40I0rmXTCtE67ABDpAZGLHE30QJhcJDqvfiNf7ocBh42ptf8JsUkCytaLlgP842Ngh+UcODOwc7N+IQUfp3B7Lb1h3WfSd2ZYv3FCxI57Z/TJSp8uDNJhmG2BeqtyyGuPmqjHRJR8PYSRzTlJK15d4HALgjJPymu6GikwisQhQGFTSa28EDYhKA0ILbhC2W4ZPLOV52o0C1fdWLIkw2A7nH1oC7pjKCPjk7cXwhBg9yhosM6RbVyvGZtxYX4G8n/oxkqsFTXNqwrY7a3Vixz20AWqrw/4WWclnkxW13/gtm/oo+lmcCWASKBM61xB+7JNnOQCrMYTU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhRJ4NGtyw96ZOw0mxcsrZMlNK8Syf8yN7Q2KVXAKtw=;
 b=YO+b5MNK3dmvHY5sGpMa6rGD6y1Lgcokf+mtY/ybKoNcCLmXRGWpQPGMVb/oN19yS0RLPJlX2kV8a47COH6JFp9dM4U9nQvi4xJfg9dTagx8H/KoLvjiZ5L+KEfy1w2IdyFcmVq6eKHznVdfOLQGwF66IDHDHvZAgDnca1/wvF0=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:57:36 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::39) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 16:57:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 16:57:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:57:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:57:33 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 10:57:33 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Destroy the context when hwctx restart fails
Date: Tue, 17 Nov 2026 08:57:31 -0800
Message-ID: <20261117165731.132261-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 268f650a-d898-4a73-c634-08df44cbe122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|10067099003|261026121527099003|261102123227099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: uv+Duj00NbuzLiKgs//p45uz3KLokVF8JOl//1ZG5v2M+wWCLUxw5HxeYbM/tElKqggVFzWQMZ/o2pPxvuOreaOERfCOrs73K367ALDoP+z2vYs791yLfB0EL8RfWEiVi5f/id7WKJVUiTyAeongQ3/FZD6T3gW0UbVNHn4coLQ+tYnvAeKwZv+Io/KZOPz26zmo7Ult6ehEpbuUSOCMAzZCW7Z4V471arzo8N48uWfDc8G6DBS1dw8X4Trw1PgfY7P97Pa1dZyX9ZiOzamESziI048ZKzkix6VfgMTfl4ONMw5+CHzihhcC1OEfQz8GHjWvXasqpS0b3QC36dRtg266RbgDvGIoN1jLja1r/i3yfEWZ4pgkVJ/eFu87xHiHC3RLkSaMMON3vgX+MyCXePjhhLgKTMKuyprGfZ4qRbIcOvqda+6prc3VOx8X52zjWE3OO0QdTSYD7BpTIg/HjflgEGc2zSd6y7sXRFkv11pwG9saYbOw/Hnzwq25VG8io2oQvuZA/JG+qc4FQoMERecDyKfbQFoN/Ii/WBV0VUHY8SOPTVDaJCsJz23Vh/OVKnuYP83y+aWFO8INLNqGww2zL5WTzXjoK+FVpU86pylEecWk1XyjWvgQbGIPZMc6QzXoJPvdET6PYVF52eOy5VSy8u9Z9iL9dtC8qsRIdac/lwhnayMLm5W0AJUPyedfGQiNVMBEIrtiDn9kbpDl2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(261102123227099003)(261009223027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hnV7hvKHRm/7Tyn5AHl740FggjHtyNaJiMuvOonU0zH+IBBsMtck3mVKyEg9pifkAFpoLMU445wXwD5MGdoIbBrIqij6eUdfNFZG6HHUgNXAkeC83ljyRvAJhn9PVExe7JDT/rJYKhy9obpUctQB9R0Ua98OAoScbM7nxYDL6DmWy+CQ9kT8W98GFzQ2leJrML8NOtiwEK8ytOO02odfynzqzoqs10fz0gn525xnkbwYSwFq+AnlnDiZwUinl7D0xuiMyESVqnuFN661AwA1+loDdT64Jq7fij1YQXB0T51GDgAbGvoKT2ZhpI3kT0j9qm+zcvSYU5nsdwDqM/wB8m9IdVSUFabdbYqLyuU63MCErLrAgVOoVW/8GPyAZqpID6ZE9cgDafaE7FqNxkptbNOm756Y9O1pb+Dt6Cg+d4q5skc8lBFgPFlXNPH//zrB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:57:35.5610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268f650a-d898-4a73-c634-08df44cbe122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

aie2_hwctx_restart() creates the firmware context first, then maps the
host buffers and configures the CUs. When any of the later steps fails,
the error is propagated to the caller but the context created at the
beginning is left behind: hwctx->fw_ctx_id stays valid, the mailbox
channel stays allocated and started, and ndev->hwctx_num is not
decremented. The hardware context is reported as failed yet remains
alive, and because aie2_sched_job_run() only tests hwctx->priv->mbox_chann
the scheduler keeps submitting jobs to a context which has no host buffer
mapped and no CU configured. Neither aie2_hwctx_resume() nor
aie2_sched_job_timedout() looks at the return value, so the context is
never cleaned up and the firmware context slot is leaked until the
hardware context is destroyed.

Tear the context down on the error path.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 74d7019268cb..11f5421e497a 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -122,7 +122,7 @@ static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hw
 				heap->mem.size);
 	if (ret) {
 		XDNA_ERR(xdna, "Map host buf failed, ret %d", ret);
-		goto out;
+		goto destroy;
 	}
 
 	xa_for_each_range(&hwctx->client->dev_heap_xa, heap_id, heap, 1,
@@ -132,16 +132,20 @@ static int aie2_hwctx_restart(struct amdxdna_dev *xdna, struct amdxdna_hwctx *hw
 					heap->mem.size);
 		if (ret) {
 			XDNA_ERR(xdna, "Add heap %ld failed ret %d", heap_id, ret);
-			goto out;
+			goto destroy;
 		}
 	}
 
 	ret = aie2_config_cu(hwctx, NULL);
 	if (ret) {
 		XDNA_ERR(xdna, "Config cu failed, ret %d", ret);
-		goto out;
+		goto destroy;
 	}
 
+	return 0;
+
+destroy:
+	aie2_hwctx_stop(xdna, hwctx, NULL);
 out:
 	XDNA_DBG(xdna, "%s restarted, ret %d", hwctx->name, ret);
 	return ret;
-- 
2.34.1

