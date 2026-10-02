Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D27CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D592810F9A8;
	Fri,  2 Oct 2026 19:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VHzejNQN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A449F10E680;
 Fri,  2 Oct 2026 19:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqGpdlQUry2ZbtM10OfOOdidv7AVFpJ+ppXM4s+UJ9U4IhZnp1pKCljELuYxCJDULMyZMwm1QVA9jNY06TDaKNwBoSA8Ca3NOfjHE7fWEs0HED8oV4EmJbbQhQivuMo0tyZOt/fl+u5/zliZXJMUNGpeuaYUaaaX4fSs4Oxv4jonZzDcKZCHZbeY17iI4c1N9Js2TU+CHdP4RIMxpC83n8qexmTa0CoNe0QSQSkSLO04r8zzdROqaEfHQjOpvSo6WYbH/NkVLrKj8/M3n5D29mkU6w+UnxyGfdYe+Qy7DE9izLBksCOR037OliGY76ZfzRhpngJPLKnVjUKMFer1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pguHMbD9VuvYzDxY33BkZ7qNiNvPmVqYIMJUcwPiEk=;
 b=Y5kFBVP9TpDKiwd879cRELB/WSb9FDviBOrObIqmY0gjfOFbZi1aFsTPxvF7OwZ+ioEnGmLdCw3MePqUR/xmiX5/0nkdRhsVVNN3Z19OV9Q/6yIQXHDmyTWdwvDdOaM+KdVeTqD7mAkbT49xEM4q0d6yqfHrFMbzvoekKvosgd3ps2QsY+EVKPEY2O+L4xBHFuUwJLYFs8oxGWYkEQRv8dEBB65F4J03bKljWIy5Sx4J+MaYceCd2lNxxi8bf41qEknSqrlUUfBM9+rXYv3+GhrhjKiKLLs85QQydpnzd/aC2Rs4xLX7Sai9MKj8CJxoTUZMYLDkCgxPIILowL/2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pguHMbD9VuvYzDxY33BkZ7qNiNvPmVqYIMJUcwPiEk=;
 b=VHzejNQNbfsr0v0SAcxbD/BMDRUuoe5b4PhB5PRNAjPYcg3mTEHky759OhQkf2RAjqvPz0Ql2yhhK6rq/YZsIOgLXzmxiwTr4BdBbSMP8U0qe7S2E/+nun7RSPl+Sb1NArI40fhQCXxbPsvpINh6wT0/JTbRJxR5qNOnGB9lIG4=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:18 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::4b) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:18 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:18 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:16 -0500
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
Subject: [PATCH v9 12/21] drm/tiny: migrate ILI9341 to connector luminance
Date: Fri, 2 Oct 2026 14:00:21 -0500
Message-ID: <20261002190030.211356-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a83c2a-27ee-4580-1e08-08df20b78a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7rc9kW20q1OgWLGOEayWzn50Cx1Ad06A7Nmp/+Eo3bn4ioDGDzWDnCpE5DyUKHOPFuVEf7yKG1E//57pPom41DLz3KD+K3kZhy24RB+fTLSCBIgQlckBZpqDeQoUVzLMfJ8XbnPcCyHZhhM4QN2C+YhnkpKHoZGTO1IzMVDnxlvhEfNJuR3ud1UdVO7uCbjQAauja36Irp7+lORYd56qWmF/AtWbcmXbDrTezVA49lMx5Diw4q9G5nQlG6xeRfGiDC4hXkYCDzdmQDh6RoPKP5lraNaEYILFuLv+5Q9ZY83Q0X3/Ikg8ykqqCa7s+urltQXrSTRHjqRrKzxwJrna6WxcnS2fchYjTDIQ0r4DgR09eSrTabCR5mvytbu4olj6KfFTh24FurBXK4YOk0IEEOjCsJ2aQsQ35WhgH16H7wTMXdUdWFIVnjzRmaaD2qleVchuRmBwiJD6tEgdXlQpnsbxg1ZaKweYu0WPUGV43Epodjs9wDHpVv0ZnA0uJe0IBXMuUbhq1YpqFxCG3kmF2ZmjMEQ2mQ/NZZcVQGTBHhQ20nvtF9InVOQ2w2446xB7BP78ojcEBHQh097D6cygexp5KmU68m4nSb5fRDNO9i91xPKsfy5tRarf89YMVSxTR+n/2Uit39J4jB+xIk4UgwTdEyC/b3En4Bx3/uZ0QWV2vtf6w2uoLiTVreD/bVqRsRxNx6SXk3YAnry0ODS3rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wa/k/iWCQOrzePSfgdXTzsBNX8QMHWQM90PZhlar6zet7GNGIG+FdUwkFTLUQ0m8MaF401S3apjslr5cAKAOWM/L3MpmBTCH+EJNLfblWqjdTeS/0ihlqyxdTWxqeX4tR4SnNz7usUG1bG1u4AHZz9vB2GxEfEa9h1TvXma3UXmiZXwl7JFpQTQ9g5gLm6NjEDoUkErwN7On4qU62sM/EzCTVK1C+CecLiS8H5WhmO41/PEthrktUs8aODGgXTn7+sapOnO7DZ3nW3K6I7DoXAtRj8TSJ7EYGsiKq8rUamhv06CotLHSmOVka+86ZbeZWdrtUfe2R4z7xTYVf5HUBqovkJ7KHkaR7+CqhQfUi7w99ZUKD1MXdc3F0obaUjkiS/fjNwFBGpV6HkM39shIc5xCC9pv5Iu3PhUdpadDDYMh0/FNfob377DfXDKfL+4q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:18.0298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a83c2a-27ee-4580-1e08-08df20b78a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

Attach the connector LUMINANCE property for ILI9341 displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig   | 2 +-
 drivers/gpu/drm/tiny/ili9341.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index e553b0aaa7571..85b166b659388 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -146,7 +146,7 @@ config TINYDRM_ILI9341
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  DRM driver for the following Ilitek ILI9341 panels:
 	  * YX240QV29-T 2.4" 240x320 TFT (Adafruit 2.4")
diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 003381aa22ea4..3a5c8b39ec7dc 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -317,6 +317,9 @@ static int ili9341_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &ili9341_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

