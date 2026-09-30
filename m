Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE00CC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6A810F169;
	Wed, 30 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHwN6leK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A62110E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLxQl0CVSLdy2P9iQNYUJcoOvEIpAe6fqodUH0a04HlW1AKNtxWmK2+k7BS+IsFsgveQ62p2y3FxFLMsR0o7d6pp+4VVH72mKUzZxHKNhVm8Km8gwsJTHLhnfnYpSyHLCpKwwO/HV8qORoWCWZrQ1DolrbDf3B7Zt8qLybub4b24PCbjFdblkicst/UAK2WxVkj77GqLdt2lEz8DGxMbIxZaSNC/0MJbDNKY8oCPKXDb9jWjngVocMWKTzL62zl6x/11qN1NZa0voIQXhn5DRsT1zAaHqip/VRk7ROZf/jwHVR1WUviRLqYiCmYta2Zla5vdEl6kRHh1Z+CGpQxpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EhjygG1II/BhuzYlChwr9P0ZOXrKk+OBuVl+qd4+I8=;
 b=YSIexCBq+FJSFiHMqxGF/c+zCUIC2TdzRB4A1pZEq1qVVFLhfWUPYWd6NI87GLjwtqLFFXAJTEKjdRXBh4d6UH1TBrdKSUh9Fx7iAEYS9wJ4nmH4zbli05pS9uuzXat0M8jhzJV8Y1q6DNr6ov7/lJ/9SnQ/i68NG5mtniM0Wzjm5f4DbpM5pJnBVJWRsJi1Q3mlMehLL8ITxS+Ql1+VIftB+NsLVrtLNbrubIyrteRmE4cTd3KHoZjYInzoakUUSGdnST1acOiW/dLXVCrUeVUZpSSp5MYUo97GvsXShDbFmFtZnm8mnhnLGgNbc8t1MOAL0GNI9yiluyIxh7Yz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EhjygG1II/BhuzYlChwr9P0ZOXrKk+OBuVl+qd4+I8=;
 b=xHwN6leKpBTPlHcubNakxwch9q9T5/lWWvy8o7ks7XgomLrCklYT1EOwXFC+33fZgoU2IquHem3GhH4YYRcXI1w0SsQ8PoFUFRl7zgl66DmsVp8jMQf4hec2cP/6XG+Zq9CK0K7ntdF41ajFksvnVYA208TpqcKSNInh9JlV0TU=
Received: from DS7P220CA0114.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::7) by
 DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Wed, 30 Sep 2026 03:32:56 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:25f:cafe::b) by DS7P220CA0114.outlook.office365.com
 (2603:10b6:8:25f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 03:32:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:55 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:54 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Soham Donwalkar <soham.donwalkar@amd.com>,
 Nishad Saraf <nishad.saraf@amd.com>
Subject: [PATCH V1 07/20] accel/amdxdna: Add get and set power_mode for AIE4
Date: Tue, 29 Sep 2026 20:32:20 -0700
Message-ID: <20260930033233.1727265-8-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed5ce70-2271-4275-bb00-08df1ea384af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|56012099006|3023799007|18092099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 3p0Ce6JHPgdHji3wqj+NlaSctqJxb3MnxMyDhjlAVJAm34nCI6HY3hW4jyU6MSWwAwdpvm3z38xq+5WkxIZVMYxU/sg2mc/EoUyfzet6mY3sBhCUCEdlRBB+TmZ3np3+l8+6mKtAWm3YvKfSvNMhT+xYBSRIxO5xK+QnotcKRDogBzIMfFxv7uWuIRXadO9lHERRjfTr2ciUFWjSIOxrvuqz2YoTBgIhtfzMFCEXxx27iEIELMN3vvrar/gcNWFHH3fzzOTZwSaQ731/yk+aeK0s8khOTcMXHQhRxtJgCrBA2CuCycOA0LDNzcHLWyYXOok7te4gEreROoLtluH//+8Xim4DTUsFaVcmXPUWXIUysYynmcs85sYlpqJ/V0Ewbq8mJrnB8ybow5m9UzIoEhZRbRrJ8rXZ6ZC7dEqS3x8MrkLD2tKmFHFW7HKhA+zx5CaSnAbi5eQ8v+FlMxeUkGw+2T8iaXCDK55ciNw8sMZwSis+F+I667ypTKQkvd6Vv0jsOdyFTl7EosnAExPCXdBXq+5zxGCpz0wgux1JMS04R9yBjn5sat9wCME0ePILWusp8h102TH5SuFoEqmZp85VThWUnV4mzUz3k5JCLgSIqIYnFK5C3wL4iRsHw4UJMrzjwUbg5ZHqhz47CZfZXxTOlT6HRAhSjXasdxDcV0NKckGA+hAjXznbddXpskePlXzZ98nkvZKT2hXR+P1aVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18092099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b4/8KPbOBZ/FsnrfZ4uRidC2idbcQ1KNMXL7UNlplpeZCweplYqo9PmZFWkM9rrIgoxT2BDT/QxeiXl6cwgYfvuquz89OU5X8wcaxve4Cm1OQd2udVASm0CqMPgdkxHb9K9L0E+DEwoTfRuQOF1MS6j0tpj1KHNTMdaVO0IDHoglCGSXGba03xyWvv2924Gl4WRboFXScjYjAVxwrvXFReOukrsyPHczWp44u1KIh/pW3JcdM1pOjDJHYNU4RgL14DpifgRCDYyBcVoWhoNDQ4F9HZwFG08KjzrURcvmw7XMGYM3FBeClMk6iW4DbvXcGaW1Q031NLDS4Ky3FYZMXIJJ6QCrcd3wnFyfSpFs0bM6X3JBy7aHCinwaDeQMT66RCEkNiLv7R0FN+C87aU0q9t6Abn260oQc5mQ4PcEL2UY/VuNWjq50Am1j5PslL1V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:56.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed5ce70-2271-4275-bb00-08df1ea384af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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
- Add AIE4_MSG_OP_POWER_OVERRIDE mailbox support
- Add DRM_AMDXDNA_GET_POWER_MODE support
- Implement aie4_set_power_mode() and wire .set_aie_state

Firmware boots in POWER_MODE_DEFAULT after a reload, so re-send the
cached user power mode override whenever the hardware starts via
aie4_restore_power_mode(). On a fresh probe, pw_mode is
POWER_MODE_DEFAULT.

Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
Co-developed-by: Nishad Saraf <nishad.saraf@amd.com>
Signed-off-by: Nishad Saraf <nishad.saraf@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  |  17 ++++
 drivers/accel/amdxdna/aie4_msg_priv.h |   9 ++
 drivers/accel/amdxdna/aie4_pci.c      | 124 ++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |   6 ++
 4 files changed, 156 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 4814cbb1f2c5..25a510bd7419 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -157,3 +157,20 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 
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
+		XDNA_WARN(ndev->aie.xdna,
+			  "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
+	else
+		XDNA_DBG(ndev->aie.xdna, "Power mode set to %u", (u32)power_mode);
+
+	return ret;
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
index aea3edd51b4f..d11bdbf16881 100644
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
@@ -293,6 +295,27 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	return 0;
 }
 
+/*
+ * Firmware always boots in POWER_MODE_DEFAULT after a (re)load, so re-send the
+ * cached user override whenever the hardware starts. This keeps the driver
+ * cache (ndev->pw_mode) and the firmware power state consistent across
+ * suspend/resume and runtime PM cycles. On a fresh probe pw_mode is
+ * POWER_MODE_DEFAULT and this is a no-op.
+ *
+ * Power override is a per-VF property in firmware: each supervisor (VF) stores
+ * its own requested mode and the hypervisor arbitrates globally by taking the
+ * highest mode across all supervisors. A full firmware reload on suspend clears
+ * every supervisor override back to default, so each device type (PF, VF and
+ * classic) must re-send its own cached override on resume.
+ */
+int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
+{
+	if (ndev->pw_mode == POWER_MODE_DEFAULT)
+		return 0;
+
+	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -309,6 +332,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	return 0;
 
 mbox_fini:
@@ -346,6 +373,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mailbox_fini;
+
 	return 0;
 
 mailbox_fini:
@@ -387,8 +418,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mailbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto partition_fini;
+
 	return 0;
 
+partition_fini:
+	aie4_partition_fini(ndev);
 mailbox_fini:
 	aie4_mailbox_fini(ndev);
 stop_fw:
@@ -528,6 +565,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
 	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
@@ -582,6 +620,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
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
@@ -598,6 +654,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
 		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
+	case DRM_AMDXDNA_GET_POWER_MODE:
+		ret = aie4_get_power_mode(client, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
@@ -608,6 +667,69 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	return ret;
 }
 
+static int aie4_set_power_mode(struct amdxdna_client *client,
+			       struct amdxdna_drm_set_state *args)
+{
+	struct amdxdna_drm_set_power_mode power_state = { 0 };
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	u32 buf_sz;
+	u8 power_mode;
+	int ret;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(power_state));
+	if (copy_from_user(&power_state, u64_to_user_ptr(args->buffer), buf_sz)) {
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
@@ -730,6 +852,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -739,4 +862,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 5ae5e8427a3b..fd2c50dc8080 100644
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
@@ -84,6 +87,9 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
 int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
 
+/* aie4_pci.c */
+int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
+
 /* aie4_sriov.c */
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
-- 
2.34.1

