Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28807CA5FEA
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A402210E691;
	Fri,  2 Oct 2026 19:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+1EsH5N";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8AE10E691;
 Fri,  2 Oct 2026 19:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbfIIBRcQdWYHFpt1COybXHLyYu0n7NJfrVEDyX8gDyqgC80Ad1O8+ajjLxiHSzZxB4BbiNzMbO5Jm97HzSDrgi4JXeqLkUfM/PAeciOtO4wbb7dVzw4P6OddNTa+1CdeFEPHfFAd4bNlFlI/3uiD2HrVk/VoYMztmh6m0ha1CYyGPWLVfSeFC3bfCepOqyLTBRvcR50xLmGL0G/Gcm4LK+JlwOlGbnKAKyzp213H1YcaaCkbssLwHLhu6m+2YqFGU2ufyUQmeqiRi1korE7zICXFPcHzbnfiwoqKcU1zzlbY0oiiBDn0I29E5WWoSQFoMRkvc14zGYY0sqt9lvsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0knnOGUhmUmcK9O9EHOYERhFb3OxAd5uGvxLM6Y4ZbA=;
 b=EgS6HKLQSo7EayayfMd5AznMVsOJF/oO3HdTbpLsP8y/94fXTNFa+X4CMED8feIk0M8YKNPVzUqVeQ9hWpix6/IY4tQlyNw6a/aKHNIJvYkh8/4ccfHUeTXgXS3n+Atcgjb2yfleRtRfcRk0jBEO2PF1+buf/dJmtnZYB06rSgQ1Q765V5f9mXMTBzCBmkKlfP/w/41GNKa7HZoJ2+u2QIYtAbQbN2HrIPj7dChKiQXCQj1hrZG3P/dF/ocbE8zlMXGgDrsRheH0GIUoKUsYAhU58+8NIchKphQK3q6uu4klnsBsE45QVGMH6yCFU/IKKEktn0CBy/JPhsdMNfIwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0knnOGUhmUmcK9O9EHOYERhFb3OxAd5uGvxLM6Y4ZbA=;
 b=E+1EsH5NljQbRPP41le08Bb/fqW0W3pe7v6cCBV+Lr9AyMasEQJf3AQw4LKAu696m8ZVDmnnvhMaRb5i2W/863exjR9+ixrcTFqMam4U1UTAXLGai+/gLZ1ilCyBiRXUM7z/H1sk/v4S4JGosf715Vq2qCdvygNSiD+Xdp+CekQ=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:18 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::2e) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:16 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:16 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:15 -0500
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
Subject: [PATCH v9 11/21] drm/tiny: migrate ILI9163 to connector luminance
Date: Fri, 2 Oct 2026 14:00:20 -0500
Message-ID: <20261002190030.211356-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 924de1b8-3236-426f-9524-08df20b78994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|23010399003|10067099003|260925021911599003|260925021311599003|260925022911599003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DoFFduV/M78YvJzih0Kcx9xzKgkhTqYy2FMsmhebmZkYFWUhWZtGjeei5P0qLNKOlLLB76rkl0ireozllrWStDCQh/oeeuqteTHEbVkJahzgBTLaQDxXhciGbiZBEX49doX/jea28PjfmWXDJlvqIUXic4LgDsWdFqGlulccYkC0l9gPeGRY+bLNwqdpobug8MtJFQD7V6laW+xRuG+4DqtYfsrhTt6IubafE4QU0OJ60VY+iDFoxHLRNvaSdIYIFw+RvO78iW+WVxO+NLEZsnto88tXJO96JoladW7DpvnzIAJ+iW45fzxF9UVRGnRtkJOnwUOFftHXMWUXYXxho9RNS3FWPLDma+Svrn64GvQd6q0i4bicKXv2MKqF0ixxtyuCMZdVL5zu8e2TumVNL1D4J7+6I0GUPH0M8NAP2wi55/dXeWlPXX84tvK9P5xIokOEDubme2WCRfggETzulXv+YxFAFgVqqXtkBxj8YLD6iACoe5NTW7WtQQadGq7b6eKPJiKB5geZ6+5UqrmvsCp2XfaKnWkb+oF0IsSYOSTKHNRPtRL6rMLfpLFp44JWWam1KpQdfFSip1wYzv7Mg5gModibVwBjS4agRzqAhtRJO2CrXreeKNT5OGh7nMkKfGJW5KsG32q1xkRAZtRUBc2mSSB8kqDPFgMFN5pZGjVGKW9o5FbCijQ/FqmY+b2cW8NX1Kj1FHn32b0/fHw0Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(23010399003)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ga1oIlmtIDpc1KeSp9CSRpMdWdZ4V9s3hUJ7fyuVcts4CVnsaD1GA7h1zukmwiHQvroV4XZjU7VggI/8lRJn3vEA4sjiVJNOBClyaerZG8ts+UH5txvfHzZjMiZrmkfKDOadQBoZXbKu7wmENJGRwordhyniBB0aNfHWZhjrgdLOI3NYbMXQfpkmyeGsIs8jdsLr4a0QqtcWHu3Gm9ey71aP/+4X7bvjTCRPetvvaw9RWWn7YJYpmR2yw5pPGWuPtdEjO8XuWFYjo9+6XmHh/vOonusuKKLNQCLtC2K5WIN2XJe9ve/SS7VOOfAPEvDaplKSTf4e3zCFrdruqldSYF/KV7afv2sMBH/+XE8i6xTQ4zmJpivYBQrBSDB8CNWjJibTNVLDei/AlVStr43iSCasyisVoGxovomf66iJPauuCz2ekRNE4aJ7GvSBPOm/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:16.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924de1b8-3236-426f-9524-08df20b78994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
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

Attach the connector LUMINANCE property for ILI9163 displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig   | 2 +-
 drivers/gpu/drm/tiny/ili9163.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 9914c096ba7fe..e553b0aaa7571 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -115,7 +115,7 @@ config TINYDRM_HX8357D
 config TINYDRM_ILI9163
 	tristate "DRM support for ILI9163 display panels"
 	depends on DRM && SPI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index 8842424504e3f..46c1582d7b444 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -286,6 +286,9 @@ static int ili9163_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &ili9163_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

