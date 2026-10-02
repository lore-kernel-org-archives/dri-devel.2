Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5111CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B9D10F98A;
	Fri,  2 Oct 2026 19:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qHdn3pTu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6181410F96B;
 Fri,  2 Oct 2026 19:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmApGNKRPj6yesqHk45Kk6gQs30Q8PFHly67jUkgIvcaSmtJyX95KDWtVrErINJ1HoR0Auj0tIa/hi7rgYxlMJt70C7KJiLdRJeg6K+dcnLGLEcFCAI54nVZsCGLO5V6zAw/tc+ZPRKlr1k1ypmiLCffVsSUZFO7uZlyQMyCtyfrTISF/RW+s5eAwfR4Po8NPFX/mAbYA6JHq6uWM7g7eU7kgzjEwy797WwMRYKSNfZ7PKt7jLrsrkE/AGeoSIMqSTccaJ/v99cBoR9f6u0Q+1yq9wyP2gdiC92ImqQLN1eK2DE+fMJNcNACLFM7C4KysP3ybtZwf5B7pf9inQnfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C22489joOxx5FDT/Vxcn/vITvAmXRkdNyXXOvHHAPW4=;
 b=A7YgpK9jlIy/GE10bagOXN7mgRXTyKhml2TZke4g2Vc3YlodlXZlCVpsk3BHrC7bhNdF2+Y/YJucNAArjG+4KR+7vPVzW3+6i2mmah6lBaejpPrqb5KjgYwpaqXmol7vW7HQQmiDu9WcVj1t6PWIYpdW9BpnAwwbOHTqC81WyrsRP/8aC6m26hTByRk5oKbnUNe24j97jxWiLQOrPRVSPOYKS5pZLTqR+e7c7aFEsDZAZ72+ngG+EcAoK7FncD+vtWo2/EcoGQRC7uvhCD7+qKiQmQ4LqELBrvk0LBr6b/y8b92LaOEuVarMDGS3vCYU3Ik+GOBqHWH3cIODYBXOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C22489joOxx5FDT/Vxcn/vITvAmXRkdNyXXOvHHAPW4=;
 b=qHdn3pTuS4j55Dl6dycO+tFy7NnLUaJoAiPUMYH/gzxMc1BbAS9ggFYp9NMpt72jjvQ87uFSIbFVXC5sNT1xk1QQkd+Beoxt9ql3TShOXd2RY4UeDt8fx8n9AY+0IXvI7vUIh4s74J0MpDIG8VZFSNlewCcRtyNylPEfMoGqYwM=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:14 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::99) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:14 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:14 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:12 -0500
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
Subject: [PATCH v9 09/21] drm/tiny: migrate panel-mipi-dbi to connector
 luminance
Date: Fri, 2 Oct 2026 14:00:18 -0500
Message-ID: <20261002190030.211356-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fab8d8-b557-4c57-5e27-08df20b7884a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700016|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4FlOCRUCBhwPxXaIyTU5E8Lzzrxk6AMoo08nsyeMWcwW4yn+4hBAqNDUF+RayYCxQUM5zaZT6boNOYdFa8D9V3A0SXUoiFIY0lyQKFnoJ6eJfZtSIIWSLfZkOUvetIDBHcrht2qIRx/+zWhR5LePO9SglD1GFsX14/xuWeHNaDcyvmerLASvXhLXVQLAcf64+uj0XdN80ZV9rB+oJesLxw+tfr/Q0Zp8SlTMYoOXcfvC5RRGtphNXzh2oMGQziO+AVrJRNda9s/5RM+2bkF+RzAKA94zHpdnrmVT1gTnkAEc0tXLb3IzDruYRPz5Ev1KG6Z9p/gyKbZxNDpJOih4ZB2E6RlbjW4nV+rjJzAzbmHVjjFwsa7km8lpD76sVILcenCv8c6w/HbXAjKLUhQuw39ax8js4/15jIiM3GEJYnCm/aQqC/c878HA8aXFREl+lB9hipli5OWIDN1/ZYsvBVWos4CS81QPRkSp5JETCmr7VDcXmzZmhmkTjBnjrZb26wUMNdJXTwFOH6NtxdNYcztF+xcqaJLJ4sKjw5/FmZHnQ91DCwU7wKUdQZB+vJY926/j+RM4MzJiUvs5Jd0q9bBoGGvGHmN6GpxCfyj+O7jTxU54FhCjGbqKFYOHbL+lvCpLtrwILJiNo1EFfWz1gsF7Zzb2TxesH36sPUL4ocuvvDni3AB6GdgHrwNGAJRM6o6tHZaAKbWybNcHNI744A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R9+xPWDjJzzxf4ATPqHxsRj7lxWXS31a2iFVdXG3aTjLM0Xpwr3HHAmkIMC+D6ZzwsFaPf/tXXoeea++Zm5RGl4T4hidJ1mQEWZtyFtWsnFfTuiUCOwJmM+SYgDsanvbOtrAqnDY8oSOS97972+HUmutKBGa6jlhoaYFLKAGCRyTZNNKOv7/LbUUiUkJAesjDhPe1J+VHfUFlZvBaPNscWtxgJaMG9DwDJeGmYuLtr04/8hShoB2PF7+7wTX2eppdbl1XDRkEK0axlIHFJzTdQ06PUs24n08sNljcSWzjLcJZb8Nk+25fhzghXAeScG8lCGhXRKXpEr4BnEXFwijKJU+lwcHFUU4mTB2DWIZJyN+IfmmQrRs5x0Ypz8ai1iRyAaWDXhh+Ca1HJrYCbWR/Fe+Adf020w31Y5TV0fi8bzupQx4r4E3JrC7DnnR0++C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:14.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fab8d8-b557-4c57-5e27-08df20b7884a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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

Attach the connector LUMINANCE property for MIPI DBI compatible panels
and retain the legacy backlight class interface only when DRM_LUMINANCE is
disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig          | 2 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a470..e61a429538bc0 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -73,7 +73,7 @@ config DRM_PANEL_MIPI_DBI
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select VIDEOMODE_HELPERS
 	help
 	  Say Y here if you want to enable support for MIPI DBI compatible
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 60cd65cae41d8..730f1b219fdec 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -485,6 +485,9 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &panel_mipi_dbi_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

