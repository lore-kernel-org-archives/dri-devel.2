Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C18CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1104E113269;
	Mon,  1 Jun 2026 12:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTfhcwWB";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CA6113277
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:30 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso6756725e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315529; x=1780920329; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
 b=OTfhcwWBTuP6zmcjTSr0yQOUH+HSNzklsl3c00UrAdkSQ9Z7J0RfLxR4G4s9seNUpX
 u26bopq0FqHP2LRqS/G3hltX2MicK/daL3MUAIbB4APK0BdJceTBukYXphH6GtB24wbl
 p17OBt0qR7Z7qUp8TZ6/INetZtM+G82KNAqxoNI+EDJMsQsueTyStWannm1CD+2B/BXs
 U01ocA2cwiiTt7Akf3qBwO93uNmbIf6KUL6tQuUbokSzBNXPn4oE+EVPC0vU8EEEL4oK
 dV3YNkn9k0DyWrCTTXm1dmoVyfB3r+Ylt/4mdwEjNKrnSEHZp9IIMvHSiwTvfHo9qr2l
 ftWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315529; x=1780920329;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
 b=cgtQmEOS/18LGJxePM/zxCieI+82QNp9xbLE0KZHUztdJa5QNOUObUintoKqeLJipI
 HKl6Nj/bepmrgBU1WWEvNVdSuAPAagblLm2YDGxN8aqBiVb19hvuT57XfeK1kMRDVGZl
 1RUVgjnwbBhVj+PMq2oG7em+4XUH3C0hLpZsqp6rAQVUAEVJydyeL2IlYRujl+y5/haO
 54GuwBCHaGusyjW8zPMwlleY5upW/iF83Z6sqc7298GZao3UsrK+rsS/4SDt0sJAbSgY
 WqVfB+xYonP0qcoaCNmjK+y+xVLCf3oOb2avgj1lsgqf2aOjZmG909kk/gL9phTBwdk7
 zOkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ysK/ZOQd1lte69jw4URmhQfStD2MTTpFSIn/8HoUJs8NmQnoNToFtiKtOC2hZqP0IjpevYU32qcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIFnIE2iJGW48NU7mJAOpztoW3vXwQZ2MMiSoE/uUk11FFQN8a
 7HSTClkKqhXhHgugD/pNHTPfJ6b/XSjgm41kUamhsPN6ywrSEcbTlZad
X-Gm-Gg: Acq92OGs3JBhSx/mlbkOvF66fPYUWx19kbEmzM+sDsq2tzUbz0FwLgKiJY0BpEkGvLt
 7UnhWD2vDHz3GkXGgLaINuZpdTmWO9NWvMG03LilPm9ju9wq8Qo67fHD8vwuk3M1d5Bzy/LDPmq
 XddbCyEOIJplQn0xI2HaW+NUa+gFQPBjrtnrmB7+arsnpUlDKmOCCX42mUL0SVaAtGT5h/nJmv1
 YGsQ6FqbQGU17kxkLYMvQYIe/pvR4VQE2TorelgobUHiP5j8qzBgG4pVIzUwPzF0iHtmDRo4MlO
 SeZao+69rkn3FYuDCEUe9cWxUb47Mz7mM/iaPzrdHKbo/4f5pLnI7wgRkGqw2TOjLccV9EbOWcj
 /dxcPapnpVptgi7gACzXioc0lSgEHZ//FsHhTSUk1+wyV2zIe0UXqtjWdwzPFVplZvEcvVcxoj2
 C53LnujjnkUBQ5dBsAYCZLHdfjdO++TdoLPEkP+jcBrA==
X-Received: by 2002:a05:600d:4441:10b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-490a2948034mr141224245e9.24.1780315529177; 
 Mon, 01 Jun 2026 05:05:29 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:58 +0000
Subject: [PATCH v3 12/24] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-12-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1065;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
 b=6Dddfxtl4gMoLaO/5GP5/dyVmNyQOwcvkR2lM9WQtjic7D5PcmUL8Jdh/MJm8FRhW7WSKe5fr
 tDjKU6mMNzBBSyBqZxxHUogeQgkpnJ46lIJQQrTED6k3CUybbznd6pc
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: include linux/array_size.h, correct commit subject
    review after sob
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 78c22c6d2312..867e3978675f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -121,11 +121,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

