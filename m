Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB6606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56A011238B;
	Thu, 19 Nov 2026 12:39:33 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023103.outbound.protection.outlook.com [52.101.127.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F62B112389
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWokPn55rWQuVElfpyTHRPX4P2ncbgTdhOQApks7hCR1NakkZ9lFZWvz04sOuy19yPPXJ3OAeC/LeBQsuPT6hzbqtoslDtn6SZpDh6M5KCLtemPaKOJnDLcU6Fo/mrS0QH3e/AJWl18JZArRelTqGkNlUQ6gqL27hei2mh0Yw8ve+D+UFPo4BTpTGy2e2KE0ZQY0sr8SLueAesnYhs3OUhL4Dim5vwT44/zfUgJcp2eJ6QXLa8isXo6LH1AJ1MSaCSgePzsWzJ4Gqoxa0NahEGIubUdsg1OPCNRdaOu5kJs/aeu+hLq3rGA8UPI/emdzwPA//2xt1Eqb5ySgWSVMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnP9qNEOOAzomKicLmOZ4uf6cMuJcAaYE2+Rzi8bLWE=;
 b=oNRZ/8MGmaP70fefV9m1cgLkhJuMlA1JiTjTuOFdLa2VAh7OMNuEBcvtKCpU4AN41AzHgTo9CKlc4VlXAsXBPk6giKSvxwHMJsELc14xABm7bkhR6lcv2Wndg/Pmhd6TTjvikevBOOcDTe3Qe9HESWua5OZwr1zk8itFbnXbqYMBVZt1gEegnFerKGbe0WZ4XKEHI7yN2G/eBUOhsN7XDTGwblhUBqwX+NeBAgHlUDLmym/R8QXsjgkqHinyXrOc7FC7l74dT33pyzpvF1i1y4me0YeOg5hKsZ2XRw2RZIeY/A0yA6TOXdoVkDah6vF3SsjZ/fh38l8tcdKBSWnhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS3P301CA0050.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21c::20)
 by TYZPR06MB5099.apcprd06.prod.outlook.com (2603:1096:400:1c5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 12:38:52 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:604:21c:cafe::69) by OS3P301CA0050.outlook.office365.com
 (2603:1096:604:21c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 12:38:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:52 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 57D8340920E5;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 4/7] drm/panthor: Add system-cache allocation policy support
Date: Thu, 19 Nov 2026 20:38:47 +0800
Message-ID: <20261119123850.2994625-5-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|TYZPR06MB5099:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5685a299-7949-4bb0-1915-08df463a1184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|6133799003|18002099003|22082099003|921020|10067099003|261022113327099003|261022105027099003|261026130827099003|261026140227099003|261022075727099003|261026135527099003|261028144727099003|261026121527099003|261022115727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: LYJMNCk++oVrUfWyNdAm9nuGgVDgUwUydTO3rdqo0GWndnZ4aJJipdmxdL1Wzh9Tmf0tl6A4TwKhw5pwNHcLx7ViSx7/INPAI9wZl+p7KZUxokbiY5L9kqakrFnWDLw9KZABVl52S4OvNQrdTakJMhrPFenU4MonlGtj1CECJeJpmRQhfIViPv0jjOsbjJ6dJdOVDOvf9B+FZXAWN3k9S42IMT1MU7gNiYrdhIo+deZBLTrlyHka/rqvTE2lAE/gA/JfbulWTScHuQJWP460MpOLsaT7KEamw4rK0VUTgEduFN67SzhlJF6CaOg4/MG3U8bJ1lcaFVeWLntx7/9grSAG7ca5kh7U02xyPq3W+23briqkXxDnbZ0m3ZWTVrKZ+WVH2IJeondsikDyn5kU54swVJFCplishWasUri3EAghT0NpwhOmMOCMS1YTJsfKcqeA1IVWad7l9p+/pW4dIDhBuVny3oE/cLSUt/Q8AwmyjR+eh3jPNk9gdaN4oHKTTgtQMhl6pslYrk9qtivVBamw8L+WxwP/UOq/ckfVHfbHgSmpEdFcT6bYCr2Bz123ZyByK6V7DCuCm/MFWeTD7vuac/Iot3zG/Em1+cc2rSv29gizbeoXH7JqTTsikzZSM+iwhpBtIEKZ4F/n0J5JZozuO2nIUXzPdvYePJyMPZO8DJBgatBa4GUCOvh7Z1dGJTlHOOSKJ0NM5QTqKNvF7skCcswWzHmDKJ98YeNZain8PJaoV4kZB85faB1YUPyy
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(921020)(10067099003)(261022113327099003)(261022105027099003)(261026130827099003)(261026140227099003)(261022075727099003)(261026135527099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4T4LLj4JwdlpnEJUwTrEpZNfhdR4/BT1+vYfNjVCtp+rRdVajELlwizJ7zOjELtMFoGxxSuJGvbegjmqBq6pnkjPaZW5BCfJ75JXcyT3aZfiwo5wafypkSyFGsvNnc1QbXczCuvn2bNkRPzJRUn6LFmzYb/urVdzsrcvP3axix2B1ska5Zk+lMvM6qEzl2XCgmoy9t1lwOMSYh9YK5Vs+Y+YKrdx5Nyko5Y0uS4LJRsaNH0dpFcNGknFjBsJCEFAuIPw3MbE2Mgomepud8zyBMlgitur/Cs9zJwEpG0fDLCh8/ZnSiqoDSuKSq7K8KzqJBJ+7DTTp6tcR10JQ5Lof46T2uFL/t23+5ZeWXwYb/X9dxNhq1Os1rsf+0M566ZVN+MihEfBXQEMk0QlwV7kg5t2gUZc2rOP0si+Z7UH3nKVAntEOJGlfkALsSyvUJqI
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:52.2402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5685a299-7949-4bb0-1915-08df463a1184
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5099
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

CIX Sky1 needs system-cache allocation policies that match the platform
integration. Without these settings, GPU rendering results are displayed
incorrectly.

Read the policies from arm,sysc-alloc instead of hardcoding platform
register values. Validate the GPU architecture, source IDs and supported
read/write policies before saving the configuration. Reject duplicate
source IDs and invalid entries.

Restore the policies before L2 power-on through the common hardware
wrapper so that both legacy and PWR backends apply them after reset and
runtime resume. Leave the registers unchanged when no property is present.

Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c      | 187 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.h      |   1 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  58 +++++++
 drivers/gpu/drm/panthor/panthor_hw.c       |  13 ++
 drivers/gpu/drm/panthor/panthor_hw.h       |   5 +-
 5 files changed, 260 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index a383b04f101e..118e13e56555 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -12,6 +12,8 @@
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/string.h>
 
 #include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
@@ -46,6 +48,15 @@ struct panthor_gpu {
 
 	/** @cache_flush_lock: Lock to serialize cache flushes */
 	struct mutex cache_flush_lock;
+
+	/**
+	 * @sysc_alloc: System-cache allocation policies for GPU architecture
+	 * 11.0.3 and later.
+	 */
+	u32 sysc_alloc[GPU_SYSC_ALLOC_COUNT];
+
+	/** @sysc_alloc_enabled: Apply the system-cache allocation policies. */
+	bool sysc_alloc_enabled;
 };
 
 #define GPU_INTERRUPTS_MASK	\
@@ -63,6 +74,178 @@ static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 		  ptdev->gpu_info.selected_coherency);
 }
 
+enum panthor_sysc_alloc_cell {
+	PANTHOR_SYSC_ALLOC_SOURCE,
+	PANTHOR_SYSC_ALLOC_READ,
+	PANTHOR_SYSC_ALLOC_WRITE,
+	PANTHOR_SYSC_ALLOC_CELLS,
+};
+
+static bool panthor_gpu_has_sysc_alloc(u32 gpu_id)
+{
+	/* SYSC_ALLOC is available from GPU architecture 11.0.3. */
+	return GPU_ARCH_MAJOR(gpu_id) > 11 ||
+	       (GPU_ARCH_MAJOR(gpu_id) == 11 &&
+		(GPU_ARCH_MINOR(gpu_id) > 0 || GPU_ARCH_REV(gpu_id) >= 3));
+}
+
+static bool panthor_gpu_sysc_alloc_policy_valid(u32 policy)
+{
+	switch (policy) {
+	case GPU_SYSC_ALLOC_L2_ALLOC:
+	case GPU_SYSC_ALLOC_NEVER_ALLOC:
+	case GPU_SYSC_ALLOC_ALWAYS_ALLOC:
+	case GPU_SYSC_ALLOC_PARTIAL_ALLOC:
+	case GPU_SYSC_ALLOC_L2_PARTIAL_ALLOC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool panthor_gpu_sysc_alloc_read_supported(u32 gpu_id, u32 source)
+{
+	switch (source) {
+	case GPU_SYSC_ALLOC_R_OTHER:
+	case GPU_SYSC_ALLOC_R_CSF:
+	case GPU_SYSC_ALLOC_R_MMU:
+	case GPU_SYSC_ALLOC_R_TILER_VERT:
+	case GPU_SYSC_ALLOC_R_TILER_PTR:
+	case GPU_SYSC_ALLOC_R_TILER_INDEX:
+	case GPU_SYSC_ALLOC_R_TILER_OTHER:
+	case GPU_SYSC_ALLOC_R_IC:
+	case GPU_SYSC_ALLOC_R_ATTR:
+	case GPU_SYSC_ALLOC_R_SCM:
+	case GPU_SYSC_ALLOC_R_FSDC:
+	case GPU_SYSC_ALLOC_R_PLR:
+	case GPU_SYSC_ALLOC_R_TEX:
+	case GPU_SYSC_ALLOC_R_LSC:
+		return true;
+	case GPU_SYSC_ALLOC_R_VL:
+		/* TTIX (architecture 12, product 0) has no VL read policy. */
+		if (GPU_ARCH_MAJOR(gpu_id) == 12 && GPU_PROD_MAJOR(gpu_id) == 0)
+			return false;
+		return true;
+	case GPU_SYSC_ALLOC_R_RT:
+	case GPU_SYSC_ALLOC_R_NE_A:
+	case GPU_SYSC_ALLOC_R_NE_N:
+		if (GPU_ARCH_MAJOR(gpu_id) < 14)
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool panthor_gpu_sysc_alloc_write_supported(u32 gpu_id, u32 source)
+{
+	switch (source) {
+	case GPU_SYSC_ALLOC_W_OTHER:
+	case GPU_SYSC_ALLOC_W_CSF:
+	case GPU_SYSC_ALLOC_W_PCB:
+	case GPU_SYSC_ALLOC_W_TILER_PTR:
+	case GPU_SYSC_ALLOC_W_TILER_VERT_PLIST:
+	case GPU_SYSC_ALLOC_W_TILER_OTHER:
+	case GPU_SYSC_ALLOC_W_L2_EVICT:
+	case GPU_SYSC_ALLOC_W_L2_FLUSH:
+	case GPU_SYSC_ALLOC_W_TIB_COLOR:
+	case GPU_SYSC_ALLOC_W_TIB_COLOR_AFBCH:
+	case GPU_SYSC_ALLOC_W_TIB_COLOR_AFBCB:
+	case GPU_SYSC_ALLOC_W_TIB_CRC:
+	case GPU_SYSC_ALLOC_W_TIB_DS:
+	case GPU_SYSC_ALLOC_W_TIB_DS_AFBCH:
+	case GPU_SYSC_ALLOC_W_TIB_DS_AFBCB:
+	case GPU_SYSC_ALLOC_W_LSC:
+		return true;
+	case GPU_SYSC_ALLOC_W_RT:
+	case GPU_SYSC_ALLOC_W_NE_A:
+	case GPU_SYSC_ALLOC_W_NE_N:
+		if (GPU_ARCH_MAJOR(gpu_id) < 14)
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
+void panthor_gpu_sysc_config_set(struct panthor_device *ptdev)
+{
+	struct panthor_gpu *gpu = ptdev->gpu;
+	unsigned int i;
+
+	if (!gpu->sysc_alloc_enabled)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(gpu->sysc_alloc); i++)
+		gpu_write(gpu->iomem, GPU_SYSC_ALLOC(i), gpu->sysc_alloc[i]);
+}
+
+static int panthor_gpu_sysc_config_init(struct panthor_device *ptdev)
+{
+	struct device *dev = ptdev->base.dev;
+	struct panthor_gpu *gpu = ptdev->gpu;
+	u32 entries[GPU_SYSC_ALLOC_SOURCE_COUNT][PANTHOR_SYSC_ALLOC_CELLS];
+	u32 config[GPU_SYSC_ALLOC_COUNT] = {};
+	u32 gpu_id = ptdev->gpu_info.gpu_id;
+	u32 sources = 0;
+	unsigned int i;
+	int count;
+	int ret;
+
+	if (!device_property_present(dev, "arm,sysc-alloc"))
+		return 0;
+
+	if (!panthor_gpu_has_sysc_alloc(gpu_id))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "SYSC_ALLOC requires GPU architecture 11.0.3 or later\n");
+
+	count = device_property_count_u32(dev, "arm,sysc-alloc");
+	if (count < 0)
+		return dev_err_probe(dev, count, "Failed to count SYSC_ALLOC cells\n");
+	if (!count || count > ARRAY_SIZE(entries) * PANTHOR_SYSC_ALLOC_CELLS ||
+	    count % PANTHOR_SYSC_ALLOC_CELLS)
+		return dev_err_probe(dev, -EINVAL, "Invalid SYSC_ALLOC entry count\n");
+
+	ret = device_property_read_u32_array(dev, "arm,sysc-alloc", &entries[0][0], count);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read SYSC_ALLOC entries\n");
+
+	for (i = 0; i < count / PANTHOR_SYSC_ALLOC_CELLS; i++) {
+		u32 source = entries[i][PANTHOR_SYSC_ALLOC_SOURCE];
+		u32 read = entries[i][PANTHOR_SYSC_ALLOC_READ];
+		u32 write = entries[i][PANTHOR_SYSC_ALLOC_WRITE];
+
+		if (source >= GPU_SYSC_ALLOC_SOURCE_COUNT)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid SYSC_ALLOC source %u\n", source);
+		if (sources & BIT(source))
+			return dev_err_probe(dev, -EINVAL,
+					     "Duplicate SYSC_ALLOC source %u\n", source);
+		sources |= BIT(source);
+
+		if (!panthor_gpu_sysc_alloc_policy_valid(read) ||
+		    !panthor_gpu_sysc_alloc_policy_valid(write))
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid SYSC_ALLOC policies <%u %u %u>\n",
+					     source, read, write);
+
+		if ((read != GPU_SYSC_ALLOC_L2_ALLOC &&
+		     !panthor_gpu_sysc_alloc_read_supported(gpu_id, source)) ||
+		    (write != GPU_SYSC_ALLOC_L2_ALLOC &&
+		     !panthor_gpu_sysc_alloc_write_supported(gpu_id, source)))
+			return dev_err_probe(dev, -EINVAL,
+					     "Unsupported SYSC_ALLOC policies <%u %u %u>\n",
+					     source, read, write);
+
+		config[source / GPU_SYSC_ALLOC_SOURCES_PER_REG] |=
+			GPU_SYSC_ALLOC_POLICY(source, read, write);
+	}
+
+	memcpy(gpu->sysc_alloc, config, sizeof(config));
+	gpu->sysc_alloc_enabled = true;
+	return 0;
+}
+
 static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 {
 	struct panthor_gpu *gpu = ptdev->gpu;
@@ -164,6 +347,10 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	mutex_init(&gpu->cache_flush_lock);
 	ptdev->gpu = gpu;
 
+	ret = panthor_gpu_sysc_config_init(ptdev);
+	if (ret)
+		return ret;
+
 	dma_set_max_seg_size(ptdev->base.dev, UINT_MAX);
 	pa_bits = GPU_MMU_FEATURES_PA_BITS(ptdev->gpu_info.mmu_features);
 	ret = dma_set_mask_and_coherent(ptdev->base.dev, DMA_BIT_MASK(pa_bits));
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index f615feb05609..935e4af31e0a 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -13,6 +13,7 @@ int panthor_gpu_init(struct panthor_device *ptdev);
 void panthor_gpu_unplug(struct panthor_device *ptdev);
 void panthor_gpu_suspend(struct panthor_device *ptdev);
 void panthor_gpu_resume(struct panthor_device *ptdev);
+void panthor_gpu_sysc_config_set(struct panthor_device *ptdev);
 
 int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 			       const char *blk_name,
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4..ec4650e7ced5 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -116,4 +116,62 @@
 #define   GPU_COHERENCY_ACE				1
 #define   GPU_COHERENCY_NONE				31
 
+#define GPU_SYSC_ALLOC_COUNT				8
+#define GPU_SYSC_ALLOC_SOURCES_PER_REG			4
+#define GPU_SYSC_ALLOC_SOURCE_COUNT			\
+	(GPU_SYSC_ALLOC_COUNT * GPU_SYSC_ALLOC_SOURCES_PER_REG)
+#define GPU_SYSC_ALLOC(n)				(0x340 + (n) * 4)
+#define   GPU_SYSC_ALLOC_READ_POLICY			GENMASK(3, 0)
+#define   GPU_SYSC_ALLOC_WRITE_POLICY			GENMASK(7, 4)
+#define   GPU_SYSC_ALLOC_POLICY(source, read, write) \
+	((FIELD_PREP(GPU_SYSC_ALLOC_READ_POLICY, read) | \
+	  FIELD_PREP(GPU_SYSC_ALLOC_WRITE_POLICY, write)) << \
+	 (((source) % GPU_SYSC_ALLOC_SOURCES_PER_REG) * BITS_PER_BYTE))
+
+#define GPU_SYSC_ALLOC_L2_ALLOC				0
+#define GPU_SYSC_ALLOC_NEVER_ALLOC			2
+#define GPU_SYSC_ALLOC_ALWAYS_ALLOC			3
+#define GPU_SYSC_ALLOC_PARTIAL_ALLOC			4
+#define GPU_SYSC_ALLOC_L2_PARTIAL_ALLOC			5
+
+/* Internal source IDs have separate read and write meanings. */
+#define GPU_SYSC_ALLOC_R_OTHER				0x00
+#define GPU_SYSC_ALLOC_R_CSF				0x02
+#define GPU_SYSC_ALLOC_R_MMU				0x04
+#define GPU_SYSC_ALLOC_R_TILER_VERT			0x08
+#define GPU_SYSC_ALLOC_R_TILER_PTR			0x09
+#define GPU_SYSC_ALLOC_R_TILER_INDEX			0x0a
+#define GPU_SYSC_ALLOC_R_TILER_OTHER			0x0b
+#define GPU_SYSC_ALLOC_R_IC				0x10
+#define GPU_SYSC_ALLOC_R_ATTR				0x11
+#define GPU_SYSC_ALLOC_R_SCM				0x12
+#define GPU_SYSC_ALLOC_R_FSDC				0x13
+#define GPU_SYSC_ALLOC_R_VL				0x14
+#define GPU_SYSC_ALLOC_R_PLR				0x15
+#define GPU_SYSC_ALLOC_R_RT				0x17
+#define GPU_SYSC_ALLOC_R_TEX				0x18
+#define GPU_SYSC_ALLOC_R_NE_A				0x19
+#define GPU_SYSC_ALLOC_R_NE_N				0x1a
+#define GPU_SYSC_ALLOC_R_LSC				0x1c
+
+#define GPU_SYSC_ALLOC_W_OTHER				0x00
+#define GPU_SYSC_ALLOC_W_CSF				0x02
+#define GPU_SYSC_ALLOC_W_PCB				0x07
+#define GPU_SYSC_ALLOC_W_TILER_PTR			0x09
+#define GPU_SYSC_ALLOC_W_TILER_VERT_PLIST		0x0a
+#define GPU_SYSC_ALLOC_W_TILER_OTHER			0x0b
+#define GPU_SYSC_ALLOC_W_L2_EVICT			0x0c
+#define GPU_SYSC_ALLOC_W_L2_FLUSH			0x0d
+#define GPU_SYSC_ALLOC_W_TIB_COLOR			0x10
+#define GPU_SYSC_ALLOC_W_TIB_COLOR_AFBCH		0x11
+#define GPU_SYSC_ALLOC_W_TIB_COLOR_AFBCB		0x12
+#define GPU_SYSC_ALLOC_W_TIB_CRC			0x13
+#define GPU_SYSC_ALLOC_W_TIB_DS				0x14
+#define GPU_SYSC_ALLOC_W_TIB_DS_AFBCH			0x15
+#define GPU_SYSC_ALLOC_W_TIB_DS_AFBCB			0x16
+#define GPU_SYSC_ALLOC_W_RT				0x17
+#define GPU_SYSC_ALLOC_W_NE_A				0x19
+#define GPU_SYSC_ALLOC_W_NE_N				0x1a
+#define GPU_SYSC_ALLOC_W_LSC				0x1c
+
 #endif /* __PANTHOR_GPU_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index ea1e222ef121..86de88163e50 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -59,6 +59,19 @@ static struct panthor_hw_entry panthor_hw_match[] = {
 	},
 };
 
+/**
+ * panthor_hw_l2_power_on() - Restore cache policies and power on L2
+ * @ptdev: Device.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int panthor_hw_l2_power_on(struct panthor_device *ptdev)
+{
+	panthor_gpu_sysc_config_set(ptdev);
+
+	return ptdev->hw->ops.l2_power_on(ptdev);
+}
+
 static int panthor_hw_set_power_tracing(struct device *dev, void *data)
 {
 	struct panthor_device *ptdev = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f797663893b2..fbcd44edd429 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -46,10 +46,7 @@ static inline int panthor_hw_soft_reset(struct panthor_device *ptdev)
 	return ptdev->hw->ops.soft_reset(ptdev);
 }
 
-static inline int panthor_hw_l2_power_on(struct panthor_device *ptdev)
-{
-	return ptdev->hw->ops.l2_power_on(ptdev);
-}
+int panthor_hw_l2_power_on(struct panthor_device *ptdev);
 
 static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
 {
-- 
2.53.0

