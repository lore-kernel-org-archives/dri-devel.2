Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45241C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7190A10F288;
	Wed,  8 Jul 2026 19:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a5v/U7UH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5134E10F285;
 Wed,  8 Jul 2026 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ny+U+mefkv8ouZNyRUp6StkCsgjc7LiY8ovyAnF4X4Y=; b=a5v/U7UHvWrzQEgfgGCKR2FcWg
 pK5qysofPS3f83atF0Zr6zWEhfUAiFmhbVeWfv3tQxUtCYoMveeXG0NmWJVtNwutvY7LjcZjzPKik
 KvshK82QFZ40mzD1QbuaurrgHO9NFXClqC66IUK+WFp2kpNyVnCF3Qilq/nhq0QCYDXvbkhmMpgQY
 Txx8wL+BXE4npwqR6Frzq1J0QQvssutBJEiIBnR+MQGay31L3V3MhK8uIoI0MUIpSBULEDxWchfpr
 PvVO0N+CrHd5oOIfIKBdPHqpsZ47RDXSYJxXgA9plVsEd+X40IY3eUbXDuvIMkVN363hWUroVZC0k
 299r/HZA==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYCc-00BtrH-Hk; Wed, 08 Jul 2026 21:45:02 +0200
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
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 14/19] drm/drm_ioctl: guard
 DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
Date: Wed,  8 Jul 2026 21:37:29 +0200
Message-ID: <20260708194343.2578387-15-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
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

