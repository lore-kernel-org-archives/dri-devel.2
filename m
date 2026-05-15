Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DFBCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7B010F401;
	Fri, 15 May 2026 06:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jajd9tvH";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39F810F401
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:47:31 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso16045084a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778827650; x=1779432450;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFZWV2maLWNy5VxQx4iSODLa/p/3Y1D+RuJl/0PViCQ=;
 b=Jajd9tvHIiqwjliL/JlX11qgHl2n+FydjsqgEPXxm0eG6oO5LO+C+FIt5JWP+sVpRO
 C3gTPY+nniTTs++ZrNG5IzBajygwefosDatVMqFNcYpZY+mUqotLeVKgQviL2lJWYIZG
 /rfAd5wGyGJsj9a00p44aOyAAuz4Z0DbaNz2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778827650; x=1779432450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sFZWV2maLWNy5VxQx4iSODLa/p/3Y1D+RuJl/0PViCQ=;
 b=K7W+YFuGPmmKQ64tN9f1OY0UecVeq/TPCzMAuIdMedJzp6dFz1i4Htgr9ihXk6PNTq
 W8o0eaUWXMxABrQ5sQkbofKI2MkKoVr9nFOPlqDwUECvZ05n7ZDcgjW2w+Vj46m4CD4Q
 3Q2Lp08dtAQrEbNh3rGgDTtxhNLo/UBbEj3UWdNnuWGi12/4QV9IETgSuMApfGQc9OO+
 ZFr6XK4nrD0xsxC87mhoOVV4EhwjF7siD4h6KwYu5KQrDNOI8Xtz4CpsLtp1Jti4Tk9r
 7mB3lmFAgpJWsL2daEaKjhqVdOOOZP0TzfyctTdYEgdzIeFPpqWlYW6IRhNcDTdf+C4z
 6vyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JcUhIIQij6MnxY5Mqs/mqm7974zLAWkC1+yOG4bY6nGG/wgQHs+zYVLFiZKrqtWvxPYfFF6pbsRA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/xgWN9pk9uFt4/7xkz3HUNvjHOcazAKLsXE3ePCXWLZuKThjR
 CkExK3LI/46593XOtKOikmUSSIovV2q88qaear+KXQBwYDkL6F5vOz0EAi3nxAWxUF7SRLg76vF
 on3kU
X-Gm-Gg: Acq92OHASi5WhT9FgRfAQuF3v/LErjhYI2XVHY5sEfxB8OF+nqbqcZCC4rXE5qSsYmy
 d9r7Vkr9jfSxQbH0xrsS5Zj0svj8lRruOJljtSJFuD1IbpaLbKDKPS5h5K3rmiWNJ1tLreMiPar
 bGDuPhmueR32FB7uREvjPMvJqQZPA6aJdCuH2Ab/Ap5Gh0T+zhdYwFxsCzzlSXLNUIn9Qctzh6v
 qEAjLpFRo07arqRIXY2Mm24HMGBd6iSCn2G7jwShUgNqLJdMeMTQ5M2rlByQ5UUawtZfW+Qtd+X
 2Ag6INIsRrt2tenXLh4Cx/IiOwLfrOrZ+mbe9w2luMk78T5us/n1rhlH5b4gDsCG/zD0/pEoEHH
 dL3S19xWz4PPWnbwCuNVn9SKik9kI8Jb53TYrz1oWNHC7EUcXmPkbYdUG8rHlDxT+I8zw2x0oMQ
 Si3LDSi7xZCcakkU56aEck7LuI1HqrrLS2ojwbp9dYn6iSsdXVKRejncqlnVdmnch1TS6pnQrLG
 xE0r3pExv98jiwv99P4uLb1NjinXlsODbAS7y0ol1efG+Jl
X-Received: by 2002:a05:6402:24ce:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-683bc1b0599mr1061118a12.5.1778827650279; 
 Thu, 14 May 2026 23:47:30 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.42.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68310d510fasm1607798a12.11.2026.05.14.23.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 23:47:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/panel: simple: Add AM-1280800W8TZQW-T00H
Date: Fri, 15 May 2026 08:47:14 +0200
Message-ID: <20260515064721.1750990-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515064721.1750990-1-dario.binacchi@amarulasolutions.com>
References: <20260515064721.1750990-1-dario.binacchi@amarulasolutions.com>
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

Add Ampire, AM-1280800W8TZQW-T00H 10.1" TFT LCD panel timings.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208cc..99deab68a2fb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -794,6 +794,31 @@ static void panel_simple_remove(struct device *dev)
 		put_device(&panel->ddc->dev);
 }
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct panel_desc ampire_am_1280800w8tzqw_t00h = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
 	.clock = 71100,
 	.hdisplay = 1280,
@@ -5193,6 +5218,9 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am-1280800n3tzqw-t00h",
 		.data = &ampire_am_1280800n3tzqw_t00h,
+	}, {
+		.compatible = "ampire,am-1280800w8tzqw-t00h",
+		.data = &ampire_am_1280800w8tzqw_t00h,
 	}, {
 		.compatible = "ampire,am-480272h3tmqw-t01h",
 		.data = &ampire_am_480272h3tmqw_t01h,
-- 
2.43.0

base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
branch: am-1280800N3tzqw-to00h
