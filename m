Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480FCA5FE4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2643010F9BA;
	Fri,  2 Oct 2026 19:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0s3EB5T3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1377410F9B4;
 Fri,  2 Oct 2026 19:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGDVRGFtMDYt5uNS/Ckw90PRT8lAIhDzatOyRx8yd+q76+IPKKDvHyDa1rZrNh8NhIAbPYAGeLZeVx2nT7EiYTd8KOjwX8cygrW2r2pYQIG87KYF6f8k4VMskGzzzmGRxHD6ze325Jp4wfzpQSak7sF4wd5+ciND7SJ8pth5YGRE2iQKXU2ShAu12LO0yAfPt9LoPc3Mo8QVXaDPVLp2I4cI/JKUQqdn5DJEJKsiYhINyz47xkKE1XH3yRWAkUHHXny95b+yfZ2OX7iUMCKo/d+bTQNZEDtEQJNa24MfEh3VwhXeRKwnCYqZRGTzM+AoLNllOSX2/HnmPSz+VRI8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UPbx0j4xvxQjdqkiPFUPPQA6yUg/yU7t8CqoqZ7/pk=;
 b=k7w0ZIdjM9/qPdPd4V+M+/9OE55lylb26K8O5B8BlfaQqFE9+F/f8b2Y1YCQLDaV90LQ2GB/xIMysBZFhiLUoTH5Q9+3awM+xat/khcjIiPuWB8WOPUsnfADFURqyahdACll7fdjbUGeNhuzXpVUoMv3n9SiIooqRa3NMUWwv4WdjmVTAZHJZzmCdEaPFOEIAv/EWz3SUX8E20OVHOaD8Xsrqz+PuvtgmXTRfKAzr9NE/cz1XruK2v0+SvXFQF1+85apkkp2yXlcCqolpe8nAzU9+aNjix9QuBaue+PZEAIL2hQf6HJtOKoJ8QlamUmp9Ue/7hPfofqViws7NjEvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UPbx0j4xvxQjdqkiPFUPPQA6yUg/yU7t8CqoqZ7/pk=;
 b=0s3EB5T3oCLDntQhGsDrRjpuF2G7s2jQZnfyjtUdvDZPtdEP/x5obStTfEN16cRVmuB1r7tBUWRenxbawy60IoUQOHng+qgzBi8OQ80vsqdqSMLbP2t8gObf1rW0Qay//XdUdIYEK43TawQMfVRW4d2oW2BNNzzQo5Ilc7ptS4o=
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by CHXPR12MB999220.namprd12.prod.outlook.com (2603:10b6:610:2fd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:21 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::4c) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:21 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:20 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:18 -0500
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
Subject: [PATCH v9 14/21] drm/tiny: migrate MI0283QT to connector luminance
Date: Fri, 2 Oct 2026 14:00:23 -0500
Message-ID: <20261002190030.211356-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|CHXPR12MB999220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d332a6e-f073-40c9-704b-08df20b78bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700016|376014|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jA/lRTr1fICSnzkqtG7oP+xs2XhoewWwEzhX0Hge76ZoJ33ZnVgzEsA99NTdbW8RpQA4DWDL9Bcg55eKeSSbpDzN2VdZDGAKaJ4qmqE3idOcGT/BFcC3UUCIUSn0hj2508f3YUC7VMsEZVJMcq35M4qyTwL2W75fgH2WtFvouEuhwa9ipLjRp7gmtm8jU53NTYOPa/8yJ5dbWYS/8SMzPCedmIFOECOeVuNFQY+QBAT1ira3sXwrSYiOyrXcCqPqkw1tHk6XNRTPwA1MdCNIexc7/jfWIj3q5BPAm7351qyonBGFDu/2eaD4ztrRktG1AOJB8gKrIimFDuG3c0WtDjpGfvk+GWoWtFh5XhvwVh8HyvIXlART+TkWX1P8ftlZtuZBQgk6/V9K9KD82jVTwNJkNVIRYPQgPfI+fhxnG8N0gaLw9ujDvf/I/xR/6nqB6G7CANsXXrExSOiGYcNtTDbiUfzH/uUK40RS1cvCPFfIuL/5D/GzVq6c9HvdibHHIaXxBXwAl/fT0mCHNVZVghBdZQq5HJAwKrd/GNbhj2elweo1dc2Ri228IE8AbV9FzhIugf9ad0LTe7Ut3dbRQQRThlTnZrK8xOn9CmGZ1OUgCLlH81NuiGL721yzzVDyYYIXvEYX31wNP/4V9YZHApzjruNGtds1WLB3oatMpPQGWqk95VG/5rk/WnTpAU5x16o3r6PLdG+9kOFwtAOe8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RBbh0/ujB3rS7fJ+/iaNE/41x33D4zVX/WLSn4QcIe40fwz5ccpwt9vGb4/S5DqtEOIMdzE2ESvmISLHEaHBaTxSP/eZuVBjzNcfigm7QvBID1XsDnnQpGKjDsDs51dR2IUm45lvMIHqCJRxuE/Z8H9xHVvJRdYexCOYdjuAeh3YD9fo9chMGKTn4E8LyhzI1uEfMp7HKDbr4C8cn7+wxxrjCbMZjddQMK8c9FhZVoNRn+snza6XufvJlfngpMM39OTPjkPGcgIG7KOCAgTogzyRAM7vYASDkITu8e4elt/N1OUhplJb4xYEuDLJRJ7lVbY0qdRc/FxMmfOSkoDdk59yhfVRVMnnj2wMiCmxzpW5wdhs3UfNU7mFrEdRGuGPVCg2XWBjkGYtqJsQziwOJlFpvCSzEQJuS6+RKnfMQVAb2cCQKrqpbvfejFZ18oBt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:20.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d332a6e-f073-40c9-704b-08df20b78bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999220
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

Attach the connector LUMINANCE property for MI0283QT displays and retain
the legacy backlight class interface only when DRM_LUMINANCE is disabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/tiny/Kconfig    | 2 +-
 drivers/gpu/drm/tiny/mi0283qt.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 778e450f381e0..fea8beb8b8ca3 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -175,7 +175,7 @@ config TINYDRM_MI0283QT
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  DRM driver for the Multi-Inno MI0283QT display panel
 	  If M is selected the module will be called mi0283qt.
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index b0121e89e2dc0..1414ae47dd079 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -325,6 +325,9 @@ static int mi0283qt_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &mi0283qt_connector_helper_funcs);
+	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
+	if (ret)
+		return ret;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
-- 
2.43.0

