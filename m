Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAF606A689
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LLbK+A8Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365ED10F840;
	Tue, 24 Nov 2026 18:18:55 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EE010F831;
 Tue, 24 Nov 2026 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=/ft2dDX/+xR38f5cE9vzasAgOzKhBwXHmY6PWU4zeiU=;
 t=1795544319; x=2110904319; b=LLbK+A8ZR/xvpONpw8TUtKfQou/t7bpdVIg7b2bG+eN7r/E
 +S8yL0kwZIdJypWj8gtpR7HSQmng9whWuEph0k9VBxoLWzn5eCaF+TL6rDs/2Kd8ts7fmFHXd995A
 L86HbJ61ccZRutDIEmxQWGzFWCZXX1/oNgn0B/xqqpoDr0PBf28m6eFVdApdezJ1xNx9Ye48uhG/g
 YrR5N1uAoCbd4z+olAp84U3kJfCSFjuiNGDFPryUE52pbPFX8plI6ybsVL4FUBGZ+cIEp8cAlXKp2
 lRATvSDlDBT7TuZrqSjPxTMZHM9FWzFrK1F1Q94vs/9CMdaiZOD4B/uR5Unc4oZw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv66-00000003axM-3FQK; Tue, 24 Nov 2026 19:18:30 +0100
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
Subject: [PATCH v3 19/19] drm/amd/display: add support to post-blend 1D-LUT
 colorop
Date: Tue, 24 Nov 2026 19:03:36 +0100
Message-ID: <20261124181652.1333986-20-mwen@igalia.com>
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

Add Regamma LUT operation as 1D LUT colorop to AMD post-blend color
pipeline.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- use the committed state of the LUT colorop when it isn't part of the
  commit
- reject a colorop of unexpected type
- check for the LUT colorop and drop the redundant check from
  amdgpu_dm_crtc_set_colorop_properties()
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 35 +++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 18 ++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 97bdb8dbddb0..8eaf67a83c37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1297,6 +1297,8 @@ __set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
 	struct drm_atomic_commit *state = crtc_state->state;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct drm_device *dev = crtc_state->state->dev;
+	const struct drm_color_lut32 *regamma_lut;
+	u32 regamma_size;
 	int ret = 0;
 
 	tf->type = TF_TYPE_BYPASS;
@@ -1319,6 +1321,36 @@ __set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
 			return ret;
 	}
 
+	/* 1D LUT - Regamma LUT */
+	colorop = colorop->next;
+	if (!colorop || colorop->type != DRM_COLOROP_1D_LUT) {
+		drm_dbg(dev, "no Regamma LUT colorop found\n");
+		return -EINVAL;
+	}
+
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
+
+	if (!colorop_state->bypass) {
+		drm_dbg(dev, "Regamma LUT colorop with ID: %d\n", colorop->base.id);
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = default_tf;
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		regamma_lut = __extract_blob_lut32(colorop_state->data, &regamma_size);
+		regamma_size = regamma_lut != NULL ? regamma_size : 0;
+
+		/* Custom LUT size must be the same as supported size */
+		if (regamma_size == colorop->size) {
+			ret = __set_output_tf_32(tf, regamma_lut, regamma_size, false);
+			if (ret)
+				return ret;
+		} else {
+			drm_dbg(dev, "Regamma LUT size doesn't match blob size\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -1358,7 +1390,7 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 	if (ret)
 		return ret;
 
-	/* 1D Curve - REGAMMA TF */
+	/* 1D Curve & LUT - REGAMMA TF & LUT */
 	colorop = colorop->next;
 	if (!colorop) {
 		drm_dbg(dev, "no regamma TF colorop found\n");
@@ -1401,7 +1433,6 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
  * Returns:
  * 0 on success. Error code if validation fails.
  */
-
 int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 				    bool check_only)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index c97a087682c4..d909fc46755c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -346,6 +346,24 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 		drm_colorop_set_next_property(ops[i-1], ops[i]);
 
 		i++;
+
+		/* 1D LUT - REGAMMA LUT */
+		ops[i] = kzalloc_obj(*ops[0]);
+		if (!ops[i]) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		ret = drm_crtc_colorop_curve_1d_lut_init(dev, ops[i], crtc, &dm_colorop_funcs,
+							 MAX_COLOR_LUT_ENTRIES,
+							 DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
+							 DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		if (ret)
+			goto cleanup;
+
+		drm_colorop_set_next_property(ops[i-1], ops[i]);
+
+		i++;
 	}
 
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
-- 
2.53.0

