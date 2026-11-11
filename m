Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D76606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Yof3OXJ7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCFB10FDC9;
	Wed, 11 Nov 2026 16:09:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E39410FD69;
 Wed, 11 Nov 2026 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=EF6YJlWcMIKeRWjHSiUzXMiAlNQMPhIfJbX3+58lWy4=;
 t=1794413336; x=2109773336; b=Yof3OXJ7zQscAtjegjRPscOLZSlQ/HS5AaKcWP0st/Qveod
 s5p2J/jQKbyQuP2E8z68Q0KWD150k/vpPdqZSCa06Rw2rzHUwbmWZbfDLqeZ2py+CHH8jMZuHPpXI
 wZK3pVdZ3rUHCjTviddIx/+lMXxO9xXD1PCyYq8/A2OelGf+d3Kn5g+QvQx3X06CvTwsUGn+r4IHi
 KZjW0uucN/o2aAFGbMo1HeSUF9AFiD5BtJcEfZwgc/Zq3Xc5wL5ZY0sfht21dYGtifgVpbH/FJHU5
 0LWDifI3/ZkQ85Phid2NEwXQb2KUO9HQS41iLA6g/jAudWqrofR1zowLB6ppg9BQ==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsF-008u8Y-Uj; Wed, 11 Nov 2026 17:08:36 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>
Subject: [PATCH v5 06/15] drm/atomic: reject colorop update from inactive
 color pipeline
Date: Wed, 11 Nov 2026 17:05:19 +0100
Message-ID: <20261111160814.21326-7-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A colorop can only be changed while it is part of an active color
pipeline, or in the same commit that activates or deactivates that
pipeline. Enforce this contract by checking that the colorop belongs to
the color pipeline of a plane in its current, new or old state, and
rejecting the state change otherwise. Do the check in
drm_atomic_check_only() rather than when the colorop property is set, so
it doesn't depend on the order userspace sets properties within a
commit.

Link: https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 2e82c06166be..36c9550c2749 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -986,6 +986,71 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
 	return 0;
 }
 
+/*
+ * drm_atomic_colorop_check - check new colorop state
+ * @new_colorop_state: new colorop state to check
+ *
+ * Ensure that the colorop in @new_colorop_state belongs to an active color
+ * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
+ * property of current, old or new plane state.
+ *
+ * Userspace is allowed to finalize colorop's settings in the same commit that
+ * deactivates its pipeline, and the changes should persist for when that
+ * pipeline is reactivated later. So changes to colorop in the old plane
+ * state's pipeline are accepted even though it won't drive hardware updates.
+ *
+ * Skip this check for duplicated state, since all colorop states must persist
+ * in suspend/resume regardless of whether it belongs to an active color
+ * pipeline or not.
+ *
+ * Returns: 0 on success, -EINVAL otherwise.
+ */
+static int drm_atomic_colorop_check(const struct drm_colorop_state *new_colorop_state)
+{
+	struct drm_atomic_commit *state = new_colorop_state->state;
+	struct drm_plane *plane = new_colorop_state->colorop->plane;
+	struct drm_plane_state *new_plane_state, *old_plane_state;
+	struct drm_colorop *colorop;
+
+	if (state->duplicated)
+		return 0;
+
+	/* Not a plane colorop */
+	if (!plane)
+		return 0;
+
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+
+	/* No changes in the plane state. Check current-committed plane state */
+	if (!new_plane_state) {
+		drm_for_each_colorop_in_pipeline(colorop, plane->state->color_pipeline)
+			if (colorop == new_colorop_state->colorop)
+				return 0;
+		return -EINVAL;
+	}
+
+	if (WARN_ON(!old_plane_state))
+		return -EINVAL;
+
+	/* Check if the colorop is active in the new plane state */
+	drm_for_each_colorop_in_pipeline(colorop, new_plane_state->color_pipeline)
+		if (colorop == new_colorop_state->colorop)
+			return 0;
+
+	/* Same color pipeline as new; no point walking old. Colorop isn't active */
+	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
+		return -EINVAL;
+
+	/* Check if the colorop was active in the old plane state */
+	drm_for_each_colorop_in_pipeline(colorop, old_plane_state->color_pipeline)
+		if (colorop == new_colorop_state->colorop)
+			return 0;
+
+	/* Colorop is not part of an active color pipeline. */
+	return -EINVAL;
+}
+
 static void drm_atomic_colorop_print_state(struct drm_printer *p,
 					   const struct drm_colorop_state *state)
 {
@@ -1869,6 +1934,8 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc_state *new_crtc_state;
@@ -1885,6 +1952,15 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 			requested_crtc |= drm_crtc_mask(crtc);
 	}
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		ret = drm_atomic_colorop_check(new_colorop_state);
+		if (ret) {
+			drm_dbg_atomic(dev, "[COLOROP:%d:%d] isn't in an active color pipeline.\n",
+				       colorop->base.id, colorop->type);
+			return ret;
+		}
+	}
+
 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
 		ret = drm_atomic_plane_check(old_plane_state, new_plane_state);
 		if (ret) {
-- 
2.53.0

