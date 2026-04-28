Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06727FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6606E10EF09;
	Wed, 29 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="RxN01hsI";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3BE10E32B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:17:47 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-ba61a0a2d26so1520053166b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777389466; x=1777994266; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a/8nD0wR4HMebuAgJ83wvxsntol+jKIWo4zghtxRUaQ=;
 b=RxN01hsIFVRW09mmMN2hec23ukm37jXC+bMr8mO+podEtxcujZKAwtkEsa9XyofaI3
 mZ4rqrdNAO6VXFCetKUedrL1JCgNGqZSyM8gE9iOl8Rs+0WZOFy/t5YuMEn9qg4H/U0f
 RPdtHcby8fKgRKT0EprGmCyM7jEdxNtTMJNo50kU/ZWzFokkBFQa3X+6ctA2MxVFwbMr
 6s+zSpi+V6xcpk7VYwR6dnCrpzUaydqzxqiUHpsGriKVoPtQ7skxrYcsN51yRrSPaxHm
 OonNq2zsgtEkMrrXMGAtbaT1gmuMzB0h2llPqdmS3n8ZJMOVBXfu5RS2oic93oieuW4w
 J2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777389466; x=1777994266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a/8nD0wR4HMebuAgJ83wvxsntol+jKIWo4zghtxRUaQ=;
 b=m9gf7wkV+es4MUu1n0MCgWT1/WsbthSGeTr2hq8GsWVpNT0e0wxpZkimm0f6YeJq/g
 9dcV+Akj2tJ6x+EznZBQKbMco0ds1ZUio0CdXwi9D836XuDlErSJ7FSiOeIr+3edWePc
 Vrh+Oq6Kj66DMqSd5w+8TU4f4DxjAe/PIN6njYmZqkGMOxDeO/JBepjUrXmyFRtVldx4
 FlGk1I2MkKRpraWDSqb4qHGhVWTD817UWldCZRVQuxQhUrTnr+ySgmqSTq+feN5hofso
 wK4+YhuRlAojnWrF/fDyqQSFTtEaMCAfKYdHMKkmo2jd2IupBp8I+rLQUDRQqbKVhYt4
 eo3g==
X-Gm-Message-State: AOJu0YwLywphytSXZt1gvkmc+pm3WfaNzhgR6zGbrMFqGCRtV+0Utrw9
 xMTYJch3g0MjkMUtOhsjTjIAn9nDdBKncsAYQffPk0DJehhFW+GgDjBadGJ16BJ56oE=
X-Gm-Gg: AeBDiet3QaeoXqdDU3EoBRPkifbGGUx3zNgy5UQpJLFeJZ91lcwTV2Ep7kxRgo0BBWJ
 N3UZ7Ke3U2DLQtTEYgU/drDZCFmFVk9uC1hdl2qwHZqLWlk6DOLalulBp4ZwzUGxSjLM2jBAYVt
 3/8EjOGTxHmPgTlRwrAReZSFHM0wWy9c5ejwlZAn6Lvi/mcBEDIdy6yhR4eYh+OJiIz2xpUqNEs
 RwVF95v3Gue1w2ugs8ehJAHXRHEWcfb3v4nHZ8/NH4AXA9XTJlJaksWXgGh6le5uz4NkAkJ5jcQ
 F5S8sOrFZ1Lu13G010hfoN2aMf2P8SPCfYlsJL/ix1j8exYfL4TaR8KuKshtsdqQJFo/GYZ7iwT
 7mO0DIkcbcIuQNVCLh998t9SC4RIP4gCcz7GWQCVgEL0YVXbdRLOUUpEREPgf758rrck9WNNUxX
 0WPxclh5xbOoUdusLBhIzm2DsAfvsT0jDEj37uqyn2xOpd4PjT32aA5MuU2TEM2WIvXOqb/sE8Z
 YaGbF/vncNbaqltQgCdguM0zvo+Zw==
X-Received: by 2002:a17:907:7fa5:b0:ba6:689e:2f48 with SMTP id
 a640c23a62f3a-bb803f5924emr208958966b.25.1777389466250; 
 Tue, 28 Apr 2026 08:17:46 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80c0828d0sm115205366b.56.2026.04.28.08.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:17:45 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Tue, 28 Apr 2026 16:17:24 +0100
Subject: [PATCH v2 1/2] dt-bindings: panel-simple-dsi: Add Team Source
 Display TST070WSNE-196C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-imdt-dsi-display-v2-1-cf7294b5d7d6@imd-tec.com>
References: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
In-Reply-To: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Add device tree binding documentation for the Team Source Display
TST070WSBE-196C, a 7" 1024x600 MIPI-DSI TFT LCD panel
using an EK79007AD controller.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index cc8d795df732..6d4133b91e7c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -63,6 +63,8 @@ properties:
       - samsung,s6e3fa7-ams559nk06
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Team Source Display Technology 7" TST070WSBE-196C 1024x600 TFT LCD panel
+      - team-source-display,tst070wsbe-196c
 
   reg:
     maxItems: 1

-- 
2.43.0

