Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB07C624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B532210E9D7;
	Mon, 31 Aug 2026 16:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KPhStYCe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6D110E9D1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:19:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E43A60120;
 Mon, 31 Aug 2026 16:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D42D1F000E9;
 Mon, 31 Aug 2026 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193167;
 bh=olsmZ3Ul3s7zk2Rw+ehqajM9/0dEgO9HJWPnMUut/sI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KPhStYCee23CmdpbU1iQ2oABZ0fIqzR8ttDSq3ri6dOSTrDW/zIZBsE6Tjg3rxMDu
 Zr1p01FyqrvVv6V2y7/XUiW+a7rPyOoGLBafems5lJmqV+Y6nqt33vYbj0JrgCgXqS
 +yaq751LvOHWfZTR2I7MtkSUxL0Wi1+mtJWkB5M6c4GobgBggoyP1b4WQAAhD/7dut
 qMMo3id3V77UoiSayFlhkN8cKDX9tJJ/P3uDviNqNUv57Lz0zdG3i0ReXQphEZHKZX
 iS44a2OecuOy+LJNZaog9KXxsPpwijfAVI2K2Ar+mbqVHUfVuvTy6jwA8wHuJpTocy
 X2y21jjqxHFEQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:43 +0200
Subject: [PATCH v3 27/40] drm/atmel-hlcdc: Drop spurious csc_init call from
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-27-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=mripard@kernel.org;
 h=from:subject:message-id; bh=P2JfiAyIE8I/b6Akuzj+8Iq3yjmRyLxXcr2s/t84Huw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTV8qkNaWfbZKJXb+74aF46PPqNtZL33axrI58e3WJ2
 mwuW5W6jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRgguMDTu2y58647x904zr
 LvWx64VXblLjzNb+McOhZIJe+ck3N/sZwvX6F3jdOeE0+dspC/bOSYwNu5gWmkt+6e8s2FWnuuf
 CjKX+68rVT0dN7pzFl63lnNnxljm1fu/U3enmtXG89/yyJgsDAA==
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

The lcdc_csc_init callback was introduced in commit aa71584b323a ("drm:
atmel-hlcdc: add driver ops to differentiate HLCDC and XLCDC IP") and
called only once, at init time, from atmel_hlcdc_plane_init_properties().

commit 81af99cbd9e4 ("drm/atmel-hlcdc: destroy properly the plane state
in the reset callback") then reworked the reset hook to use
atmel_hlcdc_plane_atomic_destroy_state() instead of duplicating the
code. However, it also introduced a new call to lcdc_csc_init in the
reset path that wasn't there before and wasn't mentioned in the commit
log.

Since CSC coefficients are hardware constants that only need to be
written once at init time. This also prevents the conversion to
atomic_create_state, which must not have any hardware side-effect.

Fixes: 81af99cbd9e4 ("drm/atmel-hlcdc: destroy properly the plane state in the reset callback")
Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index f17a832351e9..70a1cef24388 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1184,12 +1184,10 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 }
 
 static void atmel_hlcdc_plane_reset(struct drm_plane *p)
 {
 	struct atmel_hlcdc_plane_state *state;
-	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
-	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
 
 	if (p->state) {
 		atmel_hlcdc_plane_atomic_destroy_state(p, p->state);
 		p->state = NULL;
 	}
@@ -1202,13 +1200,10 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
 				"Failed to allocate initial plane state\n");
 			return;
 		}
 		__drm_atomic_helper_plane_reset(p, &state->base);
 	}
-
-	if (plane->layer.desc->layout.csc)
-		dc->desc->ops->lcdc_csc_init(plane, plane->layer.desc);
 }
 
 static const struct drm_plane_funcs layer_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,

-- 
2.55.0

