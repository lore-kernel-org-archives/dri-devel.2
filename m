Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC33CA5FBD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6CE10F16B;
	Wed, 30 Sep 2026 03:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UuiFFty3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F096310E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFOOc7bSlUDc8U46AY8rWQ75zD6zu5obHSZrzeRnBG8K03BvQRR61MqMA7mNsTFCquu4Qtwu8jFle3vBHOVTmL7xmjjsZ25+yxeHRUc61RVEREcueFwBpIiz2AJK7pKHiQEzPGU1xVpqXEDqsEGXzubmaAeKV7+rn37wRQGftqsukUf3o1JUM3gNGLTcQIWvk/ev6RgCyw8NfZwdevgTBC0bxvL7wMuIpvzns6lsXgTs0SsXiKZGByaKhv4uk1E5/Hnbg1xUxtsjNfUzjHFwbGaPY2UgcgurNaW7t5JvwfkMW2p0pzxkHs9t4gtrczxrN/n8fuSFHtwaKF25mj5UZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvpIR/6bftnR5ZMrq+C8n5dWNzqfT+dC8778wlreUmg=;
 b=C/g43/Cpa1TU9BR9S1R3GeQCQHZOf7OhtEi/bvlqhia+whoEaC5BNJPBVa45+cA/ziVx3GAbGIU4aE+w1qNrjyz27oyJ+pEROM+5nJNhZf61wxmLt3BFvNqkBQqNj1k1GJrnwiHmClD3uCSWG5wIxXDdnCUFIbs5lb1OpvHAXngVBCimRdITI7wlMu5W+c/kpPkPyp8aqFgsoJCl/r66Xv5PpDhc7YHnxiRSDU4dQ11c3yPwfOjhiK4pud/EOein1jShKyHE5NvcLq6MEVcV9AzIxLJUFHMrlT/XourerycepqcpdzZzEc9qZyl5njnZ+OL+Vsd8sBVPoflojS07ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvpIR/6bftnR5ZMrq+C8n5dWNzqfT+dC8778wlreUmg=;
 b=UuiFFty3myZR5blAgFh8L1iKh6szfNVHtYy0RpXBFcCZrF1W1PYcwP1GXh8njpbejUdW/3nOepbl8UifV4aY9+64EfQZ0bQ9OuROsvTYGFX9cCTfzRRQoNJLTpc7/dAnGImNjffOUGWzcfmyo+6dBfZBHR4Up4dOAGnh9tlByKc=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 03:33:03 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::79) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.12 via Frontend Transport; Wed,
 30 Sep 2026 03:33:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:33:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:57 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:57 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 10/20] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Tue, 29 Sep 2026 20:32:23 -0700
Message-ID: <20260930033233.1727265-11-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 92185e2f-7a09-41b5-e93e-08df1ea388d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|4143699003|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +21eN665RNiSu1LTJvmM18xmqz7FytX++sPKfcVEUTUsV9i8z+UPn7bJKaOA2EG8AUZ9kBltcMxDlHyQLIYdzpX+98Yj9L7sKWPSqIm3szU0nNtagWE+aljHXssz1OaRR9V+GXI60uAcz8qM+Pyf8K/YufMjifRrcvO6uWq8gUTSLPyGRFcpFPiyQyNIJti7rz2KjeADEV6/CjO7NWAQ5Uk2c7KBOXUPjQaoGYJ/N8uGBCnYU1Uxc2A/Lo4p7lMFCkonKRG8ItC63pR6G9C+1Ns8TxZFlyEhmvi6xoEk942AfDjuvgWtvsSX1+SRj7++8+FWs1X/ZLkxpxB7WzlSavTqgT/9CYawwzky9t31gfibCEQFwV2hdcWfmOTpnBFaHGwej6OG6G7zsMBjBdBvpsfH2vw5JAKTp8U3NpvbMPt0Fn9c52xt7bB/y4H3Zp1D+nArUlmhqc1vqR45IQ9ky5FIqaAse0iOAHvrt/XvLev6dXxCDUkQr9vKTtVMKe0xZpRMdXoHuX3uXHp4vypAA35kFG0f8CJKVDG7WC00LWhD8iNGv7JQCivvxK35YLf9yA2+mu3+7AhBUGzVEh2Zor+lXY469jG0dyy6yBy6Rm8i/if4UUQUHQ4gMfKnleJ69yEMrI28SskQVLXiVGqeVMnb5HwGCu/K83g4IGowELYPt8oLPPVC5I2hW35tV8BLB+4Rx3mEuudDfSc6mzygqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(4143699003)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oH+1etiRB3FVrxiUjVB+FHW+jPyN0hBg2Oh+BnLSm/CTmYaOBZfN7yvHkHp/HBXweLLm/IixYJ2UCMuzNDaabIe8tBHuBnUYDBPlpMWXNcVKOz29vTt5XAa3MSZEBxt4QF40cbocQwURUT6v72DgNk/bgoKX3Tk0fG3eOOBgwhGaP64ELhOXcpjmPcgoZv+8chVdhR8xZXk3g+Cg7/6n2HG29PdubTq8d08AFSSVz634hUA5fVogyPWuttmX/Dc8Y04f8rDhp4htopepNRkq/OwBLasL2LUV7zG6zevyWvhMxaQgA+NHJYG0Yi2w3kuIB5mb5ghfn/DNnH6OiPbcZIAa1DvrCUOoarHabWCI/6N0vGWyEfV9nyK9pDX15vZysgPiqrkbw3g5bemZ2UZLsmFN34C9P4bmuMKQcVTuDmZ1MvTSSr8GieQEc/idn42Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:33:03.3119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92185e2f-7a09-41b5-e93e-08df1ea388d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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
index 60348ec5bc53..b1742116bedd 100644
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

