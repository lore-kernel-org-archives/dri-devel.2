Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E3606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=cwooper.dev header.i=@cwooper.dev header.a=rsa-sha256 header.s=key1 header.b=tiYtFgq6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1CD10EA24;
	Sun,  1 Nov 2026 12:02:51 +0000 (UTC)
X-Greylist: delayed 371 seconds by postgrey-1.36 at gabe;
 Sat, 31 Oct 2026 04:25:13 UTC
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AACA10E193
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:25:13 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=Jpm4hUEiEt808dRSR8x297ZiH9nhQqjGAjQNsGPCmPY=; 
 c=simple/simple; d=cwooper.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793420711; v=1; x=1794025511;
 b=tiYtFgq6rhmg42cTGn/qdQvpzJFgcdmNLwS7yC7f1AQCtoPLEZn+kNinzdV8Fa7TYyMQgoYt
 hszX6RTUH3KYNT00s8t0N/MAEM7uKzU2dU9pVE8ki27Y7ZcE6SRPGg04/CSsESHAbXx1hnRlvaP
 HlkLpeTVQMDRxH24aEuqA7nSU479rjo4Oq6SvDYlfPkImwwvSba5cTPpwXhECBwcx2nchrZjQam
 mJSrRUNI0LnQZCEXDvPtlCvylT7IBRVZ5jjcdrh+EQ6SsefiAgubeD2mMOuWZrglKCxgAkIxi1t
 uv13VjIe0O3JmkCN/tDCniK8IsMrj6KL1Qgzp71uzYj7Q==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id da7909de37f0bb45;
 Sat, 31 Oct 2026 04:19:06 +0000
X-Mizu-Trace-ID: da7909de37f0bb45
X-Migadu-Flow: FLOW_OUT
From: Cooper Morgan <ext-github@cwooper.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: Use FreeSync v3 infopacket for sinks
 above 255 Hz
Date: Fri, 30 Oct 2026 21:18:26 -0700
Message-ID: <20261031041827.162730-3-ext-github@cwooper.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031041827.162730-1-ext-github@cwooper.dev>
References: <20261031041827.162730-1-ext-github@cwooper.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Native DP, eDP, and HDMI sinks get the v1 FreeSync infopacket unless
they are a whitelisted PCON or support Replay. v1 holds each refresh
rate in one byte, so a sink whose range goes above 255 Hz cannot be
told its real maximum. The v3 packet carries the high bits in
PB11/PB12.

The AMD VSDB version was stored for DP and eDP sinks only when they
support Replay. Store it for every DP and eDP sink, as the HDMI path
already does, and send v3 when the sink advertises AMD VSDB v3 and its
maximum refresh rate is above 255 Hz. The choice follows the sink's
maximum rather than the current mode, so such a sink gets v3 at every
mode and the packet version stays fixed per sink. Sinks whose maximum
is 255 Hz or less are unchanged.

Storing the VSDB version for DP sinks and selecting v3 from it follows
sunryze's approach in the linked issue.

Tested with this series backported to v7.2.13 on an MSI MAG 271QPX32
(AMD VSDB v3, 48-320 Hz) over DP 1.4 on an RX 9070 XT: 320 Hz shows a
correct picture, and with VRR active the refresh rate tracks frame
caps of 300, 270, and 100 Hz. At 240 Hz, where the sink now gets v3
instead of v1, the picture is correct and VRR tracks a 100 Hz cap.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5988
Signed-off-by: Cooper Morgan <ext-github@cwooper.dev>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  7 +++
 .../tests/amdgpu_dm_connector_test.c          | 25 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 59 +++++++++++++++++++
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index bc5745a5b..25b4d575e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3912,10 +3912,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 
 		get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+		amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
 
 		if (vsdb_info.replay_mode) {
 			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 386ba88c5..6cfeb9d6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -269,6 +269,13 @@ void amdgpu_dm_update_freesync_state_on_stream(
 
 		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
 					&new_stream->adaptive_sync_infopacket);
+	} else if (aconn && aconn->vsdb_info.amd_vsdb_version == 3 &&
+		   aconn->max_vfreq > 255) {
+		/*
+		 * v1 saturates at 255 Hz. Keyed on the sink's max, not the mode's
+		 * rate, so the packet version stays fixed per sink.
+		 */
+		packet_type = PACKET_TYPE_FS_V3;
 	}
 
 	mod_freesync_build_vrr_infopacket(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index acde20241..001155f56 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9554,6 +9554,30 @@ static void dm_test_fs_caps_edp_replay_mode(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->as_type, (int)ADAPTIVE_SYNC_TYPE_EDP);
 }
 
+/**
+ * dm_test_fs_caps_dp_vsdb_version - Test a DP sink's VSDB version without replay
+ * @test: The KUnit test context
+ *
+ * The version selects the FreeSync infopacket, so it is kept for every DP sink,
+ * and a later sink without the VSDB clears it.
+ */
+static void dm_test_fs_caps_dp_vsdb_version(struct kunit *test)
+{
+	struct dm_test_fs_caps_ctx *ctx =
+		dm_test_fs_caps_ctx_alloc(test, SIGNAL_TYPE_DISPLAY_PORT);
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base,
+				       dm_test_fs_edid_amd_vsdb(test, 0, 0, 0), false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->aconnector->vsdb_info.replay_mode);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->vsdb_info.amd_vsdb_version, 3);
+
+	amdgpu_dm_update_freesync_caps(&ctx->aconnector->base,
+				       dm_test_fs_edid_displayid(test, 40, 144), false);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->vsdb_info.amd_vsdb_version, 0);
+}
+
 /**
  * dm_test_fs_caps_hdmi_vsdb - Test the HDMI AMD VSDB refresh range
  * @test: The KUnit test context
@@ -10425,6 +10449,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fs_caps_dp_narrow_range),
 	KUNIT_CASE(dm_test_fs_caps_dp_msa_not_allowed),
 	KUNIT_CASE(dm_test_fs_caps_edp_replay_mode),
+	KUNIT_CASE(dm_test_fs_caps_dp_vsdb_version),
 	KUNIT_CASE(dm_test_fs_caps_hdmi_vsdb),
 	KUNIT_CASE(dm_test_fs_caps_hdmi_no_vsdb),
 	KUNIT_CASE(dm_test_fs_caps_pcon_whitelist),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index b603516e2..b1a414445 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -720,6 +720,61 @@ static void dm_test_update_freesync_state_dp_v2_saturates(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, p.sb[8], 255);
 }
 
+/**
+ * dm_test_update_freesync_state_dp_v3_above_255 - Test v3 for a VSDB v3 sink above 255Hz
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_dp_v3_above_255(struct kunit *test)
+{
+	struct dc_info_packet p =
+		dm_test_freesync_packet(test, SIGNAL_TYPE_DISPLAY_PORT, 3, 320, 320);
+
+	KUNIT_EXPECT_EQ(test, p.hb3, 3 << 2);
+	KUNIT_EXPECT_EQ(test, p.sb[8], 320 & 0xff);
+	KUNIT_EXPECT_EQ(test, p.sb[12], 320 >> 8);
+}
+
+/**
+ * dm_test_update_freesync_state_dp_v3_mode_240 - Test v3 follows the sink max, not the mode
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_dp_v3_mode_240(struct kunit *test)
+{
+	struct dc_info_packet p =
+		dm_test_freesync_packet(test, SIGNAL_TYPE_DISPLAY_PORT, 3, 320, 240);
+
+	KUNIT_EXPECT_EQ(test, p.hb3, 3 << 2);
+	KUNIT_EXPECT_EQ(test, p.sb[8], 240);
+	KUNIT_EXPECT_EQ(test, p.sb[12], 0);
+}
+
+/**
+ * dm_test_update_freesync_state_dp_v3_at_255 - Test a VSDB v3 sink at 255Hz keeps v1
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_dp_v3_at_255(struct kunit *test)
+{
+	struct dc_info_packet p =
+		dm_test_freesync_packet(test, SIGNAL_TYPE_DISPLAY_PORT, 3, 255, 255);
+
+	KUNIT_EXPECT_EQ(test, p.hb3, 0x04);
+	KUNIT_EXPECT_EQ(test, p.sb[8], 255);
+}
+
+/**
+ * dm_test_update_freesync_state_hdmi_v3_above_255 - Test v3 for a VSDB v3 HDMI sink
+ * @test: The KUnit test context
+ */
+static void dm_test_update_freesync_state_hdmi_v3_above_255(struct kunit *test)
+{
+	struct dc_info_packet p =
+		dm_test_freesync_packet(test, SIGNAL_TYPE_HDMI_TYPE_A, 3, 320, 320);
+
+	KUNIT_EXPECT_EQ(test, p.hb1, 3);
+	KUNIT_EXPECT_EQ(test, p.sb[8], 320 & 0xff);
+	KUNIT_EXPECT_EQ(test, p.sb[12], 320 >> 8);
+}
+
 /* Tests for amdgpu_dm_update_stream_irq_parameters() */
 
 /**
@@ -957,6 +1012,10 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_update_freesync_state_pcon_v3),
 	KUNIT_CASE(dm_test_update_freesync_state_pcon_default),
 	KUNIT_CASE(dm_test_update_freesync_state_dp_v2_saturates),
+	KUNIT_CASE(dm_test_update_freesync_state_dp_v3_above_255),
+	KUNIT_CASE(dm_test_update_freesync_state_dp_v3_mode_240),
+	KUNIT_CASE(dm_test_update_freesync_state_dp_v3_at_255),
+	KUNIT_CASE(dm_test_update_freesync_state_hdmi_v3_above_255),
 	/* amdgpu_dm_update_stream_irq_parameters */
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_no_stream),
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_invalid_timing),
-- 
2.56.0

