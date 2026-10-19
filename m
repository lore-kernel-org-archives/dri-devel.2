Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5560A5BDF
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3kol3F0b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FE210EF54;
	Mon, 19 Oct 2026 16:48:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D3110E6E2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYQKmyuVgI6j+WTfH3SLx9ovmLI2UxH7OwjVx/J1c3MktQZSxVmxDOXMhsj41QBHxcZNE8W9OeUo8VBg+Hkib0I1P2ej4gAhQG+E8PI7kKck8osiuVvs0DQLUjTED1gSIWFgChbHAQ4QKdHcKDzDRCIU2U/m3j6sky18/rbPrInvy3x8vjLPlGPbQ8ujlgeW8GV8Khv7M+LQtwVwbrkurXcEM+oPJLATAwTcqs3HKCJzwUCMzSsLAGymJZvvmsRnoBYEZbjQtiLMF11EnQfe6k90I8NZuL/8TKbUkhf1b3dpKzo8WVTpfuJQrQgYDcoyGANz8gVFHZ47pKsZH2FeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mMBmIIMiH0DH5X4Qrk/RyR/mMXf//wy8yU7AEIZDSY=;
 b=iOcGqU/Q1vwUAZkwEqr4XprV4My6EEkS4Bkwmy8Ht5iMYXFuVKWoNR6BDia+/N8zME1fdU+5gogeP14mn3RcRnN9yNeSYgXX5dyM9B8viRIqiD5Lmo7TfKYQQI21J96xAJqO0zRbPaaWEI5criO0ZQPad0e0PvTBKjnL/t8JfPb7ckRCKEpR56VjZRDzDIpl3H0PtOMw6N7yC+EfFBrepna4n5MktRcH5pa7W64uyT9S17agmMMWVIJ9dZ4J8D+OZuTcDmVCPcPECi777gZwBwaX6rHhh4rZvZKCuKoGn2TLdeZszR6K/OTTu5KNwsOVGpxBPHR441g9MXnlbH66BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMBmIIMiH0DH5X4Qrk/RyR/mMXf//wy8yU7AEIZDSY=;
 b=3kol3F0bS101JvamRQYpirIDUI/p+tjydzT2h7DdrN7/QVndC5CXVmzFzSA0bC+uzjf1SGFy+oZSIaBKqjA3a2xzf+kSOrFspS5giYdGfTVuTUQLYf2Oa32QA/+enw0qfVTm87C+7jkwx/T2hBdwrXnHT0E/2whFqIUJDcn75LE=
Received: from PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::19)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:47:56 +0000
Received: from PH1PEPF00062F2A.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::9a) by PH8P220CA0012.outlook.office365.com
 (2603:10b6:510:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 16:47:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F2A.mail.protection.outlook.com (10.167.243.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:47:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:47:46 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Mon, 19 Oct 2026 11:47:45 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V5 05/19] accel/amdxdna: Add NPU3 classic device support
Date: Mon, 19 Oct 2026 09:47:32 -0700
Message-ID: <20261019164746.827277-6-yidong.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2A:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e1a07c-dffd-452e-7af0-08df2e00b9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|3023799007|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: MFHAn0iT0hv2csotSl8XQkC/rj/Jbib5+uJCukRHWCL9U7H3koIE5YOAsXiyLcsQnxrZQL+1YkhNg+IzBmwTO5xAVlhMcpfqQ4hpkK0gI5vxxn1nKNuO52an8lFBlyHSDqsI6jKvf6+YtqKzJpxdtBxR86rsB3yr9DRQHnY59vWBG6QUfWeuBpxq2RXXHek1o80/frmPp0HDJXyTJE5DkMY0SOIC3AQ0xT1/Bodn6GvUazoTsadc2PjzW3GX6R/wx7i4HCVZVtMIT5t0q8KZcyWkhyaV/yhnkBM02bnl6mp84VbPVaYHnYRiR15X5dNtt7VJQ9cLhb+Vvd/1VFNjeH1aeFr8/XKsHpgr2C/b7K+EZLJIpE9Nw6Z3Edl8Nm+/TofZ7rVkc4XDGr2EBeQAewlFn1jfvqOqgmjyB81B6+kcH4ib/GJAC0/dBqV0xe/QgvqlmmdapVdBuZk+mehcocZH7eehpUkhUb+mXHheu3bsp0Xjfj8mhjGxxzU6T7MGwNZpaVgHf2Kk6epVDTFKdy89pEwrmGFV6Mc4bjnffeFGOtBf4z6JcEIBkNU+OZCyVhvLPeCsKBFFKR8rCmfRglQuwXOcrJ7GeLx9Nu/ahjVbEdFeLfhli6Iv6pX5dzApfT5hWM8DPLpMtpqyR5LZlKeYRJ0ogPXNH5IS9cWy8R0lJejQlNb9ZY5CO9Mc++hm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1AxQvHXdwChIFIc6W6rk4ecDOw2oN5CE8YSbT7yq8Wr2vtIp0kCqFCrmnylcHUIUxpCh1DwBSv/98LF2FFj7kFLfdyqODErqEoPCZoB1ndDId176brpf2K72qBeK6Oj+R3iryUmPshAGgDbGf4VSB6G0py6yjDZwa19SUNpmFNaQJ81mLAY+CK/wwngzGhemGMdbK7tSwbN4YdeyXbPrpco2FQdS1tVNsoaYsMZZYVKpL5TmWeL1gw6m+69DHS9DVFgfN6qJstEEi8IpB4z85HnIZG/GEvI7G2iH/czr2X0RsO3tLJ2wlzkVK3bbAWq6rEEBDuDWCMWMxu6Pk8X92Z9Z+5og5JYAIhe8pO0oUbnv4Uu0u5xPBQLfQnET6QWhpMt7Bafn1Hc7Hem4t5N1AcTL25vRT6QrLg03O/i6/sWfjnfoIgsn2mNKjZL1a1vw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:47:56.3193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e1a07c-dffd-452e-7af0-08df2e00b9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F2A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

Add NPU3 classic device operations (aie4_classic_ops) and register
definitions, as well as the PCI device ID and firmware declarations for
NPU3 classic devices. Remove device IDs 0x1B0B and 0x1B0C because those
devices will not be released.

Suspend and resume support is added in a later patch, once the
kernel-mode queue (KMQ) can drain in-flight commands.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c        | 83 +++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 drivers/accel/amdxdna/npu3_regs.c       | 14 +++++
 5 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e9cd2af224d3..1eeb1cb73b27 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -366,6 +366,51 @@ static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
 	aie4_mailbox_fini(ndev);
 }
 
+static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
+{
+	int ret;
+
+	ret = aie4_fw_start(ndev);
+	if (ret)
+		return ret;
+
+	ret = aie4_mailbox_init(ndev);
+	if (ret)
+		goto stop_fw;
+
+	ret = aie4_query(ndev);
+	if (ret)
+		goto mailbox_fini;
+
+	ret = aie4_attach_work_buffer(ndev);
+	if (ret)
+		goto mailbox_fini;
+
+	ret = aie4_partition_init(ndev);
+	if (ret)
+		goto mailbox_fini;
+
+	return 0;
+
+mailbox_fini:
+	aie4_mailbox_fini(ndev);
+stop_fw:
+	aie4_fw_stop(ndev);
+	return ret;
+}
+
+static void aie4_classic_hw_stop(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	aie4_partition_fini(ndev);
+	aie4_suspend_fw(ndev);
+	aie4_mailbox_fini(ndev);
+	aie4_fw_stop(ndev);
+}
+
 static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
 				 const struct firmware **npufw,
 				 const struct firmware **certfw)
@@ -628,6 +673,29 @@ static int aie4_vf_init(struct amdxdna_dev *xdna)
 	return aie4_vf_hw_start(xdna->dev_handle);
 }
 
+static int aie4_classic_init(struct amdxdna_dev *xdna)
+{
+	int ret;
+
+	ret = aie4m_pcidev_init(xdna);
+	if (ret)
+		return ret;
+
+	ret = aie4_alloc_work_buffer(xdna->dev_handle);
+	if (ret)
+		return ret;
+
+	ret = aie4_classic_hw_start(xdna->dev_handle);
+	if (ret)
+		goto free_work_buf;
+
+	return 0;
+
+free_work_buf:
+	aie4_free_work_buffer(xdna->dev_handle);
+	return ret;
+}
+
 static void aie4_pf_fini(struct amdxdna_dev *xdna)
 {
 	aie4_sriov_stop(xdna->dev_handle);
@@ -640,6 +708,12 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
 	aie4_vf_hw_stop(xdna->dev_handle);
 }
 
+static void aie4_classic_fini(struct amdxdna_dev *xdna)
+{
+	aie4_classic_hw_stop(xdna->dev_handle);
+	aie4_free_work_buffer(xdna->dev_handle);
+}
+
 const struct amdxdna_dev_ops aie4_pf_ops = {
 	.init			= aie4_pf_init,
 	.fini			= aie4_pf_fini,
@@ -654,3 +728,12 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
 };
+
+const struct amdxdna_dev_ops aie4_classic_ops = {
+	.init			= aie4_classic_init,
+	.fini			= aie4_classic_fini,
+	.hwctx_init		= aie4_hwctx_init,
+	.hwctx_fini		= aie4_hwctx_fini,
+	.cmd_wait		= aie4_cmd_wait,
+	.get_aie_info		= aie4_get_info,
+};
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index bdbb2d7cf0e7..940e67347d74 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -96,5 +96,6 @@ static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 
 extern const struct amdxdna_dev_ops aie4_pf_ops;
 extern const struct amdxdna_dev_ops aie4_vf_ops;
+extern const struct amdxdna_dev_ops aie4_classic_ops;
 
 #endif /* _AIE4_PCI_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 0842fd31c9f2..a8c29546d49c 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -29,8 +29,14 @@ MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
 MODULE_FIRMWARE("amdnpu/1502_00/npu_7.sbin");
 MODULE_FIRMWARE("amdnpu/17f0_10/npu_7.sbin");
 MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_10/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_10/cert.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_10/npu.sbin");
 MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
+MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
 
 /*
  * 0.0: Initial version
@@ -56,10 +62,9 @@ MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1502) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0B) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0C) },
 	{0}
 };
 
@@ -70,10 +75,12 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
 	{ 0x17f0, 0x10, &dev_npu4_info },
 	{ 0x17f0, 0x11, &dev_npu5_info },
 	{ 0x17f0, 0x20, &dev_npu6_info },
+	{ 0x17f1, 0x10, &dev_npu3_classic_info },
 	{ 0x17f2, 0x10, &dev_npu3_pf_info },
 	{ 0x17f3, 0x10, &dev_npu3_vf_info },
-	{ 0x1B0B, 0x10, &dev_npu3_pf_info },
-	{ 0x1B0C, 0x10, &dev_npu3_vf_info },
+	{ 0x17f1, 0x13, &dev_npu3_classic_info },
+	{ 0x17f2, 0x13, &dev_npu3_pf_info },
+	{ 0x17f3, 0x13, &dev_npu3_vf_info },
 	{0}
 };
 
@@ -141,8 +148,9 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 	mmgrab(client->mm);
 	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
 	xa_init_flags(&client->dev_heap_xa, XA_FLAGS_ALLOC);
-	drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
-		    xdna->dev_info->dev_heap_max_size);
+	if (xdna->dev_info->dev_heap_max_size)
+		drm_mm_init(&client->dev_heap_mm, xdna->dev_info->dev_mem_base,
+			    xdna->dev_info->dev_heap_max_size);
 	mutex_init(&client->mm_lock);
 
 	mutex_lock(&xdna->client_lock);
@@ -179,7 +187,8 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
 	xa_for_each(&client->dev_heap_xa, heap_id, heap)
 		drm_gem_object_put(to_gobj(heap));
 	xa_destroy(&client->dev_heap_xa);
-	drm_mm_takedown(&client->dev_heap_mm);
+	if (client->xdna->dev_info->dev_heap_max_size)
+		drm_mm_takedown(&client->dev_heap_mm);
 
 	mutex_destroy(&client->mm_lock);
 	mmdrop(client->mm);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 1b044646cc8a..11f4cc53d45f 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -178,6 +178,7 @@ struct amdxdna_client {
 
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
+extern const struct amdxdna_dev_info dev_npu3_classic_info;
 extern const struct amdxdna_dev_info dev_npu3_pf_info;
 extern const struct amdxdna_dev_info dev_npu3_vf_info;
 extern const struct amdxdna_dev_info dev_npu4_info;
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index 93f749acb5d5..c82433d62901 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -105,3 +105,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
 	.cert_feature_tbl	= npu3_cert_feature_table,
 	.ops			= &aie4_vf_ops,
 };
+
+const struct amdxdna_dev_info dev_npu3_classic_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar                = NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
+	.doorbell_bar		= NPU3_DOORBELL_BAR,
+	.default_vbnv		= "RyzenAI-npu3",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.cert_feature_tbl	= npu3_cert_feature_table,
+	.ops			= &aie4_classic_ops,
+};
-- 
2.34.1

