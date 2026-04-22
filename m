Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B3BFA1FD5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F003210EECC;
	Wed, 22 Apr 2026 16:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wB9a9hPc";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED82D10EECA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:49:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B386DC5EF06;
 Wed, 22 Apr 2026 16:50:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CECA45FA8F;
 Wed, 22 Apr 2026 16:49:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED12310460BF3; 
 Wed, 22 Apr 2026 18:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bS5tvGPU8YoGSDlKi+8QteFnA/DpeG9M3mcprRbVAl8=;
 b=wB9a9hPcUQVmgZHYZeBxhYeFYSWWNcZEhxaU66LpQYQ2FZaw4EezXGjUdFsn5PZHTw7g5N
 pg/MkmO5i+dNp19nHSa/yp2CAYJCrzupe009b/H8Kz5JfVWYv83Y3PNXkYOeuxuivyRC+s
 TxqIaor24rMN2HWbanp1MHKffx1jtsli5sP64G/gaZku4ITscrXUU0y6F/1xdNbF4ou47R
 Sxd3AvbLaAIHRpC2Qgv7NsDbgjTdUBQQjcDCHuiJxGlozlL7P4G33AtU/tc5MrIpeplwj7
 VDSw7IYd/EZ58AzykOEoPRlScT5SjM7WMHizmkJvfFm4EX/lgw341ZvGAo8hvw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:20 +0200
Subject: [PATCH v4 23/37] drm/vkms: Properly render plane using their zpos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-23-dbb52e9aadc3@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
In-Reply-To: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 llvm@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16-dev
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
index 35ddc553a5e6..faaa13f8b31e 100644
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

