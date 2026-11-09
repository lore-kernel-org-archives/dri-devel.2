Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01142606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4084610ED81;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022130.outbound.protection.outlook.com [52.101.126.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5355510E848
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZG7DXrlXaCEmofEs4vxrVPh7zozhXF+kDcJUyKD0rxZ1sbjFk3Y1rFLhvI/gsIddDANBK55ZiKUNE5T06/DnHbP5vnaKIaqfXmoE/YFE75S26uuuBe36CiMbkRArcGb0rS/T21SjnByrYH7a87RkXgW5wHQOKUlIn2Dq1XDxmf6rx+GUngspmdP+M7jnrWzKIQXsW6JqUiYIqox5IXbpybA2tWTnojtFGTXyMKAJlO/gD4M/7jCb6/leVOJPK3R0L4DUu1eVLjk2CDSDJ1dQP5ylJApEsBDrzNfQ3Rjb1XJxOl8Ob6t5j+DtM9U57sNsSqbmrktTAcsb/f+zAJwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBukfvrKHWty/D0wEXAHNvBJZFd6vag33klQlUrVbYw=;
 b=ddgXB3KoJu6w/RKG9A45cyintVne38i1gQR3KuzYIMXhNhUwknfizS5yEcmqLTuY9A3+PGWGC83IK8PpBHbdQX3TK9u2sV30M6gEvVg6mOQDX0t98xUg06Ay5y4rqKj/9MiyBBjKkyEuVPHNF7ChsfD3cjs68Sy5b2dNqf5YQAlCSTEwGsf4wGpNclZ4ZcV2Ytnv1nAyWu0BpCKm81tBV+1xmbo44T5E54ArLhFymfwK2MqKxIvfLkdfIzPJUrigZ8r2lV/awW8usCoVj6ToTENPg2UX9C2iMQnA36cqkW4qot/Hh/Kl0P0kxn33I17WICJzjHg5AXfjbdNcCPKb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI3PR02CA0012.apcprd02.prod.outlook.com (2603:1096:4:295::11)
 by SE3PR06MB9162.apcprd06.prod.outlook.com (2603:1096:101:31f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 12:09:07 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:4:295:cafe::7b) by SI3PR02CA0012.outlook.office365.com
 (2603:1096:4:295::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:09:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:09:05 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4E7CA40920FB;
 Mon,  9 Nov 2026 20:09:02 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com
Cc: daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v2 2/3] drm/panthor: Add initial support for CIX Sky1
Date: Mon,  9 Nov 2026 20:09:00 +0800
Message-ID: <20261109120902.125242-3-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
References: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SE3PR06MB9162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0c4d08d6-c0a1-4aa9-7960-08df3e5a40a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|7416014|23010399003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SDshc3sgrYwKtynmi6DFMv8WunRU2GE0dyLcvBYtmAThC6mpLfJCVI8HE3ctBc/mQR34yS5avfyf5JCurzqZaxZSL6pKiMAI9LdfATF83+9yqdZNGkD/KD3BiSuJ+kxaNKQwVX+BqbvIiElFgYFlgklta+nrz2x0vytSQ5c1XH9sSsvIvA7nKxqwNsV+dtIkqx0ImUmM6JetlWs4f+dpOj9sxksyUPmRf2qLAfhY3S0toRiOUMbDBhpbi9sHXOLGufJxuH0ZmxmeFExYNVnHl+edo79XUAtPl/LL6gB01VE+zQia1zadkaMevkkINsjjC82s+ESYZfw/v++CyYvTC4/rYHyP2p4ayQZHnDxVcQD7wbtT6WwZokVxxQR12ej1FfPc+wnXTzCs0V0DJaSCvzzaGCv8QZUTHAZFZNaLvUOhoYQOOABUltxThFObw2tmEa4NvVzUSVoHyaVbHx+Ctd0chbhVgkbw/9/pWyWxz5BBejZj2jk/KlWMO97riSdMaw0qSzziqUer6NG1m7q5eEbynZqS2NF2gVRUgfz4kitJ4yDIoGBsnsu/TZLgLGBCkeCuxl12QQY4b04VmZqs/NlPFxzf4W9SMSPBPnA93EiJv+hMZQ9Or6rGBIGhOE5TGXC620L00cjwKm8S5YCSsVMbDVMe149V7Sx53Qw5r4/TVcFC9dJ3MOWD0yAgG3eAJLxEoIJa956BykBP7sh19g==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hS6Qn/QYWQV63Voyt5540c2SPfrCaSTEj0WNNbSQsCD1Lr8OyKjz9n2jySK5pvyKiEjMOxC95WlEJH3MOqgg/WaladMkgAy13ofpzGWInOQ4ci58ruA0EbDUQcBjLLnnXhwGfJLoWf5B3h82lq/jv5laREIlWADUcpzsKFz39CBn2gVbTTX1pN5Flsns0Tvfqi/ON1lUEgPimp6ROmVyKoW5CngDG9W76caKr116Wp7KyNKbPUSd/0Zp6BX22VIEn6NMVqRUKQv9Jc6SKHbF8tYByaJgKIX4871rVe0NNkZRfi7RxudfydXcsMshE2HOEFO4CC7pVYcOQ0hpjflfdlF/IsePgR8dCXUdBZ9wt7hJzeXXfKlkpYmGfRKaVdPP986BsreCjNP4vNEmCpCsEWQpfPIa7nw3kKVSRFrsQ7lVXSWirPCXqZJ31XvNT0Xt
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:09:05.6922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4d08d6-c0a1-4aa9-7960-08df3e5a40a0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9162
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Sky1 SoC data for system-level cache settings and to skip devfreq.

The GPU on CIX Sky1 needs an external reset before the driver first
accesses the hardware. Without this reset, the GPU hardware cannot be
accessed correctly. Acquire an optional exclusive reset for all platforms
and apply it after enabling the clocks during initial probe. Platforms
without a reset keep working through the reset framework NULL handling.

Configure SYSC_ALLOC before L2 power-on. Without these settings, GPU
rendering results are displayed incorrectly.

Keep the clock settings provided by the PM firmware. This first version
does not read OPPs or enable devfreq. It does not register a GPU cooling
device.

Tested on Orion O6: offscreen pixel readback, kmscube, glmark2 at 1080p,
runtime suspend and resume with a retained EGL context, software-triggered
reset-worker tests, and module unload and reload. Display tests used
local Komeda support.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c  | 11 ++++++++++-
 drivers/gpu/drm/panthor/panthor_device.c   | 13 +++++++++++++
 drivers/gpu/drm/panthor/panthor_device.h   | 19 +++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_drv.c      | 14 ++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.c      | 14 ++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 ++
 6 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4af..1914549f7b1f 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -154,6 +154,12 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	ptdev->devfreq = pdevfreq;
 
+	/* Keep the firmware clock settings until Sky1 devfreq is supported. */
+	if (ptdev->soc_data && ptdev->soc_data->skip_devfreq) {
+		ptdev->fast_rate = clk_get_rate(ptdev->clks.core);
+		return 0;
+	}
+
 	/*
 	 * The power domain associated with the GPU may have already added an
 	 * OPP table, complete with OPPs, as part of the platform bus
@@ -323,8 +329,11 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	unsigned long freq = 0;
 	int ret;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq->devfreq) {
+		if (ptdev->soc_data && ptdev->soc_data->skip_devfreq)
+			return clk_get_rate(ptdev->clks.core);
 		return 0;
+	}
 
 	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 9687c59de350..a3a32abec5f7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -229,6 +229,11 @@ int panthor_device_init(struct panthor_device *ptdev)
 		return ret;
 	}
 
+	ptdev->reset_control = devm_reset_control_get_optional_exclusive(ptdev->base.dev, NULL);
+	if (IS_ERR(ptdev->reset_control))
+		return dev_err_probe(ptdev->base.dev, PTR_ERR(ptdev->reset_control),
+				     "Failed to get GPU reset\n");
+
 	ret = panthor_devfreq_init(ptdev);
 	if (ret)
 		return ret;
@@ -511,6 +516,12 @@ int panthor_device_resume(struct device *dev)
 	if (ret)
 		goto err_disable_stacks_clk;
 
+	if (!panthor_device_is_initialized(ptdev)) {
+		ret = reset_control_reset(ptdev->reset_control);
+		if (ret)
+			goto err_disable_coregroup_clk;
+	}
+
 	panthor_devfreq_resume(ptdev);
 
 	if (panthor_device_is_initialized(ptdev) &&
@@ -553,6 +564,8 @@ int panthor_device_resume(struct device *dev)
 
 err_suspend_devfreq:
 	panthor_devfreq_suspend(ptdev);
+
+err_disable_coregroup_clk:
 	clk_disable_unprepare(ptdev->clks.coregroup);
 
 err_disable_stacks_clk:
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd41..afb4167bd364 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+struct reset_control;
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -34,10 +36,24 @@ struct panthor_pwr;
 struct panthor_vm;
 struct panthor_vm_pool;
 
+/**
+ * struct panthor_sysc_config - GPU system-cache configuration
+ */
+struct panthor_sysc_config {
+	/** @alloc: System-cache allocation policies for GPU access types. */
+	u32 alloc[8];
+};
+
 /**
  * struct panthor_soc_data - Panthor SoC Data
  */
 struct panthor_soc_data {
+	/** @skip_devfreq: Keep the firmware clock settings without devfreq. */
+	bool skip_devfreq;
+
+	/** @sysc_config: System-cache configuration, or NULL to keep defaults. */
+	const struct panthor_sysc_config *sysc_config;
+
 	/** @asn_hash_enable: True if GPU_L2_CONFIG_ASN_HASH_ENABLE must be set. */
 	bool asn_hash_enable;
 
@@ -138,6 +154,9 @@ struct panthor_device {
 	/** @soc_data: Optional SoC data. */
 	const struct panthor_soc_data *soc_data;
 
+	/** @reset_control: Optional external GPU reset. */
+	struct reset_control *reset_control;
+
 	/** @phys_addr: Physical address of the iomem region. */
 	phys_addr_t phys_addr;
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..4d7b1230cd7b 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1872,12 +1872,26 @@ static struct attribute *panthor_attrs[] = {
 
 ATTRIBUTE_GROUPS(panthor);
 
+static const struct panthor_sysc_config sysc_config_cix_sky1 = {
+	/* Sky1 needs these SYSC_ALLOC policies for correct display of GPU output. */
+	.alloc = {
+		0x00230000, 0x00000023, 0x00000000, 0x00000000,
+		0x00523222, 0x00523200, 0x00000022, 0x00000032,
+	},
+};
+
+static const struct panthor_soc_data soc_data_cix_sky1 = {
+	.skip_devfreq = true,
+	.sysc_config = &sysc_config_cix_sky1,
+};
+
 static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 	.asn_hash_enable = true,
 	.asn_hash = { 0xb, 0xe, 0x0, },
 };
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "cix,sky1-mali", .data = &soc_data_cix_sky1 },
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101e..9a6963fe62ae 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -63,6 +63,19 @@ static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 		  ptdev->gpu_info.selected_coherency);
 }
 
+static void panthor_gpu_sysc_config_set(struct panthor_device *ptdev)
+{
+	const struct panthor_sysc_config *config;
+	unsigned int i;
+
+	if (!ptdev->soc_data || !ptdev->soc_data->sysc_config)
+		return;
+
+	config = ptdev->soc_data->sysc_config;
+	for (i = 0; i < ARRAY_SIZE(config->alloc); i++)
+		gpu_write(ptdev->gpu->iomem, GPU_SYSC_ALLOC(i), config->alloc[i]);
+}
+
 static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
@@ -317,6 +330,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 	}
 
 	/* Set the desired coherency mode and L2 config before the power up of L2 */
+	panthor_gpu_sysc_config_set(ptdev);
 	panthor_gpu_coherency_set(ptdev);
 	panthor_gpu_l2_config_set(ptdev);
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4..f9b65a4dae83 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -116,4 +116,6 @@
 #define   GPU_COHERENCY_ACE				1
 #define   GPU_COHERENCY_NONE				31
 
+#define GPU_SYSC_ALLOC(n)				(0x340 + (n) * 4)
+
 #endif /* __PANTHOR_GPU_REGS_H__ */
-- 
2.53.0

