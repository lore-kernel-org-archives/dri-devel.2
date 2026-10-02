Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E00CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423AB10F9C0;
	Fri,  2 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOcjAVc8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801E210F9A3;
 Fri,  2 Oct 2026 19:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+h8vqMxe/SVCfHnFOmz124F5pG0Vrx0v8pmCnTdl4MIxUuxGh5aWz4f1u8x5vMMPXHnngbvSVd6krlPCI97OI/BPfmD+HlbWKpd2Z8C+bTKTijzOmL3MfH2JTk9h78REQ4AYLBwz6xR8MVAkH6tZZI7WPiIeM4tt9cO5qK7iFcSgXq/tTxbL7NT4xzO0J9BF3WMkFNqHRdazGOnZQfUhNQXnGaHtBE5gZbzGLgGCk4CKLYTxea9p7rsZ34WzVFCgd9goMG5whmxGewJaauJ+P3bnfJhNGMzK5sAAELTT3h9kaaDGjAd/+JLeMZ5teaqjAKvkfADp2/7KaFUY6NnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HfjXxdMbywgqIdcP031DIlv9o7aL764Ihc5dQsybEQ=;
 b=K+UNFFfw+FS44u/VghHc53bynMN37kxSUlLfuioTU0P7vPtH+nJ1DsqVaVr+TfDB0bviw7ryTyFENjZc+/8D3tsFpbQw6Cu5uZxzNnD8nc1XSvk+ukES4Xpdrj/wQF3a6edKJ9B4UcOEDo/2qmf7JrbutrP/FDamDq8WGe45lH6CQcJ5j0No2BCjhRpxzk6LHzprjAYMaYuc468o2svJLbJ3JaONV16urRV2BPhTHU1Mg5B1yRlDGYdwEEFbEwt3ntT5l9ANGPDRVOhdwHOqWVpPaJTZ1I94LbSXUzlhkJdKEoYeqY87Wjbc9aFRLRzs4CNgvTJEeGnfIWVSA7bQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HfjXxdMbywgqIdcP031DIlv9o7aL764Ihc5dQsybEQ=;
 b=SOcjAVc87PbWoLvn8x6t3xuhpYTwk8/ykzEjs774ppBDeYSHg4Z3K4yjIXUMaujmtyLKmr3Ozp+IeIWO86BKEWeLRC2J2SJBzkfqPOq5nQ0xyWYncBDd2gggXzp0tH3db/hVW97KSXy6OmNKULpx3u9GVtfappu180/HqFqjw84=
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.16; Fri, 2 Oct 2026 19:01:22 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::41) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:21 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v9 15/21] drm/sitronix: migrate ST7735R to connector luminance
Date: Fri, 2 Oct 2026 14:00:24 -0500
Message-ID: <20261002190030.211356-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002190030.211356-1-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c44211-5c4c-4e38-95b5-08df20b78c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BXmwxmYTM/VE795Oh4cglJG7Es3BpDp097heA+8CLiCV+Bf21sXGYK9J8YOyBqDzU1IkyyOKgHwQm0vw39DXiyDvey1TVntwm1JUJ8VfWBE8SAE6PsvTmG9PTEKbTzXsbZqbsmI+dRteBdm/zg07MlHA+iD0CNL8yLHvzeeVMlmOT5sZz49bPHQpbTmLaPkXRTCcq9RV92LMCuVZ3VqI1UJR+SIUa8HettNOULA/ntv1T9UJzNxWAssjAPFuxNPqEafXo/3iT4jlT+4VKfd9Mq6nu55VjutElphhdeGqiAQuQ1mjkqpfDJ5n0UzhpTGR+hk068fJ99aCuiIYqSOhoTj5J7au+6F/0Eua17aPm8GgBKsXrdaVMQy+Vd4QWYSBvl5aIdW7XL7RwddRlQ6ab1x09ryEfA86NZ/ouhTgBS55cMiRKmfJz6N92p8nJSJjsAzqpeenc+e24R9hPI8X2g/8OI7TRTdv/ZiCYUnZRFIG/tk+pONih5tRI9ftaSKqk6E2ku3oGn/GWDYcRA6LL7d5/zYiFFugoMjkj1ReHP88hDk9HA0idvk3pKEpev0lSfL22ABDZjcQgWxcjdSJR/tH18mRosbl/quKSYsodvwnRS6a+zrUrSLgyjCnGMmcpSx9uyf/IK6vACkrarQCWEk7Le8TmAohh7LpBzsjqSIx06NvcmTSWfp2f7Dbuc4ZIOgaNeFPPHJssmUXiWepOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XZPnVcFIQVYmqO3J40FDEMQGjtcix4w+zCbjJ+4RKqE16cR4/RkR3grL2qPWBmmPReNINt44BI4K0SvVbyuXvhfGMfkui4KczTMT5Uu9vgMq2QDCgqn86jRZkmCD7UV6MQt+ZlSFYBusPB7/rPdcacUzTmvBBE42D+diMWSZDSmmbqdrtJP3teE2fZDGp3pi7tLHV+4UjAg8rN0YDcthFUZ00NRblUfN7c8E2HlxVVZLCoBmTYK0JMfHWAHQidaswB7RQtyEu04pHJlI/2zM1ebQE3eA/DQ4OfJFnarfEcMnClx8j2QOoMzmhfYf9Tnxyxkv5ad9SyzDshMzhMOLXFpBOVSJqTmP4FFn9R467i0YE+J9kUPhEQxgJN0nvczxVR6eCgMsj0Och8HudrBY1bmXRAkBcpfbYfp+Fb8TZVhPlA1dv2MHQssYgl1etp7T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:21.8007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c44211-5c4c-4e38-95b5-08df20b78c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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

Attach the connector LUMINANCE property for ST7735R displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/sitronix/Kconfig   | 2 +-
 drivers/gpu/drm/sitronix/st7735r.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/Kconfig
index 41a428ef8295e..027fbddf4593b 100644
--- a/drivers/gpu/drm/sitronix/Kconfig
+++ b/drivers/gpu/drm/sitronix/Kconfig
@@ -59,7 +59,7 @@ config DRM_ST7735R
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  DRM driver for Sitronix ST7715R/ST7735R with one of the following
 	  LCDs:
diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0c..105d994c07ab6 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -330,6 +330,9 @@ static int st7735r_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &st7735r_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

