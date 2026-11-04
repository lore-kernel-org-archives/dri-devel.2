Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2916072649
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xHrnIKnX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E99810FF45;
	Wed,  4 Nov 2026 22:16:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BB310FF45
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVVBGvut6gXV17PhkjEkn5kKxstbcXNjcGyr29D+fNCXN58l0/S3q7n6CkgtR8MTfBmWky3RU0TD46UMtgecskNRlzp2tNjEJHHtZmg/yf/l6HFasqVxBYCl/SzXgksdq18QQoHCY+GVXklzvqhMutmWLbPmC6G8n+62VvUE5I0HSOh2Tu+kkkTRist2rNkKI5M07zQaRVM6al9noCvYeFD4G3vy6VVaiJ3xepMm7J2hewXQLGzHOSrwKJU0j169wmLAknNnWHMOBs1UlZ9RW1BC4Vb3zWHHs6NuoN7W8uuw6EoxiKfMYmFLINrX3qY4UQqadwY+6bRGzDZGXDXsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jphZs+PgWEjkGrkMJwxvxoxHtLPPImvS7uY5Bp5w4t0=;
 b=JrdFV7K/5QcRd6MyTyGW68GYTTiOte+DofZ06TxCgUomLNsF72vth1by4TwGibV2EqTggyPLY80aHhIcA+TG5B2PNtQMaN0gQVDeZ4si3srQjOmadBfhiFg+1wbshyyl9In1+uYvxNaLrI7Wh0APe+n8f56ksCoAzSSlBByXPJ1DSNmD/fqQrCJ8bZsFtjsqmvLrWSM1nOdedmG38D1nl4JvuWCL61st83I8bTZDLZ7n9v4fOlOnO1cuJXqduQZ0BjSeWEBi0ijql0OOexvtji4ESEx2CVJxqHpGGuUPC92y7ubEvHw7kI513XEWZt3OXkZiKwxmv+ICMx/Poo4M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jphZs+PgWEjkGrkMJwxvxoxHtLPPImvS7uY5Bp5w4t0=;
 b=xHrnIKnXt57frSeFO2FxGxRAeoo+l1hRQt/lcw/1F82COaWiAWwZYORHjQFvksESGExositSx4R0vWqOEwnB9PFQGBEqXV4h1FnjL+lDyvahOqOkuboMxdiujvPpYEY3yxBLU7w0F+WfsRHSaNBOnpp+hHJF0m1IPhMaBA9Rq+8=
Received: from CH2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:610:54::38)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:15:52 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::1e) by CH2PR11CA0028.outlook.office365.com
 (2603:10b6:610:54::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 22:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:49 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:15:48 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 1/4] accel/amdxdna: Add NPU10 and NPU11 devices
Date: Wed, 4 Nov 2026 14:15:37 -0800
Message-ID: <20261104221540.631182-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104221540.631182-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261104221540.631182-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: e2241b7e-c510-4817-fe54-08df3ac13080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261026121527099003|261022075727099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 20MYwY+ItPMet7Wa2PxKoeZuj3rQPJRknFnt9H99DoWVAxG1Vbs7ZfB65KOcc+X/z9Iz4d/ZZoiqNt0hCsaCPkGQu2tfhXpPldlVOxBIof/mUcOfuibOVneaeGYJ7gyb1D5rhSwnCKMKPYnHokTbpDWGCTUpxbXbHqqQWnj4ybj6n9LSFQhK0hzErgiEhWdL8A5M89DRZz9i7bc5vyJ5SMr85XIEreXZw5lVjusiM/rNmTra94rsaNTcY3Hu+ZSsH+gP/silrhasU1vHsj4PxPGqe2G4VD/bw13C4ltNUJsoVsUp7kXrIlUL9qoJmo0t6iIZmuZFBevlIRoLWFRkEDUyhweQ0T3qhVnW1fJ+fw5fptL3PG3j5Q0bpF7TpmRAenSVnY/fYJyRnfBdaRB/1uYQmIncjEh7AOCngA5khXGuJnZdEoElc7/kmsEjZk5qRTwoaEQBdIuKV9GmzSHLyUyo99mOnLF6WoIP74YEQUe4O5TS/JE2FO8yqze9wl8vEk6k3tNLoYwR1/HFwInq0m3TfGX92QL3Zny0O0NjH0QQu/fkLdXnBL1kthvvAf2seJaMUD6S9v3iLrPpL+GTdyhJoD4ID/V7S45YZXr+Y5jv08f2hD44Ejm+WdxyCiwYbdh4Y55jnQJA7MuZ+KJBY5PmYonjvlkd6lYh8+R3oFFzh/i+k9YPt8aQ3BOXotMEalWdcjjTNX9OUZMry9XXwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261026121527099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C7ZXB9EmY0PBqiyeBtzmff2o53ykNGxakOs1VN2ZTtO5fNbu/0j2BSjmdb9E0w1R5NFH9hKvjj+mwT5nTFNE5i2A3EosGuvJNZ4kooeSNvegNHxZyBUcvsEawwOSnrV7j5Z/VmLDvObt+1x2pldNR3mfdF9aTXvosR84yE3uR/94hsR0eJOwrGpcVD8sNV9HqFVT4fqfRsN9f1EBK43HZ0hSX6YLRq//+knexjookO6NC5TcQH8nLTdjzAyYyFxyMx7rG5jNbR5LF+kon4tDMb74SMvk0UoUA/PBC95zaiU3W4FFLG/6KfBU9D7MCMLkjFUoTzrdrioTyUikb5zPmGPVbc4zsk/43MyKj6Uh3WBjtLWToMOEAE4YlQnkuhuCOU43ogHtneP4VqVJn86hCv+yl1v40IIC20PeYjWDFUklzrPm65rDHhC6Gp4wSQOw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:52.6200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2241b7e-c510-4817-fe54-08df3ac13080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

NPU3 revisions 0x14 and 0x15 are NPU10 and NPU11. Add their classic,
PF and VF devices with their firmware files and report each by its own
name. They otherwise use the NPU3 settings.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 14 +++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  6 ++
 drivers/accel/amdxdna/npu3_regs.c       | 78 +++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index f233eb70a295..685fe1a7dd56 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
 MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_14/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_14/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_14/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_14/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_15/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_15/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_15/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_15/cert.sbin");
 
 /*
  * 0.0: Initial version
@@ -81,6 +89,12 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
 	{ 0x17f1, 0x13, &dev_npu3_classic_info },
 	{ 0x17f2, 0x13, &dev_npu3_pf_info },
 	{ 0x17f3, 0x13, &dev_npu3_vf_info },
+	{ 0x17f1, 0x14, &dev_npu10_classic_info },
+	{ 0x17f2, 0x14, &dev_npu10_pf_info },
+	{ 0x17f3, 0x14, &dev_npu10_vf_info },
+	{ 0x17f1, 0x15, &dev_npu11_classic_info },
+	{ 0x17f2, 0x15, &dev_npu11_pf_info },
+	{ 0x17f3, 0x15, &dev_npu11_vf_info },
 	{0}
 };
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 27593190dcf6..5ca32c5b1de0 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -187,6 +187,12 @@ extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu3_classic_info;
 extern const struct amdxdna_dev_info dev_npu3_pf_info;
 extern const struct amdxdna_dev_info dev_npu3_vf_info;
+extern const struct amdxdna_dev_info dev_npu10_classic_info;
+extern const struct amdxdna_dev_info dev_npu10_pf_info;
+extern const struct amdxdna_dev_info dev_npu10_vf_info;
+extern const struct amdxdna_dev_info dev_npu11_classic_info;
+extern const struct amdxdna_dev_info dev_npu11_pf_info;
+extern const struct amdxdna_dev_info dev_npu11_vf_info;
 extern const struct amdxdna_dev_info dev_npu4_info;
 extern const struct amdxdna_dev_info dev_npu5_info;
 extern const struct amdxdna_dev_info dev_npu6_info;
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index cff99ddd3a55..4d38aeaea6d0 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -197,3 +197,81 @@ const struct amdxdna_dev_info dev_npu3_classic_info = {
 	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_classic_ops,
 };
+
+const struct amdxdna_dev_info dev_npu10_pf_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar		= NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
+	.default_vbnv		= "RyzenAI-npu10-pf",
+	.device_type		= AMDXDNA_DEV_TYPE_PF,
+	.dev_priv		= &npu3_dev_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_pf_ops,
+};
+
+const struct amdxdna_dev_info dev_npu10_vf_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.doorbell_bar		= NPU3_DOORBELL_BAR,
+	.default_vbnv		= "RyzenAI-npu10-vf",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_vf_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_vf_ops,
+};
+
+const struct amdxdna_dev_info dev_npu10_classic_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar		= NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
+	.doorbell_bar		= NPU3_DOORBELL_BAR,
+	.default_vbnv		= "RyzenAI-npu10",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_classic_ops,
+};
+
+const struct amdxdna_dev_info dev_npu11_pf_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar		= NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
+	.default_vbnv		= "RyzenAI-npu11-pf",
+	.device_type		= AMDXDNA_DEV_TYPE_PF,
+	.dev_priv		= &npu3_dev_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_pf_ops,
+};
+
+const struct amdxdna_dev_info dev_npu11_vf_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.doorbell_bar		= NPU3_DOORBELL_BAR,
+	.default_vbnv		= "RyzenAI-npu11-vf",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_vf_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_vf_ops,
+};
+
+const struct amdxdna_dev_info dev_npu11_classic_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar		= NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
+	.doorbell_bar		= NPU3_DOORBELL_BAR,
+	.default_vbnv		= "RyzenAI-npu11",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_classic_ops,
+};
-- 
2.34.1

