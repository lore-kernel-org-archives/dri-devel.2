Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C1DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C94C10F533;
	Thu,  9 Jul 2026 11:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="idUkjJWg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8E310F52A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5C48601D9;
 Thu,  9 Jul 2026 11:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB051F000E9;
 Thu,  9 Jul 2026 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597879;
 bh=zZTnyyn2vR2zW5reRGvwyC8/ckOsw14vPrmxCMySrfc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=idUkjJWgRr4Do9awcNhGgXhTXjyf4/MAVg8l+sleiO4P9cpnfUBvnS15G7O25KVVO
 FwxX54ZX9qgvdVG3Wc1cTGXMyIYK6F2YHb38AAxXh2C1MShn3X+n8tL+1Nq9vwo0Vj
 YBk0RSx8RoTm2n9oQtaWLP3zw3CmYmAJ3T+l6qVj2e3r69xxaDOvyBUeaVyrHuswC1
 SqXLrCXMYL95yn7pIuS/wAJnG0D1VMmoMtEqIDCb2/5AfQNzOX6pSEuR0DVEBpaiQM
 N5cJeTd2Hw5dzAvRoCunQvNC70X/m0hK7H89Cz/rqx9k1GvJFL/+MXGXIksyUBadPj
 QMgHYqnJAtR5g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:33 +0200
Subject: [PATCH 07/60] drm/simple-kms: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-7-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TEybdx4BgueLSaUw8bIoQYqFhE62CN3qKCY2I5snPqo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3TwRj3V5Ht8/ofqk8bKY2LQp/G92aVxQFbcLWJn8Y
 9+aU3ERHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAicnaMtUK3iyyZpzp9XvfA
 R+nzfRVDHtvuDWsi5nkJ1dzffNNL86n0qw2dQSsYhU7d3CbBOe2APGOdQfDxktTZZ8WFCxw48vt
 eV36ZPO/avNP8Ubt3TbveLng2edODR6p9ui1vfEMEVyx0aXYBAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index efb643ab6448..c99ff74dca92 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -279,38 +279,20 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.end_fb_access = drm_simple_kms_plane_end_fb_access,
 	.atomic_check = drm_simple_kms_plane_atomic_check,
 	.atomic_update = drm_simple_kms_plane_atomic_update,
 };
 
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
 
-	if (pipe->funcs->reset_plane)
-		return pipe->funcs->reset_plane(pipe);
-
-	if (pipe->funcs->create_plane_state) {
-		struct drm_plane_state *state;
-
-		if (plane->state) {
-			pipe->funcs->destroy_plane_state(pipe, plane->state);
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
-	return drm_atomic_helper_plane_reset(plane);
+	return pipe->funcs->create_plane_state(pipe);
 }
 
 static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
@@ -336,11 +318,11 @@ static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
 
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
2.54.0

