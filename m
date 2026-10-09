Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD29CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089E410EB7A;
	Fri,  9 Oct 2026 22:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yze6m0R4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1829F10EB64
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp+Naq3TGMYKL+LHLp0x6hfFQB/kTNM+6QTYcLdbr1T5ToiuoUb1K1kuclQEpC73sFDUQjaL197YQYl+BHb9IwWSG3ci+wl/GMHCRyMfmU41L4ciyqzb/W81Ecp5luk93OPioesvkglxfm0Cm/xdZlZ1on2j9LDL0I3RyLo4mISmpJVJOjqaI2k75mJuvvfbIAvzZr7QCiAA0K8wuo+AthrAayfAQuJTy15OyJqVfVwhbhKfwUBTPllTbFADmQ5z8Vvlcvu56Hm22DZirS7aKS6/k1zyRVWvKw9de53jmxIKyYRlI7x/ie/rISgGk2kTx8CjcsDked7oCmSmjQ4NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdhM4ef3HCIQG92oVIWlX3A0luOb2msqZckeJKMiOTw=;
 b=u+OibBeAaGQrVxrsMjrsV25q3YMRtniJs1sSitcZKkWNQPyOJLDK5fLsn8IPHuI0H92zDFtzomP71idDbFOi0MtFtMEJQdJFHWEmdeRPM7dqYLtUh9APxW0AQvkt5MohUbo3LVLgFuKDmt3Feg9Fmm8+vCHohwUUVA9NRJnYf+HKZHaKM9kCAMb05ppnpYNMkS73Jye1El29mqbFXUoB4GdLJa6Ju51xXSSfX2wSGDJ+j40ibzss/G9rEQAwlH8rZ79zBmlBQjOFb3423cqbJHYLBVGa8sebdUtg20YKvFRamMdLjB9SNQRumXBc7L4Zor4GkcDHp4T+jQ6OA1OwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdhM4ef3HCIQG92oVIWlX3A0luOb2msqZckeJKMiOTw=;
 b=Yze6m0R40CrcY0XFs35yqjIS1E4dB9HNnL0OjW+jB2C3aDIjCcRVMBwv+kNkkEE7FBrdcL6zH1KFANVQkllHG5LreNVyPOWprlKjhS5lO68UMMO88HV7y9Z+rCO35QzLomLCDSjFRN3HxT7eVpkVcLJ+uxcJ37MwGahg0/sejjk=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 22:53:52 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::4e) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:51 +0000
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
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 22:53:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:46 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:45 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 05/19] accel/amdxdna: Add NPU3 classic device support
Date: Fri, 9 Oct 2026 15:53:29 -0700
Message-ID: <20261009225343.3079074-6-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009225343.3079074-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: fb81005e-8837-4ab2-9688-08df26583054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: eTPYqz9LqdH/L3RMLA6t8HuaiK0MCadP7Q4ccEfZ2Q8Ic1WP2UZ/mnxBLx8732B/4kk+K0TcamvQ4ZmqKCOGaFAjlzlGP0UO8k+NC4ESpXF42WSs+ZUlf2C5s8lwlG3Cu/BQ2bEyT8S/y+0yJX2A4IRGMzr/zyO9432CMwFk3c1EBbRhwfBlwMieQPHhiD0tR4mOYc8zP8ba4rZg44WffsRaVFuoijVWfDgHJxONdkviEhU9PGvbeVqai8MDIFGMY7cvsBdg0nIFFsM2cu2xJx8UykJW3nOpA6o7G3fMwJ84pGUqo0FQnEIVU4zs3VPKuMm1z30HJqiRYOnDjao2x+fauf07OnkE4Q1CqV+DLMd9zgBwHrl00ewPPC5i6Y7vA4BRmr6JuUDo2JJoANSdynI3mCtyTTu1Rf5AH0ud/kq+OhTIZ/FiWIhPmIHwYbFCuSBhZaCWqxBJ7ywNnXn51//feBY632q+R9PHSd3J1H1DhZZIs5RWdtw8BNaKA3lFMzEMUOw3hqwuVcwzRirfFGnDu19fNPZh58uQcqySbH0MJGlTxA2S7KCAi3MlwrEE+Lpp++RH8S4AtymyXSbTAerOfNlZMBluS5ea+3XwhTC6duWpr1Vl6BXoCWNPl5/eEAzuVDP3nxhhn5EXVsSMBw6vfWWLvK9jDQNHLO/yVqQH+iXNWea1T4d1v57plu7NaG/pHV7zCjXc8lMSsmj5IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ogkyeEY3PpF04gJdFJ6PH/EAp0aPdKpQD4xszuS1DN0c5gyjFhkdKUmA9B4SbiDGxLkyzirpKt33QZqLWKcSWiQpQtvKlzCxHelr0EiygaCpDu/VIexpX/CEcUuAptPH0YzLZG1x0EBxhnA37Im+hBkM/eOz+lQP/IGghxJ5Ie2r3MbBy0CGL5tU/M2gCT103bcBWdcY2ngdibKJfUF8bOdtnEghMELiDMRgwDGB8LdLW+N8ZHfHAzPdmtNBBUvpqQsqkj1okYYL2y+AdNs+fKXZLWk6qKug6VlPuVbc5sz90ADGdc9QbnJuaRZ42CkyAPlh7eNrjh98DTPqsGUYyQc3eOnU8dQc0aKS0xbUS+QXKPZWSr1DZaoR1kLUoF5NWuPO9J+eMWCdDpQfWIpgN3DZMgulbkKqu6cGDzaxY7iotuhZJqrwqb67UdgONdXH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:51.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb81005e-8837-4ab2-9688-08df26583054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

Suspend and resume support is added in a later patch, once the
kernel-mode queue (KMQ) can drain in-flight commands.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
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

