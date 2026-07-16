Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0229FC44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D24010F382;
	Thu, 16 Jul 2026 16:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EyG762Jl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C4B10F378;
 Thu, 16 Jul 2026 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=F3sxHX1YqXKXf9pC1x5/2yVuik+umq5HGY7of5iTB1Y=; b=
 EyG762Jle1Z04+dVaYoi5YEVwXg+JNjItq96/dhH3x5obj4XP+12aapxQkXAm+VdS98jC6C6ShrqA
 GspZy83jfJX4Ve7b0lnFPB4pn5yeT/BBih37LF4TM5iXxOm78OhoykxRru148F/Ja00e2YMdYWCwz
 gO0FYQn7I+wm0KAHO6DE5++gBMxAr9VuKatNtg7ptImM0b/luDCq3w2Xtxzfk8nIYh+3gp0IPnP8M
 jET3tGpPwqozjwkDDaDeDDO61egnqLKSmN/oIjJUzxaorXFKaAQe6n955ydsS3O61ei4VsQacBHA6
 yeL5FVDYAqob/Pou9axTajQ2lTmeOYhRDg==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObp-00G01i-BJ; Thu, 16 Jul 2026 18:06:49 +0200
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
Subject: [RFC PATCH v2 14/20] drm/drm_mode_object: hide deprecated CRTC color
 mgmt props if colorop is set
Date: Thu, 16 Jul 2026 18:03:11 +0200
Message-ID: <20260716160556.227556-15-mwen@igalia.com>
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

