Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02BD105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2F110EBED;
	Fri, 13 Mar 2026 13:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RrrYxXJg";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B896410EBF6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:04 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-46704177508so1464951b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408184; x=1774012984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=RrrYxXJgnrKWeN0l+QdbWnq5Foal5clfVF061dMEPL/IM3MbnAGcDokk5XsfDsB0Pf
 ZaD4/JHNhj4moCvr+tTmuJogZ8AOQnSqv/XXYAdwVOdUIy7r2ECME1QWJu33kD2mqJmT
 SZWQVO7le+P21RnaXTxcCazgM7N+Hq/zqArjHoZx+APjMzP8Q8clBLmaTIyvKE5F4Euu
 CQJNR3NY1yAfr3iyZHVAwkEJ/JQ9RF0VsiVO9Nq36PPJpHChW4W47JK3LUsi+yJRCa+1
 Qou6jjW3aYSuRUZASneMTonBOgeMgc2gD5YGQh/jIErfDK9XO4WsjtbVvfroqkgp6Cp0
 Z1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408184; x=1774012984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vld9IFfyvePqt5M1J9/OwioGOqjnLV2rFk+KzTunpXM=;
 b=B6O7AUICnyfoWH747/8xQd1zL9dnGPvWmvGhI7o2PJy+BSBQehQnJrUweONPhTovdG
 EZOn5My6Fwtu51q+JwZY22Vj62MaaSpgAoCy0Z6HTBLCjG/SRQVI35seWl1+Q2e1jTJx
 czYFHuDns/Mw2T4orMLgILN1VPv+qt9VsOTLw+w7zJRGT34wz+3tHh3jdig9v3ruFHNf
 J6xeTetWMHreiACGoj/9cFHp7dv9lgVN57gbC36mOFI7xQKlZoQjWXJoM8hPXbdItqd2
 whcp3eefihOZCCDoRfBtLhGuR1CZoWH3ZQEmJj2mSzHi2wkEQNrwH/5xAfTvXxFrr2ot
 ttdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDUqMyNNpFK+gItXNWytRrMgws9k8J4JjglnhUDIXBFM6TRSBOtnNmll+KsZttiZbhjwPrWObEwlE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjWo9tD+mYBat3GLzHLXYSzcz01ox14Lr2ihDkDh1T8+bZzkg+
 9/6cozVP1nrEO3wPUMvumpkO8PypkvwXJMGioXwL/sPg+bSTHX584pIv
X-Gm-Gg: ATEYQzyNyCaon/qCjLY5fRIkmY0E1GIvjOredGt/KMqD523gWmgP1zB7JtdHqDaINtj
 VGWMsRRyA5dAeljxAKIsTT1wlyikj8CbBTqod9WtE1Q9gB4JplySN35u6f4JF8VwDdUG0d09pT/
 mIaKP4EVXL8UIz9VgekJL7ehscEs59KqebV9BWUTe0Sli1yr3YiWtFBn8D4APrEvVRBHSIxBzSk
 40j5z0tN1FOyRi8xivGoOzrlP0cLh01tlp+gqIhpBSmjWjV58MjKdY9fk0BQ/OogytHcoA3w9vW
 kRGYvOAdGPKpGr2iXNH07xujR5rUDI/JgeLVZvx3hQTuqbgZFK4cJSuTufWaE0p5XsfoVYp7n+9
 EPaxh+JWX6OVRhhsE58BbMCHOh+ATGMtdoNFyX4Rd3nVNAUQztuN3CvO4t1gbAu4PSAtqk9ULQK
 +SELpoTTp8lH1E8n0RU8LPtD+cMUhOTALcIW0OrVxaN0/NzY5htwCpV5E8se0=
X-Received: by 2002:a05:6808:1203:b0:466:fb74:1ec9 with SMTP id
 5614622812f47-467570ef685mr1573218b6e.4.1773408183890; 
 Fri, 13 Mar 2026 06:23:03 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 04/65] docs/dyndbg: update examples \012 to \n
Date: Fri, 13 Mar 2026 07:19:29 -0600
Message-ID: <20260313132103.2529746-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

