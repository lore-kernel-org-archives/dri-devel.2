Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC1607264A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aapG2hI1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABEF10FF4F;
	Wed,  4 Nov 2026 22:16:09 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4BA10FF4B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4x9cdWlxyxaHNnO9LuCjlxOUYsBvmDrnPyo1izaRKWWD6b4s5vUcGEBCKyMgq53WTF//2YymKGP/P6HecRNgeCFJndE/O6Ljb280VS34niRs1C7mAVTSMSHs9bArRZyKMiGxZqd58w3UgPI7KmZkZ453fzWxqlwbR8umhYV5BD5UPeBo3ZeQfO+X2AT5XzhnFim3ZL/OsmWrG9sn0ENSzJVxd4isauk6gAN6Ar8QM745dDe8d0mcDjhOBQbednhRu17Kbo/KsJS76zSpS2ikq2DyqikjDTSbjs6rEZrOTTFGf0IYwwtWEBkuutGY6IPhAHH2uMeKY973nspoSDdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6MiojFpGemwXBud1FWrdE1K51VEsaSVFByG58D32Y8=;
 b=h+SGz2NlQGxmcwWiEyCZT8DodB1QJimaR+SY21rafvPKr0M6z/B/hBPTpsKiezxHU9EefYZRgyWzMyG9amaC3mi6rReL3GmTHbWG1itkkDgg8nGJ1tGJH2pdRqucCguyRv5jKfSyZf6wRYEEPlsC9Thas1C3Jcf4N6orDqmVykPYn0orcqoOmcgCoaJDadTMOnR8+b699U9326pBjVJ8W69kPwH+9aJqo8/sMsdwcnJWzaF6ODZbzWcoq0grESo8T29vb8PGYKWZDR+X2Lc20SJv+7zwuBWSoUXga4N3vL2L7Wf6F6U7heeWGK3gvFwD1IXJk4lVS2U3RLATVWVF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6MiojFpGemwXBud1FWrdE1K51VEsaSVFByG58D32Y8=;
 b=aapG2hI1PUbXQhKegxC8LJu5cx7MT97fCq+Maafnl7ajcKLEYRAMU2D03vbRXhFbIhNDzi/EhwUzXwEawmoYjyInRgjIhMtotztHMrT9TcYbPV4MzMCReXzQbkOc/lD1c2LxDqvO1i64Flk2ziT7uQ6v4rcmCo4Vm4Yo4jWUJ6w=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by IA4PR12MB187965.namprd12.prod.outlook.com (2603:10b6:207:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:15:53 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::73) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 22:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:51 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:15:50 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: [PATCH V1 3/4] accel/amdxdna: Add AIE4 debug buffer support
Date: Wed, 4 Nov 2026 14:15:39 -0800
Message-ID: <20261104221540.631182-4-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104221540.631182-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261104221540.631182-1-yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA4PR12MB187965:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f0e961-2193-47a0-3365-08df3ac130ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|5023799004|4143699003|261028144727099003|261026140227099003|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: nDvPmnqtDwDmi4UhcnlTHKD3DIizCChsP3+tzw8u/2VZpnxU80hRod1UVyZ39LqqGqywNlGvOOI3G7BN4HVrb10Bz1yILZZCnal5kz6sjX/+xdsm9A/kPZnDTUf+OfXq+r3/MpKizOOISFee0mbZbweQyInxAfaq8jRvPlkwKm+QVV9RZvnyJHHCgP+Bf6O8JgsSyt8TS86Y9NyiZxM9nKYDwm7H3tX6cKa7dxN4ni9cOftPc96El4XvogFOBOPwQ/BiL0Qcr7xGuZP+VWC6XVsqNw+5C9Hvr6cbe+CY1AXcJsIiri7GGED+we+KsSVOYRnoY69WRI3yyb7chiI1Y5NdbOBew0i2Yg6q1drU9ZCmy7nwMeqa4/mG5GIouHvHk6Wi4tpiaAQGk0E4Pd8N0YVKYAA7uuBIG2upupr0F6PQ4bxUhDuUYu5gpk3+42Pi8Ozbft/uU8EtzJ4h2ykjc0bl84Tvdk+eoiz/FT3GEYbZLJjMO09rF8Cdt6Z/EkOKRlWy1gS5zU3f8FphPodd9SkuaLxfidh7ddeUanYnLWcID1E5zkG7m8sCZiF7/mTSKlg9YCK7l5234Q5FHYRtlLgrL97f/zRLqdxvOX+HOrEbNcwbT1drY+b22f4RjLV6IDBcxQkpk/k5o8t43a+NCst9B/gN6neb3yrE9H5/cMpSr5Dd1M6iC1pe4j9zhLB1wP79Bw+1rdPIYD5dEb+beA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(5023799004)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQ4ysRKy7F2BLajMyS5ab2+7mmamTFP7yul3xQOvEZfu8LhyT9h5UARTZ542jgG6o+PYuy/gu2g4NuvurhyO2hS2AEurDbuDuepAnkQjb6VPy9d9cP8u0tvO76f3pgaAuu26fNC12w4izF1jiSme/T9nAs2BPQD2ps/JwwhI+B9Ya1cnLpNMTVvR48HvbXMAleEZxr8XlsdrfdZUpt+f2oYm6JeMVWhKKWxASymyNKHprZ3A5bOnvMbI/wSPvgfsw3mjDZ3DKKHWEUbm8EnFvYUySK3Ez70qkQxhsZz9tXwEVRPQ344jQ3KX59JAlYyAw/N3LtgbpCModQ2bvFJ8EIdjwxlVmxzCr2/q9/NKSEVXmY7p/Bih3RR1aP39duuK7KLxp6Ok54JWDnfUfb7lVhEwCGEA5wC0CEIc8iMQ5UgrB7PJTkWh6GYqF759aBm+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:52.8972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f0e961-2193-47a0-3365-08df3ac130ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB187965
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

Let user space attach a debug buffer to an AIE4 hardware context through
the hwctx config ioctl. The buffer stays attached across suspend and
resume: the driver removes it from the firmware context before suspend
and configures it again on resume.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie4_ctx.c      | 284 +++++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_message.c  |  20 ++
 drivers/accel/amdxdna/aie4_msg_priv.h |  35 ++++
 drivers/accel/amdxdna/aie4_pci.c      |   4 +
 drivers/accel/amdxdna/aie4_pci.h      |  10 +
 drivers/accel/amdxdna/amdxdna_ctx.c   |   4 +-
 include/uapi/drm/amdxdna_accel.h      |  50 +++++
 7 files changed, 405 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
index a3f0a69b93b7..972e924dc1b3 100644
--- a/drivers/accel/amdxdna/aie4_ctx.c
+++ b/drivers/accel/amdxdna/aie4_ctx.c
@@ -9,6 +9,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/bitfield.h>
 #include <linux/hmm.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
@@ -130,6 +131,70 @@ static void aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_contex
 		XDNA_WARN(xdna, "destroy ctx id %d failed %d", hw_context_id, ret);
 }
 
+/* Release the debug buffer of @type, taken on attach. */
+static void aie4_hwctx_put_fw_buf(struct amdxdna_hwctx *hwctx, u32 type)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+
+	priv->fw_buf_bo[type]->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
+	/* Drop the reference taken when the buffer was attached. */
+	amdxdna_gem_put_obj(priv->fw_buf_bo[type]);
+	priv->fw_buf_bo[type] = NULL;
+}
+
+static int aie4_fw_buf_property(u32 type)
+{
+	switch (type) {
+	case AMDXDNA_FW_BUF_LOG:
+		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_LOG_BUFFER;
+	case AMDXDNA_FW_BUF_DEBUG:
+		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_BUFFER;
+	case AMDXDNA_FW_BUF_TRACE:
+		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_TRACE_BUFFER;
+	case AMDXDNA_FW_BUF_DBG_Q:
+		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_QUEUE;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* Release all attached debug buffers. */
+static void aie4_hwctx_put_fw_bufs(struct amdxdna_hwctx *hwctx)
+{
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	u32 type;
+
+	for (type = 0; type < ARRAY_SIZE(priv->fw_buf_bo); type++) {
+		if (priv->fw_buf_bo[type])
+			aie4_hwctx_put_fw_buf(hwctx, type);
+	}
+}
+
+/*
+ * Configure the attached debug buffers on the firmware context, or remove
+ * them from it. Suspend and resume recreate the firmware context, so the
+ * buffers are removed first and configured again afterwards.
+ */
+static void aie4_hwctx_cfg_fw_bufs(struct amdxdna_hwctx *hwctx, bool attach)
+{
+	struct aie4_msg_context_config_cert_logging none = { };
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	u32 type;
+	int ret;
+
+	for (type = 0; type < ARRAY_SIZE(priv->fw_buf_bo); type++) {
+		if (!priv->fw_buf_bo[type])
+			continue;
+		ret = aie4_configure_hw_context_cert_log(xdna->dev_handle, priv->hw_ctx_id,
+							 aie4_fw_buf_property(type),
+							 attach ? &priv->fw_buf_cl[type] : &none);
+		if (ret)
+			XDNA_WARN(xdna, "%s debug buffer type %u on %s failed, ret %d",
+				  attach ? "Configure" : "Remove", type, hwctx->name, ret);
+	}
+}
+
 static u8 aie4_parse_priority_to_dev(u32 priority)
 {
 	switch (priority) {
@@ -198,6 +263,9 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
 	hwctx->start_col = 0;
 	hwctx->num_col = ndev->total_col;
 
+	/* Pairs with aie4_hwctx_destroy(): re-attach debug buffers after resume or reset. */
+	aie4_hwctx_cfg_fw_bufs(hwctx, true);
+
 	/* Set up driver doorbell and return invalid offset to userspace. */
 	mutex_lock(&priv->io_lock);
 	ret = aie4_doorbell_setup(hwctx, &resp);
@@ -256,8 +324,15 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
 	if (has_error)
 		wake_up_all(&priv->job_list_wq);
 
-	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
+	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID) {
+		/*
+		 * Pairs with aie4_hwctx_create(): detach debug buffers.
+		 * On error, skip it; firmware drops them with the context.
+		 */
+		if (flags != AIE4_HWCTX_ERROR)
+			aie4_hwctx_cfg_fw_bufs(hwctx, false);
 		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
+	}
 
 	if (cert_comp)
 		aie4_put_cert_comp(cert_comp);
@@ -430,6 +505,8 @@ void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
 		aie4_hwctx_wait_for_running(hwctx);
 		destroy_workqueue(priv->job_work_q);
 	}
+	/* The context is gone, so release its debug buffers. */
+	aie4_hwctx_put_fw_bufs(hwctx);
 	aie4_hwctx_umq_fini(hwctx);
 	mutex_destroy(&priv->io_lock);
 	kfree(hwctx->priv);
@@ -1284,3 +1361,208 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
 	mmput(job->mm);
 	return ret;
 }
+
+/*
+ * Attach or detach the debug buffer @meta describes. @meta is a kernel copy
+ * of the user descriptor.
+ *
+ * The buffer stays attached until user space removes it or frees the
+ * hardware context. After suspend, resume or context recovery, the driver
+ * configures it again on the new firmware context.
+ */
+static int aie4_hwctx_cfg_fw_buf(struct amdxdna_hwctx *hwctx,
+				 const struct amdxdna_fw_buffer_metadata *meta,
+				 u32 size, bool attach)
+{
+	struct aie4_msg_context_config_cert_logging cl = { };
+	struct amdxdna_hwctx_priv *priv = hwctx->priv;
+	struct amdxdna_client *client = hwctx->client;
+	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct amdxdna_gem_obj *payload_bo;
+	u32 prev_size = 0;
+	u64 base_addr;
+	u32 property;
+	u32 seen = 0;	/* uC indices in the descriptor */
+	u32 used = 0;	/* uC indices with a slice size above 0 */
+	int ret;
+	int i;
+
+	if (!meta || size < sizeof(*meta)) {
+		XDNA_DBG(xdna, "Invalid debug buffer descriptor, size %u", size);
+		return -EINVAL;
+	}
+
+	if (XDNA_MBZ_DBG(xdna, meta->pad, sizeof(meta->pad)))
+		return -EINVAL;
+
+	ret = aie4_fw_buf_property(meta->buf_type);
+	if (ret < 0) {
+		XDNA_DBG(xdna, "Unsupported buf_type %u", meta->buf_type);
+		return ret;
+	}
+	property = ret;
+
+	/*
+	 * On attach, this reference is held until detach or context teardown.
+	 * The device reaches the buffer through the process address space
+	 * (PASID), so the BO is not pinned or fenced: if the process changes
+	 * that mapping, only its own jobs are affected.
+	 */
+	payload_bo = amdxdna_gem_get_obj(client, meta->bo_handle, AMDXDNA_BO_SHARE);
+	if (!payload_bo) {
+		XDNA_DBG(xdna, "Get bo %u failed", meta->bo_handle);
+		return -EINVAL;
+	}
+
+	if (!attach) {
+		if (payload_bo != priv->fw_buf_bo[meta->buf_type]) {
+			XDNA_DBG(xdna, "BO %u is not attached as debug buffer type %u on %s",
+				 meta->bo_handle, meta->buf_type, hwctx->name);
+			ret = -EINVAL;
+			goto put_obj;
+		}
+
+		/*
+		 * While the context has a firmware context, remove the buffer
+		 * from it. After a reset or resume that could not recreate it,
+		 * there is no firmware context, so only drop the driver's
+		 * reference to the BO.
+		 */
+		if (priv->hw_ctx_id != CTX_INVALID_ID) {
+			ret = aie4_configure_hw_context_cert_log(ndev, priv->hw_ctx_id,
+								 property, &cl);
+			/* Firmware may still use it, so keep it attached. */
+			if (ret)
+				goto put_obj;
+		}
+
+		/* Release the attach reference; put_obj drops the lookup one. */
+		aie4_hwctx_put_fw_buf(hwctx, meta->buf_type);
+		XDNA_DBG(xdna, "Detached debug buffer type %u BO %u from %s",
+			 meta->buf_type, meta->bo_handle, hwctx->name);
+		ret = 0;
+		goto put_obj;
+	}
+
+	if (!meta->num_ucs || meta->num_ucs > AIE4_MAX_NUM_CERTS ||
+	    size < struct_size(meta, uc_info, meta->num_ucs)) {
+		XDNA_DBG(xdna, "Invalid num_ucs %u for size %u", meta->num_ucs, size);
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
+	/* One buffer of each type per context. */
+	if (priv->fw_buf_bo[meta->buf_type]) {
+		XDNA_DBG(xdna, "Debug buffer type %u already attached on %s",
+			 meta->buf_type, hwctx->name);
+		ret = -EBUSY;
+		goto put_obj;
+	}
+
+	if (payload_bo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
+		XDNA_DBG(xdna, "BO %u already attached to a context",
+			 meta->bo_handle);
+		ret = -EBUSY;
+		goto put_obj;
+	}
+
+	if (priv->hw_ctx_id == CTX_INVALID_ID) {
+		XDNA_ERR(xdna, "No firmware context to attach debug buffer type %u on %s",
+			 meta->buf_type, hwctx->name);
+		ret = -ENODEV;
+		goto put_obj;
+	}
+
+	base_addr = amdxdna_gem_dev_addr(payload_bo);
+	if (base_addr == AMDXDNA_INVALID_ADDR) {
+		XDNA_DBG(xdna, "Debug buffer type %u payload BO %u is not mapped",
+			 meta->buf_type, meta->bo_handle);
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
+	for (i = 0; i < meta->num_ucs; i++) {
+		u32 slice_size = meta->uc_info[i].size;
+		u32 index = meta->uc_info[i].index;
+		u32 next_size;
+
+		if (index >= AIE4_MAX_NUM_CERTS) {
+			XDNA_DBG(xdna, "Invalid uc index %u", index);
+			ret = -EINVAL;
+			goto put_obj;
+		}
+
+		if (seen & BIT(index)) {
+			XDNA_DBG(xdna, "Duplicate uc index %u", index);
+			ret = -EINVAL;
+			goto put_obj;
+		}
+		seen |= BIT(index);
+
+		if (!slice_size)
+			continue;
+
+		if (check_add_overflow(prev_size, slice_size, &next_size) ||
+		    next_size > payload_bo->mem.size) {
+			XDNA_DBG(xdna, "uc[%u] slice 0x%x at 0x%x overflows bo size %lu",
+				 index, slice_size, prev_size, payload_bo->mem.size);
+			ret = -EINVAL;
+			goto put_obj;
+		}
+
+		cl.info[index].paddr = base_addr + prev_size;
+		cl.info[index].size = slice_size;
+		used |= BIT(index);
+		prev_size = next_size;
+	}
+
+	if (!used) {
+		XDNA_DBG(xdna, "Debug buffer type %u: all uc slices are empty",
+			 meta->buf_type);
+		ret = -EINVAL;
+		goto put_obj;
+	}
+
+	/* cl.info[] is indexed by uC, so cover up to the highest one used. */
+	cl.num = FIELD_PREP(AIE4_MSG_CERT_LOG_NUM, fls(used));
+	ret = aie4_configure_hw_context_cert_log(ndev, priv->hw_ctx_id, property, &cl);
+	if (ret)
+		goto put_obj;
+
+	/* Keep the lookup reference. */
+	payload_bo->assigned_hwctx = hwctx->id;
+	priv->fw_buf_bo[meta->buf_type] = payload_bo;
+	priv->fw_buf_cl[meta->buf_type] = cl;
+	XDNA_DBG(xdna, "Attached debug buffer type %u BO %u to %s",
+		 meta->buf_type, meta->bo_handle, hwctx->name);
+	return 0;
+
+put_obj:
+	amdxdna_gem_put_obj(payload_bo);
+	return ret;
+}
+
+int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value,
+		      void *buf, u32 size)
+{
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	switch (type) {
+	case DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF:
+		return aie4_hwctx_cfg_fw_buf(hwctx, buf, size, true);
+	case DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF:
+		return aie4_hwctx_cfg_fw_buf(hwctx, buf, size, false);
+	default:
+		XDNA_DBG(xdna, "Not supported type %d", type);
+		return -EOPNOTSUPP;
+	}
+}
+
+int aie4_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
+{
+	/* NO-OP */
+	return 0;
+}
diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
index 060e199f4006..bc862cbe68f3 100644
--- a/drivers/accel/amdxdna/aie4_message.c
+++ b/drivers/accel/amdxdna/aie4_message.c
@@ -326,3 +326,23 @@ int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us)
 
 	return ret;
 }
+
+int aie4_configure_hw_context_cert_log(struct amdxdna_dev_hdl *ndev,
+				       u32 hw_context_id, u32 property,
+				       const struct aie4_msg_context_config_cert_logging *cl)
+{
+	DECLARE_AIE_MSG(aie4_msg_configure_hw_context, AIE4_MSG_OP_CONFIGURE_HW_CONTEXT);
+	struct amdxdna_dev *xdna = ndev->aie.xdna;
+	int ret;
+
+	req.hw_context_id = hw_context_id;
+	req.property = property;
+	req.cert_logging = *cl;
+
+	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
+	if (ret)
+		XDNA_ERR(xdna, "Configure debug buffer failed, ctx %u property %u ret %d",
+			 hw_context_id, property, ret);
+
+	return ret;
+}
diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
index 566f6abc9e2d..977f7651341a 100644
--- a/drivers/accel/amdxdna/aie4_msg_priv.h
+++ b/drivers/accel/amdxdna/aie4_msg_priv.h
@@ -22,6 +22,7 @@ enum aie4_msg_opcode {
 	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
 	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
 	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
+	AIE4_MSG_OP_CONFIGURE_HW_CONTEXT             = 0x30005,
 	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
 	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
 	AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
@@ -156,6 +157,40 @@ struct aie4_msg_destroy_hw_context_resp {
 	__u16 resvd;
 } __packed;
 
+enum aie4_msg_configure_hw_context_property {
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_PRIORITY_BAND,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_SCHEDULING,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_DPM,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_LOG_BUFFER,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_BUFFER,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_TRACE_BUFFER,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_QUEUE,
+	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_HANDLE,
+};
+
+#define AIE4_MAX_NUM_CERTS	6
+
+struct aie4_msg_context_config_cert_logging_info {
+	__u64 paddr;
+	__u32 size;
+} __packed;
+
+struct aie4_msg_context_config_cert_logging {
+#define AIE4_MSG_CERT_LOG_NUM	GENMASK(7, 0)
+	__u32 num;
+	struct aie4_msg_context_config_cert_logging_info info[AIE4_MAX_NUM_CERTS];
+} __packed;
+
+struct aie4_msg_configure_hw_context_req {
+	__u32 hw_context_id;
+	__u32 property;
+	struct aie4_msg_context_config_cert_logging cert_logging;
+} __packed;
+
+struct aie4_msg_configure_hw_context_resp {
+	enum aie4_msg_status status;
+} __packed;
+
 struct aie4_tile_info {
 	__u32 size;
 	__u16 major;
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index 02dcb2f813d4..101f0f27b466 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1393,6 +1393,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_stop		= aie4_hwctx_stop,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.hwctx_config		= aie4_hwctx_config,
+	.hwctx_sync_debug_bo	= aie4_hwctx_sync_debug_bo,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
@@ -1408,6 +1410,8 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.hwctx_init		= aie4_hwctx_init,
 	.hwctx_stop		= aie4_hwctx_stop,
 	.hwctx_fini		= aie4_hwctx_fini,
+	.hwctx_config		= aie4_hwctx_config,
+	.hwctx_sync_debug_bo	= aie4_hwctx_sync_debug_bo,
 	.cmd_submit		= aie4_cmd_submit,
 	.cmd_wait		= aie4_cmd_wait,
 	.get_aie_info		= aie4_get_info,
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index fdc55e498246..158e68199952 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -49,6 +49,10 @@ struct amdxdna_hwctx_priv {
 	struct cert_comp                *cert_comp;
 	u32                             hw_ctx_id;
 	bool                            has_error;
+	/* Attached debug buffers, held until removal or fini. */
+	struct amdxdna_gem_obj          *fw_buf_bo[AMDXDNA_FW_BUF_NUM];
+	/* Their configuration, sent again when the context is created. */
+	struct aie4_msg_context_config_cert_logging fw_buf_cl[AMDXDNA_FW_BUF_NUM];
 
 	/* Direct and indirect packet storage aliasing umq_bo. */
 	u64                             write_index;
@@ -142,6 +146,9 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
 int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
 			 const void *data, size_t size);
 int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
+int aie4_configure_hw_context_cert_log(struct amdxdna_dev_hdl *ndev,
+				       u32 hw_context_id, u32 property,
+				       const struct aie4_msg_context_config_cert_logging *cl);
 u32 aie4_msg_pasid(struct amdxdna_client *client);
 
 /* aie4_ctx.c */
@@ -161,6 +168,9 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
 int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
 void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
+int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value,
+		      void *buf, u32 size);
+int aie4_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
 
 /* aie4_pci.c */
 void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index f4004630dc1b..0a730a637180 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -365,9 +365,11 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 
 	switch (args->param_type) {
 	case DRM_AMDXDNA_HWCTX_CONFIG_CU:
+	case DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF:
+	case DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF:
 		/* For those types that param_val is pointer */
 		if (buf_size > PAGE_SIZE) {
-			XDNA_ERR(xdna, "Config CU param buffer too large");
+			XDNA_ERR(xdna, "Config param buffer too large");
 			return -E2BIG;
 		}
 
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index 51a507561df6..0e41c45ba720 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -135,6 +135,56 @@ enum amdxdna_drm_config_hwctx_param {
 	DRM_AMDXDNA_HWCTX_CONFIG_CU,
 	DRM_AMDXDNA_HWCTX_ASSIGN_DBG_BUF,
 	DRM_AMDXDNA_HWCTX_REMOVE_DBG_BUF,
+	DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF = 4,
+	DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF,
+};
+
+/**
+ * enum amdxdna_fw_buf_type - Debug buffer type.
+ * @AMDXDNA_FW_BUF_DEBUG: Debug buffer.
+ * @AMDXDNA_FW_BUF_TRACE: Trace buffer.
+ * @AMDXDNA_FW_BUF_DBG_Q: Debug queue.
+ * @AMDXDNA_FW_BUF_LOG:   Log buffer.
+ * @AMDXDNA_FW_BUF_NUM:   Number of debug buffer types.
+ */
+enum amdxdna_fw_buf_type {
+	AMDXDNA_FW_BUF_DEBUG = 0,
+	AMDXDNA_FW_BUF_TRACE,
+	AMDXDNA_FW_BUF_DBG_Q,
+	AMDXDNA_FW_BUF_LOG,
+	AMDXDNA_FW_BUF_NUM,
+};
+
+/**
+ * struct amdxdna_uc_info_entry - per-uC slice descriptor in
+ *                                struct amdxdna_fw_buffer_metadata.
+ * @index: uC index. The payload BO is sliced per-uC; @index must be unique
+ *         within an array and stay below the device's CERT uC count.
+ * @size:  Per-uC slice size in bytes. Entries with size 0 are skipped.
+ *         At least one entry must have a size greater than 0.
+ */
+struct amdxdna_uc_info_entry {
+	__u32 index;
+	__u32 size;
+};
+
+/**
+ * struct amdxdna_fw_buffer_metadata - per-hwctx debug buffer description.
+ * @buf_type:   One of enum amdxdna_fw_buf_type.
+ * @num_ucs:    Number of valid entries in @uc_info.
+ * @pad:        MBZ. Reserved for ABI growth.
+ * @bo_handle:  Handle of the payload BO (AMDXDNA_BO_SHARE) holding the
+ *              concatenated per-uC slices.
+ * @command_id: User tag for trace correlation.
+ * @uc_info:    Per-uC slice descriptors, in payload BO layout order.
+ */
+struct amdxdna_fw_buffer_metadata {
+	__u8 buf_type;
+	__u8 num_ucs;
+	__u8 pad[2];
+	__u32 bo_handle;
+	__u64 command_id;
+	struct amdxdna_uc_info_entry uc_info[] __counted_by(num_ucs);
 };
 
 /**
-- 
2.34.1

