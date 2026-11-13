Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FD606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0flahbq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBBC10E768;
	Fri, 13 Nov 2026 19:40:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF9310E768;
 Fri, 13 Nov 2026 19:40:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2A8F6263B;
 Fri, 13 Nov 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794598840;
 b=xckd6qHOK/uGBnlJxlxmNf4e2nSqeuDkO23RnUPDWu7Wak39w4eHZjetE5MwXzt8X1kj
 9J1sLiZoUWiXNFBQO3r2lBTEz1xQH/+Kfl8D4VI+CsJGMoZoHNuDjZ/YkqV4zuvD1It2i
 gLdkkeMxRSL8RwCJ2AzOG9FqLwwWnJG7TinveyakAiz2Yj3KqkrS0gXbEsbY3f9HPQKeF
 ocawO+AnMXjTlRWWhiEYA0ynbbLTOsBRkCATANoQQE/BV57uqFbi2THgm2ear/JMJoj4j
 oDzpOHKQmASYDhFe+t0H5d73ijt0vE8RNK/qfAEtYI9+FZPWg33e2gXwAZBCJMD0XKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794598840;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qrk9fKm+b1kNDtPLA6VtXnU0ubuHPuCETIzFTgwq880=;
 b=gIEQZe2F87hTgWoIEdRbw7hqaUecoSYlGSqwANQoZTR7G9BjgfC1nF0TGZngLSeXA9U0
 4arTyZJxDWudZNqQDawmVizEotjCIqnMepwb3lO2D2kHxPttMWzZQ553+n6+Xgebid5F9
 /BVcJjJFZ9ARNlJHQ1zTBLOcsOJm5r3Hzgf94cUG1UrTNfZMoXtLdAnxbVtHbgoClyASY
 xb6kOSFdv1epafGL6DPH9aJWnBW73BmoYSGzxmpjnLMgbRqHzi1o1giiKci6VEhFJcQ0U
 2wU2Wf0QeA5B/x3WDF9xXtHmhJMaEtGuBhLv0BmZyzPsPa1N7hjoNKGYWVpS0d7bw6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7D1FA1F000C4;
 Fri, 13 Nov 2026 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794598840;
 bh=qrk9fKm+b1kNDtPLA6VtXnU0ubuHPuCETIzFTgwq880=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=W0flahbqhVm0p/gv+o0EmwlNdVOGTjH7DWtcDGeZxqeWVhPgpCiR/jev06zsbKcWM
 3QKDJ0NoO2jWQOrH3wcQ5f+96VhCbjkFRhD8WrvnOf/xTnbp5qSbS6wcDKGrvg7yBu
 pIb4uSznE+OmgtRDNf1NuDGEYpoJIFWVFuv/PBd3KgF+ti6fJoYLlbMMYMpaq72cWC
 /oyCFldcdH3KpJ3WdfOSm0pIbjRm/mZenVyXTFQiCPxXXNJZdN682/pinmaVUQwrpf
 rFwtXU3DGEGxBA6+bjXcVJmVLNK4a+aadIrDoEDRI9CtZ1G2/oDADRkP7DGjgY7C26
 D9Q70yLVo4b4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F090549A97;
 Fri, 13 Nov 2026 19:40:38 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Fri, 13 Nov 2026 19:40:38 +0000
Subject: [PATCH v2 1/3] drm/amd/display: Add helpers to check PSR and
 Replay events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-amdgpu-psr-abm-update-next-v2-1-27ce790856ea@hsal.es>
References: <20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es>
In-Reply-To: <20261113-amdgpu-psr-abm-update-next-v2-0-27ce790856ea@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Roman Li <Roman.Li@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, 
 Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14271; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=MfVTCLx/oMjGtOBIEiL+NW97vKMUKzElNui5Z1Lcp90=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsr6nb/t1q0va7GeX+8Wvx45y3M6snV566FDCL7uJH
 FtXnn8lGlPSUcrCIMbFICumyKJ7w5OBZeLkmTlFz5fAzGFlAhnCwMUpABN5KsXIcEhQdrO7GJeo
 4r+++Bci/212u2mfWCstqnf15d0K4WVB3xj++1icyN0ZvcSclSM4eVqRzdvQ/6dFxVfN+dG0ndu
 mt/M5PwC9g0wl
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
Content-Transfer-Encoding: 8bit
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

amdgpu_dm can set and clear a PSR or Replay event on a stream, but has no
way to ask whether one is already set. An upcoming patch sets the
hw_programming events around an ABM level update. When one was already
set before the update, something else set it and will clear it, so the
patch has to leave it alone

Add amdgpu_dm_psr_event_is_set() and amdgpu_dm_replay_event_is_set(),
with KUnit tests. The Replay tests get an alloc_replay_dm() helper for
the power module setup that the existing tests repeated

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  24 +++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |  25 +++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h   |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |  60 ++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        | 102 +++++++++++++++------
 6 files changed, 188 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dbad0a6d3a2b4..181ddf36dde0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -194,6 +194,30 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream
 }
 EXPORT_IF_KUNIT(amdgpu_dm_psr_set_event);
 
+/**
+ * amdgpu_dm_psr_event_is_set() - check whether a PSR event is set for a stream
+ * @dm: pointer to amdgpu_display_manager
+ * @stream: pointer to dc_stream_state
+ * @event: PSR event type
+ *
+ * Return: true if PSR is enabled on @stream and @event is set, false otherwise
+ */
+bool amdgpu_dm_psr_event_is_set(struct amdgpu_display_manager *dm,
+				struct dc_stream_state *stream, enum psr_event event)
+{
+	unsigned int psr_events;
+
+	if (!stream || !stream->link ||
+	    !stream->link->psr_settings.psr_feature_enabled)
+		return false;
+
+	if (!mod_power_get_psr_event(dm->power_module, stream, &psr_events))
+		return false;
+
+	return psr_events & event;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_psr_event_is_set);
+
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 /**
  * amdgpu_dm_psr_get_dc_feature_mask() - Get DC feature mask for KUnit tests.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index e442e7ed82ec1..b777bc9cda1df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -41,6 +41,8 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
 bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
 		struct dc_stream_state *stream, bool set_event,	enum psr_event event,
 		bool wait_for_disable);
+bool amdgpu_dm_psr_event_is_set(struct amdgpu_display_manager *dm,
+				struct dc_stream_state *stream, enum psr_event event);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 bool link_supports_psrsu(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index ee2e4754b0894..3ed4b4fce50f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -208,3 +208,28 @@ bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
 					 set_event, event, wait_for_disable);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_replay_set_event);
+
+/**
+ * amdgpu_dm_replay_event_is_set() - check whether a replay event is set for a stream
+ * @dm: pointer to amdgpu_display_manager
+ * @stream: pointer to dc_stream_state
+ * @event: replay event type
+ *
+ * Return: true if replay is enabled on @stream and @event is set, false otherwise
+ */
+bool amdgpu_dm_replay_event_is_set(struct amdgpu_display_manager *dm,
+				   struct dc_stream_state *stream,
+				   enum replay_event event)
+{
+	unsigned int replay_events;
+
+	if (!stream || !stream->link ||
+	    !stream->link->replay_settings.replay_feature_enabled)
+		return false;
+
+	if (!mod_power_get_replay_event(dm->power_module, stream, &replay_events))
+		return false;
+
+	return replay_events & event;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_replay_event_is_set);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
index 021bf02555166..4970911d55954 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -40,4 +40,7 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
 		struct dc_stream_state *stream, bool set_event,
 		enum replay_event event, bool wait_for_disable);
+bool amdgpu_dm_replay_event_is_set(struct amdgpu_display_manager *dm,
+				   struct dc_stream_state *stream,
+				   enum replay_event event);
 #endif /* AMDGPU_DM_AMDGPU_DM_REPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 0a484ea7c0e8e..19c6792b1bed5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -627,6 +627,62 @@ static void dm_test_psr_set_event_updates_event(struct kunit *test)
 }
 /* End of tests for amdgpu_dm_psr_set_event() */
 
+/* Tests for amdgpu_dm_psr_event_is_set() */
+
+/**
+ * dm_test_psr_event_is_set_psr_not_enabled() - Disabled PSR reports no event.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_event_is_set_psr_not_enabled(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+	struct psr_caps caps = {0};
+	struct core_power *core_power;
+
+	caps.psr_version = 1;
+	core_power = create_test_power_module(test, stream, &caps);
+	dm->power_module = &core_power->mod_public;
+	stream->link->psr_settings.psr_feature_enabled = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_event_is_set(dm, stream, psr_event_vsync));
+}
+
+/**
+ * dm_test_psr_event_is_set_get_event_fails() - Failed power event read reports no event.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_event_is_set_get_event_fails(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+
+	dm->power_module = NULL;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_psr_event_is_set(dm, stream, psr_event_vsync));
+}
+
+/**
+ * dm_test_psr_event_is_set_reports_events() - Only events in mod_power are set.
+ * @test: KUnit test context.
+ */
+static void dm_test_psr_event_is_set_reports_events(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_stream_state *stream = alloc_test_psr_stream(test);
+	struct psr_caps caps = {0};
+	struct core_power *core_power;
+
+	caps.psr_version = 1;
+	core_power = create_test_power_module(test, stream, &caps);
+	dm->power_module = &core_power->mod_public;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_psr_event_is_set(dm, stream, psr_event_vsync));
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_psr_event_is_set(dm, stream, psr_event_hw_programming));
+}
+/* End of tests for amdgpu_dm_psr_event_is_set() */
+
 /* Tests for amdgpu_dm_psr_is_active_allowed() */
 
 /**
@@ -738,6 +794,10 @@ static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_psr_set_event_get_event_fails),
 	KUNIT_CASE(dm_test_psr_set_event_already_set),
 	KUNIT_CASE(dm_test_psr_set_event_updates_event),
+	/* amdgpu_dm_psr_event_is_set */
+	KUNIT_CASE(dm_test_psr_event_is_set_psr_not_enabled),
+	KUNIT_CASE(dm_test_psr_event_is_set_get_event_fails),
+	KUNIT_CASE(dm_test_psr_event_is_set_reports_events),
 	/* amdgpu_dm_psr_is_active_allowed */
 	KUNIT_CASE(dm_test_psr_is_active_allowed_no_streams),
 	KUNIT_CASE(dm_test_psr_is_active_allowed_null_link),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
index 6f633b1bbaca9..1849e2b6022e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
@@ -505,17 +505,11 @@ static void dm_test_replay_set_event_missing_power_module(struct kunit *test)
 							    replay_event_vsync, false));
 }
 
-/**
- * dm_test_replay_set_event_already_set - Verify no-op when event already active
- * @test: KUnit test context
- *
- * When the requested event is already in the desired state, the function should
- * return true without calling mod_power_set_replay_event().
- */
-static void dm_test_replay_set_event_already_set(struct kunit *test)
+static struct amdgpu_display_manager *alloc_replay_dm(struct kunit *test,
+						      struct dc_stream_state *stream,
+						      unsigned int replay_events)
 {
 	struct amdgpu_display_manager *dm;
-	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
 	struct core_power *core_power;
 	struct power_entity *map;
 
@@ -528,13 +522,27 @@ static void dm_test_replay_set_event_already_set(struct kunit *test)
 	map = kunit_kzalloc(test, sizeof(*map), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, map);
 
-	/* Wire the power module so mod_power_get_replay_event() succeeds */
-	map->stream = ctx->stream;
-	map->replay_events = replay_event_vsync;
+	map->stream = stream;
+	map->replay_events = replay_events;
 	core_power->map = map;
 	core_power->num_entities = 1;
 	dm->power_module = &core_power->mod_public;
 
+	return dm;
+}
+
+/**
+ * dm_test_replay_set_event_already_set - Verify no-op when event already active
+ * @test: KUnit test context
+ *
+ * When the requested event is already in the desired state, the function should
+ * return true without calling mod_power_set_replay_event().
+ */
+static void dm_test_replay_set_event_already_set(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct amdgpu_display_manager *dm = alloc_replay_dm(test, ctx->stream, replay_event_vsync);
+
 	ctx->link->replay_settings.replay_feature_enabled = true;
 
 	/* Event already set — should return true without calling set */
@@ -551,32 +559,66 @@ static void dm_test_replay_set_event_already_set(struct kunit *test)
  */
 static void dm_test_replay_set_event_already_clear(struct kunit *test)
 {
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct amdgpu_display_manager *dm = alloc_replay_dm(test, ctx->stream, 0);
+
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	/* Clearing an event that's already clear — should return true */
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, false,
+							   replay_event_vsync, false));
+}
+
+/* Tests for amdgpu_dm_replay_event_is_set() */
+
+/**
+ * dm_test_replay_event_is_set_feature_disabled - Disabled Replay reports no event
+ * @test: KUnit test context
+ */
+static void dm_test_replay_event_is_set_feature_disabled(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
 	struct amdgpu_display_manager *dm;
+
+	dm = alloc_replay_dm(test, ctx->stream, replay_event_vsync);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_event_is_set(dm, ctx->stream,
+							       replay_event_vsync));
+}
+
+/**
+ * dm_test_replay_event_is_set_missing_power_module - Missing power module reports no event
+ * @test: KUnit test context
+ */
+static void dm_test_replay_event_is_set_missing_power_module(struct kunit *test)
+{
 	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
-	struct core_power *core_power;
-	struct power_entity *map;
+	struct amdgpu_display_manager *dm;
 
 	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm);
+	ctx->link->replay_settings.replay_feature_enabled = true;
 
-	core_power = kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, core_power);
-
-	map = kunit_kzalloc(test, sizeof(*map), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, map);
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_event_is_set(dm, ctx->stream,
+							       replay_event_vsync));
+}
 
-	/* Wire the power module — replay_events has NO vsync bit */
-	map->stream = ctx->stream;
-	map->replay_events = 0;
-	core_power->map = map;
-	core_power->num_entities = 1;
-	dm->power_module = &core_power->mod_public;
+/**
+ * dm_test_replay_event_is_set_reports_events - Only events in mod_power are set
+ * @test: KUnit test context
+ */
+static void dm_test_replay_event_is_set_reports_events(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct amdgpu_display_manager *dm;
 
+	dm = alloc_replay_dm(test, ctx->stream, replay_event_vsync);
 	ctx->link->replay_settings.replay_feature_enabled = true;
 
-	/* Clearing an event that's already clear — should return true */
-	KUNIT_EXPECT_TRUE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, false,
-							   replay_event_vsync, false));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_replay_event_is_set(dm, ctx->stream,
+							      replay_event_vsync));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_event_is_set(dm, ctx->stream,
+							       replay_event_hw_programming));
 }
 
 static struct kunit_case dm_replay_test_cases[] = {
@@ -611,6 +653,10 @@ static struct kunit_case dm_replay_test_cases[] = {
 	KUNIT_CASE(dm_test_replay_set_event_missing_power_module),
 	KUNIT_CASE(dm_test_replay_set_event_already_set),
 	KUNIT_CASE(dm_test_replay_set_event_already_clear),
+	/* amdgpu_dm_replay_event_is_set */
+	KUNIT_CASE(dm_test_replay_event_is_set_feature_disabled),
+	KUNIT_CASE(dm_test_replay_event_is_set_missing_power_module),
+	KUNIT_CASE(dm_test_replay_event_is_set_reports_events),
 	{}
 };
 

-- 
2.56.0


