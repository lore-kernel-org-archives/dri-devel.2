Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49A606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5Xh/vDA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6BE510E607;
	Sun, 22 Nov 2026 17:13:43 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC7A112B78
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:00:51 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc758830601so775679a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795186851; x=1795791651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
 b=o5Xh/vDAcOMujzZUhGPBQdGS4wadmWE8u2e9q31X7p8og4BkdzY1ElgO5sSkuWJx1j
 Esl+7HGZk9dRMsMKDqKtYLvRkPDOe9OjoV4alIJk+H1HMTGkpUjhVNW2lCIHgbpGT3io
 lq3s+a5S9PY3vrFDZWThqzazbqe+N8BTPCYMCopQu/0E63MNJ6KGK6EtoW7LYHwQSTxK
 CX2BGQGDZPVUGfxXFsqGvAS0mHGjYMOV5C2CiSCdg3BYh0FRES14Z0pxke46aydBrwUZ
 nT0WmcP5nyp28oXN3iq/48d+8g/caFzYVYS0T8Dm0hqBmBknGofNGXljkuVsaCk9esLx
 5nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795186851; x=1795791651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/iYOhMINhvEOk0ds7NRqLPwYU2L0FMs7KPyj2Wr1b4=;
 b=OXR0sfv8akhqm3Cl2mzKZgFz87BWmVLfSdBE8dBEv4DoRBsef0SkvbJeqNhgg2D7xN
 qnfqi/JijTz3pxddAUEs6MlUkHoRkI+NjoTdboBGGj5zhh+pueZ+moinjsfMBpeAXY4S
 jZ0LNhslRPEKeuK1hS6NqRBJ+Q/SxadX25DIBfldIXJsSVlYqTMHsx/zkxkc9SiwWT0z
 YeCGsI4B+PjtqIVSS8HIqfjdVsV/2BIxhrjEzwwAIgruRPUaSiZrcFhiZGwx45XfXvpu
 Kbo9S7ZypI3vjn+MCI1DCYxi5Ax9TksEws91gqSQD95q/ZVUiiDedQ3FRPjPw3CofQ5i
 n1XA==
X-Forwarded-Encrypted: i=1;
 AL+hErEEmQV/ydbhp3qIm6tYpcLWqWqnTNC84gIlEBd9IQIdfAk1o4JhduWY/DDmGbJgWdoZz2ASnWxTcsU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89KAkw4iDt/4xQsVh1ma8Jl5ptC/sFct9gGCxTYc2eDdLqjyNN
 lLsybFpvi2yPmoWuWRMq2OmbcEdo0o6Xs+xpbv8RkOHExXeL6c5+FWw1
X-Gm-Gg: AZFdTZdePoBVPymrzOtaa7VBT99Ocmxt+7ZeRCPc4KqU5Q76hn+eoYxS4EbvFTE62ya
 sI87ixzl//EUlCP2B6fpULitxwqhFL9T4TaF741098GhbedHZuKUrhXOuYEVLT+0kxToSv8nO81
 FHtDzzWRretO4sNx00DBVK0GQYEVhQoLkFCUJ59XCyrCugSD7iJZBEl9Ze25OHJDWyRd7Rnsrz+
 tI3jEfKXpAZ1XY8CMHKYUSkuHoIVPJivKPZEIbcGuPu5f7K5S4Az4hIOEC0fjAlRIHC+LjKIT9O
 DbpWLlJA++3MQNvxXfbRWXGMZyNU/ZNUn8tu+z7YP5x5lhK83eKZ57vo+B4XeD+C1mkitFaBf1k
 5Cawq8HIJNM1zG/3TCkJsjzGrN8UNXyZZBHkk0h+RD7NYezhVgo6R23kOReVPJS9yTxyxtB2peS
 ctILLR+6oUal7gk0QdX9WFMY5Tu1oi1+XqVr7cvb60t9AbtxWLtHaUQMS1CaBS+ACWbVL+BiRYG
 3d2fQL77rhG5VryvDsc3RmRvzRXOZzpGJthKsSnHHyNsB9hb0WwxxiPT5xUOYcEwNj+4te/6qIQ
 sgtmg6eVNZe4dhbZkkj9C8H+WyAacF5V3wSfUs1EtSF89H+cEFHAPBpz+T9r7lDt9N9X
X-Received: by 2002:a17:90b:2688:b0:3b3:cde6:d8c8 with SMTP id
 98e67ed59e1d1-3b41c955b9dmr2998636a91.46.1795186850600; 
 Fri, 20 Nov 2026 07:00:50 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d96bd3sm7851802a91.12.2026.11.20.07.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:00:50 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Hans Verkuil <hverkuil@kernel.org>, Linus Walleij <linusw@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nhat Tran <nhat.tranminhk2@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/bridge: tda998x: Fix CEC calibration with lazy IRQ disable
Date: Fri, 20 Nov 2026 22:00:04 +0700
Message-Id: <20261120150004.64033-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CEC oscillator calibration pulses the TDA998x interrupt line low for
10ms through the "nxp,calib" GPIO. Before driving the line,
tda998x_cec_calibration() calls disable_irq() so that gpiolib allows the
GPIO, which is also used as an interrupt, to be switched to an output.

gpiolib only allows that once the interrupt is actually disabled at the
GPIO controller. Since commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable"), disable_irq() is lazy on GPIO controllers that
do not implement .irq_disable, such as gpio-omap: the line is not masked
and gpiolib still considers the interrupt enabled. The direction change
is refused and the calibration pulse is never generated. On a
BeagleBone Black this happens on every boot:

  tda998x 0-0070: found TDA19988
  gpio-537 (nxp,calib): gpiod_direction_output_nonotify: tried to set a GPIO tied to an IRQ as output
  tda9950 0-0034: TDA9950 CEC interface, hardware version 3.3

Set IRQ_DISABLE_UNLAZY for the duration of the calibration so that
disable_irq() masks the line immediately, and clear it again once the
interrupt has been re-enabled.

Tested on a BeagleBone Black without an HDMI sink connected: the error
is gone, the GPIO is back to an input used as an interrupt afterwards,
no spurious interrupts are raised, and rebinding tda9950 repeatedly
reruns the calibration cleanly. CEC communication with a sink was not
tested.

Fixes: a8173820f441 ("gpio: gpiolib: Allow GPIO IRQs to lazy disable")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/gpu/drm/bridge/tda998x_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 0b966c9844e7..0815ce283f49 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -495,8 +495,16 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 	struct gpio_desc *calib = priv->calib;
 
 	mutex_lock(&priv->edid_mutex);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
+		/*
+		 * The pulse is driven on the IRQ line itself, and gpiolib
+		 * refuses to drive a GPIO whose interrupt is still enabled.
+		 * Make disable_irq() mask the line right away instead of
+		 * lazily, so that the GPIO can be switched to an output.
+		 */
+		irq_set_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
 		disable_irq(priv->hdmi->irq);
+	}
 	gpiod_direction_output(calib, 1);
 	tda998x_cec_set_calibration(priv, true);
 
@@ -508,8 +516,10 @@ static void tda998x_cec_calibration(struct tda998x_priv *priv)
 
 	tda998x_cec_set_calibration(priv, false);
 	gpiod_direction_input(calib);
-	if (priv->hdmi->irq > 0)
+	if (priv->hdmi->irq > 0) {
 		enable_irq(priv->hdmi->irq);
+		irq_clear_status_flags(priv->hdmi->irq, IRQ_DISABLE_UNLAZY);
+	}
 	mutex_unlock(&priv->edid_mutex);
 }
 
-- 
2.25.1

