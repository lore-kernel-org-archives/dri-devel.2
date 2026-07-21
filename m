Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9566C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFFB10EB67;
	Tue, 21 Jul 2026 20:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ErxOkT5E";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A7510EB5B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:30 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7eb64371a2aso5147665a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667450; x=1785272250; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
 b=ErxOkT5ElgKPz6YBPwlAchbOThQmP4WnzbdsRSRQ1v860CEZv0cusP7rc1AjFyhxzm
 8wzz76Bx7PA+x8izPvKM1jnJ+BDLmQ71+ZT6+Ghccg08IaYDrDgGQiG4/BfmkfeZaY6p
 l2tilRBubR1WDTa8oJhXolbMspyNv7sriwqziLXHZFQW7lGLM0CcTRbu0D4+/UG+ZfDo
 OL3jA0ZqEPT0nzatxLAKJaqmEAt+z/9xQGu1W0mzCe5DEH5XJMc8Br2HVXLpgLoo3eJD
 4pKXxm2U9rKfiWIcWu8aH3zgCZcOreMIPHIrUgQJot2TC06YqwQkZ5Wusd8faUwiGUH8
 b4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667450; x=1785272250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
 b=GB30CCk7xCBQBlrAMFLruWd/i1nPadVphfRmhy+8JfHYg+iug0tqjiTzhXJGDO/z0A
 EX4hcDKingM9QdYtlg3wVgtUNaxdp0leW/9ybG68dRlL7vgPDhs6bucIrQDy3CniseKM
 pG7niKLEkyLuapt0rq/zJNjRA1TZ2BFxs4NPIEY89gKoYJpA+tyxJeXo1dytoMopOauY
 U7t0emhPmygIQozFidEbqlyJNdKQuK6PRyHbBJsPY8l/jM6mcX269PAfJYnJYX5QVK2W
 eb5u2FK2HfgQp80D3WQicy9UhWcB/eKmTMHPPceHBUKrcBCXDQC3kWNUXidQpTNNarlL
 1Dxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoV6qttyGOln26C6K+FEqQibrVgW/dSx69sgnAD2GFPapIgOSfZ+bl2cirBCKYCqmp1lAhIyTkvyME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxsSQhI3xCTrTaDSFnEXP+77dX62uHImKeFJUB/2j5WWxdakiI
 Rc6F4ohRywJ3QJL+lQMj5ZgMpViV0Vs3rtx4cramS3BEzgHX+l13IxNj
X-Gm-Gg: AfdE7clg9DkX0UH6GKsdKYJs3PKDWAg+lpu1vXJ2emSpO2CjYNPO3BoOQzpVrdP0TXf
 +CRrdsbhtcSm9mIXXioU8g6zuYABfH0u1fCPvVEicx0K44Zp4aVtBcwJNm+SwnLH8H/6fVOjsQS
 ouTRfY5iTPqWOUIrXNo+1CZqYChUhHM9uE+wLCj65Qgi6nRCKYP0z+XBu2gcEjSY6pylf6WAaA3
 ZpysiWO+w+qR7KJwVMbeL7Gcv4mKmGFmDuhZqfx1ul+r8LdfJePSJzQXqlHylYjg+FK21VCSn5E
 WFvoTK68vKj8h+/57/rTvgqSlGY7JMijiBHXE39rI2tmELw8ewAZetiPeloT6wXAv91XErUXgLD
 owzTStkmXxYkUik2pLKuNsd4jGl6vH+teW/CnbQ3X23ohfF9rl6W0vAnsEm3dMHcxN75Vsx3IHa
 O3rJTtG1fUj7lk9LL/TOBs6wikjp/hVba/eKUuZ99+IU+7WNBsMOyedbhB9+HGh8n98ZQSUtNc7
 F4lRVIPZE+DVKC1dcDsilXfVvJN94oJvFJD
X-Received: by 2002:a05:6830:349e:b0:7e6:fe3a:b777 with SMTP id
 46e09a7af769-7ed9aa23f9bmr12810053a34.13.1784667449716; 
 Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:04 -0600
Subject: [PATCH v7 15/29] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-15-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
 b=N77P9AtjJFwy7FzRMr8In7kiy43wJO+O2C4iqOk47TEdDfFmP812nSRahvaUv1gzRqFViN7n8
 qgDCrRgljrVB76lmYlUQv1NGsjwiR6T6qctOUDgUkjgZ+pHvjsdGWoP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

