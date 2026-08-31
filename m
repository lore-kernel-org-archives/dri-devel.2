Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF1C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DBA10E9AB;
	Mon, 31 Aug 2026 16:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LEG4fPwU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB8A10E9AB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:17:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 833C460200;
 Mon, 31 Aug 2026 16:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB13E1F00A3D;
 Mon, 31 Aug 2026 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193066;
 bh=ixnxrk5qpDTpigZLp3uD/lHCRkB/I4eyrWwO5tjXUoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LEG4fPwUEqrxwV00lY21kJ6tDF7CNnwlqSse8XVNDDcYkrFsXvn8j4+vNOGCAlQeX
 FyC03AZ4gQl+UQv71wITb6Fdk4iveDiYGESDra7ALXVKAfDEbrxisXgr8SW1/a/GMm
 2x1n7cj9gZSP/8qkRSKFJgdNZfvC5Szp4MiWxq6P739rU4QB2MYQ1of/lczd30l0Cx
 NTQKRX/Xkppu5QN4vvS4YiW5FYJ37wexbqWwoJ2zsrcL2+RU9x8Ajl12wSQhMqABiu
 SEjEHvKi67QGPJKuJIzszmF0sluZ5As32Eyc+oF6RnXdsnJfioEcDfgE17jpOMtOQJ
 2mmeKQMzzWB2Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:17 +0200
Subject: [PATCH v3 01/40] drm/simple-kms: Remove unused reset_plane hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-1-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wJGWE06mB1wVOA3lCSZFLHVGSt9/u+aQxc8RiX0FhaA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTVwroluquzo7g+iv02S7h8HuJoO2JcjH1P2JvnDx18
 zbTpFUCHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi1w8xNtwLi/bu91X2X5nm
 ERlX8i2cy/HB2SV/d5zS9ehf8+RFcvzTzQI1t1Nul+zc3+Px6Obe+4z1Mc5XGla/Yi1SLTOOuql
 YWdVmc9LMt7ue5cE1O0MjbtPI5oMbJu5MlOLLEu3sVHNWfQUA
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

Commit 7f879284390c ("drm/simple-kms: Switch to atomic_create_state")
replaced drm_simple_kms_plane_reset() with
drm_simple_kms_plane_create_state(), removing the only user of the
reset_plane hook. However, the hook itself was left behind in struct
drm_simple_display_pipe_funcs.

Remove it.

Fixes: 7f879284390c ("drm/simple-kms: Switch to atomic_create_state")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_simple_kms_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index 4a4a840d84f1..2b31c25c57a9 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -40,11 +40,10 @@ struct drm_simple_display_pipe_funcs {
 	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
 	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
 	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
 				   struct drm_crtc_state *crtc_state);
-	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*create_plane_state)(struct drm_simple_display_pipe *pipe);
 	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
 	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
 				    struct drm_plane_state *plane_state);
 };

-- 
2.55.0

