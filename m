Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CB606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rEaBlfb7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331AD10F999;
	Tue, 17 Nov 2026 22:32:15 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A6010E6ED
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWRAmzdXu7p5W0wCkOKONfebNzt+zqn+JLRgnPq9kZ1ojvxggkAbv/E4pXvwZtO+p4zPdC7jdEwJew3JSBjHg4G5Gy7ByAn8F+g5wrS5kPDYFA7N06SHFdTUjmh5Sa9akuP8BjNiD6UKRi1SJHdw6lTx4fmCflHCKpJmSRWef8LUobvD7KUiVNbOaDrFEt24pi/TpOaac5sike+Z41r4O0PPHNe4HjyJthnC4kzUIk4Vj4dxWiCmd0mwP8h9Bzcr/frwkJYOpbJ7UoymSFmgXXyFPIqEnEOMvt9bXUtCqpwTDxUMzVYfwAeaCgZ+TKqDt9Si/mbfhJD9YlyqONwt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ/M9ja6XgjtpGs4U+MHpmE2XhjgAeyHJGbTosQL02s=;
 b=yn4P/oUww7v8fKvYtVtvuPc1Zz5Svz3Pg32FV50BWy3RjW5hp8kvSq6TNGsunvdJ0zO9nzCIWQagrDKdxMmXvtPrfzgGzJRRZO7IISEIV631F5+T0fcRHxnPyN7UTTfrpfVcwiAanBMEzuKFzKCHGeLsZlkEWcl1mcf7CfyuQvwlIsOOKnNOms/fueplPjUXu75saVU2pgq7kYnAjg9WDDF7WYCU551d3/nFHaJVUtO+v1W7mvIEL8AAYWHVUEia8z5nyVvhjbZzCM8H3IyqCgZi02FzI+vnRcJ5hgqj9um8VzaLXnuG3J2e6aBRq3MiXm9WRXbvpHL61TUetduDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ/M9ja6XgjtpGs4U+MHpmE2XhjgAeyHJGbTosQL02s=;
 b=rEaBlfb7aTty0UEXRF/43GOf6mi6nuoVVUKVFq2/nzqoCJL9xse9hagOpAFqfz+OJVa4bvED0lMen6uR2X7FhcSThzdqaB5ZbFRob2/r+ani6z9kGc8tSKIhsFNC3bU9Mo58ydLJl1O80YMqCRCIiXDS9jUZVgkZVo2PN6wW0vM=
Received: from CH0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:610:b1::8)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:32:00 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:b1:cafe::63) by CH0PR13CA0003.outlook.office365.com
 (2603:10b6:610:b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Tue, 17
 Nov 2026 22:32:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 17 Nov 2026 22:32:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:31:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:31:45 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 16:31:45 -0600
From: Max Zhen <max.zhen@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <lizhi.hou@amd.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1 RESEND] accel/amdxdna: Fix SMU command execution on
 platforms without interrupt trigger
Date: Tue, 17 Nov 2026 14:31:42 -0800
Message-ID: <20261117223142.179304-1-max.zhen@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 311620a0-fb4d-487f-3b9c-08df44fa987f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|18002099003|261009223027099003|3023799007|261022113327099003|261022075727099003|261021135927099003|261022115727099003|261022105027099003|261021123027099003|261021121427099003|261026130827099003|261026121527099003|261026140227099003|261026135527099003|261028144727099003|56012099006|11063799006|261021130227099003|261021133027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: rqcsOeY7TK9jz7vMp3Q2MEv4TIeRY8C031TcQ+vVqZn2gYJtyZls7RoXtaQkRT9oRG9xuCDkqy2G0/rzOteI1hBFUuPQoKSf7TfCAXPO3eC5Ves7k4M9PcqgAOdKJlm0QqhivZnw6Vp4nyCz3Ll2nD3RQ/gLHr+cW86preoJdKLiTP3kUxqUSSQZhS6YtcIy277m45gS0FxhOAEpoQCgaO0dFoH9SZtK5r3ohSVklBhuVidhaKsXEONg+7Us5Efrn3hMjcnh5rmY6ggGSFZsW2woy989yCV0QTW7RYG8jSZ8e+WGihNubB3yOVo38Jxd9ccUKAHc39DoZy6BJw4RYr2gsFWfYXfelOJlmk0J2WcFKjBrenZKXGGZmkVEDG1/b3Ki2i7HAySsUZovyWn847maUFSKXf2N1MHBER7QdEWSQ09BqCtQDyVDajMTVuQMs77tFSO1IzeOXRZYJmtQMTFTBRSyKQYZh1Kp4xzUzNikdN+p0QZUSOA1+Vb6HO9BQwqqPN4N8BL/2pXNiaUXeNBP8TXz45JJXRkJ5kIxW21LhJ+jot/UTodRo2RjCfLuxdnwGwLnK8i3jK6nt0NZua3KdD6yKEgM3CONO3R278I5LuV8z/KW3mhfB7OjRoPl1BDXvL1By3lJ1eGynJenhRBh7o+cX5Y3q7eJ7QeBYDEp2n8IsrhyAtg+xG7TeJFXsEUeDu+zyykrlf3+sVTQcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(261009223027099003)(3023799007)(261022113327099003)(261022075727099003)(261021135927099003)(261022115727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026130827099003)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(56012099006)(11063799006)(261021130227099003)(261021133027099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fNnaK7eHBUqB8Oqi29ZQdOEFLkkYPaDLLf5Ho8X05OPS8jDvyrQ4PLOX3vO+H99FpRjuoODEhq7iUYiTpEqEGG4Vf5RLPXCibv8orYYLXAfpQVaa8IQmjkgutGOiT/prJOa+MxFyPOeXBmgjZ5g3EW0vjxOuXvU7LStuNP0idhXhxV5KQbCPjGT48Ct0tQWLOAFlyrGGYdjhBwLMpFyViJlCuF6n8+izUND0OvZlANmRJIjtZsmEVEh7xaHVIKiH89eObdHuMzuq5SqbD1cJQ7ufqT/t/JwGYGTircgodlUrNWMzRLcfgXK0jAZn2wT1IPGsf/buV0X9UvGUgl8euVDNBDo7tyRGsDHNorrJa0uoKvyYrIvBL53/+v3mcQ6ilibFnjssKJhF2G8O1WQMGiLAWWVsVVUHQGbVht8WpPf1p2hFWIAXkxGevPQifW/3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:32:00.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311620a0-fb4d-487f-3b9c-08df44fa987f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
index 13af4b9b2cf2b..991e45ac7f364 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -110,6 +110,7 @@ struct aie_bar_off_pair {
 
 struct smu_config {
 	void __iomem    *smu_regs[SMU_MAX_REGS];
+	bool		intr_enabled;
 };
 
 struct psp_config {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index a3866e8933e61..cc53c1fc39443 100644
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
index 13391275df318..26e3ccdaddd54 100644
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
index 62aea550aabcf..36a5cf88aea75 100644
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
index b4a0ede636f0d..0b45375ea1108 100644
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

