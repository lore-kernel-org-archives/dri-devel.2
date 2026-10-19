Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92A606AEC0
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CUKaOE43
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9AA10EF38;
	Mon, 19 Oct 2026 16:48:29 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1373210EF38
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwDorAki+uom1yvVzsdN1QxKAHcaiQ3jDfqSAxl19y6OiHA/WeAQwEKnYpPrWbHcvJbNjo2ONfsDHu0DCYLcwGKSW0f2Ts2aabaGSe2hf+Go8NsIwNIX5INwUjrXNUXaAyz1R3WXPkVTVKVCJyLFmFvXXw5FVdYtc4UHoGa1I6DwMZsXVGoyfQl4+upgdC8efcg26rgsjJYrgaDxaJTQvrbiRT3s+BDRNignd7Bta0Ym9/9TDT2NPsksjxsOR2zpSm+SBXRLTZvHnDu5IqqFOXaIXj0Ue9a/0jsr0WFyfvZCm2tUqX2xFsm7nwch/EFg7qn/k7TMhojZyZH+tnjBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbYhDCFXzX0mAOJMjmV5EO17zCXgtCnSUOTszCQgelc=;
 b=Xy9GLplBl4BBTP3QIM4fMxIvJN4GYSugBzN7FjEOD/07DMUyqw4zZfN3Jn06S/c5QWgR7UflBbiYQjBg5h4nMG4QmdGs60HDLt/nc9rJiOALbku1F9KbpQZ2tmd6geOkI3isK6Rn0TomJmk9AhTm5N+cdWUNApBfRhrWUmx55K8kInvCGhkNc0pVCcvB4tP2HVgsX++tfouicWF54gZNADzOlhwBHySf3oGxx6DFr/HFz/G1AjeWfgIkBKbUXn78ndrSNGALhnmgtF9XOkXnnF4nfGEj8BP4fjxSCeVTpG+Ffsb2SWztOWD8yDBTN3vrhQ3mnFr46SZZm7KSoGDOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbYhDCFXzX0mAOJMjmV5EO17zCXgtCnSUOTszCQgelc=;
 b=CUKaOE43zDBb3yT/BO7MHkbb8IGUdaEdoe/KmbUQIptGY20r3svhBb/wlozA6vJmUVbJ7XCoyxqcXqime73o7GSt//9gHg/AMHnMbz/qdIbjiBWzQnDDUl/DM78L6BgwPwh79yjusb6GR8SuKh7vMJOGzzaIyo6p3VLgQs3Onbw=
Received: from CH0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:610:e6::11)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:58 +0000
Received: from DS4PEPF000001C2.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::9a) by CH0PR03CA0276.outlook.office365.com
 (2603:10b6:610:e6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:47:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C2.mail.protection.outlook.com (10.167.23.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 16:47:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:49 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:49 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Nishad Saraf <nishads@amd.com>
Subject: [PATCH V5 09/19] accel/amdxdna: Add context switch hysteresis with
 debugfs control
Date: Mon, 19 Oct 2026 09:47:36 -0700
Message-ID: <20261019164746.827277-10-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019164746.827277-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C2:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab8bfac-7ce3-4bea-e0d1-08df2e00bac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8GF0yOrV512acr2pETOn1eKkfiz1F8RjXTbFGoFenXgGfzVorzjqzYn9+sdk9Jv/zEMMbtlJr7zryjFyAFm1eQwUdWHnVwSTgQCVZuWHGnQAkhxJXY8eiFapUf06Ttdm68Gfd4ILiFcyInPtwVtnULUYwjeKDYUFX+qxOOBcgYIddUmgoLfn2HzxuQenveAi2XVPOs2yK2inK7ZMOQFUwWEN7EMziU6oKAaMaYhreyYAGaY2jrCs7NMP7SHbMuBvE168qIGxyXCeJp/5r9baQ4wGbP2MaSZbEotqrrkPp3zsS2nl/hjlvXgjtMEgEngTBuQUPD6giL6g4EDTAW0TQBYFvMd9SgHh3li45znziUe9ySGzfkH0oWrNu1QzvyGfF7cx1gw+BiXBSQfqyRsp0+k6qjR/qNbbXBCTnK16EeWYRgoNfa1sN4+Olvr2O408Ws9M62fE409AobOK2fbPkr3EawbFUEUpYXlYKQPcbpTNjHqsvwTFXhxOw29BhTW+Xq0F4vNHyX3B8IYpjXICoCC0Gsdd402sDO2df4EeUdPsgb5NOqPrF9+zsiBjOvKNvALyTFEjdtjbx/PmRdHw3fZJjsKL0efNpCct9axwbf+jJdBt9ntUvTRzTdXG9OzIKZfRqAuXqs+NMysqlzGOFCZq0h1hGMmfioTDOC8M7I8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ii6o2fsw/2UcjSV5MpI2h97yIIlaVhjrEBQos0tq9h6iDRzvx6yC0pgefL4mK4aQwBKC4S/OZLR7PryjGN8FFxQuatRj+/DAMCGyiL8xAWGSbpOgm+9Ac6hSd+IW6SDOsgbsa+IMeWym/88hbBBSOSmJFTnQjh2ERHK+0TNt0mkdYt+AvrsdtdJjci39m90zbOqJCLfZZdBCAoLzj2wyerwA9/za3QxfVV6fTTj0FtAKzrXlhniGHnW40mJsTrUpA+KMGVDG1hbiUCCMJbNSglRWrgA9RMvan96SULBq+W8mCfwLkG7yLfSsVEogHUYYJzOPZBciCxqLdPMQUSsY8/m/CiH6GAnq8Om//Ez5LIG9mdZl7cp+C8Jx9QSBH6pPmrXD9nRS00Ej2GMGxrFuK6DgBdBqDJ64G/XhvHyaPkvMCHJta9eqQIqr7C2klIyT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:57.7466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab8bfac-7ce3-4bea-e0d1-08df2e00bac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C2.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add aie4_set_ctx_hysteresis() to configure the AIE4 context switch
hysteresis timeout via the SET_RUNTIME_CONFIG message, applied at hw
start (PF and classic paths) with a default of 1000 us.

Expose a debugfs node 'ctx_switch_hysteresis_us' to change the timeout
at runtime (0 disables hysteresis). The stored value is re-applied on
every hw start so it survives runtime suspend/resume.

Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c    | 43 ++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 24 ++++++++
 drivers/accel/amdxdna/aie4_pci.c        | 74 ++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  9 +++
 drivers/accel/amdxdna/amdxdna_debugfs.c |  3 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 6 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index be5ec89f3a53..8d2ce013c69b 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -263,3 +263,46 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
 
 	return ret;
 }
+
+int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
+			 const void *data, size_t size)
+{
+	DECLARE_AIE_MSG(aie4_msg_set_runtime_cfg, AIE4_MSG_OP_SET_RUNTIME_CONFIG);
+	u8 buf[sizeof(req.type) + AIE4_RUNTIME_CFG_MAX_DATA_SIZE] __aligned(4) = { 0 };
+	int ret;
+
+	if (size > AIE4_RUNTIME_CFG_MAX_DATA_SIZE)
+		return -EINVAL;
+
+	/* Stage runtime config type and payload for firmware mailbox message. */
+	req.type = type;
+	memcpy(buf, &req.type, sizeof(req.type));
+	memcpy(buf + sizeof(req.type), data, size);
+
+	msg.send_data = buf;
+	msg.send_size = sizeof(req.type) + size;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(ndev->aie.xdna, "Failed to set runtime cfg %u: %d", type, ret);
+	return ret;
+}
+
+int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us)
+{
+	struct aie4_msg_runtime_config_ctx_switch_hysteresis cfg = {
+		.timeout_us = timeout_us,
+	};
+	int ret;
+
+	ret = aie4_set_runtime_cfg(ndev, AIE4_RUNTIME_CONFIG_CTX_SWITCH_HYSTERESIS,
+				   &cfg, sizeof(cfg));
+	if (ret)
+		XDNA_WARN(ndev->aie.xdna,
+			  "Failed to set ctx switch hysteresis to %u us (%d), using fw default",
+			  timeout_us, ret);
+	else
+		XDNA_DBG(ndev->aie.xdna, "Context switch hysteresis set to %u us", timeout_us);
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index fe78df9e23c8..636bf8d04c76 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -12,6 +12,7 @@
 enum aie4_msg_opcode {
 	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
+	AIE4_MSG_OP_SET_RUNTIME_CONFIG               = 0x10007,
 	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
@@ -65,6 +66,29 @@ struct aie4_msg_suspend_resp {
 	enum aie4_msg_status status;
 } __packed;
 
+/* Type selector for AIE4_MSG_OP_SET_RUNTIME_CONFIG. */
+enum aie4_msg_runtime_config_type {
+	AIE4_RUNTIME_CONFIG_CTX_SWITCH_HYSTERESIS	= 0xD,
+	AIE4_MAX_RUNTIME_CONFIG
+};
+
+struct aie4_msg_set_runtime_cfg_req {
+	__u32 type;
+	__u8 data[4];
+} __packed;
+
+struct aie4_msg_set_runtime_cfg_resp {
+	enum aie4_msg_status status;
+} __packed;
+
+/* Maximum payload for runtime config firmware message. */
+#define AIE4_RUNTIME_CFG_MAX_DATA_SIZE 16
+
+/* Context switch hysteresis timeout in microseconds (0 disables). */
+struct aie4_msg_runtime_config_ctx_switch_hysteresis {
+	__u32 timeout_us;
+} __packed;
+
 struct aie4_msg_create_vfs_req {
 	__u32 vf_cnt;
 } __packed;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index df88dd3658e2..f59394d62d9c 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -5,8 +5,10 @@
 
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
+#include <linux/debugfs.h>
 #include <linux/firmware.h>
 #include <linux/sizes.h>
 
@@ -321,6 +323,22 @@ int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
 	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
 }
 
+static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
+{
+	int ret;
+
+	ret = aie4_attach_work_buffer(ndev);
+	if (ret)
+		return ret;
+
+	/* Best-effort tuning knob; failure is warned inside and does not fail hw start */
+	ret = aie4_set_ctx_hysteresis(ndev, ndev->ctx_switch_hysteresis_us);
+	if (ret == -ETIME)
+		return ret;
+
+	return 0;
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -333,7 +351,7 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
 
@@ -417,7 +435,7 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
-	ret = aie4_attach_work_buffer(ndev);
+	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mailbox_fini;
 
@@ -572,6 +590,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->ctx_switch_hysteresis_us = AIE4_CTX_HYSTERESIS_US;
 	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
@@ -908,15 +927,65 @@ static void aie4_classic_fini(struct amdxdna_dev *xdna)
 	aie4_free_work_buffer(xdna->dev_handle);
 }
 
+static int aie4_ctx_hysteresis_get(void *data, u64 *val)
+{
+	struct amdxdna_dev_hdl *ndev = data;
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+
+	guard(mutex)(&xdna->dev_lock);
+	*val = ndev->ctx_switch_hysteresis_us;
+
+	return 0;
+}
+
+static int aie4_ctx_hysteresis_set(void *data, u64 val)
+{
+	struct amdxdna_dev_hdl *ndev = data;
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret, idx;
+
+	if (val > U32_MAX)
+		return -EINVAL;
+
+	if (!drm_dev_enter(&xdna->ddev, &idx))
+		return -ENODEV;
+
+	mutex_lock(&xdna->dev_lock);
+	ret = aie4_set_ctx_hysteresis(ndev, (u32)val);
+	if (!ret)
+		ndev->ctx_switch_hysteresis_us = (u32)val;
+	mutex_unlock(&xdna->dev_lock);
+	drm_dev_exit(idx);
+
+	return ret;
+}
+
+/* Context switch hysteresis timeout in microseconds; 0 disables hysteresis. */
+DEFINE_DEBUGFS_ATTRIBUTE(aie4_ctx_hysteresis_fops, aie4_ctx_hysteresis_get,
+			 aie4_ctx_hysteresis_set, "%llu\n");
+
+static void aie4_debugfs_init(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+
+	/* Context switch hysteresis is only supported on PF and classic devices. */
+	if (!to_pci_dev(xdna->ddev.dev)->is_virtfn)
+		debugfs_create_file_unsafe("ctx_switch_hysteresis_us", 0600,
+					   xdna->ddev.accel->debugfs_root, ndev,
+					   &aie4_ctx_hysteresis_fops);
+}
+
 const struct amdxdna_dev_ops aie4_pf_ops = {
 	.init			= aie4_pf_init,
 	.fini			= aie4_pf_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.sriov_configure        = aie4_sriov_configure,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
 	.init			= aie4_vf_init,
 	.fini			= aie4_vf_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
@@ -927,6 +996,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 const struct amdxdna_dev_ops aie4_classic_ops = {
 	.init			= aie4_classic_init,
 	.fini			= aie4_classic_fini,
+	.debugfs_init		= aie4_debugfs_init,
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 6e9e7f874a44..959ef3695813 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -14,6 +14,9 @@
 #include "aie4_msg_priv.h"
 #include "amdxdna_mailbox.h"
 
+/* Default context switch hysteresis timeout in microseconds. */
+#define AIE4_CTX_HYSTERESIS_US	1000
+
 struct cert_comp {
 	struct amdxdna_dev_hdl          *ndev;
 	u32                             msix_idx;
@@ -69,6 +72,9 @@ struct amdxdna_dev_hdl {
 
 	u8				pw_mode;
 
+	/* Context switch hysteresis timeout in microseconds. */
+	u32				ctx_switch_hysteresis_us;
+
 	struct amdxdna_drm_query_firmware_version cert_version;
 };
 
@@ -92,6 +98,9 @@ int aie4_init_dpm_freq_table(struct amdxdna_dev_hdl *ndev);
 int aie4_query_dpm_level(struct amdxdna_dev_hdl *ndev,
 			 u32 *aieclk_dpm_level, u32 *npuhclk_dpm_level);
 int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
+int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
+			 const void *data, size_t size);
+int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.c b/drivers/accel/amdxdna/amdxdna_debugfs.c
index a6ec17c63629..1f63cc91b168 100644
--- a/drivers/accel/amdxdna/amdxdna_debugfs.c
+++ b/drivers/accel/amdxdna/amdxdna_debugfs.c
@@ -126,4 +126,7 @@ void amdxdna_debugfs_init(struct amdxdna_dev *xdna)
 				    xdna,
 				    amdxdna_dbgfs_files[i].fops);
 	}
+
+	if (xdna->dev_info->ops->debugfs_init)
+		xdna->dev_info->ops->debugfs_init(xdna);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 11f4cc53d45f..b27492e2bf8a 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -54,6 +54,7 @@ struct amdxdna_sched_job;
 struct amdxdna_dev_ops {
 	int (*init)(struct amdxdna_dev *xdna);
 	void (*fini)(struct amdxdna_dev *xdna);
+	void (*debugfs_init)(struct amdxdna_dev *xdna);
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
-- 
2.34.1

