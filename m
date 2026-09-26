Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E89C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21FE10E10C;
	Sat, 26 Sep 2026 01:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oihZ/E5z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89ED410E10C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lms3dPHWx+ArF/+JrvJ8JRLRa3/FzVhY4rGZ6RZVU0TAFa5/OpS6bZMRO2tc8vedd1EZWh5tMUwQSWzFyg5aBuWk3TqgmZMDRr6DZ2kMYV5HX37Fi0PVGbeq9PdNNi2pL2+q7WStBS5L0aUBAo+AxpfGvuESm54Ur1P1DU2+sYUu2KXYSAhGh1slYhfSHJqBrdez/G+fFa6Qs/Q6ZIMqioYWocsCAJLpDU4Au6/pG94TKprsOlPmp3fqTktdGz3rDUHk4Bhr58G1ll1MsrSYJO042/PQ4VUz+ONh6FTZjNej5DH1Y4nBIuyj6b9TOvLvoL0EbJLV6168e/z5uqUc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmSm3h5DBZ8SYXyWzC81HfSDdaT1Kq0V9r2PukTXTyc=;
 b=H98JyaSFLt0a3JXreL1+GSXDifyToHVI16G/0g5LCvPUc+eRurHpWfa5pCOUhcBeYj03X/mHPzLUoHK1/mhlQSKYrmuflKzEFjxjtQ91EveUBUa8MaBhHKoixw0zYSWc0tE7g09tIpK2vmFyuZV4aJyQkWxlp4lEOtew+xTpwBTFqra+tYT17VAApXqD+ZDwMAF5DO2/fmwz0u7xfuGbAP0U0novxK0jY43IxJQNyEO1RFbKIhzbMnkW+qwNJWtmnqEwNVoCUm5os+Vrt/y7TFYM9mYy7B/sIOPP1fL61R+nDmuazxcE2vJ31qngwbgp6nyMkqIHEXWCE9L4zmjUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmSm3h5DBZ8SYXyWzC81HfSDdaT1Kq0V9r2PukTXTyc=;
 b=oihZ/E5zJ1j6B4pZ03md/Jlt4eSlVSnmublt60BeHPFQsFo0Xaa5i7BfSykbVY8DHvy2auChdRL2ZkXS+jbzaR+H683a2k0RNU/1sA6hfGZuOsxgcq9B/2D5LxT0Jv/W8r6cyQYrW5WHeyfp3tSm+AywpoxuYR18x+zeD17tCXE=
Received: from BN9PR03CA0449.namprd03.prod.outlook.com (2603:10b6:408:113::34)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:20 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::87) by BN9PR03CA0449.outlook.office365.com
 (2603:10b6:408:113::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Sat,
 26 Sep 2026 01:35:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:19 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:19 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 03/21] accel/amdxdna: Add CERT firmware version support
Date: Fri, 25 Sep 2026 18:34:30 -0700
Message-ID: <20260926013448.3840921-4-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e428ba-cc88-436c-42f0-08df1b6e6d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: phUkgfyqpMCRzIec7t92q2Pd9vA5asVlLx7zJJn5QVqF4EH/VcCPQyJn2rcy+VqG+YKQzdsW7eqnxedz3XnrJxTdJrwgC+U0o4DxwT70t5pF9g0RZ72N2KYRCfqu84o1s1OQgvVzNUyvxtUQdRiCS160Gqa/f0Gz1L0iVBCa2GWfNKG7QgVJoiBLvGcxE3PrLrarXl+20F45KmdJ8Uu49NztOLj8a1ECSUrC8FhLcZ+Ff7GprLn5TBZ+VQUn5nNy9KCWtSbTJI8EwNXoLmW5B5+HBSjajTRa4OoEeye1gMJVDtEtj4JmzAuMOl5G6iAHznkmAo4JK7s3lKVO8mwr5Uszm6gXschogmL9GLuE+6iSbNQxBI3UBjTHi8IT8iJMMd2E6s+GJ0ZmcceEcPfa9Uwj0aZgiWL3DUGU0BYO03d1IhEQZXjdPQBhQpFZfRHLUaRISBbVsMRRCue3cJlsbble8S2TAQJw7Dz4zacaDJzfcTw34jOSLGt9xGkzDvoKmWmgTXuALGX5spHOWFvnlTNm2Y6uStOEcfUZhqVRffGJNbjyv04P5aRGrlySZnkWCxzhIcvcjc0AHKvb8cJtC6s2NKqwxsdFuoHsSqulc4dsKLIDnFQCUxDdUdrdEyPSR23tZHfz+uG7YNCVifPZgtowM97osKl8zg/lRBAyEhafnIB9lojqh61lWsiLmoVNQIwh8HdRyqvr8iMR/KgBwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u26WcJarSdJEjtcSjWpIGGYZyd66Ii4+0WqYexPcDmQQydNMuMT1m3jr+wW1oA6YMLmEtCuHhleN9cFDDRFjBVU0GZwQHJipyuwzmg+zbP5/E7F4CvgMXOOkhaExBSd2aTmVaKVw292I6BUBhw92p6sAilHbUH+w78TZSAMogCkSkge0N7dYAvvKxzOf5EsWD9uDvdxHRmhiJUpWSQAJRdf+hbpblxgeD1xz6MHiMm8nYzBIqI98FWI4+gL8Hvq3FFAsxYBK3XzP/ddDDu/dw2ZclLZt8OF5lAwpvU2NcevzPtNnlbrDk/4ckCJWhRWP8L22YjvB2PMWMdBfUmTV4USI3OmggyEpz0yuC760/FfhOOjFVdZnIGbCzjRqcZOJNny7OJq+bH2TiPD3XSoJPlXJljhnZhLsLeqcVPpHZh0vPCxNs90b6qcO9PYma0GR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:20.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e428ba-cc88-436c-42f0-08df1b6e6d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

AIE4 platforms run two separate firmware binaries: NPU firmware for
management and CERT (Column Enternal Run Time) firmware for
handling execution contexts and queues.

Add support to query and validate CERT firmware version:
- Add mailbox opcodes and structs to query NPU firmware version (identify)
  and CERT firmware version.
- Unify firmware version storage by using struct
  amdxdna_drm_query_firmware_version across the driver.
- Introduce aie_check_cert_protocol() and cert_feature_tbl to validate
  CERT firmware host queue protocol compatibility against driver
  capabilities.
- Add helper functions amdxdna_get_firmware_version() and
  amdxdna_get_aie_version() to share version query handling across
  generations.

Note on patch ordering:
Introducing CERT firmware protocol validation prior to the firmware 6.0
upgrade ensures host queue protocol compatibility (host_queue_major/minor)
is validated before the host queue layout restructure, preserving
bisectability.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie.c             | 45 ++++++++++++++++++++---
 drivers/accel/amdxdna/aie.h             |  9 ++++-
 drivers/accel/amdxdna/aie2_message.c    |  4 +--
 drivers/accel/amdxdna/aie2_pci.c        | 47 +++----------------------
 drivers/accel/amdxdna/aie2_pci.h        |  4 +--
 drivers/accel/amdxdna/aie4_message.c    | 45 +++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 30 ++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.c        | 17 ++++++++-
 drivers/accel/amdxdna/aie4_pci.h        | 11 ++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h | 10 ++----
 drivers/accel/amdxdna/amdxdna_sysfs.c   |  2 +-
 drivers/accel/amdxdna/npu3_regs.c       |  8 +++++
 12 files changed, 170 insertions(+), 62 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index dd6f36f222c7..01a439c0ccf4 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -65,13 +65,12 @@ int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg)
 	return ret;
 }
 
-int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
+static int aie_check_protocol_impl(struct aie_device *aie, u32 fw_major, u32 fw_minor,
+				   const struct amdxdna_fw_feature_tbl *feature)
 {
-	const struct amdxdna_fw_feature_tbl *feature;
 	bool found = false;
 
-	for (feature = aie->xdna->dev_info->fw_feature_tbl;
-	     feature->major; feature++) {
+	for (; feature && feature->major; feature++) {
 		if (feature->major != fw_major)
 			continue;
 		if (fw_minor < feature->min_minor)
@@ -88,6 +87,44 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
 	return found ? 0 : -EOPNOTSUPP;
 }
 
+int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
+{
+	return aie_check_protocol_impl(aie, fw_major, fw_minor,
+				       aie->xdna->dev_info->fw_feature_tbl);
+}
+
+int aie_check_cert_protocol(struct aie_device *aie, u32 cert_major, u32 cert_minor)
+{
+	return aie_check_protocol_impl(aie, cert_major, cert_minor,
+				       aie->xdna->dev_info->cert_feature_tbl);
+}
+
+int amdxdna_get_aie_version(struct amdxdna_client *client,
+			    struct amdxdna_drm_get_info *args,
+			    struct amdxdna_drm_query_aie_version *version)
+{
+	u32 buf_sz;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
+int amdxdna_get_firmware_version(struct amdxdna_client *client,
+				 struct amdxdna_drm_get_info *args,
+				 struct amdxdna_drm_query_firmware_version *version)
+{
+	u32 buf_sz;
+
+	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
+	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
 static void amdxdna_update_vbnv(struct amdxdna_dev *xdna,
 				const struct amdxdna_rev_vbnv *tbl,
 				u32 rev)
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 0483d582b7f8..899399756661 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -28,6 +28,7 @@ struct aie_device {
 	struct psp_device *psp_hdl;
 	struct smu_device *smu_hdl;
 
+	struct amdxdna_drm_query_aie_version version;
 	struct amdxdna_drm_query_aie_metadata metadata;
 };
 
@@ -96,6 +97,7 @@ void aie_dump_mgmt_chann_debug(struct aie_device *aie);
 void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
 int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
 int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
+int aie_check_cert_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
 void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
 int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
 			 struct amdxdna_drm_get_info *args);
@@ -103,7 +105,12 @@ void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
 			       dma_addr_t *dma_addr);
 void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
 			     void *cpu_addr, dma_addr_t dma_addr);
-
+int amdxdna_get_aie_version(struct amdxdna_client *client,
+			    struct amdxdna_drm_get_info *args,
+			    struct amdxdna_drm_query_aie_version *version);
+int amdxdna_get_firmware_version(struct amdxdna_client *client,
+				 struct amdxdna_drm_get_info *args,
+				 struct amdxdna_drm_query_firmware_version *version);
 /* aie_psp.c */
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
 int aie_psp_start(struct psp_device *psp);
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index f658760c3d48..bae0cc4c3580 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -149,7 +149,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 }
 
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
-				struct amdxdna_fw_ver *fw_ver)
+				struct amdxdna_drm_query_firmware_version *fw_ver)
 {
 	DECLARE_AIE_MSG(firmware_version, MSG_OP_GET_FIRMWARE_VERSION);
 	int ret;
@@ -160,7 +160,7 @@ int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
 
 	fw_ver->major = resp.major;
 	fw_ver->minor = resp.minor;
-	fw_ver->sub = resp.sub;
+	fw_ver->patch = resp.sub;
 	fw_ver->build = resp.build;
 
 	return 0;
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 7a4314ca843b..5dc6e5b97afc 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -205,15 +205,16 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
 
 static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
 {
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
 
-	ret = aie2_query_firmware_version(ndev, &ndev->aie.xdna->fw_ver);
+	ret = aie2_query_firmware_version(ndev, &xdna->fw_ver);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "query firmware version failed");
 		return ret;
 	}
 
-	ret = aie2_query_aie_version(ndev, &ndev->version);
+	ret = aie2_query_aie_version(ndev, &ndev->aie.version);
 	if (ret) {
 		XDNA_ERR(ndev->aie.xdna, "Query AIE version failed");
 		return ret;
@@ -673,44 +674,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
 	return 0;
 }
 
-static int aie2_get_aie_version(struct amdxdna_client *client,
-				struct amdxdna_drm_get_info *args)
-{
-	struct amdxdna_drm_query_aie_version version;
-	struct amdxdna_dev *xdna = client->xdna;
-	struct amdxdna_dev_hdl *ndev;
-	u32 buf_sz;
-
-	ndev = xdna->dev_handle;
-	version.major = ndev->version.major;
-	version.minor = ndev->version.minor;
-
-	buf_sz = min(args->buffer_size, sizeof(version));
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int aie2_get_firmware_version(struct amdxdna_client *client,
-				     struct amdxdna_drm_get_info *args)
-{
-	struct amdxdna_drm_query_firmware_version version;
-	struct amdxdna_dev *xdna = client->xdna;
-	u32 buf_sz;
-
-	version.major = xdna->fw_ver.major;
-	version.minor = xdna->fw_ver.minor;
-	version.patch = xdna->fw_ver.sub;
-	version.build = xdna->fw_ver.build;
-
-	buf_sz = min(args->buffer_size, sizeof(version));
-	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
-		return -EFAULT;
-
-	return 0;
-}
-
 static int aie2_get_power_mode(struct amdxdna_client *client,
 			       struct amdxdna_drm_get_info *args)
 {
@@ -1025,7 +988,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_AIE_VERSION:
-		ret = aie2_get_aie_version(client, args);
+		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
 		break;
 	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
 		ret = aie2_get_clock_metadata(client, args);
@@ -1037,7 +1000,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 		ret = aie2_get_hwctx_status(client, args);
 		break;
 	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
-		ret = aie2_get_firmware_version(client, args);
+		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
 		break;
 	case DRM_AMDXDNA_GET_POWER_MODE:
 		ret = aie2_get_power_mode(client, args);
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 2c7019bd26b5..67971f0c4acf 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -74,7 +74,6 @@ enum aie2_sram_reg_idx {
 };
 
 struct amdxdna_client;
-struct amdxdna_fw_ver;
 struct amdxdna_hwctx;
 struct amdxdna_sched_job;
 
@@ -150,7 +149,6 @@ struct amdxdna_dev_hdl {
 	void			__iomem *mbox_base;
 
 	u32				total_col;
-	struct amdxdna_drm_query_aie_version version;
 	struct aie2_exec_msg_ops	*exec_msg_ops;
 	struct drm_gpu_scheduler	*hwctx_sched;
 	struct ida			hwctx_sched_ida;
@@ -263,7 +261,7 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
 int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
-				struct amdxdna_fw_ver *fw_ver);
+				struct amdxdna_drm_query_firmware_version *fw_ver);
 int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
 			  struct app_health_report *report);
 int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *rev);
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 88037edbb02a..b137a2a40b34 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -64,6 +64,51 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
+int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
+				    struct amdxdna_drm_query_firmware_version *fw_version)
+{
+	DECLARE_AIE_MSG(aie4_msg_identify, AIE4_MSG_OP_IDENTIFY);
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	fw_version->major = resp.fw_major;
+	fw_version->minor = resp.fw_minor;
+	fw_version->patch = resp.fw_patch;
+	fw_version->build = resp.fw_build;
+
+	return 0;
+}
+
+int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
+				     struct amdxdna_drm_query_firmware_version *cert_version)
+{
+	DECLARE_AIE_MSG(aie4_msg_query_cert_firmware_version,
+			AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION);
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	ret = aie_check_cert_protocol(&ndev->aie,
+				      resp.host_queue_major, resp.host_queue_minor);
+	if (ret) {
+		XDNA_ERR(ndev->aie.xdna, "host queue %d.%d is not supported",
+			 resp.host_queue_major, resp.host_queue_minor);
+		return ret;
+	}
+
+	cert_version->major = resp.major_version;
+	cert_version->minor = resp.minor_version;
+	cert_version->patch = resp.hotfix;
+	cert_version->build = resp.build;
+
+	return 0;
+}
+
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
 {
 	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index af0866045b91..5b97c8057de0 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -10,8 +10,10 @@
 #include <linux/types.h>
 
 enum aie4_msg_opcode {
+	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
 	AIE4_MSG_OP_SUSPEND                          = 0x10003,
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
+	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
 
 	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
 	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
@@ -30,6 +32,18 @@ enum aie4_msg_status {
 	MAX_AIE4_MSG_STATUS_CODE = 0x4,
 };
 
+struct aie4_msg_identify_req {
+	__u32 rsvd;
+} __packed;
+
+struct aie4_msg_identify_resp {
+	enum aie4_msg_status status;
+	__u32 fw_major;
+	__u32 fw_minor;
+	__u32 fw_patch;
+	__u32 fw_build;
+} __packed;
+
 struct aie4_msg_suspend_req {
 	__u32 rsvd;
 } __packed;
@@ -132,6 +146,22 @@ struct aie4_msg_aie4_tile_info_resp {
 	struct aie4_tile_info info;
 } __packed;
 
+struct aie4_msg_query_cert_firmware_version_req {
+	__u32 resvd;
+} __packed;
+
+struct aie4_msg_query_cert_firmware_version_resp {
+	enum aie4_msg_status status;
+	__u8 major_version;
+	__u8 minor_version;
+	__u8 git_hash[41];
+	__u8 date[11];
+	__u8 hotfix;
+	__u8 build;
+	__u16 host_queue_major;
+	__u16 host_queue_minor;
+} __packed;
+
 #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
 
 struct aie4_msg_attach_work_buffer_req {
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index db02d25e3f4a..3cb81bc1b627 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -271,7 +271,22 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 
 static int aie4_query(struct amdxdna_dev_hdl *ndev)
 {
-	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	ret = aie4_query_npu_firmware_version(ndev, &xdna->fw_ver);
+	if (ret)
+		return ret;
+
+	ret = aie4_query_cert_firmware_version(ndev, &ndev->cert_version);
+	if (ret)
+		return ret;
+
+	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index c6219544dc0f..8c62ee6a9b23 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -57,6 +57,13 @@ struct amdxdna_dev_hdl {
 	void				*work_buf;
 	dma_addr_t			work_buf_addr;
 	u32				work_buf_size;
+
+	struct amdxdna_drm_query_firmware_version cert_version;
+};
+
+enum aie4_fw_feature {
+	AIE4_HSA_COMMAND = 5,
+	AIE4_FEATURE_MAX
 };
 
 /* aie4_message.c */
@@ -64,6 +71,10 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
+int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
+				    struct amdxdna_drm_query_firmware_version *fw_version);
+int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
+				     struct amdxdna_drm_query_firmware_version *cert_version);
 
 /* aie4_ctx.c */
 int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 84c8973e9197..0002e6ef32ba 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -99,16 +99,10 @@ struct amdxdna_dev_info {
 	size_t				dev_heap_max_size;
 	const struct amdxdna_dev_priv	*dev_priv;
 	const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
+	const struct amdxdna_fw_feature_tbl *cert_feature_tbl;
 	const struct amdxdna_dev_ops	*ops;
 };
 
-struct amdxdna_fw_ver {
-	u32 major;
-	u32 minor;
-	u32 sub;
-	u32 build;
-};
-
 struct amdxdna_carveout;
 
 struct amdxdna_dev {
@@ -120,7 +114,7 @@ struct amdxdna_dev {
 	struct mutex			dev_lock; /* per device lock */
 	struct list_head		client_list;
 	struct mutex			client_lock; /* client_list */
-	struct amdxdna_fw_ver		fw_ver;
+	struct amdxdna_drm_query_firmware_version fw_ver;
 	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
 	struct workqueue_struct		*notifier_wq;
 
diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/amdxdna/amdxdna_sysfs.c
index d9e359ee8182..e20b7fb1e5d1 100644
--- a/drivers/accel/amdxdna/amdxdna_sysfs.c
+++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
@@ -37,7 +37,7 @@ static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr
 	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
-		       xdna->fw_ver.minor, xdna->fw_ver.sub,
+		       xdna->fw_ver.minor, xdna->fw_ver.patch,
 		       xdna->fw_ver.build);
 }
 static DEVICE_ATTR_RO(fw_version);
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index 8d287ef32fff..31208c42ad5f 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -42,6 +42,12 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ 0 }
 };
 
+static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
+	{ .major = 1, .min_minor = 0 },
+	{ .features = BIT_U64(AIE4_HSA_COMMAND), .major = 1, .min_minor = 0 },
+	{ 0 }
+};
+
 static const struct amdxdna_dev_priv npu3_dev_priv = {
 	.npufw_path             = "npu.sbin",
 	.certfw_path            = "cert.sbin",
@@ -85,6 +91,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_pf_ops,
 };
 
@@ -96,5 +103,6 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
 	.dev_priv		= &npu3_dev_vf_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_vf_ops,
 };
-- 
2.34.1

