Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FF9C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED7010F62D;
	Fri, 14 Aug 2026 14:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XLAAcfvw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DCF10F625
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD83E406D5;
 Fri, 14 Aug 2026 14:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CEC1F000E9;
 Fri, 14 Aug 2026 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719475;
 bh=N2TcyASClgdMQqlhOhNvN6whbOW7n4lY9yTEQx5bR+I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XLAAcfvwDpg1lSApSGeeeExO6KS0hnf0j5mulyz8pl62A3xu498YPFkgdqZWDQGx2
 Xvo69ikBJbjwtGiZT+lM9tVwpczcLG5qffvdM2JuDscMhQ8zdKGe2+aseXTjkaLb/0
 mpKxImFVazPDaFTbRV67V3vh4SRO+yp+q1LwUVMFiphMU704X1JzdBA6UYXQPDQITJ
 iPGiTLcpdp0PsCER7YoLFT0excrGqP9PubPuPTHk6fVWrHbsISBG7D1l4scXHkQbDh
 iS7Tz+nE8ke2XrgBj6jDO0EBEmjQig5I47eVZ2cYmZ2JmzfDKcotCyO/6UaJ/JuEvx
 kawzwCc2ZZkIQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:56 +0200
Subject: [PATCH v2 07/61] drm/simple-kms: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-7-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lfY29xaSEZTHLiNH77PqB9+rarpf7d8/+5KkgipCILU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OseFdhg2xm/hWP5GUkxi7h75daubXsa255ppOvG4s
 8dGN/3omMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOZFs3YMPW7bsUSwbAl/f8Z
 HnfcC+T+8uU8S+PmdWxCcz7nPxRkSCxpO1b99XHzs3WrzX7bfbYWZ2zY8EE84INkatDfn+XmnNl
 bV86af2Xvowux19m+9e+S3dZR/fgcd/nxlTaKdg+qJ016pq4HAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_simple_kms_plane_reset() handled three cases: delegating to
reset_plane, using create_plane_state with manual teardown, or
falling back to the default helper. This complexity existed to bridge
the old reset hook with the new create_plane_state hook during the
transition.

Now that all simple-kms drivers implement create_plane_state instead
of reset_plane, replace drm_simple_kms_plane_reset() with
drm_simple_kms_plane_create_state() which only dispatches between
create_plane_state and drm_atomic_helper_plane_create_state(). Wire
it to .atomic_create_state instead of .reset.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 528968ea5c4b..c99ff74dca92 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -279,41 +279,20 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.end_fb_access = drm_simple_kms_plane_end_fb_access,
 	.atomic_check = drm_simple_kms_plane_atomic_check,
 	.atomic_update = drm_simple_kms_plane_atomic_update,
 };
 
-static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
-					       struct drm_plane_state *state);
-
-static void drm_simple_kms_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *
+drm_simple_kms_plane_create_state(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
 
 	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs)
-		return drm_atomic_helper_plane_reset(plane);
+	if (!pipe->funcs || !pipe->funcs->create_plane_state)
+		return drm_atomic_helper_plane_create_state(plane);
 
-	if (pipe->funcs->create_plane_state) {
-		struct drm_plane_state *state;
-
-		if (plane->state) {
-			drm_simple_kms_plane_destroy_state(plane, plane->state);
-			plane->state = NULL;
-		}
-
-		state = pipe->funcs->create_plane_state(pipe);
-		if (WARN_ON(IS_ERR(state)))
-			return;
-
-		plane->state = state;
-		return;
-	}
-
-	if (pipe->funcs->reset_plane)
-		return pipe->funcs->reset_plane(pipe);
-
-	return drm_atomic_helper_plane_reset(plane);
+	return pipe->funcs->create_plane_state(pipe);
 }
 
 static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
@@ -339,11 +318,11 @@ static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
 
 static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_simple_kms_plane_reset,
+	.atomic_create_state	= drm_simple_kms_plane_create_state,
 	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
 	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
 	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 

-- 
2.55.0

