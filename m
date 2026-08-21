Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230AC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE6310EBF8;
	Fri, 21 Aug 2026 14:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K1r5RhAN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21E910EE68
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3753412C5;
 Fri, 21 Aug 2026 14:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BED1F000E9;
 Fri, 21 Aug 2026 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323174;
 bh=YwKI5yDZ9O85RvbK4cbgTYP9Q8YE2LQecf5shsJkhh8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=K1r5RhANfk+aTbLHmz/WpDkVtB4wnjhpxDe2pTC09WFHb9DwLs/SiyW7wjJt/1e3L
 +1tDeQLcZB5qYvh9h3/GLMoKp/XELkzkmrh0/d1umS5s980Vdv0SqziVezhWamp4Sy
 VOK5+d4qEC5RX+z56y0x/MpkusMBgEH1nvQ78703iCtio6QpA3HbI9vmRizoWFxk4z
 9zgWp17mNBlYTeq4478YszZXCBinyxyVEibwQGF9mT/pjdrNGnHEY/0CoEINX/vHi9
 JyYzTZeAaEdQcJeaAyODYx00TKiTKODX8lNIt0MJ1mldnZYCGFUReOt1RN/y1e2wR9
 PcvCxlslkhijQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:41 +0200
Subject: [PATCH 05/70] drm/exynos: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-5-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1o3Ndz6ezdx50B8YsDKIbtfJV6Vg99IBCJgOqljqIHM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdST/fVl9fsuOFNEfQoWtXGg2vJi92kdmYOzW9SfRIY
 LPjoT3+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAirzgYq9nqnv0316sSt20K
 KP3sw+Mr8DmG/QSjbNQELYajs3/ZMNo+ulzm0Bke8DRoZ6koT0QsY32Z7J64qy+XZUQ+3OD7Ycu
 vqVyfd0vVqt49buSluCJq4isecYd4Zrt7zWVPnT/u9plepAYA
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

The exynos crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
---
 drivers/gpu/drm/exynos/exynos_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index b071c019670d..458cad64bd07 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -161,11 +161,11 @@ static void exynos_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs exynos_crtc_funcs = {
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,
 	.destroy	= exynos_drm_crtc_destroy,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = exynos_drm_crtc_enable_vblank,
 	.disable_vblank = exynos_drm_crtc_disable_vblank,
 };

-- 
2.55.0

