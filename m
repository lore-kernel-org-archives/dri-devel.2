Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08050606A685
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=U1zuf5Df
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EF410F831;
	Tue, 24 Nov 2026 18:18:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FC210F7E3;
 Tue, 24 Nov 2026 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=D7Rnf/E6D1AzoY9q5PROajjWjX7iAQ5f2Yr8aHcnDhc=;
 t=1795544316; x=2110904316; b=U1zuf5DfJnPwoIrxSxokPm35fXcIrn4+7PC5pQhx7kPamuh
 CW1QsChIuGMs8Kp8Wn++3KjuRqfFXVZf/lM+M1m+9xBHIt03akCltFVd/n2v6YoXIQm8P/TYN6XwM
 wSFNCE/p8hf+I3Pj2eLxeo4ljhK1CaiS2Fbkx4kMpS3PZCo1Z/4rjYp202jw4XCwy5SYl04cdyld5
 NOFiSuKjOHs0ma8/qmjF51pHeU8+SoKH8fUHOy8K2Y6hsx61IvDJOXNuhUpEArhrCHRzZFVk+c6C2
 p+aYSk+gejwwbyZa9EUVeTUi+rmu8OFCtmuN5bBmeslQHpwTIZqP5ddJkgaWvbWA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5z-00000003axM-0egP; Tue, 24 Nov 2026 19:18:23 +0100
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
Subject: [PATCH v3 15/19] drm/drm_ioctl: guard
 DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
Date: Tue, 24 Nov 2026 19:03:32 +0100
Message-ID: <20261124181652.1333986-16-mwen@igalia.com>
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

If the driver doesn't support post-blend colorop, refuse attempts from
userspace to set it. Same approach is taken for pre-blend colorop since
commit ac7c6b4308c5 ("drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE").

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- refuse the cap when no CRTC has a color pipeline as the plane guard
  does
- drop the stale DRM_CAP_CRTC_COLOR_PIPELINE requirement from the cap
  documentation
---
 drivers/gpu/drm/drm_ioctl.c | 15 ++++++++++++++-
 include/uapi/drm/drm.h      |  3 ---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 3e57453ef258..9325202f8cbd 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -392,13 +392,26 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		file_priv->plane_color_pipeline = req->value;
 		break;
 	}
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
+		if (!has_crtc_with_color_pipeline)
+			return -EOPNOTSUPP;
+
 		file_priv->crtc_color_pipeline = req->value;
 		break;
+	}
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 08bd616774a4..c0971de2c0a3 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -920,9 +920,6 @@ struct drm_get_cap {
  * the hidden model to default values.
  *
  * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
- *
- * This client cap can only be set if the driver sets the corresponding driver
- * cap &DRM_CAP_CRTC_COLOR_PIPELINE.
  */
 #define DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE	8
 
-- 
2.53.0

