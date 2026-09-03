Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F6FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEF810E61E;
	Thu,  3 Sep 2026 14:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iqKMlVC2";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DD210E123
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:30:33 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so2683010a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788445833; x=1789050633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VvQUB0nrb39Z1KnOkiEgTk3LEVt0IMBJ5IPyGGTW/6M=;
 b=iqKMlVC2/aMAckB8FRkRungEMOJHEv5R6u2CKpFQkKHSha6563w/Bfthenxy0kXt14
 tZIUbjB5uusw+3f7pIj0HySlOQKqr3RlbHUS9pn43ok9cakiYEeRx+lNio8kTPcv/FJX
 nN2SPvSYJKi1P7jrJL+VcrhvIMbbqqjO8dhL8CT7i40mLxdSe9QOQJ21xauuhvYkj0CO
 tC6qXSXbMQPwnpT/YxHQa5qv32zJ3B9EprFFApitRFWBwsb88V0AKFmHHpbx0pDfSQce
 j4r/jZu4I2TpZDNOscMgiHZxhJq6/DRKmr598wR8EDQbmHDCKUCXHOuMbr/edCPT2O+K
 2FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445833; x=1789050633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvQUB0nrb39Z1KnOkiEgTk3LEVt0IMBJ5IPyGGTW/6M=;
 b=swKJfNOR8tbw3Ox2Mq4OBS4KOCQZAKhc/yLJtVfQJ5vPx7vPUb+4/tT1TrveJBDf/f
 P4KKvWsy7XPd2BT79979MSotN3S72sPJiPzxg2fQweDnJGzF0irbWiXL7oZgrQSEClae
 I5Kj81jNUGvX7bKNPwIUFn/a4kXHVOBqztnJGdLBT19Vs/4vh7RS8vkRjsJA3mgz3guD
 JFt/NjxekLWjPBzoDw73D0YtHxhwmH3DTK4AwO547Hq6UU4je+88yg+p8YsCY1nv3LM2
 nujD+2KFUvPXnHWwZLiPIQpA1+W3FGHVLfY165J1GcnJLzrE6zNzdTs6b8b9K9f/8GQL
 N5zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIQjKblkF6UYnZJ4/KQS6SuOYEHf6XO5QOAuc3e0xpA3NiAC1j6M7YMFP48IwmqIJyfHJJEmZ5pUY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k6zI5fqwjX4cKkrBMwF3d+Y6sQDuKfANFaDHCUomDZ6j5wG8Zp
 6duFQIqb6efXHa6OsKG7YqhUP/pmLO9bl97Az7EZKiNS4I6h9m6FJE5cD3gtSWwtycU=
X-Gm-Gg: AYBFou0raN875+VeLpG4Okz1jLl883lmfD2dIAwaybNMVieO+4vmCJms73MwNFvXWd4
 NRhz2Q05uYVl+IdWylXMk3smjjI33Bc4Lw7WQPqlutBcST5uHoamWnsqweJbUIyk+UCLWMV6Wf1
 nnUIsVFg12e3HwE70bJdoldVGyxJh+FhSpLIpOKvMv0w4XI20NJrnORciK4NB1oYG+qeMLUVoql
 oZZXuIwPFPx0DSmt4eyXJJtekqYwu/wPuKc9qNi0z2xNLnRSW1ZBE5hh/Qg+k20UJ/PE8/V7MvS
 impMsmG7EaVOmyE7iuk3TfAuQr5tVw10InrTa6+HAkBAOCTVVyMWw7tGEUjqX8dQgfUvZMPuSfa
 oqMjx1T6SZrPmD6YRtHM5HGQStUU6ZwZzJkinXlwz0gp8I68wgpei40VL72/gclDHQUt8ixTlG1
 dh5OzQ3mImS8kH2Ugwzum9cxjbdBYmcM8mgSGli8phgmM4FQf8v007Pcc=
X-Received: by 2002:a05:6a21:4613:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3d9af9ff7a9mr20557828637.13.1788445832582; 
 Thu, 03 Sep 2026 07:30:32 -0700 (PDT)
Received: from niej-t14p ([112.64.60.233]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc43d42b3b1sm1032759a12.25.2026.09.03.07.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:30:31 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
To: 
Cc: Jun Nie <jun.nie@linaro.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, Maxime Ripard <mripard@kernel.org>,
 Teguh Sobirin <teguh@sobir.in>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: delete timeout timer when encoder is not busy
Date: Thu,  3 Sep 2026 22:29:42 +0800
Message-ID: <20260903143004.1026181-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.53.0
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

There is a spurious timeout error message under the following reproduction
steps:
1. Run "modetest -M msm -r" and press CTRL+Z to pause it.
2. Run "while true; do rtcwake -m mem -s 3 -v; sleep 2; done"

Resulting error message:
[  124.018206] [drm:dpu_encoder_virt_atomic_disable:1425] [dpu error]enc35 timeout pending

dpu_crtc_commit_kickoff() calls dpu_encoder_kickoff() to set frame busy
bits, and then arms the frame done timer. If the frame done IRQ fires
between these two steps, the IRQ handler clears the busy bits before the
timer is armed. As a result, the timer runs with busy bits already cleared
and is never cancelled by subsequent IRQ handlers, leading to a false
timeout warning.

Delete the pending timer when all busy bits are cleared in the frame done
callback to prevent false timeouts.

Fixes: 95bbde1d0d07 ("drm/msm/dpu: Start frame done timer after encoder kickoff")
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..d83d38797331 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1573,6 +1573,21 @@ void dpu_encoder_frame_done_callback(
 			| DPU_ENCODER_FRAME_EVENT_PANEL_DEAD)) {
 
 		if (!dpu_enc->frame_busy_mask[0]) {
+			/*
+			 * dpu_crtc_commit_kickoff calls dpu_encoder_kickoff to
+			 * mark busy bits, starts the framedone timer next.
+			 * It is possibile that irq happens between the 2
+			 * operations. Thus timer is running with busy bits
+			 * cleared by irq handler and timer will not be deleted
+			 * anymore. Then false timeout introduces unnecessary
+			 * confusion and visual defect.
+			 * delete the timer here to fix it.
+			 */
+			if (atomic_read(&dpu_enc->frame_done_timeout_ms)) {
+				atomic_set(&dpu_enc->frame_done_timeout_ms, 0);
+				timer_delete(&dpu_enc->frame_done_timer);
+			}
+
 			/**
 			 * suppress frame_done without waiter,
 			 * likely autorefresh
-- 
2.53.0

