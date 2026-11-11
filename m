Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DF606A337
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=so4YXkvF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862EB10FDDF;
	Wed, 11 Nov 2026 16:09:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12BB10FD40;
 Wed, 11 Nov 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=/y5qYFZc99vTFQFHCcGT764DjvoopXBmEK09vTZo0IY=;
 t=1794413340; x=2109773340; b=so4YXkvFWmWNf2gV40cp06gV/k3bRlaDadkLRoKv6ep60Fn
 MQ8/cu+TicuK/ngM5IR1l2rpEYiBk186JoYwrlCAvV0R5Inyh+zHWBSELiw17dZEXYnM6RJ1o2+gz
 O2Q9xTlpmrYwoy0g1N9fWDyksBXe8TSoCFf7Q1Sdp8Zp2jL0Qs+HzcrR6AAeaaC3/IgXr/jTwNslN
 xMn9IhZbgo3i6xGhN1PMhvMLydPyTq46dHCWCGTUImz1dAzgHsl6Wa4QL48smGpuvghdfo1HwJd/7
 hR+IKoUkJfjxF9cudgwi+HZLqlYUWPv+uPICBy2CLSfuByzBPEUCYHaZkckUcayg==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsJ-008u8Y-9m; Wed, 11 Nov 2026 17:08:39 +0100
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
Subject: [PATCH v5 09/15] drm/amd/display: truly bypass plane colorop 3x4
 matrix and hdr mult
Date: Wed, 11 Nov 2026 17:05:22 +0100
Message-ID: <20261111160814.21326-10-mwen@igalia.com>
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

Latent issue as the driver is currently just skipping programming 3x4
matrix and hdr multiplier blocks on bypass. Reset to default values if
the bypass property is set true.

Fixes: 16e0f785b87f ("drm/amd/display: add 3x4 matrix colorop")
Fixes: de0b0eb2e045 ("drm/amd/display: add multiplier colorop")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ebb05a20aa0c..59dfae5a4a26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1693,7 +1693,13 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 		}
 	}
 
-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_CTM_3X4) {
+	if (colorop_state && colorop->type == DRM_COLOROP_CTM_3X4) {
+		if (colorop_state->bypass) {
+			dc_plane_state->gamut_remap_matrix.enable_remap = false;
+			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
+			return 0;
+		}
+
 		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
 		blob = colorop_state->data;
 		if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
@@ -1733,9 +1739,13 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 		}
 	}
 
-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_MULTIPLIER) {
-		drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
-		dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
+	if (colorop_state && colorop->type == DRM_COLOROP_MULTIPLIER) {
+		if (colorop_state->bypass) {
+			dc_plane_state->hdr_mult = dc_fixpt_one;
+		} else {
+			drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
+			dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
+		}
 	}
 
 	return 0;
-- 
2.53.0

