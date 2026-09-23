Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDDCC9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37410E380;
	Wed, 23 Sep 2026 22:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XJ+7NoOl";
	dkim-atps=neutral
Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com
 [74.125.231.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B20E10F205
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:36:02 +0000 (UTC)
Received: by mail-oa2-f35.google.com with SMTP id
 586e51a60fabf-49172f18b40so407050fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202961; x=1790807761; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anf0fctja+VnMMprL/dVwONTSp+dELUQq5LW/V5rUuo=;
 b=XJ+7NoOlmO38BI4a0wUKuL7HrA+5uxc7D45pneq4arQUbxejvxfSGxQcAFaxMCGtlU
 +PBYYvdrko1GeX2ZQNswmyg1lUPfhwKYctQpI0gbOPCGHkdWju9HSZ5/8iJ+BFVTl73k
 cHtsYQWoi+OOI14/AiSyO3nMPpIsH8Pil/0U+mYFeZzD6sGzNThTZQUI8m3QMHKtk4EK
 u9gVLX8H8G9UXrPkg59We4AQ9TF1fQb4UylWGjKDTw7IHOvvJTr+7lgsSWfCYMJhUe2Z
 yRPC76MkDCJu7o0rAHubEHcmfNswCHr2NWVhsfCKotBhFElhIYEYF1b49MCSdh/XwqlA
 nJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202961; x=1790807761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=anf0fctja+VnMMprL/dVwONTSp+dELUQq5LW/V5rUuo=;
 b=XYcyQCtCUYz4z5QgtsdD12wE1F8IOiDOaIrTV3hUy0kDJm/TpoZwoWJIcaKk0sUv0+
 vWRmZQhyFOhsW2i4z9kstym0Tsrg7lcizKW4MEzQ3Kpjk4HKLILA9qNCyh+a7thvkNaH
 XPTLuwHiYU+8+CBxX8LNgZqr8lw+AcQOb1gq625Qsj/wMKd/wE4TnAP0TZwDoOcOAY8n
 YVRcMn0TVBEdu0+z942oGFlOkKDUIHLPWZIzGhQh0uOgOpRYQthdw8Sfd8+5IJTgcbGp
 JRujZX9RIsAEUiXUZWzGFU/UXJx0qkrluTh/VymGfeN7YjWA819tl82hmvht6Ea+fSKc
 8GRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzudkRWzlHt2EkuuixEDjib5pu7B+UYHYRqeyBcMJybpDSGwgH5SNbTlK1wYNM+eTh9I2Fx4fJXCl0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mY2++Q5vHimTQULFyk0X3/qWKseer8AOU2uDBwGFYDEVKAGjNw
 LXXF9VNk7gY7/lYspu6VsYLa6GuAH37wqz5WUI2k+u/joHHQao8VtZuK
X-Gm-Gg: AYBFou0BHkJdp17xXZAubhQW9a6/ANQCunsonIqQRpUuNHhqfxP2ecH3p+tnSzQBo7F
 ErXJViAdCPpdfj5pAKV1cOhHa6UOcJung3vRF4xbdEs8wuoHRntVo8orCarc3HFFSiPj9HhzE0y
 RGUaTApxD+IPsQNF1r/KoS5RPP7CgvXn/LNFg4GI1TnLinAPy/yKLJdCTwINsf8saxp5bqfG28Y
 7VgcReT6MsxowsseypeeDJ2EbNVScUT2/BiJ8gfJZwfuFXMHX7LnwzOwE2qGZ68LQwwYf8J5E/N
 sACYOJjtgKUh/Au3+sDwJVRkq/JB4krEK9sUgEO2yulZvMjGPJkdICSDQ4tHSTV65vutZf7cJ/8
 7QXAnb1SDpKmTSm7y9Unp9NW8lbV3G+HJmtlpqSc3wueRJyoFg91OzQcZSGHCqUDDP5WNUu07Yj
 3edR/UFscMBHGVQjNIc67pv60eLdEWBIoLrM9nLAjQF/9E9vQcQnXB3cGhC5uCwMxnuc8Rxq+cZ
 nsPyqPNMVNcrY0nR0fPNrSVm2FrHyOVYmSa4FfBlL4ErwnRMS2y51qE1Ei+lbZbGVshJcAEhmPE
 afPiMcgptPsCvqrZ/Sge
X-Received: by 2002:a05:6870:3912:b0:491:2ed8:3505 with SMTP id
 586e51a60fabf-491e2441c2dmr772232fac.0.1790202961310; 
 Wed, 23 Sep 2026 15:36:01 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:36:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:00 -0600
Subject: [PATCH v11 36/38] dyndbg: add epilogue to dynamic_debug/control file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-36-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2252;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=dVCVMamiUaB96gu4NX1kujuPDVFnoxAGuPP2zSXDqA4=;
 b=xv600zdesEVIz3KiAGz67sw1u76JqgY26LqYwDj3pdMjhveZMs8ss+XJ/RmWb/HveYQerfo24
 I624GaaLxTQDvfT/Qvyw8uAGdpUY3zCzVd1BxwZnYRc7XkVEOPjCSdX
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

Add an epilogue to the control-file, to allow display of statistics
etc, without disturbing the header.

NB: epilogue lines should start with "#: " to distinguish them from
lines describing pr_debugs (and from the header line).  No new lines
are added here, only the place to do so.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v9:
. update ddebug_proc_start() to return EPILOGUE_TOKEN when seeking directly to epilogue.
---
 lib/dynamic_debug.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 098fd2639cb6..88440c1f6abb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1186,6 +1186,9 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
  * read() call from userspace.  Takes the ddebug_lock and
  * seeks the seq_file's iterator to the given position.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 {
 	struct ddebug_iter *iter = m->private;
@@ -1201,7 +1204,9 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	dp = ddebug_iter_first(iter);
 	while (dp != NULL && --n > 0)
 		dp = ddebug_iter_next(iter);
-	return dp;
+	if (dp)
+		return dp;
+	return n <= 1 ? EPILOGUE_TOKEN : NULL;
 }
 
 /*
@@ -1214,12 +1219,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
+	(*pos)++;
+
+	if (p == EPILOGUE_TOKEN)
+		return NULL;
+
 	if (p == SEQ_START_TOKEN)
 		dp = ddebug_iter_first(iter);
 	else
 		dp = ddebug_iter_next(iter);
-	++*pos;
-	return dp;
+
+	if (dp)
+		return dp;
+
+	return EPILOGUE_TOKEN;
 }
 
 static bool ddebug_class_map_in_range(const int class_id, const struct ddebug_class_map *map)
@@ -1271,6 +1284,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 			 "# filename:lineno [module]function flags format\n");
 		return 0;
 	}
+	if (p == EPILOGUE_TOKEN) {
+		/* use this soon */
+		return 0;
+	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,

-- 
2.55.0

