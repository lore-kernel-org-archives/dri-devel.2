Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A85CD98C9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DC010E36A;
	Tue,  9 Jun 2026 12:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IQJolVdc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ED710E2F6;
 Tue,  9 Jun 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UznVIFEYKC0IyDpqtfOgBPAG+0I11/IKmEt3nq+ive4=; b=IQJolVdcFmWbS7Mc/0yr9Whp9q
 qhhVeeTtgUyJR9r1u4OY18j4EUjwBSerJbSUjCUbWeXzit1MPjngl5ztNi3FuqriRIibcVP1GulJB
 PV2ktWUoWukeI6egG4cVSn9hm9RbRV+WvvD/0eAMiWmx4JrFdqc7K78+gJEywkLvA7sb0hsRYP+x/
 lKbdubTmRf5QCbHD75pGxGjs4qfABvbw9d2mL+lHhKj2x5qa+w6CGj6KcBvcHZQVZXzt+hqYxWLHG
 jPtrYBfZxgbxVzxWJeDrc0IUOlTzKa/zcAS6+LlyDrazI8dFHpR2gnUPhwxiQyyNhMy3Hc/DBGzh0
 zp7e8low==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWvK2-00EvWP-P9; Tue, 09 Jun 2026 14:12:46 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/7] drm/amd/display: don't check colorop status if its in
 an inactive pipeline
Date: Tue,  9 Jun 2026 13:51:37 +0200
Message-ID: <20260609121230.1358786-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609121230.1358786-1-mwen@igalia.com>
References: <20260609121230.1358786-1-mwen@igalia.com>
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

If colorop BYPASS property is true, but the colorop isn't part of an
active/transient active color pipeline, this colorop status should not
be taken into account when checking if a plane color pipeline is
actually active. For example, if the userspace doesn't explicitly set a
colorop obj to bypass but deactivates its color pipeline by setting
plane COLOR_PIPELINE to bypass, it means that colorop is inactive
regardless of its BYPASS property status.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d3a549f4df78 ("drm/amd/display: Use overlay cursor when color pipeline is active")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ba7f98a87808..2edec3e1b838 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12590,9 +12590,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct dr
  * @use_old: if true, inspect the old colorop states; otherwise the new ones
  *
  * A color pipeline may be selected (color_pipeline != NULL) but still is
- * inactive if every colorop in the chain is bypassed.  Only return
- * true when at least one colorop has bypass == false, meaning the cursor
- * would be subjected to the transformation in native mode.
+ * inactive if every colorop in the chain is bypassed. Only return true when at
+ * least one active colorop has bypass == false, meaning the cursor would be
+ * subjected to the transformation in native mode.
  *
  * Return: true if the pipeline modifies pixels, false otherwise.
  */
@@ -12600,18 +12600,29 @@ static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
 					   struct drm_plane *plane,
 					   bool use_old)
 {
-	struct drm_colorop *colorop;
-	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
-	int i;
+	struct drm_plane_state *plane_state = use_old ?
+					      drm_atomic_get_old_plane_state(state, plane) :
+					      drm_atomic_get_new_plane_state(state, plane);
+	struct drm_colorop *colorop, *pipeline;
+	struct drm_colorop_state *cstate;
 
-	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
-		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
+	pipeline = plane_state ? plane_state->color_pipeline :
+				 plane->state->color_pipeline;
 
-		if (cstate->colorop->plane != plane)
-			continue;
+	if (!pipeline)
+		return false;
+
+	drm_for_each_colorop_in_pipeline(colorop, pipeline) {
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

