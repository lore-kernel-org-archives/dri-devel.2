Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FB2F53D7E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6521610E133;
	Mon, 16 Mar 2026 17:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHC4iwrd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD3210E133
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 17:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlAJ09U/c2v5vyzTMbGD/lp4/XQfjaveTnhfWnox7XOF8GzQN9TJj5eiNXpVFVZtaTMKBBwj8cGUzn3eM/xSf/gcRn8lEl90Jp0fYO3Q7zEgVKp1ZHAUdOSmLKappPbMHuB5K1m76MRVo73IC78T2nrjVJuqnOMzomjEXcgD5JacvCrLYkyASlO/QBI/wdj9wxknni6+EVhgSVvpeAMTvl5pNQTRA9obFHOF7HkngsFvJfk5YG8vkwVyKEnUfykVo255tTuMrnuotQE7PEQ6ft/AjAa8H5HdcNw4UBNCoWXLrBRBtB8QiLR5V8mKj9f9e1hAZvWfCruZ1GfwBQ2QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elWR+ZPuqAKtVy8Y/bjws8FJgsrym+CL+zCMH/bIkds=;
 b=WT801+79mALt/GCSN8RCvPkPaD4s1FFpRUXXtgI6nCQK1ldTQxQ2F64eMROMjlEb906aL1MrrBBLirrifWd26vUbIvO08Tx4FzJLKbPsRUvFnxsmfejucWC90dpv/aWwaU8n47gV1LYTtQYuyMQcSt5i50bU0U0CLP5rwJXMSOHVTVBNymrrwjNnc6KXSBO4MS/HHqbkXNvneLSuBSdiia9s30pPAn8I8MSDgQvKFZh2gee3xLZd79gxOou0EITu7Z2tRVL7PpHpnkStCy1YDr7+vt/0tca5JkknVmuW9ycY11zBmarKKjOGZEQq8MwDFRGY2n9Nik/FRK71EQ6IPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elWR+ZPuqAKtVy8Y/bjws8FJgsrym+CL+zCMH/bIkds=;
 b=FHC4iwrdDKS/Mb/cP1yvzi8Un3j2gXToxqKdcYWb+TSiuV5b6SCX6HhmEWYILY+4I3dl08/C/+wYyamOQo0TlCcgweV7bBYb7i3W/YpRm22SBnAjvSi4eNpRhm4SEdjCsamXQKJFgmSP7EBX/SADkikWYbZcukXkP+bNeFkdiLQ=
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 16 Mar 2026 17:56:44 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::4d) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:56:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:56:44 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 12:56:43 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Add debug prints for command submission
Date: Mon, 16 Mar 2026 10:56:42 -0700
Message-ID: <20260316175642.1451749-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1c5f87-7ca6-488e-1948-08de838562f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2HGtFq78JKX2I7ROhLeTV+l0wqtLgox9RNeudbNb8mWIKy7ySfwhN7ChaorAVom6CsJy/5FX1h+jFcYYVwYzrxDJPnPeC0HRGa32i7mg6mcebH934XuQNLc/DOIEwQuPf47mdDc8FAZODvdVzGejhTmpjnnUgKN81GYXQ69ogYMSBW4LZc41JD7jH6UT7HRQEMYdHrzHPaWLt/an+tpUdCQ2pcjjiOjoTtbLW4VoUgKe0ueRhC6pa/KDlmLB/uQs1BiAZTcKPnBl2vUjlEW6xIddikaHVKdrYCWjyf6vNXh660a68KqFxnVqvJE17F2xVhII8sq7q46BCDQizP5DrxjtTX5OnnOcR+2IdVqxVxARaKHi6KzFxy6zYayZVQ2qGTHSZeEKEQDY+edgLEsY+K4aAoC/sRfWHkcDUkLoCLHNS/erCH94BkBtZ8iWD9kZbJj0t88ogRZSP97nnteslMjELjsgIlI54YofRgNLu5m4PCpwdUoQfFrg/y2Yyw2/fa8Uq1IBHlLr+qxkJO3qG/40vAlrNqGqUKx+MF9cBw3zJlFDIl+cq3gDF7IepyRej0lSnKyR9rZD7efMlswg8eIOhOWPJS3lNiga+yaV/QEZzUnDeaPDJ/zpB2YjoGxMcOGCYpDHe8n+9dy1OZp5ABMzmSrLhwVkbzAMHiPAXaAgvMHu6Qj1NmU0pTxWMtvcFNqafsA5MYT56+KuhgMiiSaZfnrWoMz8bi7ldiuSKj6Vtq42/IubY7BXFtH0qOXoCjOtRVUlfEBFrOZJSoWQAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IlvRREoJfDgRqDCAB1BDcdMhTnhmVU+xT7k6S5ZQIZOS2HwyisfXfQ/puysPpLyXa5buZSl0dMK1hkT9Qc0HdqSzWKKspdFQW/ZfSAjxmCosfzim2iWGD4wjiPGjtqN8z3UNGfNVQmPUrhtAwERExtCQ83LqIgztsJTzCj8cIhPLAJLmMt/ON7ZU3qgjlOJFNdxOnayX6otpmKF/DPIJAHJRpzml/f7/pMyCOPbBWmynmy7HbK2CjNDDggDXpslHWwJAgAY1dnnMIwNsgB57PSEjgiItDB4mzzr+FRGH8NvH5aEG54qgn4+G73aNhuPcfqfVEMPGg9rXBvq4T7MXUeHWcnR1D3/YR5br0C3RS59G1zLFZ5ICNNizQJYeXhg3o565p1Liwk7YnaYnRp6P+HW7hhGL54cqVriyStgVhqcAPhlWXyOaWIA3r1pM/mqm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:56:44.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1c5f87-7ca6-488e-1948-08de838562f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

Add debug prints to help diagnose issues with incoming command submissions.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_message.c | 34 ++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index b764c7e8816a..4ec591306854 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -1002,7 +1002,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
 	struct amdxdna_cmd_chain *payload;
 	struct xdna_mailbox_msg msg;
 	union exec_chain_req req;
-	u32 payload_len;
+	u32 payload_len, ccnt;
 	u32 offset = 0;
 	size_t size;
 	int ret;
@@ -1011,12 +1011,24 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
 
 	op = amdxdna_cmd_get_op(cmd_abo);
 	payload = amdxdna_cmd_get_payload(cmd_abo, &payload_len);
-	if (op != ERT_CMD_CHAIN || !payload ||
-	    payload_len < struct_size(payload, data, payload->command_count))
+	if (op != ERT_CMD_CHAIN) {
+		XDNA_DBG(xdna, "Invalid op code %d", op);
 		return -EINVAL;
+	}
+
+	if (!payload) {
+		XDNA_DBG(xdna, "Failed to get command payload");
+		return -EINVAL;
+	}
+
+	ccnt = payload->command_count;
+	if (payload_len < struct_size(payload, data, ccnt)) {
+		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
+		return -EINVAL;
+	}
 
 	op = ERT_INVALID_CMD;
-	for (i = 0; i < payload->command_count; i++) {
+	for (i = 0; i < ccnt; i++) {
 		u32 boh = (u32)(payload->data[i]);
 		struct amdxdna_gem_obj *abo;
 
@@ -1035,19 +1047,26 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
 
 		offset += size;
 	}
+
+	XDNA_DBG(xdna, "Total %d commands:", ccnt);
+	print_hex_dump_debug("cmdbufs: ", DUMP_PREFIX_OFFSET, 16, 4,
+			     cmdbuf_abo->mem.kva, offset, false);
+
 	msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
 	if (msg.opcode == MSG_OP_MAX_OPCODE)
 		return -EOPNOTSUPP;
 
 	/* The offset is the accumulated total size of the cmd buffer */
 	EXEC_MSG_OPS(xdna)->init_chain_req(&req, cmdbuf_abo->mem.dev_addr,
-					   offset, payload->command_count);
+					   offset, ccnt);
 	drm_clflush_virt_range(cmdbuf_abo->mem.kva, offset);
 
 	msg.handle = job;
 	msg.notify_cb = notify_cb;
 	msg.send_data = (u8 *)&req;
 	msg.send_size = sizeof(req);
+	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
+			     &req, msg.send_size, false);
 	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
 	if (ret) {
 		XDNA_ERR(xdna, "Send message failed");
@@ -1076,6 +1095,9 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
 	if (ret)
 		return ret;
 
+	print_hex_dump_debug("cmdbuf: ", DUMP_PREFIX_OFFSET, 16, 4,
+			     cmdbuf_abo->mem.kva, size, false);
+
 	msg.opcode = EXEC_MSG_OPS(xdna)->get_chain_msg_op(op);
 	if (msg.opcode == MSG_OP_MAX_OPCODE)
 		return -EOPNOTSUPP;
@@ -1088,6 +1110,8 @@ int aie2_cmdlist_single_execbuf(struct amdxdna_hwctx *hwctx,
 	msg.notify_cb = notify_cb;
 	msg.send_data = (u8 *)&req;
 	msg.send_size = sizeof(req);
+	print_hex_dump_debug("cmdlist msg: ", DUMP_PREFIX_OFFSET, 16, 4,
+			     &req, msg.send_size, false);
 	ret = xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
 	if (ret) {
 		XDNA_ERR(hwctx->client->xdna, "Send message failed");
-- 
2.34.1

