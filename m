Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64378606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b+mQvPnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE8910F992;
	Tue, 17 Nov 2026 22:15:57 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C107010F992
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehjps8EvxsTlsl1t1x6iFS8OFh1H9IfMRzhhS4LeCUp5fXWEC/2upLfP/i5Ekh5ubO2hkPHyLR0Mw0Qgy+XcNdgxBAnKfIUAzoW2Opv6UbyGONivmT/qNE0GwhtU814DCD5XLJMnT86zRaASxyT7DHMFg//G48GedK0n9HNGc7L9AiuMPAAgBeL5k/ueO/r+HRFSD6YDbLMZF3Xi9yvjSu2gnm4O/6T3Ng1YXgk4piXI8ki2V1AV2jOkpsyU1JyPtUXEe1ST0O+K61Uc3LtRA//1QFWWxQlJngJP04jKJvfeazbkdJq56YuAjO0NcQMzhfOHed+scuDtmnrbMef33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9CjGU2zF/0wSuV9qT/RmSGFzcWzi2STRWrahsVk4ac=;
 b=bNJ4ky3EOBOkKZSMVXuVPOn+VgH1ddEfZjqD0fsw793Zjd/0NyEcCitGKLAm5y7mAn9QwjQ/ft30EiOXBXD6tSO77kk/PPjUUGr3UDLXGHMrhMnqbuln28NuCaHd6WiyhF7AnYUhbqv+gu+jaUc6Vg0aDJcvinqPSLLGZUh3S/4U663d6zo3Zf2i5cwW3iW/cKOA1lJdmT89R2GP/e9CBF2kysSrm53LgWM5L/fLSg7IYhBRfbz3xkbTow9ObY6vNBxlGjD/PY01k9aIoG2sIYCWc57KqdpbVS07YvvE6f36DbDyTn6gTD/gRtURy5NGpUbZx3G1jybK3qzVAOYmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9CjGU2zF/0wSuV9qT/RmSGFzcWzi2STRWrahsVk4ac=;
 b=b+mQvPnADJVk4f40H+q1Vp15FgokaP63ZQ4TJUz268obAQsSE1cIQ4cpXjcOXngRp7ozwo3i5VBquqEVWJp2H/NaPtiWWE4EF7oYwT7Zcxz9JGvjDERYEnwm9mXkDCKBAa4pxO5Ja55wtEz5urD5zf8LA9IkzUPASJuC8PWwzlU=
Received: from PH8P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::18)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:15:44 +0000
Received: from CY7PEPF000000EF.namprd04.prod.outlook.com
 (2603:10b6:510:2db:cafe::74) by PH8P223CA0021.outlook.office365.com
 (2603:10b6:510:2db::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 22:15:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000EF.mail.protection.outlook.com (10.167.247.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 22:15:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:15:40 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 16:15:40 -0600
From: Max Zhen <max.zhen@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <lizhi.hou@amd.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1 4/4] accel/amdxdna: Fix SMU command execution on platforms
 without interrupt trigger
Date: Tue, 17 Nov 2026 14:15:31 -0800
Message-ID: <20261117221532.177788-1-max.zhen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EF:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: e25fe943-89cb-4062-cc79-08df44f8529d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|6133799003|261009223027099003|3023799007|261026135527099003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022075727099003|261022105027099003|261026130827099003|261021130227099003|261021133027099003|261021123027099003|261022113327099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: Z0roscVbum3ZnMxPCXfLrDesGM56kxpttXEYgV3mBO5myO0O0OgFHxNQmrFa+wVLp/mauCN9ySbTDOmBNC22e0r99KUdsEtIoB6dl6oiDQR5JsnyiUoyDVDQBAaKPDJsbdZpEU3H1KDlgA1SaotX/6JcfDqfFhOgO2oxcMmOEhOqY1nyKcSxY590rBvftOYxNNQ96K+T3sJ4D18wAzaNk3o3YPDreBP0fBayswXe9F3kCjJB2RKLz0A2iqP93b6rsUIyLD6WV14sU6BEIvPMKjHvtQhniLjwQZMuVfKjfg39esMwiEM1JuxFeR77hUTKFfMKBn63Ge2Rk7P7zoGAw7rd/K6328+DAbCQi2ZM52vd3IWRvaBaw3mpoWAw5WyIUxoolQk67ez0zhHt16r5z7IanrD0gF8cBVk5X+RvWzJfjc+6ISmi9HxA7aye4kYlOhjzYwUse1gJqxxeoYFmuVKVUtE3QDaOImEcbpaugSfO2Od/yCAsBXL72Hxu3VRRR3N784siCuiXrk3tQx+qxhuOpi6DMe0dt4W5ZGFirZisNVU9LpfzKj9Nngz9TtMqpH3PcovZOfYA9p7PKZXyF6r/6kTqruNUfXih9HYrkaY4IgtGXrOb8zdgI2mQKi5cCQZ2UdkN8AcutOZZldpf+tPaJfsyYUOIZOYEskR/T0czWtNgRF2zzh/c0esqkMRMku9mANAmlGJqAryZy7u44Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(6133799003)(261009223027099003)(3023799007)(261026135527099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026130827099003)(261021130227099003)(261021133027099003)(261021123027099003)(261022113327099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kehprs+aOJuj1oRk3ctpfjaisxv1SRdXKP3MVns51bxEFaydt6o1VWbPJpFXtEx7atafpLEy2omHGK9hN8oGm7GkQEIw9+b+whUF4YguJ8smJb6ymZqX0syTuyUDBqe53fTD34QWe8qxZ2ru4Ayhpmdi3gQC/urXaGI2GL84K8k2XlUU2IYaSLYxWrwwMS0tvfj0Tj63RpWiAJOF68/p2JdOBlswSrRyTsV/a2/UfgzGZO3kWrp8gRBP2vQYad8853fBy/IjTJketfrwgMMzsuLjQCu8ACcaP6VdP5H35THQik9Y+tfjB1ZNPusNqRtJqEkpEcBaNXbUJBJ32r1CU4OsPbKsOWNdXrPbEkZWXh3cx++cJGT2vSdJ0I9CkiXwp9YNTkowWnFeZvoKJdN3wO/aIhOKjkthgjktXbkMlivs4lA00MZ4mc1nG3nDv8o8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:15:43.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25fe943-89cb-4062-cc79-08df44f8529d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000EF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SMU command execution currently unconditionally manipulates
SMU_INTR_REG when issuing a command. This works on platforms that
require an interrupt trigger to start command processing, but it
causes failures on platforms where commands are executed directly
through the command and argument registers.

Add a per-device SMU configuration flag indicating whether the
interrupt mechanism is required. When enabled, wait for the interrupt
register to become idle before submitting a command and trigger
execution by writing to SMU_INTR_REG. When disabled, skip the
interrupt handshake and rely on the command register write to start
execution.

This allows the common SMU implementation to correctly support both
interrupt-driven and non-interrupt-driven firmware interfaces.

Signed-off-by: Max Zhen <max.zhen@amd.com>
---
 drivers/accel/amdxdna/aie.h       |  1 +
 drivers/accel/amdxdna/aie2_pci.c  |  1 +
 drivers/accel/amdxdna/aie2_pci.h  |  1 +
 drivers/accel/amdxdna/aie_smu.c   | 20 +++++++++++++++-----
 drivers/accel/amdxdna/npu1_regs.c |  1 +
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 13af4b9b2cf2..991e45ac7f36 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -110,6 +110,7 @@ struct aie_bar_off_pair {
 
 struct smu_config {
 	void __iomem    *smu_regs[SMU_MAX_REGS];
+	bool		intr_enabled;
 };
 
 struct psp_config {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index a3866e8933e6..cc53c1fc3944 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -603,6 +603,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 	for (i = 0; i < SMU_MAX_REGS; i++)
 		smu_conf.smu_regs[i] = tbl[SMU_REG_BAR(ndev, i)] + SMU_REG_OFF(ndev, i);
+	smu_conf.intr_enabled = ndev->priv->smu_intr_enabled;
 	ndev->aie.smu_hdl = aiem_smu_create(&xdna->ddev, &smu_conf);
 	if (!ndev->aie.smu_hdl) {
 		XDNA_ERR(xdna, "failed to create smu");
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 13391275df31..26e3ccdaddd5 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -190,6 +190,7 @@ struct amdxdna_dev_priv {
 	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
 	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
 	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
+	bool				smu_intr_enabled;
 	const struct aie_hw_ops		*hw_ops;
 };
 
diff --git a/drivers/accel/amdxdna/aie_smu.c b/drivers/accel/amdxdna/aie_smu.c
index 62aea550aabc..36a5cf88aea7 100644
--- a/drivers/accel/amdxdna/aie_smu.c
+++ b/drivers/accel/amdxdna/aie_smu.c
@@ -26,22 +26,31 @@
 
 struct smu_device {
 	struct drm_device	*ddev;
-	struct smu_config	conf;
 	void __iomem		*smu_regs[SMU_MAX_REGS];
+	bool			intr_enabled;
 };
 
 static int aie_smu_exec(struct smu_device *smu, u32 reg_cmd, u32 reg_arg, u32 *out)
 {
-	u32 resp;
+	u32 resp, intr;
 	int ret;
 
+	if (smu->intr_enabled) {
+		ret = readx_poll_timeout(readl, SMU_REG(smu, SMU_INTR_REG), intr,
+					 !(intr & 0x2), AIE_INTERVAL, AIE_TIMEOUT);
+		if (ret) {
+			drm_err(smu->ddev, "wait for smu intr idle timed out, 0x%x", intr);
+			return ret;
+		}
+	}
+
 	writel(0, SMU_REG(smu, SMU_RESP_REG));
 	writel(reg_arg, SMU_REG(smu, SMU_ARG_REG));
 	writel(reg_cmd, SMU_REG(smu, SMU_CMD_REG));
 
-	/* Clear and set SMU_INTR_REG to kick off */
-	writel(0, SMU_REG(smu, SMU_INTR_REG));
-	writel(1, SMU_REG(smu, SMU_INTR_REG));
+	/* Set SMU_INTR_REG to kick off */
+	if (smu->intr_enabled)
+		writel(1, SMU_REG(smu, SMU_INTR_REG));
 
 	ret = readx_poll_timeout(readl, SMU_REG(smu, SMU_RESP_REG), resp,
 				 resp, AIE_INTERVAL, AIE_TIMEOUT);
@@ -148,6 +157,7 @@ struct smu_device *aiem_smu_create(struct drm_device *ddev, struct smu_config *c
 
 	smu->ddev = ddev;
 	memcpy(smu->smu_regs, conf->smu_regs, sizeof(smu->smu_regs));
+	smu->intr_enabled = conf->intr_enabled;
 
 	return smu;
 }
diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
index b4a0ede636f0..0b45375ea110 100644
--- a/drivers/accel/amdxdna/npu1_regs.c
+++ b/drivers/accel/amdxdna/npu1_regs.c
@@ -124,6 +124,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
 		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
 		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
 	},
+	.smu_intr_enabled = true,
 	.hw_ops		= &(const struct aie_hw_ops) {
 		.set_dpm = npu1_set_dpm,
 	},
-- 
2.34.1

