Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A565FC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22F610EF8E;
	Wed,  8 Jul 2026 02:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pxc7X8ax";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F41710EF79
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:44 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e9ed64d490so86188a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477123; x=1784081923; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bZZkJn8HHk752QXiuM3ujnnoUYImIUksTU2DD+Ftzs=;
 b=Pxc7X8axi5mvvmJ6JwL4VO1sqnJ/iIUWF+79CFvzroLhxBQ7cdUFnVsWHcnG7GllbH
 LtBuZAuhIgIn2beB3JDALtktXQpRH85YAj0MlWATTRCT0d0dqurWhmaORSfcBBHzHILF
 waQJx7IkShzsVk09AR2Ulv9MFgAQVws3p7D9nXo9YJER9QpiPkJVIEDwqwZjnKBbhf6I
 jxvTCOCOqmR1NP3oVtxv4XMxGT11QNBJPjfkYhyJT8nlsHQPcz+raiPuGAka9mykN3ps
 Q10V4nT+83YND/TcuYBKpVC22/iMahdqujx8Eboc1g/TV+ObfH2Se/G5vw8pwCU+LKFy
 2XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477123; x=1784081923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+bZZkJn8HHk752QXiuM3ujnnoUYImIUksTU2DD+Ftzs=;
 b=kS76IC9SpkseVnoF5Bsuy0dmF+wWG71TZGl/fIzWhHpcEVDRwlHfXOBMrwwHd9/oxA
 wLe+VxnqE7aPWhVe+aoeuBju/s4AIQ0r03bhPItCqv2j9T5SMtyoXN+jD0/Ovw3MW571
 eE6TtY3YfPN/LrKyUNmcYSHOuwxllLy9SqtZ7dVryKlJE9SlKajhhcC4tplJ5JMB+0Ah
 kYm3IqhN978kJ1MMoFLHKBLJatek48rKsoGIFF3q9OCnRRkvIbqYIPJvPiMCtGtEpgyh
 pV568pwNNfwF1QCDiRSYzgHf6t/Ss4rBl+QHJJpbH3tM4EjY4QSkoftjMcGPl8323wv+
 6jrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ999TZzEOoLdYVLF+8ZMvQp4fb/ZLmEFtdgiGKpxtfAzD1xmzH7GWIsOcejRjiFqcevSbwHr9P+tJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2F6T/FL6kZ7N8MErTSb5VbnKUreI6vfueC2CZPICuns/RLVdn
 cK6Jy9TnSRBQjC4XsbtyTFoUDvY0qBWJEYn0kJbsiL2wio9ARK7C8LlY
X-Gm-Gg: AfdE7cm7VXEHW0z68DFiFC6WqB5qbaVm3ryWIe4hHPWcXJqXYmQC6W6mS6Q+5vj8Sxm
 /K7aHe1J929TQ3cMBBrDt8Prc9PKYpCqL6FHtV5An89VDn0BWaDVhAL4gaqVrL5n75P5GdSkwVc
 OizxsL6gcyDlB0kgT45O3FT2hBl3l/T19N9X2zwt/duDjRzxQXyxtGwAbcrEWvj84xV0rxJfGx3
 WWUyvP5tO8efJdbbDjK2cNbMjjbKEu1zFyB+GwBx8nvcT1CuGjb229wTjxHvQVRdosHrFeEFZAd
 K0A2zSx/FVuL+BfCbjXE+MOoybmpmDCrjOPG/6L0lnY1T58oyx2wO1GZNaYOSJAv+zvgjhntR1V
 R0hYJHWsHzoHrq99pdI+kbqhe87syNoRYe+olJmh9ovB37N2WWHvgmDDIJhiCMguNXeYL0Y+AU9
 mfi6IL9vDQMB7rhfxTbHf6anfFhuU+2X9cLo0/NKlOydae3nI8ouM=
X-Received: by 2002:a05:6808:4489:b0:4a0:96df:d25b with SMTP id
 5614622812f47-4a2043cd022mr314410b6e.30.1783477123155; 
 Tue, 07 Jul 2026 19:18:43 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:10 -0600
Subject: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1538;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=XQqP3CGhUC4Qf0a8iBvGk8T4hUKPih4ej2z5w1J7I+A=;
 b=PIPrAECRZ0zDaTF7+iZRCBuVAOdGqa69o6EfhQnrslAWBa5zAEuRMzEDoA8dnHoDXD/9BWJ4V
 6EUQyIE1KtYAbI3nCiqpaQWMNLdmPAheFdFtxbTDgxWqtYEFjbJO8Ah
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
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..9ae1accb9bf6 100644
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
+		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

