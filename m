Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769CC10A62CE
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5941C10E9B6;
	Thu, 26 Mar 2026 13:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AcxSyggs";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887B210E182
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:30:24 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso24810815e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774380623; x=1774985423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4NWl+nIdcZDyj9SaWGNpDFXb3knx3+VKeGhhxFBSjxc=;
 b=AcxSyggsBbqWXe4sI5oE3yesfjDPuzWgfh3Dlg2AtegZ27o8yJrwgY/9bmce3OL9Fs
 oar0b24n1nLbmdFHXkqfR1/7TXv9RUdsLPAsnByuA/x+hwOmGToEvBmY0v7Nx1CztzXE
 IoQCzCxiVrhpVSBQ9dID6hKFGKK00n/5f9Ib8nzYH6wJ4BKhZCY9Qtg9rKgTYHp1UkkA
 QtF/Q555M3uulxFo+Um9N19jWvrN+CoNHPBjp8qdo/xGSeXXLo8YGblnjWq/ml1NI2x5
 I+tsdw5Z6GbmNOIcr4dv/yqy0mQ/o6WeTwwDwZsyavzZFegETKg4NmPrJ5UHjfBudbRM
 pLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380623; x=1774985423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NWl+nIdcZDyj9SaWGNpDFXb3knx3+VKeGhhxFBSjxc=;
 b=fcqikB4nMxDoLjTH0v8wIlm/HYlpt/EPPSeJiLhHtRmpezowCqnI/tnLnR6lJ9z7P0
 PvU3Pxsq1XPrIJgZhh90n9Jf32kYmfsH0Sr9iDEb1QBGt/PU54/81igr31A5LaXGdsT1
 oF4VIDu6txJ0HRMrL0/CvP9XT0HVIssr7vmTSR7sVkcKux/f7anOHtQTrtupZHk3Wu54
 YcEmGLYusXeyUKcGTXwetAbM0pw/EgrVuR1A3Q+NTHMBKdK5fJRExl0677dWRyVm77L2
 wL3sKv30nWkVgp4YgPptXn4o7SRd00FH4ELTOl5bpqbPSSsGGbIiy3/UHnmNv9tskKe1
 lgtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1j3b898Jo1MWh+SBPT75EcV3eL7h6Tveb5M1tnsjYqSyPdpda4trjSeJLahiknZtAbNUg1Q/jnX8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfOYc+xDgSmTLr8XA+redo3uZNAyaM4gmbuH1bFLSGaUU2Ptqz
 klq8OsBhr8fGYZ0HnCg8r2S0CC8BLVVvsHeEK9h+MxTaxtBNNAZA8ntt
X-Gm-Gg: ATEYQzziExnIY1ZSwqeSQIZigs4T4KXQXwv/J7gjJEOQwDC6I/lcRQQZRZOJViA7WMC
 23LEYynHYuHlcVk21NUgWzUMc5sA1vbwS86TJpPw0iNviglF5m8oo0CgTDT+nNINjmXWTSOG9FV
 /DzK4kIj1bdzqQmqX4Z/StiMsAIKu1Yy5TPsNBkY7pCeflSf/jPyMVK8o3NP/DLYWL2GQFLujQL
 ZwgV3VwAEuaWUMcqkD5fHBuNaxQnJaxcYbzZZR3wtdYds49qP18Kw6skUlim/0iUMAy8KY2jdF9
 U4n8ZnZymCfo6c9k8LAG4Xivs48+yDytheF3xmB4kaXAu//sJ9xPpUzFTFO/KnsoCfEO/D0dPSP
 H+2YeF51EZhbcIosWlYQ/4iLj/BH/+83h4o7Qz9WY4ic5OJ7KQFd3zpCJv7KlWlD5wyAXjUUGwX
 VFlsJLWhfUQv9lnEp+Vm8qYdab2WQJNgk/Fbq43VRFxiyzesZbXaBYik4g/G9ujbXOspY1lonkb
 KYQe7XASgqmpLqSzTtK+LFPUAVzwA==
X-Received: by 2002:a05:600d:486:20b0:487:386:3714 with SMTP id
 5b1f17b1804b1-48716043919mr10455905e9.17.1774380622686; 
 Tue, 24 Mar 2026 12:30:22 -0700 (PDT)
Received: from localhost.localdomain
 (lfbn-nan-1-1836-142.w90-104.abo.wanadoo.fr. [90.104.252.142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48717373ef3sm737135e9.26.2026.03.24.12.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:30:22 -0700 (PDT)
From: Julien Chauveau <chauveau.julien@gmail.com>
To: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Julien Chauveau <chauveau.julien@gmail.com>
Subject: [PATCH] drm/bridge: it66121: acquire reset GPIO in probe
Date: Tue, 24 Mar 2026 20:30:11 +0100
Message-ID: <20260324193011.16583-1-chauveau.julien@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Mar 2026 13:17:48 +0000
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

The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
calls gpiod_set_value() on it. However, the GPIO descriptor is never
acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
the driver lifetime.

gpiod_set_value() silently returns when passed a NULL descriptor, so
the hardware reset sequence in it66121_hw_reset() is a no-op. This
leaves the chip in an undefined state at probe time, which can prevent
it from responding on the I2C bus.

The DT binding marks reset-gpios as a required property, so all
compliant device trees provide this GPIO. Add the missing
devm_gpiod_get() call after enabling power supplies and before the
hardware reset, so the chip is properly reset with power applied.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1559,6 +1559,11 @@ static int it66121_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->gpio_reset),
+				     "Failed to get reset GPIO\n");
+
 	it66121_hw_reset(ctx);
