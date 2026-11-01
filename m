Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18517606A32D
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=BAn452or
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4571C10EA34;
	Sun,  1 Nov 2026 12:30:09 +0000 (UTC)
X-Greylist: delayed 9118 seconds by postgrey-1.36 at gabe;
 Sun, 01 Nov 2026 12:30:02 UTC
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1DB10EA34
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softbase.tech;
 s=protonmail3; t=1793536201; x=1793795401;
 bh=srVkZLRUEsh8lNsFW8ZIvMUhr7jAKJQIa5Ah85ra2m0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BAn452orHYLqFv4T18JvTB8a/SaBxAvjg6X8JnaY+tm9r0tWAzcHf3dsQrwlex8++
 PBsZ5Q2BimfCnl+6iRbbGMxrMNoAQoEURsFf/jMteqS0ISUiUZcp66wTSCg9+A9/KY
 C0t4eXevYDJ1YLw2p9Hc21KS/ZqJWUS89VvZtfLRLI4Q4XeNrwJQ6AZeVpuGfDOk4v
 bFnZz8GHw03oyjQBpQF6vAbsZkZI3ZGv8ZYT6X7jkXVq/ryYxnskwCZ0cNQHSIys2X
 xWHu2qIhShh7wlULTx7H3rKXUf4xx/G414P7sYmb1d/6VspbEjyb9oooqfkRxLB8MP
 6XwyebhP9o3ug==
X-Pm-Submission-Id: 4jHZ0l0mRLz2Sd2x
From: "Beat M. Liechti" <beat@softbase.tech>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Federico Amedeo Izzo <federico@izzo.pro>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Beat M. Liechti" <beat@softbase.tech>
Subject: [PATCH v2 2/2] drm/msm: drop the CTM modeset hack from
 msm_atomic_check()
Date: Sun,  1 Nov 2026 13:26:58 +0100
Message-ID: <20261101122943.8155-3-beat@softbase.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101122943.8155-1-beat@softbase.tech>
References: <20261101095754.33840-1-beat@softbase.tech>
 <20261101122943.8155-1-beat@softbase.tech>
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

msm_atomic_check() forces a modeset, and sets allow_modeset on behalf
of userspace, whenever the CTM property of a CRTC is set or cleared.
This was added so that DPU could reserve DSPP blocks for the CTM.

DPU is the only msm display driver that exposes color management, and
dpu_crtc_check_mode_changed() now requires a modeset whenever the DSPP
requirement changes, for both CTM and GAMMA_LUT. The generic check is
therefore redundant. It also forces needless modesets when the CTM is
toggled while a GAMMA_LUT keeps the DSPPs reserved, and it overrides
the userspace decision about modesets.

Remove it, as the FIXME suggested. Commits that toggle the CTM without
DRM_MODE_ATOMIC_ALLOW_MODESET now fail with -EINVAL instead of
silently becoming a modeset.

Assisted-by: LLM
Signed-off-by: Beat M. Liechti <beat@softbase.tech>
---
 drivers/gpu/drm/msm/msm_atomic.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1db..7b480981b 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -185,22 +185,7 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct drm_crtc *crtc;
-	int i, ret = 0;
-
-	/*
-	 * FIXME: stop setting allow_modeset and move this check to the DPU
-	 * driver.
-	 */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
-		if ((old_crtc_state->ctm && !new_crtc_state->ctm) ||
-		    (!old_crtc_state->ctm && new_crtc_state->ctm)) {
-			new_crtc_state->mode_changed = true;
-			state->allow_modeset = true;
-		}
-	}
+	int ret = 0;
 
 	if (kms && kms->funcs && kms->funcs->check_mode_changed)
 		ret = kms->funcs->check_mode_changed(kms, state);
-- 
2.53.0

