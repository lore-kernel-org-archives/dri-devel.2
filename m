Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16A5F3D600
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFFB10E0F7;
	Sun, 29 Mar 2026 09:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vp8C/7cq";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414BB10E0C3
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 20:43:23 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso40015955e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774730602; x=1775335402; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
 b=Vp8C/7cqm/GBUynwI/8gXDT/+wvnKQsTWoVt8NS1yZ3QxkuGZdyY7YWVvy+FV3x9ec
 AAF2EStZUNpmsibSZd42BAW1VkT51ZDi+9xc/AWnpPUJVsNG/4b+DVHL/cc1LhP1pXfH
 ioHcntr11xOp2j0/MgygdyZDvle3yJXu54q+RNqKUKImLe/xicmtl8LiJHXZY41bdTcL
 kko3IxsSVFnCKFZ91rSxQm2BeYEO1UkV5yzow07mZJWklTuyeq6YT17si3KjQVV1BODR
 zjPeI1x2RzWSROCaliT8nkAI1+ggflax1COlV1Rfvf7LSul0dAKjKDAJwtQzgrwFbFYz
 XbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774730602; x=1775335402;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
 b=mSZ6ERrKmS4Bl+m/If28Sv7P30vgPkXlt/du+qQcDEdVhHqkQ523KwtwiInGCrQ7/Y
 nWn1wrvrcFPe+1ErsB/qB6jwyfa3MnbkSJFZnlJBx+4cWYq/jvh+2Sc7IpN1k0FoKw3f
 /ELFL9/nAZ/7RkjiW8rQ9ZJjrUZsdBxU2tiOjudx4HdJtnX1BB4sYrdqa5WI/FfWKbTJ
 OQMoXooCH6hhdgjg8JjwIOstNAGvuJ0Ovp1uyZgepPx27A2kHyyCx76tgVgbopeNaal8
 zCGde35uGfhry0KPn3aqpefzlNcSiUBq/PmxWF/qvCtpabjAA/eNCQuyLD0dKw5Qom+B
 BaXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI2BoxRGmZsklm7b5AR2uTm+vTrbUQt2zfrljUBbV6Ux7TI8XrloZONmXyejI7udsWRBUFffTXp70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdxN8qvLVv+ZEZ8OuoiEFo5wNtLSxoePkGCYu33Ci6ETt2wmCJ
 HpXaGIcV3awZT8cW6XfyYJN9RXd+QrExYDSMUa5UUyAWTxTqfdfOC5fH
X-Gm-Gg: ATEYQzwA1fwA/54CMI81p9n9DaPAqKgGPdfkIW0O/w8wuNWOvpbRZnLr1DJuIxn9hcH
 3ltmtWisB1c4jCcg5jsxa7SvBPtfWcvfqF2k9oR8INTCIVOHg+lIF4LNZpUfAQ4TmmFyZDoUy0e
 JEc7FkFLnjulZAFHfLDkhEnFC+mQzdMIzw7fK6ZzfbrpgwXRDCgnmuUr8eJVtmrIUx1b5txrU5u
 5YFaENt9DR/aSkwa/c1P0quo4EaLFu0qgGL3RIeLvmYrDLLveJYXuHHIJvQ2KhX5aqZhz+NtZ1e
 0HJJQrpj9PCkLsztQjTzK5uzwV7BheSQ6SnYAZABVSe7SHvXjHEgkT+xwYQXDeaNRnHXn1jE8jV
 g4F0wN7+MwY0JzAf2pGbNERYc/xnf15e8GxFEEtQhOQ3QJVHYwwEpke3nXO3zvOS+QcnmHrkj+k
 03tvPYNTzBoWvygILgY6cZApnox8KZXwQRhlpIcypyyurVfp3s2lT12hZ0+wNeNunxn5Iey6q4T
 OSVtKiCxtFsGZjKQ0U23dwQPw==
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-487290a9254mr102394915e9.1.1774730601395; 
 Sat, 28 Mar 2026 13:43:21 -0700 (PDT)
Received: from [127.0.1.1] (93-140-187-240.adsl.net.t-com.hr. [93.140.187.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730628efasm109519825e9.5.2026.03.28.13.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 13:43:20 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 28 Mar 2026 21:42:16 +0100
Subject: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MT3eySFCMLA0PdglzdtMwKXUPzVAtzQ9M0i2RjcyWgpoKiVKAw2MD
 o2NpaAFlB42dgAAAA
X-Change-ID: 20260314-ktd2801-pm-fix-17e8715f8c37
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=duje@dujemihanovic.xyz; s=20260328; h=from:subject:message-id;
 bh=ZxchMbxwniYIWnT9R7/2Td04/zp5hTI04KiKc8j4Q4g=;
 b=owGbwMvMwCW2z0j3+uHIyKOMp9WSGDJP2KbHtWVJlUzc/WPZVv0I27N23+16d3Wnzf39bl7+j
 oXvMxyyO0pZGMS4GGTFFFmYl8pd4ksNn+hQZJsEM4eVCWQIAxenAEzkQATDX5FW8dMPdCXrznXM
 nLJB0ap+xqH2987aWyZUy7s4d+8MS2dkmPQxZZOGwjfGGCXuy282TzVXupY8dWbx9jULg9O4epL
 nMAEA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=9BD463017690089DAA8DC266275F544B3B1B4792
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

From: Duje Mihanović <duje@dujemihanovic.xyz>

Boards using this backlight chip do not power the backlight off on
suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
the backlight core on suspend.

Tested on samsung,coreprimevelte.

Cc: stable@vger.kernel.org # v6.19
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/video/backlight/ktd2801-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index 17eac1b3bce4..1b1307e03b20 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -53,6 +53,7 @@ static int ktd2801_update_status(struct backlight_device *bd)
 }
 
 static const struct backlight_ops ktd2801_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = ktd2801_update_status,
 };
 

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260314-ktd2801-pm-fix-17e8715f8c37

Best regards,
--  
Duje Mihanović <duje@dujemihanovic.xyz>

