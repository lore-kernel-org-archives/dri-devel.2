Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E37606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lzjeIqu+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49AD10FDC2;
	Wed, 11 Nov 2026 16:09:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C769010FD62;
 Wed, 11 Nov 2026 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=IH1IrCh1AI5My9yEGrI2C/SDhX0IyneiDvEbL4p4nLg=;
 t=1794413342; x=2109773342; b=lzjeIqu+dRTexTYq9BVvjii6GF5RHnEDBqs1lAU8qREtYCG
 btb/VE+9vc/AYyy0IDtYEXzbVQdz6sXDrwVPxXXBl6Sbt6b52CymeYI3QkcDHefx4yl9FVDuMDzEU
 EmyB95EyyNus8mJU9GQ8IM8b7coahBuuhnw7e9dCS6R3xzfbiREwkqHmrrkt4b8i0LppOkD1sEyvV
 AEAaeZMYbIyfVOKrgham6mOmRg2Qc60fJ6vhE7RmmZJfpSkcDgwTO/hSUN9+tQurJziSwv87low/l
 Aj+71ACVJZxdHFqxmfHY7YyM81NHoOTCPJJoHqd8ZyW3HCzhZq5f/l4nxbfadmbQ==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsK-008u8Y-AZ; Wed, 11 Nov 2026 17:08:40 +0100
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
Subject: [PATCH v5 10/15] drm/amd/display: make shaper bypass mode cleaner
Date: Wed, 11 Nov 2026 17:05:23 +0100
Message-ID: <20261111160814.21326-11-mwen@igalia.com>
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

Start shaper transfer function setup in bypass mode, i.e. tf->type ==
TF_TYPE_BYPASS and let the helper checks set it to a different mode
according to userspace request. It's aligned with current blend setup.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 59dfae5a4a26..6455898e2da9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1766,10 +1766,12 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
 	const struct drm_color_lut32 *shaper_lut;
 	struct drm_device *dev = colorop->dev;
-	bool enabled = false;
 	u32 shaper_size;
 	int i = 0, ret = 0;
 
+	tf->type = TF_TYPE_BYPASS;
+	dc_plane_state->cm.flags.bits.shaper_enable = 0;
+
 	/* 1D Curve - SHAPER TF: find state */
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
@@ -1803,7 +1805,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 		ret = __set_output_tf(tf, 0, 0, false);
 		if (ret)
 			return ret;
-		enabled = true;
+		dc_plane_state->cm.flags.bits.shaper_enable = 1;
 	}
 
 	if (lut_state && !lut_state->bypass) {
@@ -1819,17 +1821,10 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 			ret = __set_output_tf_32(tf, shaper_lut, shaper_size, false);
 			if (ret)
 				return ret;
-			enabled = true;
+			dc_plane_state->cm.flags.bits.shaper_enable = 1;
 		}
 	}
 
-	if (!enabled) {
-		tf->type = TF_TYPE_BYPASS;
-		dc_plane_state->cm.flags.bits.shaper_enable = 0;
-	} else {
-		dc_plane_state->cm.flags.bits.shaper_enable = 1;
-	}
-
 	return 0;
 }
 
-- 
2.53.0

