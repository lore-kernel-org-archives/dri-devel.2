Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F1C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7082C10F2D9;
	Fri, 21 Aug 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SMT2e1Zk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA5F10F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03C434403B;
 Fri, 21 Aug 2026 14:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA41F00A3D;
 Fri, 21 Aug 2026 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323234;
 bh=OICp5bsGGsb0bVDe/d3hK4hcwLbRHGHvekLKySZQUak=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SMT2e1Zk0JhjfwtEw+xBTE/orrmR1hy+Wx8s/Cv3CAhVMdYAxmt7uzksHs+7xKokt
 kTcG9yQIOh5x/sN9WcVUIIi0m8xuTHSfyiNmp/3GxJVc3x9iev/3e7xFPuuJeKZayN
 zF05s398ez+1FXx369GT8La1C4vox4P9Vsoe5a2N7FdC30zLY/atgl7yzxJk7SIgS2
 6wiEKlqSnZY+Zk3QCPve7ytPNZrhqcjiGjUNi53W95+2lQD0y7MLTx12MFYkh/IZ+w
 kXkos4E0KP5JyKXTX/zJN59ID2Stx1WVHPUdKB4K3VzuiVW4qbDC4ril4qIUog+Yv7
 ZFhHlZdPtSlqw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:06 +0200
Subject: [PATCH 30/70] drm/tilcdc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-30-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=mripard@kernel.org;
 h=from:subject:message-id; bh=v+ML639uSKzRnlOjBFX8gutoJoRCX21NzmYFD9w56HA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyaxfdU/OWfnoBuuqF+1vha8fEDyXrHXrPOvXE8c1z
 t3UP2tQ3zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmot7I2LAyuPz0giey6QlN
 ZrazDB9fOOL3n/fjCq5E6aumX0wX3v1W/qnpZqGJ9lnFxWavJbXfCjDWBy1tY71wfdKGE+ZyVYt
 V4wz3v7HhWaCit9P1FtcGAYZwoYCPD74o/bV2nPLlpMSCwPIrAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 910580c4dada..b84baccb0b9a 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -686,11 +686,11 @@ static void tilcdc_crtc_disable_vblank(struct drm_crtc *crtc)
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

