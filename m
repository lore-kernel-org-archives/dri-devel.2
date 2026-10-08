Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0967BCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563F010FA77;
	Thu,  8 Oct 2026 03:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wj+fhJj6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E58410E71E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P19kUyCFnpc30eImhwGjR23cibcYrNLj81PS7s8sHB2cqvgTvxZkeA+cpzIOCjOHUR/90GZ4gaJSRw1cY4l2UWkbePFpsNQl62WMcok+C9WaGU+903oPkc/oaR3pGtVtQXsUTutW7TRKCh75X2cHWplMrcE15GfBp084I9WA5vXky8n/+fQ5Fm53ZzKGfDCTwQQ6jSSyqLbkZ+oEs8r2F4+l7/Ow3oEKK9hLZ0whIK8q1cQ3bmO3GKFzpY19ImwxS4S763NYwCFfMAwmvbUky0KtEPingctWoQLFOIIK2EGP6rDksso2bteNo1BdgbPngjRYUtaP8izV9YMxoFdenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOHraoOagYoX1LFfEWc2sPrnMP6MaweMYx+yQPqKC/U=;
 b=jqbk75k1vnHoKdPCN+eYP1xzfGHMPDZVCnQQLAnNKeqcs2SEIuQV6diylt7CWyrPxsBe0bZ+abN+/k+wy55RCakk9gjMba4pUnaY/ap/kCOs3RlK5JRbgB9Bj4oJJccgEh0H4NxzJ4Xnan7hRWjBbKbKGB5py7e7YJ4ifD9muRGojd0vRk/cl8ne5eNpOK+4cWfU3heO0CJPvY6NtK6GrGbSh/1wjKFwqNFdtljcnVrUrOlA2nEtF2lz9Wut64G4vuW/6Sazbzm/eIEiHJQl9/ASDSVoTZ8SyfMqXMdleqosuVFZAQ3HiIN/vfYLyY/5x0uKcV58tN6l4/ep05ZvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOHraoOagYoX1LFfEWc2sPrnMP6MaweMYx+yQPqKC/U=;
 b=wj+fhJj6TmPBwNAhfAQ+7nDHBWfz8i2DkQKEtNA5LksNl6/izNuVh2mvlflVxOdKxy1XbJDYd4GxP+WlrmQPoK/TiEX0rtUGII/yZLU8GPJdw7mIFrUDym8wfSH03veBLJ/PquPYzRGElNZ9Fus5heq2rNzpcDI7Qbnx8lzKCc4=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.35; Thu, 8 Oct 2026 03:24:05 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::6) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 03:24:05 +0000
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
 15.21.522.3 via Frontend Transport; Thu, 8 Oct 2026 03:24:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:24:03 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:24:03 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 10/19] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Wed, 7 Oct 2026 20:23:39 -0700
Message-ID: <20261008032348.2044667-11-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008032348.2044667-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f02540b-ab82-4494-293a-08df24eb9bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: M9QGEYGgp/QvpGkJ2zf4avOAkU1voxd98365Xq9HfXkWxSkMw+hzDmZdFvgoXTMmJSawKzniw4hF4QUeviAyRJUyk6KcdI9A7X9EZGIuMQICy+hWdO67PpIssp1Gh+Rs+X38Pf6qB9Qs9KppUs5tHBlgk5y58KDqDwIDiyFuIFfVBCGgxJicOLE30FuH2sBwiLpnrLHRpv4OUqUTmdWwAn3blnP7qdQNWNQJoLh8qzyS0oQfew63rN61H1KjgZUemwfixtW1/4L0uvsVf73NEqsFCiHhUBu2y01jhB9LQVH8QBxENNMk7C3PrC5PWqLgaFSgPMoqmZgQnUXkLt4fcRPwNVnEUjiPl3eFyEQTI48LpLbXdXGMO7SFFxlOESRf32bQtxY1G1iBdCvBdZAp9ZIDASvg09NXsq3dEooZEotOG9S48Zvc+HvLb6DWscS2Zd/7EgCLEoy4rEfOEKJSHu8iiiKwsfHsjzDv755GjdyZRc6CPRHuQc2AKfXKJjaWTQMtXH2Inw16N+MhjWnNcNAQzw7xBxoL/sUoIB3JqCjfGAbEmWRrXSi55L9MtQDrl80JP5t+iMzyB4Rsmzd58UZKCmm6st42e/LJEGzXAk4OM40QEbHluZ1KiGeFpRJ2FXDLOjkoHtcVV0GoDG2QUN+knKDNwzmLquQn91rj1L68uUeJJDSsiNjkfFMBiPjLyaWw6EIjV/SElSwLOrU/hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wN5NTBuwzon6U7+HcOLC+zCPWoP6cu+JiaijaG3P0mUf0ktFNFIokeJEWXZHv/1FbrhGWCVthsyNwBr/uVVlHW7ezW1jzlvRvZygoYeMCmEJa0UWtDcGOsV4oxK6QR/ZXudE6t6uBN9a17nLvzcNdHUk4vDeAOlRociKQpy1I0XAegZJakUpABjHpgrCK5DF+WKf+2CHy59gBuj5yHQy/xOQSJp7sBS19Mqlv9JxzvXUTEJAx8mjEEDTPTWFZyixnHaHc2kNXdjPWAgySHO2URvmLbGr45cArz+og+NSd0zmaNewX40NpEm3I1ukk4Bqk0hevvLry6vztfbtojXcxAX2deNkSHF/B395+WqvbRP/rNaX1xAt4LkECRBI4njn21iLUxN7jqXGMqN8oNYGizEuiKr2wKNDVV/5ejsDmwSP5eJgw1js32FXyuProb1S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:24:05.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f02540b-ab82-4494-293a-08df24eb9bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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
index d051aa1b51e6..8fbbbea0d800 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -50,7 +50,7 @@ static int aie4_fw_is_alive(struct amdxdna_dev *xdna)
 {
 	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
-	u32 __iomem *src;
+	void __iomem *src;
 	u32 fw_is_valid;
 	int ret;
 
@@ -279,7 +279,8 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 		XDNA_ERR(xdna, "partition fini failed: %d", ret);
 }
 
-static int aie4_query(struct amdxdna_dev_hdl *ndev)
+/* Verify CERT protocol compatibility before starting hardware. */
+static int aie4_query_fw(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
@@ -292,25 +293,6 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
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
 
@@ -339,6 +321,32 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
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
@@ -351,6 +359,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
+	ret = aie4_query_fw(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
@@ -388,13 +400,13 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -404,7 +416,7 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 
 partition_fini:
 	aie4_partition_fini(ndev);
-mailbox_fini:
+mbox_fini:
 	aie4_mailbox_fini(ndev);
 	return ret;
 }
@@ -431,17 +443,17 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -451,10 +463,11 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 
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
 
@@ -528,8 +541,8 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
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

