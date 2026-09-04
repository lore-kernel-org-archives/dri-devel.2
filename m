Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13012C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C7F10F9B5;
	Fri,  4 Sep 2026 09:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FbPTKgNf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200A110F9B4
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:08:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0978343B96;
 Fri,  4 Sep 2026 09:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6392D1F00AC4;
 Fri,  4 Sep 2026 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512900;
 bh=5aZmLOLvN0vkALuULf/JTN8Bn76prSpxgIO0tzwnMWs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FbPTKgNfkM9JzVRFy5sO+Zms/FW9IemeUv3wdA1SC+1Rb4FhdY7SN24nTEC00GSW8
 d0Pl6xbte7bEso/plRD0PWs7Pq2r+H76yjniccxXmci3YqbSicEoTYsoLpRMRT7tDA
 6iwHPag643hqb10lVmPgKKqPyMWGnBQozaTUhQmzKqQMUItnbLHbf/PDl2iQQw7uSz
 0O2mgVsZFnmy5H21AdHIR2Ltn71n9a8QKG3LsRVVXBztLy2TkqQvlcoLyKIjwk8OGl
 vAVTimbin85Pbu+cnKidahkflwEq6HS4Zf16QwY5L1bpY6ijqlXORMy/ELWr0S/TZa
 DmHMOIJNy2/hw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:31 +0200
Subject: [PATCH v3 13/13] drm/crtc: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-13-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ydJLmnoEG2vjI92xqVrE2i/qYA7T7d8yEVs7KgkCVBk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzugKaIrSXfJmtHcinJxZdW73arv7fu1csn2a0pNakv
 S1z2S/aMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbidJuxYeLbzy4JsTuPLLX8
 dFshPLo0/vy66s8Mp+JOdey5rvBCZv+sllUxCZ3RBl3PL2RfDurZxFgr7u06nS+yTkpkYlm9jm3
 5rQ+31ZJFxWbfuV4T/H3ZSfbIdbo1Ugd1H6vmbE6zaVVf2gQA
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

