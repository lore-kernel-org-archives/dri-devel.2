Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8EC4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4216B10E766;
	Thu, 16 Jul 2026 11:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANa1ebw/";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FFC10E766
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:31:14 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49392c85c8cso5157325e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784201473; x=1784806273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e5CmSTYkwSFknR5AGKkjqSMNuhrUCH0vfnwLK+Jw0JU=;
 b=ANa1ebw/u3bmP8Mk+FvPnGO03GqCXkuRmTWrsqXNV2QrOQY+FMpyZaQnhuyvi42nlp
 k3gTk945B93v6b7NyGCUbe5CSu4Q5oSFD3dfyajakjcOl9Tqu1h+JKCO5qQL8wwG3KRb
 j+fpUgi66nX/HJQwDZNCIh11RoTrvXXnoNVmkXf17UEYI6/gSaW2fN56HbVWq8uN3HCS
 kaAk/QvzX8odKaO/fo+MpyDyAG+Pl62F4Ih0uoxj46kT2xFg/VUvvTboFd7W9JPST4K7
 9HRho8CIeMQhkF7h/GjVGq/0ezYqKgkz+hvPM+6uyzHfXhfe5Kiq8ABO+80TNJQvkC4Z
 LcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784201473; x=1784806273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e5CmSTYkwSFknR5AGKkjqSMNuhrUCH0vfnwLK+Jw0JU=;
 b=Ztv2MY1HgN/Cyu/wpiqqssi1KlR7jjC8/Ey6tLl0yIM5DhubS7R4VUlDa7f2b+xVwg
 1vvlalRYCdmWw7nQGDFjHqZZH+dJ+++Qc85S+YoNCqq7zS/PLC7a72reT/qgnoAzkbDG
 sp2MNiVQ1+2VpaAoCAPFgStqCCAYTois2LPzIG7zJ/6JyBZU57+ZinRx4n+UagjuaQFb
 M/rqmSHqiiHiUkB8Njrmhh7COoy4yyJC8CR40wxHSqtHoOjJiKQQiqFOEWl3R5V6YWbf
 LJ9N091DsDGXUx1fWq3u4kDF6NO+mQ2glt7rp7B3pIYvV0MI1Jww/tgOCKmOF9cYZGW7
 PiDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoaZqwcePYbeMfLKYjPBWK93vgBO4yqWbMAcN2F4vm4iPGN0UNp9bJJ+GVy1k80Y3dcwpy//v2K/84=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQF9g3iEDOn+Taz0XhH4FqInLmT+dJyVm+oV+7Sq6XlSwYOka9
 j7xHQhWAMXPoOC0Hrr+FxfEuNa2YwBlUntZH9xoAg4GbqKl4jdZFW+cD
X-Gm-Gg: AfdE7ck8Akei712w/6vltnTgoaakXSiKpjfUulcrQSt6A6mfwwoTvtfTJassxbSC6kc
 Yj+26gc5Gus8QCa0WuIm5whgtEh4C9W5Xx8kkBYU0ROWjpK82jnJSFnFYpxWmB1rnK0kX1DHyRX
 3TdcCb8HFTvO6SVLl+kviMK06yf2+RCwC7irqEGA1vGVSjZJUSfx5DRU2QgnZdFTa9hkbTyKchz
 fLJzn3n+tu9BElJNB9xhl+F366FkLC08ppunH5sTipkVFJmNzjeWRweeM667QJvOxI+l2GhRcJl
 AadvthEZz8SC462O00zbHyhStnZ6mfeeqjguN3ktmuz4nXXdkJ4ArATvWmHLPaVSo4Gb2p6jZ8Q
 ZSK0Zd5/Sst7NnouvvgdHyHBprGEhhEbaebEuLgBtkzhB8R41WYsudIQ4qUiAYFT8qOQY3p/nmU
 vD8+6fKgwQXBtaDJbXgyK4cRGq+oECjNI7PPBg8BHzqgDc16+uuHIgIMtFLh8Df0BUEyTULKA+N
 EQgpGwlfps=
X-Received: by 2002:a05:6000:4285:b0:473:aed9:ef1c with SMTP id
 ffacd0b85a97d-47f2dce2d29mr13817474f8f.7.1784201472578; 
 Thu, 16 Jul 2026 04:31:12 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8DDB00EEA7E4D0825D1D4E.dsl.pool.telekom.hu.
 [2001:4c4e:1b8d:db00:eea7:e4d0:825d:1d4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm25222130f8f.4.2026.07.16.04.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:31:12 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] drm/rockchip: vop2: add COLOR_ENCODING and COLOR_RANGE plane
 properties
Date: Thu, 16 Jul 2026 13:30:24 +0200
Message-ID: <20260716113024.15357-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The VOP2 windows have a YCbCr to RGB conversion block whose coefficient
matrix is selected by a per-window CSC mode field, with hardware support
for BT.601, BT.709 (both limited range) and BT.2020, plus a BT.601 full
range mode. So far the driver hardcodes this to BT.709 limited range for
every YUV plane, so BT.601 (SD) and BT.2020 content is converted with
the wrong matrix.

Expose the standard COLOR_ENCODING and COLOR_RANGE plane properties and
program the window CSC mode from them, so userspace can request the
matrix matching the framebuffer. The default stays BT.709 limited range,
which matches the previous behaviour. The hardware has no full range
mode for the BT.709 and BT.2020 encodings, so that combination is
rejected in the plane atomic check.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 40 +++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 4cce3e3..22e056b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -667,6 +667,22 @@ static int vop2_convert_csc_mode(int csc_mode)
 	}
 }
 
+static int vop2_convert_color_encoding(enum drm_color_encoding color_encoding,
+				       enum drm_color_range color_range)
+{
+	bool full_range = color_range == DRM_COLOR_YCBCR_FULL_RANGE;
+
+	switch (color_encoding) {
+	case DRM_COLOR_YCBCR_BT601:
+		return full_range ? CSC_BT601F : CSC_BT601L;
+	case DRM_COLOR_YCBCR_BT2020:
+		return CSC_BT2020L;
+	case DRM_COLOR_YCBCR_BT709:
+	default:
+		return CSC_BT709L;
+	}
+}
+
 /*
  * colorspace path:
  *      Input        Win csc                     Output
@@ -707,7 +723,6 @@ static void vop2_setup_csc_mode(struct vop2_video_port *vp,
 	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(vp->crtc.state);
 	int is_input_yuv = pstate->fb->format->is_yuv;
 	int is_output_yuv = is_yuv_output(vcstate->bus_format);
-	int input_csc = V4L2_COLORSPACE_DEFAULT;
 	int output_csc = vcstate->color_space;
 	bool r2y_en, y2r_en;
 	int csc_mode;
@@ -715,7 +730,8 @@ static void vop2_setup_csc_mode(struct vop2_video_port *vp,
 	if (is_input_yuv && !is_output_yuv) {
 		y2r_en = true;
 		r2y_en = false;
-		csc_mode = vop2_convert_csc_mode(input_csc);
+		csc_mode = vop2_convert_color_encoding(pstate->color_encoding,
+						       pstate->color_range);
 	} else if (!is_input_yuv && is_output_yuv) {
 		y2r_en = false;
 		r2y_en = true;
@@ -1109,6 +1125,18 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
 	if (WARN_ON(format < 0))
 		return format;
 
+	/*
+	 * The window CSC hardware has no full range mode for the BT.709 and
+	 * BT.2020 encodings, so reject that combination.
+	 */
+	if (fb->format->is_yuv &&
+	    pstate->color_range == DRM_COLOR_YCBCR_FULL_RANGE &&
+	    pstate->color_encoding != DRM_COLOR_YCBCR_BT601) {
+		drm_dbg_kms(vop2->drm,
+			    "Full range is only supported with BT.601 encoding\n");
+		return -EINVAL;
+	}
+
 	/* Co-ordinates have now been clipped */
 	src_x = src->x1 >> 16;
 	src_w = drm_rect_width(src) >> 16;
@@ -2472,6 +2500,14 @@ static int vop2_plane_init(struct vop2 *vop2, struct vop2_win *win,
 	drm_plane_create_blend_mode_property(&win->base, blend_caps);
 	drm_plane_create_zpos_property(&win->base, win->win_id, 0,
 				       vop2->registered_num_wins - 1);
+	drm_plane_create_color_properties(&win->base,
+					  BIT(DRM_COLOR_YCBCR_BT601) |
+					  BIT(DRM_COLOR_YCBCR_BT709) |
+					  BIT(DRM_COLOR_YCBCR_BT2020),
+					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  DRM_COLOR_YCBCR_BT709,
+					  DRM_COLOR_YCBCR_LIMITED_RANGE);
 
 	return 0;
 }
-- 
2.53.0

