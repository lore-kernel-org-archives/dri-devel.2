Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89848606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nOwC2Fj6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CE910EC6A;
	Mon, 26 Oct 2026 08:38:24 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F91B10E140
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 16:40:42 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-35d0be18c71so3942076eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792946441; x=1793551241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xv9NAEq9hQ0540bja4x3wK9UU5VFlX1ceZODo3NuB5Q=;
 b=nOwC2Fj6acszz2x8zpOy8fJ0qmBH0AaRAxf3i/iTFWXeNviOVQg/I4Af4L7GI2QKGB
 OuqQ53xJ7Vfb5IlLOPPTTDfmMIEhrgIR+T81W338qUraRyCpRl9akDovyB5jo17REM+D
 S6ez7Sf3o82jzyCVtxsxQXtKwudWF+euAxP1pHM4pvG3B9qMVPUOl+56FQTCiCr1NcdB
 ZsPsIb+kgbYIPHiJh+BwNIO2OmNLhbjwRaOqlCRWPcygDDQbAAVI0AcOkvzt/bolL4Ch
 viVg2Qj+giTtlK9Xgq36K7gGPU+LnyCGd/lo78Lf8SSzYKrR4m9VU8kF8zutyWRsq8GY
 PR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792946441; x=1793551241;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xv9NAEq9hQ0540bja4x3wK9UU5VFlX1ceZODo3NuB5Q=;
 b=lxY6bHhcS53Jcp+6xSjpJCLW3pCrSmIHrJdYQ8EFDcXajFonylzx5Q47WAQSpJgPLY
 +jvH8dcFXtTrIVYx0upyVm0IrfT64gQqbeb8stdxDXr2VuASD4DiKJy35ZAarPBrj5+O
 d66xJWx+X6Jf+3wlNu/xUcVvr6jOcBeuTUXZMDF81yhPflJXwevP7u954ZIvqH5SYg3G
 5ETITA7gMW/ngpj92Tj1xo/mbTC1aKwe9NwMKD6RpyH8b+c79foY4zp3ogzMlENWiUhg
 CR3rUCjQcejm1wdZbiid2rH3a4D6RrbepnRfzhhp/OXxrkDnzE8Ewbm/mkLCqNYSGX+L
 djqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc68SJcyeYKrkUJA6eoGakKjAelboqmPpAtfcx8mC0Vac1jQ0b/mcA17E1io8KBwFZMoA4vP8zR+c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7OXEWgQDML1EFdktV40W7qpV78bionwS750WwxCHi8Us9ko3t
 RpUVxsvv/5/aTgSFY1ByBOV8LxV/gyeEl4/96s6VoQMnLucy2a15qkgf
X-Gm-Gg: AYBFou0vXIQh+SFFa2Ldn1OTr2Qh+Z8hsL+5cMPAbwVHwXYa5sNiqNz3shf70CzAkLn
 jq/FD6eoPgbS0pIlkeYUjH2HoCsfqoIH0Tx7SpUsQ2sGYQhA9u30E2WTs1yxyoO46ryS/NA7jqd
 HMEsvAm3hPj1svrABRcXhQ2ZXLVNVZnph2Ubt19+xVoRlGN6LzQER7QEScRas0U6Z6Dov3wfmQz
 phWRdsWUgoYB0Y7oL1PLAEQIXivq8BBtd05QCRT3185Tai8aeFRlWiEu3dk7DLV5mTq6KNuI2OC
 ScNpd2NGmCBqCAXOiqXNtTpKspuu0pNb8JXQJ0YBC2FZktcNNVFLEj0EL6SK7rcOIV8WAXPollO
 w7C2j26epuHc19upCZyJJr3AJV9Z3+/rQjKWlijopIH4YtrnQvXge35UqTTAjl4YVCqhmbpK/yH
 vMLoPCKu1GnhM4u0qXRV7X1HI1hEf6aN7vkAeVbFWCny+0MLZaVVQd1cctUPsp3w3Vi1XtMiBFc
 m+poulb3SnFEFi/BvOQ9Sj2paIURujeSc9vQ12hDr9Lv/UBSdKXOb6PNi5dlMciTGZD/5j5rD+C
 gbh3WJQ4VzVpyyu4uBhF
X-Received: by 2002:a05:7022:28d:20b0:15c:a04c:cd4f with SMTP id
 a92af1059eb24-1993fba292amr5562765c88.0.1792946441092; 
 Sun, 25 Oct 2026 09:40:41 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a1bfaebfsm17401503c88.15.2026.10.25.09.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 09:40:40 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH v2] staging: fbtft: Fix line length warning
Date: Sun, 25 Oct 2026 22:10:03 +0530
Message-ID: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Hi Andy,

I have made sure that the \ (backslash) is properly aligned to the same
column as the rest of the macro. I have also taken into account your
advice and hence added a local variable for platform data.

After some thorough searching through the respective directory, I have
not found any calls for fbtft_init_dbg. This might be because it's a
helper macro that might be useful as the driver progresses.

I have also noticed that some other macros around this one have simple
style issues and if you would like, I can send another different patch
cleaning up those too.

I have also done minimal testing by using the macro once to make sure it
compiles and has no errors, if you would like, I can also run any
standalone tests for this macro.

Thanks and Regards,
	Himanshu Bakshi

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index fd7f8fc2afba..ceaa9a3906ef 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -421,12 +421,11 @@ module_spi_driver(fbtft_driver_spi_driver);
 #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
 #define DEBUG_VERIFY_GPIOS          BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)-> \
-	    display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
+#define fbtft_init_dbg(dev, format, arg...)						\
+do {											\
+	struct fbtft_platform_data *pdata = dev_get_platdata((dev));			\
+	if (unlikely(pdata && (pdata->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS)))	\
+		dev_info(dev, format, ##arg);						\
 } while (0)
 
 #define fbtft_par_dbg(level, par, format, arg...)            \
-- 
2.56.0

