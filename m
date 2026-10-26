Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26760A260B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0eW8vF7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5EE10F12E;
	Mon, 26 Oct 2026 20:26:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C3310E362;
 Mon, 26 Oct 2026 20:26:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A461543ECE;
 Mon, 26 Oct 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793046366;
 b=itxv7IKT/UcVflnv00AVbLQvo4453jPr6M3z7zc8Tc1OIAuxMePpG+l/rYsLnei/e5gl
 cwVsBqDKHQbU3IvYnPalOvrAtqGvICA0X8+nAHchTnXYDccbrQM2s1WVWOlsXmWCYagAc
 plWoqs3OiAi4sw1cJ2FfwCouG6pejHfEMajx6/+UjIdrXq/oyG6kXW54CwcX7m7z1TBSd
 Sz9CYTejvPDZ3KJgkhhb+UP/2VWZpZW7tn89YRnr2RerRgD4eGHYGx9sN926YIOE5IpKq
 /4snYr7UiiTF1xko7eaMdRfJoXRZ8wkjOwY1GO711atiX2xwz0wppUcPql4Egolmiqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793046366;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=JRjSAAuR7hRAdwbUXH9UJHGrVoF/0JplyAOZ6D7TEAE=;
 b=2qI4Vrjdh902evixlHeHW6G4hRN5Kso4DG4hl37ynteVXwoCDnJbaLPkxc3DBxlSjP3f
 UU2FALkRwsQI/OxDCUegz45K/2q+RN8Q+LrBj3Z9vAZUFKPmBFU5JY9hNn+4jNwGNJsk+
 7Sbm5C5UeircFgnCAUCkbfz/1lTvbl1aLZmG8h3TryK4kBo+vAnvtPUvJwyUdQVJsGpfv
 8h7/8LoRH3szOJZV/VZlKn7xibwTO622Bnb1ezdLIz4yOVQXJtEjDoYEYqdpdwqTbt3oV
 O8UaXvLYj0cTsHljSMy8t0/nxeUzdnU6O6CdVOUt1YmusLW9hCehBSRYvO9bXZeTNtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6C1521F031E0;
 Mon, 26 Oct 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793046366;
 bh=JRjSAAuR7hRAdwbUXH9UJHGrVoF/0JplyAOZ6D7TEAE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=C0eW8vF7gH8itK7kNwszXIsozuRuoy0cXg7bS9yn8BucYHdJYquQCENT2l0ks24pp
 uSqExJvWUssV2o18NDV2EJbuoCemEpHVKyfTGzOaG6KF030uCZ7k3M57CQPHIFhLXB
 znXZIq5OksjTY2PxA7mjxqMql+hH9hKQ/U6DrcjH/zh9iJyO36m4hvC6V6admKwrxH
 MayvP6R7kPsJk1rQGxuFaGWij4t07oLVsw4wChzACxtVkAQNJmlK7mWWER7FHNu4Iq
 VuOR90DHUHeI73XdzsosAPPx/NOsz1OW53bTtNL3t23qj4VXgwqK4mzlZ9nv2Kx9d6
 EpeIN0Kv4pw7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D14B044E91;
 Mon, 26 Oct 2026 20:26:04 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 17:25:43 -0300
Subject: [PATCH v2 2/6] drm/msm/dpu: save LMs in encoder mode_set for
 cleanup use later
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v2-2-3d864435186e@gmail.com>
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Xi Zhang <xz.ca.cn@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793046364; l=5310;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=8PB6tAtHyoeBMCu0fLO2+0ATMltRJRVeHPZqWTJn5Yg=;
 b=iBv0391PMeix+fnawpXmmHtKjJOc3TB+UeksvQ9BJXQqpuJGpTaUATRuwe5KrHBF5U5i9iIS7
 rMwO0sB2KQ0BAuPP8uDgaPmlL079F2SfNauhc+TW43FPDc3tjv5qwL4
X-Developer-Key: i=xz.ca.cn@gmail.com; a=ed25519;
 pk=aRUll5L3eJbwG8Y4BO9uySKGzm+Uy+Ccei9prnRVZRs=
X-Endpoint-Received: by B4 Relay for xz.ca.cn@gmail.com/20261026 with
 auth_id=1328
X-Original-From: Xi Zhang <xz.ca.cn@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: xz.ca.cn@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xi Zhang <xz.ca.cn@gmail.com>

dpu_encoder_helper_reset_mixers, which is called during atomic_commit
disable phase, previously called
dpu_kms_get_existing_global_state, which returns the global_state
after the state swap. So the cleanup was performed on the newly
allocated resources instead of the ones that actually need reset.

Cache LMs in dpu_enc similar to other resources during mode set, and
perform the cleanup on cached LMs instead.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 58 ++++++++++++++++-------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 8d2b4d2726f2..81b983ecffbb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -133,6 +133,7 @@ enum dpu_enc_rc_states {
  * @cur_master:		Pointer to the current master in this mode. Optimization
  *			Only valid after enable. Cleared as disable.
  * @cur_slave:		As above but for the slave encoder.
+ * @hw_mixer:		Handle to the layer mixers used for the display.
  * @hw_pp:		Handle to the pingpong blocks used for the display. No.
  *			pingpong blocks can be different than num_phys_encs.
  * @hw_cwb:		Handle to the CWB muxes used for concurrent writeback
@@ -182,6 +183,7 @@ struct dpu_encoder_virt {
 	struct dpu_encoder_phys *phys_encs[MAX_PHYS_ENCODERS_PER_VIRTUAL];
 	struct dpu_encoder_phys *cur_master;
 	struct dpu_encoder_phys *cur_slave;
+	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_cwb *hw_cwb[MAX_CWB_PER_ENC];
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
@@ -1156,11 +1158,12 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct msm_drm_private *priv;
 	struct dpu_kms *dpu_kms;
 	struct dpu_global_state *global_state;
+	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_pp[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_cwb[MAX_CHANNELS_PER_ENC];
-	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
+	int num_ctl, num_lm, num_pp, num_dsc, num_pp_per_intf;
 	int num_cwb = 0;
 	bool is_cwb_encoder;
 	unsigned int dsc_mask = 0;
@@ -1189,6 +1192,14 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	trace_dpu_enc_mode_set(DRMID(drm_enc));
 
 	/* Query resource that have been reserved in atomic check step. */
+
+	num_lm = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
+		drm_enc->crtc, DPU_HW_BLK_LM, hw_lm, ARRAY_SIZE(hw_lm));
+
+	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_mixer); i++)
+		dpu_enc->hw_mixer[i] = i < num_lm ? to_dpu_hw_mixer(hw_lm[i])
+						: NULL;
+
 	if (is_cwb_encoder) {
 		num_pp = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 						       drm_enc->crtc,
@@ -2183,42 +2194,37 @@ void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
 
 static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 {
-	int i, num_lm;
-	struct dpu_global_state *global_state;
-	struct dpu_hw_blk *hw_lm[2];
-	struct dpu_hw_mixer *hw_mixer[2];
+	int i;
 	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
+	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(phys_enc->parent);
 
 	/* reset all mixers for this encoder */
 	if (ctl->ops.clear_all_blendstages)
 		ctl->ops.clear_all_blendstages(ctl);
 
-	global_state = dpu_kms_get_existing_global_state(phys_enc->dpu_kms);
-
-	num_lm = dpu_rm_get_assigned_resources(&phys_enc->dpu_kms->rm, global_state,
-		phys_enc->parent->crtc, DPU_HW_BLK_LM, hw_lm, ARRAY_SIZE(hw_lm));
-
-	for (i = 0; i < num_lm; i++) {
-		hw_mixer[i] = to_dpu_hw_mixer(hw_lm[i]);
-		if (ctl->ops.update_pending_flush_mixer)
-			ctl->ops.update_pending_flush_mixer(ctl, hw_mixer[i]->idx);
+	for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_mixer); i++) {
+		if (dpu_enc->hw_mixer[i]) {
+			if (ctl->ops.update_pending_flush_mixer)
+				ctl->ops.update_pending_flush_mixer(ctl, dpu_enc->hw_mixer[i]->idx);
 
-		/* clear all blendstages */
-		if (ctl->ops.setup_blendstage)
-			ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
+			/* clear all blendstages */
+			if (ctl->ops.setup_blendstage)
+				ctl->ops.setup_blendstage(ctl, dpu_enc->hw_mixer[i]->idx, NULL);
 
-		if (hw_mixer[i]->ops.clear_all_blendstages)
-			hw_mixer[i]->ops.clear_all_blendstages(hw_mixer[i]);
+			if (dpu_enc->hw_mixer[i]->ops.clear_all_blendstages)
+				dpu_enc->hw_mixer[i]->ops.clear_all_blendstages(
+					dpu_enc->hw_mixer[i]);
+		}
+	}
 
-		if (ctl->ops.set_active_lms)
-			ctl->ops.set_active_lms(ctl, NULL);
+	if (ctl->ops.set_active_lms)
+		ctl->ops.set_active_lms(ctl, NULL);
 
-		if (ctl->ops.set_active_fetch_pipes)
-			ctl->ops.set_active_fetch_pipes(ctl, NULL);
+	if (ctl->ops.set_active_fetch_pipes)
+		ctl->ops.set_active_fetch_pipes(ctl, NULL);
 
-		if (ctl->ops.set_active_pipes)
-			ctl->ops.set_active_pipes(ctl, NULL);
-	}
+	if (ctl->ops.set_active_pipes)
+		ctl->ops.set_active_pipes(ctl, NULL);
 }
 
 static void dpu_encoder_dsc_pipe_clr(struct dpu_hw_ctl *ctl,

-- 
2.55.0


