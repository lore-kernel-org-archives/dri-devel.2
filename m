Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F23CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 02:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218910F449;
	Tue, 13 Oct 2026 02:37:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88E010F449
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:36:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 01F66448D0;
 Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF792C2BD01;
 Tue, 13 Oct 2026 02:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791859000;
 bh=vVk7Tt2qeM/4dyRuVq2mcFwTYh/CB+Y70GzrunHOgUs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ADeCo+mkiQBR1sOmwLPNr4r+EmHH3R1382Vq8qpJDHEj+WOfir11FPE3leWeU/TBd
 t4AkBb3NZFqdmjTRuGlFlyIeldO2vav6BT80GFF5g8+JzRPgwqPWTJul5MGcq5XAAb
 zR0zeEUH2lleenPJ2CgxrGWRbW9vgWWDQXelNXCmv/0QKjW+BDwWnd2VWFcaZ/FOQr
 ZL1U8PJ7PMKH1qj+D2GSZ0beCQYOSIqw28EOFQUjd6yNXBgPPDR1zlzcU/gPhvbkQp
 BaM0m9GXewqVhBG69+FFbBWNCQudVSeT1Lxht1L8NeZd2hu24Ly/odUEBRqfiZu/ly
 JSiZX9f+BMMuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BAF4ECC6B0A;
 Tue, 13 Oct 2026 02:36:40 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:37:06 -0600
Subject: [PATCH v12 35/40] dyndbg: fix attempt to modify an RO string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-35-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=1248;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=8R/JnNLwabE40COypqEheAmB4g+drvI/q0k+tJjtJCQ=;
 b=GBe37Vf4wUzMsGdx+j7lUgOKiiXr268cXRFKywDSx1CQp53zOsAS7VdWoQQtJKJ5Fki2H7yi8
 UdSHnKSRRHwBj4eFZxWj3so/4V9Pcm0JTA3qllQdSIhPLB2bZEywdRI
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jim Cromie <jim.cromie@gmail.com>

ddebug_dyndbg_param_cb() passes an RO flags string "+p" to
ddebug_exec_queries() when no explicit param value is given, but
callee may attempt to modify it.  Fix by adding a local mutable var,
init'd with that value, and passing it instead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index efde85c7a9c1..023784dcdc80 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1634,8 +1634,9 @@ static int ddebug_add_module(struct _ddebug_info *di)
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
-				const char *modname, int on_err)
+				  const char *modname, int on_err)
 {
+	char dflt_flags[] = "+p";
 	char *sep;
 
 	sep = strchr(param, '.');
@@ -1648,7 +1649,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 	if (strcmp(param, "dyndbg"))
 		return on_err; /* determined by caller */
 
-	ddebug_exec_queries((val ? val : "+p"), modname);
+	ddebug_exec_queries((val ? val : dflt_flags), modname);
 
 	return 0; /* query failure shouldn't stop module load */
 }

-- 
2.56.0


