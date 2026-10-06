Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B2FCA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3010EF72;
	Tue,  6 Oct 2026 04:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJIfkiVD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601E410EF71
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEpe98wY7B9BcBXEqFv//uM08VNfav/tOn34zwMnGYFa2lN3MCvzn5Cogf5OtO36UDQ9hbVZRiHudmtWDLLPoepEvcIeXtykh+9bKUFghncju9Df2qpNskd0DfFs4Iu+wMJmu3sMwFiO+1m264OxAJF+jQMeJu/ng0e3S0xjj789HnDE2J8VUtJOcoodxfrvcDn6fIP86YYuI74aBIfkv1AklgO1YAmQe2pc+MsBbhKFfXCRLrp3yPhsoFOZMNSg42A38DMeM/NN2U6mVTILnuSoNHOOhrg5sKjz4o9IlCRdJ/F6D7pGLpDfe3MoiB2Z5NTU9mn/PR8zBWxxhWmpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAPBTbpwYWkURgEdsMowzbkCcIces0ruSUzujeMwyKg=;
 b=s+Yw0CwHHHMrRcSoEJ7rsFvMpuNwusy3DpcLi/KFkdAd9Xar5+r84cPtYOjELjAnDXMoKPk1FRgSz31WHJStHsfd1PW7xqZOZ2A14433wAsXZsDRc9Vk6lJS+QOnBC9O/8Z63ZsJMGi9oOPeTEl3TgkIZfeaj9i8aKyxYcX6l516S3UTd8ZeLw6zhI9zMunPuHrFn6tg1L688jrEwLiyb2n/1LUAIwo52XenqHgB8D8tTojuLSvzucaPXbbQEUcQpmCX1Vs9O7Lt3eXDS7Uvy1O8CGWGMgHAKAoVE2zRtE2qTX4YsZlRlLN2cSNlCqptLV8Ds6bW3c2sV4G8lKVWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAPBTbpwYWkURgEdsMowzbkCcIces0ruSUzujeMwyKg=;
 b=LJIfkiVDJYKM9Lp3KbKaqtVmiq22AEVL6AAJL7YCoVjqFnDi1vleiZHoZWI/OedUSQ5JHRRT5AGcUUzVpsKFMBBJlO7FyJPrfKjBtIg2BAAG+GuGKzvo539HCU3PfBmOJ0tFzEQiWL9P+pbEL7ttsnIQHTQvHmglqzBZeY0jMiM=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 04:22:55 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::18) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:55 +0000
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
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:54 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:53 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 10/20] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Mon, 5 Oct 2026 21:22:20 -0700
Message-ID: <20261006042230.547807-11-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c849463-53b3-41fd-6099-08df23617ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|3023799007|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: z4sqDeXL/yI2Ckw6G3tTdQOZh0Hoy1LzYMHi8wxaAhoE/dLhhp3zRGeMOI4HkM2cUXQc45rWKQxxEHTx3RIoIJHSGvxRqpAKFojd3e+MNc+f2K/PHJ+fBUWajTdkaIihe0rLkk8fLA1+MvwuULVwK0lYncLolO/jZ4DUV0VH0P8ocpBfCEyInNFiupl4KPPw3SdE5g8WdykNESGIKMIFNvqoVhrL10lqFbNJkfe0Lkti4yLQ6EQx5tGEe8fAdPJcXweub0YeCZK7V0aa/46u3fRlpefcVHLKFgOUw/4eTGpDU4FIkNCqQuXITn2pOeiu0p8fzWNwuCwOE72KDGoHyWqTkKHnTb3R1ZgH50n+nnA3ssVbWn/yTR2vbMiPK7HoqFMgSXL1NlxasrjNnK4DagUxQmiTt9k4Ch7iu/+B4EJrMVISLV45i3AuTw0hDS5n//KyGmIB2kEQuUYYzjo0wxqf2AGPcRO7SyA5Ee/p/p7qq+ikj4ZNOa+HOLW2ai4gb+GwQGz1XIrnJiqAZnFkV1spBocI6NLS3n/FcPMqrhjNBcyZv3SW4pJTJRr8wx4ie0fHferO6wrPhdHkJ7f8vkzVUzJfb2JWkgzeriHxC3uFu5I+yaVx3pkeyj6txqogcI4TLq3YFBJ7VXlDCOm+8mIukPYRe/v6FP0uwHU6Mk5JUslamutuswU1Sflt25LixkCHc4SNsrkFrBEENPhAig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(3023799007)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g8T2qsd7Y6Uhm26B/X3m+zl2isle7QvlZfYGPDW3KJ0PQ6Kew4m50rF3ukOL55lpOvmMpIfwmNl1XY7N1u4jhVARP0t9+JF79sV+OLROc20c6BtjlpEScWBe5qewb/QfPTSW/JTpKfQmSnYyPn+KMk9BEU6vvwdMCTRTqrY3nyo9KqsBErFJBx3JBjZJallT1WLDb0P2KXc8vXS3Vm/ZLhQdsL6VyWDUttMOC2d0mKK4pXU57eUvNKyStsC1oeUmb/TCnP8ndTnsK6wC+JQi1Dg/FwKs6bya94gdnJ8iLxqQ5lTg0A20CoIHi6j0eE8Br7Gk5ouiyuRE8EooBg7x++syywmk8z8yo12g72gIEuuilVrOtPMfEtvXZjbIN6yxFWiEYq5d36K6a9PjmSMLkIpz87gflFkXPal2xNRS950Fn7080UgYwAZAXBMIpgIX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:55.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c849463-53b3-41fd-6099-08df23617ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
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

Reorganize AIE4 hardware initialization into distinct phases:
- aie4_query_fw(): Query NPU and CERT firmware versions.
- aie4_config_fw(): Attach work buffer and configure context switch
  hysteresis.
- aie4_setup_aie(): Query AIE version, metadata, initialize DPM frequency
  table, and initialize partitions.

Update aie4_pf_hw_start(), aie4_vf_hw_start(), and aie4_classic_hw_start()
to use these phases and unify error unwinding labels. As part of this,
aie4_pf_hw_start() now also calls aie4_query_fw(), which it previously
did not do.

Additionally:
- Zero-initialize struct smu_config smu_conf in aie4_prepare_firmware().
- Clean up iomem pointer type in aie4_fw_is_alive() to void __iomem *.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c | 79 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index a315d2a5607e..4a5f30b42743 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -49,7 +49,7 @@ static int aie4_fw_is_alive(struct amdxdna_dev *xdna)
 {
 	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
-	u32 __iomem *src;
+	void __iomem *src;
 	u32 fw_is_valid;
 	int ret;
 
@@ -273,7 +273,8 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 		XDNA_ERR(xdna, "partition fini failed: %d", ret);
 }
 
-static int aie4_query(struct amdxdna_dev_hdl *ndev)
+/* Verify CERT protocol compatibility before starting hardware. */
+static int aie4_query_fw(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
@@ -286,25 +287,6 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
-	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
-	if (ret)
-		return ret;
-
-	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
-	if (ret)
-		return ret;
-
-	ndev->total_col = min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.cols);
-
-	ret = aie4_init_dpm_freq_table(ndev);
-	if (ret) {
-		if (ret == -ETIME)
-			return ret;
-		/* if query dpm from fw failed, using default value */
-		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
-			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
-	}
-
 	return 0;
 }
 
@@ -333,6 +315,32 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
 	return 0;
 }
 
+static int aie4_setup_aie(struct amdxdna_dev_hdl *ndev)
+{
+	int ret;
+
+	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
+	if (ret)
+		return ret;
+
+	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
+	if (ret)
+		return ret;
+
+	ndev->total_col = min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.cols);
+
+	ret = aie4_init_dpm_freq_table(ndev);
+	if (ret) {
+		if (ret == -ETIME)
+			return ret;
+		/* if query dpm from fw failed, using default value */
+		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
+			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
+	}
+
+	return aie4_partition_init(ndev);
+}
+
 static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
@@ -345,6 +353,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
+	ret = aie4_query_fw(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
@@ -382,13 +394,13 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		return ret;
 
-	ret = aie4_query(ndev);
+	ret = aie4_query_fw(ndev);
 	if (ret)
-		goto mailbox_fini;
+		goto mbox_fini;
 
-	ret = aie4_partition_init(ndev);
+	ret = aie4_setup_aie(ndev);
 	if (ret)
-		goto mailbox_fini;
+		goto mbox_fini;
 
 	ret = aie4_restore_power_mode(ndev);
 	if (ret)
@@ -398,7 +410,7 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 
 partition_fini:
 	aie4_partition_fini(ndev);
-mailbox_fini:
+mbox_fini:
 	aie4_mailbox_fini(ndev);
 	return ret;
 }
@@ -425,17 +437,17 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
-	ret = aie4_query(ndev);
+	ret = aie4_query_fw(ndev);
 	if (ret)
-		goto mailbox_fini;
+		goto mbox_fini;
 
 	ret = aie4_config_fw(ndev);
 	if (ret)
-		goto mailbox_fini;
+		goto mbox_fini;
 
-	ret = aie4_partition_init(ndev);
+	ret = aie4_setup_aie(ndev);
 	if (ret)
-		goto mailbox_fini;
+		goto mbox_fini;
 
 	ret = aie4_restore_power_mode(ndev);
 	if (ret)
@@ -445,10 +457,11 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 
 partition_fini:
 	aie4_partition_fini(ndev);
-mailbox_fini:
+mbox_fini:
 	aie4_mailbox_fini(ndev);
 stop_fw:
 	aie4_fw_stop(ndev);
+
 	return ret;
 }
 
@@ -522,8 +535,8 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
 				 void __iomem *tbl[PCI_NUM_RESOURCES])
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct smu_config smu_conf = {};
 	struct psp_config psp_conf;
-	struct smu_config smu_conf;
 	int i;
 
 	psp_conf.fw_size = npufw->size;
-- 
2.34.1

