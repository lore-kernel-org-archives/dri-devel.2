Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F389AC44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C53A10E508;
	Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSELJDTd";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E740410E508
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:24 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6a0ddedcd00so781522eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010484; x=1783615284; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
 b=jSELJDTdMYsiiLL6wHiCoYy6W3Vv3A36kYvChdVJzuK7cEHHaR92MQwoeXRvrLA4cB
 XC0I5onq5DKUGkOGvgv3vQYJVWvwByQSIZ0vWQ7sBr5xHXq8F4W0Z4V18zObb1rD813K
 b4t5bmtQKkIVVpvLD9BxTyhEVeZt9vmufKSb1Al7cpJUNtt33S5FhGWC+08D4x2h2SpV
 We//cFr+jNlAqN4kvrkPtvEAQoexZuY4WoW9Oik4ES+Bedcl/cJvg7w+62rwFClfu6mJ
 IhHAVPrX0etB/N+/SlN2546lkJno7LX+O+k0IlgH2tE32aKAww3rgXm7YXm7qihp49tj
 VpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010484; x=1783615284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
 b=hkKk/XH8qKinm4tBd+RaZ3nSdEKxn1En+8QHV3uNOEfGPTUHc35ti0b/xn4hMEWGPm
 O2uriohUEupYf+nlbMhbfyNSD7MA+tnqIuynFMxYeOXBZCH9MN4zV5scQCp+EA1k1FCg
 pa21xFA1a+RG+TwNITRTIa8xvh1ieD5NbP/mrJSxOtAGVf0gV8Upirw8BzEn3EniR1Uj
 Suebpu71zeplHo/biB9JOaQNk779XBaXJbXrHuf1XRUPNh1C5PxMmNECLnl8Tl4ov6B8
 IL4wjrTKzvNuuNWQvs7RrIdnek6nCJzuebvU60byPkykWEgg5HXVZgcYejK7ZrsfUlob
 0z/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ90xHQO0nrOREMTQunng4vcEQYBP8F69MmAkRB6g0kxTyKcJsOJ0LfGhdKYyxosWuclp64oop55Ry0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7ECzPjUX8cBHQr9y3KQZVeVz9nKOS56p4nMSGAybBVgDfD7ii
 c4mHpi5yisJaDphqJi92U1t4N3IvC/NByGEJ7tEbm2JSjxxw5L8nP77s
X-Gm-Gg: AfdE7clP2a50d//fccG8aG9A8OGNRtu5IKLf0zEI6WJhuNIKNJ0rR5GJSnem0ykeR+t
 V/JssDfRJ/G7jt0BzpcgA5eXWu7qqpipF+KeH/xSxdszqW9wnktajHqKI3e2J3w2NtFPL/Lhn2O
 JLklKZV7jgtHUUJibgRQnD4nA8az0B3imDBTASmtkSqErx7uH4rkt64S3jJ9wS41pn5jYmWNIBS
 qzDPY7vnJC2Nv62dvJHLjTGbsagxMDxmM/2Ya3U51RKCDrUOGF37meepk8VHsy10rgtlJ1obfRu
 L7gOUjpJD0RZfuVc2LqqxDTNgCEl1Nn9hfV9CHvSWCHKiuLcnvj2ciaYdgky12OvlQu/c1DExPl
 0TIeSSEOC590leswuuMGmtssGNZDr6StPmnUsRXw2330SLjKHjyyDQPSubrbmMBwW6VXhuQmW1h
 loy7DjRzj8lFnxYkw4n4cN9w+YHtrDoUgVYJF/X2QtV/S6LLfh8oo=
X-Received: by 2002:a05:6820:4d0c:b0:6a1:5b81:6165 with SMTP id
 006d021491bc7-6a3099c63e7mr4036506eaf.29.1783010484044; 
 Thu, 02 Jul 2026 09:41:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:58 -0600
Subject: [PATCH v5 06/18] dyndbg: bump num-tokens in a query-cmd from 9 to 15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-6-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=q0cqBNsjJhq7nt/Fn+0S0PJoYMLQXTHQFLMuKicG1os=;
 b=VLBnJePQ24weqt6kvLJCsEsOmicQ3g1ZFfiRe6eE05Uhgx78JR5IBr9it+BePeR6QsuthgUuN
 7fOI7CzsJ3ZAfq80rD3F9Ah6iX8SU/RrmxXATowwFmINGCjT92n4xuL
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

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 

-- 
2.54.0

