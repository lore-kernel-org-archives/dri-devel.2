Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE37CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07CF10F3EC;
	Thu,  9 Jul 2026 07:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qQg7Wrhf";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED1E10EA35
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:05:49 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caf18d4904so1862625ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783361149; x=1783965949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CBwDpfgatM4P1+rNlaJNEBnJH772jVzISiyjiBJelCY=;
 b=qQg7WrhfwkVwjx3Eswwvrm4toVvaadyWnbNGys6ZNAARyOfY0IFP8cYTiQIv4DwyCx
 kZ3M6txPXP+g2/XrqCr+mxSke2X0/z1A+ak2Sz5UM9WChZyjSAOHbpdkYVXf6B4d7uyT
 nTZhX08sMZZA9Ao6gjVs3ZiOEu9KbJRDAa1tyMaJh3vIb+3rwLgD3ytXYjOHTKt1+UJf
 vtgGbrSVGgbtcd88cTl+4pf6JFI1lpeFp5DaRnNc7JBPJVAl7nGaVW9Bmes4x3NhZ7Gn
 Hklj0vkE0XSUVPj/7xbn/cnCTmrew118/v4FZpT/pYszOqnfTna9fXd0VsMgkQv7CQtS
 +QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783361149; x=1783965949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CBwDpfgatM4P1+rNlaJNEBnJH772jVzISiyjiBJelCY=;
 b=eUWhbpmTFiqzUaL693eLLbVhmKirJBL9RXO8PVTzcJaG+8TFld/QOAsnVdLYERZcLJ
 5u74dM48K/E6cPU+ooklqwws4g7LegTZdGD5WU2P8WWKJ/wLWCZMNh4hEb+g16Aua7C7
 qiQdhzUG13pSMFZFAtNps/yuHLG/cFWLxkQEpJX5kaGWG89foRc0tn1U6FhIbTRpSsY0
 S7qVw9Dkp38LbZCuSE4fyt8u+V2roLaFQn19RyqAwdXWJsGbd2EbC5LIJjrekfHoHTYY
 VRzb6ZWooWoGzJAm9RA+kAbhMS/+wTsDrTJH1uQ6U/1+SP2/ahPwsfb1RpaAKnMfspIH
 MAew==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvbYjE8APh/ZKyoziz/J00YMTw9wddsfjg0Z7viUN18euU87RxzuA+mTPzTekwL62mk1R+L17Aw9I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzglLn0RaLXtRteInTjmeMbL09SMY5CZTdloenUVThpm2pxn9CE
 DzI/JESuPL883WMRTClguP3iZvGCEp7Y1tKgbwzFPrCP4vpjWWqrWoPp
X-Gm-Gg: AfdE7cmC8eEUPVNFYHRrF7to74HqJ+kRPQ1cjRxCtjTDxMfM5b6S4cltn1+O2tEn9/t
 rMtzhwavLzg0GYi+wy8WKo8A07CRprNqjOFWlLBct6tpj/vNAKyc2eSY5CyGp2rmcSr7Edwlwaq
 eoGhzicml6AzC5wdB4fjrnyjHT5G72vOQOh+5F3WgUZRde4at9kwCL8ARjHEFeEbvcMhalnBODO
 udYUT/rIBo4Fp63nYBUjU6lAu4I27EuKXUthnL7mU3/P/vngFZlTZSDDJdGOGq13s379XfFPMbg
 eL+0orrbKok0VucLi4EZSiUc1rpUhB6dcIwSpqXCFffRW4OEApv2xj1zjX0fyNDffTh4W5Em+UV
 hdYFxkOFbwWI5KCBmqGmChdSw+gYEEqeK08ywdAck+PF9RHBZkqvkNLW1zO5gRmLPNMGYewz52n
 jqLgmuN6Gz0ALdQo3b0dGRNJ3ALh0uZw==
X-Received: by 2002:a17:903:18c:b0:2cc:6817:d9c2 with SMTP id
 d9443c01a7336-2cc6817e7c9mr60828115ad.4.1783361148922; 
 Mon, 06 Jul 2026 11:05:48 -0700 (PDT)
Received: from kavandesktop.local.lan ([50.46.174.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7765789sm55875995ad.41.2026.07.06.11.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 11:05:48 -0700 (PDT)
From: Kavan Smith <kavansmith82@gmail.com>
To: robdclark@gmail.com, quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
Cc: sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kavan Smith <kavansmith82@gmail.com>
Subject: [PATCH] drm/msm/dsi: don't re-lock the PHY PLL on every DSI command
Date: Mon,  6 Jul 2026 11:07:53 -0700
Message-ID: <20260706180753.408753-1-kavansmith82@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

msm_dsi_host_xfer_prepare() runs for every DSI command, including runtime
DCS writes such as backlight (MIPI DCS 0x51), and unconditionally calls
link_clk_set_rate() before enabling the link clocks. On MSM8916 (DSI 6G
v1.3.1) the requested byte-clock rate never exactly equals the DSI PHY
PLL's achievable rate (e.g. 56250000 Hz requested vs 56246337 Hz from the
PLL), so the clk framework treats every call as a rate change and re-locks
the PLL.

During video-mode operation the byte, pixel and byte-intf clocks are
already running and feeding continuous scanout. Re-locking the PLL glitches
that live clock. On a video-mode panel with no internal timing generator
(e.g. samsung,s6d7aa0 / lsl080al03 on the Samsung Galaxy Tab A 8.0, which
regenerates its H/V timing directly from the DSI clock lane) the glitch
makes the panel lose pixel lock, producing ~1 second of displaced/wrapped
scanout on every DCS command. No FIFO underrun or dsi_err_worker error
fires; it is a silent clock-domain glitch. Stock (downstream MDSS) firmware
sends the same 0x51 with CMD_CLK_CTRL, which only refcount-enables the
clocks and never re-runs clk_set_rate, and does not glitch.

The link rate is already programmed at power-on by msm_dsi_host_power_on(),
so skip the redundant re-set once the link is up; init-time transfers
(before power_on) still set the rate.

Link: https://lists.freedesktop.org/archives/dri-devel/2018-April/172218.html
Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2170,7 +2170,17 @@
 	 * mdp clock need to be enabled to receive dsi interrupt
 	 */
 	pm_runtime_get_sync(&msm_host->pdev->dev);
-	cfg_hnd->ops->link_clk_set_rate(msm_host);
+	/*
+	 * Don't re-set the link clock rate when the link is already up. The
+	 * requested byte-clock rate rarely equals the DSI PHY PLL's achievable
+	 * rate, so clk_set_rate() re-locks the PLL on every command; for a
+	 * video-mode panel with no internal timing generator that clock glitch
+	 * makes the panel lose pixel lock mid-scanout (~1s of displaced image on
+	 * each DCS write, e.g. every backlight update). The rate is already set
+	 * at power-on.
+	 */
+	if (!msm_host->power_on)
+		cfg_hnd->ops->link_clk_set_rate(msm_host);
 	cfg_hnd->ops->link_clk_enable(msm_host);
 
 	/* TODO: vote for bus bandwidth */
