Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE2C88E6A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FA910E9F9;
	Sun, 13 Sep 2026 20:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="1ppHOcoh";
	dkim-atps=neutral
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD2A10F674
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:13:24 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hhJ2p73XDz9V1;
 Fri, 11 Sep 2026 17:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
 s=20250113; t=1789139602;
 bh=BJ4BHJ5I3o/lGlBOtZ6qsSILrtULmXOdWu3DEGOudng=;
 h=From:To:Cc:Subject:Date:From;
 b=1ppHOcohDnsGGaO7HoDHo/WxEWtobcfKNzKpZcWyEkKDq1BLb0uMTFFyNHzpl6Ow8
 7bpC6k+6+sQpu8Mw7YQkvi7ihrNqmk6YjDGn7KZ/d8Hw2SE13UeUqUr1CAJ+gbhGpP
 t5ikD/YkLqdl/H6BT4+Y6jWddBmeeWT+ppTriCqyBp367WIGy7EUIxek6nfrnFilFH
 IWIlo77vHoeiSGHUkTD/R2VwCxCp2togcwZEqEkMbXUYootT5u5XFSw1th8vzG4P1+
 14yNH1jmCNB9zfavS666qtnwW0LEZvLwZSfZs/X+xxO/joVGFNkoZRb9Ahgfe5Gq+J
 4ScOBpV8/GJMQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hhJ2n5KGYzc1x; Fri, 11 Sep 2026 17:13:21 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Adolfo Rodrigues <adolfotregosa@gmail.com>
Subject: [PATCH] drm/amd/display: Try RGB before YCbCr 4:4:4 in stream
 validation
Date: Fri, 11 Sep 2026 17:13:14 +0200
Message-ID: <20260911151314.66957-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

amdgpu_dm_create_validate_stream_for_sink() walks encoding_order[] and
uses the first encoding that validates. YCbCr 4:4:4 is listed before
RGB, so an HDMI sink that advertises 4:4:4 gets YCbCr 4:4:4 whenever the
"color format" property is left at AUTO, even though RGB fits the same
link.

That contradicts the documented AUTO behaviour for HDMI in enum
drm_connector_color_format (RGB, falling back to YCbCr 4:2:0 only when
the bandwidth is not available or the mode is 4:2:0-only), which the
amdgpu implementation of the property also describes. It also leaves
the "Broadcast RGB" property without effect on such sinks, since the
quantization range it selects only applies to RGB output.

Try RGB first. The mask still holds every encoding the sink supports,
so a mode that cannot carry RGB falls back exactly as before.

For reference, v7.2 picked RGB here unless YCbCr 4:4:4 was forced
through debugfs, while earlier kernels picked YCbCr 4:4:4 for any HDMI
sink that advertised it.

Fixes: 0b0ff65d3ca1 ("drm/amd/display: Refactor stream validation")
Suggested-by: Adolfo Rodrigues <adolfotregosa@gmail.com>
Tested-by: Adolfo Rodrigues <adolfotregosa@gmail.com>
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude Code:claude-fable-5-1
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +-
 .../tests/amdgpu_dm_connector_test.c          | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 0b446133edd8..98d0b35ed4e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2226,8 +2226,8 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 * below gate which of these entries are actually attempted.
 	 */
 	static const enum dc_pixel_encoding encoding_order[] = {
-		PIXEL_ENCODING_YCBCR444,
 		PIXEL_ENCODING_RGB,
+		PIXEL_ENCODING_YCBCR444,
 		PIXEL_ENCODING_YCBCR422,
 		PIXEL_ENCODING_YCBCR420,
 	};
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 6e70d72135dc..c064def8253b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7175,6 +7175,39 @@ static void dm_test_create_validate_stream_prune_context(struct kunit *test)
 								    NULL));
 }
 
+static enum dc_pixel_encoding dm_test_cvs_first_encoding;
+
+static bool dm_test_cvs_record_first_encoding(struct timing_generator *tg,
+					      const struct dc_crtc_timing *timing)
+{
+	if (dm_test_cvs_first_encoding == PIXEL_ENCODING_UNDEFINED)
+		dm_test_cvs_first_encoding = timing->pixel_encoding;
+
+	return false;
+}
+
+/**
+ * dm_test_create_validate_stream_hdmi_rgb_first - HDMI tries RGB before YCbCr 4:4:4
+ * @test: The KUnit test context
+ */
+static void dm_test_create_validate_stream_hdmi_rgb_first(struct kunit *test)
+{
+	struct dm_test_cvs_dc *c = dm_test_cvs_dc_alloc(test);
+
+	c->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	c->aconnector->base.display_info.color_formats =
+		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
+	c->tgfuncs->validate_timing = dm_test_cvs_record_first_encoding;
+	dm_test_cvs_first_encoding = PIXEL_ENCODING_UNDEFINED;
+
+	KUNIT_EXPECT_NULL(test,
+			  amdgpu_dm_create_validate_stream_for_sink(&c->aconnector->base,
+								    c->mode,
+								    c->dm_state,
+								    NULL));
+	KUNIT_EXPECT_EQ(test, (int)dm_test_cvs_first_encoding, (int)PIXEL_ENCODING_RGB);
+}
+
 /* Further tests for amdgpu_dm_connector_mode_valid() */
 
 /**
@@ -9268,6 +9301,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_validate_stream_force_ycbcr444),
 	KUNIT_CASE(dm_test_create_validate_stream_prune_timing),
 	KUNIT_CASE(dm_test_create_validate_stream_prune_context),
+	KUNIT_CASE(dm_test_create_validate_stream_hdmi_rgb_first),
 	/* amdgpu_dm_update_connector_after_detect */
 	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
 	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),
-- 
2.55.0

