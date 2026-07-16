Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD973C44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0592010F388;
	Thu, 16 Jul 2026 16:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bWaZ8jpO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D468710F37B;
 Thu, 16 Jul 2026 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=ny+U+mefkv8ouZNyRUp6StkCsgjc7LiY8ovyAnF4X4Y=; b=
 bWaZ8jpOUqbFhEDjggWJYQ70mmnDR2r8jXk6iI4tVC90+ytgTJZkpksQr8NVb5H8o7mJM+tAiCnfR
 1ScQGz0T5hSwOQY/xVl1MCsb38vHmb94LhFe2M1izj7B77rBQNlgRxCYVgSrsAtG8r1u/6k9OmuGs
 mWNVXx6MdD3M6sTQx8g6ZUwe6YKNd0Q8zZ+Uvz45vvelOobLp97Ml5vh65bW/BiiJsjoeWrGTaDUv
 sO4AcdI3t+3o7ptA5PvuoFjNYOWHv/np+HWDzCOCgtYlSfrbNVrfQeLnyTlzyGLW1r0mHgoT3fRNk
 p2DTUeOqlm2iFFLBU/mJIWS6OUY61z9XHA==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObr-00G01i-A0; Thu, 16 Jul 2026 18:06:51 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 15/20] drm/drm_ioctl: guard
 DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
Date: Thu, 16 Jul 2026 18:03:12 +0200
Message-ID: <20260716160556.227556-16-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
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

If the driver doesn't support post-blend colorop, refuse attempts from
usersapce to set it. Same approach is taken for pre-blend colorop.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_ioctl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ae374733e154..82d4f1bfc557 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -380,13 +380,26 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
-	case DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE:
+	case DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE: {
+		struct drm_crtc *crtc;
+		bool has_crtc_with_color_pipeline = false;
+
 		if (!file_priv->atomic)
 			return -EINVAL;
 		if (req->value > 1)
 			return -EINVAL;
+		drm_for_each_crtc(crtc, dev) {
+			if (crtc->color_pipeline_property) {
+				has_crtc_with_color_pipeline = true;
+				break;
+			}
+		}
+		if (req->value == 1 && !has_crtc_with_color_pipeline)
+			return -EOPNOTSUPP;
+
 		file_priv->crtc_color_pipeline = req->value;
 		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

