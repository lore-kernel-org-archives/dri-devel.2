Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89821CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD119113265;
	Mon,  1 Jun 2026 12:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lBPPUJQ4";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9633113265
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:02 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490a765d410so15229295e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315501; x=1780920301; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
 b=lBPPUJQ49HLrsx++aJLZCJvU0ZMf2wOlmJ+5JIrMNcYvlq2qrvsONP0aRw9xM5+zBF
 KS56l9MlEeA/hWCVRHyMZ+fRX+QP135YRXWxyQ9QWP8QwijzLb+wb4itnzK7/sVmbXCv
 O5sTtQH0+7BEuxbStwNGlDOHtxOUFxFx/RpZZ/RmL5MIB1Hc7KYnPDGSM52Gpgp3O4ac
 0d10BRtuPZLq7Wm3a9TJ6TuvALufEWMKNXl4GEHbTNqen9HaZwrNiGQS64rfy4/xfjSe
 //IzvmP8AvbhaKuRAFhYE8IZ6sujOeNK635ReiWsHoBvEpjmmxyky/CG+iUtHN/blg2g
 GQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315501; x=1780920301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
 b=TRrw8G4UPHQ/f97U2ILCEK+ZG2HmBp/9LQO63RzhjR58fAcxOAcP067HJ5PnzANcWP
 SX5F0tPoUYYkzyxyvWxW+flvuwRmcZx2OgV0PqtaRlrxLt4Bhu+jvA/nU8wPkiPwniUD
 FYPXEFaPV3GowAv+STZyn/cG4R7PY6HyOFY48IVugN6suCZCkm2mizU5SFw+BzsEJB3p
 7c0Eml0WQmXpDgwjnMtptXi+gVi/I81FiyREbsVcYva/gMCgMhGtK62sDDlghmfSRntH
 E57ViRDNQ/RYcgLheGopYiGtsuMZUKMsJh7jEHm4yO1TbCNn2vu7HJG5NTau6FAeszjJ
 OX/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LkuIolkg9jGK2OcFDCGBug04u1HZ2SNbvYoWH3uK7OUrJNLSQZeiVSQ7NTRCjUr2se9U97ByftOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX7OS+KfY4j6ANkkv/mXP9Q+WoZLkoTGxcVCfwnE6iDiKcpQqs
 EQdXBoFGNB1Sjv/a5tcQyLVEbs9FOaDpmWqRwYJbdWDxypIuue2EYU5h
X-Gm-Gg: Acq92OGCC0osGMx/B0azU0LbwxX1HW6+3LXZzBC+bjUHGPkgmrmr28AsB3r6ZWvW+os
 9Fk4jWGftd6z40gfG9h5OmlGtsCLDhu9xJnrsReFKxdYt4Co9dth1pnRwUJRZvfaWhBuPO5juwI
 +IGoJqny/UiPKOfh23Yylu0iVlIGUs1I5sFQyRrE8Ov4FOPwq2PKg9dHm2JFAaIG5xVxS+neaRP
 kRm9ds47xNmH4WsCwhwqAnhZpR7TH6H8EqfhJx06BbUObLIW34UtcDFFGFLpmqJoUCPPOxg9eCR
 M3CxK2vrIDR5kERScFDyxmiMRIQhEsKULtcmSnAtPGJdnoHomLeTfwMdnp/45G00agt0+/w5nJO
 kuPWq+Yq7XPQOa9AxYaEXy/E+8HrdF7Gsr+vMEJCIJiBSLKuPgP5zGduciFX/6EJYZfBimnAJFO
 hG7WILoeGtqqJLCVr6yZrlwNUYwM7y0aPsIv4l01NJLQ==
X-Received: by 2002:a05:600c:4715:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490a2932381mr196252395e9.11.1780315501072; 
 Mon, 01 Jun 2026 05:05:01 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:47 +0000
Subject: [PATCH v3 01/24] docs/dyndbg: update examples \012 to \n
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-1-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=c8S96t+ZCXu5kmm15ytCexf2F+SACA7KqyLI8HX9Eb3WTFBQJJe/DEwNE9wWzQI9kMMtWSMe2
 BCeYdCPPvMcCqA4vhxh710sNmgly3GwhDZJllsv9yBgjcughOSsHbPp
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

