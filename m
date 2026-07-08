Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E56C44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C918710F283;
	Wed,  8 Jul 2026 19:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BiyZe7c9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8063510F27B;
 Wed,  8 Jul 2026 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F3sxHX1YqXKXf9pC1x5/2yVuik+umq5HGY7of5iTB1Y=; b=BiyZe7c9McaxBiKxonzlgWTyCi
 ilmz+ePW2V9sU+ViIXZoOWgCx/cE28LafATzWLehrvVlPv0jKyszhzHIvqnQRnvnr8gB26oFYjWAP
 i4jSTBe1jz17sZmLgpLsko+ua7lnoUdRfTk37a+ktVn5aE3QPZvhyEvCaZBaDr3FsRP4GZlEumy9j
 CSN7tP2D9K70VHTMBUh7e0Q1egDBRKpnmP2KhJpJfHaomOXS8M8+cJAI1Pl9LUCGbaZJKd315gz4i
 41FrpQTx13vjDE05N4CovWwqpZrWAO9nIOnuWA0SizcZx5EkVql50NHA4brRgjE+8M3r6N2qi/PF8
 R0jG/kLA==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYCQ-00BtrH-Va; Wed, 08 Jul 2026 21:44:51 +0200
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
Subject: [RFC PATCH 13/19] drm/drm_mode_object: hide deprecated CRTC color
 mgmt props if colorop is set
Date: Wed,  8 Jul 2026 21:37:28 +0200
Message-ID: <20260708194343.2578387-14-mwen@igalia.com>
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

Stop advertise CRTC color mgmt properties if post-blend colorop is
enabled. Follow the same approach done for plane COLOR_ENCODING and
COLOR_RANGE when pre-blend colorop is enabled.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_mode_object.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index e9f317126035..3b7c94957bf0 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -442,10 +442,19 @@ int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				continue;
 		}
 
-		if (!crtc_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
+		if (obj->type == DRM_MODE_OBJECT_CRTC) {
 			struct drm_crtc *crtc = obj_to_crtc(obj);
+			struct drm_mode_config *config = &crtc->dev->mode_config;
 
-			if (prop == crtc->color_pipeline_property)
+			if (!crtc_color_pipeline && prop == crtc->color_pipeline_property)
+				continue;
+
+			if (crtc_color_pipeline &&
+			    (prop == config->degamma_lut_property ||
+			     prop == config->degamma_lut_size_property ||
+			     prop == config->ctm_property ||
+			     prop == config->gamma_lut_property ||
+			     prop == config->gamma_lut_size_property))
 				continue;
 		}
 
-- 
2.53.0

