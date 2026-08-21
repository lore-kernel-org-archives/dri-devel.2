Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F38C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10AF10F15A;
	Fri, 21 Aug 2026 14:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I5B26Fv1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7AA10E30C
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 732F6433D3;
 Fri, 21 Aug 2026 14:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23781F000E9;
 Fri, 21 Aug 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323213;
 bh=wQHvfxClNF+uKxuQ+t4TO3ObhFuKalb8xtWYilvIVbw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I5B26Fv16PRC1DmIdagwZ3EjbvJoqCCdv2U+TC+oFMhILEvGssgXyFLxbgHgFp5do
 K3ZMoFbc7wLLqbzfqT84q2xhj3QBkC0rzDdK3aQwIcO3N4drBYKNMOf7nxfsXaOwS5
 Hx1CpQWPjCegcJn5eFqpL+0ZPWbHmL7aLaiwrUrT97Q3v/4F4jFyeZ5d92ytuHFjXI
 AFYeHikLHLSxaH9eYwHWzdOQ2iSrQNdsUp4kqbHa9sB3pM5nF0LUZYf4zcLOmDKMh0
 houYhsZXINPBdTf0rw4JfZR+n8vXSL3v3DgN4zkzLO2L4fHhp1W6686ny6tv0bsAfC
 h3SbDjDVy5Utw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:57 +0200
Subject: [PATCH 21/70] drm/simple-kms: Remove unused reset_crtc hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-21-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OPYt1Fk5VD7MUKjijQO/wUfL0SonWXeRAKjjkcdBcG8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyYwfOctvCghI3YmI08j9JWO0cOXUeKk7NQdnh8b5r
 9uhybuoYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEykwo6xPke/RufPa/lV62zU
 1PfGOHce+/Snk/3YvdYC7yrm6xY5Qg8kZh+asOmm8N0lVYb3eNOeMzbcYcruXX7+hnXrf4P2rvU
 cMUzNUT/s1QI+l78Vy4osP71oT/Wtg9nbm3MfrtVmDfvm/h0A
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

The reset_crtc hook in drm_simple_display_pipe_funcs allows simple
KMS drivers to provide a custom CRTC reset implementation. However,
no driver ever implemented it.

Remove the hook and the wrapper function, and use
drm_atomic_helper_crtc_reset() directly.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 13 +------------
 include/drm/drm_simple_kms_helper.h     |  1 -
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..6c77154dc54e 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -100,21 +100,10 @@ static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
 	.atomic_check = drm_simple_kms_crtc_check,
 	.atomic_enable = drm_simple_kms_crtc_enable,
 	.atomic_disable = drm_simple_kms_crtc_disable,
 };
 
-static void drm_simple_kms_crtc_reset(struct drm_crtc *crtc)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->reset_crtc)
-		return drm_atomic_helper_crtc_reset(crtc);
-
-	return pipe->funcs->reset_crtc(pipe);
-}
-
 static struct drm_crtc_state *drm_simple_kms_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct drm_simple_display_pipe *pipe;
 
 	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
@@ -156,11 +145,11 @@ static void drm_simple_kms_crtc_disable_vblank(struct drm_crtc *crtc)
 
 	pipe->funcs->disable_vblank(pipe);
 }
 
 static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
-	.reset = drm_simple_kms_crtc_reset,
+	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_simple_kms_crtc_duplicate_state,
 	.atomic_destroy_state = drm_simple_kms_crtc_destroy_state,
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index cb672ce0e856..8421af764f02 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -37,11 +37,10 @@ struct drm_simple_display_pipe_funcs {
 			       struct drm_plane_state *new_plane_state);
 	void (*end_fb_access)(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state);
 	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
 	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
-	void (*reset_crtc)(struct drm_simple_display_pipe *pipe);
 	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
 				   struct drm_crtc_state *crtc_state);
 	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);

-- 
2.55.0

