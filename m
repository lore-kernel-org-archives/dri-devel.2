Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZmIk9NwW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126C1112623;
	Thu, 19 Nov 2026 15:55:11 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3FD1125E4;
 Thu, 19 Nov 2026 15:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWa+kvoLINOfdc9bGGGeHGBy0Oqdpm5cLMhFp5Xr3cb2Bn4Wv15b8Y5N/kCc0FBdI/mJNZBCVw1AE5ZQUN8VLtj65OM7i+W0t/xWbp6tCwZQNoFsgC4NAVzqh6XDACH21W03HQNBoiGSWw9BoLP8sdxRgN5qOJcBjeWCh3gVLHtWsVBAsYrbu2IfcFmp5/vth/55o/OWXicoEVRWNsJ9mlIgDarPGAD4/00wfyEYU+Zih0ClCrYD0bwspQiWG53/HAaIz8ixJn8jv17Y6UrRgKxAg5SaneTMDWAuBj5lXLYzUG7b4l/Dpr+i1VoVNmS6cG5M3Bhcyq4VYBiWYjETDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW4ONGPablWhGsBfeIbdELadQqxmAJVdT8roEI84HHQ=;
 b=hV3WI6oGisxf5GWmKJ7Jo1GCcD0V9YU6qHvHyT4qRkTGkOUB+voKS/HM+psE4WMAQdJNQLouBS3yFC7rWAmW1S6eHQa08EXsL6L1DYdtEUuQUqN5eXMh700hGABgEIo+2cpXuQd2sybI4Y7hNLa6vv0bmLhOUM7bOX0mZEE6dDSdEaAZAYbqocs6Bf6NPJY4GwEEaSK+HABxqOUzWxfGl97BhRBkKlJ1CDuZFj7MN5WfgwB8NaKXSIJGvoS02HCiNJySbOXfs2PfU1hq898vp27b4eqx7CrTao+NwRG54+M+YN1YeDGXXqy/d4/nGEv5+OVpj0sMjpA/hgKWy3/odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW4ONGPablWhGsBfeIbdELadQqxmAJVdT8roEI84HHQ=;
 b=ZmIk9NwWdQjEBKW2CPG+0NQtCmFfTswSNGpIyDypskE6OFkSMAk+507cwmwApVBLP2xdGAQhsgRj3qLUM+KEe1zNSfdpU7mZBemoaub2/O/Km8OhvCPf9oqVQauffu/NQ8AtLCBs+IPUvZLiHwQacGw+CMj5vukUZuAZ/hJpcmM=
Received: from DS3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::10) by
 CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 15:54:38 +0000
Received: from CY7PEPF000000E8.namprd04.prod.outlook.com
 (2603:10b6:8:45e:cafe::4) by DS3P221CA0007.outlook.office365.com
 (2603:10b6:8:45e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 19 Nov 2026 15:54:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000E8.mail.protection.outlook.com (10.167.247.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 15:54:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:36 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 09:54:36 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 1/4] drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
Date: Thu, 19 Nov 2026 10:54:24 -0500
Message-ID: <20261119155427.2494007-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155427.2494007-1-harry.wentland@amd.com>
References: <20261119155427.2494007-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E8:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: c769d002-9862-42f6-c089-08df465569f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|11063799006|56012099006|261021121427099003|10067099003|261009223027099003|261102123227099003|261009221227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rDDJKXwn6R+kJYHvU9x66T8WyoK/oVm1DcSuFY0ztDhV0kx0Oi1OS1jbDt1SgJFGbXK/aThqIc7QObLeyT9yOb+KzbpOOjim5cIQxZoYdYuvisdDzgpz+E/GtWXQzdqNZOk1OxJ9BA+sFDxmHnWNCRFLBA/ZjFP/g1QAP5znVBIc40rUrmxcsBzKvJaIy8bz5inTfAS7APk4UOdQFbyQOhx1Cj75cHe5X/ROE3iwuzyTpK5u3NgKPBa9oDcGAZJraO89PoKl28M/Bwp3C+Up/h4HX6wj/x3iUK97N4wM/dgb1iuPJROK9IbZNv4B1KmS0BL6itQV1BGajX0UqPY0MG/uz5yD5BJJhqy9Y0K7YKHnGxOrm/3xH1PLHgPLMvzaMoRwgq5deVZ2Kr8Eh6yiPCj/5P4p1gPxJUb+1zNUtjmpaHI4u+Kf3tAyvQ7MmvSm8No5iJ2e+JkNtO4O5H0EEPgR5y9u0yz0KTSUqvipff5gI6JfG+FEXO0GGsNXGilnUvLoo2xhyewnqbbTD724lUDOrIqBvq4xb9in/td6mWd+BPQ5DHVh1IZqNMGIwT0NlvuWHm4G68aoK+sm8Amv8e//d5uemSzuI9uheAYPzatKXyguHtOncjBbPVzz4d6UBfEXpme6iAInjvOWyUg8MvhYJSORqeAfHTcQEL9VBsoPK9h+fF8MxZLa+Xs8ktWrViTOhP/dXrdz3sFJ0jYrpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261009221227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wh/SQWTWn6UwiAykkPdzW0LzA3BBYWJBAzfhRhyKlWE3fDqUzIMSz6JBA0z3Ozh3ZOrDUJrhNpFAzCoUPcY0tKzbqhpab6DZYH6Q8ZUpM7JOT2rp29HB/cyuNRSsrqzEBX7F9W45T+WP8t+rAjPheBEpZEveIR7KLSMY0daI/Z4L2qt55dz1lWh5aFeSecTNLuPo0Xp9gTRSiV0Mk/Vmz0zzuxhIMkaXL5DWZ/BRQHLmEwPyWGrga+1q7edoUzfM3LWuCt3wtBjrjyGRzz4LWM5qjYx7s/pjvTG36Qo+/Z/0uKjZDEw+vI/GgajKxglWjBN1qbc2GOBM+wVEEcsgWsKV6LHd/2iqWHmThDSIPHdJVGHe2zwxvbvineZz9g/w/BJoq2nK77Gnq88NN50GXOd+rVCjMlrqqM70tkfONowOZcv3P1f8FT4+342/F17X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:54:37.2697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c769d002-9862-42f6-c089-08df465569f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000E8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

Add new 1D curve colorop types for the Gamma 2.4 and Gamma 2.6 power
functions and their inverses.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c |  4 ++++
 include/drm/drm_colorop.h     | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 682fcc651525..d62153fd9c71 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -79,6 +79,10 @@ static const char * const colorop_curve_1d_type_names[] = {
 	[DRM_COLOROP_1D_CURVE_BT2020_OETF] = "BT.2020 OETF",
 	[DRM_COLOROP_1D_CURVE_GAMMA22] = "Gamma 2.2",
 	[DRM_COLOROP_1D_CURVE_GAMMA22_INV] = "Gamma 2.2 Inverse",
+	[DRM_COLOROP_1D_CURVE_GAMMA24] = "Gamma 2.4",
+	[DRM_COLOROP_1D_CURVE_GAMMA24_INV] = "Gamma 2.4 Inverse",
+	[DRM_COLOROP_1D_CURVE_GAMMA26] = "Gamma 2.6",
+	[DRM_COLOROP_1D_CURVE_GAMMA26_INV] = "Gamma 2.6 Inverse",
 };
 
 static const struct drm_prop_enum_list drm_colorop_lut1d_interpolation_list[] = {
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 224fae40ed2b..5c4c763da83e 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -126,6 +126,45 @@ enum drm_colorop_curve_1d_type {
 	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA22
 	 */
 	DRM_COLOROP_1D_CURVE_GAMMA22_INV,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA24:
+	 *
+	 * enum string "Gamma 2.4"
+	 *
+	 * A gamma 2.4 power function. This applies a power curve with
+	 * gamma value of 2.4 to the input values.
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA24,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA24_INV:
+	 *
+	 * enum string "Gamma 2.4 Inverse"
+	 *
+	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA24
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA24_INV,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA26:
+	 *
+	 * enum string "Gamma 2.6"
+	 *
+	 * A gamma 2.6 power function. This applies a power curve with
+	 * gamma value of 2.6 to the input values.
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA26,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA26_INV:
+	 *
+	 * enum string "Gamma 2.6 Inverse"
+	 *
+	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA26
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA26_INV,
+
 	/**
 	 * @DRM_COLOROP_1D_CURVE_COUNT:
 	 *
-- 
2.56.1

