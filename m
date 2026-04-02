Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E7D6AB01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 20:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6414B10E535;
	Thu,  2 Apr 2026 20:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZwQBxTK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F351910E535
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 20:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxxUEv9mb8iIC4lrjEEnDjgs3OFP+JNn15UaPCs8AzE91VnHKXNAAUzWW/hBhw+akkzw56JMtaBGOKXAWXrIKRW7BGQJpRswqA1EHD9UF7DInwyhh4MYxnPR2AP6nAuv9ldluNdJFmeMJktt6vvDAgXQTT0c4IQy0AmdtPdteZUzC4gJtNLlG5DdMn50f4Jov3vI67gjpLwQct4C1rpcE+UtdZRIZhadE2StIWCW3BsZa2dIEIPnFCGf2nW4b45KGVzQkWHVMKugVOvWV6F8QBRZmC8ip8v9oqh6U3P3Hbaa9jBGLvw5PYAskKTMTcM1WIk8sDt6/mKTM5TVKYE6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJgkJs17G0k4haAPnXB85fSYR48gt3wTV4uNGoVZ/hk=;
 b=JYp30JZCo1v57VAA3720v21jgL/XllrnrhbJYqqk/j15Kdh6K8p7LxRg7/5nFyEVzsyBhn1KM8r3ewmaKrgwFmTrEyliJYAuuDqL4sWHDjCBTSarpHCWsy7bEXFHp0WkpJYocvj8SqlX8Evl5q+DBQDfHbrmAks+ZoIrICe7SBPy/dS+f9ktvfcfc3i1bUT4BEpr5jyGbREVzXvvTbfRgJuJMLsRqqE8bgMqSdTl+xCMh+UUhlBlLF2KwRqxbAblxXPuRsKXpJZxfUOmmxMiw1AQbOFYnXLZr45kfbtGlkOTzjwjw57gj91ItsK/SxOLBY2FjMtdQAKwO5rzbPN1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJgkJs17G0k4haAPnXB85fSYR48gt3wTV4uNGoVZ/hk=;
 b=sZwQBxTKZrD8pxY4CCYzlMCxEYULqMLMhX8qsQOXOhywRHfrSUcklfVUSCo7gdTFrOd3eMvEt70y23/55JItGXLeOXqPH5ip7iYSbOTBx+jl/5o/1civdUhNqs8M5XITTIDjTUGulmGSwZREm91MwlcXYOR/bsYTBl+4nUNfqCk=
Received: from PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::15)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 20:16:01 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::77) by PH8P220CA0009.outlook.office365.com
 (2603:10b6:510:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 20:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:16:00 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:15:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <contact@emersion.fr>, <harry.wentland@amd.com>, <mwen@igalia.com>,
 <sebastian.wick@redhat.com>, <alex.hung@amd.com>, <daniels@collabora.com>,
 <chaitanya.kumar.borah@intel.com>, <pekka.paalanen@collabora.com>,
 <xaver.hugl@kde.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/colorop: Remove read-only comments from interpolation
 fields
Date: Thu, 2 Apr 2026 14:15:14 -0600
Message-ID: <20260402201514.1430606-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cad75d-f35d-4270-5902-08de90f4a861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5Myqp+2AqYjVfbdouDRQXyTkMy8Kpk2wkBbSWDurf9d3jnCBjFZ4JE3Yy42c9WGyM50MmPnKqGraInir2VAZz4xH3wb2EfAAimVtbvW2P852vSEWvpYciONl1Kop8VGeLnHsGKJ/PbkdGCYbsYjQO5VrDDVpSG4K0s9RtMcQ3Rq6tgT+EuP/Z6FmeCfr6g0K54HXsMFeVi748KGstpl24qP1QPtWOdsq43EYl7sPODn+Cn6EiaO3mMi+EgTDKcNVJcv9oUq3GRpyDMQvCebmaoClNHzpqtYv1g/CE4h1OknJYzrzQ/Q8MMkqfp+1+ZNMg+FfUbuKYtmGHZgCbqRYBRQFphEhzqELiabi8rTNppraR2AJlG0I/KgC0pQr0rcm/A1dk56D71QjOPTnSXcV6PjOBt1EOBYhqRj2UvXldw7jPbh5p1BOWOodZmp4s+fHJNazuwHhjuHB1kphIMUkbUdDLn0eKZ55/pU7JJg9V3w9RtpePbUBouvBZYCtVK71h1rgJR+W4Xf3ywz4k+8zBMvPhWVpZSLerrWS4pNtD+Uz20nReAyYcO+FBYeGnzmB2VWbTHZvwqUs95Zn43afG0U6HkJu3UVY6PXxDHPITGVaXMkCFil8cT/46qBCorKrLjVXmqxzr3wzwGBISOXohVWTeldrmZlGH7+Y0mAN2UpWy2363C/9XYhPn1h2fPHAAdV2HZCaVIa7MQiXyGUuzXNvn5/d5xwQJAAgXOZPmksV7cXs2Q22kDbePXdCmz32U9l8FMc8e3je3jMqwUKkgLGNVo3j6YVwPxh/twvuVYqjwwRgIOaAcy7defSTKhMK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 47gbzgp/+sInj73CJNVzu2ne9GbpNDzp9D4TKddEPZh2UQBRnS1hpRa3YQQDi9C5fqprIELzAmkM3mqsNBXOF6ogO91qSvzS448QlaRrztYtPA3wOOgPYOVlgeQnp7CNZmwNbkvOI9dTbi6wtoyJoQSOVBzUq91CZqCztFTK0oadMJZrpA0kqs6MiijKr6w8lmChdiQ48AC9siAdujfsK35/8CoR+su3Qo6cwqmjkJ3ajnsB19clGtLZpb4whpPFBU4gtSX0AlTvXN7STHA0e4DLJw0AdTmGakiA+hOdn93yLVQjFHwqhb+gH2xD1uBW83kD93EC3pU0QFl/q/SkbJOhc04GmF+k3Cvze2juz2vfe7FV+5mXz1RI+4NfQsEyqfg24N9gfbsYOv+oJ6RO5rCyjMUN/hkNyZHncRXoCUUhArNZKuMSF6CmKsVCRRme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:16:00.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cad75d-f35d-4270-5902-08de90f4a861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

The lut1d_interpolation and lut3d_interpolation fields and their
associated properties were marked as read-only, but userspace
can set them via drm_atomic_colorop_set_property().

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 include/drm/drm_colorop.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index a3a32f9f918c..5bcb510e56c0 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -296,7 +296,6 @@ struct drm_colorop {
 	/**
 	 * @lut1d_interpolation:
 	 *
-	 * Read-only
 	 * Interpolation for DRM_COLOROP_1D_LUT
 	 */
 	enum drm_colorop_lut1d_interpolation_type lut1d_interpolation;
@@ -304,7 +303,6 @@ struct drm_colorop {
 	/**
 	 * @lut3d_interpolation:
 	 *
-	 * Read-only
 	 * Interpolation for DRM_COLOROP_3D_LUT
 	 */
 	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
@@ -312,7 +310,7 @@ struct drm_colorop {
 	/**
 	 * @lut1d_interpolation_property:
 	 *
-	 * Read-only property for DRM_COLOROP_1D_LUT interpolation
+	 * Property for DRM_COLOROP_1D_LUT interpolation
 	 */
 	struct drm_property *lut1d_interpolation_property;
 
@@ -340,7 +338,7 @@ struct drm_colorop {
 	/**
 	 * @lut3d_interpolation_property:
 	 *
-	 * Read-only property for DRM_COLOROP_3D_LUT interpolation
+	 * Property for DRM_COLOROP_3D_LUT interpolation
 	 */
 	struct drm_property *lut3d_interpolation_property;
 
-- 
2.43.0

