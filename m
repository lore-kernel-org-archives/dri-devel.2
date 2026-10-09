Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2788CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D2E112308;
	Fri,  9 Oct 2026 22:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1NUQUXk";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A13112313
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMsOHCxD868A9TwPqLhOHhfw1jbKwRq6HrR1AO9HhDb+rPN4Zd3gWLxpBvxj+OhDGC34AM6DtmnEf4Ljq91e2h5mU01tYTwdI26LVfEB5bIDvdL9OEwQpDE5c3FxpVFIFmiWlMTuABJqmj6eqGprRbXt8FhyfH6Zz0vOmYUUrSvHPwwQ+N50iF99ZZ8MuoCvbWgp/19xW2O0F59hveeQP0ZbEAbMw3VVAQAnLhnYWH5sIkk4hNF7mOmkCZq0AifYzWroqpcvG0zN46l+0iujuxScGKdQPFXIsTQSC5jso767ekUMniw/wnHudrdYFLr7zLdSeDpSCKxslJvzsiOTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=283j9btKHgIE1ocZ4m4zAYvE5B4Uvo5TcF1BAUuYGJM=;
 b=kbocV2zW9h/SMObVyt+jCQILC4UpiBm3uiaT3yn8yFG43RVJHImlRy3WGg+nAlbFaHMddv6SnAcu3IsZrr+Lh3gujq4RkeeilsE9Jhh3jLtOUZoxS8gEXQaUqx9aqGSWg2wVFLMpNU8bCEibnfpeE/a28bFe4HNl8oG0LSoQofzwVczjZKO8yKZur/Pzoo2OajV/oCBBbYSifZYtH6tSI+D3nUZoO3lDjqBDYAZRcn/rIngKMS/Zs9g53fEzOlyGG5ANH/tc8qJjvH9MJxroRdH7TG2kqnEJ0jn8McqoNzpkohpD2e3EEZjrbzY+eN8V0+PcVZJHGCfJu96wdQXqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=283j9btKHgIE1ocZ4m4zAYvE5B4Uvo5TcF1BAUuYGJM=;
 b=C1NUQUXkfh571NLBY5DVKc8e39pKT3ZhrIc8hhPVQj78nxOgWn9rJ8X3m205ZaRIHCVrihDjYFMYempDJPsq98aI06ExHXrBgL2DyO80sEqsulQp3QrcBtmT65LaqABCjE6kehnGZhTnrL2JdNWP7/Ql2ZcLAADv67ME7DPG2JM=
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:53:55 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::69) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 22:53:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 22:53:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:48 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:48 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Soham Donwalkar <soham.donwalkar@amd.com>,
 Nishad Saraf <nishad.saraf@amd.com>
Subject: [PATCH V4 07/19] accel/amdxdna: Add get and set power_mode for AIE4
Date: Fri, 9 Oct 2026 15:53:31 -0700
Message-ID: <20261009225343.3079074-8-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: ded6ee47-258e-47ff-7105-08df2658321d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18092099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: s/kBLUIkGZbKgCNqnJLLJnYbe2T9x7/LoJk5wWjQOGzY2IuzUIK6KDiVzJ8t02s5+5BSOnCdEmj1RlmPihD7Nl3Q9l2xKlmEZb2MPMAkUFKnoKBrs81m8y72rrEIJZrtux8at2vE1t1C638QTRnfggckrp0Z3V8jAPD1cUMvFqEcRQvEoen64cjWP8LTKSTMbKPCfmLbYDWCvwPmiRbHhL5l2sdS41VOuJ3WviKnXkh9rl/tlD0NzsTs/d0y8Y+v+NwASQbsg0tIUKXsuIaudAkr7FE2sfy69+EUmwKCxbp3F2qmeHyQksnzUEDub2gOB5td28qwFxxagwX/gicKcWIrIs8HB/CB5Adm1naG83rUFiftH1GghJSIXndTyl5soaFhT9Z0GyD/4HeqnCHZR2JHhcDqpaOAQ46xAEgf9gzXo1sZJNp2hqvZmhAmJXOM7hyft0DLn3dFklVwHX79bwIi3TIhxFgVIkfA31RXX3uPmlCbh5cRzjt1A3gG5IrEjAWsUDFZcnxxW77yfsQfLawq7k4ZRnZwfGyvOJelQ10B/VhShAsc5dsko4MeCX5jyAw7ZG9NlXKMfV3DNJ+bjejXnPrbRtV3zNz71gEvLyirXW1KDQy19IC4K1e0E7yn/3bpnQTCHSnoTnpNlvQw1Xa3XOeWu6A5j5KGJnnfjItRHGg9bwrEOUU49RUokgHuVcbkznEixiq72elQyeOizw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18092099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0SOyXbyJdwrSCU/OizIglLufMSrH/U3+FV0j4dm3AN010JURROdwR9t8jCiaHuWpxT3ux5KBEPhPkxT44TugR9TZ/iyQaTdxZaXYYOMQilHh/N2hcRnbNjWD0nCaPj3LC8Ek37xRC1pxSGNvUs45navFXO3pkiABLwDa0CyawT24wZAjbOeVRFuJW0vil+4au4DlXc3bS0rKPSY6zUteEOFSHRPAHlih5iSOOfXzpvgM8Q6bfE9780LAyAZIGs5WXKUcWWRewi0aCz9i+aSLZ1+2RdtQblwQZq7xYB1ydDOB4aRgRGhLgB3NEQGGwAdrPtmuQ+odlRsK9a9u2jEEFwOjwCJrLMh5RZLfNon3vTRI8WRqpyaPMLnjQx3KmXSmJW7KzEb7zdu9+7qEOV+p8U7em82odsdWUqEHFQj72viy7n5elUueQxsQrO1vYHC1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:54.9236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded6ee47-258e-47ff-7105-08df2658321d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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
 drivers/accel/amdxdna/aie4_pci.c      | 116 ++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |   6 ++
 4 files changed, 148 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index c83f81a0e65b..8d1cad50cbab 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -158,3 +158,20 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 
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
index 1cbd1665a28f..6eacdc026ec7 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <linux/firmware.h>
@@ -16,6 +17,7 @@
 #include "amdxdna_mailbox.h"
 #include "amdxdna_mailbox_helper.h"
 #include "amdxdna_pci_drv.h"
+#include "amdxdna_pm.h"
 
 #define NO_IOHUB		0
 #define PSP_NOTIFY_INTR		0xD007BE11
@@ -300,6 +302,15 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	return 0;
 }
 
+/* Restore cached power mode override across hardware start. */
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
@@ -316,6 +327,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	return 0;
 
 mbox_fini:
@@ -353,8 +368,14 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
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
 	return ret;
@@ -394,8 +415,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -535,6 +562,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
 	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
@@ -589,6 +617,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
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
@@ -605,6 +651,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
 		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
+	case DRM_AMDXDNA_GET_POWER_MODE:
+		ret = aie4_get_power_mode(client, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
@@ -615,6 +664,71 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	return ret;
 }
 
+static int aie4_set_power_mode(struct amdxdna_client *client,
+			       struct amdxdna_drm_set_state *args)
+{
+	struct amdxdna_drm_set_power_mode power_state = { 0 };
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	u8 power_mode;
+	int ret;
+
+	if (args->buffer_size < sizeof(power_state))
+		return -EINVAL;
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
@@ -737,6 +851,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -746,4 +861,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
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

