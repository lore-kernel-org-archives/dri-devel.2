Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA99CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4672210F64E;
	Tue,  2 Jun 2026 22:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KdCZvhkR";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F05810F64E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so4335610f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440502; x=1781045302; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
 b=KdCZvhkRjC0Ngn3fqpOBkDP7xfrXW1dVRxRrOEIuhhKnP3SNFVREUv6taTz9V6ABuV
 rnAR9Pf1A9eBQSr4/YdoplHQg/zHbujStLt8onBmCxwMBdD9SEWdxRZ45z4xFwNgyCQT
 ZQnaR3aJZLmUbgIj/ZHuhM4dm6NbIQv5TBlM3dLYHAXCjOulIZ4QSYt5pJVllu+8DfOl
 QlSZWjjdN4AA6+8cmBsB9KdCCqUxgUWzVuEJqmEruNGYnYO95kfN17fwW+QUbpfylisS
 B5KzVFw2KsK2k+ahNobOoFLpAeqOBoSS41gJkUIikxmkN+yIFkqWeMh9SDfwZaO08ArG
 /TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440502; x=1781045302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
 b=CeCSEaQfX21ftBc10YXPiVN8Vx9Os6ziH57En86f6ex2dnj9omuN/+aWe6OGKHjUkV
 bmxa0Trv33jiUDmuhQvAl7PGg7APAfqZ2i9W3jOC8at9XZCI3ZgRIyrwE3PtGj3jmRg3
 FvJlu1TrkKtKoEJm9aHXOmsiTkQPj3o+tz3P6LDGIw5zVk3aKN6+S1UrRn5UWIF13Ht1
 zuqLkPISn00dJApsm4p6lrHMdSSqldbGwluntM/5K/rSBsvRgWNOl2i3pUCa0cgL1hzp
 lGWVOr2QzraatO+Lu0Z5fy4aoylIDqzKduz2XjE8qrnCQlaBkvxmLuSmMMkijvmcu8dx
 QwJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8t/mT0FFhaaquqb6I6MeTmEfNCDPw5/vG9AuWNvU2SbNz7/cr8GuHvbCeg+3vZ4TWMI+Hk7Dvck0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlPm2u2vEjx7miqx1c+c51J3Gj496USvUgPHgRw4YhqVSZYUUn
 31UdGSMA1VQpJgLxPLeuJvzkioDyBHAK5YKdsXiXXaG7c8XeskJwY90Q
X-Gm-Gg: Acq92OHba6fjpEbArJolX/gSTiH8kZsaeJ2JvCCc/cbF3XjwkiuYjcQfidwuLzb3oAN
 kl7ro51PZp5Ntf4KyrVKroSDfmnBG6hIYf+6wWjD2Kudm2W7Ad3j3E03Lq7vvlcpav+58t7fRFU
 v6dXKgK6UPLCtCETWv+HKhxt0HJJFXWkLWTtoiQ0JX9HtTiqB9oS3dvQFXS0X/odYwh9gF0fZxk
 M1DGEb9NcsiRp0eodBhkrIMvieE4HKZw1uhjRE9Fg055H4vjiNLDSNhUdSIRiABBdTfswZ1fqR9
 +DnJ7Vg7GB+smEjohQMDWYj0ayjJUlIQlLYN4IqX2I8rJ++LQyaF0Eg3AbMLsjeCX4kMP/wB6OF
 YK1viTOcdi8iHO7w8CkM+ao0sKmX8f701QYNjFeK70QACCbTC661mke44kvWAUcPmik5Flhx4iJ
 HNu4L6hYSMhPzqgJaT6BhXGuhXCCJeeKpKTF9cPtm/6B4redmDLedI
X-Received: by 2002:a5d:4987:0:b0:45e:f780:6181 with SMTP id
 ffacd0b85a97d-4602182cd9emr456749f8f.23.1780440501948; 
 Tue, 02 Jun 2026 15:48:21 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:01 +0000
Subject: [PATCH v4 04/25] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-4-19a1445585a8@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=MvsNf/S/xSTGRA+QFVkd0l5ykeS++JYaB1FrXileFx3gCJmyjVcFCFJQIWqeiUZo7GqEj3BlU
 9d1r+RLMW7bDHjfviGujkjn0nEiFeEV5seia07THPaU+H02yfAvWuLZ
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

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

