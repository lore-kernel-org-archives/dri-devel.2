Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55131CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA44310F647;
	Tue,  2 Jun 2026 22:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GAlQ53XW";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EEB10F646
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:48:16 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so3576803f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440495; x=1781045295; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
 b=GAlQ53XWwYBsAOwgCQJDgilVzpFK4RsUPFg7ZSml3HVoDGQSkQUvNGylJkc53+d8Ca
 WOjB88DO1+RgPX+EL6Cg5nKPulkgCVnJFECSbTBXa9b5a+Ka4I9cBAF3YB7olDbkmJdb
 pDpCoOME6VcxZsGKHbGA67IyihMuG5ssJGfIUHuYHgwkpIm/UILv9BRBAJI2AiKh1apj
 4uXR+h+1GoDcO7ZuEwhNEjqJPjDVE8QvkotDhl2sHJeqMuzlz8UeJkXs6tO/nom/EOvu
 1FHOoOzHBPDPp5JaTfHZD5+jO7/ZyjTBrMg6KFBAzYrl/mbH18IZdZlP3ETNINgG62yz
 II6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440495; x=1781045295;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
 b=P/dbTT3/rtoUQZHFspXqaWARNt2nCukcvCV6JCovN2DWIs6joaB/OBnlsetyCpQH5A
 vQxwAVs8aoLJmk06PWSDJkvVyhRbXewSMdFheCIWV7eQWF7ZfAMA3/7rQAUH0zaGVijR
 8dZ2qg5YcjKAny8n4BT4uCnryyBUcp8C6oHvtAHhHoGqZy91v42YfGHFFZQGxETG8rwS
 WQUQzlbK2feCmPBJHlWiIbL4ogRdNKQQ8ESg9yBPMMPWKyIp6IOxhyMRdPvSTClSSocs
 2PgNd4xS8v8fE1KNkWic4PJsgCaWW4MPbObS27sZjoJBTyM9fZGwG2L0TyBa0s4hqtfW
 TRaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Jc4/qDw/Uv97EaTNIX/J+Yo4PImlwZejoUX+T09K0Z7s8aCNjWpGgbUY6wkX+/JmpZysmfA2+e/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoMNYLzAhhL6+xYKr0l53RM5IEjlNkArvndwey4lhWKrbwKrVK
 q59DcTgOh92qzWe7L69OMrfddnGrwMCeiklwlMu45vV1YzS38fYPmtmT
X-Gm-Gg: Acq92OGvhjqHXG7kkGkJP5BHkfnmI+stZmHHl6QUa01w9pbAZLTbyY00S+xAFSXxct7
 BoKgx/zPlhgA3ooMAtzFnhuRLiC+doYJW3XjTp9ufIr53BukDrarJCs/QHXZxaIqo3BO7RnH/k5
 qP10nBH8oWbpbVeAJjW1QafjBwXhsO+CrXIov5ENrQO8lKENxAxPHNhXBLqBc8Z3YMXNbW+8zTY
 XOxrFAwNZIGElYphv2qnhwG0V9UanjNqC9Reb6Ejl5rjLxVns8AJ2tjx6eU5Tgf5tGDZbmy1MUF
 zI0o8hIlMGv0T2ajLgsxssl/jxsBoXDAmDoGoPu2kw4vImZXg4jSnl6kgdauW8G77SRToimyIZM
 GIqMulxTkGMU5eGfOe/ub41F+mrIc1QSckmsivlnBBMtvp87bLwi8dX751jsOhOmdLdGJqCjrF9
 1Qysp5ABGxxIzoEdq+XTur/NBBdioKeG7hz/mZFxj6FQ==
X-Received: by 2002:adf:e8ca:0:b0:45e:dabf:a00e with SMTP id
 ffacd0b85a97d-4602195abf8mr384315f8f.31.1780440494697; 
 Tue, 02 Jun 2026 15:48:14 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:47:58 +0000
Subject: [PATCH v4 01/25] docs/dyndbg: update examples \012 to \n
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-1-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=eGa6JOHZRbOrzq3N8stPRNIhRHhJDTd+EXMPhxsQVEHGQJoLEX5/8ExqTRqXIhbGFTDS7i/jW
 my6ir9qw9H/DG3fyTSa1Qx5Qli7GCViICT1Ms058vTbgPI0z3h/lvaZ
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

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 095a63892257..4b14d9fd0300 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 

-- 
2.54.0

