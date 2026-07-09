Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B93C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DC810F513;
	Thu,  9 Jul 2026 11:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Oqc+4GT7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B615D10E6EA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68D4443A7C;
 Thu,  9 Jul 2026 11:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C935A1F000E9;
 Thu,  9 Jul 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597865;
 bh=7EU6PYD7DQuM77sTCPACiH2qWI1w1kCQjpIhDWQ4E4I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Oqc+4GT7KpIKr8Rs5xH1mAk0MUAxOxdRYSKSPZBJEDTmTAL5vS0hEAAmvtEY88G7f
 KaYLRwfwsR9wXczGpJ7R9tdtZsjnchOZb8AgUPpR57gGR/+To5+fmfZ1LFXx4UEtNg
 7j06Wqc4z6xiedTfDHkIkoPJ4TTCcQIT/qcNMxdDcV89OIkaYvcdNbDu3+0MBoWxnM
 hYuN+KXEfa69bEwNEpR+uxD0OEmDIdlRp+B07Ih7yjNBCKNspWFnu+yE8JkK503uuZ
 4hH6KLNQp8xINQQcwLyP+GsShTd5QjrpKdzuy/nu6uUjIpmr0Qc7M+6GqZpzLT8VSz
 liDLS31BB8W3A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:27 +0200
Subject: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mQb+ijley0Er3W5g1cbUtd8eFCLorK0VJ5PWdN1PEWo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3ZxO3z4lPxQ5+YB9R0246hS/1rD/28yXV/67Vv1QY
 gb7kXyGjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR6f8YG3paxWdmslfu8pkX
 +sBMs6jG99yEH9d6Uzir3ezq+ea8eq08612kxs4Xkk9eGYcWRW/+ztjQXfNt3kKNKydil6as++v
 PyM43wdd688/6KreZyp9SD71+57Zvc42YXNAWf/YVzSpXp4kCAA==
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
 drivers/gpu/drm/drm_simple_kms_helper.c | 23 +++++++++++++++++++++--
 include/drm/drm_simple_kms_helper.h     |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..efb643ab6448 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -284,14 +284,33 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 static void drm_simple_kms_plane_reset(struct drm_plane *plane)
 {
 	struct drm_simple_display_pipe *pipe;
 
 	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->reset_plane)
+	if (!pipe->funcs)
 		return drm_atomic_helper_plane_reset(plane);
 
-	return pipe->funcs->reset_plane(pipe);
+	if (pipe->funcs->reset_plane)
+		return pipe->funcs->reset_plane(pipe);
+
+	if (pipe->funcs->create_plane_state) {
+		struct drm_plane_state *state;
+
+		if (plane->state) {
+			pipe->funcs->destroy_plane_state(pipe, plane->state);
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
2.54.0

