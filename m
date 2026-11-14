Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17498606A89B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8/0cmMm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E267310E234;
	Sat, 14 Nov 2026 23:09:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3319410E1CB;
 Sat, 14 Nov 2026 23:09:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D1244607D;
 Sat, 14 Nov 2026 23:09:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794697758;
 b=ZYt08MWJLc5u6CqLJI+7qvfOXCukPfWxdgBakUwEkAgXn8c760qlpNu+OFGtKrCoQUbj
 eJwjyM1vnT6UG1cke+JxYFHv9uKL760639SZF8y4LELxMF2Ga55HfUngmDvvDuN8LkrSS
 /1lYmH7YOfAVnL0YKzhLYYs5JqvGMRt/UIiD+5IOEdMW223z9Zu/Yv0yIlF9fvVcRXrnm
 8KraTq/BE13NXfvhLRy3jrnxPV8cwMEHWp6m9uibBAZHjWS7aTZ4nzVug75nNxXEKbxp+
 6R60D9HFWps+hHMVgDzW6J5xskA2A88CycGngjbiFEYw3cUZPSSLDfGfu+ulmT8prmA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794697758;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=i6meqUZWlsUzsQisK+Q2k0oCyhUO59VVwpXdQtBM5c8=;
 b=KwC420AwK2pFfxU+qhv7tCGhkq/ShXdUqgg7OwUyMujVMRN2rcHq0WyEYwM8Hmd/sSn5
 bFSMf3CXsZDOZPFDr+BW10ezunI9zv0oLOj5BMzak62RoM6iNC1YwOYTPdadPaU6WAFkr
 PX2ldSP+eAAV73Sg+hxW9sLaQAN1rFnoVLvA3JISrdF5WC7o/tEdd6MJHkF4+vyNfBYr5
 2EVYcsd8ZyxnTNAm+xZNm2u8d+k+s1VaSBR2AVpfiPnNUgRIW3Rk7UvXa/BUfBMnFMgcW
 bGctrfjkd/xXXKfl5kVCUu6lOlKAFmkP37L3mv2+prJ3D3zasRp3nzzPDPEXMq8z+sg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 303991F000D0;
 Sat, 14 Nov 2026 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794697758;
 bh=i6meqUZWlsUzsQisK+Q2k0oCyhUO59VVwpXdQtBM5c8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=T8/0cmMmqQmzT+2+kNYdWslUfCClIRxXkbRfWLoVGpsswpehCritVpKpstEVkDQaE
 fnIwLOzPauE5QN9pINk1+kDFRR8SaNc2QfArNhnu1NophbhepL2M7kQiAkbsgp/zT5
 r1dG7qfsQFMT+Z9NqVuKMF9F2UXxfrkQybaTkvct/O8uRwE+Ji3O3EXrqe5o08albS
 s5WfTrYDEdkv4cAJqTtIpey5w8F5rpeE1j0IGMHMa9s/9nu+I5tr4q5BrEEaHwkOwb
 ahVMOt3aP7zKA6iaZi0fjNTxNY5UGD70iTsXfmWjdwY468P9P4bDUy9RNpZTx8ddPq
 sWf/yUV4314Rg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 906B649ED7;
 Sat, 14 Nov 2026 23:09:14 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Sat, 14 Nov 2026 23:09:19 +0000
Subject: [PATCH 8/8] drm/amd/display: Add KUnit tests for the mode copies
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-amdgpu-modes-four-v1-8-f11e2a6cd407@hsal.es>
References: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
In-Reply-To: <20261114-amdgpu-modes-four-v1-0-f11e2a6cd407@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ray Wu <ray.wu@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10931; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=0Ok0LbQjfbD5jZ0plsL2pNY0UFR/TkJW9zWYDxB4hFk=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn68kigO08yI/TLvq0xof9B+n5cWN1k3BC/1tjXsP
 NSterF28r6OUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmEjMG4b/uYnKJ/dc/95i
 u41zRQwz24XdNQuV4rZuswg/mlUQJrzeguGv7IsPt/583LnNq6JPevI2vz9Xlki6feBmVvk94Uf
 Gopl7GAAHek47
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 7bit
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

Test that atomic_check reads the mode copies, not connector->modes, and
only for the sink they came from. The highest refresh rate lookup
returns nothing without a copy, even with modes in connector->modes, and
nothing for a sink with another EDID or none, while a replugged sink
with the same EDID keeps the copy. Scaling ignores a preferred mode copy
from another sink, and dm_set_freesync_video_config() sets the fixed
refresh config only when the copies match the new stream's sink

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 120 +++++++++++++++++++++
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  69 ++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 71ad7e4ea5c9e..6fbf85e50872c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2534,6 +2534,95 @@ static void dm_test_highest_refresh_preferred_mode(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, aconnector->freesync_vid_base.clock, 0);
 }
 
+/**
+ * dm_test_highest_refresh_skips_modes - Test atomic_check callers never walk base.modes
+ * @test: The KUnit test context
+ *
+ * base.modes needs &drm_mode_config.mutex, which atomic_check doesn't hold.
+ * Without a copy the lookup returns NULL, even though base.modes has a mode
+ */
+static void dm_test_highest_refresh_skips_modes(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_sink *sink;
+	struct drm_display_mode *mode;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	INIT_LIST_HEAD(&aconnector->base.modes);
+	INIT_LIST_HEAD(&aconnector->base.probed_modes);
+
+	mode->type = DRM_MODE_TYPE_PREFERRED;
+	mode->clock = 148500;
+	mode->hdisplay = 1920;
+	mode->vdisplay = 1080;
+	mode->htotal = 2200;
+	mode->vtotal = 1125;
+	list_add_tail(&mode->head, &aconnector->base.modes);
+
+	sink = dm_test_copies_sink(test, aconnector);
+	KUNIT_EXPECT_NULL(test, dm_test_highest_locked(test, aconnector, false, sink));
+	KUNIT_EXPECT_EQ(test, aconnector->freesync_vid_base.clock, 0);
+}
+
+/**
+ * dm_test_highest_refresh_other_sink - Test a copy from another sink is ignored
+ * @test: The KUnit test context
+ *
+ * After a monitor swap the copy describes the previous monitor until the next
+ * probe, so a sink with another EDID, or with none, gets no freesync base. A
+ * new sink with the same EDID, as after a replug, keeps it
+ */
+static void dm_test_highest_refresh_other_sink(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *mode;
+	struct dc_sink *probed, *other, *replugged, *no_edid;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	other = kunit_kzalloc(test, sizeof(*other), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+	replugged = kunit_kzalloc(test, sizeof(*replugged), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, replugged);
+	no_edid = kunit_kzalloc(test, sizeof(*no_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, no_edid);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	INIT_LIST_HEAD(&aconnector->base.probed_modes);
+	aconnector->freesync_vid_base.clock = 148500;
+	aconnector->freesync_vid_base.hdisplay = 1920;
+	aconnector->freesync_vid_base.vdisplay = 1080;
+	aconnector->freesync_vid_base.htotal = 2200;
+	aconnector->freesync_vid_base.vtotal = 1125;
+	drm_mode_copy(mode, &aconnector->freesync_vid_base);
+
+	probed = dm_test_copies_sink(test, aconnector);
+	replugged->dc_edid = probed->dc_edid;
+	other->dc_edid = probed->dc_edid;
+	other->dc_edid.raw_edid[12]++;
+
+	KUNIT_EXPECT_PTR_EQ(test,
+			    dm_test_highest_locked(test, aconnector, false, probed),
+			    &aconnector->freesync_vid_base);
+	KUNIT_EXPECT_TRUE(test, dm_test_is_fs_video_locked(test, mode, aconnector, probed));
+	KUNIT_EXPECT_PTR_EQ(test,
+			    dm_test_highest_locked(test, aconnector, false, replugged),
+			    &aconnector->freesync_vid_base);
+
+	KUNIT_EXPECT_NULL(test, dm_test_highest_locked(test, aconnector, false, other));
+	KUNIT_EXPECT_FALSE(test, dm_test_is_fs_video_locked(test, mode, aconnector, other));
+	KUNIT_EXPECT_NULL(test,
+			  dm_test_highest_locked(test, aconnector, false, no_edid));
+	KUNIT_EXPECT_NULL(test, dm_test_highest_locked(test, aconnector, false, NULL));
+}
+
 /* Tests for amdgpu_dm_connector_update_mode_copies() */
 
 static struct drm_display_mode *
@@ -8233,6 +8322,34 @@ static void dm_test_create_validate_stream_scaled_copy(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_cvs_first_h_addressable, 3840);
 }
 
+/**
+ * dm_test_create_validate_stream_stale_copy - Test atomic_check ignores a stale copy
+ * @test: The KUnit test context
+ *
+ * After a monitor swap the connector has a sink with another EDID, and the
+ * copy describes the previous monitor. Its timing must not be applied, even
+ * with scaling on
+ */
+static void dm_test_create_validate_stream_stale_copy(struct kunit *test)
+{
+	struct dm_test_cvs_dc *c = dm_test_cvs_dc_alloc(test);
+
+	/* drm_mode_convert_umode() fills in the CRTC timing of atomic modes */
+	drm_mode_set_crtcinfo(c->mode, CRTC_INTERLACE_HALVE_V);
+	c->dm_state->scaling = RMX_FULL;
+	dm_test_cvs_set_preferred_copy(test, c);
+	c->aconnector->dc_sink->dc_edid.raw_edid[12]++;
+	c->tgfuncs->validate_timing = dm_test_cvs_record_first_h_addressable;
+	dm_test_cvs_first_h_addressable = 0;
+
+	KUNIT_EXPECT_NULL(test,
+			  dm_test_validate_locked(&c->aconnector->base,
+						  c->mode,
+						  c->dm_state,
+						  NULL));
+	KUNIT_EXPECT_EQ(test, dm_test_cvs_first_h_addressable, 1920);
+}
+
 /**
  * dm_test_mode_valid_ignores_preferred_copy - Test mode_valid uses the mode's own timing
  * @test: The KUnit test context
@@ -11271,6 +11388,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_highest_refresh_cached_base),
 	KUNIT_CASE(dm_test_highest_refresh_preferred_mode),
 	KUNIT_CASE(dm_test_highest_refresh_probed_skips_copy),
+	KUNIT_CASE(dm_test_highest_refresh_skips_modes),
+	KUNIT_CASE(dm_test_highest_refresh_other_sink),
 	/* amdgpu_dm_connector_update_mode_copies */
 	KUNIT_CASE(dm_test_update_mode_copies_highest_refresh),
 	KUNIT_CASE(dm_test_update_mode_copies_no_preferred),
@@ -11503,6 +11622,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_validate_stream_prune_context),
 	KUNIT_CASE(dm_test_create_validate_stream_hdmi_rgb_first),
 	KUNIT_CASE(dm_test_create_validate_stream_scaled_copy),
+	KUNIT_CASE(dm_test_create_validate_stream_stale_copy),
 	KUNIT_CASE(dm_test_mode_valid_ignores_preferred_copy),
 	/* amdgpu_dm_update_connector_after_detect */
 	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 8eaa5909068bc..b6b3964ce497d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3296,6 +3296,74 @@ static void dm_test_freesync_video_config_no_old_stream(struct kunit *test)
 	amdgpu_freesync_vid_mode = saved_vid_mode;
 }
 
+/**
+ * dm_test_freesync_video_config_new_sink - Test the fixed config follows the new stream's sink
+ * @test: The KUnit test context
+ *
+ * The mode is a 50 Hz FreeSync video mode of a 1080p60 base. The fixed config
+ * is set only when the copies match the sink the new stream was built for,
+ * the sink create_stream_for_sink() checked when it picked the timing
+ */
+static void dm_test_freesync_video_config_new_sink(struct kunit *test)
+{
+	uint saved_vid_mode = amdgpu_freesync_vid_mode;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *base, *mode;
+	struct dm_crtc_state *crtc_state;
+	struct dc_stream_state *stream;
+	struct dc_sink *sink, *other;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	other = kunit_kzalloc(test, sizeof(*other), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	base = &aconnector->freesync_vid_base;
+	base->clock = 148500;
+	base->hdisplay = 1920;
+	base->hsync_start = 2008;
+	base->hsync_end = 2052;
+	base->htotal = 2200;
+	base->vdisplay = 1080;
+	base->vsync_start = 1084;
+	base->vsync_end = 1089;
+	base->vtotal = 1125;
+
+	mode = &crtc_state->base.mode;
+	drm_mode_copy(mode, base);
+	mode->vsync_start += 225;
+	mode->vsync_end += 225;
+	mode->vtotal += 225;
+
+	memset(sink->dc_edid.raw_edid, 0x5a, 128);
+	sink->dc_edid.length = 128;
+	other->dc_edid = sink->dc_edid;
+	other->dc_edid.raw_edid[12]++;
+	aconnector->mode_copies_edid_size = 128;
+	memcpy(aconnector->mode_copies_edid, sink->dc_edid.raw_edid, 128);
+
+	amdgpu_freesync_vid_mode = 1;
+
+	stream->sink = other;
+	dm_test_fs_video_config_locked(test, aconnector, crtc_state, stream);
+	KUNIT_EXPECT_EQ(test, (int)crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+
+	stream->sink = sink;
+	dm_test_fs_video_config_locked(test, aconnector, crtc_state, stream);
+	KUNIT_EXPECT_EQ(test, (int)crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+
+	amdgpu_freesync_vid_mode = saved_vid_mode;
+}
+
 /**
  * dm_test_update_crtc_state_unchanged - Test unchanged state needs no validation
  * @test: The KUnit test context
@@ -5443,6 +5511,7 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
 	KUNIT_CASE(dm_test_freesync_video_config_no_old_stream),
+	KUNIT_CASE(dm_test_freesync_video_config_new_sink),
 	KUNIT_CASE(dm_test_update_crtc_state_unchanged),
 	KUNIT_CASE(dm_test_update_plane_state_detached),
 	KUNIT_CASE(dm_test_mod_power_update_streams_empty),

-- 
2.56.0


