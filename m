Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94425C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBBDC10E1C8;
	Tue, 30 Jun 2026 08:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="TBSZmYCq";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7879810E1C8;
 Tue, 30 Jun 2026 08:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782808991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vmcp9+P2+zVVGjlknJcCugSPkACENyZchXZwe3EkEbGbyajkzli0ANoSzeauGiit1WvI9DwnWPjpWbeSIl20fquGutUd0E8txJiXY8aAln6He6+paZA96Ez/adnApuKoquc7ib60BFtjAT0zzpeJmBQtCTqKF85bCSJ0AGgkq4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782808991;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7SKXbw6sqS2+R2VhFfpClmyyEFJnI1KY9RMDYcCVsTA=; 
 b=VOC+p1UqsyZHzjNJg6+p75eVv+ap29pjP9V9DgeNuJBibqfI0mKCDWAJYA2mkEM2/RWyRk24i3LE3On/V8yz/K63YnxbcSScBYVqqyw+l2FMPiwvqdIeDrk5lUuGoGpwuWuWR1F3xy8pWAZw/nL4cqtk3NPfvhYG9RYLGLoYUFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782808991; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7SKXbw6sqS2+R2VhFfpClmyyEFJnI1KY9RMDYcCVsTA=;
 b=TBSZmYCqT98RYWK0hEu0LgcjnyoNv2ppn7AWZuWxUW686HMA7TPMv4pHdGj9mDlD
 xkkqwuBh2Y7MeJDD7vpOD9QdH8YAUZw2JeDyV3B6n0IZ/63q904DzFH2S/JZ2MZx/B1
 Eg0+T18nP5P0K1hSOouI/YhjsFLF5EBUmoOSC8Q0=
Received: by mx.zohomail.com with SMTPS id 1782808989324295.46946848078676;
 Tue, 30 Jun 2026 01:43:09 -0700 (PDT)
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
Subject: [PATCH v1 1/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE behind
 driver feature
Date: Tue, 30 Jun 2026 10:42:26 +0200
Message-ID: <20260630084229.529682-2-robert.mader@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630084229.529682-1-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
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

The client cap is currently advertised unconditionally, even for drivers that do
not support plane color pipelines. If clients supporting the later, like Wayland
compositors and drm_info, enable the client cap on sich drivers they will be
left without both color pipeline and the legacy properties COLOR_ENCODING and
COLOR_RANGE, effectively breaking YUV->RGB conversion support.

Add a new driver feature and guard the client cap behind it, allowing
plane color pipeline and legacy YUV->RGB support to co-exist.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/drm_ioctl.c | 2 ++
 include/drm/drm_drv.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e..96fda92e31b9 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -374,6 +374,8 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		file_priv->supports_virtualized_cursor_plane = req->value;
 		break;
 	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
+		if (!drm_core_check_feature(dev, DRIVER_PLANE_COLOR_PIPELINE))
+			return -EOPNOTSUPP;
 		if (!file_priv->atomic)
 			return -EINVAL;
 		if (req->value > 1)
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index e09559495c5b..108ddd2c8d30 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -116,6 +116,12 @@ enum drm_driver_feature {
 	 * the cursor planes to work correctly).
 	 */
 	DRIVER_CURSOR_HOTSPOT           = BIT(9),
+	/**
+	 * @DRIVER_PLANE_COLOR_PIPELINE:
+	 *
+	 * Driver supports PLANE_COLOR_PIPELINE.
+	 */
+	DRIVER_PLANE_COLOR_PIPELINE	= BIT(10),
 
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
-- 
2.54.0

