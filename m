Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07152C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29B910E95B;
	Mon, 31 Aug 2026 15:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ua3PymdB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB6710E958
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9E4840C26;
 Mon, 31 Aug 2026 15:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CAA1F000E9;
 Mon, 31 Aug 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190519;
 bh=kwu49uvS/F9yVzAm7mgMSi0Cmw59f8c0bNMe0gcgMTk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ua3PymdBSeiSxphQ33Wjo9wsXvgf2ijjYYozrDdUrrPkwRetGkIhn2wNZZY3GRFwH
 HN3HR6lsScPm5OCdBZmmuHNqn7SsJhgqOcsRbIww6iOuTlorRUltwx2C6rcbc0jQn1
 v9Y8AoLz2aojKgkSEBtgLJsYQ2NYkAv6L2oF+73smZlFHIYAfKG47Z98cOdw2+g9M8
 edcx2K+V69QFOCBJPspfHvJyDp56C8u5GD0y007BrNkLAqZKdd5qV1BCKvKknPnPfv
 UIqn85Xb0SBd2QpiUWkOKMc66KiQOW7pT6P2M2QRJSg9ZY7xkM3wuIUni+DoGaHYJj
 tatR5B8elaV2g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:26 +0200
Subject: [PATCH v2 13/13] drm/crtc: Remove reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-13-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aYPiqP27EgbTFpWTIkEK+zPJw7V3/9p1j/fqpwUYwDQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5zP+NJiiuJd99o+Iqtnus47yGt524LVOWNP0bc22o
 rB1ivvdO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE7OUY66ufT2Jo/j1n4dF9
 nJnlG/m3PJmhfuFZ3qTKtjOx+QeyNpb84q22Xfum6Os+WUvmmvTGVYyVjJbRd1oTWQVOs3WHfyu
 cYyA8ZXLR7bS9vpcCrhUvToj+PX+fd8hTjaVvBNZOFD84va0WAA==
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
 drivers/gpu/drm/drm_mode_config.c |  4 +---
 include/drm/drm_crtc.h            | 10 ----------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index bb2efc274323..5eed5c194b66 100644
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

