Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E03C43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7A010E440;
	Sat, 27 Jun 2026 03:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZqI3IJ0v";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D5310E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 426374E40A00;
 Sat, 27 Jun 2026 03:31:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 15DB660233;
 Sat, 27 Jun 2026 03:31:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ADD53106F1172; 
 Sat, 27 Jun 2026 05:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531107; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aqUeAdfRMUeJoGH0Dv/QpauOpWa/cRF5WcCXvZnC8v8=;
 b=ZqI3IJ0vwrzlR4jB4ZtrMwKoV3omPPKEC8WoO1DRgMChk7Xmbdh+VB7+7fzCo0seMTFqHV
 QeKzII9LZzxujEqFn5iQyL7cQ2S4ivCnTl6Ua0FTJILVvVVBj/rfxXUDOy08X3r4jGRxYu
 1flKfQ4OFjTHqBY0TnH60jG4XhVGVMJ694dV77WAueNpmMtgPIfnTXORgeT+3UR8IrSAJx
 FrXNzS3wl2hx0v9MjSwiybi2maVyygPqZT2KQmXG+0AfhnKJ4+bap1cZYxaxZzZrvThnGj
 +HNk8g9dLY8lqzmywDRIqrQbFD1JsPelydASxeDUsPg36QU9RSMKxjHopqwgKw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:41 +0200
Subject: [PATCH v5 24/38] drm/vkms: Properly render plane using their zpos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-24-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=dbnNOCVyuHgzODjpkXH7tcpHCmDfL0zKsDiaeIAlbdo=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PgRY3eCdENGmpYDgYmhS4LQKZBvVCrsK1W4
 tuXi3q7uACJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKavA/9EWZ8uaE5oglEpSJxLEisWcQU8IdCW0U
 ImAKTuFH4kdMVHFG4r/OFj1N8x/MZfbThX0ZCHWzOjuQBbuShDvE/7t1nJ31KMZssC+IcX3ki1o
 4OJYJ0tXmcAADWqJP8Q3Sq1L3VQlzbmpXm9/eBKh1YGcz1wAL71Uw2DX0GQ5tWpvv5RUB12nPf2
 QzIBRCFh/7pKZUZwcPZLcAwGouoLpzFZd6YFMlS5+y7B79on49XqbU5+wj14SD0E5f9dZvqv54/
 IKyS1QkVkt0ZhCm/cEiepdYXAa/uSrDNXR3YMc7XFuO6u9tkBPV7otzpDycXycVyp0lfDkEyCgk
 L97s6IkarOl1qMrrXoJkckWEohXhD5YXeF+ECyp8zhF+p09DVSkUXX4Gq28uWGa/tepZJ5d9UAd
 EeaO3MJfQc938hnDAg4A9XJCxXrgXYA1LYqmYd/Puc+demIFhlSRTRNClIlJWZpyd4hpnKmeCP2
 Drc8TaXJLiWWyTyN1UHACrZpR8pysWj9jW48nLtp0Y/cTBQFaAUti4xCBqU/apocpviYTnL7Ccg
 WOeHcz9fXVMCIFmVJLP1sXq+hZDCc+WDL3nwP7s0Fh/LJcG/G3Iy4B8qTtrkpu/K78c//s1R1Qv
 7xoOc8tsbCzPo49zHgrEXXDTqxbQfO+kQcRYHdFDmKwMoXGpZkhM=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

Currently planes are rendered in creation order. This is not an issue, but
with the introduction of new zpos configuration, it is required to
properly render planes.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 079abfba427d..b9428de2d4aa 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -142,14 +142,20 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
 
-	i = 0;
+	ret = drm_atomic_normalize_zpos(crtc->dev, state);
+	if (ret)
+		return ret;
+
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
 		plane_state = drm_atomic_get_new_plane_state(crtc_state->state, plane);
 
 		if (!plane_state->visible)
 			continue;
 
-		vkms_state->active_planes[i++] =
+		// Order planes according to their normalized_zpos
+		// After drm_atomic_normalize_zpos, the possible values are 0..n_planes-1
+		// so store them using this index
+		vkms_state->active_planes[plane_state->normalized_zpos] =
 			to_vkms_plane_state(plane_state);
 	}
 

-- 
2.54.0

