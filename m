Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6749ACDB470
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2C710E69A;
	Mon, 22 Jun 2026 12:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HBkqTNIE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AC910E6A2;
 Mon, 22 Jun 2026 12:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3E7E42DF9;
 Mon, 22 Jun 2026 12:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B07B1F000E9;
 Mon, 22 Jun 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782131891;
 bh=aLPqKAV7NdOOeAs34uEEPNQIcuUUtHD4+t3qpP0ZBqM=;
 h=From:To:Cc:Subject:Date;
 b=HBkqTNIEGjJS5hE5R8YGUecnvZvxQ7ddtBHMiP7EKEWMM9OzJhNrBEcpW8zpRoUab
 c9kjjbUfPmR7kEbS0sYhrxgxrCeYlVXC0nzksTNwVVbYchnMDLz+iwxZgD0eWXRbUU
 3RpXyhVdjIAFp0LdF4dW7Uo12KCtrfuk8OdywQnQ+Ip1xOSYyJWQNIeolZfnO2V05m
 s+wtx1P+CgGhESs+dWV0uD9LTM6u5eY7CAxEsAzScigQfpPLUCtIP/nuhhCHT5XNrE
 gzmF+W+pQv7aNUMCsWErqDeZxevQmQ4ZjK/1VYelrWxhL6F9eoVL+6yPn5opWxAtVV
 onz/U84y7K4BQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <siqueira@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: kunit: move dc_link objects off stack
Date: Mon, 22 Jun 2026 14:36:42 +0200
Message-Id: <20260622123659.2221930-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Arnd Bergmann <arnd@arndb.de>

'struct dc_link' is too large to be on the kernel stack, with every instance
causing a build time warning in some configurations:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c: In function 'dm_test_subconnector_type_none':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c:36:1: error: the frame size of 1608 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
   36 | }
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c: In function 'dm_mst_test_needs_dsc_aux_workaround_zero_sink_count':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c:156:1: error: the frame size of 1584 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
  156 | }

Since the tests do not need to run concurrently, just make it a per-file
static object that gets reinitialized for each test case.

Fixes: a895eb57a55f drm/amd/display: Add KUnit tests for amdgpu_dm_connector
Fixes: 1c37d1b6c741 drm/amd/display: Add KUnit tests for amdgpu_dm_mst_types
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patches causing this seem to have appeared were not in linux-next
during the first half of the merge window, not sure why they are there,
but in case these are intended for 7.2, it still needs to get fixed.
---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 17 +++++++++--------
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c  | 14 ++++++++------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 34e40d2a9d2c..e2c0c2a934a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -22,6 +22,7 @@
 #include "include/grph_object_id.h"
 
 /* Tests for get_subconnector_type() */
+static struct dc_link link;
 
 /**
  * dm_test_subconnector_type_none - Test Subconnector type none
@@ -29,7 +30,7 @@
  */
 static void dm_test_subconnector_type_none(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Native);
@@ -41,7 +42,7 @@ static void dm_test_subconnector_type_none(struct kunit *test)
  */
 static void dm_test_subconnector_type_vga(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_VGA_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_VGA);
@@ -53,7 +54,7 @@ static void dm_test_subconnector_type_vga(struct kunit *test)
  */
 static void dm_test_subconnector_type_dvi_converter(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_DVID);
@@ -65,7 +66,7 @@ static void dm_test_subconnector_type_dvi_converter(struct kunit *test)
  */
 static void dm_test_subconnector_type_dvi_dongle(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_DVID);
@@ -77,7 +78,7 @@ static void dm_test_subconnector_type_dvi_dongle(struct kunit *test)
  */
 static void dm_test_subconnector_type_hdmi_converter(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
@@ -89,7 +90,7 @@ static void dm_test_subconnector_type_hdmi_converter(struct kunit *test)
  */
 static void dm_test_subconnector_type_hdmi_dongle(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
@@ -101,7 +102,7 @@ static void dm_test_subconnector_type_hdmi_dongle(struct kunit *test)
  */
 static void dm_test_subconnector_type_mismatched(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
@@ -113,7 +114,7 @@ static void dm_test_subconnector_type_mismatched(struct kunit *test)
  */
 static void dm_test_subconnector_type_default_unknown(struct kunit *test)
 {
-	struct dc_link link = {};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.dongle_type = (typeof(link.dpcd_caps.dongle_type))0x7f;
 	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index e3b171992be1..f1f728acd373 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -45,6 +45,8 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 	}
 }
 
+static struct dc_link link;
+
 /* Tests for needs_dsc_aux_workaround */
 
 /**
@@ -56,7 +58,7 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
  */
 static void dm_mst_test_needs_dsc_aux_workaround_match(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -74,7 +76,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_match(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_rev12(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_12;
@@ -92,7 +94,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_rev12(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = 0x123456;
 	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -110,7 +112,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id(struct kunit *test
  */
 static void dm_mst_test_needs_dsc_aux_workaround_wrong_rev(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link.dpcd_caps.dpcd_rev.raw = 0x11; /* DPCD 1.1 */
@@ -128,7 +130,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_rev(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
@@ -146,7 +148,7 @@ static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *te
  */
 static void dm_mst_test_needs_dsc_aux_workaround_zero_sink_count(struct kunit *test)
 {
-	struct dc_link link = {0};
+	memset(&link, 0, sizeof(link));
 
 	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
 	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-- 
2.39.5

