Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF34C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8610510EC89;
	Tue,  8 Sep 2026 14:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mnhR7KGw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C72710EC89
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:49:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94F0D601FF;
 Tue,  8 Sep 2026 14:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D01F00A3A;
 Tue,  8 Sep 2026 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878998;
 bh=xHF/LwlZed3XvB//KdmFVhIZ9dOBkaMbyCaUxq0qLXU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mnhR7KGwDEF4hrAc28Qeqt4GfoOf7lREieTnaowS/DXM4WxeSyHl6/m1Vog6Sdsr9
 qswc55p7cKu8ltykjO2MiHQ6z4u3vL5Un9EkL+VP+q6wT8qpocyTo+mlzCIDEH29U5
 aKKgr9sHMlm8NoP3XKaknu9LrZtKBncNieEuTUe2OH/HvzuKDnyujmw2YeFyyc4D1F
 Gy7n+QISd8wiY9FD1SiNWb48NQruPlHd1uCBhf4lmECDiDCXKi+l/bwV0RAITK5F9o
 2SjfPEaKXuI6B0ru7O26n6BdB2mq82SZf85M61CjuciE0WkKOW4tOCarUjOtOwkz1U
 HFrZkU0TICJ9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:47:12 +0200
Subject: [PATCH v4 41/41] drm/plane: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-41-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cLkGIz6wKoYJdWFaZTz3op5g+Abs3/sa9kG/tDWQcb8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5O/zp2U6FmnPv6lwOrKxbaa61JTgqFDBfdeUz+z6n
 5nYVbeyYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzktipjw6XW1odKnXtbNu1M
 Xf43r0nyjnxygCJT5vktvq5H2c+Eu7at0+4QiPw9Y92eZW+PaM74zljDt/73p1sTlJXFXTNei6e
 cu2E5+fWGK41LbvNf3cf6aGHjXV5ztzX75Jd+09VZON97g8w/AA==
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

All plane drivers now implement the atomic_create_state hook instead of
the reset hook for initial state creation. The reset hook conflated
initial state allocation at probe time with hardware and software reset
during suspend/resume, making error handling difficult since it is not
fallible.

Remove the reset hook from struct drm_plane_funcs and the associated
call in drm_mode_config_reset().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 4 +---
 include/drm/drm_plane.h           | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 366f6d821242..a1e6ea408ece 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -287,13 +287,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 
 	drm_for_each_colorop(colorop, dev)
 		drm_colorop_reset(colorop);
 
 	drm_for_each_plane(plane, dev) {
-		if (plane->funcs->reset)
-			plane->funcs->reset(plane);
-		else if (plane->funcs->atomic_create_state)
+		if (plane->funcs->atomic_create_state)
 			drm_mode_config_plane_reset_with_create_state(plane);
 	}
 
 	drm_for_each_crtc(crtc, dev) {
 		if (crtc->funcs->reset)
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index e757e9dbf132..a16e96aa7e60 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -357,19 +357,10 @@ struct drm_plane_funcs {
 	 * through drm_mode_config_cleanup() since a plane cannot be hotplugged
 	 * in DRM.
 	 */
 	void (*destroy)(struct drm_plane *plane);
 
-	/**
-	 * @reset:
-	 *
-	 * Reset plane hardware and software state to off. This function isn't
-	 * called by the core directly, only through drm_mode_config_reset().
-	 * It's not a helper hook only for historical reasons.
-	 */
-	void (*reset)(struct drm_plane *plane);
-
 	/**
 	 * @set_property:
 	 *
 	 * This is the legacy entry point to update a property attached to the
 	 * plane.

-- 
2.55.0

