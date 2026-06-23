Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFD5CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2547710EC48;
	Tue, 23 Jun 2026 18:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K598KBEv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF3610EC69;
 Tue, 23 Jun 2026 18:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/gz8+xdaxT5ZXPBPjQvaZgO0s+0CU0oKqGD++kcdLHMg+OZxUUd5fVDw8GHSgTdvKBjcPujS6JubWD/IzCY3Iv3b7MdXgNMHAI1lxHBu+bK2BGJT6Xe4ZjwuMDtLiUnMW/2MYHNOkjOy+K8r/nK+MKoBgligTVwLMAqGw3YZn/qDG4YMXvGfdDBlCgbkISyD1pYDVjQvi6wXTY1uZNXcAAcH/oSTjMUpHwj/Y6d03Q3e0hQWHcc4hl8o1tDB9YwDLBxAooTyotvO6a/9AeDETW53rai3AvGQFvqwms73hYF3UdqraVu/KSdDKP80E1UFUESUuSgUnIsu59H1xE5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3yyZvcq5UIOHvgkqByrcZGsQIo9wt4W9amv42BDU0M=;
 b=X1TfRkuDs7pxFh8klFa3Dnn1ExKlsCubiWx+sypg4EbrXUtbfQGVMoOEp+nUJdD/JPcJ+ZpX7QCPOodd3UMR1rlQ38l4Q4i9PtFRh/hhD/8G9uTJ7J3DHrDw+W1ogH7FFsFI7uK983oqvSgeCgqJMPdgxAnP2LDP9WXwUSTdjHLbPg5zFTcE5LZOnL9H3jQxHBlsz1Ifo5MLReFh0tyB2NjKgxCRY5WWQFQvqTUaov+KMhZ/PP5ozdJ4Fooc2jkRdi3xyd/mLk2OwmazuUDxMQbew2ePtCnhkBVYT4q62ZXiHv0yLmMJD/B+tY2JJ332LStVUmPmB3zSKczl+srjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3yyZvcq5UIOHvgkqByrcZGsQIo9wt4W9amv42BDU0M=;
 b=K598KBEvkYXESAZRL0o093aSHK498m/L6ECVdvT0tV1RuKeTHcK0vM4kyp0SD3F48AQdEDmC/38XKw/eu/z/+0MSZgYBIs8JacW93gYTp1VcO62E+tm/YSRtU9Ye8KvPdeQ/AsnqR92H8UdK5fgW3pK+EcRe8OpqVY14I11kFH0=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 18:32:21 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::a2) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 18:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 18:32:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 13:32:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:31:58 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 13:31:57 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Add support for 2.4 and 2.6 Gamma and
 its Inverse
Date: Tue, 23 Jun 2026 14:31:55 -0400
Message-ID: <20260623183155.212394-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623183155.212394-1-harry.wentland@amd.com>
References: <20260623183155.212394-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: b86029b7-d991-46a5-2776-08ded155c343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BIBjoLyEtjb/nfmN3Al+gbY9x5L+8hRzq1vWVE2GlKr7Avv+aEtSnNzRrJx0liqzcVGhhAHwXVJaTRd6kUI9ayI9u1fEnuCdN/zUF+OU59L2P1r9x0spUiPHE1Y1w9apEkWBk+H45A+7oz+cKj4d8Pd/FRSCQHhdV/uqqUii9VKrM8U/Lu4DOt2ltqviTzFqyP7LdQLtqOnOXtj/hkH14FVjOV/Kb80qVYgZdeM4+Zv9G3E9ghTOYFhCbzXuYShge53/umhR/TWplnhL2KwHVQgfr/BHiFRBuO+LwfRBjywy095Byh6i3guhu9kaObykYfRdR6gnWCN9MqVZNTFl2m+3FrXhIHE9XvLY/YED0irmAXgT7rHPd6oxfRBW8JZ+eFf8pGdSN77GiXKBozOqGBFl1AbhVGATCo4o9SH/O+mUTpv5cOre0x1+rzSRmV9KegZXBSyYB0eOawkVGCu6+SFJHAw8406RuBnBzfqVn5ftU4J8bvIZ7TCwkeCUW9jiccSKrmkNBs2D/bqEQpEaTJKZDN3CwQMIhj2cyjy5fHE7d96LtMHq7vso8V6hQyGzv/mgGZjDAcUZn0Xv/M7LjeMOCSGTRD0tiUy+bvVcy/sxEn+IzjP/i86wuTJmMaQoOb6Dv4KpFnLmkcOPX+orHRLRzMu5tJR91zfKJ9oC9gATpTXUi9AI6lx0lhEPjUdZB6k09yXEu4+Xu+WvbvzJmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4PfgrF7+8MztGKRXMC5DFjStXaUGHAXIjhLIeICsoNw+xEfOWMzlHNjfpsYSfEz4WFU5LndJunsILQpsEhduXHVkqmalzXlZ1+kK6u4BBHSJUNzdGlsyFYcsfN5eY5PqwWzAFEijJsfYmJKpIEBBNPNqlIr3J0LdIYoAPfyrzGdEIfCUJmQYpWnUu9CG/fjjN7OywiMY4rS3OwhKJoNYiYImreFna9FNjCyVVp/q0gPO8KTtuV4IMyWgQoJBvpHiu4TuAEOWO16ScrNSdwDEYNKy72BbqUYyYh5EprXO1kxG+Yb9bH0KrMOHVTO7JgC0jeFnogSt+5k7HFDQoo6IqQoZSRLJf375iQtEDs77BYyh+FEerYRcxJI7R18NrPuoGTExkHqHXY04OErkSHJPAQbGd+7w6Z+rdRyyKhLdr4f0Ug8ClSeffkL7aHNOwMUg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:32:21.1154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86029b7-d991-46a5-2776-08ded155c343
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

Wire up the newly defined Gamma 2.4 and Gamma 2.6 curve types in the
amdgpu DM color pipeline. Map them to the corresponding DC transfer
functions and advertise them in the supported degamma, shaper, and
blend transfer function masks.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Assisted-by: Copilot:claude-opus-4.8
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  |  6 ++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c    | 12 +++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index fa6883ae4dfb..2ace173b06e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -896,6 +896,12 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 	case DRM_COLOROP_1D_CURVE_GAMMA22:
 	case DRM_COLOROP_1D_CURVE_GAMMA22_INV:
 		return TRANSFER_FUNCTION_GAMMA22;
+	case DRM_COLOROP_1D_CURVE_GAMMA24:
+	case DRM_COLOROP_1D_CURVE_GAMMA24_INV:
+		return TRANSFER_FUNCTION_GAMMA24;
+	case DRM_COLOROP_1D_CURVE_GAMMA26:
+	case DRM_COLOROP_1D_CURVE_GAMMA26_INV:
+		return TRANSFER_FUNCTION_GAMMA26;
 	default:
 		return TRANSFER_FUNCTION_LINEAR;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 7ee051cb3c05..081a92959d90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -37,19 +37,25 @@ const u64 amdgpu_dm_supported_degam_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 
 const u64 amdgpu_dm_supported_shaper_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24_INV) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26_INV);
 
 const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 
 #define MAX_COLOR_PIPELINE_OPS 10
 
-- 
2.54.0

