Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D49606A681
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=quiGei8U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC6810F836;
	Tue, 24 Nov 2026 18:18:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB7510F081;
 Tue, 24 Nov 2026 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=b6K3+t6KOdL51KffwKMFowzojnZMXnYTCwh0Jc0Y0+I=;
 t=1795544309; x=2110904309; b=quiGei8U2LaNmTb8WXuwxSn7D5llokYCIz316Rqtxa0aYOT
 BR8bAQjBXumgHEPiMhoGm2U7QLrHkbZ6pYgfpttPBr4HqRno1n7fB+tflEysSnWqUCW0Rh+2G2my2
 a/n7XQcLzPqTdHncshrKn1uKsP1jCKqieGi/nD6vZWAniB64UGdhWkGUoZR+L4IvsgOxhZlBXeiOM
 WZOmPP+fI6hynUrTjfeV7TYjPEDFpXjV812Rr6FiHXqT7dA+UjJ2Q9cBT/9KSjisN4E4aVAy5l/z3
 czMXLG/8PUAHfqYSmVuCmupX1PekTBQLOAlDp+RDj1nJu45v9yEkvS8YX1BDHfaQ==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5v-00000003axM-2T4X; Tue, 24 Nov 2026 19:18:19 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 13/19] drm/drm_mode_object: hide deprecated CRTC color mgmt
 props if colorop is set
Date: Tue, 24 Nov 2026 19:03:30 +0100
Message-ID: <20261124181652.1333986-14-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop advertising CRTC color mgmt properties if post-blend colorop is
enabled. Follow the same approach done for plane COLOR_ENCODING and
COLOR_RANGE when pre-blend colorop is enabled.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
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

