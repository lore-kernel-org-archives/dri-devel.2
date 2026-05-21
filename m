Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C107CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC0510F365;
	Thu, 21 May 2026 14:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j+mCSAwR";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99AA10F365
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:47:16 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-369576666d5so2903391a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374836; x=1779979636; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9BURsh5NYMbwKkwuyMPazevtClBiueqRU9O2y7rbG4=;
 b=j+mCSAwRrsMGiZZ5337+WBOqQBRgW4ulmiK0LJ+sCmq1N+7n3axSajW6rf8davLUJ0
 D2KStM50yhpS3ovyAwek6H4TqVHqfPl6XiqXPs7PGhLWi0LiIpA2firUkZOr6FPRIHrK
 3xl2IjSkQ216+5M5hScNwkFAhQlYmYKbgexdk2MoS/N5Vq422pg08Jl2vqbKMjS4RUIq
 haVvemYh/nWV/SfG+ShsRnnwyPquOXLbdCqCfeMSRUQIqLBAFQX5rZUoEg6ilRfvpxgr
 yuJdjRDkpM9kDnzMLpH+Z5u15NaiPQug8JTpmjjjGaEyPcNqGN8jJuUnZT4Mfn75d33k
 n1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374836; x=1779979636;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n9BURsh5NYMbwKkwuyMPazevtClBiueqRU9O2y7rbG4=;
 b=c92CKVyDTpGhCiBjpcoFkPTzrQlViGxtbA5q+Qz4l7e8c/h9+jFXMgfb7HDfeM+7Dw
 LbR69PIyQPW8v/flvsTPOH2crjlKJ0fb/ZcanxvWzxEfJ9nJSfFUEwmDhnwXTKsRqaFq
 Qj5biFBV+/VZRxOpeCfoyA/OB1UJeTtan9nrWPEWojZ3bJ7TcQoKZ4uKs6l2LWsF/90I
 36JH+RZ8WryxvCib2nbBNXRLnK1Wxep/6T4hQnHmk6eQfjX6wqUx7w0Drlp3p0WLqp/c
 9aXark+SGYBFEK7B58Q2aPu2pZCUrbB54og5ytSl3lYesye7qbDV9Q7bYc70XrP6bl8A
 3D1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jzs/wgCIAB3/d5Ovd4BhDvUCsBoL2kMsJdScKiKO4NE8NvRJwDKcRpjEhDe1tzZSZmE168Fxn+Ug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxW8PTh3AeR+CQAF7fA6PjHBQZXZOwpgUfmQa+HB+169LKcq4A
 xxsYxGwvn2glD9uLC5Jpvq0/LdgVrMf7gFRf/fYO6zJGYCX4C+lQXft+W4KANNrGV8Q=
X-Gm-Gg: Acq92OFuyG68TyFfAydrjp4OPwfZi19KoncThfplDHyb8pTQJi+Y3+3vC8PHnTZoCuZ
 D+FIx0c9i3TrlOmHJBvktFajYCzBjzMFRw6SH1bS6hQIxvvfqBVvoXbhVxnoyd8gkGPavkpPH0O
 Xaeqen3Iy+Lo+pevKhrfv2WDwF8NMRRPcB+2AlUe/xEx23rkiLqReIi36HdWrP38CUbZK5ILgUu
 G5n+a2j1jUdJsmmsIrNjrMFfAYs8oYlntFP+WNv6qNk6uRwcPnMgLngHlUxkp2onnsGCChzoHhG
 rEkMGk9U7WOkiibgMyUnK2huiFpOk3XCc3w4OGWqM/uML7r2fWy87kwM7hNVCaahhOp91jOdKZU
 pH1SKJi5MDv1T13BtjDu1MzeK6zZ4QiNl28z9QosIBv6QE3KKHNOWGDvVvUMiRp4V3+nRnbCWDC
 5nzP8k
X-Received: by 2002:a17:90b:3d4e:b0:35f:b7f5:9cd with SMTP id
 98e67ed59e1d1-36a4563db18mr3294883a91.20.1779374836085; 
 Thu, 21 May 2026 07:47:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a11:3:200::109e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5bff3ef3sm476527a91.4.2026.05.21.07.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:47:15 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 21 May 2026 22:46:05 +0800
Subject: [PATCH v4 3/5] drm/msm/dsi: Support dual panel use case with
 single CRTC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-sm8650-7-1-bonded-dsi-v4-3-a4dd5e0850f1@linaro.org>
References: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
In-Reply-To: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779374785; l=3355;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=KnQNWhFGZp33dCjq6OXiRZfhx2zq6YDbC/BM4AvYDFo=;
 b=nMdcNoK7/z8Uvsq3qZxzJYj4k6T+yPZNRjhZ4FVWWK4hodIv7ywVAZaXqYzqN6eh4rNaL0DUK
 4O0zFdXVKxcDx+0rHZUOJMKzSINWRX6pZDrVJ97WSdEdwIz1gI2bbTY
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=
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

Support a hardware configuration where two independent DSI panels are
driven by a single, synchronous CRTC. This configuration uses a bonded
DSI link to provide a unified vblank for both displays.

This allows application software to treat the two displays as a single,
wide framebuffer with a synchronized refresh cycle, simplifying rendering
logic for side-by-side panel arrangements.

At the DSI host level, the frame width for each link must be that of an
individual panel. The driver therefore halves the CRTC's horizontal
resolution before configuring the DSI host and any DSC encoders, ensuring
each panel receives the correct half of the framebuffer.

While the DSI panel driver should manage two panels togehter.
1. During probe, the driver finds the sibling dsi host via device tree
phandle and register the 2nd panel to get another mipi_dsi_device.
2. Set dual_panel flag on both mipi_dsi_device.
3. Prepare DSC data per requirement from single panel.
4. All DSI commands should be send on every DSI link.
5. Handle power supply for 2 panels in one shot, the same is true to
   brightness.
6. From the CRTC's perspective, the two panels appear as one wide display.
   The driver exposes a DRM mode where the horizontal timings (hdisplay,
   hsync_start, etc.) are doubled, while the vertical timings remain those
   of a single panel. Because 2 panels are expected to be mounted in
   left/right position.

To maintain synchronization, both DSI links are configured to share a
single clock source, with the DSI1 controller using the clock provided
to DSI0 as below.

&mdss_dsi1 {
   assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
		     <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
   assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
}

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index d14b6e41dcd90..4d7ac01aa393d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -186,6 +186,7 @@ struct msm_dsi_host {
 	bool registered;
 	bool power_on;
 	bool enabled;
+	bool is_dual_panel;
 	int irq;
 };
 
@@ -1024,7 +1025,10 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			return;
 		}
 
-		dsc->pic_width = mode->hdisplay;
+		if (msm_host->is_dual_panel)
+			dsc->pic_width = hdisplay;
+		else
+			dsc->pic_width = mode->hdisplay;
 		dsc->pic_height = mode->vdisplay;
 		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
 
@@ -1705,6 +1709,7 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
 	if (dsi->lanes > msm_host->num_data_lanes)
 		return -EINVAL;
 
+	msm_host->is_dual_panel = dsi->dual_panel;
 	msm_host->channel = dsi->channel;
 	msm_host->lanes = dsi->lanes;
 	msm_host->format = dsi->format;
@@ -2596,6 +2601,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
 	if (!msm_host->dsc)
 		return MODE_OK;
 
+	if (msm_host->is_dual_panel)
+		pic_width = mode->hdisplay / 2;
+
 	if (pic_width % dsc->slice_width) {
 		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
 		       pic_width, dsc->slice_width);

-- 
2.43.0

