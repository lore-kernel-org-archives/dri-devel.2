Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF8FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958D910F660;
	Tue,  2 Jun 2026 22:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcC5JdvJ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B68D10F65A
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso11739415e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440525; x=1781045325; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
 b=YcC5JdvJ6i8AGFHZtPnFkpkpps9BkXCteDHcWnq86W/KVKDPid3SVKJNET7qqoRz94
 h9E0UOdhutDFqHG0JP/293t+iV9JNXQJBYZShScj1bbnguJLPlskV5b/13g4EUfd2a2s
 E8OmFqcGJabEa1kdxnOVW03oZSrqNCGY13h1+SP8kfpVBCfU63Ty8yBZ7G4/lsYWtSCu
 7/HRYk8OHrZ3t3OuajUEflnJFCiHMnSCi04/3t+yVavVcrWggErT23dK7luof6aEgZwj
 QkA4jha+YQWuWQ+kKjDGIHihjMzbyNaWvscT3wsVtZdeWpcB0So5ffwF28xd5eqEJux2
 DykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440525; x=1781045325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
 b=kRovs39xwTXal8zukcPE8J4vpKqRw4jimBjItD60oV55w35xkyOcIMec/9wtMvxopY
 kFkxLqYH1R/5K2Dzl7PXtcponeR6LsQYwU42B0xB1RJm0+XqwRKU81NmXr800aCN5wk1
 /zyhUSFS+KnCqXZRVZ3zGBfjHKyP1oCk6ka+zwNHEbp/eKyvTEtnXeQ9Z66RCfr5K/hO
 HAT3s5EIXnQAZKrsDdBESdTtIl7UiQ6b3TvAkC8eTA6sVuwbz/Y515aq8kvYOoDlazu9
 3UHBB6gy58vsErD0QDJ/gNkvO28Nn6BInFAVemj5M211jdzoVAfJBeImxgP0gR9Bgfer
 njTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94WWKI/e9b/iGj5igHDh4fhy1zUdGNQkTo4SzzbPOwD8+ZA9Lih3nlLvilEFR1KjUCBtLyOD3XuVo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6TMblPLRGfmgu9am/3AuHM1RKfCfj/NgI6NMkSNKOXw3oXJE1
 jgDKtTp+MPiQuuKs0RRgFBTg8gRnVmYCmJ5Rn/YLAg5dGyDU6dOj4ss3
X-Gm-Gg: Acq92OFQb5E9+1Y0yFIVU8gWbZNP18jLnKqR0xvwS8ZKTzj+yPBZfEvwnCPZByy3J+w
 DbbbTjHupqcVjFfduSh3zDtqAdIJgqWOFlc3bDwDCNXHRe+0XkPGb5758zk5mwjtepDZq9QQNdc
 I8TX40Z7L/IaCZJom8u8DDKx4Olxh3dMMLyP9MdPSZx2wOAKE+qIKIcO5XqUzxdXDA7k+9Qdg9q
 SsZyKprTlVIiPq8Ot7CGN9DAiDEafSfevAywb0EzU01PtcyRLNZ9lfMjNpDPbbMer+X8AteQN/w
 wckz5ncmPN3E6FSqR/nc2YsJxSNoskNs6DI0dk7rBJmKljC5O+B4jU6EuoB3t2XBAF2zXVrKRAw
 TQFf3EJhRY9SDOakFCpRpHbTujwpsyNV+Uu931a6Ao6ck8PDSzhHpKr+f8gGJrfrEXkzHzXxCwE
 MZeWw8ymsbZ4oQLJp3T8dSiVjlUMBCLkO4Lziwe1QypQ==
X-Received: by 2002:a05:600c:444c:b0:490:b58b:a4a5 with SMTP id
 5b1f17b1804b1-490b60e0a19mr10858865e9.31.1780440524578; 
 Tue, 02 Jun 2026 15:48:44 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:09 +0000
Subject: [PATCH v4 12/25] dyndbg: drop NUM_TYPE_ARGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-12-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1065;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
 b=oyNMvL7qSBs9lqVN4LVgnejy7txyYF8Shv9mWgJ+0KrkNEc3NqHoPNa6IT5raJlG3MwcHq7XR
 qlFV9dpli+hD8ELBygRyFABvmf4T8xIJ2ymzMxgsM8PRk4Z5FJyAeGg
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

