Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C001061B0A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7339910E230;
	Mon, 30 Mar 2026 15:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mooaXSHx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB9510E21E;
 Mon, 30 Mar 2026 15:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJbhXQRF/NLXIuH/4Jdmc+BvEODifSVndY/I8cMEW5RzW3Go4NPFExHynMYNHR0sgWSDMWvmDme3SwhkJm2QKptgP6kmxcTHRmgRJy17srewCR0B/TFuStuJZKgX665UAfuBIoMGOy7cbjiC76SxWnfqiY/W09P0gS0f62O1YfCcv6C8IFH6iIxtfgCnRTrM15DDG/M2wmGvaHZ4IrgkN9o3qjimw+R5tl3fWcQJMl3K0PTlD6qzPhkUmREdvTXo3Zr7ra7tmHn5UAxjbwC59stDPga2qiCMpKPdW4pUUxpy9K/QjnXcqvKe+uGvf4jibb9WNkKKVozZFtkEw29EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLWGYYJkFej8suCIPO25kSCNP02GuDS5GfbxGifw6Kw=;
 b=WkBfvFomKF++q8t5fhSE6a7fsQxJa8nTQJAIx36jgy/15rSqLQbwHzGEbhIKv0HjHPz+MkgdlqIt0OqcGySD99sv19m+Lj/ghgmvurg5Wet8EdxvIK9OiZVe6EEQ0SXYsdpaPyXF95QCIFbsc2H/Qq5U2j49tglg+MyTsfoPF20Y2tfqjaUbAirTU1GLyeBdc0v69Vz/D696bgVhlpjYm99BktgSo79IMSFrnAldhYltleS3UoC0qx7ct+WOdrfmYXwtKGpKbnRMsLYBxMkdyVQA+mEAiUxUK+MCNBaPNZwoD7kAt/Xmr2frLAaXT4CNMkxH6F9SeEeFyuaU8zgFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLWGYYJkFej8suCIPO25kSCNP02GuDS5GfbxGifw6Kw=;
 b=mooaXSHxACIa2jYMbAhgHNnBv/7W0fL4TXycxHdWZ/SGfrDq6Lk0J2KyRY4pKSMaUn2VUM8ERBJd+YiZAjbVRy1qsI8DzggkF1RhlpbcK97QYkkcmAMsXPfnfwrsDzLqLM+5ClvC6GO6chJQ60cZ1wNqByOYJDipitHTr4Wi8p4=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 15:34:57 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::39) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 10:34:56 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:56 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 2/9] drm/colorop: Add limited-range YUV-to-RGB CSC FF
 enum values
Date: Mon, 30 Mar 2026 11:34:44 -0400
Message-ID: <20260330153451.99472-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: d9450ed4-37a8-43b5-7781-08de8e71e5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zgxuZajRbVwXoS34AS8SCqnN0F99gltUKUQtZkr7GvJ9KYMdrjqRIvOKOlLVEAds4g3p+Akwb+3ZH9s9yhYTCt3JFuEjMCRvcLfNVq3Xe5o8mDhLQf8OFCCOOv2+1+2WoiqPio5+ACSySpjVG4yFxVsnU/n6dZ8rhLSewN2kcoanO/U12AsZ/m2IkiqPF4XIh2hHw6dT591NtH32LkQ2mIt2AtUnKLi08ak8gkdNZNneMl0CFAdAXxpx2hvVQyqcDDD1Q+PC0HcGWLNN7+OjGBrGYwrYGaYHSe59dNgNaig6HxyPvjFfLdhk73kmTkM1hEP1LTWLflHkJNjhhmpWegpC6TILHWMSSZHmvbRum8XwhWwQBPlNTEjf2+0BFKiBh2iNX+E4zSWOx111lRJ3qzB87XtI1yer+FJjElZcxXd7zIBD+VqB01+G0729SLriKUj8chZX854BxPIzKkXi98g5qJ17scglKjwMW1M4+9O1CvrMKHP+CgUIXdi0O/dnQDNyg3F/ZYc/TC9BJj3n+S3UF7/GpI9E3/h4LjZsdJcoFDWhpYikZlRjnyFtugTqgUU3PxKuhxLAFw+M8GG2fkGaduhchme35XgsV9uROH0qBMxL9hpdGf/NKjWeAjHr6eWtSKQmVI2w4U+M3QJ9TPxiIAZGrbOtSmHU1ig9cJYyMfBN1eQZa0wAtyhxjfaLsHlMjkCDy9UmCXAsY+oK07RLYaf1J88XqlyaBHj1Ufq7QoxbqY/B+1ncXD4OSFZWF2GgXmPcEdanXtMXfBomDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RAA4aXsbqrBkJzV3lhifJwGl/SmCOiRHjP2dAZR98djEkR1xbEEaik/T6re6+1zm6qtmGN07uKDk6iwayHwkIGgrrp7xLnugu2ZtyTMJICSltnfTWwk5M9fu4F9qPTfNaS+SHPrcRvp+JHGTMnD6Sp5W/DQFo1xDZfNUL/ACitHxZywvpQuwmk5qadJ7pJz5ANPMp568wBjpb49hd2W7y97wstegDjUf/HcTIAfhslXlKebgk/mD9BAqAlYYuUhHT4Qi4PhL1jXnbQJqIX7bd/v01bXp6GMTg3DVzh4fz1PPqMVXqW1tGvDSPbdXwWoZ/5DAh5EMcSQIoH0NgDRapInCn3tOzj/ZwxbKiW62jAK5GZzwR4mI5NQCev+ujFJvF2B8hvt8idDJO3EgoArH+RpAFgbKRnSrtznBLbWko6lEP8fVsnKmzvG8Hq8fKrrA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:57.2821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9450ed4-37a8-43b5-7781-08de8e71e5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

Add three new limited-range YUV-to-RGB conversion presets to the
CSC Fixed-Function colorop enum:

  - DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601
  - DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709
  - DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020

The existing full-range enums (YUV601_RGB601, YUV709_RGB709,
YUV2020_RGB2020) are kept as-is. The limited-range variants are
inserted after their corresponding full-range entries.

This gives drivers the ability to advertise support for both full
and limited range YCbCr framebuffers via the color pipeline,
replacing the need for separate COLOR_ENCODING and COLOR_RANGE
properties on the CSC colorop.

Assisted-by Claude:claude-opus-4.6

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 11 +++++----
 include/drm/drm_colorop.h     | 42 ++++++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 6a345e2e8b15..f0d11cf7e3cd 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -92,10 +92,13 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 };
 
 static const char * const colorop_csc_ff_type_names[] = {
-	[DRM_COLOROP_CSC_FF_YUV601_RGB601]   = "YUV601 to RGB601",
-	[DRM_COLOROP_CSC_FF_YUV709_RGB709]   = "YUV709 to RGB709",
-	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020] = "YUV2020 to RGB2020",
-	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]  = "RGB709 to RGB2020",
+	[DRM_COLOROP_CSC_FF_YUV601_RGB601]           = "YUV601 to RGB601",
+	[DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601]    = "YUV601 Limited to RGB601",
+	[DRM_COLOROP_CSC_FF_YUV709_RGB709]            = "YUV709 to RGB709",
+	[DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709]    = "YUV709 Limited to RGB709",
+	[DRM_COLOROP_CSC_FF_YUV2020_RGB2020]          = "YUV2020 to RGB2020",
+	[DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020]  = "YUV2020 Limited to RGB2020",
+	[DRM_COLOROP_CSC_FF_RGB709_RGB2020]           = "RGB709 to RGB2020",
 };
 
 /* Init Helpers */
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 2cd8e0779c2a..c414b9070afb 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -145,31 +145,61 @@ enum drm_colorop_csc_ff_type {
 	 *
 	 * enum string "YUV601 to RGB601"
 	 *
-	 * Selects the fixed-function CSC preset that converts YUV
-	 * (BT.601) colorimetry to RGB (BT.601).
+	 * Selects the fixed-function CSC preset that converts full-range
+	 * YUV (BT.601) colorimetry to RGB (BT.601).
 	 */
 	DRM_COLOROP_CSC_FF_YUV601_RGB601,
 
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
+	 *
+	 * enum string "YUV601 Limited to RGB601"
+	 *
+	 * Selects the fixed-function CSC preset that converts limited-range
+	 * YUV (BT.601) colorimetry to RGB (BT.601).
+	 */
+	DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601,
+
 	/**
 	 * @DRM_COLOROP_CSC_FF_YUV709_RGB709:
 	 *
 	 * enum string "YUV709 to RGB709"
 	 *
-	 * Selects the fixed-function CSC preset that converts YUV
-	 * (BT.709) colorimetry to RGB (BT.709).
+	 * Selects the fixed-function CSC preset that converts full-range
+	 * YUV (BT.709) colorimetry to RGB (BT.709).
 	 */
 	DRM_COLOROP_CSC_FF_YUV709_RGB709,
 
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
+	 *
+	 * enum string "YUV709 Limited to RGB709"
+	 *
+	 * Selects the fixed-function CSC preset that converts limited-range
+	 * YUV (BT.709) colorimetry to RGB (BT.709).
+	 */
+	DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709,
+
 	/**
 	 * @DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
 	 *
 	 * enum string "YUV2020 to RGB2020"
 	 *
-	 * Selects the fixed-function CSC preset that converts YUV
-	 * (BT.2020) colorimetry to RGB (BT.2020).
+	 * Selects the fixed-function CSC preset that converts full-range
+	 * YUV (BT.2020) colorimetry to RGB (BT.2020).
 	 */
 	DRM_COLOROP_CSC_FF_YUV2020_RGB2020,
 
+	/**
+	 * @DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
+	 *
+	 * enum string "YUV2020 Limited to RGB2020"
+	 *
+	 * Selects the fixed-function CSC preset that converts limited-range
+	 * YUV (BT.2020) colorimetry to RGB (BT.2020).
+	 */
+	DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020,
+
 	/**
 	 * @DRM_COLOROP_CSC_FF_RGB709_RGB2020:
 	 *
-- 
2.53.0

