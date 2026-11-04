Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657B606D836
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AHpg7tvm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD5B110FF8A;
	Wed,  4 Nov 2026 22:43:20 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BD510FF93
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8dQ5iv1Z2RKa5mqiQfcYkrDhzqHHHKw4XM0IbN2EbMegVdzsgX5UzeAjGG2zaxDzlTwxphQAXXneEM6YSjYbvIlxPWjZupPwp63jPxLAd8x5IL3jRr44AoAwM+akoB8lEDu1mCPT30LAn5t6oFiQ1OCNdNU0LH8PXZK9sdbxOnfUobjxT+UgZ2S77kIdnsucy1MGzPGqK2CBEOZGXlsgVrYY955r3kOAtUZUaQzi5lVuP5IUzLv93fCjtwHnrgQgh36FavLsYCuHCE/VhDa+23P0zXe2OnLxbRHy2zK7gH1pUjy1x6Jlff9mEoNikJfGPPUCa/EfQAYhem0h5rG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jphZs+PgWEjkGrkMJwxvxoxHtLPPImvS7uY5Bp5w4t0=;
 b=T3iHWJJGeFQmN/D3fPhjL3nzZn9UEI+Ac5mhDpfqisqe8cQSc6GwjFGwlM+ixAyIzCn20k5pD6NNUa8niQvVzXkpdlxfrpoGyqo8aKpqAnGTm0Y5nBVPc6FEmscBtHf7WDE3XFnSCF7LzjEdXsEx4RRGfHoCoBP+V18cdL+evlLWF3qXMooj0Kw6pSf8BE//M5qY8AUHSGQrFRthwRq9AsXY77JcSjEvVAfXNEdIgM7Rn/v9uymLifNkBFEe6B9f5YotjaEr9zDHyWzBwRo0XnqBMxOHTBmw11fGIX+xEBUS3Jgt262BS4bOsR4osZvVcfKaRiF3T8DlAJU9pT1V6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jphZs+PgWEjkGrkMJwxvxoxHtLPPImvS7uY5Bp5w4t0=;
 b=AHpg7tvmGYVmg7epnWBiI0UNFYhpH3wJQMAq2TbRa+/tRt+otA2MfXhryj3b0sacCAPu6JOVvemC8orRjrX5AWbeW87XmHmitpApVHfF5PEBiJHDEs0e9a3DMcTtHkM3Ii9P3wrZDo6O9TAO4PLWSWOCzRvfaajuK8bGQVm2Ulo=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 22:43:10 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::a0) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 4
 Nov 2026 22:43:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:43:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:09 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:43:08 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH RESEND V1 1/4] accel/amdxdna: Add NPU10 and NPU11 devices
Date: Wed, 4 Nov 2026 14:42:59 -0800
Message-ID: <20261104224302.643329-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104224302.643329-1-yidong.zhang@amd.com>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 391b435b-97de-47a0-0db3-08df3ac50090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|11063799006|10067099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: NGIJHn0uPGQrLUOkNAn92FpbqxabaOoyhyx0BI0NYAmyU9WisD8YKva368VxHZ9Y44fmy07595CefdaBalfI4d4/eaT66c8buM32Ek/+RR6P0GqLHTmhXsNMsWe+73pQbOg1PHPnRybToEF9gpOlN9W5nHOqOVgeNNIChcgN2+tSv+12+6UJyY1qwx7adC/dTnA+j+0wdwqOIX6ou9Cu61danpq9nPEVejV4PfYJwdcC13LhFhgzbtnfc74ji3RQV/80F9R7WdKJu5ihvTPH2Te/MC3htJ/Win/zl1PR/qz19tlSgA9C/UFbZvh5PLG5oPg6lzOeLtRUspNSvreMyiuh/fYB2SNo6GV/OTDQZc3lpMbO2hQDL6DliE9BRxoHBftolPxiFS7lixzrQDeMxgjDVW37m04W7q4SsH0emkEW4lR5A19cnueIhaz7UZhQBy9jSTMubj5O2BqMrq7Y82DRv/GhPPkuQlSqEsnHFkgzJYhM99nf+4KA+GNdLO7ntTSc7K1dsmelp57xPqL5ifht8AhGGKTVsFdEH31OLfFEwb3uIbfSFYsY+NEaPy5fyM95G9p7531fov+7qL9E1MuFJ3RcpvvKW0VdvrSZojFkfGHE1TjKzs0Hidiya773gavvp5is6NSb2Qps0aG78rEIXNrG/fKxfMiGzCkFGEX8VV/CjrSgEgFBDvw8+lwiIb7x3SfnvIsxuebsbSuPAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(11063799006)(10067099003)(261028144727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3I9IiImEzW1aEEfQizWHxSj4wm4aAle3ccEf4GgXoQUzteSUqFa1MV7XC1/XTHCsStMdY5PK2bOLNNaHQ0BuivB9B7YqhspqTax44USVWRBSVZ1xCkdoMVyHnnaibmZ3/5lxkfqeJenjnF8IyYVIqA892c6loDNZgPU6+KUGeHxLRdvbow3d3sUNyUU83Od0pokt2bRxdTgIpJBBSomPpPaQiV3PslbTNsNKVaV3pbZdKOgSRT2UqtGe18fian/1K36o9dTCw6u5Rma7wocg71GgivR5k40U12hN/oKYGMpK+84Nwc/KGFkVa96R5sbH8Tr55GpEMAHsNwzs5wMt8Mv1MLXKTWsIMETVvBziH67asVC5fzu5vs0uz++DI3fVny5TkBeWn+vlwi3OvY3bTpgZ7nqUIAxX6RaM2VsQPnWrBsSdesS2NMn3YDqWYQWb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:43:10.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391b435b-97de-47a0-0db3-08df3ac50090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

