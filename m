Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4F31099B32
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB09610EAC0;
	Fri, 20 Mar 2026 19:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCMg2utF";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B5810EAC0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:12:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ab232cc803so4133045ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774033944; x=1774638744; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GzUsZ0V+OsYZzU5hFHvU5ER39DG7821lBv6s9PN+5+U=;
 b=HCMg2utFzZCqCpdmMhzA+h2YbKfCROfYc2ai7NPSrrT1h6ZnL5+KK/00qrfUM9SHmp
 Y/KgsH0RFgeYmdvPdJugXBpfBwCPyl7B0QXUpsFEhsxBmNUu6Mi1VDbU0yOYCX/xrMs7
 1rfuvdkLY7362oXaglyorp+RIIPNQkSlTMnoyjYXJ53HPeEYz33YY+9kAbl2IzpgfXYN
 cUf1V2Ne8de2kmPv/nGCuv64J8+iBIKkFAxc2xVQiuOLph/BuLKpTzrieN80KzL/r4ZR
 QgOEcVwPJP4Ztz3NMwS+dp2PtY4X8al4Jv/h1+AcnKY7wpxeNF3b0BP84SUGnC+pbmaW
 nEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774033944; x=1774638744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GzUsZ0V+OsYZzU5hFHvU5ER39DG7821lBv6s9PN+5+U=;
 b=PC1SdtCMVMWzsm33WY68xbSCvulem2O4NtxcCSAApWYU5Bx9En3Cip+Ubyf0sz2aOP
 INKX0cjQ8xQzdKc4jtRllieo7PxTkfbQ2bVQWXFKalTgLQQ4hsgs42jpmtPp5Uqks8G2
 65G+nuWEDywtJZdOyGhAqhKZCkEiTBWxV8ZRFRHA2prKiTtYPElH4duTaj8I3dHQOAWe
 8unqpS5L4ElD+KZTXKeF6/J5TxZ0x6K+J2reioOGOIpnKTDwcz20HGXqJiD9oK7qDzL1
 enl3T69eKjCy5KAo00+rj6u1VRtOrbRTUabi61+NrPPLZk0OsZX1Pz+GqqpI9wUAAduY
 Kocg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYs1aJScdrZv+yto6ICdUA5c3178shZB+31MKQXxXkXj2CI4eVPzzbEEPsdKWzRR5ewXcKjqb3Om4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+BgHsotbuG+DbvzJw6jqVC1QcKt8frWDqTSb0NaTwkd0p/Xs8
 58c22bFNEoGa32kLPVt0oQS/+DKAbzNM8U9jsaYL7z5f2P+1U4qxz8yg6sagM1RbRIlJng==
X-Gm-Gg: ATEYQzxzh1RwWeod25fcVAhaoFDicAvJYL6QwSIa7i1NG8nAM/9bNg2QNO5LPMf0/+7
 k5Krjq9kepaCTV/5LGronxxRyMJGweKqMO1JlUbddk+n40c3ZnI+PUov/gY2EC6AuKoC2zbqMrX
 7FF8vvRSv4dZlsYBh4GA6CJjOtxksvRbBcXclye8TT/3NTdOiQVUyqtjU/K03r/10AvdCebXckt
 NBPrwOSLKHmxNiRGLN1CGE4N4IOoze8bMB/uHxNlWWvl6vpSTUmjY6zMaV/A73Ie1O+tVScNO8B
 AbmkHiVxFJ60gtI1bEkGBW0ZT98EZfUqQt2NaZuN2K5tKS8bLeQiAtQRlOsLMC2Jl7PVizxV6tl
 8vsOW4FLLf/5IGgaO7U+eYw1/UM0I2DRwgpU5V9vTTNlqirmnQSluFwnrt+miYLLOnOUmoHu0C9
 Tf0v6UHVEuY9/eawqb4nso8YBk/fC2uKxiLbc/
X-Received: by 2002:a17:903:38cf:b0:2b0:6961:150a with SMTP id
 d9443c01a7336-2b0827d7e20mr37519215ad.38.1774033944094; 
 Fri, 20 Mar 2026 12:12:24 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083688ca4sm39599915ad.67.2026.03.20.12.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 12:12:23 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 21 Mar 2026 03:12:10 +0800
Subject: [PATCH 1/2] drm/bridge: th1520-dw-hdmi: Fix error check on
 dw_hdmi_probe() return value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-th1520-v1-1-ec877197770d@gmail.com>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
In-Reply-To: <20260321-th1520-v1-0-ec877197770d@gmail.com>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <uwu@icenowy.me>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774033935; l=995;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=4F+Ll1PWHhd/QixktSYleAKOUdmCyNteN2mj0AKQq7Y=;
 b=1wKT8Nsz2Paz9DLjSvFMhtNlNWSOreFb8Roupg24Rg5qwt9FTGGanMq1ALok9+x2liB+HzDBH
 13ucLSz6c/ECAxSLCoMI4i+CbOdxMEYfXaNVwZGrBm0CPKJkIRxF64J
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
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

The error check after calling dw_hdmi_probe() was incorrectly checking
the struct pointer hdmi instead of the probe result hdmi->dw_hdmi.

Fix this by checking the correct variable.

Fixes: 96f30ee0fb9d ("drm/bridge: add a driver for T-Head TH1520 HDMI controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
index 389eead5f1c4..c9968ec1823c 100644
--- a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
@@ -136,8 +136,8 @@ static int th1520_dw_hdmi_probe(struct platform_device *pdev)
 	plat_data->priv_data = hdmi;
 
 	hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
-	if (IS_ERR(hdmi))
-		return PTR_ERR(hdmi);
+	if (IS_ERR(hdmi->dw_hdmi))
+		return PTR_ERR(hdmi->dw_hdmi);
 
 	platform_set_drvdata(pdev, hdmi);
 

-- 
2.43.0

