Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A10FC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1238C10EDE4;
	Wed, 22 Jul 2026 13:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QaYSjwVG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DF310EDE3;
 Wed, 22 Jul 2026 13:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwxIjzD0LeLkyMUi9YP0MGJpFtPuM4U67zLolaWZom9s7FuHM//5Sr1LDbT8bA7ByzSypXYwYgFK1L6zMyUaPM308doj/QQECu8c6XK/vmPHanPV1DmsIEDB+UwbqD2d/GmrT9gdLrwg8+WLVvw4HIEfZoEPRPjcbe2GyBoSVHFd9h8/FqSo3JFGQZdo9VEXER1gHvW90sNdvFwSVOAo9ITWtkUv7nUxu76t+SmHBtQhsW+VOV+nVowmctjH7dBK8AG+qlAxSKMiphE/SV0tc1WE1G3Td8fU7K0rAY0szsfOzFKcb3VBUXRRSV6tslatY9W8FwGFc4ajxMlRwEvlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozkJNWVjojQwILyzNt60oLCj7h+tLNr53C/dXI2ery0=;
 b=xT/J2/TXXcqNn82gcyFe0KJvxzGqpKKjxpLUKDkA9EabKQbeBYvu2rR1ef/LX53+YmdV7pae8lIfS8RssqI8p62X7Jxc9cM8FBZlIySZocLamLcOQk7XcgHlIQpPxvrLPu/WR8SAHVZRoOoVh96dWJ0HQla/QiIcQlS2MluBpQ+q8fA/pGihJ04EcCS8b2egxc3Ai1MnnklggNdh34uJrGLQPocSNoh11d/8suUp+1dz561E94o+bkEs6Upg3HiLJq8Gyx9mXjqM9/kANn0QiBcRKGsIjeEEmlMsJP35QX09Hoqxmy03vu1dUVfCOaaGUw/ceIGod2rSAO4izTKLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozkJNWVjojQwILyzNt60oLCj7h+tLNr53C/dXI2ery0=;
 b=QaYSjwVGmgdC9xltAPXwvv45tjZ9Yf3+ehPRgnzI9pNpIXsYa2Wz7y4p0BmUJrAdZgBYrj4iE3ieXgjylDzfcdlTSCAsnWTeajw48xLhHtJoEWQ2JdIy99p/jpbqkGL5qakUVU6unzX/5WK7VCHJDZf659NnBR9uOMcEqWGG+G4=
Received: from SJ0PR05CA0151.namprd05.prod.outlook.com (2603:10b6:a03:339::6)
 by SAWPR12MB999291.namprd12.prod.outlook.com (2603:10b6:806:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:18 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::97) by SJ0PR05CA0151.outlook.office365.com
 (2603:10b6:a03:339::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Wed, 22
 Jul 2026 13:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:17 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:16 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB conversion
 matrices
Date: Wed, 22 Jul 2026 09:45:59 -0400
Message-ID: <20260722134607.136293-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SAWPR12MB999291:EE_
X-MS-Office365-Filtering-Correlation-Id: e23f4079-4152-4197-a0a2-08dee7f79b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QcixUj16mdK8GHmCuD5tyWJNLnwZkQy+SluOkY5q1zng3fIG1P2TOZQTku+jryF4zdxNkGjj0encDmPhxNDJa6IaFFAh96hbC7SVVQuYv6ZxwTYMup74GYa18V+7LSlqz97s7gRZnbEJbkKvcDyjyPuXyUzPMbEgIIRCApRiGR9pPGPecZ1IMuNp2Y9fo1hEFMSXx8corKrwv4Ba0leKKwH/wL+fkxR/HJAtXdUGwrZW4WEULCm6916W6M0AVi01a4j/4Zs8szt1EqD9dxMPw0mXogY2gjdbh1HZEASeFoL84uyTj+gYvnvoY0JTbIrBVWs8N4GS7lKsgtUT41euhuQhiOkxUF5i8MFeTKnPpzvx2vUJxrpmouyh1YRzUZWVKp/xBeBOwjMd6wjICi1gpIoON/+997NE3cd2uOFggx39jETVpBSKZVVKXB/odHrtyyFRanjiaElErwVeIVgEmIAbyNIFF4m3hFgxPrChU8Y+E22755xhFJAPiyvRti7nXOTMhoOvpz6XVXroa67r1QsxQQO7DThAsVs03JmxXy/jOZck141j0vLBy53RxlCyTGNZaifhaRRwqco8h7A9PVFn30KpdIa6U80OtMy1L56B/pPOLFb6Yz2x3bPL5x27y1DIewcHW1RhAFQFGWJWzhtWJ/RmmeyFlLD+Qdv6udhfY96j5vfecOrc5sFBxM8Zjnbrt6JEmUxhv0DhDHul9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OxhGfJCrQDj0anqOH7fTBRBOhfYLieoVC8BGA80kQ/2kIIxyyK0sGLTSs8DOO6oLz/vYBN+PJUTxyjgIZ/K6iN8c3kU3vpB2DYxTewnyYvdPTTPtTgCrXVBgGk05ydT2si+g+r2k4gW60eaqjYMZaw4mcsE7fxOOP1ZLFXdLHRY+z8nvATHH8kIEZacIfk76gtoOVA0wKGHKERQjuI6cyHVngomGSGlzyZowY6JKW+BHkOVrmrcZzs/opIy9zA+tsIEIdb/xflvIfnvoSTR7/WpOeAspLSG5xlChmkVND1V60c/6y6l22i4lBuERhT/LWWcM/HprynDIL0DukvDP+YvQLPwkGMTUWSkX/tfz99WWBN0vB3I6PngRFwKJj2RBtz91TvLVvfHJJ0waYoalh+/7OFKEF+npo8mYuF8aQSIoMEUrwt25QIwtj5dHLl4B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:17.8552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23f4079-4152-4197-a0a2-08dee7f79b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999291
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

The existing yuv_u16_to_argb_u16 test performs a full RGB->YCbCr->RGB
round trip with a tolerance of 0x1ff. That tolerance is required because
fully saturated primaries clamp their chroma at encode time and cannot
round-trip exactly, but it also makes the test unable to detect small
scaling errors in the conversion matrices (such as using a 2^n instead
of a 2^n - 1 full-range maximum for limited range, an error of ~129 at
gray - below the tolerance).

Add a parameterised test that checks the exact S31.32 fixed-point
coefficients and luma offset returned by
get_conversion_matrix_to_argb_u16() for each encoding and range against
reference values. This directly pins the matrices and catches
sub-tolerance regressions that the round-trip test cannot.

Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 789c59d07ffb..e746b18bf37b 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -263,8 +263,130 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_cases,
 		  vkms_format_test_yuv_u16_to_argb_u16_case_desc
 );
 
+/*
+ * struct conversion_matrix_case - Reference matrix to test the YUV to RGB
+ * conversion matrices returned by get_conversion_matrix_to_argb_u16()
+ *
+ * @encoding: Encoding of the conversion matrix under test
+ * @range: Range of the conversion matrix under test
+ * @expected: Expected S31.32 fixed-point matrix and luma offset
+ *
+ * The limited-range coefficients use the studio-range scaling mandated by the
+ * DRM UAPI and IGT's igt_ycbcr_to_rgb_matrix(): the narrow range is expanded
+ * relative to a full-range maximum of 2^n - 1 (255 for 8-bit), i.e. luma by
+ * 255/(235 - 16) and chroma by 255/(240 - 128). Generating them with the
+ * common 2^n normalisation (as colour.matrix_YCbCr(is_legal=True) does) is off
+ * by a factor of 256/255. See the DRM_COLOROP_FM_YCBCR*_LIMITED_RGB
+ * documentation in <drm/drm_colorop.h>.
+ */
+struct conversion_matrix_case {
+	enum drm_color_encoding encoding;
+	enum drm_color_range range;
+	struct conversion_matrix expected;
+};
+
+static struct conversion_matrix_case conversion_matrix_cases[] = {
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.expected = { .matrix = {
+			{ 4294967296, 0,           6021544149 },
+			{ 4294967296, -1478054095, -3067191994 },
+			{ 4294967296, 7610682049,  0 },
+		}, .y_offset = 0 },
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.expected = { .matrix = {
+			{ 5000989317, 0,           6854882848 },
+			{ 5000989317, -1682606224, -3491669458 },
+			{ 5000989317, 8663946082,  0 },
+		}, .y_offset = 16 },
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.expected = { .matrix = {
+			{ 4294967296, 0,          6763714498 },
+			{ 4294967296, -804551626, -2010578443 },
+			{ 4294967296, 7969741314, 0 },
+		}, .y_offset = 0 },
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.expected = { .matrix = {
+			{ 5000989317, 0,          7699764272 },
+			{ 5000989317, -915895824, -2288828138 },
+			{ 5000989317, 9072696586, 0 },
+		}, .y_offset = 16 },
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.expected = { .matrix = {
+			{ 4294967296, 0,          6333358775 },
+			{ 4294967296, -706750298, -2453942994 },
+			{ 4294967296, 8080551471, 0 },
+		}, .y_offset = 0 },
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.expected = { .matrix = {
+			{ 5000989317, 0,          7209850391 },
+			{ 5000989317, -804559491, -2793551177 },
+			{ 5000989317, 9198842076, 0 },
+		}, .y_offset = 16 },
+	},
+};
+
+/*
+ * vkms_format_test_conversion_matrix - Verify the YUV to RGB conversion matrices
+ *
+ * This test checks that get_conversion_matrix_to_argb_u16() returns the exact
+ * fixed-point coefficients expected for each encoding and range. Unlike the
+ * round-trip test above, it is sensitive to small (sub-tolerance) scaling
+ * errors such as using a 2^n instead of a 2^n - 1 full-range maximum for the
+ * limited-range matrices.
+ */
+static void vkms_format_test_conversion_matrix(struct kunit *test)
+{
+	const struct conversion_matrix_case *param = test->param_value;
+	struct conversion_matrix matrix;
+
+	get_conversion_matrix_to_argb_u16(DRM_FORMAT_NV12, param->encoding,
+					  param->range, false, &matrix);
+
+	for (size_t i = 0; i < 3; i++) {
+		for (size_t j = 0; j < 3; j++) {
+			KUNIT_EXPECT_EQ_MSG(test, matrix.matrix[i][j],
+					    param->expected.matrix[i][j],
+					    "matrix[%zu][%zu] mismatch for %s - %s",
+					    i, j,
+					    drm_get_color_encoding_name(param->encoding),
+					    drm_get_color_range_name(param->range));
+		}
+	}
+
+	KUNIT_EXPECT_EQ(test, matrix.y_offset, param->expected.y_offset);
+}
+
+static void vkms_format_test_conversion_matrix_case_desc(struct conversion_matrix_case *t,
+							 char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
+		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
+}
+
+KUNIT_ARRAY_PARAM(conversion_matrix, conversion_matrix_cases,
+		  vkms_format_test_conversion_matrix_case_desc
+);
+
 static struct kunit_case vkms_format_test_cases[] = {
 	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
+	KUNIT_CASE_PARAM(vkms_format_test_conversion_matrix, conversion_matrix_gen_params),
 	{}
 };
 
-- 
2.55.0

