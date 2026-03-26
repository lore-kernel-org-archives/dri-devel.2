Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB8010AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D71C10EB8F;
	Thu, 26 Mar 2026 18:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q7SaHxTh";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4BA10EB82
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:41 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-40423dbe98bso539460fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551280; x=1775156080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=q7SaHxTh7CfuOSjmFHrwJ5Ge22mn+MYijaUWx6/lV2YxeJgV4oMzqBBtBokfRKhj3D
 MOL7OHE8gtcvhqxMgowHrB804KrIAO9bZWHRx4voIk5UmQQ3J4MKJvW2FsWD1RqPzEt5
 gPjIsxEh/WSXBr2SoaKMFLL6jBYxeASnYwyTNvMGV3yuQsutLJgFvfggngz8xu+BZ57S
 4qA0Z15Ujb4AscWPIyGAosoOP2zKNo78P3lrGQglztMKTKjeeYhyx2D4mH6g0dlc8I5A
 JcDIFapbiqfE8ETsV7nKuZQy+ifx7buDPHTQ8FrQ/HKbdf6tMj5AoGjutTl14y2AisiZ
 ouUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551280; x=1775156080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=XsjWE14NdmUvh2J+nBBHw07iXil0z6/xbQXpjhAMp16u9U0/6x2T1kUZXeuQ4Jct20
 b+zels8p9UKBz7KlmHK/sShRh4dB0w7LyuF/RABSRjmO+q7eXq8/jub3cx8wk7W0bNL+
 R8VJVVEN0QhV7HhEDXfKgALDRs9FFK5mxUkfmeU3s8we0COid2dh+oXAYpiOKW4jSSli
 rwuoY4EjxrUIRN5f4zs4ZuDRUzScxwsQcSRvmv8K9NIZz5xOIHoBMsw8c7CmCxRi/dLi
 cNbkrq1eIIOdL8LskNJD17/4uGk8GAq9JVkyCxNBncEfc7Fwck7kH7HR6qnIF3Krf2Pa
 t6Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaKiIjBagJzmuLW/gfv8DTsyhd6zScgF9fu4dglJvTDzyL1xLANGrdKdsKHeOLJ7z9aB230e1X2h8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN64UhV3qIcVygimPN92YcwMnDLgfDxYkx7LcVrlPGRFUR/oT3
 YyEZOCxzue6ldXLjcjhsogkxA4QuCkPrFq1PSW6y1B+6sbBmdLxX9OtU
X-Gm-Gg: ATEYQzztcplsw2nP9P6cUwbrcDWMuR7X9QVZN1Pq5cLaSx1h52K8pkosz//v+svIYh1
 Mzj9zg3Cwyyp8PdfbDr6TKTgFuVlte3VXZD6JZ2U4Dm5vlVbd/WoK8mYuSkL9oG9g8dTdREiSEM
 Zrs8u90qfCjoi5hlzUPB5D2+5UeCpRCYeJNC+G7dW+M26uNG6EOULtleYVArP5EukXoeWUhNfqi
 nJF3CvsBkOngH8g3fl4nvFeR5dBLFC5htG48Oh27AN+3CRMe6dXmJIAOCEKW9wI8MlnqAlJEdck
 oGQkaTx8PkMk5iIJxzHm0OJ/G5I9sOdvTHHjxOyrdZc/VkY2HQ/uh/EgmMEPT4B75rr94GybXCR
 3OvO+DDJ4xkO5yNms+GIn/DWnYv+Hry0ntfof1f2v0xS+plYWdhQ7n0MB2vgcV1cr+4Gzz7poLq
 tC8ChAQ5SCB0iTCT7v7/DHfGQPRK2Qi4XnJcBehXThYOPGMKcf
X-Received: by 2002:a05:6870:2e93:b0:41c:b780:93c with SMTP id
 586e51a60fabf-41cb780158emr4151613fac.8.1774551280220; 
 Thu, 26 Mar 2026 11:54:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 07/69] docs/dyndbg: update examples \012 to \n
Date: Thu, 26 Mar 2026 12:53:11 -0600
Message-ID: <20260326185413.1205870-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../admin-guide/dynamic-debug-howto.rst       | 20 +++++++++----------
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
2.53.0

