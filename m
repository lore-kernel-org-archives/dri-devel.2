Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD594606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ws4hq9x6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6C310E840;
	Thu, 19 Nov 2026 19:52:23 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E051F10E5A0;
 Thu, 19 Nov 2026 19:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVF/GNFwP285SaOgfNzJuWx2VIfW3RteEUuBkvVRehPI213G4LJIX8VVPIOFRXcgWqOnp80hvhzQ/jebvooiLl/A+V7az6BQG0XOf2yKqTCx3lyn/N/2g/a+0Y6g4Pd1ezHi/shTmE6LzOjcl1ayKn96BJHj+rRTNcW/uy8Yfl1+2iT6EPix5uHt5ZcD64yTmlbcCCT9PbxDTHvVBKRsEsv7462dIAbmO77yGADePcPTTycgR0bd5lk23rNZ7IEoNlrGptOc5WCNUSi8+Askw7AHcaBYVuGdBeaRfhYWPiBAkYb9lNKhiOvLSa3YbuYw8KNoWoCCUBGNYtoOmcgARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmXXkgQL+IrT7bPX+eyG6z3neKEg2/MdAKFdnV/IGl8=;
 b=qQL+yI2FS7pi5QRFMXo/zZqMuH81CQtQBAYSXKpq4oH58shcscKcMeBOodCmsNoJqA++7uQAG+7pH9VWcj9OTsdXR3mG80f6Z6zF97b3QeefEAhmwIc8c/jz9IwRJKlwnMsny01VS7WA7vB4NYALJHKqIdrfeBHzD5eKlUIjKDIKrW+XSauk8c0Y3rqGxZXaj7oBoI6HpN1cqdOCCjnxRQPjji8cZEv7OWTDc82YWSKDkZuKxScwz6qJ9L4143pzesEZVKtXWJfWhuxxpXrx7VYtXSD8wPCJVRVhl2LkGNFJD4acOBtURBygbAOzYSX5BbYBQzTWSDfNVb0oVFmI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmXXkgQL+IrT7bPX+eyG6z3neKEg2/MdAKFdnV/IGl8=;
 b=Ws4hq9x6RhIfirQ0yOQhqs3o/09c3jT/VM1HpeKqYF1mUo+a7i38RYS7nGCU3Pc9EkDIs/8Dt3UeBCTY7DXNY5LRu2QsJIx7D74uxTJZ4kub11kUOHUtr5WZyUUOSwH7g/msAVPAbbnhS6zWjolybK3QjswALB5SK7JnHT5XBgE=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:52:05 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::21) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Thu,
 19 Nov 2026 19:52:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:52:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:01 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:52:01 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 4/4] drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6
 colorops
Date: Thu, 19 Nov 2026 14:51:58 -0500
Message-ID: <20261119195158.2546927-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
References: <20261119195158.2546927-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ccdd51-dbc4-466a-54c2-08df46769633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009223027099003|22082099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: JimOwZ08HjRFQrs3pTnr0Iabd+gulffHCleqvF8voOV2VKatX8aDZbVzZya8NRVUK9TDM6BXvNhcIQJjPqu7tebRi55ee9usOXspMbEWoKBcG4e4X6+nCjCVqBds7ydVeLKOpweA6jwFbfubcCuGNI8rgjVLpL7nnc77BT7FjIeM8W3i0GrnnLxqdqf8xI1g8YntCwJCaV8Vn/Makqoq1q10TwPTBlHpc19v5fmwtK1bVqMWgJQbeSO3y53m6OGh904I8VcpbtwJ3s5WIl0W5GSVYV40exWmTfldO4MJQNsUe6zWnB5dKwJJ+O12rws5I0MGpP66jUoQOqlSVb8gGpDqmEi3pH1+oCQWLN1BBMoPVFcKUtwjxxIt2QUPkSZs0hPVCampeo/X20v2RQ1aC7OKIk1oKX5nzrQc7jwtl+h/tyhUdyWrbrI2XiTHobmF136p6viX7yK1AVEhdjOfdHfJFt5JHdPNLZhNnPiIaenxT1tZz17Vrv1aJHMZ2wJoDM9VfY14jUW0FI/X4YLjO+ac8zfW9i5Un0UV993LaGPapGe9/rS72fQzlvsCnZ/Soiw7lEn8/piLr3OhZ0C9Cent+lfGGObQK8TuzNwMHdcemX4KnVekGn7kPbpEgbMr+6NG0qv4OAJF3IjoQXedBUhHn2pB3yCl8iUTVzMCK1LWya/BVwcsS0ZeTTvdaEGEMDRGU2OGP7+r2FQuF2p75g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BjVXKlecojmsaETBHFvYL0UUgCCJIvuQGutWGJYQD7D1Gq5b7kF7zW4pxbsWBpeu9C+F+VTnZ82iRJ7QIcvW3bS2jywtGvXi9qDb5vmvZZ7jBNF1fcbftcAoUr9q62EyuPZUFCS1UMD7EJrC8Mb+/gHmNp7ForWQKvK2B0rPtOUB/9O+6e41KLAsTx9zjQxu3E76eCtLi8lfrolIbNMzgqziOT9CfszO0nRnuE2D1Lrir+FCfi5gFp7Ml+TTfHSk9HDCz5w463qn2Kn6MeQIkkdT8MOjCI8b3U7WQJvw5WZPvlp2Jl6LVLm20thdBZjqjD3vwvCh9xjuGRJnMFJnEMd9bFgaQW6vkpSMeYfkVpqd7cvC+vVWJypcYoCTDX5kj5qUJ1Y1P1ven8SHEcFmDSzY9sVuyiS5fH2hxHvvv9T8ecoS3qkppD1RyvDsagil
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:52:04.8626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ccdd51-dbc4-466a-54c2-08df46769633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

