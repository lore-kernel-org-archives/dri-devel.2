Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E621CC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DBC10E30C;
	Fri, 21 Aug 2026 14:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IotvYh3l";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0F110E306
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D26D26136F;
 Fri, 21 Aug 2026 14:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8851F00A3A;
 Fri, 21 Aug 2026 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323179;
 bh=SKPKXRQkpjk+0gWkRGnN8uDiW43tLgaZPt4bulSsvys=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IotvYh3lMypxoe/R/W0dtz3TohvCqdpM/af2iQO4fu+ZGj9Wm/2zaHsZAYu9yhEre
 Bj1hsjsFmKmAvJBU3pdq4WxA+tA0a50r+LGgrYEF+KgYpqDVrnjP731n1Bo9jxOzW/
 fDGN6LrXlU8AKkWHgWAgC0SqKZQ7F/WcIus1ruuVCBM3mpRwzcKYNMACcprGgs7xeg
 0FB3Nr32XXK0X6arbxI9p/2U8olkO4iqqnmJxfpJaJd6+Fmjn2QjPysxZN6SVSGoFr
 HzAbZLtjtGeZJ92kSGMXeuULYP43FTOVIPMUsf7lnSzRqB0rDL/U5PzJt6iR2bMn0l
 CTNnddm0nIBGw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:43 +0200
Subject: [PATCH 07/70] drm/gud: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-7-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WjG0NGReqeHLtFG50kMJ729Ge0jlddvmXfOSb4h2UZs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSb8EXzxLbmE9q/pbMvUWA6vmlEuTuUSkDqw0s07cf
 TmPQ/J7x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIDRtjw1RnzcSjpbu23uiw
 y94t/i/IMvCM9bG53DUFRQfNfC6khgTs33rv2szXC+SKtijt0pQ2ZWxY/G2i/0+tHIHij4IiX09
 MTZ/rXvLkpPWG3K8tu3pMzqlXv3uuvLZ87pH3TZ8rJRNZjHYDAA==
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

The gud crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 89bd6ca36003..83a036c6e41d 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -343,11 +343,11 @@ static const struct drm_crtc_helper_funcs gud_crtc_helper_funcs = {
 	.atomic_enable = gud_crtc_atomic_enable,
 	.atomic_disable = gud_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs gud_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

