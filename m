Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA2BFED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19EE810E700;
	Tue, 17 Mar 2026 16:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sq0FZvEA";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3772E10E6EF;
 Tue, 17 Mar 2026 16:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRFRcxk8DTuYVxdTt8DEA4Z0B4EfoTbGH+hoX2Ts8xWnol7obtA5/yZoSylucvxqUorztZJ+pyZtGthhjJXiHNd/EzMTPkLwX/2zgb1KVZX4+PKQz6jE1kWktTYyxoAK74n5MNUbUpd2vEWDzpTOLfuXmeTgID1kACe0bo22wN1jFGVclS6X38Hh/nw0Dwp8w4vf0GGHCC9e5swKtQ4EBTcrX0PV8xe4idRveSkYe4V2M4EKbJrIK04TOZTWyoJCVFH0JggOquPdvzOzrJiCyWkOPfzmt76XqTO9+m1s4dXlZgKHG8qXY4daQIoxCeUlKL4micUGKeoH/v2Sn4Y6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOaRfrM45e97F0mGmk9xdqUGEehYHB3nuI/ymZL72v4=;
 b=FgKy9jOspyACf7Qnb018kbBsiv/6TDC1JaPz9CYJYCSDz7VPwKkCJSjSYPZ5VQQGRPvBjmTImcT/pxsPidHPTdSuSu8JDQstLfVn9aLRnRVDYugt5VygH/OMD3IZGVShSvD3lZZ+k6DbBMUp7qQxg7TEBsWkEZxNjUdDBgcX+x0UmPD5EUiwozwY8eUfXpsPLdWciW6lV4TwNR0zqtKBu2SM/00h7qujeF15rFtyERMo9td/SoDe8WOeXQUv+Rk5KAt0XXWy8UJk3IzWHsvU6+cv7eZ6wkiCb3pHsqQsfXW7EtvsLA5lAacCyX2mFERze9xDbxfVKUCeVtPiQX3CLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOaRfrM45e97F0mGmk9xdqUGEehYHB3nuI/ymZL72v4=;
 b=Sq0FZvEA5/B6W66FNapqNWrQZGkglTzqJXJpyvpwEi+vv5NXGtOq/2ZY5jEsQqIRsUSreJ0iXn+u/stwie7BxQ+XbUrIS0WpYPe3fVll4RrIP5hqkl1qiLWb2cFveaV3ROqnG1PK9hvkHN0la4SleSHo1toLWs9FNcuAtu6UyG4=
Received: from SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:04:20 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::3f) by SJ0PR03CA0156.outlook.office365.com
 (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Tue,
 17 Mar 2026 16:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:05 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:05 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 08/10] drm/amd/display: Check CSC colorop bypass before
 programming
Date: Tue, 17 Mar 2026 12:03:48 -0400
Message-ID: <20260317160350.229028-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: f99a36d6-aad3-4b14-1a58-08de843ed8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ei/9EO0nm/yC4yiI/J7eDHds/mAK4OIXAVwm7TUlLm/ROCQpgY+kMRaX1BMfvMRErUtQQGGt4X1EtTbALmi2Jh3A/SGrXpQrme0nKVqKOCylGITUXgGQBf887TS3EaDiYx+fDszbC8SerRSUrpJgI58FrVDLA5LHLviUlRtXFAEjC4zqrH10SBZlq3/oDP0bbeMFJQ5xu+XUxKXvvdJA29YG+WlRnL6ZUR1bqkKBd+V9OrWAdKB+LiXZlFJjs/ubK1TWOvkhfj8y4EM2xCakqHN6M8Nu7QHiZ2xRFr5kX90BuiHeFsSWeVrTumgV9bWlCtUc0VCJu6qT6LAxYX7Ct/jviXgS/Xnf0cZTm0uWVt2hYVEX24CNi1i15f+ZJTOZrCvzSlR0jbmdQL3lULgSkHgYZzSzd1jVJPtG9FTm7e0RfmeO+FGn9cXHWC+bvsfwdhxDSayqs4WNKcb0VX51O2kO2BEAv7DouS1qWVQJu8nYMyoOWG1yRKwSwiz0m1b5HkgiOmyb6L497uNSY7JWUBsmX27IKhs2MDyFNrbmD7tNXxYzzH68MhvpkEyuEhOMEazUPgNIkoJ3OKu83lTAOfi0PHs28jC5zGIlg524/fKHkOiYup8XwuhKi3yo2k1Aks1BSwIz9EMkPZ8usNdysh40dOexQbGpblv0FuyYUw/395Rb0utrLBthy0u6sY2OCxSplTYesXDZ/aWL+1Anw0PsTriymwMTu7hzro4B4F05nudzJ1C+nveQ6Vg2X3wx7RR+iftPXus42DCIrMohJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 76q3KLAmqDmYYbRudbDyHz6y7ogy7EDRBXgRpcgbGUUCLaJ37UxT816csqc4gu5tMHMqGNNNiFXBq0V/VIUWBHhCf/lUU97rQQ5MDalhC9boP+dOdKkn5OSpOz5jnsvTYEhTemmfaiUscZwzNbru36MYkfBCjs+4pD0ICLYcqzU9dEr76hv/a2+Ui1ele25OWKcqW34148H22BFPcphzqedSxs5nmtd5jbvv3V/qoDSSKmiAO3iT03r11LLQcxDatTBgbeI7Inui38s5KN/qRv8BdZzoUsNmhL7IxVEZnCF3gebOOJ5FLdlldn2HjtycZUWeSsSeHgUWkCmurUB9WuQunP0bh1NFISRk1iehD6EvqvcP6H7JuFTub1zgo/wzqFbaqDZ20Q1tPa6dKuWvfRXlzXXGNHW/jYak3Uc5TkwrURmkm5ifcD9+15KD1wH1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:19.4302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99a36d6-aad3-4b14-1a58-08de843ed8e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

The __set_dm_plane_colorop_csc() function was unconditionally
programming the CSC (color space conversion) even when the bypass
property was set. This meant that even when userspace set BYPASS=1,
the hardware would still use the CSC.

Add a check for colorop_state->bypass and reset dc_plane_state->color_space
to COLOR_SPACE_UNKNOWN when CSC is bypassed, properly indicating that no
YUV->RGB conversion should be performed by the hardware.

This matches the behavior of other colorops in the pipeline which
respect the bypass property.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 0d58eb45552d..79ca7e891244 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1931,6 +1931,12 @@ __set_dm_plane_colorop_csc(struct drm_plane_state *plane_state,
 	if (IS_ERR(colorop_state))
 		return PTR_ERR(colorop_state);
 
+	/* If CSC is in bypass, reset color_space to unknown (no conversion) */
+	if (colorop_state->bypass) {
+		dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
+		return 0;
+	}
+
 	encoding = colorop_state->color_encoding;
 	range = colorop_state->color_range;
 	full_range = (range == DRM_COLOR_YCBCR_FULL_RANGE);
-- 
2.53.0

