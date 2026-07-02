Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304ACC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9A410F4F0;
	Thu,  2 Jul 2026 16:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rrz18VW/";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A5610F4F0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:17 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-448b89ad70fso414307fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010476; x=1783615276; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P8fTbja1t6IaR2B1RPD8t4oUf19W7cXH/RnkuoJsAkA=;
 b=Rrz18VW/P1jmw4XSRsVUQxi0RdFGX/0ktoFRATGbFDRjddsghDHCvGI2LyCPcMubbS
 rIoBPQ5Hq7V6HZMlOCxefzYGamZqqlLHC1FSGldyrJ5gKBkPz9vBDNI7NuF90GdQiYOi
 xfjZHPJPB3v3QxWdUumyLlZ1AS9Gbs/Sns3zh7HD9LkV7GZ+b+c/+reXPVtPc20FgFTs
 AkHfqcowVmPVA4ZNHE+qb7e6D8sLcLnOu/9XVaisLqeWt3lRdhC9GhJFTIuFS7nQLs8t
 ptejo8iKlG6SCNBp9weB38DSSCR7UcEwD8DKaOdd8CP4DJjJxz2TCZYaCZVt7Jljh2XW
 YYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010476; x=1783615276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P8fTbja1t6IaR2B1RPD8t4oUf19W7cXH/RnkuoJsAkA=;
 b=XQi8/tsKZReg2LUrZ5e62qU0tO26hdyWQicNyz/Oum6aKKOFByiziGGzHo8DGXdv89
 JnxISoROkdVdfZZMrlXlIqmTlGMtNaKgqLcoBuZV/N++2+xHeT2IX8pxRD+oP3MJQkvl
 7c0Zh8sPiDCS8mOmnMSZswiplYKTFEYsGO+N2JUFUHSb2d5f/MBANCFT3uYly3yCZsXg
 /0FMvvhEsh69Hkucv+uUDg3lskQDW+5oVdFqG555cJopp/Vz3P6J/9vStkl2cPqfTKkK
 sQYZkVMBZYIQVDsELwn/cOhGhNkmKQuDhi0zM0rsDgYdZmtP9guHu/RcByd+DMgc9WZ9
 cugw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4LKRbD6mEz2kTY7Fq8D2Y6bhJVbI1YbdiLVrps9UA/3EoIj+Qko/V0UdyUbK6ZdqTL4S4fJTutRY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQLvVzdXp6X12QgVvh04FXOvXIXBc3mOThxePVkaiOB3zAy9EZ
 VtT+Hg+b0J/+7Y0o4sSVH4341KgsQ0B+tYbEQWJfQUq4FRsvBedk1Ob4
X-Gm-Gg: AfdE7ck+IHZChx483/r19xrsnnxq5oeaQ8qPSw0zAzdhfEE7LrOOoZiZzH0RLB3tuxr
 Z/TEbqfBJDevvYLMXL0fo1GYvbgPOQUbgGo3PDgB7mKlO810rVUrOrPk+iAeh06ngQeWp0yNGWU
 nCtoplw2jfYkGf+2LAkg9YVssBGWY7EOcxhadx110Opd1spk1QRdSDpg/TWwpcBAjMZh3p06bFs
 NkiD9KuLxERvT7KLIVeoGj5+0u01TE1UmR0PGjEJZaUe6n1moY3sZWO9evbHRzR+OVscbxVY29+
 L/OlvxfnIDXxU8pzf2X0jbLH12heVH2AHw6nXC5myAkr8zDSlvJHceO56CVaVFtcbRkgMAVyh2x
 7MIAE1Dli2VTAQna1fLu9AvIlAMRaDpg3QbOeP0i4UWi9UOqY9EFbZnHX1kC3mSw08pOuLgcoOw
 PkdFNr9NWDpfmK4OKa9L/pEseef0m1hqSC7iMBmlJC2feTdnr8xwg=
X-Received: by 2002:a05:6808:191a:b0:494:984b:39d8 with SMTP id
 5614622812f47-4960f10eff7mr4621385b6e.41.1783010476167; 
 Thu, 02 Jul 2026 09:41:16 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:53 -0600
Subject: [PATCH v5 01/18] dyndbg: factor ddebug_match_desc out from
 ddebug_change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-1-24f22b052bf2@gmail.com>
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
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=rOK0DI4WBj/yprGM5lB4e5699JqPcU+lt1tA7vpH4gw=;
 b=4cq4LpmAWnIaECSyT0/8uVstFNieJpKyOUKVxbCp9RndYjBkK/Iz3OMfFaJU6r+qS84FiJqql
 JfQTr/W2CpQAIbleE3d3FC2GTjWzX+0o+dTr8CGNSfncjIR6GvSm0gT
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
2.54.0

