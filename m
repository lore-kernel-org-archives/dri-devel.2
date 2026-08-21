Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7064EC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F368E10F2F6;
	Fri, 21 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lubya9hp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE0210F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:42:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2A696136F;
 Fri, 21 Aug 2026 14:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2061F000E9;
 Fri, 21 Aug 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323330;
 bh=5vCcrjTC6fdjyiXe+iiNWKoI+eKhp8ZnA0oqjo52QBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Lubya9hp8cyGzu8K3+kQo09I4U7CdN98P6sr59wxYWp0u2nB9rKeyD2MKGgFxOjXI
 GKW9rYUOkCLKMBQ0PJRtwUXffdib/F35zp8Se13bdHuuqXCm2ws2bGeKzHiecU04ds
 /l7xpjk85+dhSJwoy6AH3c+hMqQ/P75aFRxNy5clBB4IiXn5VA7QObILHeHftBfiN6
 JgHquMPCg8GLRTtNH4Jya8Rj1tvl1WcrvGK0t4mb3IB0Csuw2MX8daLLYunDtX3eEz
 eJrTnIu7YjrlClN1RcoFjlRwXyobs/30JIUT/H6sLrGdfNxKOZ8fUjRf2qDDkknAbj
 gpItfnekzO5LA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:46 +0200
Subject: [PATCH 70/70] drm/crtc: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-70-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BqdG+BYbqtPRa1rNO1DShHaZ/7NZSkWGMHxpNMmA+u0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyeJPCp4JKq5leJtUGMhepHLgzra7Acdj3fVT76ue3
 Bp43/Npx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgIkz1jw8l5wv+UI7yd35w8
 IXeUYUnwSX1ztf1LP6rP8Ww5L5i+Ufuj0JI8HRur+BtWVT7v9xudY2z4/0Pog36DoLNczHuRs8s
 TghJd17b0nPrPENsRFr/hQFtBKJ/LORM2LwZjvlerDwiWygAA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c |  4 +---
 include/drm/drm_crtc.h            | 10 ----------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 3bcc7bf0900c..9f4eb694e1fb 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -294,13 +294,11 @@ void drm_mode_config_reset(struct drm_device *dev)
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
index 12f43253f059..be5dca538d87 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -421,20 +421,10 @@ struct drm_crtc_state {
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
-	 *
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

