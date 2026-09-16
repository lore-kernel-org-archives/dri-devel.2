Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82060C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F77010E6D6;
	Wed, 16 Sep 2026 08:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8LJ1mm5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AD610E6D6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56BD96053C;
 Wed, 16 Sep 2026 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB2B1F00898;
 Wed, 16 Sep 2026 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548990;
 bh=vIX6OY04ELuT9Rly9w0RE9XzMYDQjO+C2nabXC5FQ+U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q8LJ1mm53cxC95xLKlpzwBIisky+yjBUS1pMPdn4tu1UBc5QUOGZHlcMaU6MeAUx4
 vhHcuN66paHINvLKLEyULfuYdyyzkV3V83rD/0bTZqefYT4NltGNP1wLIu1oLZ5gym
 RMqWcC2c4o0wVzOwZRl0AwBUOBjlKkfp7WM11YwtG14Kq/SlHnQkW+HmWVlOvWXbo/
 k3vNxmFgh2wwUizp8BrSb+AdnsvxYF16MLQ+UKP7BZTvwLZF0dzUvrZ8SOQ+UnmEtN
 7Ph6Unq5nncJWWTlysymN1aUdcZX9+seUtD/rnQ1VkvziXjexQdVn+bM3YTlEdtCzX
 lwQu9AcLyPSrQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:52 +0200
Subject: [PATCH v5 9/9] drm/plane: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-9-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=mripard@kernel.org;
 h=from:subject:message-id; bh=deimxSZ1PhPJquHBcxpxbqhdTcwMYod6QhydHqWSulE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqd7nLqy8uDsU4/eBl478krS9+XiJ4Vmslmt77Zwq
 nXtPpG2pmMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMJLyeseHktld32CT2flGJ
 3bxn4TsOV13zhUsOrFmxVNphdtuNzS09vOaTd556cirg2/sNB2uetd9grK/7frXktYfcO2/eidN
 057Ud/jHta5+76iyj5Fsy34TP/q9qam/t2V/M23nq6kbLTwZhtgA=
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
index c7c8e38b192d..48a56f23dadb 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -298,13 +298,11 @@ void drm_mode_config_reset(struct drm_device *dev)
 
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
 		if (crtc->funcs->atomic_create_state)
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

