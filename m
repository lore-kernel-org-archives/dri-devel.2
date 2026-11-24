Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B490606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mLfnNFfc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547D710F7D5;
	Tue, 24 Nov 2026 18:18:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D9D10F089;
 Tue, 24 Nov 2026 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=s3byCnHPVT1eU87gbtrEdDBkR4rkyakplss8SuneH9U=;
 t=1795544309; x=2110904309; b=mLfnNFfcljyaVBogNdOkyi3yN1hP41I7dRfLIxtwD2EKLDo
 vlTEh7zLsdfSQUKB2EmJFEYVEua3XCf56+0z/Z8cmfjwsOzlREnWCW4VESAnEMdCXubZ9Rqw84kq+
 Ngn59VATEzITJ8i45tqayNWahX9bWAAPgzEHXeVbRyEOZMivTMM+nyb50g8Bve4E98NMLYro9o0nO
 R7uMG7N393MyMztLDGBrijjWIghwo2VkbWC1FmwNoVORv3AwpiBlxq4nzXwtmkecpCLtlDW7pXnk1
 rLeLKYwoNFUa1qdYhirVpEk2oBTpgc2y7GK5ceyIpQ6DaKgI0vwAm/lMBl/DrKqw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5t-00000003axM-3RzG; Tue, 24 Nov 2026 19:18:17 +0100
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
Subject: [PATCH v3 12/19] drm/colorop: distinguish whether a colorop belongs
 to a plane or a CRTC
Date: Tue, 24 Nov 2026 19:03:29 +0100
Message-ID: <20261124181652.1333986-13-mwen@igalia.com>
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

To correctly track states and color management changes with the support
of both pre-blend and post-blend colorop.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 drivers/gpu/drm/drm_atomic_uapi.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 195aaed55e7a..0a597b9e8005 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1382,7 +1382,6 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		break;
 	}
 	case DRM_MODE_OBJECT_COLOROP: {
-		struct drm_plane_state *plane_state;
 		struct drm_colorop *colorop = obj_to_colorop(obj);
 		struct drm_colorop_state *colorop_state;
 		bool replaced = false;
@@ -1407,12 +1406,26 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
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

