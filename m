Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C9606AEE7
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xYVE7DRC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D6110EF58;
	Mon, 19 Oct 2026 16:48:35 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B10210EF4C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcyrT3RNE0XiFgvlq5z19v2peG/c2bcwiDe6sS3PulUWmMimR48GCjDTd/gvtdZtKt7bKpkn8JvQPrkkqDtT7xv0DO0BIYtKpeZrJBoa8p2TE0PfE++AoFWTaqHHeS/xrgMBKtZRPBRTYLCmOO0mTieElqeXcsAg3PxmUrhV3c4lKIZBV3IZZMrfCp6hw8ahoYwDP8OAg8ZR+GECeWeqtooAQLo7OmHEx1xgbfPfkCB0sCAeVVbwcP/gw1kyL/7tN7aSKgWNVsImktHzePPrBXldgYij+/omOkHpLjuDdr81VVhVphWjsiaXkn/rhKHZ2MhXqlbUmwsip28Sr+IqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke9la3yxYRMt5c/qW00x/3z30hK0V6G++wjq6ckoaes=;
 b=AopM4lzZgcO04xKuCah86V44rIwJNheIA/X5eda9+dFdOiBBOjDEvX0ywSF1yR7eK+xbSNg3qlb9kRi3zDeAU7wJGEJrQMDhblSaKK0udsWgCYW3Aeu8+QttoHX89Ho4iwEQEsKurzO/3K05hiNg6lfcvSxrd7XTql2xzfNPMfVcP9de2Oj6TIFDDKcXRUkcy+CS7Sy5WlOJIzmfbvhG41nmsKWaGQ4DQdNTutbeXFhlpxedxL+VycZmx62pTkCgNqWgdvHGg1usDSJCTFJ7iTCv8CzEYDP6iMSDJjq2zNtblWozR50rSbno59sIFI24dHJXJRVtD+vw9Szb/vVeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke9la3yxYRMt5c/qW00x/3z30hK0V6G++wjq6ckoaes=;
 b=xYVE7DRCFCamSOKYEOZSL4ZAv8CmO9xmB6nzLova1SvTjgw3AhJEVBAtiBiBt1bvlEY/j8hBwbaUWhSRRIxc+aUJwNUof9SOoQ4LZu/gk36hhuTST7IQfyBhvhVWvTb0gov0ImJz52vgNgc0UsfoBVNOr2G1edx29DsjOfbE0UA=
Received: from PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::18)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:48:12 +0000
Received: from PH1PEPF00062F27.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::13) by PH7P220CA0125.outlook.office365.com
 (2603:10b6:510:327::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:48:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F27.mail.protection.outlook.com (10.167.243.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:48:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:50 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:50 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 10/19] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Mon, 19 Oct 2026 09:47:37 -0700
Message-ID: <20261019164746.827277-11-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F27:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2008e4-225f-47b8-ac87-08df2e00c398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: +j9iv/B5p+iNPssLw3z+tad3gCADoADlUIEYiVMSPpzPv6kqgNcvyOpHPjUNjDk6ajQO+GqZw/XJWHZouRzWyqZS91GAwARM3uEstclm8VVWNuGXsufNaQG0+9upqvGT4c1sC7sCBBqXsKHO2eTZinz3LXN26AlpAWZM2GuU8GlHKcImdIzp/PEq07CKqeRMpTpkx2FyHW44a1VRwtQskw8BZSFvzAIBPWoA+Za2yCp83qkyqbx2fxAiYdT8mg4YeWWrBJn9wEjC2bJO5GjU874kt6ATjra2n5Sg0ei0oJAH9SYsxUQdfB+iGdsJ4JJqrehclZJ8EAkX0LLUqm/RDzMtQP4wUEIG/1kleEpxQi4HNS+Hvg+wno+L440AN0Vd2cQZT7Ri/aWP53EM8pUVVRoLRDgZfdJTacTD+y8WW+3RSDYYq5MfBuWg2CcL/4iaWDH+z8RVLcSRdWyBGjvVTehE3eJbtmwhaiUHUZzIBFoy+Wq/jNm2fVCqNOCG47/F3qlCgJt69V6b/toKXZDBgm2MAOp2Ap2QLpPEg8QLEECsLeAjU6AJcknwhCE2JF+5UCnejZyUHYITGUS6xrBH6tnAHNQQlh6ZvDRtMtb9+bt3qgjs0ZyLWygrA1EOTMAOL4qDXWDcCIF582+bfsWV+9pVPXeYkZQYkSWzGnQn0QGxmPT/Q7KQBk+218NmT7y2sHL6CID4g15PufTjLEOC9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z6unDV5B9ThAn4JQz+kpPaeDdIGxIh+6FqKijvVhX87FzseVO88szZYRZcrZLGAF0s//TOC1k0X74Dxy4YwSUoUV2oKghSyRG8b1QVfuscNFAHdS8dACMPQQ8r/UtBxgyCbWykSrh8G+j5FKt+6+LOruzKe/npV5kR7NkkCeZcrm9+6Ar3pwt7pEpuIuRhg1Ig3KzA4mDqCWP1TQZ9N5aYA4SVAMyl54cpm26XLTYMZ5/SFXy/fZr67cvWiPKbJfJyzslcOkQbhvLVtgvUQOSbia54YNTEnHvItF5Kx6oR3HLEJAXMWyz3GI5Xe0YTHPdEEBfCHcuWsiJI7peoxwfzrDBbJ1hhDkWvAkq4aTl2M6opPxSXAVdvSI7X1EstQ366ruleewTgGYkKvJ1xNPqBGkhFdxAv0KvfDV+n7MUcXaNRkxz0nJD5uznTLL4Jj9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:48:12.5212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2008e4-225f-47b8-ac87-08df2e00c398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F27.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

Reorganize AIE4 hardware initialization into distinct phases, next to
the existing aie4_config_fw():
- aie4_query_fw(): Query NPU and CERT firmware versions.
- aie4_setup_aie(): Query AIE version, metadata, initialize DPM frequency
  table, and initialize partitions.

Update aie4_pf_hw_start(), aie4_vf_hw_start(), and aie4_classic_hw_start()
to use these phases and unify error unwinding labels. As part of this,
aie4_pf_hw_start() now also calls aie4_query_fw(), which it previously
did not do.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c | 79 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index f59394d62d9c..544a7d6a02eb 100644
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

