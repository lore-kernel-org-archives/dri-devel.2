Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056B606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwM873Zt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D20D112CE8;
	Fri, 20 Nov 2026 19:21:10 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015FE112CE3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:20:54 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-55d6deecef6so12677861cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795202453; x=1795807253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JzigroRRK1EKbCrob1Vqde61idCw6MMlemAEeFuskd4=;
 b=KwM873ZtXAUaMsoj0Cw+2T8yp5DNoPB+NMbDw0LdcF05U4MoEmqt3N9XruujzbzfqD
 kTndB/CxxZH+1CJPGRzpb81b4s0XJ3YAzgySf4S2c2lvrc9usETRtZqYSZP6PCub6LgI
 ujb3UFGRsKKrjJsJOF+BrJwYXvHJXMv2aLwVFemy8t1fBnwZz8xP/7VyjaAr9GM+NRdU
 dx5tNnq8GAmkNX0S0y5INuLOptOC7FLezho6gOZJTUxKsFwqpTbbYbPLKq75vYtrpWBQ
 QM4xRdHjojB7+PFFjG+Ui1bLQmGiwaaxUkAV7mmkIyPS3LcdRgK5FbHmM5ySJjOfQl6Z
 cbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202453; x=1795807253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JzigroRRK1EKbCrob1Vqde61idCw6MMlemAEeFuskd4=;
 b=JakeiI7eZwXnWPiJVAjwgoigUws2Ncppeew5FiZiNDKdigQxU+nX3WXicnG3F7MO+s
 +pczzrv95atHebsY3BCsi3qEoAvq/I0nTXyKmDixyU+lA7xU/HKCulMXiom68ZBUaW4x
 bZ2w8UbxuqwRss/M//HOwx31mZXlv+da+vjN9cDPDZb+AePD4JS85pwFHdMT25MTCSA/
 qmD+cIbVEym5Ogqdvtmvm3Kf/f7kEbRE9zKSguVf8d8aeeLOE/PnW078zJxS8XtRLN9f
 pgXP7nkXQmozpM5ok+i7d2eU9kj6tieIiR2Y+H6/Y0V+zYGtK+yhfae2HaDw05iN/kCC
 RzTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3qJctkveeWk8li4iuKR9u9LdlUl09Ln0rvuvGDnbU8RkCRT/XvFRsY7YXLwL5Fupj2MQEb4hp9wE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81Mm8IwApxrW5wOhtBKkTWq3RStacdxv8oPmWBrQP2PkKURjvX
 RBzs134bZJ/SfNF7/ZON6aMrqqGge/+JcQ5EIBOWhg3fcsKDQrjCCxHTiweQNcXqjGWPhg==
X-Gm-Gg: AYBFou3mMzwUadRPvcXn9yVIfwi4ytVoy84GYXVzEmwhJfASNA1xWjQoZkT+KCFlKtP
 J2LM3ZLtbwpq3fBpE691PJqSdwhpQ4A2ATtkzoS7OxH1EgdILxGZ6a03EoMarPC3tG+rIrCk5iL
 f+C/xKLauCh3/dGgqZ4RD/8sD8xR6TcL5O8Ea3vs4A3cUtp+J4HjPuWR2W7uE4LWPXBEMghV7Yw
 i6BA61xQZ8wYqAOAq2RjMcqxLt68asIKc0BU2deieyPJ9vU50e6Yu9zuQ3RSXwRgZGmqHpv7Plb
 7o2nFZGnvVbTLE7jJnWrQBcg1WRRiVesak+RcPeujaoIw0KAmX/XzntDODorXnBn2tHMqAMx5wt
 GxW8yDBbWg5W6KxSPWVh0R5TY9BGLy7OXcJKM52kcsWvVrIjUhFXMxX/tG7iKR+l6iPKunfheGS
 Y3smwtm+j1lxwc3lhEVF8cRaJNBpqJ9UYrw8voPm7/PqyU69MWoLveYE0BZ/p9Vh7PzF1xTY8EC
 10/fmy6AHV9oWaQuhjC3GbiVfAVTc2lVdwhUoHoGLqp0WaY2MZtTojfzYg1tWT5HY2Wi0FkhDFj
 yr+TPEt8IYj2A9sanIZQx//8U5ZGTDLs9ZcTMPcToV2lMwhQC6TXR0gdK5sQAViVIMw/7tRLYqo
 dcXjAmle6bYv7/cb+7PzTEtdwXCEKoOtK/0N6PIiGdv10NndrBSdlvZpaZQDZ636Q22zPGOEK+j
 WC6RLqrHOvXwQxb7Fx/pOZK2/lC9oxUnNkVZGhsyCICfuNaoGg2gLo/prJ8oqJQrqlNyqZD6jjO
 e0nY87d7mcOAfWF2KfBcClvh0eD4XqNp2Vlp/ANuPMHnw==
X-Received: by 2002:ac8:5a46:0:b0:536:6bbc:6187 with SMTP id
 d75a77b69052e-55d76a4ffabmr77548281cf.31.1795202452871; 
 Fri, 20 Nov 2026 11:20:52 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net
 ([2600:4041:5024:4b00:d420:4621:169f:8773])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882e2c6sm31475921cf.12.2026.11.20.11.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 11:20:52 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Martin <jimmartin@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 1/2] drm/msm/dp: carry the eDP rate-set selection into the
 link parameters
Date: Fri, 20 Nov 2026 14:20:49 -0500
Message-ID: <20261120192050.73315-2-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120192050.73315-1-jesse.casco@gmail.com>
References: <20261120192050.73315-1-jesse.casco@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_panel_read_link_caps() picks an eDP 1.4 LINK_RATE_SET index and
fills panel->link_info.rate_set, use_rate_set and supported_rates, but
msm_dp_ctrl_on_link() only copies rate and num_lanes into
ctrl->link->link_params. Link training builds its msm_dp_link_info from
link_params, so use_rate_set is always false there and
msm_dp_aux_link_configure() never writes LINK_RATE_SET. The rate-set
branch of msm_dp_ctrl_link_rate_down_shift() is unreachable for the
same reason.

Copy the rate-set fields along with the rate, pass them to
msm_dp_aux_link_configure(), and restore rate_set together with the
rate when falling back to fewer lanes.

Fixes: ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link rates table")
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 47647fdec..c8d097d65 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1596,6 +1596,7 @@ static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl,
 
 	ctrl->link->link_params.num_lanes /= 2;
 	ctrl->link->link_params.rate = panel->link_info.rate;
+	ctrl->link->link_params.rate_set = panel->link_info.rate_set;
 
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
@@ -1712,6 +1713,8 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;
+	link_info.rate_set = ctrl->link->link_params.rate_set;
+	link_info.use_rate_set = ctrl->link->link_params.use_rate_set;
 	link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
 
 	msm_dp_aux_link_configure(ctrl->aux, &link_info);
@@ -2407,6 +2410,12 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 		ctrl->link->link_params.rate = rate;
 		ctrl->link->link_params.num_lanes =
 			panel->link_info.num_lanes;
+		ctrl->link->link_params.rate_set = panel->link_info.rate_set;
+		ctrl->link->link_params.use_rate_set =
+			panel->link_info.use_rate_set;
+		memcpy(ctrl->link->link_params.supported_rates,
+		       panel->link_info.supported_rates,
+		       sizeof(ctrl->link->link_params.supported_rates));
 		if (panel->msm_dp_mode.out_fmt_is_yuv_420)
 			pixel_rate >>= 1;
 	}
-- 
2.56.1

