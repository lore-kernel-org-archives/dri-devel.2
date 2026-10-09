Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA3CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60CB1122E4;
	Fri,  9 Oct 2026 22:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLKBTSQ4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DE410EB64
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKQkALf3y3bCOTKKmJy1bWednObximDDzWTTfDUSv6CNtELZNCtNiCr+0KXTrYXtLvYch5uKpMmH1t8oIsKvCJxHZo/ZcVzOc2AKNxxOJCa7kb/YAQxWcc1kzqFU7trdaAm8NE9epqzX7ChN7rten9yXacmoWLvWdEVLbqmdjLHMp0YqLt4sZLhJKr7kN54SKK1o0opUF1zMuvhP6O/J6Oe9HypbUpKlLDRSsccsE/cY6x+kxuY9fdaaIesR2MrUEK19k5R4OP0an3PLypebYtT2bTQm95yyKBsTKfOwc8O0bjg3lGvk2L/4GUz+0Bxiww00uXLzCeu4dJKPXQ9p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg669wYDEB1TKOkSIwZ/CWEl5KtiNIuBLxFMyawL1yQ=;
 b=Ygjwtja97OmZdIbdQ5idkncqTtOHZWeSjeTJCA/8uj2KuXp3NeEaSZjQm8eCjTajoQ7aCLzqOH7GnCH2eHwa20yPOceNB14EeoGwcM9x6tUkHjTKhZ5q4bZnfaggQ0naPvnpD/rKVBAqjd9t0LllAGtAAj8ADX/Q9mvv25Rb2LV258EH9wSahnQjNarl8iBvR0l1/41dIzy3JJNOs9cyserMXiyqoHsOP6mdmZDQKB7At22YemeXNarW5FiD5GY4jf0SXIJ8OTfOk/fFZnXucPLDZoLz5Zk9kBdvGyBbiU1aqebB3m5cebJzeEYOV/7x9TrqEyP/ZDsUIUEOhyOM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg669wYDEB1TKOkSIwZ/CWEl5KtiNIuBLxFMyawL1yQ=;
 b=iLKBTSQ443aIXoA4huh4os2+xOb8FEfMVwg3yuc6+lAjeaiqqy4wTGLahjXc49Lj63WSSC7MrQ7QO9sP/Sqz5AHKhYVc61Sf1cqa8u7mLNLGMZK+65Hya32Gs4qqPfU9bEB7067hCCI7z3URMS2szuoh+eIFxrmgmuBXz6kmoRE=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Fri, 9 Oct
 2026 22:53:53 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::88) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:47 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:46 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
Subject: [PATCH V4 06/19] accel/amdxdna: Add AIE version query to aie4_get_info
Date: Fri, 9 Oct 2026 15:53:30 -0700
Message-ID: <20261009225343.3079074-7-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 6019c0fa-5764-4c2d-744b-08df2658312c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: SWrnQkSY96uUzfxJRmq+fLiSzTR9AsRzsX8vPIPqqfvyPKt5kzWAkeIbgB2kNXOCLV7c5rpbEy9DA1Txrrr8fz+3SQmaG788zZl0TQXiMDaqM6kMzev2NG5/zKdtgFPYO12N8UoGxNkEJfHwEUzILIefaLIQ3yB+E0i+2PoVVf3VhQYKu5yI1BQu24cSQmC39eMgeP27tXv6bqxZOCAQ1WZznZpDaM6tJ/FIkNYgqXW08xN1vrZ9olEt8Q/8QH79UsFnlOZXTX76/8d2oDpVdYZfs7kcAZkMrE1OdZhvh9j8XNI3KD9Wx4PHXmvAOaFqs5z73Gi0zl9dezW8LNg6cPPghcbKyothvCKGEZIqUmfANmlywj6i/c1Ra2A6oUccQvfEmjIRO8nUPLq31/TivzZmCZPihcTtHiBJSq0Xoah+CGmvDo9vSHMhCOGg2M0MFk7wZKFVNtTugrpo6qqB9UquP5zZkZBh58fhAQaKA0kC2r1RJJX+LR3wlQQuRBZKwWtgdOjeGGJarIWH3l6B8pWy/qWVw/AR/jRb3yPppDBBaPSinWICJj79nS66Mp7Mnk4tmN2VFNOhuFfmD+hrdeNSC/81xohmAIuHCvORC5xTqrqcalvdNxgC5GYXihjF0sGHKZ6Siou8wvoPXIkHpTGTTGUesuaJfXElTZ6sto0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: okiDTIxNEXuGe/EMa4VG+EiFpSQbUjUa1D+J/Fv53iErhmCgpR/+5c6SgeCh+McSCI5/ESwTdyQJBDN8zTqguIkylhCkZQZ3JN+WaAEPKsZSMFePlvjhlb5m2cxDLpGG/JWJRWG49yOGofosDGwux4ODvZndjeszAJFPCWxmI7rStiSUiadcGZC/AqaHwiAY0I9VbCP1Vl9hwoGliIX9oVQWUDR6cwQ7T5qjI7S4MXn/PuJKtCdEJHkY77f/ymBddOJu1wGErgbltEK+WWxz+ljYt4rn6fiX2/jnohVVfVODKYUujGCxTH4dkTuC+RB7wS0C7b/bifwWdfjEgvhjGjzPycsAbAKibtUlLkYsILDmIcDXUicvRfdBANwWngpLKFRmfEaQmBLpDGnOBop2YNz/fAwmyaFRUxZIuDnEz9D0+1IUjpsHqBCoM4pW1lLA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:53.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6019c0fa-5764-4c2d-744b-08df2658312c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
index f67aa8ba943c..c83f81a0e65b 100644
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
index 1eeb1cb73b27..1cbd1665a28f 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -289,6 +289,10 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
+	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
+	if (ret)
+		return ret;
+
 	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
 	if (ret)
 		return ret;
@@ -595,6 +599,12 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
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

