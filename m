Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ahvs2Qkd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9AD112826;
	Fri, 27 Nov 2026 08:29:14 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61EE10E9A8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:36:01 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc758830601so5237172a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795700161; x=1796304961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
 b=Ahvs2QkdO/Uj23iMdseqae6q3RkvkvXTuudYX2CU2fFC97MUJsi3uPxQ+oHopmv6zn
 B85vgVeERq80lH2gdGJJWFJ/82mNmK1EcVhCuLSIQt43AJ0EsXS2cU7qEi7mC19i96NR
 lgkzgHS9Ske55s+rrQIWkb5D7z/kQXj748G26NIWQSKiermstafP3v1PVC4k6H7W9RKP
 k6wUxZiVzalU4BFaSaxKT7KNtC760jpI6NRbcdkpf/kW4A+mAfseWSKk0RrMCmNPkLfa
 0Ha6OghBJTKAHmoeXSxQdig0ATzHnyYmoK9P1NJPyIpxsYLjMsgopSMdVwJR6yKIl+dX
 ixpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795700161; x=1796304961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
 b=tpNPb97LL6v/6XOYCAUzYhyJYgZrPiKD4Jl5slOA7lwUvN0ACRZF7fjqHf8zAlXwnQ
 5kGN/pinAkzj0sqbb5F7uPapfyDBkkSve1wFOS35wi6Agsmh2fqUHmYDKhe6sGvjwhdB
 SFKwfkBwhngQ4433kH5JdvSJSpawWd3nB2fa+AK8xyW30CoEfhB6rjtEeZ9Q3rIp9VCz
 IuOzr5Wx4QZSrbbK8BW/C4le0ggaScku3luIZOClyS25rkskW6DXX9+Rli72BpvqONij
 awEFhPMKf5uEAxnxVusn6LRU+9Ry4EvjIZj9TGhqUHlyeuKv2sVbhqgX7OM1BXSyNd6s
 BAaA==
X-Forwarded-Encrypted: i=1;
 AL+hErHe1bIGq7sXP3Ul0qUvmOAOG3zVmOEO/nbXP29JX4EAFwtRBkX+ZCkD9hpHzEDvgCwA3JYWflzCjRM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+gZw+tYGjD0HiJGsu0KpoApp1A5S1FCd3qchqksPPITSpQpE0I
 KdRkAzCOCqxqy71aXrQUYr9QPpcSgrVAgvzxpa/6nIVROlWRVBmrKSw=
X-Gm-Gg: AZFdTZdoj3NJZwSftHcvyePvxFTYGetA2k1kpzYf/8716ezicjkSqOgOxGWqdBitDq/
 ke5k+ha+WJAGriaCduKevj1gVRbai9XiMIbBmfBwhYTrMsTpvaoWLKt1dT3u6Vj1Pd0ZEyzDUeE
 locbd7fgjEr/SLiF95DSJDqDdE14QTlKxwTjn6SzsKCyNz5iF2eRKcJmY+5rkvvr9SiB1t6RsFg
 aLz4kb3PfjPtjpvJ1eQghp4FIMA7DkhjGibXtFB2SQsEzLRxUjI/68FcLohMkNoxgPF81qlItWY
 Prt+rw6XrPAFAIJPMSg8k4BpxqWHzKyyml5g2FcZZaEOEp4C7BwnozUHS32cFdRJwE4AwAIutnP
 WLqV5KNQLUpGbsJTBQreEaok5K+X9kLQWQNFULHmVZxo3WzwdqXNn47rq/Jj8AbIE2V9XVSYrou
 x+BIH+Bo0gioRg4HBbsIHJkzU/dzzgYNbIy+bonBwCHP1XYBnph/7j09P3KuO7lOv0CENwgcf7L
 mRm8BRRpHSOQq4BkB+EqjvgAQ3iz5w11pydmOUVpaXp/5gwpn7MEfCNd611A5JzMN9ELlCzwnNN
 U+ZAj6RdeAYvbqTtOv2PdHfq3sOOcgXsXdX8YQAdDu5KYzdwsX4j0KD4qAayLVbqZ0PNQPJ4fgd
 09A+aPu59aTdI
X-Received: by 2002:a17:90b:3e81:b0:3b3:ff66:4097 with SMTP id
 98e67ed59e1d1-3b41c92a1cdmr18216781a91.26.1795700161363; 
 Thu, 26 Nov 2026 05:36:01 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b6fe711sm14480336a91.1.2026.11.26.05.35.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 05:36:01 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Yige Jiang <yigejiang86@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] fbdev: ssd1307fb: release PWM if panel initialization fails
Date: Thu, 26 Nov 2026 21:35:56 +0800
Message-ID: <rc-b1-20261110-vc-112-b07bbe936b75@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

On the SSD1307 variant, ssd1307fb_init() gets and enables the PWM
before it sends the panel init commands over I2C. If one of those
writes fails, ssd1307fb_probe() jumps to regulator_enable_error, below
the pwm_disable()/pwm_put() at panel_init_error. The PWM is left
enabled and requested, and its references on the PWM chip device and
module are never dropped. As the PWM stays marked as requested, a later
probe of the display can no longer get it (pwm_device_request() returns
-EBUSY).

The sashiko AI review bot pointed this out on 2026-09-26, while
reviewing an unrelated ssd1307fb error-handling patch.

Jump to panel_init_error instead and drop the now unused
regulator_enable_error label. pwm_disable() and pwm_put() accept NULL,
which covers variants without a PWM, so clear par->pwm when pwm_get()
fails instead of leaving an ERR_PTR() for the error path.

Fixes: bbc79089ae2b ("video: ssd1307fb: Add support for SSD1306 OLED controller")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263%40kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_FB_SSD1307=m, CONFIG_PWM=y, CONFIG_COMPILE_TEST=y; baseline and patched ssd1307fb.o, no new warnings.
No hardware or runtime test was performed.
The path needs an I2C write error during panel init on a solomon,ssd1307fb-i2c device.

 drivers/video/fbdev/ssd1307fb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ef4bb920c6ff..dbe5dc67e044 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -403,7 +403,9 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		par->pwm = pwm_get(&par->client->dev, NULL);
 		if (IS_ERR(par->pwm)) {
 			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
-			return PTR_ERR(par->pwm);
+			ret = PTR_ERR(par->pwm);
+			par->pwm = NULL;
+			return ret;
 		}
 
 		pwm_init_state(par->pwm, &pwmstate);
@@ -794,7 +796,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	ret = ssd1307fb_init(par);
 	if (ret)
-		goto regulator_enable_error;
+		goto panel_init_error;
 
 	bl = backlight_device_register("ssd1307fb-bl", dev, par, &ssd1307fb_bl_ops,
 				       NULL);
@@ -823,7 +825,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 panel_init_error:
 	pwm_disable(par->pwm);
 	pwm_put(par->pwm);
-regulator_enable_error:
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
 reset_oled_error:

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
