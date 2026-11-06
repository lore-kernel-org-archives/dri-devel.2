Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0D606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SwQktOmM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0210E060;
	Fri,  6 Nov 2026 01:28:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD58910E060
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793928498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
 b=SwQktOmMK+OOPotnjTMjhszEs+5+twyPTDGjrEicxXDrRN1biVnWIFS88HuxlH1O4AwJpV
 44e/caS7LThZkgBcQPnv64BR4vKEisG//a8qiBqMdxMiOB0a7CCiNJg7bdh2DjCXUYJcYh
 kTPQOycxSUL7S3Xc+9bCKkCILwqSiI4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-jdlCTDKOMTaBG2fthSZ7Lw-1; Thu, 05 Nov 2026 20:28:16 -0500
X-MC-Unique: jdlCTDKOMTaBG2fthSZ7Lw-1
X-Mimecast-MFC-AGG-ID: jdlCTDKOMTaBG2fthSZ7Lw_1793928496
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337b591609so1143201cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 17:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793928496; x=1794533296;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
 b=pHgE4JzYYLxLgYSxouxw8kX8p780J38pjOrlBuXcupcXVmJgiGt3Ko3gL4x01L/LdW
 wdfvJgAU6dult82jBk/0d0mUIbNVaCYX0wCd0kAuAk/BB2vvxJK2ctkS9VY4aNdoUv3f
 RTHvdSbj16D0KGsXr4zUM6HI+zJDrzsrphl3ccD0kkwssNCeWBZ42vmFOfzhIUUdQCLG
 i0odcPJuwi2dVzTbTLowoAZWx3h2OBH92LJi2B+lg7seRLRnUy0bKoajXxbSj49Iulww
 KnGH6pfai+mHfqljXw3cM3FtYyjARBYtHi/abCNHm5xYQpJOUQ73sRsgjVfisymgzBOP
 Msyg==
X-Gm-Message-State: APuU4Z8rGhLJ8dSNTVwJFjbkZHPwlf1bMGRG6gA1vQbAuURh+YMkwG/p
 AGWzvWrOy0NhnvnH3k4X831fw9Tf7dLuF8d+lYeypOhe1IPwcAFh74JRAs3mmidjHoHlyhp/rgn
 /FpXPBwKpSXL+vFJZyOJz8cqCeOaVomx5Bv8nSnGBUdkbBD+wU0CH14+xuDdEBlxz7JtFHg==
X-Gm-Gg: AYBFou1CZow3Om9XmIN1yUXnIwl3jBDn3PuiED+0YeZlxXSfweJj/DAHZ/sn/uvpNv3
 fD/VvLaSAAfF3kYU6u9mK65FtrGcnyf7Z/suzccq8CoGIRhccvO38DxYab8Ss0T16ZoZm1N4ttP
 YDgt+rEvbWwN6be7pObLZ0iT3zefkpD2q6pgEVPueNUStTpqBFj6wX9kDOjSGVM5VRmdvbE1Axr
 nvPk9S094FUM8y7tSp6A7FC0TGWiuSFywO7xrwuJj8gGWLKZiO0wlc23A4Eb+oNoCbFUkd4r8IY
 MA/m+XwIhtwKqU78prh5IECTYFlSz+2AUUWf6257lYqTr7raBPOlY1ntcXIxUhBIE+WePPyEEyI
 Iq7j/xgiEw2/Nvo86sWoUlD7NfodREBF9MjfQy1FE9ofcqiA9UU435KOyWwjqohKjEN3vFRYkAV
 hUaNBwkuce0hZFdRpK
X-Received: by 2002:a05:622a:4c0a:b0:532:9b14:96c5 with SMTP id
 d75a77b69052e-54e15762f20mr17086161cf.60.1793928495959; 
 Thu, 05 Nov 2026 17:28:15 -0800 (PST)
X-Received: by 2002:a05:622a:4c0a:b0:532:9b14:96c5 with SMTP id
 d75a77b69052e-54e15762f20mr17085971cf.60.1793928495520; 
 Thu, 05 Nov 2026 17:28:15 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea68fc43asm8983646d6.3.2026.11.05.17.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 17:28:14 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 05 Nov 2026 20:28:02 -0500
Subject: [PATCH] backlight: aat2870-backlight: convert to
 subsys_platform_driver()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261105-backlight-subsys-v1-1-ee9e4cbc8cdf@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWvSSlxfRSzaGgyCdBAi3l2x/
 JJz/gsYHSFDEVzgcCemefJQYQC201OLgmpviGSUKCVjYbQdRmq7VfBm+GShUp3rpDaZNAj+tjh
 s6PiSZfXbL3u069uB+34AqBad+XQAAAA=
X-Change-ID: 20261105-backlight-subsys-17a9a6db80be
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=H2Ld4en7JsjVIIhCDl57TIyk/SGKDX29aUAga9OP9iU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLe6mrezL7W5KgvfvdaGM+czQYGWYu0H1t0fz7VHWW0V
 sRNWPBPRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABM5uoGRYbax8+fouQ21RXqP
 jl3hvcV7cPWUkxfcj1dK2OQsbuvKzGf4X7BCjlXHm4cve/05l0Mie3cdcmLyn/WO+yPXMt0lmm+
 LeAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: di_tiwdTeDKcYifhbY-3tEnpLerWm-OJJJ9Z0Asc_K4_1793928496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce boilerplate code in this driver and convert it over to use
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/video/backlight/aat2870_bl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842..2428427e11aa 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -189,17 +189,7 @@ static struct platform_driver aat2870_bl_driver = {
 	.remove		= aat2870_bl_remove,
 };
 
-static int __init aat2870_bl_init(void)
-{
-	return platform_driver_register(&aat2870_bl_driver);
-}
-subsys_initcall(aat2870_bl_init);
-
-static void __exit aat2870_bl_exit(void)
-{
-	platform_driver_unregister(&aat2870_bl_driver);
-}
-module_exit(aat2870_bl_exit);
+subsys_platform_driver(aat2870_bl_driver);
 
 MODULE_DESCRIPTION("AnalogicTech AAT2870 Backlight");
 MODULE_LICENSE("GPL");

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261105-backlight-subsys-17a9a6db80be

Best regards,
--  
Brian Masney <bmasney@redhat.com>

