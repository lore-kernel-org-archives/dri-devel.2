Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9FDC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C362310F75A;
	Fri, 14 Aug 2026 21:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvxLzFKd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A9D10F740;
 Fri, 14 Aug 2026 21:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqRlHkhmOIoU+C3B/tOtiSyBm3DNvAZhpV0LEgnilkA+EQsTS5oYed9FVbP7mT+5CqqV+ZsybtsWJHBPOt+qSDhXd8pk+QbmLzt3MNVTo09HzZSfwQdoYsuhbFd3skPHBlGQku7NV9SWR9ab5/U0AQlR1drZl/AV6KMPY8sXC98ZHYr0oEzCxoPRh1pwKpXxkB7FMdRzkexKZ3Zc4kLXifbbP1t+ObDpX1N4IybKL99mGh/AGomZogMlloZ/eXA9iUsiRbs2f0V5uNQalFQ1o7pt/KHJ5FQjLTuv3TcT51DC2on1e0IOR/QJH8BMMNjrs6Re1cOzBxh43ua2pFiKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3F/jgbWDN3HjfAXofb3UKWvr06uQbjYF00rLn5MVHU=;
 b=U4UIRR6DXbjSlpGw4R3uENRJPRi07wzFqZVZieN57AEy23N8Hsxv5x1QphO9N9rmiNR8zanK8CWNwvF45pJa7ftwgqrzAi5Rx22xcumMNw2TIr7u2zzCfjaB/Fi9hF3gqDgazpr+MqDs3qI6pD4THB9dWeQhLMPzbrAmmi53stGM6fs9NDlM1XTdKYK2CsuwqGE/fyHaZYzSbQwzGkqIpMkcdJUw2TzxpZmoffl7J9mmtH2T7ptEqZIjKV6XqQb8NA6mj2Vq2Mcio1sw+Ls+dk4DTN7DkqKC8/3j0JuFE1TvFQ8FTh8X+O9OSB5nnElwlARYgNyPggxj5+uF1DRuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3F/jgbWDN3HjfAXofb3UKWvr06uQbjYF00rLn5MVHU=;
 b=QvxLzFKdsSHbdUHk1p/3XQOefXa8szJ4ClF95uz0sAlOzyZEDdLUkY+W2A7PGjsq7QQLepQwXfbofcQmyH/SeW5WXob7sOh3wtPfGVrukowg2d1LFjQqxBCEQq6+Zf67+nujgaqXp/Va/Zs2cdaGeSxVpEsxobjych0SiSKpN2c=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:23 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::63) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 07/10] drm/amd/display: Use GAMCOR for first TF if YUV
 conversion is needed
Date: Fri, 14 Aug 2026 17:18:13 -0400
Message-ID: <20260814211816.1219597-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2fc886-c7c9-4551-4698-08defa49926c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uXbwS1N3lbWgpjV+ubs0GcBU/nzD15oDAQeUJsJ67h5Hu4iwI18qZMdsHQmKczqzjJn7d32c4b9RIMd0nQB5w3FfQeFgHdA2KIF5YNc8o2Gi6t1UuTAj93Dsqd0cYb7d+XqV37e9KMcCdUGlzZ46Lf/ImAQgXUjKS0Ok9kQI3y0BV6c2i3TP63yQ1dfmwJzBMan7Ha0MCONnq0DJJ0Kept1apRc70oneyLIAUrR/Cls9ZIGzkdimEzkSfRJOwYUZVAajF3VgVWFie00N/wkpHMLlUCqE7maH8RVxX/9p8OlkSdx+0fCtVV48YOHW447/EP3rHYyHdN/QXII/ElxCvCYEsR+wpvYFvbFFMwcD+NekpGYzlm5UlEHXZ1THS39WBw2hbRN8shLDtHBDO1jQY8IJYc1QhLcrBDfX1uc3ExDRXJ/ZDSMo2ImvYOTB+78CiYCZ6QIxxQy/X3kwL9+6rMDhdP7PDOIc6s6EyeuiGAQiOkWsO+N64MnKH0yS8nr0EXjAyNs99EH7D1o3PV0L4wRo937rf7V9/3C2WKpWiJZt/nhQi+2MmvdCSrtZpaIKvJNI4oS4ydM4Z12cQYPUhs+hJtLsCcJ2HAxKdKYQpJ9HFC7i6asTByuOcBfVMBo82GoraQpkSWwmxKNFkHN8tUIaqLtGqOWkIqoQfpJ2e5VVW7l8lai1Nw9xlBqPIQ/2jnXQ+Nd5a816twSN1Ef4nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IhIvg7CGBO59323FXw2Lz3GAKDiib9g45nNzH1V81gM/Nmt0EkcrBMuS6yCJ3oFjLBp+Kdj9oGqslXgS5q6yiO0WKSa9J8VDUxhYm+DJ0EY7GOmuDsIGyqq8+2+5uzCk1LRfDQ7qteFcQQVh7tWuE5LdjElsQRGVj5es40vzZpZp7t/9QOrkfNYYJDBZ1fh0WY6sX5sMnqJYhWHmGdK4vxDfds/AB48dAAc2aTT8OafUkio6I5chj0Hpas1ifAl6+5SL6Ed4PPIl38utvUkkqiLazicP96DVg1WEnqpMbWQuAP1awm1Hd5d74WZ2g2ZQNolWfa0pv1j4FI0X0/4Imf93I7vYIsrkOfHApkzS7aU99RM2Fnc4ahuHiBAuc/LmtO0LxmnkO2z0gUptkAniFEBH1SJphUMBcdmhcRk3n22h0HXNLfbnS9lGRNJsmaJG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:22.8771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2fc886-c7c9-4551-4698-08defa49926c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

For subsampled formats we need to use GAMCOR instead of
the DEGAM block. The color module can create a LUT for
that if we set map_user_ramp to true. So do that when
we have subsampled formats.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 62791077ceef..8913bc9f0f06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1524,6 +1524,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
 	struct drm_colorop *colorop = colorop_state->colorop;
 	struct drm_device *drm = colorop->dev;
+	struct dc_color_caps *color_caps = NULL;
+	bool is_subsampled_format;
 
 	if (colorop->type != DRM_COLOROP_1D_CURVE)
 		return -EINVAL;
@@ -1537,10 +1539,23 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	}
 
 	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
-
 	tf->type = TF_TYPE_PREDEFINED;
+
+	/* Check if format requires post-scale color processing (subsampled formats) */
+	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
 	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
 
+	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
+		color_caps = &dc_plane_state->ctx->dc->caps.color;
+
+	if (!mod_color_calculate_degamma_params(color_caps, tf, NULL,
+						is_subsampled_format)) {
+		drm_err(drm, "Failed to calculate degamma params\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
-- 
2.55.0

