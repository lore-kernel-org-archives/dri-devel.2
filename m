Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68938CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E6A10EF75;
	Tue,  6 Oct 2026 04:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0mRwm5c5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7B710EF72
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQh34A7jobi9NJ8IKxE+MRLykxE4AfWaG+drmdvg3eDplnK1CMH08b8GPuhp42/KkaT9eP8KRipD2rw0byczYB6YRqQvuVKnihzmr7yqgpAUkdNFreso7GzwsHE9noP2uWyC0kFm/OUyLE3uU9Al8lrE9kYc2gvHdltTvACYYsKIFNjAyOAxsfQeNnabaf8rH2dQP83cSw1zcK0sCiKZ1d5C0sT/5kCo7DSv+j0E1vYdNC4/eGmEH6Oz4NG7CP8csEjKFDNkG65bMaqRMRzeb45SyiiXFznQtfCfo7LSIXSqjy2Kfnt0a1uphucsrmCmKjTLLlTV4YRWSXKRwKOj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgqseSY2qJIsC9fCXtuBnSJSgXP7dOpf4KsNunJvkJg=;
 b=urmYoYAvtNrXEDUi+2LjrI0/NfLmuCqwLR+/6rU29yoSotYNubxyITi35+U9ja+ojJrhjfV3+ZOReWiY3Cea3JZGKFBaOpkNI78sFgKrR+0edMh8jU8zVO6v156ZhvCNJWCkabeMZ/VhpaWUx+HFeNp5m5sfaERu2yanxLTM//QkNHPcnhXtGIvCKZeUcjtaJAwJ1d5QbkLDfDzK0Km4XkO629s7t2V5OmgK7ojbu3So21UWGZrPnrzMWOa847rn8Xq54zzxu/r3kGbHLzVF4HEH1JBGnjdsvTDZ7kgUgctYkKTWCzd6LefTqSZ7TxxlkEeSTb3jNAEoxksHmeb49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgqseSY2qJIsC9fCXtuBnSJSgXP7dOpf4KsNunJvkJg=;
 b=0mRwm5c54ynkuLc+N9wdEB3gZAgL7py4Lcw9EIM31n/U+tzOhE2psRhClDJO1/SDEVbGx9lJft3t0ZAqAy7t0x2sidnZJ5drxvw1FEqULDXRDQJob7yWxTxuUJJZ+0GCHmS/HYkhmHWRXYKKGrVnfsJJNv//8r6lFWUaJQabrnM=
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by DSVPR12MB073533.namprd12.prod.outlook.com (2603:10b6:8:3ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:22:56 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::84) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:50 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:49 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 05/20] accel/amdxdna: Add NPU3 classic device support
Date: Mon, 5 Oct 2026 21:22:15 -0700
Message-ID: <20261006042230.547807-6-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DSVPR12MB073533:EE_
X-MS-Office365-Filtering-Correlation-Id: df753143-1588-4030-da90-08df23617f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: n9V2PSEuezc1xFoqgauwf9oyBXMOeDUBf2u+lLdBfqrNqWMoeu3UMQlkKrupHVhQeIU7/JVrPOQSeWlfc7dSrV05RCLNLOc8vx1pRIhpSFT0S5zADjNPVD3+eVxwdAjclrX6WNWeLcxJBs4nSLv4AQOoRoIsaRTAD2wbdT9QNUgfBbH6d3IW/cR9oCUQPZpr4nbDPwqF5bwB4pAGLFob3QfrV3ZaDB+cgsfbnojXXjuBXAAEZHvO7r08JSM2V7+cIIz/F5tTmMb9OWBhFM/2afbuCuls9agPiuUcAQ6XuWZ9tM4x5s7i6m3ML66AgQOjpH9IeCAUfJQfgAUu4DO94IjWZdAMhdJ+WVPqEfn0fShvnHXZRZldQ3p8RqpQCup533xd3Wwb74nyZPatRQVczz8x3qvpX4CDBq54Kt/AyUQjGlEo8eh7oFaQJ30n58l7YJTk5I24DF/ivIyNFG/dsMK18tDCx7rOsTzb6R9Wsr6dbtTf9Ai19shZH6JTl8vDfD9KZ+Sc1tk3tRD3LCDYKP68EFZf9gIcfMnB4oAMYj08tJX6VgYAbTPC5GM2GfUPoYsG20uInfqKK9sp8JflWQ8FtG5Camc4hYQntMQ5bi4QXnGLwGQYJH1BZ+PF10yf20XuUtcwhII+U88Wzix9cTbsCmySeMoC5KX6g6wszNblSVaCd5bs77kYOkZbtepBdGzBvVJekf+VP96c4i/TiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHpNRwF+5afRBUSLMz5dP4bmtYjMgqE6lfz2GEk1q2m+lfAf4yqSb/mwWxiX4MtIDYVlngP0iBo/E7wIinoibKIZ0mKZftce8Cp1qaonWxoGpuj9AxCE1geCh3CNrWiRblRgJQv9TjgAuHTQ83zTlUNqoSdHlVnoLpfxHYecBUJbG1Z7+NlXVT6u7r8BgIZEI4nRaafbLQY3YHCmCUzhdNpvMhDj5IpPmvZrK5/wtq77+6d+BOPBV9/2xozx/4vPpr1LOTFveMJeQWBM/fvtLJ1PBr/4xSXEWr+F41efYiTusc3UB9ZiB4C/1W4aZ3AG43cDcRMMiT984p8gtRNl7I6R4YRAKfv2MDelibQypGtJi45Szo7I99Sw3M/XyWg1wNOzngiAbtCtxXAA7OHMmbRSMOhWTyI3NqNWOoFA1T26Ngd8N3di5OEN+gFnNTyz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:56.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df753143-1588-4030-da90-08df23617f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB073533
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

Add NPU3 classic device operations (aie4_classic_ops) and register
definitions, as well as the PCI device ID and firmware declarations for
NPU3 classic devices. Remove device IDs 0x1B0B and 0x1B0C because those
devices will not be released.

Also guard dev_heap_mm initialization and takedown against zero-sized
device heap, as NPU3 does not configure a dedicated device memory heap.

Note: System suspend/resume support requires draining and managing
in-flight commands by leveraging the kernel-mode queue (KMQ) infra.
Full suspend and resume callbacks for all AIE4 device types are
introduced in a subsequent patch with KMQ support.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c        | 83 +++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 23 ++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 drivers/accel/amdxdna/npu3_regs.c       | 14 +++++
 5 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 3cb81bc1b627..880619e3a4a8 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -359,6 +359,51 @@ static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
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
@@ -621,6 +666,29 @@ static int aie4_vf_init(struct amdxdna_dev *xdna)
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
@@ -633,6 +701,12 @@ static void aie4_vf_fini(struct amdxdna_dev *xdna)
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
@@ -647,3 +721,12 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
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
index 3140af69e29c..f5f7831c4e80 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -28,8 +28,14 @@ MODULE_FIRMWARE("amdnpu/17f0_20/npu.sbin");
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
@@ -55,10 +61,9 @@ MODULE_FIRMWARE("amdnpu/17f2_10/cert.sbin");
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
 
@@ -69,10 +74,12 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
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
 
@@ -140,8 +147,9 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
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
@@ -176,7 +184,8 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
 	xa_for_each(&client->dev_heap_xa, heap_id, heap)
 		drm_gem_object_put(to_gobj(heap));
 	xa_destroy(&client->dev_heap_xa);
-	drm_mm_takedown(&client->dev_heap_mm);
+	if (client->xdna->dev_info->dev_heap_max_size)
+		drm_mm_takedown(&client->dev_heap_mm);
 
 	mutex_destroy(&client->mm_lock);
 	mmdrop(client->mm);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 0002e6ef32ba..953bf783b3f7 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -169,6 +169,7 @@ struct amdxdna_client {
 
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

