Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D531CA5FEB
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD14210F9DA;
	Fri,  2 Oct 2026 19:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDZcNmTe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98AB10F984;
 Fri,  2 Oct 2026 19:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msYdh1uxc42mUBPbtvAFBrMvWSE8ICLzLU8LwRzVLKcnmQS9fF6aKKMICt4P0zwBeENzfGdIxF0FoOeOPCVLKsm19YoJALPJnAx2+oDQ4T9lHJabP+KuX0hxdh6d6jMZBHJNiudfGDxSsmGJwypFIpO4W0V74N6+9tx5NCRClvTbyWtAgCM1DBW1xGAN3vK9e/0Aj1unsJT+/nJ368Xa/3VsXrpET/PzsExqUB5FT4jV48sbRdWQe9UhgZLpitLNKXu7AvY47sSVOOre/sgvbByCRlWEjWHC3sMODk7m4mAv3a6Prkqh1TG6jQ8WWvpuYqPCS8u+/C4ZuXD5JUY6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV6rmgDm7OTVrKtjHXtsEO/DCn+lLxDRJmKcurHSkq4=;
 b=A/j1c+Qi03sqiUmbZeWQ0YZbr2K14mA4JFozpEJj2MqnfWJU56T5iUazkjtWVlwP8U1IxKw1i71IWqNPzp7lSUP9ZEEeeKx++mxpMhk/lytAO5LfsO5FduLL9xxYtqYnE4UNK8X3zowg3wTuHoxkipQN2ggWzGBFJN0n/Xtzya8DrxU7GXJKJygsgwH3dizLUEfcretZYVluf3VeXZEZBwliwF8QzGtQtTj8TIQ/bJ1bGkBFdduZTCY+ELw0qbplNNfegA+GZTdLF3Z/efj+7ehLdAuUCgiOAqOIqq/oU+i90N6FPxQPIzC38mezE1QuwBnXFAET6mqxZovctIGuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV6rmgDm7OTVrKtjHXtsEO/DCn+lLxDRJmKcurHSkq4=;
 b=yDZcNmTeTjcWrh0LK1vT7tz68mJlASPhlMx4b9sIoORyZk+00Alxaq95HdwPtSYMhPPxqD98K+AASnqTVHSKLJsLrjKsmj6WdlKEu+09S5A7eemZxDQIblSEErcfmMhBcoP5ItpsV8ylJCKQc5uw5+UJBnx1oQ4x5JATVVukZUo=
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:19 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::8e) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:19 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:17 -0500
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
Subject: [PATCH v9 13/21] drm/tiny: migrate ILI9486 to connector luminance
Date: Fri, 2 Oct 2026 14:00:22 -0500
Message-ID: <20261002190030.211356-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 687e3b2f-d61f-427c-3890-08df20b78b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|82310400026|36860700016|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q55u0xlRyxdq504//pkrgLRiDO4MklfVVYJnFXX9uq3XkpU4776soIkieEJNhK0jgeeUl5mzAVvsIlkPHlR+xPCJzhw2lobgF/YMPA/TNCUXWBTdrH9pjfXDHYTQ38VGoK2h7ILOIkXwkZ7n0nUJNFQbdpHW2P3rJQsgkcY8shpNQCxcJTYX8SHKgB4ltqoZSXXKs2Yg/OItu1DDXNW9qk2vNlTiwpvMHsWDXv5AzArqXDuiBf8tu9i7Hu+HkQYncCiScZmneeX11rNls7zDOOEDCtnL4Cat2/xOMWRsyqa9X0di5eAWQeF7Uxzt4lmMQR3eb0cNBfZDOy4V/iIE5pq+nbvry4AZhzp88DrTXG8Q5yGkPZXLEopBEk6OGsvlDK7LWJKJibQzD9nbsmVsSXIJhAXv+lyWkq2Mq793gRgftYbZO0bFvKbW5Vlom1Sq1bUJ8+QI7WR9gBXgsSVrNO26hhXBaVFKY1dogaz13SAK2lH/wbiZfK9VHX/ChMo0W6wIx5nLFrbZj9HwzzvcbkVjto12aoeGR0wSUoznSlmkYb3/RfB6QfD3FK6zHgBDtXaSb7tiQuhfSgeVDUpPf7C3xqDDXuAgXp60Bu0pY+JAn4YQzMjV2Hs7pA5tSr86CpimV+HBKnKi5V4boyL5uiMJUi2lfjd8LOgg4B+7RViuTSaQKbHS2Bt81I6k6tkNdK85eaSZgAqVXMY0JA9odw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YGoTbiL0tIOPXIMHzkrN5vIdIHu8vNilqEKW48JR3I62v/cnwgQUnFuQOP5DSvJgOLpHyRF/uNMD1NXJZxS28duz75NE5AaIbcbEwVx1ghYidXAxNQc9Oj15FWZE7qcCLgquX3YTI293X7bXyHLtFZDSDFKwKQSf4F/d6RftAEUdpmPNt/SoeoSgzaMBT6WPKRyjiXJUcpgxn6whju3SFpyh5nZ7jhi7C9gQLfxyf+fDNeG+jklTNZHBqLqmBGMAHYq9SCOy8jwMPtMVu+tAj/ZMoA4a8N9cqqEswiF6tVtPgyI0FgSStt4eM0YC5YjBs+NoUbT/fE4IBkD810QCalVK+UIZfkLrS6OtPS5NLjAgix7PsdfXc+02l9mZXxzWh5aWwRdc+48z63nFMjAVZkKaKCFYIsGc4J/72cIG/wOsrqWvW/GxlUm9+/MHIPk4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:19.3141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687e3b2f-d61f-427c-3890-08df20b78b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

Attach the connector LUMINANCE property for ILI9486 displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig   | 2 +-
 drivers/gpu/drm/tiny/ili9486.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 85b166b659388..778e450f381e0 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -160,7 +160,7 @@ config TINYDRM_ILI9486
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  DRM driver for the following Ilitek ILI9486 panels:
 	  * PISCREEN 3.5" 320x480 TFT (Ozzmaker 3.5")
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index c945a91443158..480f14bb3bfb0 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -345,6 +345,9 @@ static int ili9486_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &ili9486_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

