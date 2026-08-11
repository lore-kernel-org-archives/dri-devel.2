Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA4C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4307010ED0F;
	Tue, 11 Aug 2026 17:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mjeSnO0k";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12A310ED0F;
 Tue, 11 Aug 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=aeVLgTc9lZD5on/N87viJZ3GrMBOhpVvY69l77soMIM=; b=
 mjeSnO0kwHJ1/45i3TDYpAjYfSybU8gEDrTFuzUUHx8l8igaIIwpQXOmZQGsV+jV5JWcNaGU9nmaf
 gArCchncM2YFzcWUTIVd4d8pM4pBT9HqUzNfbfoqD5gL1+t9Ql/RM4ouJiEe9JtSuEHoJzYCOkjKy
 4ffy+FzS5wcF0I+1Z2ut241/rorsExv5WxedxABSW6GKWLLk9Q9J4oda1F8TTgt9kRDoSpYyf15WB
 SgIMeg1Lma+WQeDYZrJMh6f1NkxRlvcMMb2RTucUnHrs2+f0Q50C4KGJgOm9VGiIpcnCCFcLfs7fx
 V8XKpd85T/NjGaBeuW6mJU03WwCvrwd8+A==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpzd-00HH9d-EX; Tue, 11 Aug 2026 19:10:25 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 05/11] drm/amd/display: only check colorops of an active
 color pipeline
Date: Tue, 11 Aug 2026 18:45:54 +0200
Message-ID: <20260811171011.184964-6-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811171011.184964-1-mwen@igalia.com>
References: <20260811171011.184964-1-mwen@igalia.com>
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

dm_plane_color_pipeline_active() iterates every colorop state in the
atomic commit, so colorops of a pipeline that userspace deactivated via
plane COLOR_PIPELINE are still taken into account, even though their
BYPASS property is irrelevant once the pipeline is off. Walk the color
pipeline of the plane state under evaluation instead, falling back to
the committed colorop state when a colorop isn't in the atomic commit.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d3a549f4df78 ("drm/amd/display: Use overlay cursor when color pipeline is active")
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---

v4:
- drop the ternary and add just a warn_on since both current callers
  iterate planes already in the atomic state. (John H.)
- explain the reason to use commited colorop (John H.)
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d0e612371c8f..384541b9ac9c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6551,9 +6551,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct dr
  * @use_old: if true, inspect the old colorop states; otherwise the new ones
  *
  * A color pipeline may be selected (color_pipeline != NULL) but still is
- * inactive if every colorop in the chain is bypassed.  Only return
- * true when at least one colorop has bypass == false, meaning the cursor
- * would be subjected to the transformation in native mode.
+ * inactive if every colorop in the chain is bypassed. Only return true when at
+ * least one colorop has bypass == false, meaning the cursor would be subjected
+ * to the transformation in native mode.
  *
  * Return: true if the pipeline modifies pixels, false otherwise.
  */
@@ -6561,18 +6561,33 @@ static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
 					   struct drm_plane *plane,
 					   bool use_old)
 {
+	struct drm_plane_state *plane_state = use_old ?
+					      drm_atomic_get_old_plane_state(state, plane) :
+					      drm_atomic_get_new_plane_state(state, plane);
 	struct drm_colorop *colorop;
-	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
-	int i;
+	struct drm_colorop_state *cstate;
 
-	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
-		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
+	if (drm_WARN_ON(plane->dev, !plane_state))
+		return false;
 
-		if (cstate->colorop->plane != plane)
-			continue;
+	/*
+	 * A commit may change only some colorops of a pipeline, and only those
+	 * have old and new states here. Telling whether the pipeline modifies
+	 * pixels requires every colorop of the selected pipeline, so fall back
+	 * to the committed state of the untouched ones; it's both their old
+	 * and new state.
+	 */
+	drm_for_each_colorop_in_pipeline(colorop, plane_state->color_pipeline) {
+		cstate = use_old ?
+			 drm_atomic_get_old_colorop_state(state, colorop) :
+			 drm_atomic_get_new_colorop_state(state, colorop);
+
+		if (!cstate)
+			cstate = colorop->state;
 		if (!cstate->bypass)
 			return true;
 	}
+
 	return false;
 }
 
-- 
2.53.0

