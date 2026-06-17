Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACC9CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B1C10EA14;
	Wed, 17 Jun 2026 13:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COv5L1a/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71957890D2;
 Wed, 17 Jun 2026 13:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4CeBBFYVJ8wHIs3tKG6Xjhk79s3opIri48b0vxQdUyAFEqrPGwTFOCU8+k4V+gb5m7s42yXQuYUVi9GwKfh1P4dnUfUxQuHLOWp1uhTacLY14efD9bnEp6VyLvHDpZDhGdWM8ad2SRXS0Gd+1EHtr5hR9CR5x1XtR4wjMRxlVuZ8L43DUSZPcVtPEA8MtgXPBy2XdJmZNEHCxqttRlyDTVTkTFqt+S61nCowvFzDMX5xqn7lBFXCVPGJrCRWVtqYyuIv5ecuUsGEyNy/c83h1D1QrAOPwdtpxLOgl/fSrsTI9RBTIENt0Xnyff6zLUnyfL507SXIW7Pvz810ZMxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MBs+27jap3xUduqPHojnXPyRsCN59GceMYMWFE3Xko=;
 b=HlI2vLCPBzj/Ic3kO+Es9lJ2Fv0Q/71BqsTkQz+GcDBZDCJ2QGXGqj1vxYD55gzAdm/z1QP+mLnYAf4X+v9334ZVsmnegyYUsSDi2KCiVsF3OWVY9EBZKuTjq7uNl6M9nHxKA5LlwsVf61StaCdjph6sRGR8e5dKt+EWaiBtOK9ijRECfrp74fW/xUK2VQfSBc5rDve2ZMPod87JmYTC2rS5GKguQqHoEbYGT5UwB87ZoOkYWKTm7MF20+WxWoIAS+5BN+ZnITyzLBTgF6ssyRyoIsj9BA3S43UmG0z7RNtuhWpNC2xS4Ta+KYwdN81vTSn246Swck6bHqNsrwjfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MBs+27jap3xUduqPHojnXPyRsCN59GceMYMWFE3Xko=;
 b=COv5L1a/icHkTGu9g1dVkZa2aGts/K/68FQI9b/kYzXw9tiEYDSgTAHVAywgj32/hIhNkLb43NujFMICRNb6gyb+OKtixxMCV070NYBPp/sy4gDIzsW1ijI440JglLhnxCryvsdL+w+Af/qi0h2ulQJIOXhritBEASQ5vuP99ZA=
Received: from BN9PR03CA0675.namprd03.prod.outlook.com (2603:10b6:408:10e::20)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 13:29:14 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::5e) by BN9PR03CA0675.outlook.office365.com
 (2603:10b6:408:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 13:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 13:29:13 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 17 Jun 2026 08:29:11 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] drm/amdgpu: delay ttm buffer func enablement on xgmi
Date: Wed, 17 Jun 2026 15:28:33 +0200
Message-ID: <20260617132835.12306-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d046ab0-b10b-47ee-e1a1-08decc746c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aC1qWyPi52FjgBkdcGfuB8n6Wn7jfjEF3FvClC3k1rO59+UfE+zy6JUmutzmp951uffBY/xLHY8Aldz/eMPb3dY0f3l4dzh4oH05B7XyfpSaevSpT+AIAdAWGhSE2i2j5vpgighABDnUnGBo+WskZDJEeOYRy0iF1eo3uPTrKV1b4kYurVHB0i2OuuXFtA42X9cePv8Y75ulQ08K4BotW+3KGhHZ+Pxn16ej/V75e1F2rcyBafUFHD7pVQYvSnMTQikaueHpNSg51iL82a7LS2PPxg/HhLLyH7jqJQaKf2s6CeE8YdKSOgHy666sJGQ0ZPMRDgb9VpTtV3o/LE3BvaM8wR/8EWOaNGZp5nAdWJz2asAh+O0RAIDX0RqjOzH4bNWO3HTAkogibvK2OdfnbCtWAp/cmgRkdLZLk12Zez3joqOdxTE9S0kT3TGbsmhoknntjMettQUZNaXsqUX1dnDjLq3jzSMJZ7ZFT7dD6dmRtrcB71W9m+W9cLxg6hXspXr0QVaIKm1l0k/aSJIbOQHrgfexYxgZKBTqGWAy0z86GyJahF71JctTOrJqStKBiyWOWoxdtEzOKF6kW09XY6sgyQ2FBOJje8WKhj8RYkbtv4IqSZG8Y4chENhD6k9G884KMT6reO5esG1YdZO+QvXlVgQQnBCz26Ts6V54ZGJnaIxO7cf/T4uxKfavR4btlgJkZxKh1IEs5vA2mbOIthwv+iX9RjALhXopPNQA6Q4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lKIYx4pUZC0YkG03PK63YPUyIx/yeQ9cvlph0c5ea3D/HkLSBjw97oDmV0g6/V37tglvaXSvLr7bNVWcamCZO/1kucwZnHvECZG0tPTk1nZXOyKevLnBBE+awMaI0xgfnwvNQn1Qj20ZcbWHlJUr2RHF3Go+8npMyRfOldDNv+xWgtFy1VNXksGlV/T1neGomAReVSUb4Map2HMh4e4G/zo/O/Kj/qORN1TWUh4/9kmjNAg7rg2xnex/P1DaPzfanxQGhsPMhqDUfB0PB7Ec42QGvUuuNGFNrz/GKIG5KxWAvOEZ46QWErelclakwWsMVgRtFlA8hLsMhG1bYP8SmvKx9qLozmA8sJNs1ZBMKrLC1X2lOnZLinK+dbek/bQGcukdoIQPOq114ptaLAcLup1n55ChIT5k5zFzhU5MJR0vw3yE1j2wU71jM+DzYct5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:29:13.6974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d046ab0-b10b-47ee-e1a1-08decc746c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

When amdgpu_init_minimal_xgmi is used, SDMA engines init
is delayed so amdgpu_ttm_enable_buffer_funcs must be
called later.

Without this, the check for num_buffer_funcs_scheds will
fail and using ttm buffer funcs later will fail.

---
v2: no need to add a new call. Instead move down the one from
    amdgpu_device_reinit_after_reset after amdgpu_ib_ring_tests
---

Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for ttm")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57e10afb4714..53150fe55350 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	amdgpu_ttm_enable_buffer_funcs(adev);
+	if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
+		amdgpu_ttm_enable_buffer_funcs(adev);
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
@@ -5253,8 +5254,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				amdgpu_ttm_enable_buffer_funcs(tmp_adev);
-
 				r = amdgpu_device_ip_resume_phase3(tmp_adev);
 				if (r)
 					goto out;
@@ -5320,6 +5319,8 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				r = -EAGAIN;
 				goto end;
 			}
+
+			amdgpu_ttm_enable_buffer_funcs(tmp_adev);
 		}
 
 		if (r)
-- 
2.43.0

