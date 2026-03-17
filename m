Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2AFED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DFD10E6E5;
	Tue, 17 Mar 2026 16:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fF8EHv6s";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2067310E587;
 Tue, 17 Mar 2026 16:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nbd+c5vUStHz0NLkDwnNYHXLyxzziWJC1effRcTLeLTPPro1RcXL00T5M1bebx2aSTnVd8af0NGPTWiBs3WPCFhv+NpE9W1+UNtHj1SUHwptafDkToRkseh41iIUXAKx18zVsgi77MzQIfKJsVMoTK+nCRiXNWAAsfvs52iXdIifgneGy0C9FekcVtoJZFLHQHQT/PYOOwIGw/0WTZwYDtXQF9cbjc+mHIEPdFTeDAtE7MCUsMVkhQpxDLUaYbhCUX6mQ/7uNNUYh0Qp/6TcuNIKFixmZzEohhuhUg/nBgZqYd/r1NajZGGk3rJaNaN/IZv5CRWOo/hCE352RhK4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okAuU18+4ZxwPhu6EqnfVUc3BjPDIunyyoKaL3C/vgk=;
 b=RZkL0hOYpElpqJcrpPxQamcpUhf0K40x3Wqgd0Cmki5k7Mu1WPOssuEPZY1g1E22XA6yn6Hdq7Xih0VKdD258E4XvDT1GobUFTrebAAl4EqUBzub5i8qW3HOkntXxz0a3Brgv/zTEy+4z0OzaZL6r58vA3TZQ/jvhtG40n0rigvlg1QFRggyNFdfEjmUoH9WSNpHmKbmW2JLuY4Tr0QyMZzqudsZQaTQvTD+BFz1oVSOWm2l/iV7CIs3OOWlCnSuolAPCfpQ2SgspnOYdmSO51hLeTMH/BVE/wbXJ9QcB9hbgNIwtL2CXSfiEofrHwroFszfEQdK+La7a66KxN+b6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okAuU18+4ZxwPhu6EqnfVUc3BjPDIunyyoKaL3C/vgk=;
 b=fF8EHv6sBgQrwXahv6WilRrnZ8cYEq4yo1oHLuIsl1yipOR0GmjvIXH/LgsjPnSUKPLMfaJGgPHE9Ru7ao5ONPaYRMnAr+2Om8aVwG5ndDF78rmnjrPpGnq0bXPqKD6H6KEuIbSSBD603dieIHoFrauESvYrbjhGKP4co5aLJao=
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:17 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::e7) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 16:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:03 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:03 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 05/10] drm/vkms: Add atomic check and matrix handling for
 CSC colorop
Date: Tue, 17 Mar 2026 12:03:45 -0400
Message-ID: <20260317160350.229028-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: 846054ac-0436-4764-605d-08de843ed6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qI9jKRJUHHKtMYTb8tFQYzpoIXGThT38bj8t/PxokCBrw1dXNytCecuP3rATsuql3JfJsLUilPC/krobJQqZkt5+ojb1aqVRozze9jWvHOtl8SffESjAd2c0PDZz8n0fh0XZ0RTmX48G3puObez/HQxlq3ldg7W/iwFdjq/xs17I0G90/wyCTD8R3qvWlFAEVvsZSh4ASOmBNAJ7Q7a0fAVwr0oPv6hE3nPbrN9Kq2aYmfnbKsf0PyGkcJHc4mW79bJG7b1dWfvcD2t1d1sxase7PUm6XD3rrOTNLszaCd84TI8bmkE2cgCJE4PDDOhhPrijIsM4XVKg3pNPX8gxdUYTNrZkGbj9DJJkVhQOzYVHA9ytnrLNSefgWdtvUaSawVNj39DAMt3FbZaqKckGUjeU6Bzuvm7YVsX9pYWqloynmofsWBZ2CfvqnciZpumKN6s+OIuAyMUQ86vv9HbUc6FNMVWD6OIrVVGqEoiUMQrUh1CqPsQFxFxh+OOY2pxnihuhRWw5aFwNWawtaEyjMhfczI7KPPt9aC0JLelVBPM6r3cj3jcAU7BguMv0shQn3fjFm/kHkeuu01t9KzZSabRO3V1NrOeXzFu6aWGUeYEzhDgFENIX47vSpJEtb1OzzNgyAt4IYqv7CJ4v36IkD+5E7mvPVC8PI2z9l4x0LL/DhZtFw/KZSqJJ0a6m8tIDylsZ6zOkH08IpbaWUJMNwo0kl7YDjqDPTIRiec6Ma66SMZSYm0b+i4M75NfZxDpLk0qX8CApbhg2752KLuuTxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vdjD9/jGgtIB3W1smx0SwGCzffBzOHihtJ2gAzlrD/hVKmTgxBKDnx0G8dN6v9JxMCtpW4ZDLMlvYCNOPKL7xhPeSaBGoVF0KamIW1GLDGDXT97UY5L8lhUvjbwMWuXwF027qhVKKmyUimyp37tA61IdPFyjrzftWNaogDPzTIKHLKNI7cxkKpfB2OI1iHNlZAUMnb8MaUMUCDSFn9sJ0SUHn4Z2uue+rdU+MvgnL5ZQhMEMUVjhPmzRyBM7STGWOMUlsktZ/9visIXA5ya5DPzKVp7hv5evJQoQ/WfC+SK7cJi+RQp9kqeNt1stsX0Hfe4rR8t7SbjHxueJGkL5NTC4f+nbkvxbvLnSF4KHqhssdcAgmgSrmJ/DdC0+3unvfwcTg+mxGRUkK5Cm7NsO9cvKGEatEBhZfbs4L9mcTW30TKy4LIyALfHfM0J1ZKsP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:15.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846054ac-0436-4764-605d-08de843ed6d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
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

Add validation in atomic_check to ensure YUV formats are used with
an active (non-bypassed) CSC colorop as the first colorop in the
pipeline.

Update atomic_update to set the YUV conversion matrix based on the
CSC colorop's color_encoding and color_range properties when using
the color pipeline. Falls back to legacy COLOR_ENCODING/COLOR_RANGE
plane properties when not using color pipeline.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 50 +++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index ca7aee101a95..0be6ec813b4c 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -6,10 +6,12 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
+#include <drm/drm_colorop.h>
 
 #include "vkms_drv.h"
 #include "vkms_formats.h"
@@ -148,8 +150,27 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
-	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
-					  &vkms_plane_state->conversion_matrix);
+
+	if (!new_state->color_pipeline) {
+		get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding,
+						  new_state->color_range,
+						  &vkms_plane_state->conversion_matrix);
+	} else {
+		struct drm_colorop *colorop = new_state->color_pipeline;
+		struct drm_colorop_state *colorop_state = NULL;
+
+		if (colorop && colorop->type == DRM_COLOROP_CSC) {
+			colorop_state = drm_atomic_get_new_colorop_state(state,
+									  colorop);
+		}
+
+		if (colorop_state && !colorop_state->bypass) {
+			get_conversion_matrix_to_argb_u16(fmt,
+							  colorop_state->color_encoding,
+							  colorop_state->color_range,
+							  &vkms_plane_state->conversion_matrix);
+		}
+	}
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,
@@ -175,6 +196,31 @@ static int vkms_plane_atomic_check(struct drm_plane *plane,
 	if (ret != 0)
 		return ret;
 
+	if (new_plane_state->color_pipeline) {
+		const struct drm_format_info *info = new_plane_state->fb->format;
+
+		if (info->is_yuv) {
+			struct drm_colorop *colorop = new_plane_state->color_pipeline;
+			struct drm_colorop_state *colorop_state = NULL;
+
+			if (!colorop || colorop->type != DRM_COLOROP_CSC) {
+				DRM_DEBUG_ATOMIC("YUV format requires CSC as first colorop\n");
+				return -EINVAL;
+			}
+
+			colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+			if (!colorop_state) {
+				DRM_DEBUG_ATOMIC("Failed to get CSC colorop state\n");
+				return -EINVAL;
+			}
+
+			if (colorop_state->bypass) {
+				DRM_DEBUG_ATOMIC("YUV format requires active CSC colorop (not bypassed)\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.53.0

