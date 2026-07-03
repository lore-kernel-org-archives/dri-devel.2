Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7813FC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B736010F6A7;
	Fri,  3 Jul 2026 07:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="G+YS6hGx";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D6110F6A2;
 Fri,  3 Jul 2026 07:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783063970; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cjiKBcRJ2FcfJtGgLDm2hbDOXuOzDEnA24oOaPihvz6qIPbq9wEKxbb3M0feRtvHBVG60El62ZZLHx8zffZhHOXTKl2SdPUKMez3SwxvPlJ8tvewbgcn8rUAyL5SumQBTKZNyo5khjCxoQiXFig5BbYsuN+YK9ntAf/0LFh8OBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783063970;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZYbUgCJ3ExixzrmVpyLYUCTsn1F7Y7J8nLL7GxXpIYs=; 
 b=JO+ESHHtQJksuVG6yAiK5+GCGF4sT7bkLIFTmDQBoCFSc35ozTiejfVA6lGXyPHEncdnpG8gCIpNhyRx72PWt+vhAfGGKJkLZaKn045OvtlfxCyLC4UgUzJR/kgs2z+x+/ZUpdpJCDoTBrc5VmsZVIDwBNqbGKeEUFeXKlwf64Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783063970; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ZYbUgCJ3ExixzrmVpyLYUCTsn1F7Y7J8nLL7GxXpIYs=;
 b=G+YS6hGx1beU1SmsTlsKvXRZGgG6QuBlxYqowKWcvbO20A3qEvUsmoCJLcOS7FXq
 kHShIcWj3WttwZYHofQna6PIYhBU1PJhXVXog/GPoJEV5tDR7iLWVkA/6+gNvjERu5Z
 aaiYeAEnQg6U4tTrBHbmAsce/6DyJLT/gNdJQHkE=
Received: by mx.zohomail.com with SMTPS id 1783063968273443.120155012085;
 Fri, 3 Jul 2026 00:32:48 -0700 (PDT)
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
Subject: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
Date: Fri,  3 Jul 2026 09:32:30 +0200
Message-ID: <20260703073230.19982-1-robert.mader@collabora.com>
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

Changes in v3:
 - Move the new check behind the existing EINVAL ones
 - Rebase on latest drm-misc-next

Changes in v2:
 - Replace the driver feature with a simple check (suggested by Maarten
   Lankhorst <maarten.lankhorst@linux.intel.com>)
 - Expand the commit message slightly and change the title
---
 drivers/gpu/drm/drm_ioctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index e2df4becce62..9039a39c4324 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -373,13 +373,25 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->supports_virtualized_cursor_plane = req->value;
 		break;
-	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
+	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE: {
+		struct drm_plane *plane;
+		bool has_plane_with_color_pipeline = false;
+
 		if (!file_priv->atomic)
 			return -EINVAL;
 		if (req->value > 1)
 			return -EINVAL;
+		drm_for_each_plane(plane, dev) {
+			if (plane->color_pipeline_property) {
+				has_plane_with_color_pipeline = true;
+				break;
+			}
+		}
+		if (!has_plane_with_color_pipeline)
+			return -EOPNOTSUPP;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.55.0

