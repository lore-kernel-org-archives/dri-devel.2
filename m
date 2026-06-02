Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC9CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE67310F652;
	Tue,  2 Jun 2026 22:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6xwOF2U";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F311B10F653
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:40 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so4553208f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440519; x=1781045319; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
 b=l6xwOF2UCG4ADrNxHvUIYa/QZz1mF5yLwB9hdyB+lsczjADqdoLPSYaQzMaD47rwXF
 QKmwiiKeLgjqv/YahhTkJz+QYMknC1U9+W8+7cucA20JsqoSr+DYJh/IoJ4zXybfkel6
 FA5HCDxtKZiKwYiegIr9rQo+UgVwfjvx8wgWSMVKyogOXBCUlPw8Z0Zx95XcGj5lWgIZ
 MBtxbZ6xCPNMQIvYnMRbzK+JNpirIexjf6cmP2ztYUN5iqsw4Kp0o77ZK1mc1Mc/lOHw
 3S/OG9IunMuL37Rxvxr2juPxkylTm1q1XEWbjqc/P2OxMXbXSyUgr5WDhHD2iHmqYVkO
 F8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440519; x=1781045319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
 b=qTTe8per9HsLBv+oU7xLL3ixfAoQg1KKVY2hQNiwZGm6QXy/nqP+eup0eHgjviqlKG
 MwEHSv25vakgxpcyebeVHT3VLwiBnvhFNRBtYwJARY/iW9guTUPhGhOBV4CS4Jwe8xz6
 dfAwEDldS05Tr5I6zC0bZguJ29aSeBO+V43AJm0xidWs/mpjtk3OFogKzxqdaIbjDMFQ
 Ghql97sNs+CGfuMM7uo8RIBLuIm5OWYkQvFH3rZ7GowaMOXj5NKo04LchmyQgLr6hlpA
 cq4Ftp71ZgZ/v0jpfMc3IA+LX5YlkxSKhMvUCzRWOhDaQxmuabdZH98YpCTuc4aDb4DF
 lWpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tM6RaarKjwgYxLy75JVSbNktRb3BILHFZDXg6e0jkjEwZZ85ZPe7CIUmIlJtsh+q8XRJISH5umG4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD3s7m6nQaaRGTeyYuPtIxlcr4n7xukJhnvyDnN6uzU4P0OuEE
 lr6SBKatptqixdDuJX1hsGkLzDjN7LsuyurViLMPfyK1qNQRrGozaBbm
X-Gm-Gg: Acq92OE5Q6JRd2l4jEZZNcTPKcmYDegAOl50KCHJbbLJIluubRoQ5idsVgVz6VyDBEx
 BRDyqNuDT3hmnaIrVbdE6BZFW6fOTkaGwO91BqDYDUm3FN5RFRnsszUOnqKK2ex/P2NilJCceIr
 ABf2dJMTCMxlqN905uxkJTfqPguRm+IPjRXw2Mr4ZSrc4v/pUYzYbOkOZ5wvYbwa6mcdgmL3Xu4
 Zp7B40MWxx9OykoB8yPzaaxniL3uiCNHIRq142FCwgxfeqbMO1nB5AEgx+wG3fxBPve/TaGE3/m
 Osi9A2LgOHmmK8INPuKxmLMWieF5wrBM5e+jS32QYCADT/KBsZ0BYN18bDMTKjebU9yYdlH+WRW
 28S4CAn6pBAY+YPpb+lek0AA8k9om9pcnpci3fv3NMQMU6MtzCSUmb5jLxPpOcV5vlzOh5RnLKZ
 QVU+9RNy3j0uA+q0he2ELn6oy9eeXqHo4QRTcnQwfdMA==
X-Received: by 2002:a05:600c:458b:b0:490:b409:94f4 with SMTP id
 5b1f17b1804b1-490b5fdcda1mr13028365e9.28.1780440519473; 
 Tue, 02 Jun 2026 15:48:39 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:07 +0000
Subject: [PATCH v4 10/25] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-10-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1309;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
 b=mY6va1q+pplf3oiRh9kAqV2/4rkm8Jt+FXjkD2G7wa/YV3UYCu8KlP74E8zHuHM0fBwUW7QfI
 85+dFL9KEusADx7bjdzgWA9Z4a2ALDbaZGX4b6jMBC5KuU25CaW5OCx
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

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports classmap coding error condition, which should be
   detected before review.
b- SHOUTING the error makes it uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

