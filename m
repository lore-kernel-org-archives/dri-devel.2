Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D148C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBC010ED2A;
	Tue, 11 Aug 2026 17:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SSQd8Cd3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8373A10ED06;
 Tue, 11 Aug 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=TKOOjCLLZWBgmHVgLpQgEUNXD3dMcbd5GmU0BxUALeo=; b=
 SSQd8Cd3EA//Ea9yfyu4mzraFFzSkeKlJk90b11Jm79ajUSxtDLx1fnFtKyNcS+dKZsE9X5WVSIeR
 HHAyxIL0P8fWMaW7NOqIGlGHveE2+MABw1fym6sHpfENsc7Dp2hsX8B1zG6HHvfGvpFWUGh0+knMM
 5iasnHlWAZlr1x/QAPlJHB/ao5QpYIjJelbqgb8EWWMv4gQoB4nm4RD+y0KzFjApoqYtpJl28TpzS
 XwWggH1Ahy05hKDQPC7Lw0Bpawm8e/HHFZGx4RJvHVh8QDfdchX8fjnBm5kUfLELIrf5/ekf4uFVz
 KKjbzLiLD1urXZWAIZrWjye9ca0AReLtlA==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpzl-00HH9d-Am; Tue, 11 Aug 2026 19:10:33 +0200
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
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 11/11] drm/amd/display: distinguish colorop setup error
 from no colorop support
Date: Tue, 11 Aug 2026 18:46:00 +0200
Message-ID: <20260811171011.184964-12-mwen@igalia.com>
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

amdgpu_dm_plane_set_colorop_properties() returns -EINVAL both when the
plane has no color pipeline selected, where falling back to the legacy
color properties is correct, and when programming an active pipeline
fails, so the caller treats every failure as the former and silently
programs the plane from the legacy properties, leaving it in a mixed
state and userspace with no error. Check if plane_state->color_pipeline
is set instead, so the legacy path is only taken when no pipeline is set
and any other failure is propagated out of the atomic check.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index f6a2af5d2e96..f2731989499c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1906,10 +1906,10 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
-	/* 1D Curve - DEGAM TF */
-	if (!colorop)
+	if (drm_WARN_ON(dev, !colorop))
 		return -EINVAL;
 
+	/* 1D Curve - DEGAM TF */
 	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
@@ -2080,8 +2080,8 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
 	}
 
-	if (!amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state))
-		return 0;
+	if (plane_state->color_pipeline)
+		return amdgpu_dm_plane_set_colorop_properties(plane_state, dc_plane_state);
 
 	return amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
 }
-- 
2.53.0

