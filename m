Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F16CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8FB10EE80;
	Wed,  6 May 2026 19:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="H8/W6XLa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E65510EE7E;
 Wed,  6 May 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ODId+Puv+ksLM5ZeP1J/HwczMH5qfWb0nljTGmHwaLI=; b=H8/W6XLa41JzkcGaEfRluJFnjb
 OIkSAtQy7cmTFwEbiLtuTmgvnto79gBBmF2Pb9kX6tkwtvNUdVgKccWC5DPV9yHpvpHpQEamDHavI
 r5b3e3PeoAMq+Abi4dPLYTePnpF4eSj4WWdL3BquLavdIk9pxIEXO5ylNr6kZQ+GELxIuh/QN9PkX
 YYFqn/evZSZmHnq0lfFKiq4k5AfRSnlx7/uvYPQM8qeH2mUxmwktEK5eH6LDfUxDHJigDugQKTd1L
 /3QQfT6xB3MOOjAEB1epeFcO/U5yf4906pxgbYNaS+caKcq8GS428qbCOCrRguQeoJwWV+lpLk6sx
 yhZnqexA==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhtg-0072dZ-Ho; Wed, 06 May 2026 21:27:04 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/6] drm/atomic: don't set colorop properties of inactive
 color pipelines
Date: Wed,  6 May 2026 16:23:48 -0300
Message-ID: <20260506192633.16066-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506192633.16066-1-mwen@igalia.com>
References: <20260506192633.16066-1-mwen@igalia.com>
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

Reject attempts to change property values of a colorop that is not
part of an active plane color pipeline.

Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 34 ++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df..bff8d58f8f12 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1275,15 +1275,38 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		break;
 	}
 	case DRM_MODE_OBJECT_COLOROP: {
-		struct drm_colorop *colorop = obj_to_colorop(obj);
-		struct drm_colorop_state *colorop_state;
+		struct drm_colorop *active_colorop, *colorop = obj_to_colorop(obj);
+		struct drm_colorop_state *colorop_state = NULL;
+		struct drm_plane_state *plane_state;
 
-		colorop_state = drm_atomic_get_colorop_state(state, colorop);
-		if (IS_ERR(colorop_state)) {
-			ret = PTR_ERR(colorop_state);
+		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
+		if (IS_ERR(plane_state)) {
+			ret = PTR_ERR(plane_state);
 			break;
 		}
 
+		/* Check if the colorop obj is part of an active color pipeline */
+		for (active_colorop = plane_state->color_pipeline;
+		     active_colorop;
+		     active_colorop = active_colorop->next) {
+			if (active_colorop == colorop) {
+				colorop_state = drm_atomic_get_colorop_state(state, colorop);
+				if (IS_ERR(colorop_state)) {
+					ret = PTR_ERR(colorop_state);
+					goto err;
+				}
+				break;
+			}
+		}
+
+		if (!colorop_state) {
+			drm_dbg_atomic(prop->dev,
+				       "[COLOROP:%d:%d] not part of the active pipeline\n",
+					obj->id, colorop->type);
+			ret = -EINVAL;
+			goto err;
+		}
+
 		ret = drm_atomic_colorop_set_property(colorop, colorop_state,
 						      file_priv, prop, prop_value);
 		break;
@@ -1294,6 +1317,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 		break;
 	}
 
+err:
 	drm_property_change_valid_put(prop, ref);
 	return ret;
 }
-- 
2.53.0

