Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12337C98311
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBDD10F1EC;
	Wed, 23 Sep 2026 22:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TokKcK6s";
	dkim-atps=neutral
Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com
 [74.125.231.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898F910E50C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:34:54 +0000 (UTC)
Received: by mail-oa2-f35.google.com with SMTP id
 586e51a60fabf-491c13d63d9so284290fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202894; x=1790807694; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pY/j1ww3Y8UnMsGPx7zQGy6NPa6GEKgP8JCREIbwugg=;
 b=TokKcK6sbSdHVBe1hozdlRAv9BG1TM449cEL1v5+BfjSnmu8im+w043h6LyvIeljCp
 zim4WX3Pwo4nmpvaiZ4qcCHKy5KFIqeEXaJmD3uMhA+NJT9Jo9bGvEBBxfBDzf7JNY7n
 xr/zliGmmVGANrWTu9oIzVPqzEnkXmCrSt0Zig+ot5BZBs9hAeEL11Tv/rnnAaXs3WL1
 6KByQJAVMjsf9HAgeP8eTu3q10iAS60RLjjxjlKqyBZMNqXk12zzzkAX68yS+Md+CCRY
 RsQcNbQc4oMJ756aYUJB/aQhOKZX7X5bkRi3RH27KHXW0TqC3dKcHJs1uCnwvf09mSf2
 +n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202894; x=1790807694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pY/j1ww3Y8UnMsGPx7zQGy6NPa6GEKgP8JCREIbwugg=;
 b=lyfTtklCZqeGiqBUdJTJUbd+b3nC5K5NMkh/UN92h84iHos4R2BK5qDILIPsah9gCc
 1pa6FNxoDqeDT5w2mRysPpIOdyaSNLUepQZMlEO/ICPMStKti5TA2ZwD9u3YDFBaRAmn
 zRuux0s3ZkC8CUXrcEJPXokW5UFEIXcSY8B3gEIHiHjD4Js4JmxT9vT7emQy91QifxGp
 bTRkff5ToVTzgn5CjYrMLqDCrsppRJmB5jtOvcH9H2fmtUeQ4B48lHHSjRlzyb4fLT+V
 os/kvy36mlDjl+/NwSeEIZT8U/SUpOXDUHq/hJkbFA/uGRZB3LZZjcahMu9SWdwpQFee
 5pUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjiq2tNokfu42q0f6Q1ftMOt5aU485eV/fIwJwfh2QPP4wWZ9Q6S2AuECC/MpCGV/p45gL7XOwVk0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ku0VldjN1lMyN9Winc/bs2W6rCwgRZFG06du+dXw2797o4SGzH
 w8SZcQMb+8NfDHfmFI5/suvt60RMoPQ2KEyoQMr35A2tnGa/EgSmh5j9
X-Gm-Gg: AYBFou3gli5KgVs++Abd6r5xhJbSpEEJVVct7xK24loMNesHCHb37+Y1x7YlIA46fN6
 8p8x/KZerLzSsG1ye5WNsPCGV5APtRUkKnn/b50Nil4KV8FLGiVo45lxdErUMzeYtZH2LWe2hbV
 FO+Rb/lsDMqN6aAlZ8foxaVc5ytObL676niLdkdss1zA5d4Pyi26blZfxMt7SD1ls2HmbVjj+h3
 WoakhXDg97mXXej52izj9u0nPIhPXYbsJrl1G4j7jHXzMfFwDRnHloX0PtIL7xkCOZandhdwVOl
 3yf9uDhohb6UmJSF4jb0Gk892l+Af/nqojjg/5sb6OraXtHzdzKa3gKR2ei3YKu+xOCAMG6jVHP
 0MRlcIAfuaoiYd8ULt4B/nQlgmKxsAm/ZX5uS7dS82YlITknjFHcCTY1a1NSSbnEZeoLIsla2Uz
 /qmsjnPcv2N3KceimmbcO1dGJ62B6dgkDQOD1J/SK2Eh2zer+MZkyMO2BIlk/cQTY5zUeZYux4l
 X6hNKXeXl3RGWx3Tn3Asuv3fcPMhZ26SRUS+AvJa9H8MkhDmhxyYY8yfV2nXWiExU70JPLKExEe
 jM3fHkZqjiygM8Yq7i8=
X-Received: by 2002:a05:6870:6783:b0:487:31c8:f341 with SMTP id
 586e51a60fabf-491e549eaecmr721076fac.19.1790202893734; 
 Wed, 23 Sep 2026 15:34:53 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:34:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:31 -0600
Subject: [PATCH v11 07/38] dyndbg: factor ddebug_match_desc out from
 ddebug_change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-7-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5231;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ea2Lf2NOIb4xfOxyj7JKgPRMz10QHHz8z+1IIkR3nVY=;
 b=Wq1j33LYlnk4/v38X95dwW7rLmRMFQGkcjeMowlE5C9vXaIuKAiQNHIStsK0SHxoEw2YOGQ1U
 kgs4mu9en9+D9zx428a2j2DNgycLXIGQgxm08Up1gD3jLuugn9wl68e
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
v11:
. move doc comment block down to precede ddebug_change().
  Sashiko review complaint (patch 7):
  "Does this placement separate the block comment from its intended
  target? The comment describes a function that returns the number of
  matching callsites and takes ddebug_lock, which accurately describes
  ddebug_change(). However, by inserting ddebug_match_desc()
  immediately after this comment, does it leave ddebug_change()
  undocumented and make the comment falsely apply to
  ddebug_match_desc()..."

v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
v7: elevate null format to pr_err adding filename, function, lineno.
---
 lib/dynamic_debug.c | 91 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 49334d1aa4b3..8682c23b5fe7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -166,6 +166,60 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 }
 
 #define __outvar /* filled by callee */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	if (!dp->format) {
+		pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
+				   dp->filename ? dp->filename : "?",
+				   dp->function ? dp->function : "?",
+				   dp->lineno);
+		return false;
+	}
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
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -204,42 +258,7 @@ static int ddebug_change(const struct ddebug_query *query,
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

