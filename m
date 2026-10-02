Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB17ECA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA2010F84E;
	Fri,  2 Oct 2026 13:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azKiOiNM";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE1B10F84A;
 Fri,  2 Oct 2026 13:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H37jR8DtGzvzZCJlqY1jM8QAnmk/RSvujZZ7QYGNL1BKIO74cNG0eCUCeo9XUXVAMUJWz3+fODlzbJuMMFyGat/it0t5hT1U8KFNrB2+5+VdusooUH+ZAigGfGjs431wykAOeeF/Ed05QAVUmqij1EehYcwWwF/fMuZ7yCHQWFO2Rw/p7LLFPqfr6/RW1XNKxAIlWGtr1kvlitag2w+IuRurjA5par2T61SOIkJwX1klLG8B1z94n0cdmUfdPBYLp2t7AEGwTudoO01wldMIreTexXGxLiDgZM4jYWps3tvkk4Ovo58DgV4boU44tpmeXqCDNGrbWzPoMkiUneNc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFGLOz5RPzJlA33SkoTfbmUqA0t4GyIMvcBQo0FuJ/4=;
 b=JAYMX5BHVwOSKY6BpQiweeMc1q7QYL7yHZ2tE2z10hhTJZUYM4Qjfo2kt2kjcHgorGgaoh1OfRA2nMDjN6m2ktnyUBRg3EdbfdiXFDvvLaVM8IYZEztwW/nFPjbJEwm4EDvuvbsp7iH4ijtFtPDoQZnDLWHUDfgIGV0BcONxsdEOcFeDbbZG9PqpadUcattkbWn+oUpY8HEbowdMY6UYBxPrXYXTHYZICQnGZo4o0CU+CYwlkxTI8O+uMchBiMr3XOJ4jiZRjAhFsCCppGgtFfB0Lez/KkYMHTq2ZKu5PpkBemcRwqtS6CtVC2xv1vkvZ08Xu9pOyn2m1GpQHfHAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFGLOz5RPzJlA33SkoTfbmUqA0t4GyIMvcBQo0FuJ/4=;
 b=azKiOiNM0BxEylE27lFhZby7bmFd6UI7W42hSGE1CBWau4exJ/e9s2gBg53zQ0YDrbMzDosP9Pwa0H7OKBUjsdUI4HcLJJXV7yZfpMw3fkw6TG5im22QOSWMDFU2FBjDd7MnyJNH3TODDY9fAI2zCuq4i43loo+cGuxrsSbzAbs=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:39:40 +0000
Received: from BN5PEPF0004698C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7a) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 13:39:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF0004698C.mail.protection.outlook.com (10.167.245.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 13:39:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 08:39:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 08:39:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aesteve@redhat.com>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <rdunlap@infradead.org>
CC: <dri-devel@lists.freedesktop.org>, <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/3] Revert "drm/amd/display: drop INLINE_IFN_KUNIT"
Date: Fri, 2 Oct 2026 09:39:23 -0400
Message-ID: <20261002133925.2356834-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698C:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: b80d4fcc-6f8c-413d-ecdc-08df208a9947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: yLXp2t+IUeydSSvSIZh6rzWB5y+Mg69t8XXVtZGTpvdmRRZqBLVMdsRnhnUhoyPQawirDO49sJ/Ktr0u9nFw/EuSwGDwEGKKSoqOppkx/C5xJM4AblTdamittLAJoeWv6cypofTQQpymrkbTmw6zRiYE5wp2B7s5Iau02Ac+rXQBc7xCRF67PN22Cmc2RkER92OHZPcjQq/l8qfw7Rki6P8/wDHXFLrCFi9/bDksYRewGMMWTFkSrHaq92xhjQdTujiN7T9FByUiu+UpL7dOMWvZ+oqfo4TLdX+B+c8C6m5Jt9dcT/YqDt+b31R5heor4y+sCS7I4dKOSC03cHeJzlmYu1IPfdl7xtHNqSoB1lej856mja9xBdUbMJ2SGAdE9RgB5k+1ygYSaF2IIYMQHwyErWNaGDqXm2OZCkQjCRWaAKEA/o0A8raOBxUgzTJxtMu0jShHqne0z57SEh1P6DDzEjnzkxNSk4biPi1i+nlockH17wMHdvGP3MAQCXBCHwiIXM2S4DYskksXD7RPyfM7B+3ivW+h5SFYm+Hb8r5bvuJ3vZxaXd3Z6/UcHMhcGuBojwZDLKwL0rL4kjwhyj1yvUC5dBEQFJREnfopkSlKoVWXS11gqVgV0fgjhrxfDiildICUmPI5YHq8riRXic52BQ+Zb+jklm6YSrzD1BvYoc6+2V8SEWUaGAgi/6UnDzSpZBPXrO13vuzyzh7Hp/7HCc6BLFyoKy9xsAj5pv73csF/a+CO4X5JvUmvKQHy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e5qUKIUEHvj7AlRRrpO40rmS7q+DHhUpPZmWcgHT5rBXUipDPJeAI9ZTgPeTsg9jg4fHoLFAI7k1TL4SyLrisKAb+cDGlFDBwIe1BIZ7hUKiz1ci/odkvjH9fxJoRhEzKnqv6clkN6kiZjRG3a7sQjpoM8t6cbKH/oLOw4Y91C1mFtle91MyO77/VcVfmy9NwK5HhSodM08QkJGyqGUzvfHtVX5+Jev/biIQrtzxDIZrTQYvqtSeu1Y/ooEsxRIlA7HUr9LL9SqpEiub2oqpR/nsuwrLvE5yFB86MG9yYQgckEJfCh1EjW0WJl/oNJ4Ko7n29UG6qinQNELwdJyhcwMX7fR3R34tXofbe8L8hL0KR+ZSpfQ7QDOgy+ApufbL7YUeef/d/FDyBw+GLKGXgK2e6Se9KVbucDdHelkZIxXAZnLKPo5GwXjp1PXjnskG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:39:35.8687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80d4fcc-6f8c-413d-ecdc-08df208a9947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
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

This reverts commit 5a98f454a61197761c4c5e8eed948dea2b9f5a69.

This series breaks the build when CONFIG_KUNIT=y and
CONFIG_DRM_AMD_DC_KUNIT_TEST=n. When CONFIG_KUNIT=y,
the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=n,
they should be.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h             | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index de4af9adc633..c787082409fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -274,7 +274,7 @@ static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops;
  * @array_of_surface_update: dc surface update pointer
  *
  */
-VISIBLE_IF_KUNIT inline
+VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
 bool update_planes_and_stream_adapter(struct dc *dc,
 				      int planes_count,
 				      struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 1fde4959baea..341b4972a309 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -173,7 +173,7 @@ void amdgpu_dm_init_color_mod(void)
 }
 EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_init_color_mod);
 
-VISIBLE_IF_KUNIT inline
+VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
 struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 {
 	struct fixed31_32 val;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index cabcbc2599e6..6d7cdab1006f 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -194,6 +194,13 @@ void dm_helpers_mccs_vcp_set(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#define INLINE_IFN_KUNIT inline
+
+#else
+#define INLINE_IFN_KUNIT
+#endif
+
 bool dm_helpers_submit_i2c_over_aux(
 	struct ddc_service *ddc,
 	uint32_t address,
-- 
2.55.0

