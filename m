Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606E3CD98C4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE71610E368;
	Tue,  9 Jun 2026 12:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Zsau6Q60";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA3910E2F9;
 Tue,  9 Jun 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/1ouOhs9zil1j2UFZmVX9yU6jOYsnVTUIT74lG75H9s=; b=Zsau6Q60jM/Q0y9TiVnGaHONN8
 5zLHO0mPpKAAeAnk/NyjuTlskLwew/pI+iuHhwBQUjy+nkXo0JRRwiSbt+GefYEE/c32vOY1qg1Tj
 jNihgQnc91+fl4grJKnTIGWFyRTRXmA0Uam+blfLITLGaLU/WmgNShC3mTQxXITcRvOMO+q+TDK89
 qQVRrNIPQ671XH4EhFc2g+B4D2aQj6nm3MEpPXvSDuwYvDbucQgCB0R0SMvZrFoykXTQTHCDEEZma
 Oqd1B4djT9KyVXTvqvWN5G8tHcE12kslNFuK1c2c5O8ClRSjroJGIA59yZgLuQ5PC/LrOlmiy+Em9
 EaeNZBaA==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWvK4-00EvWP-Nb; Tue, 09 Jun 2026 14:12:48 +0200
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
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/7] drm/amd/display: truly bypass plane colorop 3x4 matrix
 and hdr mult
Date: Tue,  9 Jun 2026 13:51:38 +0200
Message-ID: <20260609121230.1358786-5-mwen@igalia.com>
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

Latent issue as the driver is currently just skipping programming 3x4
matrix and hdr multiplier blocks on bypass. Reset to default values if
the bypass property is set true.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c    | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index fa6883ae4dfb..84ff136183ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1542,7 +1542,13 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
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
@@ -1581,9 +1587,13 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
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

