Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC42FCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C8210E1B2;
	Thu, 21 May 2026 14:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CEEymA5K";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A7A10F349
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:46:52 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-365eecc5885so5686641a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374812; x=1779979612; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Asp0zRkS+UgWcG9vl0amstXfnHnSp8pf6SKHURGIe3E=;
 b=CEEymA5KxeLYW3FgnkmqZrKhepUTLjmnyBzCrLALE55b8COT5DxGGBPlvkJtqiaF7z
 AkbltNsjybf4wWo3FMPTCo+IjJRtRcIxw++5FUuJ1UDbhdbk+PohndS9UqmY4IVfoRuA
 bLUpqjUC6r1w6h9dmxlo//rRXJXvA9kSTjxjy2Dr7tkhNRV9dUli/lrb6WjwrOQrRIKv
 uA1mdUmYPb5DXmPbPPs/HOXCDmzbukIcYKYdaBg33uzVwgKjdYeiBQBYdV6PHpQXNASO
 Qkr7f3y3K/XMgDAGn0sYDfgYErC1a/zv4WWjzzxQ38Yq4MMwj/fL8CPF78m2YkDKyw7H
 tPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374812; x=1779979612;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Asp0zRkS+UgWcG9vl0amstXfnHnSp8pf6SKHURGIe3E=;
 b=FSYiElTtnXhp+8x8vEaDnHJTWrysrYfx9ESJXc4w5BGrgfLFkvMkleoFiDBo2vqpac
 oJx+CM2Z+WAcogs6+f/l1e+trI3GS76yLpfYQ5WXEmzbfl1/Ckm7nCzB2zG80euKAutR
 2huNYs6VqsE4U/OEj5w+UjnBsCVJydsct+Nmrq+b00xKtFS/PQQvpT5A+jrkIUvphrxq
 X27b/Yjy84IwSrsyGdh5u/7HrU/1KNe2BM9lFsMRHj7izh9poMy/W0dNG4PVH2CqL1Z2
 PVLm0VAc6jJ2qxY7PZ1aMvO9qiRXyXVF154aBEsoqXV4kbmsVraQX3pqQzJUlYnx1aAM
 g/zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q2+tJmTUsyBo4ua6wRkw4AJzZccFJkrLcMGFa8XBpsNRFbtwoTasR2YVbDCvycRGYH9XYSY76ulY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR26oiEp3aX+L4+597EVSGygRUDi60nrxQSmw4tnZ9bmSOJCRr
 9Jnfk3oJe0hKRNzwiNtTbMH8ejgBQTE9dy/uwSLsw0D+ywpQ/HB1ExCvM+bkVSsipw0=
X-Gm-Gg: Acq92OG7tRZZ8laoC1oZ0yQy6mCmgsTkvXAZgEMFgR2Do8SZRa6CBllg/otcdA/Jb9U
 5L6iwLTMqvDeYRG49XlZYTamQ/nQ37JUVHTC/hg4zl6yQEkGXJdFVIlU24K4xfytywX3e81ZrFt
 vqfJUccyHKKNzja64riI0uecIvKrmK+MXZbv/GxaB9ChVYt3UtgEkAc04/9IhSZEw7DcXMJqNoZ
 5dmLPBkpUqcwjDH8loGAM/dhBxW7pJrWdEkXSuwrS9fI4bV/QT9HqqqT9Tc4gEuGQBgtX8bX1mw
 0cY3TD/eC/W2yhWU0Nqwba8eAJwHmFQ6ehcsyv7UI4H+LzuXQRKDfbOisOnIz5g1V2/xg+7p8rO
 o42DMrGKiwODM+JEBEQU0IuduERtbVChbEmg8GsnZuHwPeXb9Ab9Xce4GuhNMKLhih0Fmzw==
X-Received: by 2002:a17:90b:4d90:b0:369:a359:b192 with SMTP id
 98e67ed59e1d1-36a45182255mr3160061a91.10.1779374811479; 
 Thu, 21 May 2026 07:46:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a11:3:200::109e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5bff3ef3sm476527a91.4.2026.05.21.07.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:46:51 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 21 May 2026 22:46:03 +0800
Subject: [PATCH v4 1/5] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-sm8650-7-1-bonded-dsi-v4-1-a4dd5e0850f1@linaro.org>
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
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, 
 Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779374785; l=3578;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=aKBFRzOSRxcJ4Txy7/kSLmugaeZPSeJFq/bdVBQc+E4=;
 b=Wb/XYoQvQLih10uVNXcXtJ4LZNf+eFEbM7cw4pN8fli1pFCMy5LBN6yWHkEoV97Q5lKtduYI9
 X6o8VEoodRuCd5YUgeeZytLQm70SuYHzEPnrd/eeA/zt2jfLHQfajIa
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

Some panels require multiple slice to be sent in a single DSC packet. And
this feature is a must for specific panels, such as Sharp ls026b3sa06. Add
a dsc_slice_per_pkt member into struct drm_dsc_config and support the
feature in msm mdss driver.

Co-developed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 23 ++++++++---------------
 include/drm/display/drm_dsc.h      |  7 +++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 53ff23f4f68ab..d14b6e41dcd90 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -166,6 +166,7 @@ struct msm_dsi_host {
 
 	struct drm_display_mode *mode;
 	struct drm_dsc_config *dsc;
+	unsigned int dsc_slice_per_pkt;
 
 	/* connected device info */
 	unsigned int channel;
@@ -938,17 +939,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	slice_per_intf = dsc->slice_count;
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
-	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
+	bytes_per_pkt = dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt;
 
 	eol_byte_num = total_bytes_per_intf % 3;
-
-	/*
-	 * Typically, pkt_per_line = slice_per_intf * slice_per_pkt.
-	 *
-	 * Since the current driver only supports slice_per_pkt = 1,
-	 * pkt_per_line will be equal to slice per intf for now.
-	 */
-	pkt_per_line = slice_per_intf;
+	pkt_per_line = slice_per_intf / msm_host->dsc_slice_per_pkt;
 
 	if (is_cmd_mode) /* packet data type */
 		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
@@ -1104,12 +1098,8 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		else
 			/*
 			 * When DSC is enabled, WC = slice_chunk_size * slice_per_pkt + 1.
-			 * Currently, the driver only supports default value of slice_per_pkt = 1
-			 *
-			 * TODO: Expand mipi_dsi_device struct to hold slice_per_pkt info
-			 *       and adjust DSC math to account for slice_per_pkt.
 			 */
-			wc = msm_host->dsc->slice_chunk_size + 1;
+			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt + 1;
 
 		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
 			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
@@ -1719,8 +1709,11 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
 	msm_host->lanes = dsi->lanes;
 	msm_host->format = dsi->format;
 	msm_host->mode_flags = dsi->mode_flags;
-	if (dsi->dsc)
+	if (dsi->dsc) {
 		msm_host->dsc = dsi->dsc;
+		/* for backwards compatibility, assume 1 if not set */
+		msm_host->dsc_slice_per_pkt = dsi->dsc->dsc_slice_per_pkt ?: 1;
+	}
 
 	if (msm_host->format == MIPI_DSI_FMT_RGB101010) {
 		if (!msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR_6G,
diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_dsc.h
index bbbe7438473d3..c522ab3d71853 100644
--- a/include/drm/display/drm_dsc.h
+++ b/include/drm/display/drm_dsc.h
@@ -267,6 +267,13 @@ struct drm_dsc_config {
 	 * Offset adjustment for second line in Native 4:2:0 mode
 	 */
 	u16 second_line_offset_adj;
+
+	/**
+	 * @dsc_slice_per_pkt:
+	 * Number of DSC slices to be sent in a single packet. This is not
+	 * part of DSC standard, and only used in some DSI panels so far.
+	 */
+	unsigned int dsc_slice_per_pkt;
 };
 
 /**

-- 
2.43.0

