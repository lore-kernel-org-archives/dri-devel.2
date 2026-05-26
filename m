Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF17DCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 18:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABD210E4B6;
	Tue, 26 May 2026 18:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pbgIX87J";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4657C10E4B6
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779819441;
 bh=KLzRwNHwtY0byiHeNkWWjPvarNGJTAfL/OSZMOgasBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pbgIX87J/tk2fyHoi7tNbeDPXgE78G0b1eyM41S8X3QDchlQ2xcRVOpFxbvVpLLYu
 iObepXEJZ2e1noV8oCGI/wLPK9how2oqcvHekIHBuQkHTZulO7fzjONfM3bW580ngQ
 s2hyaqyFu+BjCX0wvIzKPk+fvlvI/y79cLy7E3wqztr5pJTDhGCfCb6D+VakcGdfb1
 4KvrOLo4X4Lz+3Uz4RotNxcxubqiXdofd0bHbj5ZGML8RKQ7S9RBHySzByOYX5R6VN
 3YlQq4adHHNdQF1/DtAfYtRPtoD8maMswbztockyGHXGCrACr1FMq9T+eLkcz3P6Xr
 M19YTs7FGBNjA==
Received: from archlinux (unknown [100.64.0.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C90117E12C6;
 Tue, 26 May 2026 20:17:17 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drm: ensure blend mode supported if pixel format with
 alpha exposed
Date: Tue, 26 May 2026 15:17:00 -0300
Message-ID: <20260526181700.25310-3-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
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

Before "drm/drm_blend: allow blend mode property without PREMULTI",
userspace would have to assume that only PREMULTI was supported by
drivers that didn't expose the blend mode property. But now userspace
shouldn't rely on that, as they can't count with drivers always
supporting PREMULTI.

Warn if a driver exposes pixel formats with alpha but doesn't expose the
blend mode property. This way userspace doesn't have to guess. Drivers
triggering this warning must be fixed.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 66f7dc37b597..8cca1dea3b3d 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -674,6 +674,25 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
 	     encoder->possible_crtcs, crtc_mask);
 }
 
+static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
+{
+	const struct drm_format_info *fmt;
+	u32 i;
+
+	/* blend mode property supported, no need to check anything */
+	if (plane->blend_mode_property)
+		return;
+
+	for (i = 0; i < plane->format_count; i++) {
+		fmt = drm_format_info(plane->format_types[i]);
+		if (fmt->has_alpha) {
+			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but "
+			     "blend mode not setup", plane->base.id, plane->name);
+			break;
+		}
+	}
+}
+
 void drm_mode_config_validate(struct drm_device *dev)
 {
 	struct drm_encoder *encoder;
@@ -732,6 +751,8 @@ void drm_mode_config_validate(struct drm_device *dev)
 	drm_for_each_plane(plane, dev) {
 		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
 			num_primary++;
+
+		validate_blend_mode_for_alpha_formats(plane);
 	}
 
 	WARN(num_primary != dev->mode_config.num_crtc,
-- 
2.54.0

