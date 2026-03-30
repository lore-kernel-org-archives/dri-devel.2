Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EA41061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B92810E64A;
	Mon, 30 Mar 2026 16:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjQSCEk4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD49410E5C9
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 16:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAjwxLP758PAQThMI/hO5WVWAeRZ9nBG/VMDmrWMnOPiQ+is89AZNPxMRnU3IBQ8gDb+rTUJ6C6rUTJ6bFM5VIxFobicjHSJn8wIrkLUNCQAwF6hH1VeJ3flRvgvToHfNZ3BtypWuWytXTPCG1R+97LZrCx1oqz76+E1mGMPAojKJdV8zBarQDRQHZYCyMOkmNXTdvhXVvBHUfZzECqK/YgxJBQXpTtY94I0Rir38s5F8mI6bu+3BEdD5aNLRw/8ikVZATlAFcY4puWO9hzQ53+JJdiJnUujHjmwcPyFpV6C+QYZIMxD8ZFxPJPaTisRAtKnyE7Tudgak1bsvGoKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTvBVoSU2gjFJiK5+YJurq1tEyyy628UYSGIf/yOr2s=;
 b=wDk7wov8hVIBmykzKc2hkN/BvAGJNmZTdEXwG1sTRlM299u8U9lBkuk7RMX+FAoqbxs620ZX0p9YcGiLAkPBejXXSIP2dTIIQII7TJeC47S6ez4ixSYzMmE32UTtY00hrf1vXdxbGXP3SKnznO64yHpJFo0Oa9BBX3X9RYQl4Kf0jOUlbi57Pyu+33kDBcPf4vqmMMOcxv34Lx8xdGoch6qY9i7IxOCPI7GJknZYVpvw7UVF42AQ6MxujhMhgiEYSDvRqo7TRNJ82lYGHBhoJHUhKMFgZ4rtdjVnFhvmKvYC6AGlISSMiYpZpca3tf+suxbBQc86uXPn+uUNqLrhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTvBVoSU2gjFJiK5+YJurq1tEyyy628UYSGIf/yOr2s=;
 b=BjQSCEk4J7SCp90/fqy4eyuWI0sK8kn+q0Zi38pyuWJtQ+iiuX55uZP5mVztzy1vHT9z3PhzY9IzZdMyXn948QxGDS+OM6YEwz/cYKjGO7zzN4WpEEv4r1zRIqd1+jcPHxtU+0j6yRuyfl3HW09gzA5rK3HbAXdk78aJW2A7Kz0=
Received: from SA1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:806:2d3::8)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:37:19 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::be) by SA1PR03CA0004.outlook.office365.com
 (2603:10b6:806:2d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 16:37:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 11:37:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:37:17 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 11:37:16 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1 3/6] accel/amdxdna: Create common PSP interfaces for AIE2
 and AIE4
Date: Mon, 30 Mar 2026 09:37:02 -0700
Message-ID: <20260330163705.3153647-4-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330163705.3153647-1-lizhi.hou@amd.com>
References: <20260330163705.3153647-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a100118-ad0e-45f0-7bae-08de8e7a9c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gsmihKi7YNTgajNEivK5yw59aaWljvPrg8qPYw1cGADDtneybYYfKLtPd7s9hpfFDq9g3Ms0vA6Agk5DtwGejLmwUTneBIhUrc42NemFy0wG+Y2GHN1jj7Ewnmy7eGkCm3MCIGGoEvlYccvthfwVJbwJN5/VzqHqUetZ17JUbH6xtntEtOnefZbH8ubDibTwKeo/oxk1gs9f2AdzzPDhL/Jy73Bf+CO95iSZpo4JFc6B+vyskcjvyg2vi2WnVrCrytcqAmjg5/ldnie6Uhj7Pgbed9WJizbAa34Zq3LWeCdNqUTCyCWQvYdFUQxAz9IKLp/6c8CxEnxycsDuBLZ4PAao6b1jUJSEPhKgE2TuyffxhDNH9lhQ8rCRJ+/kliKUtYUKzUunc+JovAqA+aSRRSO9ob6WBJuE1gVzEnKu81znM6D5rdIRXQ87PsOw9Pdi8TA+pDl3lMg7UrHq/SZwkSI/47y9frYiP+1z3wpmRSmxQMsvrUoDG9DDgP8tale6qioGBgakxAXxakmO/LW/w7F7O2Zovz3+fIYopmdU8yXH19tKTKfI81shxNCF65Lztfq3462FiMnyelODx/6OM72kVhw4fCY5qhlFhzNAyBWBc2wg3YUdyvEJLcdEprw9IOfBppbH++IgHZLTcI8ZhjtAyqpHF/fM7JeFMtc5G2dNmfy0TOWwBjMP6SJ3om3y5koyQt0MSp6ISLQsOdR30XqEDX0VUfbAg0R7LWcCOYrp+bcL0GtOs//s5HyAO219jKjM/BwQ3stpCbDv48mUOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FbP4ISLL+L1sr0tB0k+xWdY+TEJhnrIWo7vigDEgJUMnAwGpbY89Fu/xK/6A5fRnrgImj+5ec0H0R7HVXnTuAqdHRagMJUlz0DuhsRP+Gw58tDgm0rNadvMlen+2aloA8z8oEQbUNhVgmQEzkQWDIaOGpX8XgOZSyyBk2/d3pmO5PRIVD7xBtk9XWCrfAjOPhfYLA5EPnjEbmfDfA00rGpYOc/OrO/hwMHAzJ0U3gO04+S5B6FnDAyU+7VmMrdxkJy1wF8D26DuEO1pTKf4V1vJN+OW+XAFQkhx8cRnpUOQoNPlgoVsgU+TV9fxu6eiTA1Pyc+0Or9r5ySyhRLZesaESggLGaVJ9lxhBEV1NVv9gffQ0m/qch8VWIuSwLNhfNCeaCwrYU237DwLnkOMxmsEe1WXGHGr8E9fdjv0KCoqF12YvhkO467cq1e7dqGqh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:37:19.5510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a100118-ad0e-45f0-7bae-08de8e7a9c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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

The AIE2 and AIE4 use the similar interface to PSP (Platform Security
Processor). Move the PSP implementation into aie_psp.c so both platforms
use the same path and future AIE4 PSP work can build on it.

Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/Makefile                |  2 +-
 drivers/accel/amdxdna/aie.h                   | 41 +++++++++++++++++
 drivers/accel/amdxdna/aie2_message.c          |  2 +-
 drivers/accel/amdxdna/aie2_pci.c              | 12 ++---
 drivers/accel/amdxdna/aie2_pci.h              | 44 ++-----------------
 .../accel/amdxdna/{aie2_psp.c => aie_psp.c}   | 17 +++----
 6 files changed, 60 insertions(+), 58 deletions(-)
 rename drivers/accel/amdxdna/{aie2_psp.c => aie_psp.c} (88%)

diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
index a61cd6c0db30..d3c0fe765a8b 100644
--- a/drivers/accel/amdxdna/Makefile
+++ b/drivers/accel/amdxdna/Makefile
@@ -2,12 +2,12 @@
 
 amdxdna-y := \
 	aie.o \
+	aie_psp.o \
 	aie2_ctx.o \
 	aie2_error.o \
 	aie2_message.o \
 	aie2_pci.o \
 	aie2_pm.o \
-	aie2_psp.o \
 	aie2_smu.o \
 	aie2_solver.o \
 	aie4_message.o \
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 6c53870d0098..124c0f7e9ca0 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -11,6 +11,8 @@
 #define AIE_INTERVAL	20000	/* us */
 #define AIE_TIMEOUT	1000000	/* us */
 
+struct psp_device;
+
 struct aie_device {
 	struct amdxdna_dev *xdna;
 	struct mailbox_channel *mgmt_chann;
@@ -20,15 +22,54 @@ struct aie_device {
 	u32 mgmt_prot_major;
 	u32 mgmt_prot_minor;
 	unsigned long feature_mask;
+
+	struct psp_device *psp_hdl;
 };
 
 #define DECLARE_AIE_MSG(name, op) \
 	DECLARE_XDNA_MSG_COMMON(name, op, -1)
 #define AIE_FEATURE_ON(aie, feature) test_bit(feature, &(aie)->feature_mask)
 
+#define PSP_REG_BAR(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].bar_idx)
+#define PSP_REG_OFF(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].offset)
+
+#define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
+	[reg_name] = {bar##_BAR_INDEX, (reg_addr) - bar##_BAR_BASE}
+
+enum psp_reg_idx {
+	PSP_CMD_REG = 0,
+	PSP_ARG0_REG,
+	PSP_ARG1_REG,
+	PSP_ARG2_REG,
+	PSP_NUM_IN_REGS, /* number of input registers */
+	PSP_INTR_REG = PSP_NUM_IN_REGS,
+	PSP_STATUS_REG,
+	PSP_RESP_REG,
+	PSP_PWAITMODE_REG,
+	PSP_MAX_REGS /* Keep this at the end */
+};
+
+struct aie_bar_off_pair {
+	int	bar_idx;
+	u32	offset;
+};
+
+struct psp_config {
+	const void		*fw_buf;
+	u32			fw_size;
+	void __iomem		*psp_regs[PSP_MAX_REGS];
+};
+
+/* aie.c */
 void aie_dump_mgmt_chann_debug(struct aie_device *aie);
 void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
 int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
 int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
 
+/* aie_psp.c */
+struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
+int aie_psp_start(struct psp_device *psp);
+void aie_psp_stop(struct psp_device *psp);
+int aie_psp_waitmode_poll(struct psp_device *psp);
+
 #endif /* _AIE_H_ */
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index ccf87b1aa1cc..e5e7da7a8f40 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -75,7 +75,7 @@ int aie2_suspend_fw(struct amdxdna_dev_hdl *ndev)
 		return ret;
 	}
 
-	return aie2_psp_waitmode_poll(ndev->psp_hdl);
+	return aie_psp_waitmode_poll(ndev->aie.psp_hdl);
 }
 
 int aie2_resume_fw(struct amdxdna_dev_hdl *ndev)
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 708d0b7fd2e3..e4b7893bd429 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -297,7 +297,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 	aie_destroy_chann(&ndev->aie, &ndev->aie.mgmt_chann);
 	drmm_kfree(&xdna->ddev, ndev->mbox);
 	ndev->mbox = NULL;
-	aie2_psp_stop(ndev->psp_hdl);
+	aie_psp_stop(ndev->aie.psp_hdl);
 	aie2_smu_fini(ndev);
 	aie2_error_async_events_free(ndev);
 	pci_disable_device(pdev);
@@ -350,7 +350,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		goto free_channel;
 	}
 
-	ret = aie2_psp_start(ndev->psp_hdl);
+	ret = aie_psp_start(ndev->aie.psp_hdl);
 	if (ret) {
 		XDNA_ERR(xdna, "failed to start psp, ret %d", ret);
 		goto fini_smu;
@@ -413,7 +413,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 	aie2_suspend_fw(ndev);
 	xdna_mailbox_stop_channel(ndev->aie.mgmt_chann);
 stop_psp:
-	aie2_psp_stop(ndev->psp_hdl);
+	aie_psp_stop(ndev->aie.psp_hdl);
 fini_smu:
 	aie2_smu_fini(ndev);
 free_channel:
@@ -463,7 +463,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	void __iomem *tbl[PCI_NUM_RESOURCES] = {0};
 	struct init_config xrs_cfg = { 0 };
 	struct amdxdna_dev_hdl *ndev;
-	struct psp_config psp_conf;
+	struct psp_config psp_conf = { 0 };
 	const struct firmware *fw;
 	unsigned long bars = 0;
 	char *fw_full_path;
@@ -551,8 +551,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	psp_conf.fw_buf = fw->data;
 	for (i = 0; i < PSP_MAX_REGS; i++)
 		psp_conf.psp_regs[i] = tbl[PSP_REG_BAR(ndev, i)] + PSP_REG_OFF(ndev, i);
-	ndev->psp_hdl = aie2m_psp_create(&xdna->ddev, &psp_conf);
-	if (!ndev->psp_hdl) {
+	ndev->aie.psp_hdl = aiem_psp_create(&xdna->ddev, &psp_conf);
+	if (!ndev->aie.psp_hdl) {
 		XDNA_ERR(xdna, "failed to create psp");
 		ret = -ENOMEM;
 		goto release_fw;
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 96960a2219a4..4f036b9fa096 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2023-2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2023-2026, Advanced Micro Devices, Inc.
  */
 
 #ifndef _AIE2_PCI_H_
@@ -23,8 +23,6 @@
 #define AIE2_SRAM_OFF(ndev, addr) ((addr) - (ndev)->priv->sram_dev_addr)
 #define AIE2_MBOX_OFF(ndev, addr) ((addr) - (ndev)->priv->mbox_dev_addr)
 
-#define PSP_REG_BAR(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].bar_idx)
-#define PSP_REG_OFF(ndev, idx) ((ndev)->priv->psp_regs_off[(idx)].offset)
 #define SRAM_REG_OFF(ndev, idx) ((ndev)->priv->sram_offs[(idx)].offset)
 
 #define SMU_REG(ndev, idx) \
@@ -88,30 +86,11 @@ enum aie2_sram_reg_idx {
 	SRAM_MAX_INDEX /* Keep this at the end */
 };
 
-enum psp_reg_idx {
-	PSP_CMD_REG = 0,
-	PSP_ARG0_REG,
-	PSP_ARG1_REG,
-	PSP_ARG2_REG,
-	PSP_NUM_IN_REGS, /* number of input registers */
-	PSP_INTR_REG = PSP_NUM_IN_REGS,
-	PSP_STATUS_REG,
-	PSP_RESP_REG,
-	PSP_PWAITMODE_REG,
-	PSP_MAX_REGS /* Keep this at the end */
-};
-
 struct amdxdna_client;
 struct amdxdna_fw_ver;
 struct amdxdna_hwctx;
 struct amdxdna_sched_job;
 
-struct psp_config {
-	const void	*fw_buf;
-	u32		fw_size;
-	void __iomem	*psp_regs[PSP_MAX_REGS];
-};
-
 struct aie_version {
 	u16 major;
 	u16 minor;
@@ -206,7 +185,6 @@ struct amdxdna_dev_hdl {
 	void			__iomem *sram_base;
 	void			__iomem *smu_base;
 	void			__iomem *mbox_base;
-	struct psp_device		*psp_hdl;
 
 	u32				total_col;
 	struct aie_version		version;
@@ -236,14 +214,6 @@ struct amdxdna_dev_hdl {
 	struct amdxdna_async_error	last_async_err;
 };
 
-#define DEFINE_BAR_OFFSET(reg_name, bar, reg_addr) \
-	[reg_name] = {bar##_BAR_INDEX, (reg_addr) - bar##_BAR_BASE}
-
-struct aie2_bar_off_pair {
-	int	bar_idx;
-	u32	offset;
-};
-
 struct aie2_hw_ops {
 	int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
 };
@@ -271,9 +241,9 @@ struct amdxdna_dev_priv {
 	u32				mbox_size;
 	u32				hwctx_limit;
 	u32				sram_dev_addr;
-	struct aie2_bar_off_pair	sram_offs[SRAM_MAX_INDEX];
-	struct aie2_bar_off_pair	psp_regs_off[PSP_MAX_REGS];
-	struct aie2_bar_off_pair	smu_regs_off[SMU_MAX_REGS];
+	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
+	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
+	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
 	struct aie2_hw_ops		hw_ops;
 };
 
@@ -300,12 +270,6 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
 int aie2_pm_set_mode(struct amdxdna_dev_hdl *ndev, enum amdxdna_power_mode_type target);
 int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
 
-/* aie2_psp.c */
-struct psp_device *aie2m_psp_create(struct drm_device *ddev, struct psp_config *conf);
-int aie2_psp_start(struct psp_device *psp);
-void aie2_psp_stop(struct psp_device *psp);
-int aie2_psp_waitmode_poll(struct psp_device *psp);
-
 /* aie2_error.c */
 int aie2_error_async_events_alloc(struct amdxdna_dev_hdl *ndev);
 void aie2_error_async_events_free(struct amdxdna_dev_hdl *ndev);
diff --git a/drivers/accel/amdxdna/aie2_psp.c b/drivers/accel/amdxdna/aie_psp.c
similarity index 88%
rename from drivers/accel/amdxdna/aie2_psp.c
rename to drivers/accel/amdxdna/aie_psp.c
index 3a7130577e3e..8743b812a449 100644
--- a/drivers/accel/amdxdna/aie2_psp.c
+++ b/drivers/accel/amdxdna/aie_psp.c
@@ -1,19 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022-2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
  */
 
 #include <drm/drm_device.h>
-#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
-#include <drm/gpu_scheduler.h>
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
+#include <linux/slab.h>
 
-#include "aie2_pci.h"
-#include "amdxdna_mailbox.h"
-#include "amdxdna_pci_drv.h"
+#include "aie.h"
 
 #define PSP_STATUS_READY	BIT(31)
 
@@ -76,7 +73,7 @@ static int psp_exec(struct psp_device *psp, u32 *reg_vals)
 	return 0;
 }
 
-int aie2_psp_waitmode_poll(struct psp_device *psp)
+int aie_psp_waitmode_poll(struct psp_device *psp)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(psp->ddev);
 	u32 mode_reg;
@@ -91,7 +88,7 @@ int aie2_psp_waitmode_poll(struct psp_device *psp)
 	return ret;
 }
 
-void aie2_psp_stop(struct psp_device *psp)
+void aie_psp_stop(struct psp_device *psp)
 {
 	u32 reg_vals[PSP_NUM_IN_REGS] = { PSP_RELEASE_TMR, };
 	int ret;
@@ -101,7 +98,7 @@ void aie2_psp_stop(struct psp_device *psp)
 		drm_err(psp->ddev, "release tmr failed, ret %d", ret);
 }
 
-int aie2_psp_start(struct psp_device *psp)
+int aie_psp_start(struct psp_device *psp)
 {
 	u32 reg_vals[PSP_NUM_IN_REGS];
 	int ret;
@@ -129,7 +126,7 @@ int aie2_psp_start(struct psp_device *psp)
 	return 0;
 }
 
-struct psp_device *aie2m_psp_create(struct drm_device *ddev, struct psp_config *conf)
+struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf)
 {
 	struct psp_device *psp;
 	u64 offset;
-- 
2.34.1

