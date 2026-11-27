Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3IySZu4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3564B1129FD;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5659112984
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:29 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so6928440f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774468; x=1796379268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mgx5cNkPMPqWVvWeuCS5VO4HsywH9BFvEOT6o0QcnWI=;
 b=P3IySZu4uji0uHPeYHXfklZ+n1fStS/vYDBNG9WQhc+0fI58Hxfg7FA5Zng6HF0SmL
 OKdmHIn1EdeFKqkDKA9cIdUnAxE2YG661bx+GNxlaI1pgL1yZ08SRlxfBK3E4SNAnICU
 KnarBMiXoE/tIEnrInLBM6xJR/L2S9wxzdFhdLwDyNCQTOu4C+kcX9PFAay8SFpQT00z
 F+hihkv28+qeUbQ7aEZRIhapPR1hKSJGiTd8jJXd+tPRk5z9kQMqjZHMr5qM7Ih7r26v
 z83UL9k+nOHY3P1BueIf0egKp597OZS8P5/R3y+Sib4Y0f9rtdTMKtONCnpjaHXObo6h
 IBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774468; x=1796379268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mgx5cNkPMPqWVvWeuCS5VO4HsywH9BFvEOT6o0QcnWI=;
 b=l+wMmwh8KICHtxKmKoXFUJd14UA6JYDCLVF3cWMyqFKtepPQOgd0qgR6GdrHzMK5dI
 F6D3j6fqhIk0VnMsx9L+sgeQLFPuep7O8UuPhTlhsB1soVx7ohFQSMgi6pW+liz/GwPE
 Gb5/ZN2knuAWWfcFeZ6pwanUOjtOIJ8NUjAbwFeuk+eTBjv+MCpF3A77gbj42YWaSTo7
 pXP4Ah36W1nsZvhjA4rHlmMNVFHYGYEEA1SJPW8TJUIFDFdZwvqYr/FPqyXHYkc9Xh7p
 0NDjr3ZKack9kQBZLj/WrZ0NNjsH7loik401gsIn64BK68f+ujLxZLLsWc2zIJ6vjgMv
 9d0g==
X-Forwarded-Encrypted: i=1;
 AL+hErF/Yd1qDRg2T9SjQjtrI+jalvB5ZiASOUR39uAm344lpRdszy+IFIAfWv1bAr/bnJkgqAItlt6V0e0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+rVLIH3q6gDdFJSrrcauAsAcP3A+LcTXkesmSI+NTaT/2rlE9/
 0xS+Iw0Hk+2cZ+JpbdJGnBE7NDYY10WjoUf6N6E+p8nJ1wRdRc2j5O0=
X-Gm-Gg: AZFdTZfaL0LSc4ze+rAtABpPJoY/TTQNLJLa1i5hA4GaQp8odNldXf+dfC61LpoedFS
 DTHYjgARjUU6goLPk6L/Wg7ZU1sdMCOgGkrzlru/OBYeiDWI+1L9XpCRFUoaPJ/eiNZKVkzd6n3
 C0A4stTdCAcSSmOJJGbYTuDT3ynY8C+FY0d+lGWpGC4jBmBFH6hJXrtJLI5zuRPKoxuXDm0Isk8
 kHLsG+NU6E38rmOjOSRELkmnFkoareK51bFOTHOsMTcyItkgsYYw0L4JD9Tbk2jbQz5fqbtOf7u
 qf0i3UnuCuo1utYNLyYmJ7RqVhy48PfKHUJ3Md/9gJIKu7xfBDFlLh+jMRq2auIHcbC0tcrxcVM
 M6wwshhhzHjEEvdBAlfP5dVycftEHkxdhgB75REkmD/g1jtNxpnFmhTgqNAFpBmEZCOITEgitWO
 GDlZZr3OR24I2PJ4bl0pXRCTj+7/8+zhkGjdCcVxtanw8BsEuH51xi4Z9BlZZ/dnLOeCs7tSmgp
 Yn1N5KRb5qRMsVEIGU0J8Sn2zG6fHcE2iVEKPe1xb1qa0ZFYsbYuzLbX9XSJTYLkd86u/8EXBQ2
 tAY8QL69uDSzjiNJD+D7IJEzi2LfyiC+UOqClVyQx9oCxVo7vRaSU1LpW47Hb3vZmHAw7jmAPsp
 8UnfCPYYHs6sUx0KLH95TKlp9TWFm3A8DBm+2VIjAiP9h/GYwiiX7Kehxl6w=
X-Received: by 2002:a05:6000:2489:b0:4a5:8f40:a644 with SMTP id
 ffacd0b85a97d-4abb1baa9eamr48914855f8f.9.1795774468069; 
 Fri, 27 Nov 2026 02:14:28 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:27 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 04/10] drm/msm/dp: reinit video_comp and guard stream state
 on link maintenance
Date: Fri, 27 Nov 2026 11:14:11 +0100
Message-Id: <20261127101417.24303-5-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_ctrl_link_maintenance() waits on ctrl->video_comp without
reinitializing it first, causing msm_dp_ctrl_wait4video_ready() to
consume a stale completion left over from initial stream bring-up.

In addition, if link maintenance runs while no video stream pixel clock
is active (for example in the window between msm_dp_display_prepare_link()
and msm_dp_ctrl_on_stream()):
- Driving DP_STATE_CTRL_PUSH_IDLE via msm_dp_ctrl_push_idle() without an
  active stream times out waiting for idle_comp.
- Clearing DP_TRAINING_PATTERN_SET while REG_DP_STATE_CTRL has not yet
  transitioned to DP_STATE_CTRL_SEND_VIDEO re-enables the sink
  descrambler against unscrambled TPS symbols, and waiting for video
  ready cannot succeed.

Guard msm_dp_ctrl_push_idle() on ctrl->stream_clks_on, reinitialize
ctrl->video_comp before retraining, and return early after
msm_dp_ctrl_setup_main_link() when the stream pixel clock is off so the
training pattern stays active until msm_dp_ctrl_on_stream() enables
video.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 779f743f9418..7201b7b513a3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2089,13 +2089,16 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl,
 	int ret = 0;
 	int training_step = DP_TRAINING_NONE;
 
-	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
+	if (ctrl->stream_clks_on[panel->stream_id])
+		msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
 
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
 
+	reinit_completion(&ctrl->video_comp);
+
 	ret = msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
-	if (ret)
+	if (ret || !ctrl->stream_clks_on[panel->stream_id])
 		goto end;
 
 	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
-- 
2.25.1

