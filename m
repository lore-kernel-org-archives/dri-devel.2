Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD844CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFF7112311;
	Fri,  9 Oct 2026 22:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6kJJXd/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A4E112315
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hssyz0c0sBCc6nAfTJ8h4IhoBlvBCEytj9B6gYXCKSCOwycla+aSU+So4f1HQeterA5Jpk80lVHjVUD0Wtpwcne+brDghYxXA34nkAsx0r7/d9DX9D8Xsut8C3TPtV52/yGpZp9RU8Ux8kt3CQWs5YjnVUatyFvpoCrfod654S3iaz6V81yLUvFGM0YKeXRNTY45RTZLfofeRoLGWSMBLlEKWEQxk1nBU80NsgkDdwELelmtmUPn6xA2q1GIIN3lY8wD/oVLUvQLmz8YLa8lIC5Z/f1xXsg+fXYaB6mrvMCrHWdbGkk02twpwPFUsEQC7lU9DirtFaz0cC6UfJNapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2aomMM6AihMHNG54RGzTErmPdjDmrdz2+sFz0l2+Ik=;
 b=vjTa5QcCgShtFDBXUHRT1I76B7LFMlyCkt7wx3DhGdep2EcDuHYlaKxsoLiLY9FG0FwaNV3nMD4HwU74RZ8qa29yF9Q5p/tPtb/RpxG1TchKY1yoiR0bFU6G8mAQzbkxiQN43IFzfPFdpxzCp1UzVchbMz0vFR0sfjRuB04Q5A9W9LNlcS9BiJsr+A0ZbQ5+GaaFBlODTRe25xLmRKAuYSGpXqJVMk6Y1PW4miK7ZeumVxcC/3JcI7mUtCxIpb8PqQphTLU0I1ErkEVUwh2LkCdpjxfgE0PKTRM/obTD4kGzIFcANYZ5wCz9B2GaTQRM3VlAVM3qCSY6USbrt38ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2aomMM6AihMHNG54RGzTErmPdjDmrdz2+sFz0l2+Ik=;
 b=R6kJJXd/PoxZr1kr73D7UE7lDthKLI3IyNCLEn+SNzLODtLt0B22zfIMrWGR6i3W0nmBAwI08reWN3NExMoEEU+E9e2IRy/M7nJqD0mAHMCZWBNxGlg+TzJ6OuNAMn8IUTsoGb8YYFZJqg0mfcvhqBzlWTmPAghIBczirm3kQF4=
Received: from BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::14)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 22:53:57 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::9b) by BN9P221CA0022.outlook.office365.com
 (2603:10b6:408:10a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 22:53:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 22:53:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:52 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:51 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 10/19] accel/amdxdna: Refactor AIE4 hardware initialization
 sequence
Date: Fri, 9 Oct 2026 15:53:34 -0700
Message-ID: <20261009225343.3079074-11-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 21be6b03-24fa-44c6-c6db-08df265833ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 0eLky9JTdiuiw+5xx6JCHlqAEsAXwmb0XiZNwTyDC4CrXmYg9X41YwCxUKiGRQHRo9tAzX3omLdMNCUpV5D/OdWx99D2MYX58mmylac1bLG7hn4Tv0GarWyIx34j2Gm055vQanqN0GMT2zuqDjf/dRxkYTAS/S1gWhM1QnDDMexYo72yY0EuB8OSm2Q8ibqdCoiH6kWvK+rZt06k/jwQEO2iv8uIED9g6t3RuLhdCuwCmQFMVJ0tz3/rrgYD0Xtl1Ci0Hrl1N+ie3Q4DXglkNz9RRy0+lBM7XNcx6gsZL/T2NW5YsgdYFHiXbu4zQAGM0RDkeb/CAzmKzqrwo3NzwiprgyR2BaD6pzPaj/eRktHURCi2TsQrT72XgQACVIzUKsGQSHd8m0s+jxV4uD8oawLV9URnrch/7RflJHCDcc0AyUXCoBljAeKAzAM6xppFhVDQEx+gU+RkiEUdOV4wvgfxH/OsH7QFZusnbZoNT2nXnIarxhQJ9VNB9EWpxXF1J0VpXn+hScgpjqghbS+xpkdmduPa2EHlWn6x1Jw061pI3GFrlUjFO46trWB8ROsy16vOzRw4rAY0wg/BcT0jjqiRfXEnmQ9Iw3mTNymtMu0TJc6El+dwUBD1t8HVE0jc+yOYvaz+lVOATSq7+aZ/q4gEHeVpqOF5Ua7flp/Q0BDxTAkd/K422afUrH2NNt/f1XSAi4VOVhwaxJIGCKvagw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HQT90j/QIfiZHdDVaxVSUtq4eZEjx/gjESPPa1dINNZIKpbAFjayQFD7p2nmbB5I3Bw20xpY1M4oPBM6oYLOmXpSJLazH+4h4YDPmNUrhJ9qFyZALyDKnI0k8rCH1g1Nf9kHizdK+EUYxeWQRA0yunWQBkuSzzssbxpRZ9TZh7DnvffldcBjTgF08hHOMSnAHWgp58fX8ybrkQj7LBXeyTmuVcdgrtodUTFISdM6dqokTf+M68NLZaaCnT0VtsxEZa10sxFwO1e6KVxYMBEiWPj5rFhDV4p+PzNC/9kyr7Lb081ZUqWOaCds14WLO1TY/xxD0GJcKaXlY+iBhtzVljqPjrOJzru7z+LFCKZFQsSNQwZaKpk7xHhSyYibvuIF8eRCBn3Ixb0nHbDHvWlMA7l+mMZLXd1IMfpgSuWBQ64r59gZMOLci3BuWGyVTqqa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:57.7228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be6b03-24fa-44c6-c6db-08df265833ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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
---
 drivers/accel/amdxdna/aie4_pci.c | 79 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 446ab2f47c7d..ffe78c0c4e8b 100644
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
 
@@ -280,7 +280,8 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
 		XDNA_ERR(xdna, "partition fini failed: %d", ret);
 }
 
-static int aie4_query(struct amdxdna_dev_hdl *ndev)
+/* Verify CERT protocol compatibility before starting hardware. */
+static int aie4_query_fw(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	int ret;
@@ -293,25 +294,6 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
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
 
@@ -340,6 +322,32 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
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
@@ -352,6 +360,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 	if (ret)
 		goto stop_fw;
 
+	ret = aie4_query_fw(ndev);
+	if (ret)
+		goto mbox_fini;
+
 	ret = aie4_config_fw(ndev);
 	if (ret)
 		goto mbox_fini;
@@ -389,13 +401,13 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -405,7 +417,7 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 
 partition_fini:
 	aie4_partition_fini(ndev);
-mailbox_fini:
+mbox_fini:
 	aie4_mailbox_fini(ndev);
 	return ret;
 }
@@ -432,17 +444,17 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
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
@@ -452,10 +464,11 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
 
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
 
@@ -529,8 +542,8 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
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

