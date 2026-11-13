Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69027606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elazThG7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC7C10EC86;
	Fri, 13 Nov 2026 19:40:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F2010EC86;
 Fri, 13 Nov 2026 19:40:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B41962FBD;
 Fri, 13 Nov 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794598840;
 b=iqTjfjruRbDHRunBjpnx3yjq6YIR6bQjjy8WIZXX+g72G8ZC4DWdBzR/tEaFfvK/ZiNW
 vYNZ/YQCLYBqaCJO2XbrVQtpJksiV1tdusMxb3Cerseunmb6iZoyLyaqbHfoPeXNq8XVN
 Y+5o0NqAUKM2vR8xyKV6515aopMTagaGtqpBeWLociiblpD41V4eCXoohfro58v3mcw0j
 pRhxkv9wq8DwFNMrvt43sWrXGSpSQK74EBg2Y3ozMz/PmRShdrlth2Y58Z0P6zS+MfhTA
 DNemThcAyzt/eWCJrhvNO0cLQ0AHcGNYtCNLgUy2070lajgtFN3kEAe8POuW9xWzOYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794598840;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=BPepXkgxN2/CunE+vUYRGUqFnou6gzA2QcmaiD1UYUk=;
 b=hjVUL7919blvIb4j5AgIClQ5ufBDiHXxgFuJrX3fqhlSe1YkKLCWh95OlnEdMMV04c7p
 hK+QzWd9RWbSLL45OkUievb6n+ouubKiCojo9/my3TCIeFM0py/85hLDzHgSMN+uXOBSu
 CGJdx821M96wNUkEvqvKv8QBGFRYl32gplevhCuhxI3Ex6QlNYtOgBK29ZnkJUEB+Q7se
 w/Atb0K2ruke6wLzmWHHlvrFt0jk7CZWXf0/5lgl4zRZIh6unQWVGwQhm2F+hS5HRaKOg
 k+XYzvuC9tJsIke5GIohL18g8/Tqi6qTMkfaT9KzwsUHVpZedNZ7u3DdHf1MZ1DNOCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7F6FF1F000C6;
 Fri, 13 Nov 2026 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794598840;
 bh=BPepXkgxN2/CunE+vUYRGUqFnou6gzA2QcmaiD1UYUk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=elazThG7cdNCZfnsJ6GFeL379t+eCdHKuSacgLnlJYWQi62P/INepGOPDQSrh97cU
 nAKgDoRl/LBXKidGXeyJ3eqpVP/o0ewCgm2lNkA2KcgWlvNTFkwnlbhqn1WVDdxeny
 K1V4r4i3FfOVCmQ8vfXYj0AX4fLSzZd07NKVJaoj6TR4OQ3wF+ggH/SM6AsnIYIPcK
 nxYaX9v1/wXYNGnVP9UXZIJ+lZOVzEIXzB6IgjXgx67QPif66OTGmQjnHQAQc3bRFp
 LFcnB8S9uxUd33s9viO5cFCry2GIoItoU2MskmSFWzV/nn0FOCNtm37FJqm03R7PkC
 OhWZE3m9oqruQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 11B3F49AA3;
 Fri, 13 Nov 2026 19:40:39 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Fri, 13 Nov 2026 19:40:39 +0000
Subject: [PATCH v2 2/3] drm/amd/display: Leave self-refresh before an ABM
 level update
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-amdgpu-psr-abm-update-next-v2-2-27ce790856ea@hsal.es>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7318; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=aPK+/O58ErSzPhBOIOuBjn+oOrhfRqck5lqxBkYi52s=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsr6nb2N8qsSrJa2eI6bcF5rD5Xf6hqKc4wzmk1wLq
 6UOl9hz8naUsjCIcTHIiimy6N7wZGCZOHlmTtHzJTBzWJlAhjBwcQrARKqkGRka+xtD5rhHL3Dm
 jLLht5C7Nc8g+crSpomfZ02Krz6iPfMnw1+RV4EJ3PklVeFrmYRfy53szz1+Irfy9eqXW7P4Z07
 LO8QBAF1PRQU=
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hugo Sales <hugo@hsal.es>

Writing panel_power_savings while the eDP is in PSR hangs DMUB on a
Cezanne laptop (DCN 2.1)

An abm_level change on its own is a fast update, so the commit skips
amdgpu_dm_commit_streams(), where amdgpu_dm_mod_power_update_streams()
sets the events that keep the panel out of self-refresh. The ABM level
then reaches DMUB through amdgpu_dm_commit_planes(), or through the
connector update loop in amdgpu_dm_atomic_commit_tail(), with the panel
still in self-refresh

Raise the PSR and Replay hw_programming events before both updates and
clear them once DC has the new level. Leaving them for
amdgpu_dm_enable_self_refresh() would keep PSR off on an idle desktop
until an unrelated commit came along. An event that a full update, a
modeset or a PSR SU dirty rect change set before the update stays set,
for that code to clear

Fixes: 8c322309e48e ("drm/amd/display: Enable PSR")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
v1 was tested on an ASUS ROG Flow X13 (GV301QH, Cezanne, DCN 2.1, PSR1 eDP)
with PSR turned on through amdgpu.dcfeaturemask=0xa and "drm/amd/display:
Don't require DMUB PSR caps before DCN 3.0" [1], which DCN 2.1 needs for
PSR to come up at all, but, as far as I can tell, the same bug would
manifest on other DMUB versions that use PSR and ABM

On 7.3 without this patch, writing 3 to panel_power_savings while
psr_state reads 6 makes DMUB fail within a second. The log fills with
"DMCUB error - collecting diagnostic data" and the panel shows vertical
lines. amdgpu doesn't attempt a GPU reset, and the errors go on until a
reboot

With the fix, I let psr_state reach 6 before each of these steps:

- turn ABM on, from level 0 to 3
- change the level, from 4 to 1
- turn ABM off, from 1 to 0, which takes the immediate disable path
- switch power-profiles-daemon to balanced and back to power-saver,
  which sets a new level each time

None of them logged a DMCUB error. Both kernels had [2] applied as well

I tested v2 the same way. I let psr_state reach 6 before each of these
writes: 0 to 4, 4 to 1, 1 to 4, 4 to 0, and the back-to-back writes
1 2 3 4 and 0 3 0. None logged a DMCUB error. psr_state left 6 within
7 ms of each write, and PSR was enabled again about 115 ms later. With
ABM on, the panel went back into self-refresh about 18 seconds after the
write

Commit 8c322309e48e ("drm/amd/display: Enable PSR") only paused PSR for
full updates. The power module events used here came with commit
3c108046e1d6 ("drm/amd/display: Add power module on Linux"), so a
backport before that needs another way to leave PSR

[1] https://lore.kernel.org/r/20261029171219.2842014-1-hugo@hsal.es
[2] https://lore.kernel.org/r/20261029165420.2255749-1-hugo@hsal.es
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfbc384fbbdb4..262170b611502 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3841,6 +3841,56 @@ STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *ac
 }
 EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
 
+struct dm_sr_hold {
+	bool psr;
+	bool replay;
+};
+
+/*
+ * DMUB can hang if an ABM level reaches it while the panel is in
+ * self-refresh. A commit that changes only the ABM level is a fast update and
+ * skips the hold in amdgpu_dm_mod_power_update_streams(), so hold PSR and
+ * Replay off around the DC update. Holds that something else already set stay
+ * as they are, for their owner to clear. dc_lock keeps the backlight path,
+ * amdgpu_dm_mod_power_update_streams() and the self-refresh code in
+ * amdgpu_dm_commit_planes() from changing them in between.
+ * amdgpu_dm_mod_power_setup_streams() sets them without dc_lock, but only for
+ * a modeset stream, earlier in the same commit tail
+ */
+static struct dm_sr_hold dm_hold_self_refresh(struct amdgpu_display_manager *dm,
+					      struct dc_stream_state *stream)
+{
+	struct dm_sr_hold hold;
+
+	lockdep_assert_held(&dm->dc_lock);
+
+	hold.psr = !amdgpu_dm_psr_event_is_set(dm, stream, psr_event_hw_programming);
+	hold.replay = !amdgpu_dm_replay_event_is_set(dm, stream, replay_event_hw_programming);
+
+	if (hold.psr)
+		amdgpu_dm_psr_set_event(dm, stream, true, psr_event_hw_programming, true);
+	if (hold.replay)
+		amdgpu_dm_replay_set_event(dm, stream, true, replay_event_hw_programming, true);
+
+	return hold;
+}
+
+/*
+ * Nothing else may commit on an idle desktop, so drop the hold right after the
+ * update rather than leaving it to amdgpu_dm_enable_self_refresh()
+ */
+static void dm_release_self_refresh(struct amdgpu_display_manager *dm,
+				    struct dc_stream_state *stream,
+				    struct dm_sr_hold hold)
+{
+	lockdep_assert_held(&dm->dc_lock);
+
+	if (hold.psr)
+		amdgpu_dm_psr_set_event(dm, stream, false, psr_event_hw_programming, false);
+	if (hold.replay)
+		amdgpu_dm_replay_set_event(dm, stream, false, replay_event_hw_programming, false);
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -3868,6 +3918,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
 	bool stream_update_needed = false;
+	struct dm_sr_hold sr_hold = {};
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_plane_info plane_infos[MAX_SURFACES];
@@ -4224,11 +4275,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
 				replay_event_immediate_flip, true);
 		}
+		if (bundle->stream_update.abm_level) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			sr_hold = dm_hold_self_refresh(dm, acrtc_state->stream);
+		}
 		update_planes_and_stream_adapter(dm->dc,
 					 planes_count,
 					 acrtc_state->stream,
 					 stream_update_needed ? &bundle->stream_update : NULL,
 					 bundle->surface_updates);
+		dm_release_self_refresh(dm, acrtc_state->stream, sr_hold);
 		updated_planes_and_streams = true;
 
 		/**
@@ -5198,6 +5254,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
+		struct dm_sr_hold sr_hold = {};
 
 		memset(&stream_update, 0, sizeof(stream_update));
 
@@ -5280,11 +5337,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 		mutex_lock(&dm->dc_lock);
 		dc_exit_ips_for_hw_access(dm->dc);
+		if (abm_changed)
+			sr_hold = dm_hold_self_refresh(dm, dm_new_crtc_state->stream);
 		dc_update_planes_and_stream(dm->dc,
 					    dummy_updates,
 					    status->plane_count,
 					    dm_new_crtc_state->stream,
 					    &stream_update);
+		dm_release_self_refresh(dm, dm_new_crtc_state->stream, sr_hold);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
 

-- 
2.56.0


