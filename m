Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95618606AEFB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wupVDHUP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90ADA10EF61;
	Mon, 19 Oct 2026 16:48:44 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011022.outbound.protection.outlook.com
 [40.93.194.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7F210EDA4
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnJVNYJ1KhZFoaIsYZGtjiILldgfZVomrUO49b/f7YcGV8b3v4+fX8SS7Gt9SDZ3d1Oh//8PuWgbOc1jCklj1mDH/BOQBu9fm0UNKUMusz+7WncD5QywiVHoxhWnWVd93sjl1wtEigg7bRl3O6KkNYovVXqoQ00/sPu5JRnpcc88BNdplE8YYSI/79i4ttcyUbAbdTzlTCtNUL1bRfXOj169+nyqREkBKZTd1oSwUI9Afm9RwnWrd3LopP91GIL6UzGXU1mGq/kivmt+Z7nGZ6psPoED+bj1z1dui7JA2hCZGauSmzGxxyqnjworSFZxrP5BDPWd3dJhrWQVMHWPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2m6QvyAjhvd6gtOta6crp3LcC7XX8GerjDER8LVgKQ=;
 b=i+EiWopABhXvEj4I3cypx8yU5Hx6mIqYmcgZjBZ3Z5EYTwTmuAzyRFZNvGQjWtJIivFmhItJU2H9WNfKDqrJPwSK3mFMUisSMWHPy37RcXAIn3NRsd3ABgQ7G4O3zmYx8XVZsKky2kzUw6+ouR7LZ4P2ChHdQ/C2hw8/sy6rRJgJ6YXLudVYT0FklAjurMxLT0IqsGVm5mHxqBWR9pzJ8kZHlFLQPp72LuXc7QTE8Qqu0EnfxL/CmkvvqtWam04a/K3WXVCAgP0bybLbmwGs4iUwhxx0IIlNBgcXKy0q8hFtauXTeq9VWIr0XX6dkFpO5oqcZ6pVRupu9ZIiGu1Z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2m6QvyAjhvd6gtOta6crp3LcC7XX8GerjDER8LVgKQ=;
 b=wupVDHUPJn8N4UMwNmlNPDwG3KWF5tsuI39z/Q/sl8iCP9kn82QQLQu7EgXnr0ov6+Md2RvS8uX+SG0d8yl1G4917eadmFQfs/oYhypll6ZHH4E4+4RI8iI+C16KFfdiub8dFbPnz087ccknWtHyYU+fPqMKViRFPy612nEEcG4=
Received: from PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::18)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:59 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::5e) by PH8P220CA0014.outlook.office365.com
 (2603:10b6:510:345::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:47:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:48 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:47 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Soham Donwalkar <soham.donwalkar@amd.com>,
 Nishad Saraf <nishad.saraf@amd.com>
Subject: [PATCH V5 07/19] accel/amdxdna: Add get and set power_mode for AIE4
Date: Mon, 19 Oct 2026 09:47:34 -0700
Message-ID: <20261019164746.827277-8-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: debad40a-447b-4d9c-7843-08df2e00bbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18092099006|18002099003|10067099003|22082099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4Z6BYBoBF2abSreAZJlioaDvATltuUmPc/ciim0FzF7+OugKd3hzHN0hAxBo/p9q7W0n9e4kd6lVlJXbP1xkLpcu6U4C6a7PnA0+HwT9DzXD0ZvkiJmn5jbvgoZ+HKgFFVQCFPhmrmQtgCAREgw4iZAdIx7NJVpTbmeS47jHersUGPwzx0lXhQ5lVQ/5+XRLg2beLLlr4orbv0M3mkjYq+BaDuBgxr2S5ytP0aaTHkgdT1ab8Hp5tcQ069hPXKvjVxyxEHsQnJN8AOm/d3fxmrIIeEDO5nKP46C5GdDl8HLs1R4qfGEEVnXaoknsH0u2epSIRFqk3JhRVzn4S8REhhUZMMb4DSWn6KAS/6tsY4xnhesA9Zxksen7j1AuL11xI9d5RBYh5T621+46oDGYcf2Cu+BrF3epjm8wd/NIvgD3pD5DgCyt5LIJxJn78g9R/pgnnFETueso/ee7BSFqNfffTfZRJH5nhcfi7wOivg1TzSs5W7gKO1f/84xunv8/mZmSNFGqda4yC27Bkbk4hQ1sf5srHl7GQTRwbpCcanVXkM6b6WPfdf7x+ojPC/3XtuXY+HtTQYqpiVx8uRQ2PZYin/Us71MNshiDI+KGs/XqH2Iji4DZ/MblxgstGzQEqaZccXEd1ibww6PfHAsl2rQhsca2NvgTg67viEGg/p13Fmkzv+CeHHjzpI9VbVllhHHoGnDjjCP3S43amCIL/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18092099006)(18002099003)(10067099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: upshWoOicSVQfAaMGBp4G0TUO3KOwkXyleRkWm6rApSMBUEu6DfB4rvD0RqNeihxTMMfxLmuas8QESBY5UUHifrS1beRQh3QjjKxVTnvj+GnqyeX/l0ZpUx9JS+rd4ilTdvnpdG8iGDw/BLIqwJzODCGreQSP2JJ7iyzZTs8QBKFnfZYBfuZYmATQHKAjq06ZYYok55pdCprSFuCsLljEOkoETnWMNAutLy4p7YUdDWzTSX/EoMzCyhcKSumTr5mtwnWan5DplATRIQ2R8qmDwR6hcXBgj9wyLUyDqBXG3zMUQprRwolP3rJA1VNvr+ZH+/ppYA8p9fV0uQirkf+7ugefnS2gj9G5mOPBGeYNmoUVNE/5B15V28FYMto9SQMgjw13ckvPglWXMLYWb68xa6Rn6sHLksAnmigYHEx8myBexB+03Ie2W2NP9kJ4RNV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:59.2686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: debad40a-447b-4d9c-7843-08df2e00bbb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611
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
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  |  17 ++++
 drivers/accel/amdxdna/aie4_msg_priv.h |   9 +++
 drivers/accel/amdxdna/aie4_pci.c      | 110 ++++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |   6 ++
 4 files changed, 142 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index c83f81a0e65b..7f25ca58d0e3 100644
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
+		XDNA_ERR(ndev->aie.xdna,
+			 "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
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
index 1cbd1665a28f..39921a06c9e6 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <linux/firmware.h>
@@ -300,6 +301,15 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
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
@@ -316,6 +326,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto mbox_fini;
 
+	ret = aie4_restore_power_mode(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	return 0;
 
 mbox_fini:
@@ -353,8 +367,14 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -394,8 +414,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -535,6 +561,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 
 	ndev->priv = xdna->dev_info->dev_priv;
 	ndev->aie.xdna = xdna;
+	ndev->pw_mode = POWER_MODE_DEFAULT;
 	xdna->dev_handle = ndev;
 
 	xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
@@ -589,6 +616,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
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
@@ -605,6 +650,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
 		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
+	case DRM_AMDXDNA_GET_POWER_MODE:
+		ret = aie4_get_power_mode(client, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
@@ -615,6 +663,66 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
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
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	if (!drm_dev_enter(&xdna->ddev, &idx))
+		return -ENODEV;
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
+	drm_dev_exit(idx);
+	return ret;
+}
+
 static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
@@ -737,6 +845,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_fini		= aie4_hwctx_fini,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
+	.set_aie_state		= aie4_set_state,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -746,4 +855,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
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

