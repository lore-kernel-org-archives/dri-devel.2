Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8BC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41EC10F405;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVElntgp";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF6510E0E6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 01:30:42 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-380a02c71e2so1442932a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783387842; x=1783992642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ROUC3cgy4QtTAai8fuwZ/i9UUpJYp/TQoiTouEVN0vM=;
 b=QVElntgpoDCUVqIKAGiaNdNA6M0S7TEf7MV+EgU3aEw5UZgpldrxN6HakAvztA+JYu
 tEB/vyDejWKdpa3b7d+V8WFLzXv8z2HO5/F4cBQTuM/LsB3JKtzOSMoaATxGRahY5x/E
 CjOyg9jEqpAVWxIjkaKlQIBjdvTE8Gqo0UG1An9vwpbS0IJYeeq3GgnPLdFPkZfzCqY7
 8mDZV9kfMwC7jOZQR2eyOlTe13ovMIM1hIF3k2Pa1HW09Gq4ZVtcyQuOSFR/sIzYcs4t
 MRwci4vI0LdUdb/EF9B/1jRsHvi+YAmdmWmHf7cNYqQiwN2OwlP5NFOdy3Aju6vqqz4Q
 i9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783387842; x=1783992642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ROUC3cgy4QtTAai8fuwZ/i9UUpJYp/TQoiTouEVN0vM=;
 b=jvCyPhFYybgSxDoLJjjnhjTe5zwAMa/QqvgFP1jQatt+9kFXASzyeuGIyXZKh1eSzo
 x0bGqqMVGnLr7imZq9UNIpk9RjHw9SteRU/LKb5SqiU2vkOC5diMdS2VTzieNuxxKrmT
 ypd/+2+F8Ql/82v744au2iqnFurGSjG7IaN0//dEcJqp5Uh9dbfYGsLR5Q+sI1sRdXrF
 7Yh0TaCGi24A2Ob3pgl5hGsKbuGNo0JsxF7jmLU78kbR9CqKDroxtC0Aqnj/0es08iI0
 7BxjJOWWdEMgJHdM8RYWJEu32c7r/hWVtwgmjiwQaBxw9BUga2rrWNj3tKZYv5U1OGK1
 +hOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWG5EmEOhqIi115lDgH3MjVlDdhbVZq2Jf4RkpZV5olwriz0yr7Kc6b0piBC/wpyyFUr54pODLE04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMib4GaQ1eWwFiTv8qeQpZcjIm6fWpzYgLjO2sxB+yNOvKejWp
 TytFq7QxlTmMSn/HVqOJsARgrg2oaq8QuDOgVR20UkTa4w3lRBiD8hFM
X-Gm-Gg: AfdE7cmgLMI+EkrGlmO2iFWJ2NyQ+xzcpA2FEJcJzVTa+usQJi7WwjV+DIgaeyo77wJ
 2usemSKegkjygSGOZ0XDrELfjk3Uo6I4pgzq0BFjrS8pu+OqAfpi5/kQuLasiurWUIuRPDrrsPM
 eqNzwgTs0oFXEQUPYr9soXKdJmNz0HlLilpCBG9c8kF6POXtseU30UPKI5BcArWM2MhRKok2Y8n
 bYo+Vz06Tzt4EJTIrS5+IL7w0CzDqR2+rhOzvW3GAhZcVYw0Et2OtdoMDPMH8KfZJGreAXU/otU
 T++OQ7yoildVYOTclHZxdbHAgFMGE1uZzqZW/GG7ZCyqk3ye42c5gsFXdAPDsGRIh+RFEXl68Jy
 U3ieSUMZf+pQxC1iMfmm4MoVt02JXgfLuduOPwLsAIXfLWNGhAr3a2fL1u7CNbHxdpMxRjgGGFx
 y3tyw/w5OgRzja+SfND1rkd7MSFolVZQ==
X-Received: by 2002:a17:903:41cf:b0:2c9:e9ef:bdd9 with SMTP id
 d9443c01a7336-2cccad90e8cmr5468245ad.7.1783387841900; 
 Mon, 06 Jul 2026 18:30:41 -0700 (PDT)
Received: from kavandesktop.local.lan ([50.46.174.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e279sm2653435ad.45.2026.07.06.18.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 18:30:41 -0700 (PDT)
From: Kavan Smith <kavansmith82@gmail.com>
To: robdclark@gmail.com, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com
Cc: sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kavan Smith <kavansmith82@gmail.com>, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the
 PLL-achievable value
Date: Mon,  6 Jul 2026 18:32:40 -0700
Message-ID: <20260707013240.681012-1-kavansmith82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706180753.408753-1-kavansmith82@gmail.com>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
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

MSM8916 runtime DSI commands still go through
msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
enabling the link clocks. That is fine in principle, but on DSI 6G the
requested byte clock rate often does not exactly match the DSI PHY PLL's
realizable rate. For example, the driver can request 56250000 Hz while the
PLL actually runs at 56246337 Hz.

Because the requested and actual rates differ slightly, every later
link_clk_set_rate() call is treated as a real clock change and re-locks
the PLL. On a video-mode panel without an internal timing generator, such
as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
command, including backlight writes.

Fix this by rounding the computed 6G byte clock rate up front, before it is
stored in msm_host->byte_clk_rate and reused by later transfers. Once the
host carries the PLL-achievable rate instead of the idealized one,
repeated link_clk_set_rate() calls become no-ops in the common clock
framework and no longer re-lock the PLL.

This keeps the normal transfer callback sequencing intact, preserves the
OPP vote path in link_clk_set_rate(), and matches the fix direction
suggested in the original 2018 discussion.

Reported-by: Daniel Mack <daniel@zonque.org>
Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
Cc: stable@vger.kernel.org
Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index eabdaa4..5119862 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -603,12 +603,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 {
+	long rounded_byte_clk_rate;
+
 	if (!msm_host->mode) {
 		pr_err("%s: mode not set\n", __func__);
 		return -EINVAL;
 	}
 
 	dsi_calc_pclk(msm_host, is_bonded_dsi);
+
+	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
+					       msm_host->byte_clk_rate);
+	if (rounded_byte_clk_rate < 0) {
+		pr_err("%s: failed to round byte clock rate, %ld\n",
+		       __func__, rounded_byte_clk_rate);
+		return rounded_byte_clk_rate;
+	}
+
+	msm_host->byte_clk_rate = rounded_byte_clk_rate;
 	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
 	return 0;
 }
@@ -2056,18 +2068,7 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 	 * mdp clock need to be enabled to receive dsi interrupt
 	 */
 	pm_runtime_get_sync(&msm_host->pdev->dev);
-	/*
-	 * Do NOT re-set the link clock rate when the link is already up and
-	 * streaming. On MSM8916 the requested byte-clock rate never exactly equals
-	 * the DSI PHY PLL's achievable rate, so clk_set_rate() re-locks the PLL on
-	 * every command. For a video-mode panel with no internal timing generator
-	 * (e.g. s6d7aa0), that clock glitch makes the panel lose pixel lock mid-
-	 * scanout -> ~1s of displaced/wrapped image on every DCS write (backlight).
-	 * The rate is already correct from power-on; downstream MDSS only refcount-
-	 * enables the clocks here (CMD_CLK_CTRL) and never re-sets the rate.
-	 */
-	if (!msm_host->power_on)
-		cfg_hnd->ops->link_clk_set_rate(msm_host);
+	cfg_hnd->ops->link_clk_set_rate(msm_host);
 	cfg_hnd->ops->link_clk_enable(msm_host);
 
 	/* TODO: vote for bus bandwidth */
-- 
2.43.0

