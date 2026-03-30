Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0809B1061B16
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FA210E658;
	Mon, 30 Mar 2026 16:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+IAJJ0w";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7805910E651
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 16:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNaFhioOWTH0P4kMBsTpoTVtE1orjUzkQgOPkRmhk/bBciXf5rtALstynzRt7N5FfLuS5sMOq6s1H7lNmfROdoegkgFsYjkWGKYwSY8BiohqiK9BbLtFwcg7eIdHogN4gS1SVlLvTd6Cae0j0ZPRILtgZ+43MyfC+iD9CkibqCytzYSeuQMuw+nJgQ8AsNv6iEmDCuh1nfAPPHNdEYEdFkFpwVR7NU/DOReIsnEM7en63IbalHSN0b2PQhjqWMerMJw8QG9zoN/Rsbgkw944NhoniX2M0FCrjKfat43KclZ8pFx4tfX6cTEYSTd6aFRVfz0BcfQwiFDTKYD9xQS6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Dye76UQhgvD46wJTtZxiA9F2lY7l0tKZtthZW1rPA=;
 b=xXRNj3ff6K06/UB+Z9x3OMzUo9O5MV21fptj9A6Jqjh6iUV1QHkSSs6NxxvGg3hbxAbC3IMtMttVBK9TD25IdeMl57zl/dqjCfIs4i00gr+3D/BN2NFYLbV1acvXFLgnAw/bFC3yTdPwsuwtycuZ7tWXOIdO/FBd1KX4K2YM8Y6XXXCPuluUYCJaQLdtbcoKAu8RrW4E4qrwC+qOXkwhGsevgyH9Cd9Pdy2cNcEGB+Xp8GTkcqNGOAQTQZRWSpkkwuf7JS4CcGrdeodOny6g23Q1Pat1spyVQn0QEVNkRIigGQLtToUVbJJ3M7Os2PUOqyoheU6YYnX0uIFnm7lFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Dye76UQhgvD46wJTtZxiA9F2lY7l0tKZtthZW1rPA=;
 b=f+IAJJ0wTi3yr32JAlEf4f6EumVvFC/bad3w+NduAUkyIOY9HO+8jGL5ovLQcupH5IqL6UbZPGRf4Z1MjrPwMDWi0lNP96/xTeMfae3hipevR47rT0VsaVw4EQtiHhcXmNNRtiDzvXw86WLOcjyv85dsaaCEOe00h3PdUv/BqwU=
Received: from SA0PR12CA0021.namprd12.prod.outlook.com (2603:10b6:806:6f::26)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:37:22 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::8) by SA0PR12CA0021.outlook.office365.com
 (2603:10b6:806:6f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 16:37:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 11:37:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:37:20 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 11:37:19 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 6/6] accel/amdxdna: Add AIE4 power on and off support
Date: Mon, 30 Mar 2026 09:37:05 -0700
Message-ID: <20260330163705.3153647-7-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330163705.3153647-1-lizhi.hou@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 84876440-5c28-4a7e-52ef-08de8e7a9dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZeVnZ5SxfxdcbOet0VqnOfhSYWk16/fi/NvyblL8R5GTuZb7dEFwKTpYtLtYw7JVhgKEYE/pAiEe+6jqB5qv/5EAMDlmoK+68+Xn8Qh+qgVGd9dXfCMEJnVKC0py9x/XLPWpe6qvQwgpJnG3LTRd6084ZbtHzyW2mcqK61D2uPDe620Vyk8axXPjnjj4Ufl+3iOw/wswlUGxJzUzW56QxVvMJhwB3Ui+C2ONsYvNU+zaeDTLWWJYOEWEqYMUgZftawwAZ+jxC8LASMIXxtPxQwpFI/hJxRhkyJtfEjBAdctKJSmcLa39iyZngocjzzCwcME12HdKUNRXM2VyXEFFrWkxzPXr9FDo4gkUE8rJHKmlWX4cgqtNjNmz9L28jITiOGQTsBap9SD37bgKMchlF+r8bdfpiI16ovOIdRpkClmO+i/zlCJ5EE2hGT2sowXOVfgGqTDyLet/mjOhgWS+8HVwkAffGQZTPZ5lXvHwN/7IxJmp7FRJQN5FGxwchbAhdPsFDnd5Alkb1IfifwU8Petcoakaxuh84HQqqwxUZl2vYrTuVzBiBZ+2EdyV9p++7BGCTKFG57YQFh3TyNvt8uxU/R5VxSmoVTClpPt484+jzM3T00qTUHATN6gZaXQmXFnadq/sn4OHudgJL2/2Gqc7oZSp+v+Pv9IrwmuiWeCWKD6c2gVF67NWC6YnI0GyICHP5VU17o8NwyqIVGPyp731Eaj5GhuXPbFQ2lmW6pjQneKjfNjxj2NQNUdUP8CzEF16MAIzYk/i08EYPAMEiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9EijVfL+dAR/UfEiIzIJzcdw0v81rxPHj/7zMAQeoW40uZRjofJbLvPuZaKuh8p5DfXBss3ZjdYQnR8KQHJuQQnpu5iT7xhh3ciW3y2sFCbpDH1NhVRpNa5He0qd0tWLzO/GzHT8K1w8BFTZq8vP3ScKxtN8nW05YXT15SLVvVy63WHoVJVNJBQR7cHjUzG6PaxPkGXdP4nGOSxZD6fH/T2i0y6jttUVT3giHadk72dOVuUMGcJSrIO+dYrayS+l1iOy1C8gW0rYdRwQKjk9iS6LC38g46hfRB1OWUFiKDgJ1Gcrflhpgid+Pjem5BDc9EPIUGX4hB1dVknkwRTqa29BUmsXRZxoQwRwmA4r7cADIudnHxgneINUxGgC/y41rj64JlE00rvx1hLLHM0BQAYZ1IYcg8Qp3KWRAvTaqwkDkhGlE6ZbQXsIN+CB93Cw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:37:21.7681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84876440-5c28-4a7e-52ef-08de8e7a9dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

Implement AIE4 power on and off control using the common SMU interfaces.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie4_pci.c  | 28 +++++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h  |  1 +
 drivers/accel/amdxdna/npu3_regs.c | 17 ++++++++++++++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index e7993b315996..2249b2c9398d 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -212,11 +212,26 @@ static int aie4_mailbox_init(struct amdxdna_dev *xdna)
 static void aie4_fw_unload(struct amdxdna_dev_hdl *ndev)
 {
 	aie_psp_stop(ndev->aie.psp_hdl);
+	aie_smu_fini(ndev->aie.smu_hdl);
 }
 
 static int aie4_fw_load(struct amdxdna_dev_hdl *ndev)
 {
-	return aie_psp_start(ndev->aie.psp_hdl);
+	int ret;
+
+	ret = aie_smu_init(ndev->aie.smu_hdl);
+	if (ret) {
+		XDNA_ERR(ndev->aie.xdna, "failed to init smu, ret %d", ret);
+		return ret;
+	}
+
+	ret = aie_psp_start(ndev->aie.psp_hdl);
+	if (ret) {
+		XDNA_ERR(ndev->aie.xdna, "failed to start psp, ret %d", ret);
+		aie_smu_fini(ndev->aie.smu_hdl);
+	}
+
+	return ret;
 }
 
 static int aie4_hw_start(struct amdxdna_dev *xdna)
@@ -331,6 +346,7 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
 {
 	struct amdxdna_dev *xdna = ndev->aie.xdna;
 	struct psp_config psp_conf;
+	struct smu_config smu_conf;
 	int i;
 
 	psp_conf.fw_size = npufw->size;
@@ -347,6 +363,14 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < SMU_MAX_REGS; i++)
+		smu_conf.smu_regs[i] = tbl[SMU_REG_BAR(ndev, i)] + SMU_REG_OFF(ndev, i);
+	ndev->aie.smu_hdl = aiem_smu_create(&xdna->ddev, &smu_conf);
+	if (!ndev->aie.smu_hdl) {
+		XDNA_ERR(xdna, "failed to create smu");
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -374,6 +398,8 @@ static int aie4_pcidev_init(struct amdxdna_dev_hdl *ndev)
 
 	for (i = 0; i < PSP_MAX_REGS; i++)
 		set_bit(PSP_REG_BAR(ndev, i), &bars);
+	for (i = 0; i < SMU_MAX_REGS; i++)
+		set_bit(SMU_REG_BAR(ndev, i), &bars);
 	set_bit(xdna->dev_info->mbox_bar, &bars);
 	set_bit(xdna->dev_info->sram_bar, &bars);
 
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index ee388ccf7196..aa1495c3370b 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -21,6 +21,7 @@ struct amdxdna_dev_priv {
 	u64			mbox_info_off;
 
 	struct aie_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
+	struct aie_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
 };
 
 struct amdxdna_dev_hdl {
diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
index fb2bd60b8f00..5a0bbc916094 100644
--- a/drivers/accel/amdxdna/npu3_regs.c
+++ b/drivers/accel/amdxdna/npu3_regs.c
@@ -17,15 +17,23 @@
 /* PCIe BAR Index for NPU3 */
 #define NPU3_REG_BAR_INDEX	0
 #define NPU3_PSP_BAR_INDEX      4
+#define NPU3_SMU_BAR_INDEX      5
 
 #define MMNPU_APERTURE3_BASE    0x3810000
+#define MMNPU_APERTURE4_BASE    0x3B10000
+
 #define NPU3_PSP_BAR_BASE       MMNPU_APERTURE3_BASE
+#define NPU3_SMU_BAR_BASE       MMNPU_APERTURE4_BASE
 
 #define MPASP_C2PMSG_123_ALT_1  0x3810AEC
 #define MPASP_C2PMSG_156_ALT_1  0x3810B70
 #define MPASP_C2PMSG_157_ALT_1  0x3810B74
 #define MPASP_C2PMSG_73_ALT_1   0x3810A24
 
+#define MP1_C2PMSG_59_ALT_1     0x3B109EC
+#define MP1_C2PMSG_61_ALT_1     0x3B109F4
+#define MP1_C2PMSG_60_ALT_1     0x3B109F0
+
 static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
 	{ .major = 5, .min_minor = 10 },
 	{ 0 }
@@ -47,13 +55,20 @@ static const struct amdxdna_dev_priv npu3_dev_priv = {
 		DEFINE_BAR_OFFSET(PSP_RESP_REG,   NPU3_PSP, MPASP_C2PMSG_156_ALT_1),
 		/* npu3 doesn't use 8th pwaitmode register */
 	},
-
+	.smu_regs_off   = {
+		DEFINE_BAR_OFFSET(SMU_CMD_REG,  NPU3_SMU, MP1_C2PMSG_59_ALT_1),
+		DEFINE_BAR_OFFSET(SMU_ARG_REG,  NPU3_SMU, MP1_C2PMSG_61_ALT_1),
+		DEFINE_BAR_OFFSET(SMU_INTR_REG, NPU3_SMU, MMNPU_APERTURE4_BASE),
+		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU3_SMU, MP1_C2PMSG_60_ALT_1),
+		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU3_SMU, MP1_C2PMSG_61_ALT_1),
+	},
 };
 
 const struct amdxdna_dev_info dev_npu3_pf_info = {
 	.mbox_bar		= NPU3_MBOX_BAR,
 	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
 	.psp_bar                = NPU3_PSP_BAR_INDEX,
+	.smu_bar		= NPU3_SMU_BAR_INDEX,
 	.vbnv			= "RyzenAI-npu3-pf",
 	.device_type		= AMDXDNA_DEV_TYPE_PF,
 	.dev_priv		= &npu3_dev_priv,
-- 
2.34.1

