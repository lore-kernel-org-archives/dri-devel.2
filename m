Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0B1061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5929710E665;
	Mon, 30 Mar 2026 16:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NRGAs+i2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7888D10E5B1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 16:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPKwyu2RVqP/Ipgjjl8lgS7ShNXfsLBtYpHx1bJ85+Fi+MzKRdljbHVAu1LV5no7VdAh3xm5YQbrAhaIq5a65EQsqN9AttQE3tyTIngzD100fpZE1NCAykcfc8Z1x0q3zyK7nOVrrJemV9o9jQWWhFM509+O2Ei2RhEFqXEtwMT4mGx17D1mvPFyCW0XTKCmfsWX0YIQgDPEVqzXEO9EvHuTxzKb2fnfad4XvdjFdP/JzztW2NP532QwbDpYnzlrBcuvowMkOSwJQ+bttT/UT0zUblstXgFR95t7Ri2vVA1XYrLhNLUxoYyPTKxUbn+OK/nPVTQt9sDoKLkoc1Ag6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o0P9fRF8q6RdF7bn4NICLGsxL25a6TXCaRrEuyiZ+4=;
 b=DQ+ptOpYLEpfiQHDzOvnfMEe05mAwz5QXTVZEyHoodxQ58n9mtofkVSA2rRMngVfynu7kkLz2fFH6l71j1SpZpcmwPvHsJjE2JgrNvbL0ps0vaThdDIlpeLlqN55UWRC9W1Gw0jMg4ggDafFg4UQFxdqJuNMr0XDlGOPNxnOQ9usHPffCNAWRER0BvIzDMuR+BE7CR5SIFCIwyjN8aMlhgfdFYzxam22pybxBLn3utiM3CbF3/NRiDae1xgxAqV09ucSSgriVYrx8ODiLC/jU4IdJG9wWePq/5VkdK4JG4bhqudhrJ5Drffpxj6eJGUIVl9u4HKVg0LBSRClFsFQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o0P9fRF8q6RdF7bn4NICLGsxL25a6TXCaRrEuyiZ+4=;
 b=NRGAs+i2/WmqYKY2RGm4l4CopbvNKOYrvRC/cluYDH07qCV5fjfFPOxkXiaeziO/Tsz7M6gUMwiNRz9AazWEBWb3qhFsFzzCniXXxBR6Ipx4CM9hSJHV1oy8PMi+l+Po/Z5QKNqa1STUEK494Jt8C/85Y4Z9h+DK43d4g0Otnmo=
Received: from SA0PR11CA0048.namprd11.prod.outlook.com (2603:10b6:806:d0::23)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:37:19 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::15) by SA0PR11CA0048.outlook.office365.com
 (2603:10b6:806:d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 16:37:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 11:37:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:37:18 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 11:37:17 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 4/6] accel/amdxdna: Add AIE4 firmware loading
Date: Mon, 30 Mar 2026 09:37:03 -0700
Message-ID: <20260330163705.3153647-5-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330163705.3153647-1-lizhi.hou@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 83056c46-4c7f-4f44-2054-08de8e7a9c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0WxHDreE/WzKimcGXm+lSprzXB5ObUjwAlf0Zc2XGQ40k3SDv8LHjLaho+FKGz7zM6KpRSg077SqLKi55bWHPuwNOZjBFr4BLVzBeRZ5TaaX65ZxmE8ZIwK/kk4b4Ow6KBh9ii/OkJh+AKl10yA75P1jQoyaQKIALeuN9HkRPKxXBjrTRSk4U1nYtS3xEqjbLXC1oATL3EbT88AiH9P4SQttx9cpnlovQieKq1v5ZxXOZ0JSd4lCbPUgCCS9hmRArAjUQEmQyJtQGc5OA64C8dQg4Bvj2Vf9lKP7LzJCU/0FWvh3Rr1bc9uL6I22Opqe2HcMd6OsmCiLtTMkuH0uHQr5zfNfxaxbt7GMb/zVSZX8A3O5nX0+BVX3xrZTEJZYWrdvYdteBIYpe5L+duSXs/1v1kJ+zMcGUpkJyWvdR3g28YYnCGsMyHDbrcgbcgC3n+EP1EslLHfcrQv9/cWvgAlxFUZCcH+VTwVAuYnwvsY/QdSjMHqcMef/InCQGnAm2lggzrp7WhpsbLu3AGl8s52CS2ukLuOH2es9QGvCTtmzxE6Pk0qwrq7J/JYbmj8AOpBpX13fCk5mHzE86yCAs9+aTW3xRUDCmYHCfX/OeoX3qW6KIkBvrZpP1g1uJnbrPdNMNgDgjYIeNwvUmyw63Uk2a0gpovVRD93nD5/+JFwQ1X/o3ntPR2h8kJ65Bx/g9r5HZLhJhlskmp1Rsy75PD820D/YFn1/YadvQIsVOLDIwgeeK0yuewiuCALp+UtHki3gh40eYfyrQNwuC8fa7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ul1/FicWhX0aVqZ74fX8A5WuTIs5ZZehrjiHeqEOxMitl6fztbF3vsCZPd6qw7tze1YgBib0yrIZSeoeQCBQ39e924g4brOU3Z92IwmeGPnK20adDSrIia5irMZQEq7Vv7FcuvWeYpI06aZbw/XD/xmv4IUmtQ5qmudAJJuAl7ubmkORzaF2WfuMK+anpCKI2x3QP8ThvlxPe5S6En1SLCNG8x6b4W2fSvKlE7jOhLPVF0fwCFtRaoS2Awze3PTAOGMuCnO6lyYHkcJTKGAm5xEX1xDVmazWHo3x2LKeIpFtyWp4GBP7+Janz0d9NKcv6E9IReSloD26ideN5/AVmpwkLBiJFy8wNXn7NIt6d3s6DcqZT8Zkl1+WEiT77muuI6+qc+/T/umhEMOhfDbxjXAk9niaB0OrZTO1Enhr8D90H2blhiw11xq8Wlam+Fcg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:37:18.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83056c46-4c7f-4f44-2054-08de8e7a9c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

Add support for loading AIE4 firmware through the common PSP
interfaces.

Compared to AIE2, AIE4 introduces an additional CERT firmware image.
aiem_psp_create() performs CERT setup when the CERT image size is
non-zero.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie.h       |   4 +
 drivers/accel/amdxdna/aie2_pci.c  |   2 +
 drivers/accel/amdxdna/aie4_pci.c  | 109 ++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h  |   4 +
 drivers/accel/amdxdna/aie_psp.c   | 141 +++++++++++++++++++++++-------
 drivers/accel/amdxdna/npu3_regs.c |  23 +++++
 6 files changed, 247 insertions(+), 36 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 124c0f7e9ca0..423ed34af9ee 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -57,7 +57,11 @@ struct aie_bar_off_pair {
 struct psp_config {
 	const void		*fw_buf;
 	u32			fw_size;
+	const void              *certfw_buf;
+	u32                     certfw_size;
 	void __iomem		*psp_regs[PSP_MAX_REGS];
+	u32			arg2_mask;
+	u32			notify_val;
 };
 
 /* aie.c */
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index e4b7893bd429..0489e668cd73 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -549,6 +549,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 	psp_conf.fw_size = fw->size;
 	psp_conf.fw_buf = fw->data;
+	psp_conf.arg2_mask = GENMASK(23, 0);
+	psp_conf.notify_val = 1;
 	for (i = 0; i < PSP_MAX_REGS; i++)
 		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
 	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 0f360c1ccebd..e7993b315996 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -6,11 +6,15 @@
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
+#include <linux/firmware.h>
+#include <linux/sizes.h>
 
 #include "aie4_pci.h"
 #include "amdxdna_pci_drv.h"
 
-#define NO_IOHUB	0
+#define NO_IOHUB		0
+#define CERTFW_MAX_SIZE         (SZ_32K + SZ_256)
+#define PSP_NOTIFY_INTR		0xD007BE11
 
 /*
  * The management mailbox channel is allocated by firmware.
@@ -207,13 +211,12 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
 
 static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
 {
-	/* TODO */
+	aie_psp_stop(ndev->aie.psp_hdl);
 }
 
 static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
 {
-	/* TODO */
-	return 0;
+	return aie_psp_start(ndev->aie.psp_hdl);
 }
 
 static int aie4_hw_start(struct amdxdna_dev *xdna)
@@ -261,11 +264,98 @@ static void aie4_hw_stop(struct amdxdna_dev *xdna)
 	aie4_fw_unload(ndev);
 }
 
+static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
+				 const struct firmware **npufw,
+				 const struct firmware **certfw)
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+	char fw_name[128];
+	int ret;
+
+	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
+		       pdev->device, pdev->revision, ndev->priv->npufw_path);
+	if (ret >= sizeof(fw_name)) {
+		XDNA_ERR(xdna, "npu firmware path is truncated");
+		return -EINVAL;
+	}
+
+	ret = request_firmware(npufw, fw_name, &pdev->dev);
+	if (ret) {
+		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
+		return ret;
+	}
+
+	ret = snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
+		       pdev->device, pdev->revision, ndev->priv->certfw_path);
+	if (ret >= sizeof(fw_name)) {
+		XDNA_ERR(xdna, "cert firmware path is truncated");
+		ret = -EINVAL;
+		goto release_npufw;
+	}
+
+	ret = request_firmware(certfw, fw_name, &pdev->dev);
+	if (ret) {
+		XDNA_ERR(xdna, "failed to request_firmware %s, ret %d", fw_name, ret);
+		goto release_npufw;
+	}
+
+	if ((*certfw)->size > CERTFW_MAX_SIZE) {
+		XDNA_ERR(xdna, "CERTFW over maximum size of 32 KB + 256 B");
+		ret = -EINVAL;
+		goto release_certfw;
+	}
+
+	return 0;
+
+release_certfw:
+	release_firmware(*certfw);
+release_npufw:
+	release_firmware(*npufw);
+
+	return ret;
+}
+
+static void aie4_release_firmware(struct amdxdna_dev_hdl *ndev,
+				  const struct firmware *npufw,
+				  const struct firmware *certfw)
+{
+	release_firmware(certfw);
+	release_firmware(npufw);
+}
+
+static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
+				 const struct firmware *npufw,
+				 const struct firmware *certfw,
+				 void __iomem *tbl[PCI_NUM_RESOURCES])
+{
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	struct psp_config psp_conf;
+	int i;
+
+	psp_conf.fw_size = npufw->size;
+	psp_conf.fw_buf = npufw->data;
+	psp_conf.certfw_size = certfw->size;
+	psp_conf.certfw_buf = certfw->data;
+	psp_conf.arg2_mask = ~0;
+	psp_conf.notify_val = PSP_NOTIFY_INTR;
+	for (i = 0; i < PSP_MAX_REGS; i++)
+		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
+	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
+	if (!ndev->aie.psp_hdl) {
+		XDNA_ERR(xdna, "failed to create psp");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
 	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
+	const struct firmware *npufw, *certfw;
 	unsigned long bars = 0;
 	int ret, i;
 
@@ -282,6 +372,8 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
 		return ret;
 	}
 
+	for (i = 0; i < PSP_MAX_REGS; i++)
+		set_bit(PSP_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
 
@@ -300,6 +392,15 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
 
 	pci_set_master(pdev);
 
+	ret = aie4_request_firmware(ndev, &npufw, &certfw);
+	if (ret)
+		goto clear_master;
+
+	ret = aie4_prepare_firmware(ndev, npufw, certfw, tbl);
+	aie4_release_firmware(ndev, npufw, certfw);
+	if (ret)
+		goto clear_master;
+
 	ret = aie4_irq_init(xdna);
 	if (ret)
 		goto clear_master;
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index f3810a969431..ee388ccf7196 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -14,9 +14,13 @@
 #include "amdxdna_mailbox.h"
 
 struct amdxdna_dev_priv {
+	const char              *npufw_path;
+	const char              *certfw_path;
 	u32			mbox_bar;
 	u32			mbox_rbuf_bar;
 	u64			mbox_info_off;
+
+	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
 };
 
 struct amdxdna_dev_hdl {
diff --git a/drivers/accel/amdxdna/aie_psp.c b/drivers/accel/amdxdna/aie_psp.c
index 8743b812a449..458dca7cc5a0 100644
--- a/drivers/accel/amdxdna/aie_psp.c
+++ b/drivers/accel/amdxdna/aie_psp.c
@@ -18,6 +18,7 @@
 #define PSP_VALIDATE		1
 #define PSP_START		2
 #define PSP_RELEASE_TMR		3
+#define PSP_VALIDATE_CERT       4
 
 /* PSP special arguments */
 #define PSP_START_COPY_FW	1
@@ -27,10 +28,20 @@
 #define PSP_ERROR_BAD_STATE	0xFFFF0007
 
 #define PSP_FW_ALIGN		0x10000
+#define PSP_CFW_ALIGN           0x8000
 #define PSP_POLL_INTERVAL	20000	/* us */
 #define PSP_POLL_TIMEOUT	1000000	/* us */
 
-#define PSP_REG(p, reg) ((p)->psp_regs[reg])
+#define PSP_REG(p, reg) ((p)->conf.psp_regs[reg])
+#define PSP_SET_CMD(psp, reg_vals, cmd, arg0, arg1, arg2)		\
+({									\
+	u32 *_regs = reg_vals;						\
+	u32 _cmd = cmd;							\
+	_regs[0] = _cmd;						\
+	_regs[1] = arg0;						\
+	_regs[2] = arg1;						\
+	_regs[3] = ((arg2) | ((_cmd) << 24)) & (psp)->conf.arg2_mask;	\
+})
 
 struct psp_device {
 	struct drm_device	*ddev;
@@ -38,7 +49,9 @@ struct psp_device {
 	u32			fw_buf_sz;
 	u64			fw_paddr;
 	void			*fw_buffer;
-	void __iomem		*psp_regs[PSP_MAX_REGS];
+	u32                     certfw_buf_sz;
+	u64                     certfw_paddr;
+	void                    *certfw_buffer;
 };
 
 static int psp_exec(struct psp_device *psp, u32 *reg_vals)
@@ -47,13 +60,22 @@ static int psp_exec(struct psp_device *psp, u32 *reg_vals)
 	int ret, i;
 	u32 ready;
 
+	/* Check for PSP ready before any write */
+	ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
+				 FIELD_GET(PSP_STATUS_READY, ready),
+				 PSP_POLL_INTERVAL, PSP_POLL_TIMEOUT);
+	if (ret) {
+		drm_err(psp->ddev, "PSP is not ready, ret 0x%x", ret);
+		return ret;
+	}
+
 	/* Write command and argument registers */
 	for (i = 0; i < PSP_NUM_IN_REGS; i++)
 		writel(reg_vals[i], PSP_REG(psp, i));
 
 	/* clear and set PSP INTR register to kick off */
 	writel(0, PSP_REG(psp, PSP_INTR_REG));
-	writel(1, PSP_REG(psp, PSP_INTR_REG));
+	writel(psp->conf.notify_val, PSP_REG(psp, PSP_INTR_REG));
 
 	/* PSP should be busy. Wait for ready, so we know task is done. */
 	ret = readx_poll_timeout(readl, PSP_REG(psp, PSP_STATUS_REG), ready,
@@ -90,69 +112,124 @@ int aie_psp_waitmode_poll(struct psp_device *psp)
 
 void aie_psp_stop(struct psp_device *psp)
 {
-	u32 reg_vals[PSP_NUM_IN_REGS] = { PSP_RELEASE_TMR, };
+	u32 reg_vals[PSP_NUM_IN_REGS];
 	int ret;
 
+	PSP_SET_CMD(psp, reg_vals, PSP_RELEASE_TMR, 0, 0, 0);
+
 	ret = psp_exec(psp, reg_vals);
 	if (ret)
 		drm_err(psp->ddev, "release tmr failed, ret %d", ret);
 }
 
-int aie_psp_start(struct psp_device *psp)
+static int psp_validate_fw(struct psp_device *psp, u8 cmd, u64 paddr, u32 buf_sz)
 {
 	u32 reg_vals[PSP_NUM_IN_REGS];
 	int ret;
 
-	reg_vals[0] = PSP_VALIDATE;
-	reg_vals[1] = lower_32_bits(psp->fw_paddr);
-	reg_vals[2] = upper_32_bits(psp->fw_paddr);
-	reg_vals[3] = psp->fw_buf_sz;
+	PSP_SET_CMD(psp, reg_vals, cmd, lower_32_bits(paddr),
+		    upper_32_bits(paddr), buf_sz);
 
 	ret = psp_exec(psp, reg_vals);
-	if (ret) {
+	if (ret)
 		drm_err(psp->ddev, "failed to validate fw, ret %d", ret);
-		return ret;
-	}
 
-	memset(reg_vals, 0, sizeof(reg_vals));
-	reg_vals[0] = PSP_START;
-	reg_vals[1] = PSP_START_COPY_FW;
+	return ret;
+}
+
+static int psp_start(struct psp_device *psp)
+{
+	u32 reg_vals[PSP_NUM_IN_REGS];
+	int ret;
+
+	PSP_SET_CMD(psp, reg_vals, PSP_START, PSP_START_COPY_FW, 0, 0);
+
 	ret = psp_exec(psp, reg_vals);
-	if (ret) {
+	if (ret)
 		drm_err(psp->ddev, "failed to start fw, ret %d", ret);
+
+	return ret;
+}
+
+int aie_psp_start(struct psp_device *psp)
+{
+	int ret;
+
+	ret = psp_validate_fw(psp, PSP_VALIDATE,
+			      psp->fw_paddr, psp->fw_buf_sz);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
+	if (!psp->certfw_buf_sz)
+		goto psp_start;
+
+	ret = psp_validate_fw(psp, PSP_VALIDATE_CERT,
+			      psp->certfw_paddr, psp->certfw_buf_sz);
+	if (ret)
+		return ret;
+psp_start:
+	return psp_start(psp);
+}
+
+/*
+ * PSP requires host physical address to load firmware.
+ * Allocate a buffer, obtain its physical address, align, and copy data in.
+ */
+static void *psp_alloc_fw_buf(struct psp_device *psp, const void *fw_data,
+			      u32 fw_size, u32 align, u32 *buf_sz,
+			      u64 *paddr)
+{
+	u32 alloc_sz;
+	void *buffer;
+	u64 offset;
+
+	*buf_sz = ALIGN(fw_size, align);
+	alloc_sz = *buf_sz + align;
+
+	buffer = drmm_kmalloc(psp->ddev, alloc_sz, GFP_KERNEL);
+	if (!buffer)
+		return NULL;
+
+	*paddr = virt_to_phys(buffer);
+	offset = ALIGN(*paddr, align) - *paddr;
+	*paddr += offset;
+	memcpy(buffer + offset, fw_data, fw_size);
+
+	return buffer;
 }
 
 struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf)
 {
 	struct psp_device *psp;
-	u64 offset;
 
 	psp = drmm_kzalloc(ddev, sizeof(*psp), GFP_KERNEL);
 	if (!psp)
 		return NULL;
 
 	psp->ddev = ddev;
-	memcpy(psp->psp_regs, conf->psp_regs, sizeof(psp->psp_regs));
+	psp->fw_buffer = psp_alloc_fw_buf(psp, conf->fw_buf, conf->fw_size,
+					  PSP_FW_ALIGN, &psp->fw_buf_sz,
+					  &psp->fw_paddr);
+	if (!psp->fw_buffer)
+		return NULL;
+
+	if (!conf->certfw_size) {
+		drm_dbg(ddev, "no cert fw");
+		goto done;
+	}
 
-	psp->fw_buf_sz = ALIGN(conf->fw_size, PSP_FW_ALIGN);
-	psp->fw_buffer = drmm_kmalloc(ddev, psp->fw_buf_sz + PSP_FW_ALIGN, GFP_KERNEL);
-	if (!psp->fw_buffer) {
-		drm_err(ddev, "no memory for fw buffer");
+	/* CERT firmware */
+	psp->certfw_buffer = psp_alloc_fw_buf(psp, conf->certfw_buf,
+					      conf->certfw_size, PSP_CFW_ALIGN,
+					      &psp->certfw_buf_sz,
+					      &psp->certfw_paddr);
+	if (!psp->certfw_buffer) {
+		drm_err(ddev, "no memory for cert fw buffer");
 		return NULL;
 	}
 
-	/*
-	 * AMD Platform Security Processor(PSP) requires host physical
-	 * address to load NPU firmware.
-	 */
-	psp->fw_paddr = virt_to_phys(psp->fw_buffer);
-	offset = ALIGN(psp->fw_paddr, PSP_FW_ALIGN) - psp->fw_paddr;
-	psp->fw_paddr += offset;
-	memcpy(psp->fw_buffer + offset, conf->fw_buf, conf->fw_size);
+done:
+	memcpy(&psp->conf, conf, sizeof(psp->conf));
 
 	return psp;
 }
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index f6e20f4858db..fb2bd60b8f00 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -16,6 +16,15 @@
 
 /* PCIe BAR Index for NPU3 */
 #define NPU3_REG_BAR_INDEX	0
+#define NPU3_PSP_BAR_INDEX      4
+
+#define MMNPU_APERTURE3_BASE    0x3810000
+#define NPU3_PSP_BAR_BASE       MMNPU_APERTURE3_BASE
+
+#define MPASP_C2PMSG_123_ALT_1  0x3810AEC
+#define MPASP_C2PMSG_156_ALT_1  0x3810B70
+#define MPASP_C2PMSG_157_ALT_1  0x3810B74
+#define MPASP_C2PMSG_73_ALT_1   0x3810A24
 
 static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ .major = 5, .min_minor = 10 },
@@ -23,14 +32,28 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 };
 
 static const struct amdxdna_dev_priv npu3_dev_priv = {
+	.npufw_path             = "npu.dev.sbin",
+	.certfw_path            = "cert.dev.sbin",
 	.mbox_bar		= NPU3_MBOX_BAR,
 	.mbox_rbuf_bar		= NPU3_MBOX_BUFFER_BAR,
 	.mbox_info_off		= NPU3_MBOX_INFO_OFF,
+	.psp_regs_off   = {
+		DEFINE_BAR_OFFSET(PSP_CMD_REG,    NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_ARG0_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_ARG1_REG,   NPU3_PSP, MPASP_C2PMSG_157_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_ARG2_REG,   NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_INTR_REG,   NPU3_PSP, MPASP_C2PMSG_73_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_STATUS_REG, NPU3_PSP, MPASP_C2PMSG_123_ALT_1),
+		DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
+		/* npu3 doesn't use 8th pwaitmode register */
+	},
+
 };
 
 const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.mbox_bar		= NPU3_MBOX_BAR,
 	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
+	.psp_bar                = NPU3_PSP_BAR_INDEX,
 	.vbnv			= "RyzenAI-npu3-pf",
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
-- 
2.34.1

