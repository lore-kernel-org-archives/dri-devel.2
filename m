Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29F606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OMi0cSkc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC9010F895;
	Tue,  3 Nov 2026 21:38:25 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F0910F87A;
 Tue,  3 Nov 2026 21:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+nHIwcC673gNGgEkARoyDmAlEmR+HLL4JzLfRO4KuvnW7TV9RHMIxdbKVXWE+uxjGepyjbCZSOd2G63G1hbQqswNv9CynrLZvUeOCo1rw4LZ1q8MExhl97ObKZIUVtT5dnBW0hPwC+QIlFvGJBzlpS/fs3BaystDM+I0chCC95UMqt9ErJestva76DrxqgQ3Q8WsXUVhRw/jeOq9NfA7MDmLjJjDQrIK3OkslJO56mOlq0PvPCV90h8PHr+S9Xrtn2GhnF9HXWFnG/jMuy8MXqQ89nP5j5BuTtmKJipHacJ65Hh21kCb62MeRffrmJkeTXMOfPgGVU85NTpYScdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znDRqdgTtT//oMSutJmR0JPoaac1nW5mh/SgSL3/lsk=;
 b=y4AJMfKLzI400ZBQvYQOCzoFnJDVuTsejcHWBleyj6kXLFi6FPRwIaGvUeknsuHdTL8LslSvlzz4lPEasBIKIa+9yArhlga5ft9OSvKmEyCC1zV8Osp7g2kGlBXRvURNlY9fkSSUs6wZ71u9b9mlAcnE5T5q2ssWklIlPsLQlMfoZ5068vrLHzaFywppo82Pa5XSG+oIn5nY8xbWG+Z7IWT3UCKe6MbW97SU050NxFkRoJM8iJqAHYOrEAXYb7IXPxNNMrd6ffKi36uNU6KsLOfFzgbJEhkYPEjKEB3itzU0EVWm4uPvvLRXERwXRO6im1325djKQgwwcxKMBQ5Bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znDRqdgTtT//oMSutJmR0JPoaac1nW5mh/SgSL3/lsk=;
 b=OMi0cSkc97FQ660Rhf+7ATf6GWlWzenf8gwVT20hgR0itSBwTUcF5qSKylIQwFLz6ewgMin57ycwoAxjdrfFD4drV4r+DkyZFVIJOg3trlCGGFLAwoGGXYzaBTEEyI3CCJlLwH3dyO3ih9IjUXK/XvJmtTdQWUy5qUgWOVIxouY=
Received: from BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:10 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::99) by BLAPR03CA0134.outlook.office365.com
 (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:07 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 10/13] drm/amd/display: add 3D LUT DMA pitch alignment cap
Date: Tue, 3 Nov 2026 16:37:53 -0500
Message-ID: <20261103213756.618024-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 56877019-15ce-494c-550f-08df39f2c184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|261102123227099003|56012099006|261022105027099003|261021121427099003|261026140227099003|261009223027099003|261028144727099003|11063799006|261021123027099003;
X-Microsoft-Antispam-Message-Info: Sql/02OPNN1WSMCSw9vG0Mhocm9Oq5ApMU2DAFCrXdUMJaVOU/vEh5rSQ08Vm3kFB2vB+lHaSS+YUOwT6qc477l7AAfiqybYwFIK+r4DDwQpVwZ+ndLwr9aInf+eLlPY58tsW8mCLS+X6V2DLdGaeLN6vp9vKhpw1DtpkUlMbEBpyJlZgnLCUf3IIRU/+AbaZqyV8NeIk7XrO57gWwdCREK0ZOLlqC3HpQ4o8Hig2fCCCz+5ba8bF1wvVoE0ac8dFamRAV8cjfviIDppCitsatO1AC+tCVwdhCFnJPGR8MHWh8WBSkiX9Ko+fblFEMTkK2VqCSIIqMNlgcpeWfwGL+psFlkuXJwR9gimfuYz/RXIFgahjHVXjB3eJ0rA5Ac/DLy2sYGbQTHOO81SQturTJ0+kyEywL6hSWy2A5ACtEGOj3TCH4St8UNa3Hw3W+MBy3NeseQRdL9JSfUlZYqMf3ddxfuDt93eZLd19HWG3PCJNqMqG/nSXTdOESPKl4wCn1AUsh/lG7RuFP5SSpfLu3Aa18fAcrJRUqxGmiwvfVS8TRmNutHYPBHX6oSlJpJZ4a20+2Via1mwXKzAE6zVaEGefmwx/pE6yBu/9I3UN2ytZubzbIJc0ZmAnE3sBE6ebvEjQTpuniPi6qD1ueSjSitHxBVsjAS7MLEsjgParaYSv2I8C+pIndg4eOuTWnLOzyaLTPt9W/VzWOyhJOM2lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261028144727099003)(11063799006)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4BhLw2NugxVtfG57EB4tViysOhIHe6uxvkN4STRlR0fF8fsGDwBnpOAIi0f2vm7D7fw3pkKymOnuH+rfPGlVSinDsta15fFxvpDHEIOyImMftUcJr/ONs12XTzcVyuQUdhLT3d3M9B6dMVuO3T7T6XHMISDRJnIF9OGhDeUowx5LTvsXDF6gvbUWRtygvg/ar54gNoR8negffgH0JvUb4g2NWayqjJQV19UPovyneuX1cG7vlWbaVKIBhOFnEAToekEHUE8yAp6beduPYxlxlqBnKjH/OGCxWW9IDbsoi8s9FMCoWSS2qrwsn6Ix4mqBA7N5Eo3Ud7l7JnF/fO8WIHnzEkSRhktKvCoD9xLuuQzzBGepMLolGISfg9bJwJ8QvRf4094ey6uM74nVN+xKV5hlh/FxIMqwcYU39LVt5FvmZIWZO3pyKy5/fntNzfby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:10.1015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56877019-15ce-494c-550f-08df39f2c184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rows of a DMA-fetched 3D LUT in the 3D swizzle layouts must be aligned
to 256 bytes when paired with gfx11 and to 128 bytes when paired with
gfx12, as modeled by the DML 3D LUT pitch calculation. DM needs this to
advertise the framebuffer pitch it expects for a DMA 3D LUT.

Add a pitch_alignment field to struct lut3d_caps and populate it for the
ASICs that support DMA 3D LUTs: 128 bytes for DCN401, which is paired
with gfx12, and 256 bytes for DCN42 and DCN42B, which are paired with
gfx11.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                             | 2 ++
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c  | 2 ++
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..e82db13687bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -297,6 +297,8 @@ struct lut3d_caps {
 		uint32_t dim_45 : 1; /* 3D LUT support for 45x45x45 */
 		uint32_t dim_65 : 1; /* 3D LUT support for 65x65x65 */
 	} lut_dim_caps;
+	/*< DMA row pitch alignment in bytes for the 3D swizzle layouts */
+	uint32_t pitch_alignment;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index e5e94e955157..a1fbe89a32bb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2129,6 +2129,7 @@ static bool dcn42_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
 	dc->caps.color.mpc.mcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.pitch_alignment = 256;
 	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_9 = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
@@ -2140,6 +2141,7 @@ static bool dcn42_resource_construct(
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.pitch_alignment = 256;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index e111e7532383..4e91c908a948 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -2095,6 +2095,7 @@ static bool dcn42b_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 	dc->caps.color.mpc.preblend = true;
 	dc->caps.color.mpc.mcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.pitch_alignment = 256;
 	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_9 = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
@@ -2106,6 +2107,7 @@ static bool dcn42b_resource_construct(
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
 	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.pitch_alignment = 256;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33 = 1;
 	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
-- 
2.56.0

