Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AC606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGxugDUk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA7610F7F6;
	Tue, 10 Nov 2026 16:03:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF9910F7D7;
 Tue, 10 Nov 2026 16:03:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E935D44F77;
 Tue, 10 Nov 2026 16:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BC61F008A2;
 Tue, 10 Nov 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326597;
 bh=IK06K6MQBECuIUNklXJJ1e7MILzdFrcFN8KSljlqPhY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NGxugDUkg4VjFeeky/SgVUxyTWSVKoRWjGLbsnQlCMHHjMsto+tubmwbk/4KyE1EU
 NRT99j2cMmrVbuxIMXIowq22P+thyoNKFy5qYHJUk5z95MgO1g7GoZsRX4F+fB4+f3
 eAVh4MxWaKPjAVsA4W5m6M5Bgh8H4TWIgEPuXxtFTJHwQSKfNg4nNHrpUzzdEdOmIm
 4ZiWkdXy+Wxjh/fFy2K/v35nOWiCJ/QwKaUYGyECR0DNe/B4BVPKdf7eJhp4no03Vo
 6lv0zyV6io1dZG3xGckXLhyJQK3WyG5clJpsZcRqAW83kRWsJRSYyEM+E0nz65E3DD
 6cN+rtUmqCn1A==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 10 Nov 2026 17:02:53 +0100
Subject: [PATCH v9 06/10] drm/amd/display: Take over the current stream and
 dc_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-drm-reset-state-flag-v9-6-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
In-Reply-To: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4877; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+2bQgIjtV6naBU0maTRuT8nAW4TJ+nxq4tsm5xK+MVY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmfHfRWr5qVpNYQkRGQc0TY7bF6sePpT5r6KpONLnVcd
 I/lPh/QMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyZjZjwxsZu1X8GZIR+pt3
 bt4wScR52p3mTv679zWm5/4XXmF8sNmsIHxS/+Q1Ta8TL/5S436oz1infrjGuePU8yIms+Pc+lY
 uLFHtjhIGz/bJzs0T939QHpaioOsr17eHV8iiti73mNC6NwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_atomic_commit_fill_with_defaults() builds its commits out of
states created through atomic_create_state() instead of duplicating
the current state. A created state comes with no stream nor dc_state,
while a duplicated state carries the ones in use, with their
reference.

The update passes of amdgpu_dm_atomic_check() release the stream and
dc_state in use and clear the pointer of the new state, on top of the
reference the current state drops when it gets destroyed. Those
releases are only balanced if the new state brought a reference of
its own, so a commit that disables or reconfigures a live CRTC or
plane through a created state over-releases and frees the stream
early, leading to a use-after-free when the current state gets
destroyed. The paths that keep a CRTC or a plane enabled without a
modeset also work on the stream and dc_state through the new state,
and hit BUG_ON(dm_new_crtc_state->stream == NULL) since it never had
one.

Take the stream and dc_state of the current state over, with a
reference, at the beginning of amdgpu_dm_atomic_check(), like a
duplicated state would have carried them. This has to happen before
the update passes clear the stream of the new states: past that
point, a state whose stream was cleared can't be told apart from a
created one.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ea45ab12119..b2eddb87dd5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6279,10 +6279,60 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_dp_mst_topology_state *mst_state;
 	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {0};
 
 	trace_amdgpu_dm_atomic_check_begin(state);
 
+	/*
+	 * A CRTC or a plane that stays enabled keeps its stream and
+	 * dc_state: a duplicated state carries them over, with their
+	 * reference, but a state created through atomic_create_state()
+	 * comes with neither. Take them over from the current state,
+	 * with a reference, like a duplicated state would.
+	 *
+	 * The reference is needed when the update passes below
+	 * reconfigure the CRTC or plane: they release the stream and
+	 * dc_state in use and clear the pointer of the new state then,
+	 * on top of the reference the current state drops when it gets
+	 * destroyed, so that release is only balanced if the new state
+	 * brought a reference of its own. The pointer is needed when
+	 * they don't: the paths that keep a CRTC or a plane enabled
+	 * without a modeset work on the stream and dc_state through
+	 * the new state.
+	 *
+	 * A stream or a dc_state in the current state means the CRTC
+	 * or the plane is enabled, since they are cleared when it gets
+	 * disabled, so the conditions below already single out the
+	 * live objects. They deliberately don't check whether this
+	 * commit keeps them enabled on top of that: the update passes
+	 * release the stream and dc_state of the CRTC or plane being
+	 * disabled too, so their new state has to bring the reference
+	 * just the same.
+	 *
+	 * This has to run before the update passes below clear the
+	 * stream of the new states: past that point, a state whose
+	 * stream was cleared can't be told apart from a created one.
+	 */
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		if (!dm_new_crtc_state->stream && dm_old_crtc_state->stream) {
+			dm_new_crtc_state->stream = dm_old_crtc_state->stream;
+			dc_stream_retain(dm_new_crtc_state->stream);
+		}
+	}
+
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		struct dm_plane_state *dm_old_plane_state = to_dm_plane_state(old_plane_state);
+		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
+
+		if (!dm_new_plane_state->dc_state && dm_old_plane_state->dc_state) {
+			dm_new_plane_state->dc_state = dm_old_plane_state->dc_state;
+			dc_plane_state_retain(dm_new_plane_state->dc_state);
+		}
+	}
+
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret) {
 		drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed: %pe\n", ERR_PTR(ret));
 		goto fail;
 	}

-- 
2.56.0

