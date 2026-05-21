Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A16FCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C845610F376;
	Thu, 21 May 2026 14:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RltEXwaA";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4769F10F371
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:47:04 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so6692718a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374824; x=1779979624; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2YtFavMCVSChLdyN1Eu3nk01mQaCAGqqLzhDnGc7Wo=;
 b=RltEXwaAdaX+sDRIYXJQNHKsJ6bNtLdv4FKayTIL/q36JfsEK2mFSff2NYdEWwfAUg
 uDrfnyXPiQoxkMjyybiP6AQRF96OamF1XDgaZvw8NmHtILlfnGiRO8TTe5x2ANr7QA+4
 3aMef/bLpczXpgmXLru29pwI74PiCOQaztdqnQ/JPJ8Y1YnUI7wRoLiMPjhyDkX38B9j
 6MucXwaUwmK5XTKWGSLndSPzlLgYV6uWdvTIVw4YctW/kdF1JzSkQiazHjiROjrepAE4
 fYO2raB7vbxWfg+OHcgBJRH11E03xfIVQYWRn8bV+keIVdXCJGl32DHFoOW224oGesmu
 KgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374824; x=1779979624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2YtFavMCVSChLdyN1Eu3nk01mQaCAGqqLzhDnGc7Wo=;
 b=fT6SjN7l+TRCa8Vf3uDxO72vQXTtJCl2qkMShA+vd1xTERjh6rq6H24y6e1cRG0lg3
 Prmlch6MjmLSvz4WDcBJQAPSBPldXeQzHdgJdB8cz6eCnqSNAeoRV3zHw5hdEL6GWg9l
 66Q88zENctsUfXhbk3laWjrPH7JYimIhrYkGtEspEPf0YTsqVV6GOazpxvTZKRHPVAmv
 9m+mqqiCMugJT6HdACHuh9dkG+q32AXDpsWzyuyTJx5xYiDyOhn906Ow7z3RODOgtPVR
 2pzkxNS1GeqqXvrj5WNZq1TYp0T8+gOW6eiwA0eG3+KWpXguzdbC5bXedDppCmIUmEFI
 m1rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9336Sfh1sl96N8+3+uNXXgI9JIfQgdhKiGem6Yt9NoqKBns90DP9ThZvcFklQ7YSjDNzTlm4coI14=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCNNORb+aec/F1Or3Xp6mI8Ncd1HBaFa5uYFufUG+vP501jgv7
 iGoxa6X9tmQdupFiKF2P1BPWkQS4C/ywP0HFt8swkQYS7LgWLEux9RrwNzqpgqDxzzo=
X-Gm-Gg: Acq92OFUuqAvXHBIlbzQifgya5VpR32CWj/z1j+xphPi2qkWdvLKJbx3NmZ/jQ7w12n
 beCeMZR6UT81SPxd51jGjpAvXOLBk5WFW8cfJy1Wm85MA60XKfnMPFtFa+Hcj26Es7y18k/nqCM
 +XqO+rKyYMfOWCZnvj4GW6muEvevEWXuuLEofdneIgEolbAP/6QcHI0MbY9V9LEYEZmtbGVzpWK
 02mktcxX4AF9bQrvaAGwzwlqDMpUo4PtdpPuc1hOhNiH6FIJbR2tclUvVYhm2HIIobFlzskjn3r
 3dofOTLfMbnVbdzdWEL0Zi5/Th1AZ7+YBgCiaKIlSjUUu5l5BvBVqTYQersPVZd/A903xFac8IY
 74AJu0YWSc7yn4ipDexXbVKViEpKJPYtUDzHXnHntrVx9mrz+8RryFHyds5nfDsxI2BQCH7TM++
 7TXXk3
X-Received: by 2002:a17:90b:2e4d:b0:368:b176:c5a8 with SMTP id
 98e67ed59e1d1-36a4560d3femr3288287a91.15.1779374823731; 
 Thu, 21 May 2026 07:47:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a11:3:200::109e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5bff3ef3sm476527a91.4.2026.05.21.07.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:47:03 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 21 May 2026 22:46:04 +0800
Subject: [PATCH v4 2/5] drm/mipi-dsi: Add flag to support dual-panel
 configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-sm8650-7-1-bonded-dsi-v4-2-a4dd5e0850f1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779374785; l=1347;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=mkr0K1mBT5RxN/+YTqKfY48rfoOCEL8C2meJua6xkiM=;
 b=5+BFUHgumhowsBls/J2rN2yIsZQXpzOQS6/+y+2Qz3iGix/P7ZytH3k3y+Mg9h5wKQaqlauaP
 LhU3lmKnCkmDIsEMKF+cgBAlPUlB8yMWgxQTqBhhZg4H5n/7FtZgOGS
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

Some devices treat two independent physical DSI panels as a single
logical panel from the CRTC's perspective. However, two separate DSI
hosts are still required to drive the panels individually.

Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
allows a panel driver to inform the DSI host that it is part of a
dual-panel setup, enabling the host to coordinate both physical
displays as one.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 2ab651a36115d..889ef1421207a 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -169,6 +169,7 @@ struct mipi_dsi_device_info {
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
  * @attached: the DSI device has been successfully attached
+ * @dual_panel: the DSI device is one instance of dual panel
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -186,6 +187,7 @@ struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
 	bool attached;
+	bool dual_panel;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;

-- 
2.43.0

