Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AC606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LY5XXrlS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF09610FDA2;
	Wed, 11 Nov 2026 16:09:03 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1235C10FD5D;
 Wed, 11 Nov 2026 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=f/cZaduwWh9lNBTtL3zVDM/TEsIs0K5OI4ynG53kQso=;
 t=1794413335; x=2109773335; b=LY5XXrlSwSeZ4rP4qfQSgiVexpEuDhoJ0cW7KuyY6ifQvRL
 6asGdb+dycZ/Hw1tSMxpy/qDkPloF4dQoSJCZouHwYm/m8XWUVh+UTcXYPX97pMcxGplbuFMXDosR
 aCE/J1N5DcKjz/vZsd5npgiC8qoP2okNcpdbXI0KmJDLmHIRvLQU8xK+/u4ku2qdmHNDLrXuQCp+7
 TGUwZ05H6agP6lb5T4KQ/bg2/fsrqOU7MI0Flf+dwuHZsTFRkEktqt0vCnAHTau85qnPCwEViaM+b
 nanUsseZ/aB/Gn4CVPbxEkLGNcG9igNGc8znchnJZ1SBpSb2hR2+nw8bl8X+tw6Q==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsE-008u8Y-SW; Wed, 11 Nov 2026 17:08:34 +0100
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
 John Harrison <John.Harrison@igalia.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 05/15] drm/amd/display: only check colorops of an active
 color pipeline
Date: Wed, 11 Nov 2026 17:05:18 +0100
Message-ID: <20261111160814.21326-6-mwen@igalia.com>
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

dm_plane_color_pipeline_active() iterates every colorop state in the
atomic commit, so colorops of a pipeline that userspace deactivated via
plane COLOR_PIPELINE are still taken into account, even though their
BYPASS property is irrelevant once the pipeline is off. Walk the color
pipeline of the plane state under evaluation instead, falling back to
the committed colorop state when a colorop isn't in the atomic commit.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d3a549f4df78 ("drm/amd/display: Use overlay cursor when color pipeline is active")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 8204ad4018e6..a026610e81d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -236,14 +236,28 @@ STATIC_IFN_KUNIT bool dm_plane_color_pipeline_active(struct drm_atomic_commit *s
 						     bool use_old)
 {
 	struct drm_colorop *colorop;
-	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
-	int i;
+	struct drm_colorop_state *cstate;
+	struct drm_plane_state *plane_state = use_old ?
+					      drm_atomic_get_old_plane_state(state, plane) :
+					      drm_atomic_get_new_plane_state(state, plane);
 
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
-- 
2.53.0

