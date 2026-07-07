Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81480C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C5A10E2F4;
	Tue,  7 Jul 2026 17:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tk5g9gwC";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C388510EE8B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:52:19 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92e5b048375so202491185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783446739; x=1784051539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dKpLi/aSU1pvIw+0U5MiuZ/Ta5E2utuxKfUPqmuk/fY=;
 b=Tk5g9gwCieT7IKajcp/v9fubYIuImM2TLi3qw3AlCIxGGqk6TNnQK/c6Px6jB4hXuQ
 uOl88DITLb8YcqwLTxBojJxgRbTtZM0EbtEqjyi+uakWbm8POlBuoEfQnOPI/DUcgxzG
 FCXoc2B17uZ2RS024nQIIhzZCyseMlGK1LAxbdB+owlegfy6i7NNPcqr7ma7Hfmwyyx0
 jrGxEFmAkGPKzNXQsLhlZ2YP6buX29NpW7oRTcwEEbala7Li2GvFjeFEWdGUYgrvcjMt
 JFMnKDNdJqyH5OGaomJkkvWEA6byPlEzVVmL2khlcDzGrUOxQK9TcCZ+PTgBQ2eNOvxd
 8XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446739; x=1784051539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKpLi/aSU1pvIw+0U5MiuZ/Ta5E2utuxKfUPqmuk/fY=;
 b=FS5VsOBD6V6o4IvGmM54jM04U7dILyPStihKJlLu7RKl1Ffim4YYssDz2y5xrrRNQn
 zOFvj/cpj4SvoeMtOAfh/wAWB12/5OX3QeP6Nnxpggh0wxZ6zPEdRaWXixKK8yKRhakb
 9kMJBIQIX8SNd3nnvzhlb6AWdPVELj1qqTFn5XtMhnYJqgnBZBIbCDzj9+2C5pmtOMhN
 47zNOZX3NZp2YAKxPb4Jycv8W4Iaunw5eqXLokZkkXP3VaA9RqNGjHVPTI7pt7cq6UP5
 1qW5aqU21pKxUcAUVVJIhjmiB7WHS8o4idLSkIl79D4qOzA656szVQzkpctawBJ/HPdV
 H3xw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHUwGRX0MbPhmmtbwyh6LcggkgFZCTZY3wka5KdC3462xTBORjvzzhqE7kiKYxyZoyDZhtICzDgTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznxUcFCmuv3u5V66P/I96DEWktGSNl01UxTG6LRQZbOCbdk9yJ
 hfoR7lm8XcMcuGN85Qh2OnEWEdV+ZRxTM94G04b9uTIXZF2Qit5wv2wz
X-Gm-Gg: AfdE7ckRIMo2MfeOpzEwdsqMW5PmvkAnmlIHTtuKroFznU7lwC0J9Asj8zUYZqkTbSe
 S043D5jzfn1BsPdA5DzjuMJ9Yq+8KWorHFAZ2nE0t4z2dc6TwH6lnkpvWSfj9bCD0MiZVkvpmLr
 Nl/pxUKYI2Y7nrr+X6QEGxYLnLfqbHJZrRY3pgBDajBqig9MRUpggJApFD9YP8oGB+XL2rqvaFk
 0EJFxrVmFPW0H5AYJqQaFFzlVpgkjzco+3qVChq5Glql+2wZr1aWBImSdzuFKd+JBOr32gZdCuD
 MdmjZKETW4jw6mKL78GdMjulwvqgW3SoQMqKS711a0LG4OKeuuMy08bqZJfjyzoS+wBtte8RFoJ
 YBuz5W4+TJ20ZqqmMvnE77on4M6P2B6SZjkEbDxZBLPYU9zSmxXC/HXIsz7cej9BMgVZvUF0aqt
 FZ13PnCdHPVPJu3e6KHZhqVJZHZkZE6DgngP06OTktsR/9clsFX5BV1Yo19vqnPTHWbIx80Jbb0
 XYpxO3guEYcxgg=
X-Received: by 2002:a05:620a:a803:b0:92e:bd6f:b166 with SMTP id
 af79cd13be357-92ebd6fb78bmr488673385a.63.1783446738390; 
 Tue, 07 Jul 2026 10:52:18 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cfdefasm1229880085a.47.2026.07.07.10.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 10:52:17 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kees Cook <kees@kernel.org>,
 Dale Whinham <daleyo@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/msm/dp: Disable stream clock after video-ready timeout
Date: Tue,  7 Jul 2026 13:52:12 -0400
Message-ID: <20260707175212.412699-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
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

msm_dp_ctrl_on_stream() enables the stream pixel clock before waiting for
video readiness. If that wait times out, it returns without disabling the
clock or clearing stream_clks_on.

Route the timeout path through cleanup and disable the clock only if this
call enabled it.

Fixes: 9bd0946d5ca1 ("drm/msm/dp: simplify stream clocks handling")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..139e9fa25d6a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2469,6 +2469,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 {
 	int ret = 0;
 	bool mainlink_ready = false;
+	bool stream_clk_enabled = false;
 	struct msm_dp_ctrl_private *ctrl;
 	unsigned long pixel_rate;
 	unsigned long pixel_rate_orig;
@@ -2514,6 +2515,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 			goto end;
 		}
 		ctrl->stream_clks_on = true;
+		stream_clk_enabled = true;
 	}
 
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
@@ -2543,13 +2545,17 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
-		return ret;
+		goto end;
 
 	mainlink_ready = msm_dp_ctrl_mainlink_ready(ctrl);
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
 end:
+	if (stream_clk_enabled && ret) {
+		clk_disable_unprepare(ctrl->pixel_clk);
+		ctrl->stream_clks_on = false;
+	}
 	return ret;
 }
 
-- 
2.43.0

