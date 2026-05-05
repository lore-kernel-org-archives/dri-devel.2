Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084A5CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9EB10E1F2;
	Tue,  5 May 2026 16:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S19JICNw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3653010E1F2
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 16:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch4GzGJbOJrAogvTdzlOQrFn3Kfcxvam2FjO6ZGns/NXOklmbPD+H3mJefV84otLDsGpbiuZG+6eE+B9c9TvWACiZ2eDbkASks1bDmNFjbDo/WXUabNEETRkN3TfhG0VB5i1Mnjh3M93KBagWVkPRDBoeG10BVXO+lSbHhMtZoz4c16yqO22uJChznere9XzerWcYs1dvwHllow+Rn8zDSC8vxFGUo7pIQALKgB58qa0a8WIEtaZ0t3DMu06Bt7QBte/dE+p5KwxszhUlYdhpc9u3sXu8JtND37sbBa3h1VkimgWEqNFiRw+a7emwV9oSWoy88cja1i9NkukoHY/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC7V+WZUDJxUh02GmUMfi8Mca9aX3hJYKtqCSeaJhao=;
 b=zSKjnlo6Syihs4YVNN7MC9xTkw6K6/IC2890fZoSW2EA/0W6Nnyy0R/eS7hzlqeZSn+0DAEKqnL/HfhrVsOZwKF01b4bNA1gAP0NTr0v0K2eHYwG75jHzAmQwfV2DtbCd+rjFt+ieyedhYmmWRce4gO3BNMIWxxYgZZ+TAn0N17hWPCP8fPdOri7X7s+1mPu2pCJ/IMFdpHeSrlseMmm02hsw9pTMiQ16d1U7nlMn200MQe2CTL5cmFoP8Hq7+Ppcd+KmiSN8q8KywtWRif9JYmMQ7R19pIR/E55ZJRmmPOh+cVsV9haiAmmgLOgvx8v9F0YyL5sfVPhDtUSGIcjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC7V+WZUDJxUh02GmUMfi8Mca9aX3hJYKtqCSeaJhao=;
 b=S19JICNwcNRt02+AfYGXxroPFLn1I3aGctg1q7XTe5kNsYCAiE0bUvLHWUfKHjwQr+Oc8ZryOh0pekcZcgO6DVdbOUjqRymeImhsGBStEGiKm57nAZQpK+y7Z56NHEg5rLKyLmznQwtZgZXEpFOPRKS8/zPIUg3kz6CWovyhvRE=
Received: from PH7P220CA0092.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::28)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:10:40 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::6a) by PH7P220CA0092.outlook.office365.com
 (2603:10b6:510:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 16:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:10:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 09:09:44 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:09:44 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 1/6] accel/amdxdna: Add initial support for AIE4 VF
Date: Tue, 5 May 2026 09:09:31 -0700
Message-ID: <20260505160936.3917732-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505160936.3917732-1-lizhi.hou@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: d963e3d5-9002-4d5d-d7ce-08deaac0d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: XouEL5xBD6U5MwOHtV8HwCcvN+3QA5D126y7aglI7MrMoDc7e+iK/IyJr9iLcGo8pUz6T6BQfG8/FJf/LHTDOjlxjUENkZHm7aowVv9IT5BBgHSeSauu0qn7Od1gZcqlN67Ruodh77VPow1dX653DSFVSrsnM64asl1Bqe+p6diyzTy/N4utzOJg+62CDouDqaDpppXY7E5O5SAEKIchjwNkJpJBVoSejz4BcP4sGi/JYt1s0VsD90hYYYbPkTyvs9Dtsvx3n74bo5mMojcttXLQaM69lK+ORd6Oj8Hj6rUVWjCjnBaeNF8gR88O8DlKX1UNFKXigEL+pxcvYur2JpQuP0liWE4kH7xkEDkQ6nnaBv/00KseRmRX2PW2RmevXTJGa4lmukEwqQNFiaWOOxB+THtfH683soH/V3/scP2OVH3dYKt6pXzZUQLUXmj15KQWJZXLIsl8sj+RAwFsW8Fbq4ZscjGRuSoHctjmuZi0oAds8eS4OdLg0+0hKRsQd/DQ5emjmEizb6xxOHVpnENoRvuewnWY/Gg910vpa1IToVq7ah9fR5HRZy1eFDZzcwo1zZ7tCfhF1GaPS6wPz37lAN3z37YodF/EUxM1MsbTA7hcAgVIbD/MN7ma6pH0sLXrMPvKPDoWgbQe2RtV3lKgrj5ftnDSG119ixCpSSPzZrDNI6GPuyMW5LbcIwpNcp9yAVR0zQFNfHvmrID6mK1XY9V1NrEv43hSW4jxCbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9X8d+8AslZffBguKjL8NLnPrXrU9zm+C/wnMUWhK316G+qAnAjOtPdkLjlUKCiYVBalehqf6+8GTZz7+x6mYZUgrtpbgaM32GUuM5IJhSkdQzrren9XIlugImQ7rkFoNXXCE3uRodmK01WuLI0bqh1IBrZFge0Hgv5NT1rSlXp0kpK4fUvjyytwG60CJCUMR3AXQ77sV9jAB/pM8A7yZHl02CHVjUl9/uJL+BuNHLTEBniqZ+rk6fOLExbBOCsQ9pWxA2N/dBAkfQncvYVvUOOwvXMvJixh08Q5UUB0jAkV6kZX580GmgMFIxMkAnXZ82bQoLxOWgpfyzJJG1RrB8h5O2rITAql3OFUqCQJ/vySonziXz2DsJSMUbdgUdcpWKnudbpCf1T+yvTfh9BoMqload0vmiMgYo8N0QDG9gILXNisEa6qKTvmcok+DyiII
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:10:39.7593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d963e3d5-9002-4d5d-d7ce-08deaac0d9d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
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

From: David Zhang <yidong.zhang@amd.com>

Add basic device initialization support for AIE4 Virtual Functions (PCI
device IDs 0x17F3 and 0x1B0C).

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c        | 160 +++++++++++++-----------
 drivers/accel/amdxdna/aie4_pci.h        |   3 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   4 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   1 +
 drivers/accel/amdxdna/npu3_regs.c       |  20 ++-
 include/uapi/drm/amdxdna_accel.h        |   1 +
 6 files changed, 113 insertions(+), 76 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 87f80f804f91..a967e2db7ebd 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -196,8 +196,9 @@ static int aie4_mailbox_start(struct amdxdna_dev *xdna,
 	return ret;
 }
 
-static int aie4_mailbox_init(struct amdxdna_dev *xdna)
+static int aie4_mailbox_init(struct amdxdna_dev_hdl *ndev)
 {
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	struct mailbox_info mbox_info;
 	int ret;
 
@@ -208,13 +209,13 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
 	return aie4_mailbox_start(xdna, &mbox_info);
 }
 
-static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
+static void aie4_fw_stop(struct amdxdna_dev_hdl *ndev)
 {
 	aie_psp_stop(ndev->aie.psp_hdl);
 	aie_smu_fini(ndev->aie.smu_hdl);
 }
 
-static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
+static int aie4_fw_start(struct amdxdna_dev_hdl *ndev)
 {
 	int ret;
 
@@ -233,49 +234,49 @@ static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
 	return ret;
 }
 
-static int aie4_hw_start(struct amdxdna_dev *xdna)
+static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
-	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	int ret;
 
-	ret = aie4_fw_load(ndev);
+	ret = aie4_fw_start(ndev);
 	if (ret)
 		return ret;
 
-	ret = aie4_mailbox_init(xdna);
+	ret = aie4_mailbox_init(ndev);
 	if (ret)
-		goto fw_unload;
+		goto stop_fw;
 
 	return 0;
 
-fw_unload:
-	aie4_fw_unload(ndev);
+stop_fw:
+	aie4_fw_stop(ndev);
 
 	return ret;
 }
 
-static void aie4_mgmt_fw_fini(struct amdxdna_dev_hdl *ndev)
+static void aie4_pf_hw_stop(struct amdxdna_dev_hdl *ndev)
 {
-	int ret;
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 
-	/* No paired resume needed, fw is stateless */
-	ret = aie4_suspend_fw(ndev);
-	if (ret)
-		XDNA_ERR(ndev->aie.xdna, "suspend_fw failed, ret %d", ret);
-	else
-		XDNA_DBG(ndev->aie.xdna, "npu firmware suspended");
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	aie4_suspend_fw(ndev);
+	aie4_mailbox_fini(ndev);
+	aie4_fw_stop(ndev);
 }
 
-static void aie4_hw_stop(struct amdxdna_dev *xdna)
+static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
 {
-	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	return aie4_mailbox_init(ndev);
+}
+
+static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 
-	aie4_mgmt_fw_fini(ndev);
 	aie4_mailbox_fini(ndev);
-
-	aie4_fw_unload(ndev);
 }
 
 static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
@@ -365,15 +366,41 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
 	return 0;
 }
 
-static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
+static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
+			void __iomem *tbl[PCI_NUM_RESOURCES])
+{
+	const struct firmware *npufw, *certfw;
+	int ret;
+
+	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
+		return 0;
+
+	ret = aie4_request_firmware(ndev, &npufw, &certfw);
+	if (ret)
+		return ret;
+
+	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
+	aie4_release_firmware(ndev, npufw, certfw);
+
+	return ret;
+}
+
+static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
 {
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	struct amdxdna_dev_hdl *ndev;
 	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
-	const struct firmware *npufw, *certfw;
 	unsigned long bars = 0;
 	int ret, i;
 
+	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
+	if (!ndev)
+		return -ENOMEM;
+
+	ndev->priv = xdna->dev_info->dev_priv;
+	ndev->aie.xdna = xdna;
+	xdna->dev_handle = ndev;
+
 	/* Enable managed PCI device */
 	ret = pcim_enable_device(pdev);
 	if (ret) {
@@ -409,75 +436,60 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
 
 	pci_set_master(pdev);
 
-	ret = aie4_request_firmware(ndev, &npufw, &certfw);
-	if (ret)
-		goto clear_master;
-
-	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
-	aie4_release_firmware(ndev, npufw, certfw);
+	ret = aie4_load_fw(ndev, tbl);
 	if (ret)
-		goto clear_master;
+		return ret;
 
 	ret = aie4_irq_init(xdna);
 	if (ret)
-		goto clear_master;
+		return ret;
 
-	ret = aie4_hw_start(xdna);
-	if (ret)
-		goto clear_master;
+	amdxdna_vbnv_init(xdna);
+	XDNA_DBG(xdna, "init finished");
 
 	return 0;
-
-clear_master:
-	pci_clear_master(pdev);
-
-	return ret;
 }
 
-static void aie4_pcidev_fini(struct amdxdna_dev_hdl *ndev)
+static int aie4_pf_init(struct amdxdna_dev *xdna)
 {
-	struct amdxdna_dev *xdna = ndev->aie.xdna;
-	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
-
-	aie4_hw_stop(xdna);
-
-	pci_clear_master(pdev);
-}
+	int ret;
 
-static void aie4_fini(struct amdxdna_dev *xdna)
-{
-	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	ret = aie4m_pcidev_init(xdna);
+	if (ret)
+		return ret;
 
-	aie4_sriov_stop(ndev);
-	aie4_pcidev_fini(ndev);
+	return aie4_pf_hw_start(xdna->dev_handle);
 }
 
-static int aie4_init(struct amdxdna_dev *xdna)
+static int aie4_vf_init(struct amdxdna_dev *xdna)
 {
-	struct amdxdna_dev_hdl *ndev;
 	int ret;
 
-	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
-	if (!ndev)
-		return -ENOMEM;
+	ret = aie4m_pcidev_init(xdna);
+	if (ret)
+		return ret;
 
-	ndev->priv = xdna->dev_info->dev_priv;
-	ndev->aie.xdna = xdna;
-	xdna->dev_handle = ndev;
+	return aie4_vf_hw_start(xdna->dev_handle);
+}
 
-	ret = aie4_pcidev_init(ndev);
-	if (ret) {
-		XDNA_ERR(xdna, "Setup PCI device failed, ret %d", ret);
-		return ret;
-	}
+static void aie4_pf_fini(struct amdxdna_dev *xdna)
+{
+	aie4_sriov_stop(xdna->dev_handle);
+	aie4_pf_hw_stop(xdna->dev_handle);
+}
 
-	amdxdna_vbnv_init(xdna);
-	XDNA_DBG(xdna, "aie4 init finished");
-	return 0;
+static void aie4_vf_fini(struct amdxdna_dev *xdna)
+{
+	aie4_vf_hw_stop(xdna->dev_handle);
 }
 
-const struct amdxdna_dev_ops aie4_ops = {
-	.init			= aie4_init,
-	.fini			= aie4_fini,
+const struct amdxdna_dev_ops aie4_pf_ops = {
+	.init			= aie4_pf_init,
+	.fini			= aie4_pf_fini,
 	.sriov_configure        = aie4_sriov_configure,
 };
+
+const struct amdxdna_dev_ops aie4_vf_ops = {
+	.init			= aie4_vf_init,
+	.fini			= aie4_vf_fini,
+};
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index aa1495c3370b..cbf3424a4341 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -48,6 +48,7 @@ static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 }
 #endif
 
-extern const struct amdxdna_dev_ops aie4_ops;
+extern const struct amdxdna_dev_ops aie4_pf_ops;
+extern const struct amdxdna_dev_ops aie4_vf_ops;
 
 #endif /* _AIE4_PCI_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 1b08a08343cf..39ad081ac082 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -53,7 +53,9 @@ static const struct pci_device_id pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1502) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x17f3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0B) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1B0C) },
 	{0}
 };
 
@@ -65,7 +67,9 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
 	{ 0x17f0, 0x11, &dev_npu5_info },
 	{ 0x17f0, 0x20, &dev_npu6_info },
 	{ 0x17f2, 0x10, &dev_npu3_pf_info },
+	{ 0x17f3, 0x10, &dev_npu3_vf_info },
 	{ 0x1B0B, 0x10, &dev_npu3_pf_info },
+	{ 0x1B0C, 0x10, &dev_npu3_vf_info },
 	{0}
 };
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index b1548cf16f59..caed11c09e55 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -167,6 +167,7 @@ struct amdxdna_client {
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu3_pf_info;
+extern const struct amdxdna_dev_info dev_npu3_vf_info;
 extern const struct amdxdna_dev_info dev_npu4_info;
 extern const struct amdxdna_dev_info dev_npu5_info;
 extern const struct amdxdna_dev_info dev_npu6_info;
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index acece0faddf2..6d5da779232b 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -64,6 +64,14 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
 	},
 };
 
+static const struct amdxdna_dev_priv npu3_dev_vf_priv = {
+	/* vf device does not load firmware */
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
+	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
+	/* vf device does not have smu and psp */
+};
+
 const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.mbox_bar		= NPU3_MBOX_BAR,
 	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
@@ -73,5 +81,15 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
 	.fw_feature_tbl		= npu3_fw_feature_table,
-	.ops			= &aie4_ops,
+	.ops			= &aie4_pf_ops,
+};
+
+const struct amdxdna_dev_info dev_npu3_vf_info = {
+	.mbox_bar		= NPU3_MBOX_BAR,
+	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.default_vbnv		= "RyzenAI-npu3-vf",
+	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
+	.dev_priv		= &npu3_dev_vf_priv,
+	.fw_feature_tbl		= npu3_fw_feature_table,
+	.ops			= &aie4_vf_ops,
 };
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 0b11e8e3ea5d..34212feee15c 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -30,6 +30,7 @@ extern "C" {
 enum amdxdna_device_type {
 	AMDXDNA_DEV_TYPE_UNKNOWN = -1,
 	AMDXDNA_DEV_TYPE_KMQ = 0,
+	AMDXDNA_DEV_TYPE_UMQ = 1,
 	AMDXDNA_DEV_TYPE_PF = 2,
 };
 
-- 
2.34.1

