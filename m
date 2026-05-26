Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C2CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CE910E528;
	Tue, 26 May 2026 14:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SohMtHi2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8EA10E4EB;
 Tue, 26 May 2026 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oqZyzcWW+SVENqYEdzT/g6oNyc+nRa4NJGuS3Z6L+QM=; b=SohMtHi22jGXx7lJ6XEw7WDWry
 i6OR/KN3Ej435caRowe9iN5Exu9429K1L8LuEanuIBm411oCWkKckaEw8xEC49gMwzBtsenADFQPk
 tNOFLdglCSTXw7QTbyem5iMc+7GWo3428/f9tsePzkrMS+oWZem1a11/5n2gPP+HmKIvUqbiTl2lM
 Wgqo6mX638AK31X/DjAMGztHnSOmcuEjzBUd5IqULTdmaIxTvK1VQ+FSU3y5xfZfX9kuUx8XV/D1j
 tbaLJPpj2fusTsnWFFwCSmr4/vyV6MPiGrCBni/m+nmsuL7SopbrDWdK9zgxzPTlAmGiVF6g0vjBX
 GkP45Tng==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wRsn3-008TUc-IP; Tue, 26 May 2026 16:29:53 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 John Harrison <John.Harrison@Igalia.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/atomic: reject colorop update from inactive color
 pipeline
Date: Tue, 26 May 2026 16:17:10 +0200
Message-ID: <20260526142940.504911-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526142940.504911-1-mwen@igalia.com>
References: <20260526142940.504911-1-mwen@igalia.com>
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

Only allow updates on colorops that are part of an active pipeline, i.e.
check if a colorop belongs to the color pipeline of a plane in its
current, new or old state. If not, reject the state change of this
inactive colorop. Performing this check later in drm_atomic_check_only()
to remove the ordering dependency that would exist if done at the time
of colorop property setting. Userspace is allowed to change colorops of
an active color pipeline, or when activating or deactivating its
pipeline in the same commit. However, changes in inactive color pipeline
is not allowed.

Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 4fb3a23e862a..a0549435954b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -865,6 +865,54 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
 	return 0;
 }
 
+/**
+ * drm_atomic_colorop_check - check new colorop state
+ * @new_colorop_state: new colorop state to check
+ *
+ * Ensure that the colorop in @new_colorop_state belongs to an active color
+ * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
+ * property of current, old or new plane state.
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
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+
+	/* No changes in the plane state. Check current-committed plane state */
+	if (!new_plane_state) {
+		for (colorop = plane->state->color_pipeline; colorop; colorop = colorop->next)
+			if (colorop == new_colorop_state->colorop)
+				return 0;
+		return -EINVAL;
+	}
+
+	if (WARN_ON(!old_plane_state)) return -EINVAL;
+
+	/* Check if the colorop is active in the new plane state */
+	for (colorop = new_plane_state->color_pipeline; colorop; colorop = colorop->next)
+		if (colorop == new_colorop_state->colorop)
+			return 0;
+
+	/* Same color pipeline as new; no point walking old. Colorop isn't active */
+	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
+		return -EINVAL;
+
+	/* Check if the colorop was active in the old plane state */
+	for (colorop = old_plane_state->color_pipeline; colorop; colorop = colorop->next)
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
@@ -1714,6 +1762,8 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc_state *new_crtc_state;
@@ -1730,6 +1780,15 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
 			requested_crtc |= drm_crtc_mask(crtc);
 	}
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		ret = drm_atomic_colorop_check(new_colorop_state);
+		if (ret) {
+			drm_dbg_atomic(dev, "[COLOROP:%d:%d] is not part of an active color pipeline.\n",
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

