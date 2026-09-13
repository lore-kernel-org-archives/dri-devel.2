Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352C8C88E66
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FE610EA43;
	Sun, 13 Sep 2026 22:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVrM/bCs";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD4910EA43
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:30:27 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-90ce6d5271dso10216366d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789338626; x=1789943426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0bAI9mmXm3rd1fs6JBz3Pfb/OV3Rxah7vPEmWuwzOx0=;
 b=QVrM/bCsYyNUB6nhjcr3G67Qxt0Z197lesHQ6hjiR94+MZBRUMd0WtKeH0J1RTy0Lz
 vdiQtEHljcW6LPLsnHUDQhxSmCIhuJsufRelupHlBwYDM9S/Qz5QUS/ujF0xf5xIjgNx
 Ihv5jNtRVd3wr/RMn5q0FzgacjACD1xEe5IIe7fL3/b6mmkMl8M+ip9Q47azSUulfACd
 ZhBKBH4aE1f/eiWSbFd5cARZxwL144DrutXF0vhLcMiLiHrqNyY6/kYfP3K8vZLpev4/
 t6C+ogsq79Lin8SmazAPHqHQF0RtgNGv96mfrqEg27hWku6j1eJdQkawJtWxNorC2FF2
 LQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338626; x=1789943426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0bAI9mmXm3rd1fs6JBz3Pfb/OV3Rxah7vPEmWuwzOx0=;
 b=gSuz+/Pb/YCpCC6PwDFxaKdeJCrCc5hyLScm4D2T3a0VqYa5u0ri0fhafa0gZlYbDp
 bM6G/mUh4HPIljHWLXfpHJhd+ZbY9ljg4N2HMWXWcKw6d93QIYQb8ciYhpdRRlvf+DU4
 McGCqq+QLU/w/NhDE9HCQfwKXDWWOls3oitpIxKsChDKMAzmxLprSJmF4o+jyo8i76+T
 yISovorCqmxOaKiV9peabcxC8mAMPawuaD3NrLxko6A9fVmUYu1fwstq/2gGPrzkIvxd
 Vr9nvsuoGJHMJC+dcOssKf6ej8ZUPBV4oR6vLdQgqFdEg56uN2UW99qfyvk43Mf8Bgdb
 97+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxawMLN6MBmVvtZXj792vGa5SiuFxH+Y9NMPyq1KDQDZEcrel67RGbwh3doW3iJJT9VW4oiL/QlLNM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbQqCMvzfyfmE+qpF9jtnMmy/Rw4gAreZcfVcwUnYL1G3EaMaP
 Ih0lq+9zT78IEL802LHRShvlcYVMRRip52vfli3O6binsXT/042tZXU=
X-Gm-Gg: AYBFou195Hu2C0mkPMz0VcBew+kPG5SrbwVE2SFeNH1p52UG4/iJu1OEnzDjT9e0I7B
 bul2ER6AcEG3SHkGvrmiSMriBcj+HmJiDdDaSWlMy/85+DCk42DKXE28n8ccNl0cgXSCUTGfk3L
 WjEd3m2hHQV4X875AcPZSzKhjr+g4bKBS1m6cB7i5EhwxpWfBDPFHC+RMsrBIRFwyLwahJyH9eY
 1pw5bwS4MKqdHa7vqQtXnvDwmRj6r2upUoRgs5Kq+kDMDsHbQBy1JIPD19HGR1+B1paDSnGKcsQ
 9RUte21KURUGbnrI6UszZmVnV+gwiDGb+jGkJAGAiJFXrVTMoN2GXNKiQpje9Yo6hOzJHDGyAbz
 iDw6QBAQ3RM44qXM5MDgpby5Y8icfKqZiRoIPRIoxZyfvItezS5W5cXfaMK7rsWPpkV8krhAczJ
 2viHbpuxLNsE871q0Ez7ghaz/tWF0Jk7CUCps4k7cxTiCCMWtrinc+VBwNb1jmLvboQZk9RyXEG
 /wCYowEyDjLi96B1f9vfJ3RGPu27c4FvfLh0gd64Sr5NWC6WWyLSOkuLLe89xVaCpHWzUMgfRey
 B+E6Yh61Xr2sfCFDGEXT5/yOT+uKSOx1Z37xav0lTDdd
X-Received: by 2002:ad4:4ea4:0:b0:911:2a7e:abbb with SMTP id
 6a1803df08f44-91226b71087mr49832196d6.14.1789338626502; 
 Sun, 13 Sep 2026 15:30:26 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120ef650a6sm80587576d6.0.2026.09.13.15.30.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 13 Sep 2026 15:30:25 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/aspeed: Balance the display clock enable on teardown
Date: Sun, 13 Sep 2026 18:30:19 -0400
Message-ID: <20260913223019.89651-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

aspeed_gfx_load() enables the display clock without checking the return
value and never disables it on probe failure or removal. devm_clk_get()
only releases the clock reference, leaving the enable unbalanced.

Use devm_clk_get_enabled() to handle enable failures and automatically
disable and unprepare the clock on probe failure or removal.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, clock-failure injection or unbind testing was done.

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d4577663a..aa36b79d0 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -189,13 +189,12 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	}
 	reset_control_deassert(priv->rst);
 
-	priv->clk = devm_clk_get(drm->dev, NULL);
+	priv->clk = devm_clk_get_enabled(drm->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev,
-			"missing or invalid clk device tree entry");
+			"failed to get and enable clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);
