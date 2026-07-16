Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36372C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687F910F37F;
	Thu, 16 Jul 2026 16:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lCUOat6+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3B410F36B;
 Thu, 16 Jul 2026 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=b3l281+Jm1AKS6Qg9eGQ12J1cB0+K8ejD+iPwx5sAz4=; b=lCUOat6+Ktl7qQQnEsbfv/6LcV
 lm00LVzEWbLZg6TBMubE1miZe6KMeeUXKOVQyUFO/nCZr1DoEr6W+faMHmCwXiLKqWo9Z0wBpaOhT
 ym5Dm4PUXvxQTlLdzZ7HQEmaT2c4uwwcIxY8+wy3LSr5ldSCLv1UdUVgaTp+dYTzEmHVTksIGvMdm
 Vj07v3oWbCFsZOTpsazNeq1Lb1AVkzuRhpx4H74obv7j1JNbZd8uXHAzbFPJRQ1UOSLQVoTE5wSqH
 nVF1kcZ7p7zMN3r6a/2Gi7tnRVhUOOHeu4PR0wG3zpm7O9cSO8VrR4XP14Xpm5AGsqCnNnR8UTuX+
 Y5BTFnOg==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObd-00G01i-5H; Thu, 16 Jul 2026 18:06:37 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 11/20] drm/crtc: Track crtc color pipeline client cap
 in drm_crtc_state
Date: Thu, 16 Jul 2026 18:03:08 +0200
Message-ID: <20260716160556.227556-12-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Some drivers, like VKMS, only have access to the drm_crtc_state but not
the drm_atomic_state during composition of the output framebuffer. Store
the state of the CRTC (post-blend) color pipeline client cap in the
drm_crtc_state so those drivers can decide whether to look at the color
pipeline or the legacy properties for the color management settings to
apply.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c | 1 +
 include/drm/drm_crtc.h       | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 76c7665b3c4c..8bb0e5d124f8 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -468,6 +468,7 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
 	state->crtcs[index].new_state = crtc_state;
 	state->crtcs[index].ptr = crtc;
 	crtc_state->state = state;
+	crtc_state->color_pipeline_enabled = state->crtc_color_pipeline;
 
 	drm_dbg_atomic(state->dev, "Added [CRTC:%d:%s] %p state to %p\n",
 		       crtc->base.id, crtc->name, crtc_state, state);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 5852b506c614..bd36acf902e8 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -282,6 +282,14 @@ struct drm_crtc_state {
 	 */
 	struct drm_colorop *color_pipeline;
 
+	/**
+	 * @color_pipeline_enabled:
+	 *
+	 * Whether color management should be done based on the &color_pipeline
+	 * or the legacy color properties (&ctm, &gamma_lut and &degamma_lut).
+	 */
+	bool color_pipeline_enabled;
+
 	/**
 	 * @background_color:
 	 *
-- 
2.53.0

