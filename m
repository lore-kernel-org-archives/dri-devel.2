Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1464CC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE7210F220;
	Thu,  2 Jul 2026 08:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Geisr4Ww";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE20A10F220;
 Thu,  2 Jul 2026 08:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782980259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UQ4N3uoTpLdHqGqeyN6bP31boYEYbJk7nNKzBUi5UAzHO64mnh7++NtNIct+RRm7qcF8xCT5MvlrEO1RCoyEFTS5GU0U/tMU/oU9fdUwZYLyCPDWkGbCs8tVlqHqao4O3u+Q5DQye2g0cM91EGHlayR20QkHYUF4Ajh+FPQmVNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782980259;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wn/JhRLP/kw9OT3tYgqPgKSK7xYfFVe48gW5Umt2FKA=; 
 b=F0k5PoQ6m7wK49IAyXZLL7cze/9rSRUfw3GXTqsIm2YYYE9C2AgacsXc+EEcxIGiw7pSCWz+L25ElUFWs3OWx2JZQpvUc8FpjYGP8cgjV6bUYbS52HiDSKvxbUToxXYS1BsPT90YUnEl7IzdNweJvBdUlSwYNjEI/QwiDTSdcP8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782980259; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wn/JhRLP/kw9OT3tYgqPgKSK7xYfFVe48gW5Umt2FKA=;
 b=Geisr4Wwqy5yLjY/Puu8gfYpHnElb+k2YKKM+wJf8reqnJ+D3z/eqcKSGhQzx+e8
 2YCXEVcPVAVwmEX3nu4B9WEBuaT3MAFO/qYTd0i43APBucyK7JWSh83HmQF2PLSgDX6
 fdMV+4rO75ihHE+ReAwif8x6Nxtt7Ou2d9CF9PCo=
Received: by mx.zohomail.com with SMTPS id 1782980257337423.760676344912;
 Thu, 2 Jul 2026 01:17:37 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v2] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
Date: Thu,  2 Jul 2026 10:16:41 +0200
Message-ID: <20260702081641.22990-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.55.0
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

The client cap is currently advertised unconditionally, even for drivers
that do not support plane color pipelines. If clients supporting the later,
like Wayland compositors or tools like drm_info, enable the client cap on
such drivers they will be left without both color pipeline and the legacy
properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
conversion support.

Prevent that by only marking the cap supported if there are actually planes
with color pipelines.

Note: while the color pipeline replacement for the legacy properties is
still under review (1), we can assume that it will work as a drop-in
replacement. That means any plane on any hardware currently supporting
the legacy properties will be able to offer a functionally equal color
pipeline and there will be no technical reason keep using the legacy
properties if both the driver and the client support the new API.

1: https://lore.kernel.org/dri-devel/20260623164812.81110-1-harry.wentland@amd.com/

Signed-off-by: Robert Mader <robert.mader@collabora.com>

---

Changes in v2:
 - Replace the driver feature with a simple check (suggested by Maarten
   Lankhorst <maarten.lankhorst@linux.intel.com>)
 - Expand the commit message slightly and change the title
---
 drivers/gpu/drm/drm_ioctl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index e2df4becce62..b2c0234eaf14 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -373,13 +373,26 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->supports_virtualized_cursor_plane = req->value;
 		break;
-	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
+	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
+		struct drm_plane *plane;
+		bool has_plane_with_color_pipeline = false;
+
+		drm_for_each_plane(plane, dev) {
+			if (plane->color_pipeline_property) {
+				has_plane_with_color_pipeline = true;
+				break;
+			}
+		}
+		if (!has_plane_with_color_pipeline)
+			return -EOPNOTSUPP;
+
 		if (!file_priv->atomic)
 			return -EINVAL;
 		if (req->value > 1)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.55.0

