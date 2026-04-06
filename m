Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B42FB5164
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B88C10E2BF;
	Mon,  6 Apr 2026 22:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OGHi/I3b";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5982A10E2BF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 22:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmkDtDAdZtk0mFj1DHRpu0ridzlBQv7M5sGkvAI0SPgEzRlT9zP975EwfrTjxsyBJOxwyH2dxaz1XLbhJZOmh+Z2BpQaW8QLWUBOEbY3PLW3xf75W0AWqr/EVEtO5dkMbqAHlZ/AF1kVaFDLWZ8cy/Pqx2RESmDB4wLOiZBRMuV22jo1P2KCmP4jRw6t9K+nTY8t2UaNzbJhkcdhjAyACl+h2wSzTwM3oU6LBNo3wmcuCsWEix4gcchjdMzVKKBQtOgHGGWH6PeKZy9nCZjWEb9A8NPOBgHMMHQ9QnpSeMSm7ds5/9C1HZgQ/7sNQo4cHaWjIa3jo4rb0GJR20+Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYs+s7fZKC6hCZ3f7g7CO/Y6opAsaFBzot0tfkb1U6U=;
 b=B3ohK7BPlVrgMJfkZMwcgmrfc19ZvarBFRao4j2JRKoV0dCJUuSwCoKD5QXOQ5c9YglKFraS45133XyN+D7HTnay7P9+xd50o+OF/gXcbMkQsB9NZHVVz7zO13Tw2qt3wbrXXtgKhX6hvgVLottZioSUNjCxobl5GHdvHpWemJQqA9ubzAlv0zdiUEHW/cXp16w8e5fVE0V7rKhNYJv1pXqB5ScX1Wiv1fwa3h1MjodvQz6kIiEQMFKZqeWwTKuokJCqZB+76Po/fJfx1ozTCn8YoeeHqkSIkRvVP16+I0YPfBQ49fgtJzzDUxH4kPXvkljw0jpA+N3ZbD0FaE4t6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYs+s7fZKC6hCZ3f7g7CO/Y6opAsaFBzot0tfkb1U6U=;
 b=OGHi/I3brWcT6SKSm2+4jFprUc8lh88u/LMkfHs4RO5Hs9F5O81LROs/0D/uawXsu8G+HJzwt3kzJ6kNYDdpuKGJ6fKD44SaBoaNI+cXbWdSOLQsGpcbNNPR7BcEll2o9e/i2fNzyVxh9yHI3eM0iUFYrHbVXtTMCOg/6FwMLDA=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 22:05:29 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::90) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 22:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 22:05:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 17:05:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 15:05:28 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 17:05:27 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Read real-time clock frequencies
Date: Mon, 6 Apr 2026 15:05:26 -0700
Message-ID: <20260406220526.4027917-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3771bce3-cc88-4f59-bf73-08de94289d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AEOpmSy818X/zjgHTBd89iavblJ0Cduhxr814PhSbRDuRCgefKi9FpGNLt/XnacLmJh51eRIVpKnHULtRml0bROKskKR5HXnpiwQL+ePZFcBiryKo3LBP7tLxHBNsIIqwB4o3O4jZf46WL4tsABAgzyF0BshR1PRGdOpEAkw69tRikG8ktDjH1Wz68CQo7zOpvOyspaVcvXPCT8/5LBeL2x/ygInNNANw1ITS++qLZw+UY72LJkuEuNXdxtD9tPFKsMEVnDEF6CUPIqFiRJDCdnns01uitX0nvWtMfUBF/qhemTTxGVs7LwROLGIkw8tnj7ofthGT+mFepMXz/MdITWCDq7vW46ls8Ga/yot3lpPqXLniYePx5Xe0A4RpVs3qFnHe6DmqtTjxYTggmakvMQx+HTqKLpXZAa1XXmcTuEOrK8eSM1jc2xp5maW+Y2enmLpzrcCAqoUXPW4vhp7/kI7r1aXKkGSpSe6CJ2GgdxPI+ZDKKXJj5HtEBxFd2uWxLttPIi/t6QYSITRJL2wwF/caaxhOwT3SJJPNpSQ6c8pk+6DXyGu22CGEwC2s/i7yP6hDxEyLZAd/Nrda4ztnfM5qXX1Kzk5D9Xq7l7WdAR7IX+zSvndNFWPaFc4JUPcHgBqwcOeDDkrDPambKREj0gRA1yGwGzitJk6dCDeu5YWRoYXLGn8x2MelFK6J99RxgY05XHurWkZc6yoO6ZOjkFiJz8dsNW9vxiNu7jEzF9FRcTvkRMqI03KPW7SBP+24VbEE0aTAbkHm5WjBiEHoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQ6Mw6oyse1oYZA9GZidzUd84LPOlX3HL+jnaPMstoYgfUsYdjDHN8FvPlP/BDM0JoMFmxNCgJuRd8Ligh19XX+Q293SsANUfdKlXts4WyFtKgcSJ8WYfwibzWTsAox7F+Smkm5+t2a5kJGqKGkYjmgqPnWEoTNN4ycqDDHhyRtRl1kCfTaFxAcnpbvbJcUvg11Gtc1taVhFdfNYEa/2eVp5zWIu04Uk90hS7Mu0m2RRGRv1tLFT7bevVH6AHVavmLsbb0u4NiD/jVrIs9bcKqJNOAeUKKniIuL9dCwTnLYxwKQWGp18G7RuqG6KKM1gafW7WAnxkgvlo8EzS6ncVXwQRr1l9I8O8oo5DFn5LNO+yhZQI6yi+57wp3hHXw42LSuPqyU4MuRosL87A+JehnAGYQ/Rzc/AVOlUXju0nbTXKVoU57u9plmE59fSpE0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 22:05:28.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3771bce3-cc88-4f59-bf73-08de94289d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

Add support for reading real-time clock frequencies through the PMF
interface.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c  |  4 +++-
 drivers/accel/amdxdna/aie2_pci.h  | 12 ++++++++--
 drivers/accel/amdxdna/aie2_pm.c   |  6 ++---
 drivers/accel/amdxdna/npu1_regs.c |  2 +-
 drivers/accel/amdxdna/npu4_regs.c | 39 +++++++++++++++++++++----------
 drivers/accel/amdxdna/npu5_regs.c |  4 +---
 drivers/accel/amdxdna/npu6_regs.c |  4 +---
 7 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 041cbc8cd7e5..c9c23c889c78 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -284,7 +284,7 @@ static struct xrs_action_ops aie2_xrs_actions = {
 
 static void aie2_smu_fini(struct amdxdna_dev_hdl *ndev)
 {
-	ndev->priv->hw_ops.set_dpm(ndev, 0);
+	ndev->priv->hw_ops->set_dpm(ndev, 0);
 	aie_smu_fini(ndev->aie.smu_hdl);
 }
 
@@ -765,6 +765,7 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
 	if (!clock)
 		return -ENOMEM;
 
+	aie2_update_counters(ndev);
 	snprintf(clock->mp_npu_clock.name, sizeof(clock->mp_npu_clock.name),
 		 "MP-NPU Clock");
 	clock->mp_npu_clock.freq_mhz = ndev->npuclk_freq;
@@ -925,6 +926,7 @@ static int aie2_query_resource_info(struct amdxdna_client *client,
 	ndev = xdna->dev_handle;
 	priv = ndev->priv;
 
+	aie2_update_counters(ndev);
 	res_info.npu_clk_max = priv->dpm_clk_tbl[ndev->max_dpm_level].hclk;
 	res_info.npu_tops_max = ndev->max_tops;
 	res_info.npu_task_max = priv->hwctx_limit;
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 7c308672b5fe..77ba125e4d72 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -201,8 +201,16 @@ struct amdxdna_dev_hdl {
 
 struct aie2_hw_ops {
 	int (*set_dpm)(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
+	int (*update_counters)(struct amdxdna_dev_hdl *ndev);
 };
 
+#define aie2_update_counters(ndev)				\
+({								\
+	typeof(ndev) _ndev = ndev;				\
+	if (_ndev->priv->hw_ops->update_counters)		\
+		_ndev->priv->hw_ops->update_counters(_ndev);	\
+})
+
 enum aie2_fw_feature {
 	AIE2_NPU_COMMAND,
 	AIE2_PREEMPT,
@@ -229,7 +237,7 @@ struct amdxdna_dev_priv {
 	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
 	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
 	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
-	struct aie2_hw_ops		hw_ops;
+	const struct aie2_hw_ops	*hw_ops;
 };
 
 extern const struct amdxdna_dev_ops aie2_ops;
@@ -243,7 +251,7 @@ extern const struct dpm_clk_freq npu4_dpm_clk_table[];
 extern const struct rt_config npu1_default_rt_cfg[];
 extern const struct rt_config npu4_default_rt_cfg[];
 extern const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[];
-int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level);
+extern const struct aie2_hw_ops npu4_hw_ops;
 
 /* aie2_pm.c */
 int aie2_pm_init(struct amdxdna_dev_hdl *ndev);
diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
index 5ec6728d04fd..786d688bd82c 100644
--- a/drivers/accel/amdxdna/aie2_pm.c
+++ b/drivers/accel/amdxdna/aie2_pm.c
@@ -35,7 +35,7 @@ int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 	if (ret)
 		return ret;
 
-	ret = ndev->priv->hw_ops.set_dpm(ndev, dpm_level);
+	ret = ndev->priv->hw_ops->set_dpm(ndev, dpm_level);
 	if (!ret)
 		ndev->dpm_level = dpm_level;
 	amdxdna_pm_suspend_put(ndev->aie.xdna);
@@ -49,7 +49,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
 
 	if (ndev->dev_status != AIE2_DEV_UNINIT) {
 		/* Resume device */
-		ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->dpm_level);
+		ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->dpm_level);
 		if (ret)
 			return ret;
 
@@ -64,7 +64,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
 		ndev->max_dpm_level++;
 	ndev->max_dpm_level--;
 
-	ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->max_dpm_level);
+	ret = ndev->priv->hw_ops->set_dpm(ndev, ndev->max_dpm_level);
 	if (ret)
 		return ret;
 	ndev->dpm_level = ndev->max_dpm_level;
diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
index a83e44f378ad..f1141a65e64d 100644
--- a/drivers/accel/amdxdna/npu1_regs.c
+++ b/drivers/accel/amdxdna/npu1_regs.c
@@ -122,7 +122,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
 		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
 		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
 	},
-	.hw_ops		= {
+	.hw_ops		= &(const struct aie2_hw_ops) {
 		.set_dpm = npu1_set_dpm,
 	},
 };
diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
index 5d68171f4ec2..a3b6df56abd0 100644
--- a/drivers/accel/amdxdna/npu4_regs.c
+++ b/drivers/accel/amdxdna/npu4_regs.c
@@ -6,6 +6,7 @@
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_device.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/amd-pmf-io.h>
 #include <linux/bits.h>
 #include <linux/sizes.h>
 
@@ -63,12 +64,7 @@
 #define NPU4_SMU_BAR_BASE	MMNPU_APERTURE4_BASE
 #define NPU4_SRAM_BAR_BASE	MMNPU_APERTURE1_BASE
 
-#define NPU4_DPM_TOPS(ndev, dpm_level) \
-({ \
-	typeof(ndev) _ndev = ndev; \
-	(4096 * (_ndev)->total_col * \
-	 (_ndev)->priv->dpm_clk_tbl[dpm_level].hclk / 1000000); \
-})
+#define NPU4_DPM_TOPS(ndev, hclk) (4096 * (ndev)->total_col * (hclk) / 1000000)
 
 const struct rt_config npu4_default_rt_cfg[] = {
 	{ 5, 1, AIE2_RT_CFG_INIT }, /* PDI APP LOAD MODE */
@@ -105,7 +101,7 @@ const struct amdxdna_fw_feature_tbl npu4_fw_feature_table[] = {
 	{ 0 }
 };
 
-int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
+static int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 {
 	int ret;
 
@@ -115,8 +111,8 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 
 	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
 	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
-	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
-	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
+	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->priv->dpm_clk_tbl[ndev->max_dpm_level].hclk);
+	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
 
 	XDNA_DBG(ndev->aie.xdna, "MP-NPU clock %d, H clock %d\n",
 		 ndev->npuclk_freq, ndev->hclk_freq);
@@ -124,6 +120,27 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 	return 0;
 }
 
+static int npu4_update_counters(struct amdxdna_dev_hdl *ndev)
+{
+	struct amd_pmf_npu_metrics npu_metrics;
+	int ret;
+
+	ret = AIE2_GET_PMF_NPU_METRICS(&npu_metrics);
+	if (ret)
+		return ret;
+
+	ndev->npuclk_freq = npu_metrics.mpnpuclk_freq;
+	ndev->hclk_freq = npu_metrics.npuclk_freq;
+	ndev->curr_tops = NPU4_DPM_TOPS(ndev, ndev->hclk_freq);
+
+	return 0;
+}
+
+const struct aie2_hw_ops npu4_hw_ops = {
+	.set_dpm = npu4_set_dpm,
+	.update_counters = npu4_update_counters,
+};
+
 static const struct amdxdna_dev_priv npu4_dev_priv = {
 	.fw_path        = "amdnpu/17f0_10/",
 	.rt_config	= npu4_default_rt_cfg,
@@ -154,9 +171,7 @@ static const struct amdxdna_dev_priv npu4_dev_priv = {
 		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU4_SMU, MP1_C2PMSG_61),
 		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU4_SMU, MP1_C2PMSG_60),
 	},
-	.hw_ops		= {
-		.set_dpm = npu4_set_dpm,
-	},
+	.hw_ops		= &npu4_hw_ops
 };
 
 const struct amdxdna_dev_info dev_npu4_info = {
diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/amdxdna/npu5_regs.c
index 98ee8780f3f5..6d4596b9e61e 100644
--- a/drivers/accel/amdxdna/npu5_regs.c
+++ b/drivers/accel/amdxdna/npu5_regs.c
@@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
 		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU5_SMU, MP1_C2PMSG_61),
 		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU5_SMU, MP1_C2PMSG_60),
 	},
-	.hw_ops		= {
-		.set_dpm = npu4_set_dpm,
-	},
+	.hw_ops		= &npu4_hw_ops
 };
 
 const struct amdxdna_dev_info dev_npu5_info = {
diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/amdxdna/npu6_regs.c
index 31400cca5ec4..76181345b6d1 100644
--- a/drivers/accel/amdxdna/npu6_regs.c
+++ b/drivers/accel/amdxdna/npu6_regs.c
@@ -92,9 +92,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
 		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU6_SMU, MP1_C2PMSG_61),
 		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU6_SMU, MP1_C2PMSG_60),
 	},
-	.hw_ops         = {
-		.set_dpm = npu4_set_dpm,
-	},
+	.hw_ops         = &npu4_hw_ops
 
 };
 
-- 
2.34.1

