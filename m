Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E2C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC35910FD06;
	Sat, 26 Sep 2026 01:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ojOPRuad";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B182D10FD00
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xexlDfgZlQ//nngDtIIkIvKYVw9qotBMPBS1Ol7VP5Ng2ik9xFjYstyo7j1gxYnbY+VQjGfUSg/NajUnCdeGFR10sB9Vkb2KpFIC8wc5K2N/ESS5FyCrxHEUhc1k8sL9lHpF9P3cmpPKAuIE2tf7UExrheNXKcvzODSD+78xssnUWoWVzbpkNDGfpugVEJDLvbgVYjj7x3MS986/cvMTLl8h9PTHX8WDuKVA5d9/pd/UWea+yVg977/YwJgcsyd0wiP48f5/ZPgy12/20wTjfwouW8mt1zpYs7pOmCxntVElbgb5cVQw4B8PlYxOwT3XZljyz2rrK0WjMnUqDDfoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGBRyLarvyowaxbWeVHcMKmkVyH/YRvhxLhZETMarOc=;
 b=iwzgnV5m83grmyCixTdxvQXXGR+wUfc7a9cRMGqI2SgaIRF8sF4H6Ja6sc+QEarXhqiQJ/zBQg3s675RtF/WbOzE604BuY9DCk0m+EpyHeRObdW67WP0CR3AWHulGnzVQAuUBbim+K0++6MslRs647EBjlYkIPU1l9YiIePDLJyXB1TTk11Vw8SvHEatJR2R6m9WNr+UdOV460WPKKA+IfLdb5Qm2a+FMoYd9sLmPCjIKY7EMgZZPUkYLV10Z9pS6gNMaHhHG0FsnPIYOAaLGZ7edkSjJzZyxKJNJQ/boK5RUtooAVoJRbFe5O09KpL7r9/a2q8y+VAB6ECeKymN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGBRyLarvyowaxbWeVHcMKmkVyH/YRvhxLhZETMarOc=;
 b=ojOPRuad2HjjTMWsbW0PPK6xsVG2r7bL5b02MnWfnUjDwtkpI/gxSDbYQdatCdhUtXEtAFzW3ZU2lRoGcJdMyLJeKz2bKKFf9A4hRua4WvX9/b8QKk8Lr+6JI6dWIvG+BiIdAyREj6wkrp342eWUkFkACfTraT8Zmdc0mybYe/c=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Sat, 26 Sep 2026 01:35:25 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::ac) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 01:35:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:23 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:22 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>,
 "Soham Donwalkar" <soham.donwalkar@amd.com>
Subject: [PATCH V0 07/21] accel/amdxdna: Add get and set power_mode for AIE4
Date: Fri, 25 Sep 2026 18:34:34 -0700
Message-ID: <20260926013448.3840921-8-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d74fe1c-646d-402a-7f4a-08df1b6e707a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /7ApYPIsu06XdnmYg1XU6venXgASD+ubv1oINiZaK580k1kKiUjmvDQphFgfUc9Hk+xabICOdE5Hs3czD0FGWlmHlNy1S5JD8TF9OLl8sLXFl/5elyI3iSvUAMvuhCIn0CMxbLEPeJVTipBAVunNvdSxva0TAltSI4kd1GSj+BoAGx2yshMzWTBvJkjwQCVWN1Waaqnqb2vqW13KVTTWnu0c/fMCE5Wu/bVYxyXz1/8O4x8hlw8ywaBMs10shzWH3nx4D16AWixR+FTRmFrjG2iKvXzM8j4eOB0DrD47yeo9/Y0wJj7NKbkTcXf/k369O9teyHBPypepc7xny3sO+g8O5qweItKKgxl/yu+yI4rxzOPTo9aDbhuvZe0mUN3FmpZYnl03ImqySiIpBuWHi48cPLen8cC9zoOEU/qgq7rj2SKwU1dOpO3j5j55F/QtplRaF6GIzLfMjW9B+eFnw0f6YanZe/wxK2/xnwp0+qD8X4XpLkpT32Vh7rhUiZHqsH/zJEa6oO/+GXB838ukgNfohApjSS5awfIWzKl97B799GgT2gHBo2sU14+CXp0Pk7KSOKiwxtHb8yMHuzDEKpFBdVYBFuDabXk982Znp/U0zEDN/kdj4iDkq18b81h8KQhNuAuiuaiqZCFyfJ4Dtp1uAR6vbhZkyiqbTfdR8WgElJrsbSt6OFHS5WD3gCQp7rfV9MDcfVG1s2pfO0yiNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OfoWJIbgATw4GaXw5FXhdrCwrRwKzyCt+jd5yG9zLVme0CxHNV0SYBkD1cuX0cDQUjAoknZRhgm4UJzcRmiZq8IGtovz6/+OiX66puM6zmyaZCqGmjE+enlMQHBSCZS2jGyKkCcmbruCqD8eNTjog0obZ4YdV5X+bjGLXQR3w2Yj/Vp56d4n4BrHhOFnqSW5YfcLpz9wYtr1SfWfNL/Rb1Yjz3daO2YxXmylOqCS2Mqdi5bXGbGxmRnOnogusVShSaazt7c1NGHY/fqToQd8XSfdrcykvGec/t1nJ2f/sylBjvlZ0J+TmRBZJ6SPQ0ldQN2/+zMl8vhTsy75dP1aneAaopD9wonkjcd/274hEImNOHNkiHfn9uBihTStf2LlF1qJlYI3UYyqVaK0C4jeSFIwn3oK+ojp5VjSh1WZTUkc+woBCRQlU4pbtEWgO2pd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:25.6902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d74fe1c-646d-402a-7f4a-08df1b6e707a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

Add power mode support for AIE4 devices via DRM_AMDXDNA_GET_INFO and
DRM_AMDXDNA_SET_STATE:
- Add AIE4_MSG_OP_POWER_OVERRIDE mailbox message definitions and
  aie4_msg_set_power_mode() helper to send power mode commands to firmware.
- Support DRM_AMDXDNA_GET_POWER_MODE in aie4_get_info() to return the
  cached device power mode.
- Implement aie4_set_power_mode() and aie4_set_state() to validate user
  input, send the override command to firmware, and cache the mode in
  ndev->pw_mode.
- Wire .set_aie_state into aie4_vf_ops and aie4_classic_ops.

Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  | 14 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h |  9 +++
 drivers/accel/amdxdna/aie4_pci.c      | 88 +++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  3 +
 4 files changed, 114 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 17cc335f0656..a7025995d0e0 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -156,3 +156,17 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 
 	return ret;
 }
+
+int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
+{
+	DECLARE_AIE_MSG(aie4_msg_power_override, AIE4_MSG_OP_POWER_OVERRIDE);
+	int ret;
+
+	req.power_mode = power_mode;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 81842fa1d6ce..4c06792df1bd 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -23,6 +23,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
 	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
 	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
+	AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
 
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
 };
@@ -187,6 +188,14 @@ struct aie4_msg_query_cert_firmware_version_resp {
 	__u16 host_queue_minor;
 } __packed;
 
+struct aie4_msg_power_override_req {
+	__u32 power_mode;
+} __packed;
+
+struct aie4_msg_power_override_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
 
 struct aie4_msg_attach_work_buffer_req {
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index aea3edd51b4f..3a063d3ffa94 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <linux/firmware.h>
@@ -15,6 +16,7 @@
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 #define NO_IOHUB		0
 #define PSP_NOTIFY_INTR		0xD007BE11
@@ -528,6 +530,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
 	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
@@ -582,6 +585,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 	return 0;
 }
 
+static int aie4_get_power_mode(struct amdxdna_client *client,
+			       struct amdxdna_drm_get_info *args)
+{
+	struct amdxdna_drm_get_power_mode mode = {};
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev;
+	u32 buf_sz;
+
+	ndev = xdna->dev_handle;
+	mode.power_mode = ndev->pw_mode;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(mode));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
 {
 	struct amdxdna_dev *xdna = client->xdna;
@@ -598,6 +619,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
 		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
+	case DRM_AMDXDNA_GET_POWER_MODE:
+		ret = aie4_get_power_mode(client, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
@@ -608,6 +632,68 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	return ret;
 }
 
+static int aie4_set_power_mode(struct amdxdna_client *client,
+			       struct amdxdna_drm_set_state *args)
+{
+	struct amdxdna_drm_set_power_mode power_state;
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	u8 power_mode;
+	int ret;
+
+	if (copy_from_user(&power_state, u64_to_user_ptr(args->buffer),
+			   sizeof(power_state))) {
+		XDNA_ERR(xdna, "Failed to copy power mode request into kernel");
+		return -EFAULT;
+	}
+
+	if (XDNA_MBZ_DBG(xdna, power_state.pad, sizeof(power_state.pad)))
+		return -EINVAL;
+
+	power_mode = power_state.power_mode;
+	if (power_mode > POWER_MODE_TURBO) {
+		XDNA_ERR(xdna, "Invalid power mode %d", power_mode);
+		return -EINVAL;
+	}
+
+	ret = aie4_msg_set_power_mode(xdna->dev_handle, power_mode);
+	if (ret)
+		return ret;
+
+	ndev->pw_mode = power_mode;
+	return 0;
+}
+
+static int aie4_set_state(struct amdxdna_client *client,
+			  struct amdxdna_drm_set_state *args)
+{
+	struct amdxdna_dev *xdna = client->xdna;
+	int ret, idx;
+
+	if (!drm_dev_enter(&xdna->ddev, &idx))
+		return -ENODEV;
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		goto dev_exit;
+
+	switch (args->param) {
+	case DRM_AMDXDNA_SET_POWER_MODE:
+		ret = aie4_set_power_mode(client, args);
+		break;
+	default:
+		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	amdxdna_pm_suspend_put(xdna);
+
+dev_exit:
+	drm_dev_exit(idx);
+	return ret;
+}
+
 static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -730,6 +816,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -739,4 +826,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 5ae5e8427a3b..98b637279257 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -58,6 +58,8 @@ struct amdxdna_dev_hdl {
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
 
+	u8				pw_mode;
+
 	struct amdxdna_drm_query_firmware_version cert_version;
 };
 
@@ -77,6 +79,7 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version);
 int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
 				     struct amdxdna_drm_query_firmware_version *cert_version);
+int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
-- 
2.34.1

