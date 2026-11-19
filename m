Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3172606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lvfzyYpN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC6C11261D;
	Thu, 19 Nov 2026 15:55:13 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6843D112611;
 Thu, 19 Nov 2026 15:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV2bRwwV9GYnkGt8/T8K/EM4LUxeB8Vskr2mHI8TgQd8VmPCPhKm0iOy6CgTDZIu+ZtIVGUVqiZpNOEB9hos/QPzC7FBiDg5HXq9oC/QaQYYkVyHat7+WxBnzDlavjK4B3JFk7eoEPGPaZC+2+0tPWveYx09h6G5CpquLVq4ZSJV1X1NetnAjvApDN691UR4VElAxsQ6vxrLFV/0n0nICv5fivd+j/LkMIIOUCC8zNeWzzy5H+oE5jmrObpH1qfRPebPazHCfzNVzGvvhnHLX1uQjAqq6CrI6icz4oXxSWKq3gMfTj5Kb1EuLIJRDQNxrBKchVtaK27Ho7sBmM8FZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmXXkgQL+IrT7bPX+eyG6z3neKEg2/MdAKFdnV/IGl8=;
 b=yxAsmg8cG2SSVX7NEJTmd1vypvAObUCAbS62kdcLxtLlwuJ2JR+XnyNrndlsRsgh7Wix9Kh6G7JoJHABR5j6cyrSXWrBpo8hBphmN0IPAYKrblrZQmEgvDjfp1dhDmmkDOvZPg27/fnZfWZVWkriFyf65ueNdQY98vUye4AubvNhtblLToA0eHnw+YRWmjSn/3YlQDTKyvUxmWrB/rQ6YHAjkkGYtDN9UY8YVm5y9yZEs8nps5Iy6e3eZcFY4Xl7QaZFoUbeRWTSQaQFuu3zleZRe5K9rUD/PrC5Gf3uHkui/WGFOHj0LIaHj278c2jwonGWJXj27LwrrBQX1kKw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmXXkgQL+IrT7bPX+eyG6z3neKEg2/MdAKFdnV/IGl8=;
 b=lvfzyYpNfCmCk+aymyOTGPLbOkpIn9gwB80SOwM/eHgeBxnf2+Z2HQ8qUNruMTKaycPJtbKrjms7yGz1FdzcJxgVQ3Oc8M4+Jk6Q2Ml2GVaKCb2ftOXGrj8Invmny6JDMmMwhYg4qi1K7PPyFnkPmp5YfQCHoAOw+JAhIlNaBeA=
Received: from DS3P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::16) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.10; Thu, 19 Nov 2026 15:54:40 +0000
Received: from CY7PEPF000000E8.namprd04.prod.outlook.com
 (2603:10b6:8:45e:cafe::9) by DS3P221CA0002.outlook.office365.com
 (2603:10b6:8:45e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Thu,
 19 Nov 2026 15:54:40 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 15:54:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:38 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:37 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 09:54:37 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 4/4] drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6
 colorops
Date: Thu, 19 Nov 2026 10:54:27 -0500
Message-ID: <20261119155427.2494007-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155427.2494007-1-harry.wentland@amd.com>
References: <20261119155427.2494007-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E8:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3c074a-cb78-4755-d91c-08df46556bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|11063799006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ibW+Dmsoh8M/w10QWZp8UB5kUQrnLVAvg20dog4gHqOyIQmHcNHPKKZJZfVUa4pKrUkVc5SxyKWq2NAi9h2NfJPMAjLOCg+sxwNBGoJlgi0vQrOX002xmfxFu5CdANjcjcZmuWqauQ2XK5Yp6wf6w3QzvMOungHlpO9PzHwu0RJM8hKXpy0sSapXrgTN9OcQCQ99k7oZdLHvkCPiUTCbkGhEqI2M9hXVX5nJRkVId2f/DQ2VXFBV4PIQklB8GuvIxocAr6MzRSWAzwPfjeccsnrA0uPmuz3eF58QIihBIBsIkJt5EQ4Ra+M3cCMAKUOUV2Z7YxgtBSvQNj6xt8z6yLBJTzqIMmeDUq8wqsgyPJrFy0OdZZ9DMLSid4O+lDtbIhStqZl443Klnu3J05t+wqiTpfHiLoLlySvu8a9Gj3H91mkBh9PiIQxGfa/1bYvCmG1Y8FmRVtDSDUw5GsOF7qJlud1SYLAkuOJTSHBrEmF+WYwI+LfHU8O068htheSjVWFcH2tdyW6b6/WnVuSxF4U+0QZT3uSmDvlDrSP7qs+VuyZrc78WxF6Bs5ivysO6sQaSNabLJb6PM8eenSJTEpmtwomsiFrTAO6gUhL/Vk+s/CYconGLqMRLrVuQpMv26QcpKzcxyYSFL8ea1lChIv5GvLOjiqASkjwyF8rDlUmrH1fNyi/RGJBBf0xUICtO9GxnKBdrPHEioOiqc7jWHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kRHUH+VElaWIJZvTPbMEf3PQfK0m7tfI17inpujsFJaT5m9MAJAypaEmUDNnzkHmiIJOhlLcENhwwQ3i5XPvRMa1aIyowssAEPA/EGZ75zkJLFU6ytZpTMaEKzJBnubaCwqExe+LAcCQgAelJev76ulCnwtEPVWR8/5KLOycupSqPuOuhyPX5rRaEwv+YYPnRGZvl74fX8wQYiuw4NQH+AoKnVXE1xE5NaX32QeqGrg0XTM/ysQR8N4qnXm4p9WHUjrFbEQu3Cw0CO+2RJdUViUST9eP9IKzxHTTXvLe7uRb3sP8BpT/w8NHXMeMlD4mMYSBJ+Lj1OkuxDeGE/ZMYBSPYVLfwHu8p0xh/Aty2y1xoZBWlEVUoPk6hoSMksB0e6cB+mJBeZ/IYml95wu6Bc43GQZy4eMzBDgqfMl4uTR5Hq6BfjNqVk+SD4c04Oqt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:54:40.6528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c074a-cb78-4755-d91c-08df46556bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000E8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

Check that amdgpu_colorop_tf_to_dc_tf() maps the gamma 2.4 and 2.6
curves and their inverses to TRANSFER_FUNCTION_GAMMA24 and
TRANSFER_FUNCTION_GAMMA26.

Check that the degamma and blend masks include gamma 2.4 and 2.6, and
that the shaper mask includes their inverses. Update the
*_no_extra_bits cases for the new mask values.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 18 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 54 +++++++++++++++++--
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 7ad8c56cbcf3..7a2c137f2967 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -330,6 +330,22 @@ static void dm_test_colorop_tf_to_dc_tf_gamma22(struct kunit *test)
 			(int)TRANSFER_FUNCTION_GAMMA22);
 }
 
+static void dm_test_colorop_tf_to_dc_tf_gamma24(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA24),
+			(int)TRANSFER_FUNCTION_GAMMA24);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA24_INV),
+			(int)TRANSFER_FUNCTION_GAMMA24);
+}
+
+static void dm_test_colorop_tf_to_dc_tf_gamma26(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA26),
+			(int)TRANSFER_FUNCTION_GAMMA26);
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_GAMMA26_INV),
+			(int)TRANSFER_FUNCTION_GAMMA26);
+}
+
 static void dm_test_colorop_tf_to_dc_tf_default(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_colorop_tf_to_dc_tf(DRM_COLOROP_1D_CURVE_COUNT),
@@ -2928,6 +2944,8 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_pq),
 	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_bt2020),
 	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_gamma22),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_gamma24),
+	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_gamma26),
 	KUNIT_CASE(dm_test_colorop_tf_to_dc_tf_default),
 	/* __drm_lut_to_dc_gamma */
 	KUNIT_CASE(dm_test_drm_lut_to_dc_gamma_legacy_zero),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 27cd4b8500e8..9195a2c827ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -40,12 +40,26 @@ static void dm_test_supported_degam_tfs_has_gamma22(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
 }
 
+static void dm_test_supported_degam_tfs_has_gamma24(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA24));
+}
+
+static void dm_test_supported_degam_tfs_has_gamma26(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA26));
+}
+
 static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
 {
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_degam_tfs, expected);
 }
@@ -76,12 +90,26 @@ static void dm_test_supported_shaper_tfs_has_gamma22_inv(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
 }
 
+static void dm_test_supported_shaper_tfs_has_gamma24_inv(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA24_INV));
+}
+
+static void dm_test_supported_shaper_tfs_has_gamma26_inv(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA26_INV));
+}
+
 static void dm_test_supported_shaper_tfs_no_extra_bits(struct kunit *test)
 {
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA24_INV) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA26_INV);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_shaper_tfs, expected);
 }
@@ -112,12 +140,26 @@ static void dm_test_supported_blnd_tfs_has_gamma22(struct kunit *test)
 			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
 }
 
+static void dm_test_supported_blnd_tfs_has_gamma24(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA24));
+}
+
+static void dm_test_supported_blnd_tfs_has_gamma26(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA26));
+}
+
 static void dm_test_supported_blnd_tfs_no_extra_bits(struct kunit *test)
 {
 	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA24) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA26);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_blnd_tfs, expected);
 }
@@ -497,18 +539,24 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_pq125_eotf),
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_bt2020_inv_oetf),
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma22),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma24),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma26),
 	KUNIT_CASE(dm_test_supported_degam_tfs_no_extra_bits),
 	/* shaper TFs */
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_srgb_inv_eotf),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_pq125_inv_eotf),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_bt2020_oetf),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma22_inv),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma24_inv),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma26_inv),
 	KUNIT_CASE(dm_test_supported_shaper_tfs_no_extra_bits),
 	/* blnd TFs */
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_srgb_eotf),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_pq125_eotf),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_bt2020_inv_oetf),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma22),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma24),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma26),
 	KUNIT_CASE(dm_test_supported_blnd_tfs_no_extra_bits),
 	/* cross-check */
 	KUNIT_CASE(dm_test_degam_and_blnd_tfs_match),
-- 
2.56.1

