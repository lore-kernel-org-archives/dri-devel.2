Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D64606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX4K7ivH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CC410F0EF;
	Mon, 26 Oct 2026 19:17:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8CB10F0CC;
 Mon, 26 Oct 2026 19:17:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 898DB406A8;
 Mon, 26 Oct 2026 19:17:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793042239;
 b=MOUo6YgwbhwNRmmf3zZYaHojh5lisCjhzMu7RERrUQftkIisc66b5aAsHfq7A2Qc227n
 fmUC8DRphzTft2nh7j85LFS80m82ctn/F2wRNrVh/S1XRDzmkfdJnSW2zLcHWMRNIgO3k
 4TtDH8OYcPAtctB9/QwaEuYUKrxQkPnYWxx1njaDaO7W5oF154YGLChbUNlC+T+oeH35q
 7rR2jS6LGboFc71fdmXNfGag3jbjZ2QlnmbV4zHadWdSmC0suvJ6HNURK+LYdAwPxvTUO
 CIok0EDo+vYmKIWW7vJQ6iSd/cZv26+YwQOmgolCI6ONiWW+txDTeptMYEqj02c/LYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042239;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=2YZQW11LMpAg6FbtG7dfpuG3Q4WOyZw1dtjuZP2GnOE=;
 b=LOP3pvqFrHnV8wZqZ60bfiVZOb/N8lQn/JjcjqrXShKTpBnnL+/JnkzdM1uYbl5ZYr/p
 mbqN180h1PIt/tHZ1XVxONgZjV2i8iGQtY1ak6WJ/FVfoWYkmEOsM2v26rFpBlT7qr74T
 KPCHYLBIh4wbqZJm+Wsxr4j5rGpX6nsHQ0bfRdOGHVuAtp5p93rx/R4Zqxfky59DaXJ+A
 dm1ZtH/8/5fWokAcJhD7nkAVoyEouFwioFCCE7+/W2qEXs5YPVTYUpXqiaX0bn5MxnJOi
 s6QWZ7GiebleRUXMMvYE+k6gRBD20T6XNfMqfjL5AjPXTR1uCiA3GVAMf72NEog2CBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B38891F031E3;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042239;
 bh=2YZQW11LMpAg6FbtG7dfpuG3Q4WOyZw1dtjuZP2GnOE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=IX4K7ivHe/2GiHSMJO8vxrFhil+02Ik3xSngW311rwOPlRTeQA7Agg2qZPVprP3Kf
 k79EW5KZ2RlDGIh/nR4FEqMzf9QAmWpqnNb1alSspGQQea249VWQvoxlWR+his5h+C
 ohLSfO9XhLyIUdwHRZJ/JZE9efUlIXS+qmqPszmSqc4hxkAG5SDt2G2ZkIev3ij356
 s2np48oy7NbbC7V2wlYUBngKam0oxZeot+gPXQgIKW/0iNSk/i6OwSYeb4NWjegD8Y
 krtGGq0SlmEiRwHQtiWmm5yo+BGq6tMX1CmA/+jzL+s+zTzT0n8INZJvd9VoQ2nfo2
 eTuQ0Pg09eJTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D07F344E54;
 Mon, 26 Oct 2026 19:17:16 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 16:16:53 -0300
Subject: [PATCH 5/8] drm/msm/dpu: use cached PINGPONGs from mode set in cwb
 setup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v1-5-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793042236; l=2160;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=Z1k+1OyboIw3FwlS2YQ2mt7AUCLFoNmOxjQChG5wHhQ=;
 b=5WTfGrGDY9HoEPtY+145EtqV+YOoCgU2atdQ0i8iU7JsZE1MEqBQ4meUEIE494qCHpGNhkttD
 946Gcd33reACz0p/fbHprBwGUCfIbHLcjfreDPdoexf9dSQCm1d71oA
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

No functional change intended. Clean up only.

The cached hw_pp should be the same as the ones from
dpu_kms_get_existing_global_state during
dpu_encoder_helper_phys_setup_cwb.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 7d092398fc99..f1d2482b787b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2363,11 +2363,6 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
 	struct dpu_hw_ctl *hw_ctl;
 	struct dpu_hw_cwb_setup_cfg cwb_cfg;
 
-	struct dpu_kms *dpu_kms;
-	struct dpu_global_state *global_state;
-	struct dpu_hw_blk *rt_pp_list[MAX_CHANNELS_PER_ENC];
-	int num_pp;
-
 	if (!phys_enc->hw_wb)
 		return;
 
@@ -2379,33 +2374,20 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
 		return;
 	}
 
-	dpu_kms = phys_enc->dpu_kms;
-	global_state = dpu_kms_get_existing_global_state(dpu_kms);
-	num_pp = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
-					       phys_enc->parent->crtc,
-					       DPU_HW_BLK_PINGPONG, rt_pp_list,
-					       ARRAY_SIZE(rt_pp_list));
-
-	if (num_pp == 0 || num_pp > MAX_CHANNELS_PER_ENC) {
-		DPU_DEBUG_ENC(dpu_enc, "invalid num_pp %d\n", num_pp);
-		return;
-	}
-
 	/*
 	 * The CWB mux supports using LM or DSPP as tap points. For now,
 	 * always use LM tap point
 	 */
 	cwb_cfg.input = INPUT_MODE_LM_OUT;
 
-	for (int i = 0; i < MAX_CWB_PER_ENC; i++) {
+	for (int i = 0; i < ARRAY_SIZE(dpu_enc->hw_cwb); i++) {
 		hw_cwb = dpu_enc->hw_cwb[i];
 		if (!hw_cwb)
 			continue;
 
 		if (enable) {
-			struct dpu_hw_pingpong *hw_pp =
-					to_dpu_hw_pingpong(rt_pp_list[i]);
-			cwb_cfg.pp_idx = hw_pp->idx;
+			cwb_cfg.pp_idx = i < ARRAY_SIZE(dpu_enc->hw_pp) && dpu_enc->hw_pp[i] ?
+					dpu_enc->hw_pp[i]->idx : PINGPONG_NONE;
 		} else {
 			cwb_cfg.pp_idx = PINGPONG_NONE;
 		}

-- 
2.55.0


