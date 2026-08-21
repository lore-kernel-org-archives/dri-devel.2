Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BACC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9475510F117;
	Fri, 21 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dXuHIl6C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3168410E30C
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 184C141A5D;
 Fri, 21 Aug 2026 14:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7378E1F00A3E;
 Fri, 21 Aug 2026 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323211;
 bh=EfdARYIEnWcsW3l095v7ANfPV12kbdFyoBSIREjIoFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dXuHIl6CX2p9oP3nwqufHtCktjoXrJpiATiNi1D1HRwEdHg5HTAVgjhgjJ5xRV9SP
 el/jqap22gFpqUvhOqaHDShaMwhi/GNB9D/1XuNDrn1n/zIfDJ27C6sUHHWZyb7N8H
 0ZyMir/Bm1wCSmvq1ABPxAJBjKX75s1+q0azGTvB+Zho1Nz5Hy6dOX4w+t4X4IFoKY
 qmGqe2p5ZaYPScrMrUVZGoxbGQZOAicinvEoJW5wDfaSluJQ1+jLu/6yel8MHwFXBd
 J7Bm3Eq1Kyc1d/ZND967ZTS+EwF/xu/3h8O2v0t6EJplrE7jGeJm5BNdxF4+xoL+40
 U9Cc7u4UugNHw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:56 +0200
Subject: [PATCH 20/70] drm/renesas: shmobile: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-20-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tgTqNRTuE/qYBhsMUVKSF4aasb30woH+3UrJXa7d+ic=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyYze+bbOC5ex3l/Zd/Fzo/ICy0U75ylNf2d0WyT40
 0HtbqlJHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiU6sZG1YxaWXf2zQ9MD2H
 i6fCoPHjBt3YJUzVR6W/bF+z1nXVsoCd1S+T9jwWjH788eOGqiC1y4x1ynxhp9yebzD9dX1D5B1
 7TgH/4EsJ93K2MAvO3Rj0ovKylEkTi1d2x7rsiECWrm/O368BAA==
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

The shmobile crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 1a2b9b68af6f..2ea510cbc55c 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -362,11 +362,11 @@ static void shmob_drm_disable_vblank(struct drm_crtc *crtc)
 
 	shmob_drm_crtc_enable_vblank(sdev, false);
 }
 
 static const struct drm_crtc_funcs crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = shmob_drm_crtc_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

