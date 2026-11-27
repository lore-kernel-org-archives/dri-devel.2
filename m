Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsUjzMQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274F61129FA;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFB1112999
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:28 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so6928421f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774467; x=1796379267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tA+J6mGbIT9WLOmGI7WGSCcbG+FEuLz9DTzxi1U99nI=;
 b=PsUjzMQ6eve/EZ6dBbhYWBL3OWVPw7OlyglxVSq2LEIn2UZVaheTohZqdXfIzd4+YP
 mTs/yx7bqMg7dqBUG/jSEKPn0XGBx2+uAl2Yt5vEfh/v3LLDVlLoP4GzUl3g9rdn4xGL
 RQ2lautIHsz+G60QVnwxzljhkrJkkIywHgqP3ofpXRtdlaFeg8a6mA5twtuEVpI/5UwE
 wnqhfHZURz1xOUKqXSxOEb/RlWnEAUzJ2qx/33FXo7T0/xEGCLqo5FwFPyeUUST6ZRb/
 JXObYABoFastprpJZBKHikZ1ytKYal6Qn/xzUHrDTHebLvNN8El2VBCf/O0YjWog388j
 Geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774467; x=1796379267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tA+J6mGbIT9WLOmGI7WGSCcbG+FEuLz9DTzxi1U99nI=;
 b=IfwyhbCzO+jljj2Q7nmQQKk5VZ3OOIsdj3H26SgQWLjEP6bdbYsimyw0hxpAJxHs+R
 cnv/0En483MgodIKLzyKjD+TVL40Lpwj+1uVUyryoUmjKbaVNAl4gl6I5Xcw0n5vRqFY
 JzZl/FQAxAFuMumkQq1GjsFKd7he7pOnJ314weeB4TGdgIMWuZRe3zdTK6/89eMzSBHW
 L1jld0MZHCOEeQ5GkK1EWlGOoeoszr/kq5MiktEQQYf2DNYMuRKP1Bc3Ifzg9XI2Nbos
 39iAy883Ekjb0E+BxeNSUwoQ17lIjOFIgwoEKggvUHI3bDMIo2g4RqtKT/xx8gPslFug
 YUvA==
X-Forwarded-Encrypted: i=1;
 AL+hErEKN00Ymta2p/tm/+X1f6Wvs/GtiIvp7LuktTtJ0pw8k7HzJeVDo6P/hMfjF/zgBSh+Cgc6XiqOG9M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lkr+JtH0W3qhjsoEKhYfKICsGnmZAbtiYUHi9HeoaUOWdyx2J
 4kilIJfjQv9X+ZP7yn+1MHfanhFfirt1HWpp+X8qXblJ0ViR/bykzt0=
X-Gm-Gg: AZFdTZfsqbaXXcZwh6lm0i4A48Dp4MgkrlUuxHmRC9T81mpvC+5t5PCcmAnh0ZY3ULR
 Ar0Z4ct7cdwM4ldcII1b0XLLCp7uj+71YZOXyntldFZ5Q7T4RBXa81fTdQDlEGUwAZ1TEdlutV0
 jBhTHYssgKJbtBEjFlDp00K8PMKQA45RABfji7sN4AIjaRmvbhAfM2Iv2G+4XOrIUBpIwV8Ygb+
 O90R8Y5dD4S9bfmvL9kZbtZh6oIfUpYGKyNkdtLkV/xKB6ntJGnn4uxz+ZltHV0Kt8U2vhpW1lq
 kuF6LYCIu4UqbiIiDckskgI/Sqh5GENXDJX/n+1g8jXpWA+FYs/FfLXhk6D/4f95vjqe5wxB2KE
 ThbVV1ZdNLkFMM0Ch3l+zi2Sd3FM7spYws+n/nMuGFF9oCSigJZZovKXJB/Fgo4/gtQejbhMJQ9
 usgiDQbC09xKgYnver2xwROTe0t3lDWOZHofdQQ+7VLsi/mp699p9ch+gzhYtiEqOTyiPs0AoxA
 IP6Fj2eAkH4anDm24pjrxIZBF2Z4oKvb2UoOqU2Ea96KhojVbZAgWMiBU673tLigGXb1CW1TX8O
 AZREDL2NaQhURgQGPeV/aK00LQUspej/045Y1l60IYYrDT2jSdOBY17h6L0Bi7Hdlpr5opMXGen
 n93edFmQTMsETOG0AboGM418DO9TroQwFBlz7OacqfHSLvcfvXREhICHlD1M=
X-Received: by 2002:a05:6000:4014:b0:4b7:ae36:5493 with SMTP id
 ffacd0b85a97d-4b7ae36567emr25594210f8f.12.1795774466728; 
 Fri, 27 Nov 2026 02:14:26 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:26 -0800 (PST)
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
Subject: [PATCH v2 03/10] drm/msm/dp: keep training pattern active until
 stream video is ready
Date: Fri, 27 Nov 2026 11:14:10 +0100
Message-Id: <20261127101417.24303-4-gianfranco.mariotti94@gmail.com>
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

Commit ca16db3d18cf ("drm/msm/dp: break up dp_display_enable into two
parts") introduced two regressions on DisplayPort re-plug:

1. msm_dp_display_prepare_link() called msm_dp_ctrl_on_link() on every
   prepare (even when power_on was already true) and unconditionally set
   force_link_train = true when !power_on, causing
   msm_dp_ctrl_prepare_stream_on() to immediately re-run link training a
   second time right after msm_dp_ctrl_on_link() succeeded. Only call
   msm_dp_ctrl_on_link() when !power_on, and pass force_link_train =
   false to msm_dp_ctrl_prepare_stream_on() so it only retrains if
   channel equalization was lost.

2. Splitting msm_dp_ctrl_on_stream() left
   msm_dp_ctrl_clear_training_pattern() in
   msm_dp_ctrl_prepare_stream_on(), clearing DP_TRAINING_PATTERN_SET
   (DPCD 0x102 = 0x00, which re-enables the sink descrambler) ~45 ms
   before msm_dp_ctrl_on_stream() enables the pixel clock, programs the
   TU, and switches REG_DP_STATE_CTRL to DP_STATE_CTRL_SEND_VIDEO.
   During that window the DPTX remains in MR_LINK_TRAINING2 transmitting
   unscrambled TPS symbols, causing SST monitors to lose symbol lock.

Move msm_dp_ctrl_clear_training_pattern() back into
msm_dp_ctrl_on_stream() immediately before DP_STATE_CTRL_SEND_VIDEO.

Fixes: ca16db3d18cf ("drm/msm/dp: break up dp_display_enable into two parts")
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz> # x1p42100-lenovo-ideacentre-mini
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  6 +++---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++++---------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b896196cf244..779f743f9418 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2616,9 +2616,6 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
 		msm_dp_ctrl_link_retrain(ctrl, panel);
 
-	/* stop txing train pattern to end link training */
-	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
-
 	return ret;
 }
 
@@ -2663,6 +2660,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
+	/* stop txing train pattern to end link training */
+	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);
+
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bce641d7d893..b8373740275b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -632,7 +632,6 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 	int rc = 0;
-	bool force_link_train = false;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
@@ -650,17 +649,16 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 
 	if (!msm_dp_display->power_on) {
 		msm_dp_display_host_phy_init(dp);
-		force_link_train = true;
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
-		return rc;
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc) {
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+			/* TODO: schedule drm_connector_set_link_status_property() */
+			return rc;
+		}
 	}
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, false);
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
-- 
2.25.1

