Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72D9C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E093610F621;
	Fri, 14 Aug 2026 14:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bJzylpFq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962F010F621
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A1BC44034;
 Fri, 14 Aug 2026 14:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57C21F00A3A;
 Fri, 14 Aug 2026 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719461;
 bh=GoYuOczj9hhHjt3dvsFLccyaVSLrjVDvlOsBnv/KzyY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bJzylpFqCyZirf23727ZOFQG+Ok7ApYLk1JUmOP10RY/9OQxrZg/PVWZF4W+O4oZY
 23OrdnT3NoOAM7FItDRisWBQ1cLnpsK1rdzBYyDFfi/1OCjWld+8NBHOwvULA4m7X5
 680LrV0x15vUq42QyS79B3VdhvqQzaDJJg14ng9jQdS/bIWm97GBeDsVxF7rfQlRyt
 5i0wWDe+Xq3aKUfYXGWkbIk/XRoxoqCbUQFWtNvfNl6Fje0Y1H6gcmWQ5TebXFOBRv
 VFCabFJkLHu8XnvGCvBZ/eVR4coRjTHcfbxhwkNy0O84WtTjYWrQIAajb5GXvV8bPH
 7GldzCUgCpGpw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:50 +0200
Subject: [PATCH v2 01/61] drm/simple-kms: Add create_plane_state hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-1-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rgppf2EgB5mHpLt+EzP+oKPLiSSKT4N/Y9naLRIuEBs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Oke2FlZc+M97yNZZPahOd+KUy/OThBefnJal8VBcw
 eZ9vGdgx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhItT1jw77Gnu2OTNWf8l4d
 29oZtkozNe6Tb9ilLw9S3jwLfy+nsVhL2653LYPY7wuxV8IWc2tzMTZMkL0yTfPk3neHXl3mcg1
 wjUt4HN55bZ5iRPWSc+WiNt1xN7MYb9g/r3ixmCHXjofzpDAA
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

The simple-kms helper provides a reset_plane hook to let drivers
override the default plane reset. However, the reset hook is
overloaded: it is used to create the initial software state at probe
time, but also to reset both the hardware and software state during
suspend/resume. These two roles have different expectations, and
reset is not fallible which makes error handling difficult.

The atomic_create_state pattern was introduced to untangle this by
providing a hook that only allocates and initializes a pristine state
without any side effect.

Add a create_plane_state hook to struct
drm_simple_display_pipe_funcs. When provided,
drm_simple_kms_plane_reset() will use it to allocate a fresh state,
falling back to reset_plane and then to the default
drm_atomic_helper_plane_reset().

This will allow simple-kms drivers to be converted to the
atomic_create_state pattern.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 26 ++++++++++++++++++++++++--
 include/drm/drm_simple_kms_helper.h     |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..528968ea5c4b 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -279,19 +279,41 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.end_fb_access = drm_simple_kms_plane_end_fb_access,
 	.atomic_check = drm_simple_kms_plane_atomic_check,
 	.atomic_update = drm_simple_kms_plane_atomic_update,
 };
 
+static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state);
+
 static void drm_simple_kms_plane_reset(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
 
 	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->reset_plane)
+	if (!pipe->funcs)
 		return drm_atomic_helper_plane_reset(plane);
 
-	return pipe->funcs->reset_plane(pipe);
+	if (pipe->funcs->create_plane_state) {
+		struct drm_plane_state *state;
+
+		if (plane->state) {
+			drm_simple_kms_plane_destroy_state(plane, plane->state);
+			plane->state = NULL;
+		}
+
+		state = pipe->funcs->create_plane_state(pipe);
+		if (WARN_ON(IS_ERR(state)))
+			return;
+
+		plane->state = state;
+		return;
+	}
+
+	if (pipe->funcs->reset_plane)
+		return pipe->funcs->reset_plane(pipe);
+
+	return drm_atomic_helper_plane_reset(plane);
 }
 
 static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index cb672ce0e856..b58f6d532820 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -42,10 +42,11 @@ struct drm_simple_display_pipe_funcs {
 	void (*reset_crtc)(struct drm_simple_display_pipe *pipe);
 	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
 				   struct drm_crtc_state *crtc_state);
 	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
+	struct drm_plane_state * (*create_plane_state)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
 				    struct drm_plane_state *plane_state);
 };
 

-- 
2.55.0

