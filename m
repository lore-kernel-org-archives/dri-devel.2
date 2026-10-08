Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C670CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85AC110FC04;
	Thu,  8 Oct 2026 03:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1T6x10Re";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942BD10FBFF
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvXZ2Mu55lN7YTjryMWkHiEa/rEvGOacV43zrslMV2lOaC0X1r/zmvQegZZZmmpH+IAo8boFRdlBfxrhnqzhzCujUgkGR3Vc7MzWqJJlxL5BeS6PT/G8GnO/cIQdaHAvTwRSLc4FHFUm0sXwSRFfpspwFSA3cw/PC8wYG/eGrD1N9HQ4Ke7bkbCuMYdcG81rfVnNRZrIT78YaW6vSOUedrVwz90LtbmZd3UvifCRf5fG8RrMB5PD6guqbW9l4XPg96+XdbRPO8zSGBaSlCAxlaKNevjfbsA7zPPorgfkMZglnkI/Z5hbW+Kn8RHNbSkCnVENpGSbEqd9ZJiEHIKtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ffJAG02Lm5IYMWSmVui23zwP/TI0oJjoVZ1dVPVAKc=;
 b=mRrNW08LMHgvEGwKXIVTQtC3brvbh5bu0QspuTzk9DAwO0pNCca5CvJvFfzeMm8ZpGkRfCGtxsc203fAyJbeLOmZvbAo1leLII4LLKSYF34htM5o9AdzxPyEu1ADN/hhzLOi5HxvvdoGG3Wtpay0uvuQlE7L6YL0cS0iQQt1/UIxVqeH267A27t+OZfyaK/gu5V1x85XczDluPGYT3VpvcO0VXjnu0o4LHgcFFLR9166bkqKCFBZPXjEjkstISG+YkZTnDmOp4PhcK1+WfTeGtFu2uRiq8Q9JcjGibu2QmU2OChQW6AE7FSuHrOanvJObXoP8WU8atVVm6IkV8v5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ffJAG02Lm5IYMWSmVui23zwP/TI0oJjoVZ1dVPVAKc=;
 b=1T6x10ReTIKo0DVB75dxW21BS57uXhqQDhLSLYq28spZ2h8Z6dXGHRwAkarbf5azM07Vnd472KZcxvGoi6YKMrBr4ZxTe/ZHbwZeZIcbg/wWb2Z66BDDrmGV5xGI05YSBRQI1LHiU+9WzBHoe6m6+PjNruhfUgtlaALzPsAVVsc=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:24:03 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::a9) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 03:24:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Thu, 8 Oct 2026 03:24:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:00 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:23:59 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
Subject: [PATCH V3 06/19] accel/amdxdna: Add AIE version query to aie4_get_info
Date: Wed, 7 Oct 2026 20:23:35 -0700
Message-ID: <20261008032348.2044667-7-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee5055a-368d-435b-ba7e-08df24eb9a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dcseEFlXyLTj3xrWgpBeL7MItu4Ec6INU2wpjen3sTMEYPqGIzQfTY/SSaicpboE3TFvs9pNlcSmWm15bo4b+nECEN5rcn5kAW8HzoPq91i/kVdOZZd+3eOQJ6EPaOMzgT1GNP5zdhcBmrm+s4+RXHf1j/rC3LW5jNLKDtoNekk41mdGpZadpbNG0g1KpYhDvKeRoXfUSSwBNXkU4HV1J07FzKLwfuK9N5LqiwnijSWcgqCt6A80u+eIOwC9TishCZmU7D2y9fkTbcM547hBt0EjYcAUFaC7fJUAhNwQba8HpJxIQlHvmCz+0VWypAx741cICpEpwXBR79WLQ0Qp0HAAwdIQ+vL+vg9WOUjdp4HfHp8HWBFNKL/K/TB2NRB8EMEWJ35IOqKO4LTiBobpfdN6dGPlAuIuoMF0lTaQuZG4zhMBkdXx5LNeNbLLtRcTqNAVzCyh1eHyOxn2L/TuCUAmh+IK+xe6bmSvH2kbOPKxb/7/xnw0lVnkI3JTUKNKvhgJH1ZQj1bvUNHGvpytj1j++52ZOUzh77rd61gRUvzsPcZRZg5K7in47nMhrQNWWhAi5nZpJxBP+Qd1lN8QodQ+y8ADciQHWlZjrrSHrSDV6FXHXINaYI3jtx/0uVf7WcSv4WYZOZeamMGGGjPCyz6kxiLyFkcWblmM7fz8AAp6e2vbxrFyZVvljwxsugSOKxfKEcoUPuyTwx9yTY/QEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E/gqC1t7c49Vvi79D+tc4hjEusVVA5pvazDO80HEiiSIqUc7gmgqVKOAycKAs2YMbJTl4JMhx7X2B0OQp26ma8Ugsw8VYi2B2d8t3ON/XjJ8bXSndEXb7BXrEpgxNhcpKxPqX65YouWhC8xO0FmOhXveoNPOw/EHHa4SdjJLCJ5Q8szQFTM/QvecnuYpY9idn9WCJ/az6+pBW9Ie3M6/u3DsjUycRDv5Ogdd7JD1uUOZTTaftDIS9OoCucWhktC+8Ffc0JNUq6PHqswQnWn60mddkEiZxbi5gQFPiCRP2jR/k++ETqdZepg51bqZK/pyFCItxe646CiL8GHSFGZW0hB9C3lD/dTHSSzM3nI2AGSFFC/zpKqF9z2JCXMth+lr0d8EE2iHAOcg/BYR/1N6OkjxZczrZNt7y7A/a1H90Rquv6mj+b55O0Cnx2k54JXC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:02.8536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee5055a-368d-435b-ba7e-08df24eb9a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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

Add AIE version query via DRM_AMDXDNA_GET_INFO. The NPU firmware
version query already existed internally; it is now also exposed
through this ioctl alongside the new AIE version query.

These versions are mandatory once released, the firmware management
interfaces must support those queries in their stable version.
Propagating any failure to abort device initialization is intentional.

Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_message.c  | 20 ++++++++++++++++++++
 drivers/accel/amdxdna/aie4_msg_priv.h | 11 +++++++++++
 drivers/accel/amdxdna/aie4_pci.c      | 10 ++++++++++
 drivers/accel/amdxdna/aie4_pci.h      |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index bdbd1d116b61..4814cbb1f2c5 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -75,6 +75,26 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
+int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version)
+{
+	DECLARE_AIE_MSG(aie4_msg_aie4_version_info, AIE4_MSG_OP_AIE_VERSION_INFO);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		return ret;
+
+	XDNA_DBG(xdna, "Query AIE version - major: %u minor: %u",
+		 resp.major, resp.minor);
+
+	version->major = resp.major;
+	version->minor = resp.minor;
+
+	return 0;
+}
+
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
 				    struct amdxdna_drm_query_firmware_version *fw_version)
 {
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index b9f7c61f36e3..81842fa1d6ce 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -22,6 +22,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
 	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
+	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
 
 	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
 };
@@ -160,6 +161,16 @@ struct aie4_msg_aie4_tile_info_resp {
 	struct aie4_tile_info info;
 } __packed;
 
+struct aie4_msg_aie4_version_info_req {
+	__u32 resvd;
+} __packed;
+
+struct aie4_msg_aie4_version_info_resp {
+	enum aie4_msg_status status;
+	__u16 major;
+	__u16 minor;
+} __packed;
+
 struct aie4_msg_query_cert_firmware_version_req {
 	__u32 resvd;
 } __packed;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index d8c26655dbfd..d6faafb70315 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -288,6 +288,10 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
+	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
+	if (ret)
+		return ret;
+
 	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
 	if (ret)
 		return ret;
@@ -594,6 +598,12 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
 	case DRM_AMDXDNA_QUERY_AIE_METADATA:
 		ret = amdxdna_get_metadata(&ndev->aie, client, args);
 		break;
+	case DRM_AMDXDNA_QUERY_AIE_VERSION:
+		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
+		break;
+	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
+		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 940e67347d74..5ae5e8427a3b 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -69,6 +69,8 @@ enum aie4_fw_feature {
 /* aie4_message.c */
 int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
 			    struct amdxdna_drm_query_aie_metadata *metadata);
+int aie4_query_aie_version(struct amdxdna_dev_hdl *ndev,
+			   struct amdxdna_drm_query_aie_version *version);
 int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
 int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
-- 
2.34.1

