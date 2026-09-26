Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FE6C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAA410FD14;
	Sat, 26 Sep 2026 01:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4PZCw0y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48C110FD00
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYVvygU/drKRKYNp+/hRgkLR88OnShJhDjrtQBYu7AIp8EAr726H6Q0qc0bUwcaWaYSxSgtfOGQh1zPoZsWPeHvnwlJ94ucYnewaYmbSNTjQjxGMiETgPem6J77aJeSeH5IM23vyaxn+e22JoqLF8T/nsYm6qXQnp7JeW19tRdmyL629qjYwkUPTxudCx300ISjRLEHP449zSsGMDS873GJntCagELi+JWhm1ga3oQ2dC+ND9yisJuxWc/0kFqaqABweMDCLVMEuwKzfOgEuFQvMJQCOCVx/edl0Rlz8fp/tpotUsnkA0Jr5oxN+McsEx2H7qIO3D+D5N8ayeIsIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVxAR+gR/Lmi8jRoxcbS35his3x8QXtnML1f8b4KQaI=;
 b=i1A77BkuvnYCcdCw5sQwMTSSpx5C75eAcKzqI3RKe93woRG3c/RIjF63Ifq+GSyZXOPjyl08XevLRx9P0mhfAEIopCRlXR1Q0izZMs8uHCY5u15CPGvgelobvoySBPfLoaZoA6nIg1/emezZgjgkrUfV9sqYM0xVYjq32MLUVz2q378/OmRPjRtFrsR7iutlmbarOPo0IfSCcxke8zcXbvu/JRZold3yWjMA09ACQc3+y+siPCoNoN49sPW0YUe1yYEywJuaKG7qb6qo9yfDb2jR8Bx9LPpxKnpb3tQLYDwpto3Ka78UIXAyNBX3+mmNRWoxTZ8U+aO0MPYnIt0HJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVxAR+gR/Lmi8jRoxcbS35his3x8QXtnML1f8b4KQaI=;
 b=L4PZCw0ydk+ujqiL9Xf9zRp8r2ifGdI6avevGMGBIx+qq33QYIRqhznzkc/rvHEXySuOSkpI5Q6eA9tf9CJIEmQPdHaVxZFA+e7hrS4yrX5jkjVHxuaqkxseC0n4DIzcWo64jg6x3oENYNi/J8G4XR+ksUBlktS0OqkGG1J7X1s=
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:33 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::a2) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Sat,
 26 Sep 2026 01:35:33 +0000
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
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:26 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:26 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 11/21] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Fri, 25 Sep 2026 18:34:38 -0700
Message-ID: <20260926013448.3840921-12-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae30dac-ead7-4679-2fa8-08df1b6e74f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|10067099003|56012099006|3023799007|6133799003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: PKzqutJSkRYglO9nv8NgazZ0lo53AjMezAO4GxUt4WrH+01IWxVo8kuLIqi88xLctfgg82uaGo/lDG+G++5147lsdTh4ABQtzIOR1lt4BtpejsG9E2iynuel2rS0J/KabqTb5NAv3f2anximE1YrFkwiKOawFrUGgZseTyH305NJCQh+PuH/CFye6C5p7EAmLayN5FPdOvVU5m9y712CF5/0UYDTi4TWQElAigtHdviL4SsjT8hA30tYLvO38ayA9ULYtQm4vsZYjbYlDFEUYC8nnjFA9KJOKJjtJOhlcBLH7dNAMYhoWJ5mRgpMIZZY+CvwHI5Ii4gUvoWMD+9QxGLX5fAYxBHqZu/GKQPhHa8DNcRpxIkG54XCm3xIkFIAss4Sa9iSbG0GF4QcTjD56p+AdTDKZM9s1aHHFA4s5M0erAbC0kdUhPyBB/SnpDkPIkJ0UxgKWGX7+e1SIdT9U22y87wVu3Djrz7eaHxUVziZBXibQI9zOAlFgxxRFuKdMOJ1Y1r5QW6tTMdVyJFqAmsuCUC7avQNw6TB9dPZYjuUO4OO7oQ5sKpaugf0MGO5dLHWmqxxfT/yqC21wZaOvphNb9aFbVUX7XCybuxiYwXaJDRp0yGPB2AJ1msvfi3dzx1s3Zk08ltAwjBDmbNWdePa0Go2rBruW1Cp9WzOO9x7Z+wzVK8RnVqvZjB2LNJ99JGRPLHpSPbQ2F2vRgOuXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lsMWfasfLYH/NCiivFDEESan42aF1+pUT7HXy10xOCjUSty/iQKSvJ0TaEOOrsXRbl6fptBWEGEndY9/vCfxE00Ix9GMMndz/ilzPiCOUhY2U9rLx3zdwgP0GBHtc1Re6jP1WeNMmhA84qES82QNLgd6MOaQgnBcrHl7/lucPJnqZr8JbW/YbXjTQrdMbHKAy3HejzdFmIfzoA5WRsRqCu7JSmZx2+Mmij+IHnA1s90lbt1wvd3i/ThDN76GYeRPMBdRQr8qtbu0D8v3gPzx/ytUMHY6h4Ie/6tg4EbE7RJ6xQOO/eXqs5FPa+tIYvoseBbLIGT69mSDPUAAGXeguz/BYkMHisq+/6Tq2F7k3OUPV5OTt7NHw0RYgBdn6eVMg+FOnD/kSqDOeUWlkKg8xx10vPT2UPwvP+Xl4V2dJUQY1oVx1l718flGrztxB/YF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:33.2136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae30dac-ead7-4679-2fa8-08df1b6e74f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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
 drivers/accel/amdxdna/aie4_pci.c | 82 +++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e1484d384d3d..1e2b120c4972 100644
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
 
@@ -273,7 +273,13 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 		XDNA_ERR(xdna, "partition fini failed: %d", ret);
 }
 
-static int aie4_query(struct amdxdna_dev_hdl *ndev)
+/*
+ * Called by all three hw_start paths (PF, VF, classic) right after mailbox
+ * init. aie4_query_cert_firmware_version() runs a CERT protocol
+ * compatibility check, so firmware/driver compatibility is intentionally
+ * verified before any other firmware operation is attempted.
+ */
+static int aie4_query_fw(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
@@ -286,23 +292,6 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
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
-		/* if query dpm from fw failed, using default value */
-		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
-			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
-	}
-
 	return 0;
 }
 
@@ -341,6 +330,30 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
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
@@ -353,6 +366,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
+	ret = aie4_query_fw(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
@@ -390,21 +407,21 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
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
-		goto mailbox_fini;
+		goto mbox_fini;
 
 	return 0;
 
-mailbox_fini:
+mbox_fini:
 	aie4_mailbox_fini(ndev);
 	return ret;
 }
@@ -431,17 +448,17 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -451,10 +468,11 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 
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
 
@@ -528,8 +546,8 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
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

