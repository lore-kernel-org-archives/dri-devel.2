Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706BCC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF7E10EF86;
	Wed,  8 Jul 2026 02:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHH9U12J";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AC910EF82
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:18:36 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-49c86d1d21cso75744b6e.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477116; x=1784081916; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
 b=hHH9U12JBdQVEdXqUqNfPL/tL8SJzfLVHCnUMQHD4R53FojLcuXM/67g3KcxZucYMs
 PylBEuien7zkde1w/jDmzCmGRFKsnIfs4kX86XL85z7aGKjf7WeDHRKUchUoh8Zc7hUw
 AQBPYtFukXRniof5cEHXHMG24qX05Z5fCRuFKd+lsLhUUbYYSEl4rBlFpNbNW2NQB8t1
 5bGeLCdNf5Se1/VfsmD5e9hio+7vBtWd2dfRuhFz5nO+4+ugUlwyJjFMv1W8I9aWCCBD
 EBtyxhE4NAOyMeaFFbMIU/MO85LqKUMWr1fwRkwB1/ooFTeooiDKln6Heu1r77rEwUi4
 mjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477116; x=1784081916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
 b=mXZDNNrTbeM5Be2pZgRmNZgxOKshDu1kvMc63yV8f9BSet4hMxcpf2Kqqndll+h3KL
 ZFfv02W9p0WhltkmOkH7NUVYvSgYfA3CNlycOmlskGEhbyRuhyJob4d4z+5gKCUWgVBy
 8AxrBlLWy4c7WZQB5f6liqbcUUOh+qZ3HH6tuXUpz4XCD9C3d+xALlYACuCnZKId07oC
 A3MEtgUjSQuco8hTwlicyfpjnQdI19FEN82eTkVBDEMR5QQt+5x57X1cdR0hM8fO8N1y
 xUMts47x0Wm1UGdnfm3Nwpd8BO0v1XO59HRRV+s+rlakqhGOaeL/R1rP/ghprOKqKDIE
 5r4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ociRB6uPPtJ8E6l/Pocy2L+ndvkuUre2ydc/2rUE1PfZfIdOTe5ah/3f5Xijf9yeXr70AZHRhptg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4NS4m9opHtGRB0if78MWOs/sfdHMztWHjWjRGauCPIyufU7uR
 EllBf8stvFrT0PuBvxwcb0xCVcg7r4NyF1HIYXZSaW7X4jFsskXv1Z0e
X-Gm-Gg: AfdE7cmqg36aVHYmjhuVel75vgcnFpmuEzwLF7WKRzfiBthqhvS7vn0so2B0ew6wDIV
 Rgu0nSuo/mOGyXM/ecb2FPdednMSfgTuIEOJQbrtgG6yRUcRem4BDhBiadrmfpK6wvi1sVaLLMK
 gelsdz/jOs2TemG99v3gOzjDK/RpUhyOL0hlK8tQ1iQMd54ylnRnlhODe8NHUkEm88V4U+kJkOB
 CF24b1fsTfnBg4Uzd7SshS928a3D61Gx3m8cZmrJmDA1avDdao8d7eka71MXfUTqD7YH2Ak/0iW
 xOFlhzwcUO1dWjL9pn+sPKzQnV1dPrTt7RzWi5JtTDMR0glm3vtsFeE/bm4ayEo0Zo0A4Yh7R0E
 nW96udVdDyoX1pQKkCxbgHtYyaaIX/1SgLAVEoG4R8Bbs4RRXS5rMCjdIgTTHAEAxtHHYSmIyC0
 DpostTIQNmuThJGAXvkpzATbkyTMdz0vOWyOj2U8O040qPynAb2vM=
X-Received: by 2002:a05:6808:1203:b0:496:fd2:94e8 with SMTP id
 5614622812f47-4a20252b9f2mr325652b6e.12.1783477115870; 
 Tue, 07 Jul 2026 19:18:35 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:35 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:06 -0600
Subject: [PATCH v6 06/24] dyndbg: factor ddebug_match_desc out from
 ddebug_change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-6-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
 b=04RgXc/Apq9U8cVOxkk9yG7Al6ydGuc69Ip+3XA/yuC3YkRyQar6eVXBInEVdxoRCCuknZtdO
 +FNIb0eFwmIB3dOAaNrZUY01ELAnI3eh1V4e8zq/FpVXFi3JrNiRDWj
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
v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
---
 lib/dynamic_debug.c | 87 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..577a07916072 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,56 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
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
+		if (!dp->format) {
+			pr_info("encountered a NULL format\n");
+			return false;
+		}
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
@@ -204,42 +254,7 @@ static int ddebug_change(const struct ddebug_query *query,
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
2.55.0

