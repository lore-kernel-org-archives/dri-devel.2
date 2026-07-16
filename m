Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FF0C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36C910F372;
	Thu, 16 Jul 2026 16:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MYSpywLK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519F910F371;
 Thu, 16 Jul 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=/5TUAQInGqaXeVxQvXE079kMYarVwTzwiA95N8KWQaE=; b=
 MYSpywLK8Z4qFZAlt8NDJLW0rtoEvS5ayf05vaW5BCbuLrTlifnvAm74444S0iiMWxSMZIdlIjQiB
 7w7seUXUSawbLGnY+6f3cMkLlPDsKa1bAZ13VtN9hxtYZpx/PL+M2Jn+unBR0+za/fFqFdpNbDOzn
 j8uDJUwPy2J2qhnWm14E9ejQP/OzElApyrcEXEnh9yUQOAd0eEYGHayrEfkxMyJA4394v/0yqQUs3
 nkGq7S44a05HCbfPLVnbK3777RuCxRtskntLrNLapmxGKUwZX5CihKij5ju2agNC0jq3q2Lycm/3C
 CPG+0Bc4ZjuOfFe9//X7UUIzJcA55aXl8Q==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObW-00G01i-BN; Thu, 16 Jul 2026 18:06:30 +0200
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
Subject: [RFC PATCH v2 10/20] drm/colorop: distinguish whether a colorop
 belongs to a plane or a CRTC
Date: Thu, 16 Jul 2026 18:03:07 +0200
Message-ID: <20260716160556.227556-11-mwen@igalia.com>
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

To correctly track states and color management changes.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 0ee44976031e..5cb860cb7da4 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1374,7 +1374,6 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		break;
 	}
 	case DRM_MODE_OBJECT_COLOROP: {
-		struct drm_plane_state *plane_state;
 		struct drm_colorop *colorop = obj_to_colorop(obj);
 		struct drm_colorop_state *colorop_state;
 		bool replaced = false;
@@ -1391,12 +1390,26 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		if (ret || !replaced)
 			break;
 
-		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
-		if (IS_ERR(plane_state)) {
-			ret = PTR_ERR(plane_state);
-			break;
+		if (colorop->plane) {
+			struct drm_plane_state *plane_state;
+
+			plane_state = drm_atomic_get_plane_state(state, colorop->plane);
+			if (IS_ERR(plane_state)) {
+				ret = PTR_ERR(plane_state);
+				break;
+			}
+			plane_state->color_mgmt_changed |= replaced;
+		} else if (colorop->crtc) {
+			struct drm_crtc_state *crtc_state;
+
+			crtc_state = drm_atomic_get_crtc_state(state, colorop->crtc);
+			if (IS_ERR(crtc_state)) {
+				ret = PTR_ERR(crtc_state);
+				break;
+			}
+			crtc_state->color_mgmt_changed |= replaced;
+
 		}
-		plane_state->color_mgmt_changed |= replaced;
 
 		break;
 	}
-- 
2.53.0

