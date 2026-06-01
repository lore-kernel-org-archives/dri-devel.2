Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196DDCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790D4113276;
	Mon,  1 Jun 2026 12:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jd6gwO2z";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3911113275
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so68931785e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315524; x=1780920324; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
 b=jd6gwO2zCnip/AjlJc5KueaphTluIveVo8TAUE2roQDhFTmGNjs3p+0i6y3UZMCR1a
 q4JeLEdc2L+0JbhrVb6Fo9cbQw3mQfuuHQA4IrZ13m6yS531QitfHrFJbuNh27urzK41
 +UqUsYMmW7PvYh8413PPRk9hUs3nvEdZWuxIi/Ba8HHsr3zhzoFO7TTPxw8pUpOFQxHE
 oR6dLtml10ryYBl8JPwT8uY0kIUKynKuiSOqhssfnFv3qaCB3GiJ6iwhGYGOB1yqt8UJ
 NZDH7zrFhYd1jG/Wsd7wBDZO43eJ10JppmKZchzqQ+MeYs32VTE5j2sDk74vWbhruDAV
 ZO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315524; x=1780920324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
 b=Dos8NUPrGsnq5oe3JEq2L+ffM+xJF/rYErU97pnZW3WhgJxHo/VgCjw4NkFn1sKKty
 HoSW87lRQuRat9YysksVkPlYSaPNA8S72l5zzEws8XCAAeClpryv8xF68VqvK8oJ8uJ4
 gPxvLwGFhVm0VlxYvss+Vss6FboMLa+NH4oX/gaTN9LwXaMcr+x44s5nWWcOv3CyA3yT
 YTjlNPYAGtfmchZAraeCINXdHESYHN6fVm8uPKcEqyVyN/RRdHL/VqyDmPBgf0HShpuX
 kkcQZQA89hmK/QYCJjjvW0v1J8hkS6BBM4o7hozudBKrs30XSh7LlR7ppOvV+UcW5+Bj
 D+VQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1H0AdyIF9VjmZSSlCe7oss2No2G1vOv554xPX0t4srgvJeO7P0Y+H7spUueCwH3hjwvPWTsW0WZE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCHUAU1kRuihFIOR/fDyDZJqRD6d29beuPU/vdLWdU9+gCsapy
 DMguj/3Hk8vDr85MzPFj0cyy37q8Yu7HuR9LcRTorUzhB8UZTryqcLPp
X-Gm-Gg: Acq92OGf+VkXxf4b6I7UIkX+lQI0rk9kSeZISycosK28MAVnhHWbLVbpFXsgJkCmhfp
 /4pKwNi3srM4gWryJZJeZ2TLfJIjUOyoMyDJsya0YYySXVcn+CNCji7L/VD0eFDczbZ7XOWna3G
 Esd5lqROP3yw5Fxg1iMDerrAbDVycGkCX9jvnjoMpIFsNa5ZxXDnA+pl3W1iEYLn9bx8/DQwPn4
 5Pdduv55jZGjVO+JzCexaqmXUDs5GR2HkQVYOm0CdbdobmS8m1p6+qliAQK52jrtwnlSb5G9a4s
 avsom0xqGCj3/Ps1nCav5y5G/JWRUdtJCwdx+SJonjBDuTeXm8fk2rEuSypftIDtdmWT47xTAJJ
 bxxHbvvRkF0NzQZ1RSEfDqvfJOZ8vK1dqXMgzcto5WylN2IPmYU79gjunG3j+8STRpK6gV2lIFV
 K7OPOTt/m4rSq2C3u96dYYxVXUnCpSnF73ZaszW/ySVw==
X-Received: by 2002:a05:600c:64c8:b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-490a298ad48mr185339785e9.17.1780315524059; 
 Mon, 01 Jun 2026 05:05:24 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:56 +0000
Subject: [PATCH v3 10/24] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-10-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1309;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
 b=4n65AvgYtX7DtTVqkK1I41Xodkq0iZVSmLxfv1Y6t8k120KPHW6PpndNmLzsyHWrgFjRlxjH3
 1OE/Ktc1/TcBtwgSTMRYSIw1FJSESkUk8jXihxInLBxLSKTv4/NPkPP
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

