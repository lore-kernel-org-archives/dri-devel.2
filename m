Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB9606A332
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5qcIXxP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCE110EC9F;
	Fri, 13 Nov 2026 19:40:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B562010E6CE;
 Fri, 13 Nov 2026 19:40:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0391C6284A;
 Fri, 13 Nov 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794598840;
 b=EBOIxlyD6kLUiewSF2enIl4bPwKlDuBmOqItVYhETTPS/wx+82ASxle9E3oEqbvI6e2J
 kJ7+d44UC69a+8shhd1AKP4PNGZs5/+2MyWJlURWNIBWWZOZHMlv0kMrcsLAYRjyacEUC
 9zFEne/1Ca9HBfCO5vtSO+457RX2OpvZcUslPYC6TaPu2ly581HUa/P25F9SY37OgVpeu
 Lvzmyd13CpXg5yla9vzFevcoj2avKBeO3obSyf5PsYJTO9KmEaf1do4C6LxDz3s+Q1cZe
 DjyjYrf4iSaE0O6IpkBnSMG9NKcj6DhhSVHz5F0j2BZxDeJ4hjg75/4EbsOr1Lz7/aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794598840;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=7SAxWA/AqtLYv0LJ6fqo0Mn17BiPmqtk2U3uaoLE5HI=;
 b=Y+X2Y37TqAlcKXTrLmN7EYBS9dpU6WW9t2mWiWI2PygQpP8ZSeIgwD85W3UvlLomKnkn
 dlevS6eFOaJk8xJL2p2S9G4q741sHXaqk7e9105txY2MmGDabvF8gfzGXUw1VlhGvp1Vk
 00bY8040ivwpGiQoZAENxnCumDARGBkT604zl4fu+XrlukKek2ji2R+wsXuE07cQI0H6m
 8WYN/+Do8V2QD/pXs8qy/EEFF1Gu34w55urAL6sM+fh0VAtCgLH27a23QvmkvzpMP0rcu
 V3Tf3LzG+6joXrDDxw6tEh2dmXMyMkvEDMhYGu+AksiSBtF6+HKgf9HZCKv/xh1kZUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 936231F000C7;
 Fri, 13 Nov 2026 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794598840;
 bh=7SAxWA/AqtLYv0LJ6fqo0Mn17BiPmqtk2U3uaoLE5HI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=X5qcIXxPGb4Vjl9t6LqDgP6IxrNXmLK/VPPqvaoWcMMzSKHRVi6R6Jmnr3Z/Q3IjK
 YSFq1JV1/s41z+Lnma7cpt2grareRnx5ne+pZa+QnjA3gO+g2sXiigae4QJa4sF/63
 2s4TS1JDev+13qrYMx3634dyr5nOVzo56/wXCkayHRPpBUmWuwLWtYgXF2DlSDxohk
 PpWpYtsS2/W33ICE064uBV4/SfGo3R+EXLcJUxkFAOE+yqGLLsGTdhSy8CcJ84g8KZ
 H5coOfJ5h7Z6tuAUUhIc7pUpqQ9GNfQRydrCxSJ1NeRze5JouOBEU8pQ26t6A6qgLM
 P1Q0NBo54QSZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2687149AA7;
 Fri, 13 Nov 2026 19:40:39 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Date: Fri, 13 Nov 2026 19:40:40 +0000
Subject: [PATCH v2 3/3] drm/amd/display: Send a changed ABM level once per
 commit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-amdgpu-psr-abm-update-next-v2-3-27ce790856ea@hsal.es>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=LlOJID8gdQUbNTNGo+hW6h93h+A/dK5Q46QGvGs1m3s=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsr6nb9Nb6fzsH797mre8wZ45cQvjs9cK/roRe/7ro
 g7+lT+fbVXrKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgIkETWZk2HKYKTJOcuaK
 X+/rdgaFT37WYnv3jt05SbH8XNP7F9akWzEynAx055901DCkzPahxNI/vhueVRSuX1Cyf37Ur1i
 5SN+pzABAtEx6
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

When a commit changes the ABM level and also has planes on that CRTC,
the connector update loop in amdgpu_dm_atomic_commit_tail() sends the new
level to DC, and amdgpu_dm_commit_planes() sends it again. The panel
leaves self-refresh for each send, so one level change takes it out of
PSR or Replay twice

Record the CRTCs whose level the connector loop sent, and skip the second
send for them in amdgpu_dm_commit_planes()

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 262170b611502..3077744b2d2d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3895,7 +3895,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
 				    struct drm_crtc *pcrtc,
-				    bool wait_for_vblank)
+				    bool wait_for_vblank,
+				    bool abm_sent)
 {
 	u32 i;
 	u64 timestamp_ns = ktime_get_ns();
@@ -4245,7 +4246,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		acrtc_state->stream->abm_level = acrtc_state->abm_level;
-		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level) {
+		/* The connector loop in amdgpu_dm_atomic_commit_tail() may have sent it */
+		if (!abm_sent && acrtc_state->abm_level != dm_old_crtc_state->abm_level) {
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 			stream_update_needed = true;
 		}
@@ -5230,6 +5232,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	struct drm_connector_state *old_con_state = NULL, *new_con_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
+	u32 abm_sent = 0;
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
@@ -5255,6 +5258,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
 		struct dm_sr_hold sr_hold = {};
+		bool updated;
 
 		memset(&stream_update, 0, sizeof(stream_update));
 
@@ -5339,14 +5343,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		dc_exit_ips_for_hw_access(dm->dc);
 		if (abm_changed)
 			sr_hold = dm_hold_self_refresh(dm, dm_new_crtc_state->stream);
-		dc_update_planes_and_stream(dm->dc,
-					    dummy_updates,
-					    status->plane_count,
-					    dm_new_crtc_state->stream,
-					    &stream_update);
+		updated = dc_update_planes_and_stream(dm->dc,
+						      dummy_updates,
+						      status->plane_count,
+						      dm_new_crtc_state->stream,
+						      &stream_update);
 		dm_release_self_refresh(dm, dm_new_crtc_state->stream, sr_hold);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
+		if (abm_changed && updated)
+			abm_sent |= drm_crtc_mask(&acrtc->base);
 
 		drm_connector_update_privacy_screen(new_con_state);
 	}
@@ -5440,7 +5446,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		if (dm_new_crtc_state->stream)
-			amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vblank);
+			amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vblank,
+						abm_sent & drm_crtc_mask(crtc));
 	}
 
 	/* Enable writeback */

-- 
2.56.0


