Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB2606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=40cAUHXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDB610E50A;
	Tue, 17 Nov 2026 21:27:56 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DC810E50A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvqZEBW16jJvwUwr++Rfhg09ca0HkCxPA+bUWTJOHCAbbAh2P13lJWyIEhkotnXetwkVGVwPegcpeF243dfsQxkuXuoxhI7SN8SsKJUIb3Rgey2rBW4rjEZgal58xaObQ0LU0Qyn3NGxT24wbK6XzGJZ+JNv+NJ3BH3HZEtMtyexYgzCpuBNHySweCCNyPgqLBYnRxRRocOg4X85m4fvgsF7nroewkdcXR98JSoGpbdgmrn27Bx/n9crFj0P9Xxl30zVgILzPqyUfGl89n7hHH0QrJNoUO7cw0/IvuoWLS9fMQMyp/TUhOCU5zcldrKqXXxPdS8X646q3Z4nlcozdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozmx6QG8ZvFL9hWSgeDBeVqzvL/Mx4BlB4AK4Gz1yPk=;
 b=YWwKsHoLcOZWbRlEtx96amNw+AGM8SDqOyiew91JbPm+9uU6s8C9lx5JBxKaQ5qojTdyrVF70tWnYNwf93yT+t9OImku1nJQ4GHw63Sl1ATxEEu/EWM7u0D1SAChgRBAZHHqMjWtyOayWfAzBPKTH/4kz+ZspG9w+TN8JpnIjHmMjFGDKRe+kormPvTJ9r8qS1YfCB/xxJA5yAkTeVZumA6YsvNWkcE2F9s8tfe0FbAnpAidQpRy8UdxP9Lqdzh2q3dGYSwMtdgCENwcnWpq7ekgJNnMB5SnRlxCDjWkD/ZW/Zc07SHbKOalO2lnW/26gicLKKhGEPbOIg5AAEw2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozmx6QG8ZvFL9hWSgeDBeVqzvL/Mx4BlB4AK4Gz1yPk=;
 b=40cAUHXa76omcdZGgTZ3SkB/aklL4CGYzX9MT2eLQLWaY+n0fIhAMZjYvwEwcEc9H3WO8VNnhIhMlYWa+8UIEDeDMed5vWiOKxCRB5h1MBVJ27tWI31D/f9N66mAxzo6j+t+hVPKfQIAESvTHa2o+tov+5z4AcUV2/AL7MDmhAs=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by SA3PR12MB239779.namprd12.prod.outlook.com (2603:10b6:806:5a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 21:27:42 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::f) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 21:27:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:27:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:27:41 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:27:41 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 15:27:40 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V2 1/2] accel/amdxdna: Detect a driver command without
 firmware response
Date: Tue, 17 Nov 2026 13:27:32 -0800
Message-ID: <20261117212733.172074-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|SA3PR12MB239779:EE_
X-MS-Office365-Filtering-Correlation-Id: 57559c31-440e-449a-138c-08df44f19ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|261009223027099003|11063799006|56012099006|10067099003|261021123027099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ZV4jhT5/rh+jabvJ45y7saMC87Qs2C8DUKrR6kN7ncV7/2Z/teve0nhh9sxPIFBxK/xotzUIks+6RP1ohGjScFw65/n57T016jWEkFp0DfpNDknSxl1KTXh3VKUZJooDiFNlzd0iFQhNH1xbFa3uoL8EsLzpboauf1m1ovul98tSXrB6BhQPgzqu7yxZiHp6LxLjbYhWLMepwmnjhQvknREzw3ZQdnnqOJn7AxtDT10CfmswJP9byeEX/MFappkv0+iC54AYukstXhdknkHtU5ZOfTjwxEfY9ZSuLuDyHDTGIPinO9TrCL1iKsFPRI0ED9AwPHHWCovGOWTfZL877ffP38GctoNQtdfUtfGecKZPMZnuNnLsY5DLxVD6SVYByh6Br8RQQajC1DzmReZs6bFDYtxNjcVP8mQqcKn6BCI1+hk+XmW+zr9/5yePuamYulbmhtAPH3Z5UVb89HNkmnWR7aEkhiEJVGN9MtWWUbdgQqltcK64pywsMnXpLVK36JnYOnGvsyniBK+eGzI7+oAnWJAtkVbVMGQbnEUyq5dxR6J9MnqW3hhycUS26WnaOQIkYyMbfcIy5cTfMgh0CcC1bkjd53D17yZvEoGC9FOD1ypXnImeaAwLvvdr8Aqihsz6w0IBYqDm7o4UICKUEj3+XybcGUoXC56IYTHLehPUB9HOBSPk355wn4A+ehUVmcS7NqW4uXKRUGzMRWytqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ua0LC3wohJ2tCJsO4jOOKlhsbqjMVqm/seSPvYlP+ysGlvzGAErOxwL+Ldo6JR5uK9J7hVnzxe7VisineD0OhNVlyF+IchVk9b/8GxwMK9cBLNmjWfF3bRbdkoW45kRXu6pTq4RQ6jwDL/eBoTQqQAj45PYfinitzHJq+PIGgUQ+8Z3yXO3G3dKbBSr4rbnvY/XuNu0v0KWcrbXDZnmkmekuGRwhg98cDJnBlCA4+GWFMVvbahLXbVqu1KWvAlOURtKyWm/qN8n8q1CV1ejLfIfI9JcvEm680IG5cpcHkqGT9HOAIsVJlaDC1kTmn1mtu6hzV3yUz9O9/LnY++kUS+H3pVUh8+x6nciWYH5Bl9ecuLPmxP/Bi/M4+rImggnDfhFo/3FyqZTJrJujlyDzp6R7oESTt6V16GRhXRDEeu/JWl6A0hvLMWfNMY6rjCf7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:27:41.7950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57559c31-440e-449a-138c-08df44f19ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB239779
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

aie2_hwctx_cfg_debug_bo() and aie2_hwctx_sync_debug_bo() decide success
solely from cmd->result.

cmd->result is only written by aie2_sched_drvcmd_resp_handler(), which
runs when firmware responds. If the job fails before it reaches
firmware, for example aie2_sync_bo() or aie2_config_debug_bo() fail to
send the mailbox message, no response handler runs. cmd is zero
allocated, so cmd->result stays 0 and the caller treats the failed
command as successful. aie2_hwctx_cfg_debug_bo() then goes on to update
abo->assigned_hwctx, leaving it out of sync with firmware.

Set cmd->result to U32_MAX before submitting, so a command which gets
no response is reported as a failure.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
   Use a simplier fix to address sashiko comment.

 drivers/accel/amdxdna/aie2_ctx.c    | 12 +++++++++---
 drivers/accel/amdxdna/amdxdna_ctx.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 11f5421e497aa..32458d05635f9 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -989,10 +989,14 @@ static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
 	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
 
-	if (!out_fence) {
-		XDNA_ERR(xdna, "Failed to get fence");
+	/*
+	 * No fence to wait for. Either seq has already signaled and a later
+	 * point pruned it out of the timeline chain, or the syncobj was
+	 * reset. Neither means the command failed, so leave the verdict to
+	 * the caller, which inspects cmd->result.
+	 */
+	if (!out_fence)
 		return;
-	}
 
 	mutex_unlock(&xdna->dev_lock);
 	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
@@ -1022,6 +1026,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 		goto put_obj;
 	}
 	kref_init(&cmd->refcnt);
+	cmd->result = U32_MAX;
 
 	if (attach) {
 		if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
@@ -1095,6 +1100,7 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
 	if (!cmd)
 		return -ENOMEM;
 	kref_init(&cmd->refcnt);
+	cmd->result = U32_MAX;
 
 	cmd->opcode = SYNC_DEBUG_BO;
 	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 2e6b300d652f8..bf248d3f16ed1 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -145,6 +145,11 @@ enum amdxdna_job_opcode {
 
 struct amdxdna_drv_cmd {
 	enum amdxdna_job_opcode	opcode;
+	/*
+	 * Written by the firmware response handler only. Set it to U32_MAX
+	 * before submitting, so a job which never reaches firmware, and thus
+	 * gets no response, is not mistaken for a successful command.
+	 */
 	u32			result;
 	struct kref		refcnt;
 };
-- 
2.34.1

