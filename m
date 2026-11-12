Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F5606A33C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K6+Tnp+1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1500610EB85;
	Thu, 12 Nov 2026 07:52:37 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E442B10EB85
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:30 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8a058315c79so2085917b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469950; x=1795074750; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qVNYeCbCbAXxmLLdlIMU9oCrRe4PBlONcsIqJq1mQ30=;
 b=K6+Tnp+1MQu4SOVL7+Oo7M+Q5SbuppTIjfu+4dPrZtPBz8xfF1yq3BLKjZzBN6BncU
 gPfnTxKjePHjTwLKWntc+rpJyVFEIdq65xxdAawSMOdiNtQ2EmrJUPWTqm0ANxWh1hsr
 rFb2XJbWDRGBqcnCJWynwVU/3TtAZtPEFEOIiuUPxwQX3qDBJmgQW/FgjO9gNeIsMLE7
 +rCw8iJzaeD35f5rwApUJ+9VykK9XaDC6yF7eo74hgLZkFMi2Opp+ZVnWCYY+jCJTEMP
 VmyZMCgaCIZ6NU7y6iGkhPKu7LJk7BJnJgcUL3tPS5SvudVl2ORAT91A3bLPuUFUAdax
 Cb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469950; x=1795074750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVNYeCbCbAXxmLLdlIMU9oCrRe4PBlONcsIqJq1mQ30=;
 b=hiR3fl8av3XI4V0OTUPtoNBFRFDFJ3ZTGQ/TpKezZhyD0V4HVcV2fTA42djMZ3v6Uu
 EmSuhc4Zla7mkaKFOsbezUNwUXkfwMR9eWWb7NyMiT5vlPQxuBSuWno7zT8g51DuYW+X
 E12nFgl5+yHIIo+9dw/zI3bdztI6MiUKqGs4mHzSB97HaKpXJvuyLC7NodDtClZH+lP7
 cK16Im98Oormd/sA5QrOgs+7L22+c0b9doqWwt2ws9Fi7WqXOr5tahkjWHZyoE7X+tTk
 HxZ+49jD2ShR1AoCEgRcXEvnNz6jKCi+6SXJUfBGMfnxBpKeQJjXwOOKGLokpG/xPe0m
 gc7g==
X-Forwarded-Encrypted: i=1;
 AL+hErE1KjScbsG1UM4yzvMJ4HnjVVRT8asiE2bpvRh5Y8ZQOAZSVrJMMsRcYjX+hY/GzNRB/ZxHzJ82Go8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95K9qf6y+hVpC7RNvXvF+WOjxEOM0jGwQYhFEas5R2Rh4WGAXw
 5CKw11EhmqV0YX14hl0ujPY88reaKrawFzx6CM9qG+NQP1pnv/upNZPgObYpT2U1bTs=
X-Gm-Gg: AYBFou0Llh7wUHFdBlNYBFFzYeqiRRpPVqUTQws9QjyhZZReCFy0S/7cIIWlt377dXH
 TX1DFbdmol8zLUJHNf3zdLF6XaopMD0Bjv+G3E4+Ut91GhVgzTpKVpsz1Ui4EmqbXoUI8Vg/0B2
 6IMv2lQGoYj2P/ht/PEC5DiA+Yu8me6cW/RP2tdLDIBGewI23f7aNLn1K1bwmDENABVD8Vkrb/Q
 UEQ09D7VYogXCI6vfbMqEKaUenb3czbl6MRl1uXE0u0/0Xm7JsmmtONgWMIVjRV/HpY48wYhq6V
 JQZMFgT57Uzc2a0dwX5Gwm1sYvICek+TrwVRzLdT9Qxpq8bFe6RdprzYtI1ekl+bHFMtXkRnqDT
 6j3T0Wy2QcuaidFWb/6omufT65sWoJGwxWSa1DKMMRVFhuqFjoojXgkLLTlE6rVY+5pKSYgfYvG
 l6vm7Ca7uKXeOptB5crcGAMyQOOBdCFs2IMx8rjMz5tB4OvZ70Pqy2NykUHiKUU8M3GMM550qDq
 o+9O19/gvlM6fnH5qnGORNQ8QnnfqycMIfnNsX3yfpfx2BzNr69Hg09tggg2b8k+zI+P0O1eQDs
 FLORntdMSPvPLlpP9Qdm2A7AyKpI2Q==
X-Received: by 2002:a05:6a00:3d47:b0:88d:8074:1a9e with SMTP id
 d2e1a72fcca58-8bc1a39e51amr4637834b3a.3.1794469950174; 
 Wed, 11 Nov 2026 23:52:30 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:29 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:04 +0800
Subject: [PATCH 3/8] drm/msm/dpu: support mapping framebuffer to 2 physical WB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-3-a6a88d928aa4@linaro.org>
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=3088;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=n92yISLOg7FxejPirqGSQZt1WBDSmToFc68ZG69Z3/c=;
 b=mws8i9pwyAQijwBNy8Z8yQ+mt7XdSqf5wyM9PZaWS1yq6P0SNsYZMNFdVdkUnMWPN+tJAYQAo
 x+R/Jac9QhhBo8GGUWT1LBG0EODqgus7nnM1BOZcMvK2FPuXtIF+vcZ
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
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

Only single WB interface is supported in writeback use case currently.
Dual WB interfaces are required in quad-pipe topology. Map framebuffer
to 2 physical WBs in low level, with master physical encoder to handle
high level communication.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 22433bfbea1e..7d3528907670 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -188,9 +188,18 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 		cdp_usage = DPU_PERF_CDP_USAGE_NRT;
 
 	wb_cfg->intf_mode = phys_enc->intf_mode;
-	wb_cfg->roi.x1 = 0;
-	wb_cfg->roi.x2 = phys_enc->cached_mode.hdisplay;
+
+	if (phys_enc->split_role == ENC_ROLE_SLAVE)
+		wb_cfg->roi.x1 = phys_enc->cached_mode.hdisplay / 2;
+	else
+		wb_cfg->roi.x1 = 0;
 	wb_cfg->roi.y1 = 0;
+
+	if (phys_enc->split_role == ENC_ROLE_MASTER)
+		wb_cfg->roi.x2 = phys_enc->cached_mode.hdisplay / 2;
+	else
+		wb_cfg->roi.x2 = phys_enc->cached_mode.hdisplay;
+
 	wb_cfg->roi.y2 = phys_enc->cached_mode.vdisplay;
 
 	if (hw_wb->ops.setup_roi)
@@ -206,6 +215,9 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 				     perf->cdp_cfg[cdp_usage].wr_enable);
 	}
 
+	if (phys_enc->split_role == ENC_ROLE_SLAVE)
+		wb_cfg->dest.plane_addr[0] +=
+			phys_enc->cached_mode.hdisplay * format->bpp / 2;
 	if (hw_wb->ops.setup_outaddress)
 		hw_wb->ops.setup_outaddress(hw_wb, wb_cfg);
 }
@@ -369,7 +381,12 @@ static void dpu_encoder_phys_wb_done_irq(void *arg)
 	atomic_add_unless(&phys_enc->pending_kickoff_cnt, -1, 0);
 	spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);
 
-	if (wb_enc->wb_conn)
+	/*
+	 * For writeback with dual HW WB, only master WB is needed to handle
+	 * high level task.
+	 */
+	if (wb_enc->wb_conn &&
+	    phys_enc->split_role != ENC_ROLE_SLAVE)
 		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
 
 	/* Signal any waiting atomic commit thread */
@@ -430,7 +447,8 @@ static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
 	/* request a ctl reset before the next kickoff */
 	phys_enc->enable_state = DPU_ENC_ERR_NEEDS_HW_RESET;
 
-	if (wb_enc->wb_conn)
+	if (wb_enc->wb_conn &&
+	    phys_enc->split_role != ENC_ROLE_SLAVE)
 		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
 
 	dpu_encoder_frame_done_callback(phys_enc->parent, phys_enc, frame_event);
@@ -484,7 +502,8 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
 	drm_conn = &wb_enc->wb_conn->base;
 	state = drm_conn->state;
 
-	if (wb_enc->wb_conn && wb_enc->wb_job)
+	if (wb_enc->wb_conn && wb_enc->wb_job &&
+	    phys_enc->split_role != ENC_ROLE_SLAVE)
 		drm_writeback_queue_job(wb_enc->wb_conn, state);
 
 	dpu_encoder_phys_wb_setup(phys_enc);

-- 
2.53.0

