Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFBDCA5FE7
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0DF10F99A;
	Fri,  2 Oct 2026 19:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CoLV3c5I";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A4C10F98B;
 Fri,  2 Oct 2026 19:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2Six+ccxlwM/v+R4b/fiyF4g0EEjLtqUx7acqw0Z4SrBPOKfwEOq0ArruzF8r8jNqBZ15T1vhY/PtoKUh0jW3lMkO0dCi8os2SwJQ+U0sY8kYOotKeGzVIuyHzu3T8wAbnfLkCXvI5LD5jR78p4Sdr3PBGvxTmwORtrn5ZaiC9CWHsJBcwOorG21bjF0NVtJVZ7u9igGU4Irg1zlQYPWIi6pcz75U+W6SWbpK2oHO4aCd7EOzZUUzSKWzHlJ94mzS+zU+jZpXbMcCTEIG3mxLNwXzwPgf2JkU/qSusrobZIY39k6+ahc9pen+P/34+EZpKpzlgmat2j5AvLJ0wVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oayC4FgicVlhm7Hb05qdpFiVnYGEwuqEIcERdMcLZw=;
 b=E1OGFmx5KXuQWmpMaUoFP/x7+QYshzUyJBaPEdLwKFo/GCV+JXHU6AbeJ5BTKaTTqk3We8If0FVQW6QgFzLWAGHlPbn1Vq9PToWPuZfO7ml7CpqGSYjgxhauTUubfs+K/V9Y7IfeSaOoHt5kmVX3qJhMHEpxR1lv5WMfr2r1ovJfsYhrfuCHFvde2qECrJK4X/hD6Ng85fWtuT5ZDtWN+ir/j/AyggZtwYxlsz6GJOsk2jsLvmGJAdeal7LP3S7kGFxCNg197VGtCUnclBIKhVLE2qH8ksvXFbHdYJRodDVHe4QopLp1gNVbmD/GhsFPsqQ6FgPnl+5P/1b0fXfTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oayC4FgicVlhm7Hb05qdpFiVnYGEwuqEIcERdMcLZw=;
 b=CoLV3c5I/xsrSZlyMc6vzwh9GQQmlksMWK8f9kSyldkyZc57cqI6MCE0lCLwqIdLzOHo0VbrA7xdFGC8ntgQf+Kd/VeyE0X6nEUZb94JsA95OvPZ5KYhU2CPpwKBtvNg2uQUymLTbS7fLtDx9B68xrLDCSXY9AhsE2na64XDgH0=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 2 Oct
 2026 19:01:16 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::1d) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:15 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:14 -0500
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
Subject: [PATCH v9 10/21] drm/tiny: migrate HX8357D to connector luminance
Date: Fri, 2 Oct 2026 14:00:19 -0500
Message-ID: <20261002190030.211356-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: f9044625-ec85-4c5b-a318-08df20b788f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|18002099003|10067099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: lVgCetb17CJDS5q583wD/13/ZIw2Csz9FJGWnkqp02C6O42CtP4OlQGfO4J2suswm8EcJ8Y9cDzb6AiuhUHUXnzbYCXjTlwWGSmgj7uTi5RRCCY8kgsAnsxXFqmWQStaKI2mGDI83E6k+WK68TFnOT4CDMM28b4WKdaZbk3+DDVlVP5bapeamC27piVQYcqaxIEEYFv/BVaHM7Xo8T4V5rAWG/1MXJNV3eHBo1hA3ty7qNmdZ5SoYaot1IxOrxVo9v6ZbXSq5qGmOdhcHifwC6HjvXIpxkXRcb49gU40N2cAiD6LRrvHjX6MB6oVtVi/JccZzwvpZ0DZfPuR/HmsRhyV542dMsBU07T8bCXAF88OFzgwmYTzgcH4/h0+v8W0rCKZJTedsBnvi50TFwISIBHMyvSLUjNQB8eoQ6/mA1VAc7wbHhO9IGH5Vxwe0Em9qOuYzTmd42BTuHbYUu/UElk4IsmvN+TxV/dhy4E7LOQIa2AtwmeiFPxddWCr9tCP40sMj/5+rniJvoQzvSCEhtMwTuec3Ud0HLNwM2nsgyoxjSK5nR47SBIWPX4CC4YVxyKTleiWYQ2xWLp+twC1LW3K5QLZR05GRl4iW3aZwtYm6QGGkr5YYoy08geZ3azrrM1kjRkE5Wcu/RKDf0Av8ITR3hG6uhtwSX/VDHTc+CnKhuAKPPlO571YK4vxHbHK4yr3VG2uwEnliVZKmx3shA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 94wru+W9HHJ2gtIbOaFkfZhpNiMKzguX2x3/1US+YfDuRil7Y9GlmQltNDmx9Y+o8idueGjCrqH4j85RFPEHSjpGPRVyYWKVo6CSRFMUTJ0fEwnvuOFjEnHbn2HJM22e8f6dTDLHDgMO9zI27b2TrBmpF3UC7OQrhW+nEta/myeCDAS8C6TMttOvWm0oVUuhSXNF/rIBk6hTzZNUbhhJSwmSm4k50MCbmm1KZuqu7obFLnfqHO9QShH9IcbilWeszIdohxT32EdV9VeRf5iEqorzOD7QFpJGYmFoyiJrA7SaFqcDGY7SkvGYjvmGhg8InG2HAUy+lxyCyMb5FeVoOJkieGopuQDbXwpuNqMqFbju043UXGAGXF4M5HLjqxd6Ec8KA8aVyIUkLElNGZkwsWSivW7InHZ+1F1wopJeBh4YkfISJGE014+3N3hDrgHI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:15.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9044625-ec85-4c5b-a318-08df20b788f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

Attach the connector LUMINANCE property for HX8357D displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig   | 2 +-
 drivers/gpu/drm/tiny/hx8357d.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index e61a429538bc0..9914c096ba7fe 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -105,7 +105,7 @@ config TINYDRM_HX8357D
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  DRM driver for the following HX8357D panels:
 	  * YX350HV15-T 3.5" 340x350 TFT (Adafruit 3.5")
diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index f942a8d09ff22..c5cfee13b3e99 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -355,6 +355,9 @@ static int hx8357d_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &hx8357d_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

