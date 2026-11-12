Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320ED606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RSagk8yw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC0010F203;
	Thu, 12 Nov 2026 07:53:01 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F024010F525
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:54 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so2226899b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469974; x=1795074774; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JxZOgh8Tz9Rs+HuyIZTWtrxpzparsBej/GhOgMZ7srY=;
 b=RSagk8ywS77SQdh6ZKPzJ3tof/BKKRgw22/5Its9osvf7KlIewTRI/+UniGbf3F1uE
 3Zvd2IoBijCGA9jVqGdF6m5eeEta158UWDRSVGR1meFzavTqDE3uMbjEtr9g5eppsmR+
 2odJdKYITeJPW5eo3AqqdFRXBrwyByr7qplsnTC/o6dYXlAO341j2uoivs75oaD5DxxY
 0TgmYZt3LsD0u2E9w0JDEgrPQcMeQAfgRsGwigmcybVxz3thuPD/lOBGPnHxTMe1DUif
 Bm1DgzMkeP0gDe0jpE8ASrb/yJilAYbjfhqhvb6wYlkEHIdO/l6nUBYs7do88oD22Ocf
 YVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469974; x=1795074774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JxZOgh8Tz9Rs+HuyIZTWtrxpzparsBej/GhOgMZ7srY=;
 b=W54FsKkzOfBIq/WLMc0GpYDFjJtNmJhNEqUq6JYaGJkZm6syeFT4GdIVeDh5lm/OAR
 BF2eGhofqNA/yLFBAgusTRCd1U+vlU5KtSByJoFf/nR5sb83x9tacyQlficncj+xly5n
 Bm9HcMY65D1DHWZOLNFQGAQKghIh0KZwSLPQqaQphiHHQ3I2ZWjan4ebt+aZgaNgt6w1
 9pjtxiFCcqh/5b9khhlZZ66EpIYtfKFOjgDjxi7EqSPwmogEbeqOSsnXCqObSIG95PJl
 +uopVdmu1lex7nQXIwaNBfHjpFUy17wS6UVdqQexFnmCUMwftQJkTzsM2wULW5mpMYJq
 9TMw==
X-Forwarded-Encrypted: i=1;
 AL+hErHnu7Y2fYw1o3+FjJQOdV7gF6qop70TK/72KDXNBTouvX6fuSOmQNimmdPkZRugAqqd1OpBgrGWvpo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EG/DhrGYw8v68KwnIGY9wzr3yDGouGU5SolPPQA8m+V0hBhRG
 +tnV3/G9I8jnQEtrFxDegWncZh7IwGdCaI1fm+P10AJ/WAd66OLbXIy+uuty+PzxRws=
X-Gm-Gg: AYBFou18FizM70SfCI1pFJuAxoSgjduAWx9Dn0ux270vNH4d2k7yagkawlsZlZ90oFt
 6j7+b08hjkVVOsxXoN84uj9Vy1/WGjkB8xOKlUno35dLvv5q60JptD2vRxDvyvMtuNPvgXPriN8
 sq5hYkYwDHURe5glvT8ikYIYp99XwolNVEDTgexmBBBVljhFuGRRqzSEIKS5dVgnIbAZ3i0L2zE
 y7yU6hVlJH520KPYP5E/YlUF8Uf2a3FDWsiLY/K/gzO65jSFyc88/1Jh0b5OyxQs0LFWvS6pSmW
 +4DKWHl345gbJmW3IcCFve/rrAN3hjOwnYBAmfGZu5Ot8/HkWdMPKhg8oRlOtunECNhpfpEGeVO
 VS0MVQZ0o4Y/BB5tVhibCqCceurakZQEFWA2jF2lp/HGmGC8LhONwizLSUCtVEoo3v9Tods4ePN
 ouAzaPwgtmoSgHNdYwzcu8ijo/STeFtZG6hZipAIRoWHAC/2yHZW8mhJfFqBe4qlMnzWumLz7Mf
 940Y7P8tsXQ6rnG5fDXNbbWBQsOZfiQPUn7fdCuTTsLdXoZO7kPc5cnZQ2byyPcnyAHn8IJv6jO
 412rWeQRf7xCqLBRXjzEihzk7L+kFQ==
X-Received: by 2002:a05:6a00:17a8:b0:891:6d3e:3992 with SMTP id
 d2e1a72fcca58-8bc1cc6884dmr4894574b3a.46.1794469974348; 
 Wed, 11 Nov 2026 23:52:54 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:53 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:08 +0800
Subject: [PATCH 7/8] drm/msm/dpu: ignore merge_3d flush bit for non-CWB
 INTF
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-7-a6a88d928aa4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=2914;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=9Xse6MQZpCn/nWHqVpI3yh8n18tnb7floW0gWgsrbFk=;
 b=i7Cde9Pr5WbrvmOjjlemGCENIVjn01Df8Sd/E/sUaTSMCbGcBNbCN53IsaPLoFcCriyFLRaqk
 8xM0X53dmrNC7YVgZiskcRaKzoD0TPlSO3Tc/LFitAjwMcms3SQJjYF
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

merge_3d flush bit is always asserted for DSI interface vblank
wait in CWB case, while there is no visual defect actually.
Ignore the bit for now.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          |  7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h     |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 17 +++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 2f19ecfb6020..1a294f817972 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -3050,6 +3050,13 @@ unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc)
 	return dpu_enc->dsc_mask;
 }
 
+bool dpu_encoder_in_clone_mode(struct dpu_encoder_phys *phys_enc)
+{
+	struct drm_encoder *encoder = phys_enc->parent;
+
+	return drm_crtc_in_clone_mode(encoder->crtc->state);
+}
+
 void dpu_encoder_phys_init(struct dpu_encoder_phys *phys_enc,
 			  struct dpu_enc_phys_init_params *p)
 {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index b8c8222a03b2..34cde9a64d25 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -354,4 +354,6 @@ void dpu_encoder_phys_init(struct dpu_encoder_phys *phys,
 
 void dpu_encoder_phys_wb_deinit(struct drm_device *dev,
 				struct dpu_encoder_phys *phys_enc);
+
+bool dpu_encoder_in_clone_mode(struct dpu_encoder_phys *phys_enc);
 #endif /* __dpu_encoder_phys_H__ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 2ac517db50fc..7b310fd5db34 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -534,15 +534,28 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
 {
 	struct dpu_hw_ctl *hw_ctl = phys_enc->hw_ctl;
 	int ret;
+	u32 mask;
 
 	if (!hw_ctl)
 		return 0;
 
+	/*
+	 * For CWB case, DSI path always report timeout. Workaround it for now.
+	 */
+#define  MERGE_3D_IDX   23
+	if (dpu_encoder_in_clone_mode(phys_enc))
+		mask = ~BIT(MERGE_3D_IDX);
+	else
+		mask = 0xffffffff;
+
 	ret = wait_event_timeout(phys_enc->pending_kickoff_wq,
-		(hw_ctl->ops.get_flush_register(hw_ctl) == 0),
+		((hw_ctl->ops.get_flush_register(hw_ctl) & mask) == 0),
 		msecs_to_jiffies(50));
 	if (ret <= 0) {
-		DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
+		DPU_ERROR("%s phys.split_role %d vblank timeout: %x\n",
+			  phys_enc->parent->name,
+			  phys_enc->split_role,
+			  hw_ctl->ops.get_flush_register(hw_ctl));
 		return -ETIMEDOUT;
 	}
 

-- 
2.53.0

