Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD97DCA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F6610F552;
	Thu,  1 Oct 2026 02:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YCzSWA/r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A4E10F54F;
 Thu,  1 Oct 2026 02:13:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C7735400AA;
 Thu,  1 Oct 2026 02:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A780AC2BCB9;
 Thu,  1 Oct 2026 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790820816;
 bh=DuNWW2/4c2h8l/+mCS129Lv1oKgRWfY4Vpu4QEuPlGk=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=YCzSWA/rG5zVl/G0Z5N6DFntPfxH9iOvDAF1WS+8WeyAM1FtkiifDiRkiuJp7EsSQ
 venGZziP8Lff/9fyiCIvihxfsv/NCRo6g65ehCbxoQkMOFeLhGDhCk/oagvytTgqsC
 xDnsC3fWfCU1qJTOJ8zTpCtgCXO2bWE96mVObnKXuUGCrM+2LuZ3o+SD1nXBY0cEta
 ji7fgMHnuYTz/tE5hZB+zdnsYa+rCCN3jPAF+X1hbmIjUv5bde7CG74ZhN4KpXOSbF
 pE+H1OFkXlTPdCWidSnPWNjKC8MiGzugR4tqPUW9itOuCV+ABtJT7ov0/hPZOXNUVR
 2u8/a6yv0fHFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 80A81CA5FC1;
 Thu,  1 Oct 2026 02:13:36 +0000 (UTC)
From: David Medina via B4 Relay <devnull+b2amedina.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 22:13:36 -0400
Subject: [PATCH RFC] drm/amd/display: Disable CRTC on MST connector unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-amd-mst-teardown-v1-1-16a39ebdd4de@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS2MD3cTcFN3c4hLdktTEopT88jzd5MQki0Rjc2NDU0szJaC2gqLUtMw
 KsJHRSkFuzkqxEMHi0qSs1OQSkGFKtbUAKYzzU3kAAAA=
X-Change-ID: 20260930-amd-mst-teardown-cab8a3731596
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, David Medina <b2amedina@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790820815; l=4851;
 i=b2amedina@gmail.com; s=20261001; h=from:subject:message-id;
 bh=ACruRfV2/ag5NwIsG5RQC9W31bSPTFkiXG9HJmO8Xf8=;
 b=GyBptfxYhz4vHnlsYJz54kDnkBdXkCtlEy9z0/PHR5jo03HeDgHd/gVGXvEa1EZE6OuOD+8s/
 FD0RCaUs2NIDTi65kZnyA2obdEkkGAh5ujUtJ6QQ+NWA7hvi2G9MfkX
X-Developer-Key: i=b2amedina@gmail.com; a=ed25519;
 pk=6kajg3wsf4T4/+F2W+hj7g5W4lTch1OgfXS+6o1FsFY=
X-Endpoint-Received: by B4 Relay for b2amedina@gmail.com/20261001 with
 auth_id=1091
X-Original-From: David Medina <b2amedina@gmail.com>
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
Reply-To: b2amedina@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Medina <b2amedina@gmail.com>

amdgpu_dm_mst_connector_early_unregister() releases the connector's
sink but leaves the CRTC it was driving active and its MST encoder
assigned. Because the connector is unregistered in the same step,
userspace has no chance to disable the CRTC before it is gone. When the
same display is re-plugged a new MST connector is created, and the
re-commit fails in drm_atomic_helper_check_modeset() because the stale
connector still owns the encoder (handle_conflicting_encoders), leaving
the display dark until a full modeset (e.g. a session restart) tears
everything down.

Disable the CRTC from the driver when the connector is torn down, so the
MST encoder is released and the DC stream dropped. Reuse the
drm_atomic_helper_disable_all() pattern: deactivate the CRTC, clear the
mode, and disconnect the connector.

Reproduced 100% of the time by unplugging and re-plugging the Thunderbolt
dock driving the LG ULTRAWIDE: on re-plug the display stays dark and
dmesg shows drm_atomic_helper_check_modeset() failing with an encoder
conflict (handle_conflicting_encoders). Verified over four unplug/replug
cycles with this patch applied.

I am not certain that forcing a modeset from early_unregister() is the
right approach, and the disable here is intentionally minimal: it
deactivates the CRTC and disconnects the connector but does not
add/detach the CRTC's affected planes the way
drm_atomic_helper_disable_all() does. The minimal version resolves the
failure in testing; I would welcome guidance on whether the full
affected-planes teardown (or a different location) is required.

Fixes: a1b27e99229a ("drm/amd/display: Implement MST Aux device registration")
Signed-off-by: David Medina <b2amedina@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 045a7f88b754..24b146068739 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -29,6 +29,7 @@
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_edid.h>
 #include "dm_services.h"
@@ -227,6 +228,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 	struct amdgpu_dm_connector *root = aconnector->mst_root;
 	struct dc_link *dc_link = aconnector->dc_link;
 	struct dc_sink *dc_sink = aconnector->dc_sink;
+	struct drm_crtc *crtc = connector->state ? connector->state->crtc : NULL;
 
 	drm_dp_mst_connector_early_unregister(connector, port);
 
@@ -250,6 +252,57 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
 	drm_modeset_unlock(&root->mst_mgr.base.lock);
+
+	/*
+	 * The connector is being removed from the MST topology. If a CRTC is
+	 * still driving it, force a modeset that disables the CRTC so that the
+	 * MST encoder is released and the DC stream dropped. Otherwise, on a
+	 * subsequent re-plug the stale CRTC/encoder assignment triggers an
+	 * encoder conflict in drm_atomic_helper_check_modeset() and the display
+	 * stays dark.
+	 */
+	if (crtc) {
+		struct drm_atomic_commit *state;
+		struct drm_connector_state *conn_state;
+		struct drm_crtc_state *crtc_state;
+		struct drm_modeset_acquire_ctx ctx;
+		int ret;
+
+		drm_modeset_acquire_init(&ctx, 0);
+retry:
+		state = drm_atomic_commit_alloc(connector->dev);
+		if (!state)
+			goto out;
+		state->acquire_ctx = &ctx;
+
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		ret = PTR_ERR_OR_ZERO(crtc_state);
+		if (!ret)
+			crtc_state->active = false;
+		if (!ret)
+			ret = drm_atomic_set_mode_prop_for_crtc(crtc_state, NULL);
+		if (!ret) {
+			conn_state = drm_atomic_get_connector_state(state, connector);
+			ret = PTR_ERR_OR_ZERO(conn_state);
+		}
+		if (!ret)
+			ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
+		if (!ret)
+			ret = drm_atomic_commit(state);
+
+		drm_atomic_commit_put(state);
+		if (ret == -EDEADLK) {
+			drm_modeset_backoff(&ctx);
+			goto retry;
+		}
+		if (ret)
+			drm_err(connector->dev,
+				"DM_MST: failed to disable CRTC for removed connector %s (%d)\n",
+				connector->name, ret);
+out:
+		drm_modeset_drop_locks(&ctx);
+		drm_modeset_acquire_fini(&ctx);
+	}
 }
 
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {

---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20260930-amd-mst-teardown-cab8a3731596

Best regards,
--  
David Medina <b2amedina@gmail.com>


