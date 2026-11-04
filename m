Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F56606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOSHfEpt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6434310E840;
	Wed,  4 Nov 2026 18:39:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9941510E840
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:39:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CC8C60A7C;
 Wed,  4 Nov 2026 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0221D1F00919;
 Wed,  4 Nov 2026 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793817588;
 bh=GCXM+1vHv30jwbDAeKZYBleOEN3MIKNP86ZtMt61Hjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jOSHfEptiiOKgeEosLGAGrMmzKcsJF/qUzKQHApDUWg3yY3OD2tOOIEKQnZnd2pwA
 Tkm0oXb2WOsP99CfqkHY011A93wvO7dsv6yMVpClJZ4YnnJJoe0HjMVwnePoIQOQBV
 5QYXZQ6qI67kuMSAndP4teRR5Ve1JybUf7MaufIGNBlOPLxwZ/4wibZPaL+Wej79at
 KLBcQXF8UYZEoiozBdY7HEW+NRDaSq8fDZDxO3BbHw7x53szQWMC6I5KzPI3sE+VXi
 wnuGCFU1sYYOE2xpydduE/A5jeoKpnQFMS7z2yS/po45n9IbjD/LADUXFVPsVXIE48
 lvtxrQxAfUUyQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Daniel Jeong <gshark.jeong@gmail.com>, LDD MLP <ldd-mlp@list.ti.com>,
 Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/6] backlight: lm3630a: Request PWM device before registering
 backlight
Date: Wed,  4 Nov 2026 18:39:02 +0000
Message-ID: <20261104183935.1214630-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lm3630a_probe() currently registers the backlight devices via
lm3630a_backlight_register() before acquiring and initialising the PWM
device via devm_pwm_get() and pwm_init_state().

This creates two issues when PWM control is enabled:

1. Exposing the backlight sysfs attributes before pchip->pwmd is
   initialised leaves a window during probe where a userspace brightness
   update calls lm3630a_pwm_ctrl() with pchip->pwmd still NULL (or set
   to an ERR_PTR() if devm_pwm_get() fails while devres tears down the
   backlight device).

2. Because devres releases resources in reverse registration order on
   driver unbind, the PWM device is released before the backlight
   devices are unregistered, allowing a sysfs brightness write during
   unbind to invoke lm3630a_pwm_ctrl() on a freed PWM device.

Acquire and initialise the PWM device before registering the backlight
devices so that pchip->pwmd is valid throughout the lifetime of the
backlight registration.

Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
Closes: https://sashiko.dev/#/bug/linux-ba01ed63-0b5a-4b3d-94c5-e6989857d77c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8ef8163c7fef..9061355ef8ed 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -549,12 +549,6 @@ static int lm3630a_probe(struct i2c_client *client)
 		dev_err(&client->dev, "fail : init chip\n");
 		return rval;
 	}
-	/* backlight register */
-	rval = lm3630a_backlight_register(pchip);
-	if (rval < 0) {
-		dev_err(&client->dev, "fail : backlight register.\n");
-		return rval;
-	}
 	/* pwm */
 	if (pdata->pwm_ctrl != LM3630A_PWM_DISABLE) {
 		pchip->pwmd = devm_pwm_get(pchip->dev, "lm3630a-pwm");
@@ -564,6 +558,12 @@ static int lm3630a_probe(struct i2c_client *client)
 
 		pwm_init_state(pchip->pwmd, &pchip->pwmd_state);
 	}
+	/* backlight register */
+	rval = lm3630a_backlight_register(pchip);
+	if (rval < 0) {
+		dev_err(&client->dev, "fail : backlight register.\n");
+		return rval;
+	}
 
 	/* interrupt enable  : irq 0 is not allowed */
 	pchip->irq = client->irq;
-- 
2.56.0.385.gac671c819a-goog

