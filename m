Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF069C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A62910E9E6;
	Wed, 30 Sep 2026 03:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ioRSgl+A";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0795810E9E0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvg2R4L9gYUCMP4gRYTjYcatOLh+LLepQ1M/fTQBlF8MTrp5DuUwsKIsM6C8Gq27HRDLlG8+u5rAwDrgyRju10XnInMkDU3t1OZ7XO81DeyfuTUgJWvqq3zoZJQJH8GpXUGHR9rb9pjZnRVVXERXSE9V6AyfAD0l5ddBc1jY7MfRO8OrF8uja4J9mAHCN+QE73RJhJkodxuAcyPU6iQMyOx4brsopfoHyecEgFA0caDuHms35KhkapEzJjTD95VgC3GEbeeS7+prJaMLrPu2jgMy5w5RqPO+HGBzVf3pcLMbZ4XYBju3k8WkdKVqFGc7ePC5fP+gVtTnByAbk+UhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPMTnSvi7LRty2UAqEkxku39xQO2txUk1GnUVeG35rk=;
 b=EhO7FwpYLADwTI1FNTiuSUquOmX/Vf0ZLWzwpwYv1mtbAFIfEXnfOAmnFI3nf/qIlzwQl1YeYyvNctmK4ffQB0YKPO/3VEWmoILNKRZDuUZqG/vbtA6klLT+ubAA3OcnsgHrf2CIouCRahCREmOus3svLmUf8z0dXKfdN/ISP+JGrqL4x3jISZgiPdA11p5UkRXf1vap7Clh8mcXDc7lPEVe97OCCQ/vHHtmUXDlXi0AWSPNBW97++8iwv57/OOLVibLPIQO8miaaHjznXVhBaDNtRkZ6/bvUhtB8GQfnQd63b0epBvm/l5Ok4JlHrdzG9RsuATbjjiI12VvtQG2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPMTnSvi7LRty2UAqEkxku39xQO2txUk1GnUVeG35rk=;
 b=ioRSgl+AG1WJLUQELM/F6kAYkOTQqmkavGX1bEtwDDWbYzXmE2s/I3L6m692+tyZWawf/FI4HSgD9LglIBgtZ7khIA5y6ZofvYzWDJ65Jo6Wt9ajqrHBOHHDbg0XXS5HdO/WQmQ2DdXsJnPfdIEk9XcoJHyBdn+GkcItFrwmKAE=
Received: from DS7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::18) by
 CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 03:32:54 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:25f:cafe::4b) by DS7P220CA0121.outlook.office365.com
 (2603:10b6:8:25f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 03:32:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 03:32:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 22:32:53 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Tue, 29 Sep 2026 22:32:53 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V1 05/20] accel/amdxdna: Add NPU3 classic device support
Date: Tue, 29 Sep 2026 20:32:18 -0700
Message-ID: <20260930033233.1727265-6-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930033233.1727265-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5ea100-a494-4130-8ddb-08df1ea38393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|4143699003|10067099003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ikfXDFdJAMg0ZSLrejx6jM1e4XpxxR0SfeRmMjd7lNQj3Xn9dlHTTCMuhfZcqPfhoemEbSGU35Jb28y6WC+8g8ZYCr/iN3xKIECwXqZ2gb8yHEkWkGOB0qrEbQ4ZRAizzDj2onqEkK4XlBp9g/ojhRkZ8KuK9QQAyN1FikVWwoTy7l+bv6kxsneat8Metuw8QiJvbl2zcolXsneqkvVx2SZUbzgfSTluNYw7xyJ07+MRCwZYblfGCeDesMsLatOYJtT30wYnOtHVLcQCRKJAGHgfgPhwCPJ82W+Og3vkJqhoAMGqcq9wwdzxlAMNC4B0n1RnEXnjz8MQ0LRK5fciu6GvzmsvbfwqHmk1osDr1wHL2/N7Dj7r/ayarkzFRxMIwuM2YkUguQCdCKlUqoH0CIwM2xOzogrE61rLG+LbSNwmjEk4hnxJuZcjscIMUpaLWbupF5VwwqD6vw2NEk8qPlHoe6cQS+LeG4+VgXhlL6j5ILFgeGRUb0RRp6gRR/XHxbGBhHduDVXNUP6MLCE2Jv9KSVsKIZPKzgr9lp5hU0qngMaE3g/4DqrtImf0ECJoa4IeH//bwRk87jdsuuEEVxdwjfcy21jNrZevKCVaqhI9paTojs7x1rTIXQkA5XpoHl2su4Nw79BKY6CJZ5FW4plWpdGoj9/ttIJyDiezqItiB7Mj/pY0zbshFaoB1wM90LFW+Bb6gjLvLGCrUFmjZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(4143699003)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zOcTg4L0YswyOtqSTvaJqmCaFugn0BLKhUQKfhl76F1SWfJpbGnbMmx1e+hwB1X/9K2vNffPsldG58S271ZljZaf8/STI6v7ZkhXMAYYca6Bd6v0aiK7XqPJxp51wzccfsRZQydYZJ6LmOdGcxvj1NBZwxXnyhpbmY9no49rRFAp6r+gwrxwTl2tfVvWWtNVvaPEr86aElXBSZ+InGWGfZgMEcfbO4B1a8o1UPRbgZqNKZUk5a0QLu3l1zMhSj6wEF1bNioyyj+AKdBM088gNIBN1wBeF/Taf2lxAvQrf7qX6CpJI1nzZOzsP9u4KUSdQY0Rw6YxxHSn6K8hk5uChyWIdv975Y5s+RBinPeR3jccaKeRBBJcyKdxE0CC8dCAhvj89TWsEo7WOg7quHBRsOGwANU01miudYSbSjNQi+A8kKSb2u3SY9p5W+F/91TH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:32:54.5520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5ea100-a494-4130-8ddb-08df1ea38393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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

Note: System suspend/resume support requires draining and managing
in-flight commands by leveraging the kernel-mode queue (KMQ) infra.
Full suspend and resume callbacks for all AIE4 device types are
introduced in a subsequent patch with KMQ support.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c        | 83 +++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 15 +++--
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 +
 drivers/accel/amdxdna/npu3_regs.c       | 14 +++++
 5 files changed, 110 insertions(+), 4 deletions(-)

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
index 3140af69e29c..8b6e7283e057 100644
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
index 891c5f243ae5..21e24901976c 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -106,3 +106,17 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
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

