Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F29C5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C011210F658;
	Fri, 14 Aug 2026 14:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nJ3a6nnf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5F310F654
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4ADE44EA6;
 Fri, 14 Aug 2026 14:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F65B1F00A3A;
 Fri, 14 Aug 2026 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719563;
 bh=olsmZ3Ul3s7zk2Rw+ehqajM9/0dEgO9HJWPnMUut/sI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nJ3a6nnfSoYQlqf7lWfrBH/QmTXqYKyA8mbiNownCt26nKHrSBrJ4mKpcQAaCC5Ml
 uqNNzlH1KY4t5F5wNYvbGk5+S+W0MCJb1KZzVdL7aBvukfLxeviXmL3VcV+VtaFdfW
 SKVoQIpP9mUy5nFIs7lkpLtjrbqckv6mHyswU4e2xEP9EL/hplXNXiy17TUTwK2HGn
 74nLKxGoic3zt7iEGSjGdpfxXagiFt+ldjBvfCxE+swTjxZaWEH3ypJsBrOYFRq4yH
 CscuuEa3bRdp3MIGRR5zuibF+7/azeAvHBYuIR6DIhyMUAkT6c1qnSqkyysvcgjuhw
 grh8+0kfFDdew==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:33 +0200
Subject: [PATCH v2 44/61] drm/atmel-hlcdc: Drop spurious csc_init call from
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-44-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Otd5q0oql0188fHgEZHd/hLz5so+WD/XWe/mHBsHr
 pDAlUcndExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ3LvLWGfAdy3nirDs35ue
 zpwbLis57a00CW1ZGjVN6OE696uWN5hOVyyZ8Hra81Uc0SdOsXGw+DLWl/08wnRqXXJLS1PgIkk
 2mYNCP42kpyW/6L9YZWGe/X1JHM99+9xZrqltUY/NlF44q3ADAA==
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

