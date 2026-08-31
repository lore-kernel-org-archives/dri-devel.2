Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC692C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8FC10E951;
	Mon, 31 Aug 2026 15:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R0FRiVox";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9957410E950
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:34:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E3E660214;
 Mon, 31 Aug 2026 15:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAEB1F000E9;
 Mon, 31 Aug 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190488;
 bh=neZm+NWtZCOfwuw5eRWfPnd4ZkDtMvem/wAv00azdQY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R0FRiVox6EEyNGCBkwgp3+EaufseXXqxU2c2yo2Q2fN5cl+0IvOG0/5oADw7Giq4j
 1f20icBPKnpCrGqon5qn0EQFCOkGg5Niy7ggkooNFR2tP+onsxbbrJaS0Rb9JZwHma
 3qr0OoLE/y2ZotwhK54Xcn1u4VevuGFOLI+qfDOt4oTtKKjfwhXYwb+TVEHqeWybq+
 A3wPnr35FAWgdHHFZ0eF8g9Vgn/u5gx3Hy2NUDvNArrIkKQOAXUU+0NadT4Cfa2Klk
 Etk4OG/Sa5NP9mxZbB5zsL28VRfW/0bjTz2bBYY55O4LboVGLZW5cojz6EBtZEOAUI
 LL5gEwIhiihqA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 17:34:18 +0200
Subject: [PATCH v2 05/13] drm/tilcdc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-crtc-reset-v2-5-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dagBGMFWByWpy+3AXs/qc6yB0OlkOY1S0mQ5SNOQ8lA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/1tPbbsz1TpNadYVW20TkmVWUiuytluUJ66+nC9h
 7Qi45IlHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/wIYG67eWN4z5cX0z6o1
 5yxT9xUc+B0eesBigeMJ21eXJsk0P3nEY3GEsW9/CpPoF87rvCtsvBirWbcLpKc+mpw0KcbY5cw
 T4Up+F/kQQy67G+9WrF2RJzl7oqnmykMV8jbrWjtn/DBuzr0KAA==
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

The tilcdc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index b299d73ce385..f619b7a6e70d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -712,11 +712,11 @@ static void tilcdc_crtc_hw_reset(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs tilcdc_crtc_funcs = {
 	.set_config     = drm_atomic_helper_set_config,
 	.page_flip      = drm_atomic_helper_page_flip,
-	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= tilcdc_crtc_enable_vblank,
 	.disable_vblank	= tilcdc_crtc_disable_vblank,
 };

-- 
2.55.0

