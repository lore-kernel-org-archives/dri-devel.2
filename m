Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2558EC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AE989151;
	Tue, 25 Aug 2026 14:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="evaykTSJ";
	dkim-atps=neutral
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com
 [203.205.221.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAC210E16B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1787648299; bh=9xvODdda/cJtrVomNv8s/Z8no4Xi8h3PVmyvznxcSzQ=;
 h=Date:To:Cc:From:Subject;
 b=evaykTSJZKGtQihbeFiAaACTLsnCfTExE13u4epM2BWwDJXth4bIhiiRo227YTZqJ
 xy8x1GDkv4Uh4TTggNcQfFfpj50HGcoKqcd0SECUEL2yURfdzn9OOKgcBJXLV7EpvX
 dL4w7sMqDlarnNGzz/lXJwR7tcKKchmV7cuHNaCk=
Received: from [192.168.255.10] ([111.206.145.19])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id E90B74EB; Tue, 25 Aug 2026 16:58:16 +0800
X-QQ-mid: xmsmtpt1787648296tavryu85r
Message-ID: <tencent_93CDCEC8A5EA657378E58B59854679079C0A@qq.com>
X-QQ-XMAILINFO: MVzyZ2KMQtlaj77DLvTQsGupLzss5aDxAqeBL2qmH+34LtmsKeLCR0w+HhLApC
 eFrRKgX5jAtIVAX2idnIdTFAXpi2OCdQtRaKZy4Kqbhq7Y+qRarVEcwUAaWsaJGvJz0iQrTJdfig
 1uFCk+b+jatklQYKkTpVDa0yj+YBKer26+KpoY3cgVhFd3DP38gMJTrLXhDuqiVfGy1jTsEpkSyv
 E0q9gDSTLnoawv+Xrc91MIgxC3PwHiAzcl21G8Q9x7Ck2uShXzz2uyj0oFCW5Fu2DvHTR5HPsWEG
 oUioFkPqrOOVQ7yRGx7YZnYuoueVQufRsZFnIPZojKOj3SP3K8Z2szIZBdbtojnB4hQw5ijmhAju
 MIJZLIiKtKpBGCWNwQKaZmTPddN0hXdntvxX7A1iGMw2HyNOjTWNabtBw3N7VXHBPtHYoVn25MVv
 PtlessSrYHRn1MKoHtNHIYNGchCqb09XHExWRcB1tIeO+fCnc4Y9utZH+6ufUNgX3t7QJ1wMEnJS
 jLPhiy+C9MjE4lF2Abmp0TA94McTMCszGVJfp1nsp16GQTqcYYpm2MUiazNXRvMGvNn8VCvbRYA6
 l6y4ISDkGCW3BSPir8g+I2Lt9gzQcD/qLtxPhWtWOkdXaHjksPZt3Tg13akOSajS8dAEvE5gIfjU
 FYaZ70OVPBFsg2b+TX0RgXXZcQB7m5GQ/sWxHQLv2v9MX3RpC0MuYOCLAblUmLhczRSxuODp0tvc
 ZVe0OAcbJ54BijNakIVxzxPBB2Q+CtUmSwSvl+i7KAq3MwkCW79Hpppfzj9A3Sp15i6W0TdZqDfU
 XHx3GlBdLBaEFiDe60qlUoVmTWCWHWK2JpRkqRb5R/aGgSrRUhlmX5vYjrhbK6vHIvz+jVfZGneV
 WbS6ZiD9gXY/n5KW27T6vY7r9rC8L4ZLowzKsaRpkv0mj4fPy+rJgSfi5g/ASGKZs0WO9xqImmiq
 /UMQms6zKzFtiwD4vu0z+6uqN4g7sYKlZiqHDEmtV7o3g7Y0WlDJfPnGV1kLpRJkmlDyrrtJEhm1
 wbE4ngshkybWATYRMne9cOD2XRv4BzC9r5R7LFB8YzhiMiTVHjM1vIMuUHYyCPXapPfdjzJw8MaW
 RPiXPRV5UiZv3TnatsDHwo2TtOLw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <68e6c603-95a0-47c7-93e9-0812964aea18@qq.com>
Date: Tue, 25 Aug 2026 16:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: deller@gmx.de, linux-fbdev@vger.kernel.org
Cc: sh_def@163.com, nihaal@cse.iitm.ac.in, u.kleine-koenig@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] fbdev: ssd1307fb: fix NULL pointer dereference on missing
 match data
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

device_get_match_data() can return NULL, e.g. when the device is matched
through the I2C device ID table rather than the OF match table. The
returned value is stored in par->device_info and later dereferenced when
initializing par->vcomh, causing a NULL pointer dereference.

Check the return value right after the assignment and bail out with
-ENODEV (releasing the already allocated framebuffer) before any
dereference.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index c4fdecafd856..4d185c754284 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -665,6 +665,10 @@ static int ssd1307fb_probe(struct i2c_client *client)
     spin_lock_init(&par->damage_lock);
 
     par->device_info = device_get_match_data(dev);
+    if (!par->device_info) {
+        ret = -ENODEV;
+        goto fb_alloc_error;
+    }
 
     par->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
     if (IS_ERR(par->reset)) {

