Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094B4CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6965E113272;
	Mon,  1 Jun 2026 12:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="li2qolhU";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A505113273
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490a765f47aso10984605e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315520; x=1780920320; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
 b=li2qolhU6yeUuydgy2y2zDPTuMrhJyHdzXnfEFo4bUYqI1ifuTzmG1CUMBDVbxgMAG
 N/2fh+FSz1QJE4MeQkbxGBShULdRA+wd8pKyOt0qzQGvDwlj/OFQ3ZYwRFpToWZAitac
 +1pIniLER8Fh6nhS77oZ3TXgicdNro8kSqeVp8v5At4oAhzuudCQXpagde+1EcOcBptG
 sz0TQVlNBxq0LFOBBOsl26MGiIUahmSJavpnrsCauHuUTpLGgtnI2x2kk+0H2XTX7caK
 bqsBt+xj1jz1O3PIkrKCnfW7KWBx8Mpb10+NhKQmYtciTbP4B+SelrMgCACY8fBdMaU6
 MHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315520; x=1780920320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
 b=NTXxkQPgkg6FpE7XvgG/rlwQ3Fch1HSC7iTk8ahmNN4uanMOrknmM/LWt1raJATkBl
 KVDFeYwg5ndjbf+SkpFZBVtyvFgoYO10Z7QspNdE5Tne8BS1zLL6nKaGrSagjP3aRUd+
 tlP17KVyuGaTRE326gnEqLdPTDcHmgkKmLaeJYy8qZo3xwsJkvNKwHcczJRacrKK8MlV
 s7w13Fh6Q8EI0onwC6g1+ocHUJgiHfLhfIGHzS/GzeBmZ5YdW3XLYw9dpOEOsndinQPW
 efQjKUv2YWhYFRtoCQvMerKXNsA/LpTykLDW8Uc6l7vgxSUgHlUC+1+xowRsXLoe+c8K
 oWyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AsNIkzvNgdszHkkHAeaUjli8PLsGM/6e3skIDcs/HUBKQgearbOCqhlJDHseVJddAEYxNIV7pMb0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu0eCdwxYr/ASE9WJvm6NZuykEcW9FusiGQyElzsoTnrWfyR6+
 2fVh/aaDmoWCICaRY/zvXkj1YB9KL2YpePiUlVsqQpsCBfgWJzUrjC0y
X-Gm-Gg: Acq92OHzU215WB7Yo+vjJJb9E7ixsUwsdLA+JsEHY6TLbdLEty1dxR6AoK8QDExW4Cd
 POMak/r0a8oigSBrJseY8l7T0jddmHqLyRdE08RaH9G3P9bA4/FET4fnTjpunLoM5RIauw6ECPg
 DRjChivjvzI1wKtBLEfh1LZ5HXk66D9TKuoGFVuIeKXlZFguJMQ8chJ48AvsHjl44nv7pWPwmZg
 FFmEox4N25qGDAQW7S+vGFBL8lheG79C1ZYTHxO344+4r6xv7Qm6s8ehiqxYR8tlaFqMPR2Vsgw
 SBeCgJduXi5IKQMQTbUzbXfxCkUZul4xA60tXHcI5szAq9doYppI/mYtBeDM6fHxzfZkNyJaxFD
 YxIJFeM3DdJIIq0cc6nwrUWG2QQRSoyPHRGHt7E6sZVEplG+Zw4CFMaH23v44Ysifexh5QRu5z1
 a1TR4hoNFqT/vpSEiIOYZXSNmIfKUUsAWaDiJIgv3NCw==
X-Received: by 2002:a05:600d:8499:10b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-490a29122d3mr149472665e9.4.1780315519308; 
 Mon, 01 Jun 2026 05:05:19 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:54 +0000
Subject: [PATCH v3 08/24] dyndbg: factor ddebug_match_desc out from
 ddebug_change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-8-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=4346;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ytc0P/UZw6i8hpySK2Au28vrT+KoK4/4tvvmOq28NjE=;
 b=+ufThVv6ucRec0InwE1oCIlL6liuHDUePM3lBke3OZ+hQCGp+ZsnENSLAGbcypyjP9YmxLFW1
 VBzb0Ler2QqCfTSkZKIsWBtoCA6TP04CmDZHb1FiMbti/6RhHDWlB/W
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

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 83 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..6b1e983cfedc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * callsites, normally the same as number of changes.  If verbose,
  * logs the changes.  Takes ddebug_lock.
  */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
 {
@@ -204,42 +250,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;

-- 
2.54.0

