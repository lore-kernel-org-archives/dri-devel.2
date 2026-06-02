Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F5ECD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94B910F60D;
	Tue,  2 Jun 2026 22:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="EbNioqCw";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9073A10F299
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:01:22 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ee6d32402so3066764f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780419681; x=1781024481; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X8xIPFYU6wfDv0UXLz0s+nj/6PQ14Xci+jABKOcPGUI=;
 b=EbNioqCwS6iW+EAH7p8ujKW6R+lzDDhSVfMBfEDoPpevovRMSgVoR4E4c0h8UGAE7R
 9TD6QH4drVwkBwt+VRnTbAPvW0co/SpV+9cGnEETCqAdZ1FydtzkKrpbelbBMNgmcKig
 yoJ00fMDnENIUc2WDeuy2Bztw41vgInQ9NYDc9AGs9uPqxJTngz0SQUvK0+oQYPwelju
 zDunRWkdW0QmOVCVk1M9fPPS/Rh5Hd76cWRgGH7DuxVX5vLM81rKEjYifAf4A8JebNll
 nhhLvAHxv/FAThe3uYzgq6sPIxIJiAmR4RqyMFelQMh/DaxdFMFh01xe6/r6iTmn9D79
 UKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780419681; x=1781024481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X8xIPFYU6wfDv0UXLz0s+nj/6PQ14Xci+jABKOcPGUI=;
 b=XnxadeZdEeiuz3mvCIKjjz/1il154GoS7YyGPHKdt03FTZ488RpraUmiujRVn7g6QM
 OwCkMdu00XJw0wEHBlEq35QLGgwO69KG9+2uVT4kft/FeF09ZxUOlQpUgQV9w0XdKWUl
 8uEnAJkmjSDAjdCuimXZII4KWWNc5gc1dKg36N4ZeDJ2eQxl3itT+orajDJXDvX9wgr6
 v5YLV8UYgNkcq9FAHSMi/ENm+02zB05S/shp7zCB+XfkdlcHjiJk7nmVffj9lJz5U1BG
 e3Cq08/PIu0uNOmuvnTQqcHrG98icxRYeRvkNjMgDzDkzenTl4WRH4qyUkqfktwNcFky
 MtFg==
X-Gm-Message-State: AOJu0YwJq5x8+VhzHe+Dc8a4+nSyLZnmEfVUy6qlJVJtmy31yjjQyGSL
 nopr9Rn1mrUP62py7jjQ8fbf+do39SsK5uIQrTCTkU7BObnH1wfX8mdO83pcthWyBU4=
X-Gm-Gg: Acq92OE1DrlUVcFEUTsStEoumP0xcOO0Xwnu6RBAEk3nIXp2AV3ziPARyx+tludeyLc
 exc7XvlSAmYuNG9D5HO/UPMGIgSrdZLJuTajSslkLycJdkFl9INf5EgwWtp8iPaLiiapQcAHbKz
 QJM1YiFrljcmDd7TPM5hWrzzCeMXxQKc9LSzoaz8VbofVvKDIpmBk4Yx/l3OiMlBN9fyjbyBAr6
 +cd7bT9SalcTcELZJhV3Qv+btBSIbenycCy3D/ExKeYlNZRe+Thq0hAF9xOtBhqwywon/RbOadz
 yU08prmfmUyFjATOxuhXLQd1/Jl9w5gEMFFiYalcrswgREX/hehHQ3KleD3vvCHZfiZyVRNn+jE
 sFXkc/3QfRT7bPSICqAKO83iDCQNUM9EUx6Y0ikviqlDiAdfDttJ4Zfw5ET4nv35yq4LIWj2CAg
 N7OENHRNUt0aarlf7AUu8ILIzw5LkOy6kNyoIGfao2z5LinW4ThKE=
X-Received: by 2002:a5d:5c8a:0:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-4601f4e5644mr315246f8f.11.1780419680809; 
 Tue, 02 Jun 2026 10:01:20 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm588495f8f.8.2026.06.02.10.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:01:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 02 Jun 2026 21:00:39 +0400
Subject: [PATCH 1/2] drm/rockchip: vop2: honor TV margins from CRTC state
 for overscan compensation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-hdmi-overscan-v1-1-31f71b817c80@flipper.net>
References: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
In-Reply-To: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039; i=alchark@flipper.net;
 h=from:subject:message-id; bh=4HOiDswIVjSXnFgQ5UeLjf28Vzb7ocv1OaHcngkgLQk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJ84TmGZ3sfxZTdFhC7ewCsdiPOkFTdsjtlf7RoeLDe
 0E+y0a5YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKn2L2NkuLLg2GlFg+nnnxamX6+ptZyqFFHX61jNr374x5utgZ+ebmRkeHnt+5m
 ZsUsOltdqF03wbsuumrZ1tdMVnUXPZkqtTDi0mwMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 02 Jun 2026 22:31:15 +0000
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

Replace the hard-coded percent values with pixel margins carried in struct
rockchip_crtc_state, sourced from the standard DRM "left/right/top/bottom
margin" connector properties (struct drm_connector_tv_margins) to pave way
for HDMI overscan compensation support.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h  |  2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 2e86ad00979c..83f8ec4f3319 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -10,6 +10,7 @@
 #define _ROCKCHIP_DRM_DRV_H
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_gem.h>
 
 #include <linux/bits.h>
@@ -53,6 +54,7 @@ struct rockchip_crtc_state {
 	u32 bus_format;
 	u32 bus_flags;
 	int color_space;
+	struct drm_connector_tv_margins tv_margins;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a160077a507f..55307b8493ae 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1558,30 +1558,35 @@ static void vop2_post_config(struct drm_crtc *crtc)
 {
 	struct vop2_video_port *vp = to_vop2_video_port(crtc);
 	struct vop2 *vop2 = vp->vop2;
+	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc->state);
 	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+	const struct drm_connector_tv_margins *m = &vcstate->tv_margins;
 	u64 bgcolor = crtc->state->background_color;
 	u16 vtotal = mode->crtc_vtotal;
 	u16 hdisplay = mode->crtc_hdisplay;
 	u16 hact_st = mode->crtc_htotal - mode->crtc_hsync_start;
 	u16 vdisplay = mode->crtc_vdisplay;
 	u16 vact_st = mode->crtc_vtotal - mode->crtc_vsync_start;
-	u32 left_margin = 100, right_margin = 100;
-	u32 top_margin = 100, bottom_margin = 100;
-	u16 hsize = hdisplay * (left_margin + right_margin) / 200;
-	u16 vsize = vdisplay * (top_margin + bottom_margin) / 200;
+	u16 hsize = hdisplay;
+	u16 vsize = vdisplay;
 	u16 hact_end, vact_end;
 	u32 val;
 
 	vop2->ops->setup_bg_dly(vp);
 
+	if (m->left + m->right < hdisplay)
+		hsize = hdisplay - m->left - m->right;
+	if (m->top + m->bottom < vdisplay)
+		vsize = vdisplay - m->top - m->bottom;
+
 	vsize = rounddown(vsize, 2);
 	hsize = rounddown(hsize, 2);
-	hact_st += hdisplay * (100 - left_margin) / 200;
+	hact_st += m->left;
 	hact_end = hact_st + hsize;
 	val = hact_st << 16;
 	val |= hact_end;
 	vop2_vp_write(vp, RK3568_VP_POST_DSP_HACT_INFO, val);
-	vact_st += vdisplay * (100 - top_margin) / 200;
+	vact_st += m->top;
 	vact_end = vact_st + vsize;
 	val = vact_st << 16;
 	val |= vact_end;

-- 
2.52.0

