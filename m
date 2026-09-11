Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB0BC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F38589B99;
	Fri, 11 Sep 2026 13:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YlQwJwh7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B5410F61E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:21:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20AB6418ED;
 Fri, 11 Sep 2026 13:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704AB1F000FF;
 Fri, 11 Sep 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789132893;
 bh=oQlubmtr+cCYntxpdF3uo6bnZrdAnirie0kNXixDCng=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YlQwJwh785u6Dfc3guxfLLGL3qsJpDzxO5NcBuprGcKXARPouo+vYlTHCdi9o8y9e
 HxMHlGaQyiK5MdMS/mhAeSCakf4ZOS2m6/DwLy+zYUZXNjEpsekwCye+uTouuKozx2
 fU/uXkD4YcZuOuWdQmJv4DZKcKG/99oiPN24jM8/HXR6UhdcthHX4PLBmXbWwsEqNB
 ebD331zKmI7Cg+cLDKPtazNIlGQIUw7KFLZG7mQhoXjrLoYqdNPntMzc4NFbU1GccB
 WUR7kmKejklG9eV1f6IrPpJbaY8gGPaZyufIZWb/EG6cM+vw6b5kLOQdGZJpx4HTi7
 lhy7tF1swIZ8A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 11 Sep 2026 15:21:11 +0200
Subject: [PATCH v4 4/4] drm/crtc: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-no-more-crtc-reset-v4-4-662e0ccd815c@kernel.org>
References: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
In-Reply-To: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3XeZc7wubdpscscQfAf1O626QLh8DmEif8oFZnmICDo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlLGDw1GDb8W/TcL/nD2w/9Iivmnw6+9vv9ks6npivEv
 HxMU3gaOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE5PQY67Tl/G1SxBuP/lWW
 ian9ILgzrHnalxDv19u/izMlSenczJ+wb2Z+yrlyRv4pvJsy/FjiGWvFjcpfv01d4bzBn4mhbNm
 ZUMlXRv4vj5+O95wvsd/zau7tx04JF+evfpskcaDsa90kphIA
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

All crtc drivers now implement the atomic_create_state hook instead of
the reset hook for initial state creation. The reset hook conflated
initial state allocation at probe time with hardware and software reset
during suspend/resume, making error handling difficult since it is not
fallible.

Remove the reset hook from struct drm_crtc_funcs and the associated
call in drm_mode_config_reset().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 4 +---
 include/drm/drm_crtc.h            | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index f95cd9695b43..c7c8e38b192d 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -305,13 +305,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 		else if (plane->funcs->atomic_create_state)
 			drm_mode_config_plane_reset_with_create_state(plane);
 	}
 
 	drm_for_each_crtc(crtc, dev) {
-		if (crtc->funcs->reset)
-			crtc->funcs->reset(crtc);
-		else if (crtc->funcs->atomic_create_state)
+		if (crtc->funcs->atomic_create_state)
 			drm_mode_config_crtc_reset_with_create_state(crtc);
 	}
 
 	drm_for_each_encoder(encoder, dev)
 		if (encoder->funcs && encoder->funcs->reset)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 746d049f1b6e..be5dca538d87 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -421,19 +421,10 @@ struct drm_crtc_state {
  * Each driver is responsible for filling out this structure at startup time,
  * in addition to providing other modesetting features, like i2c and DDC
  * bus accessors.
  */
 struct drm_crtc_funcs {
-	/**
-	 * @reset:
-	 *
-	 * Reset CRTC hardware and software state to off. This function isn't
-	 * called by the core directly, only through drm_mode_config_reset().
-	 * It's not a helper hook only for historical reasons.
-	 */
-	void (*reset)(struct drm_crtc *crtc);
-
 	/**
 	 * @cursor_set:
 	 *
 	 * Update the cursor image. The cursor position is relative to the CRTC
 	 * and can be partially or fully outside of the visible area.

-- 
2.55.0

