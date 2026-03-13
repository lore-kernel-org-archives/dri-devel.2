Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B4105F7A7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50ED10EBE6;
	Fri, 13 Mar 2026 13:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQ/ULjna";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B1110EBE6
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:12:07 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d73d6976adso1892203a34.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773407527; x=1774012327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=eQ/ULjnaqKu27dgcYx6ISKGTt3dDhRu+UXIH7gH4shZ5/zTnnQHZL+eJk4JSIIigtf
 4d4u9gyltZHXmA5UaRIP1HhrkAVtm44YzAeNpIu+rgKwejT/phvx34/P99G/0+lc3S9u
 ZLdlRix/elXTVF7z0akOGbtM6pYxx1o7i/HMPmCp6i7rGCiqEYssCxIlZxZL4lXpaqI9
 QQARYMfgWNRB81W4rB8ZoMbshMJIFn3jFtkUAVU7eZutXVwGmc28L1mx4CZ7/XPytwIR
 V3CP7nSDlpUySyWUTNuuDeV6ePlk3AuwfbPYCG9MENqfORflCmP/wiFmAi8agOibcq2M
 5dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773407527; x=1774012327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=hcwJQHRJ8wQb8f5yjnfsd3m35fpQ6LelDFpN5Z3VojYO8vpDHL3ILaoMkczuevg8c+
 +xuOVJqUTDu23HXfabd9GyVtkKRFB6ev2A21LR9BynT2XYonMzE8PlpRJgIHTumHVKOB
 vtISWe1hHRrHl+DTR5bbSuDkTaegaIrINmq4M1ggfBx2Jk5xumTsjVp2157s7GR3CQQz
 3GdyMhjOPumyP5726BZhYDrM8IVsGUCyR6IoMgBr76bXnRmdpJoQ0sBMR+HAbPAwQT46
 M6/rhwdTso2gG0nBY6l52ps/AhaLRtB+wPYZbmHmm4Meq7H1o5VfMkV5yj7VqnEA5WeH
 fKWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh+p4IyPbcTkOPrgo8xX5w6JLdUQLxCO5/qHDmoTlZOPWRbXk7WdDThLjCzOeuKVzoCJUSDUvhoqc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCYPYyYBaCPUtlUVvYhdA9JYBmVllfo97535wtsQ2M1M7eNmN8
 s6oZvBGVMYfdoPW1vJ4LOWMAEcEDBmYSbFFC3YtHlN6b9JlawSwQVCMp
X-Gm-Gg: ATEYQzwUcebo4VP0p7hkYXSUfYz+DuVrFK2JZfteoImQf3lfadTfnZ4ZdvYnEaAnU/G
 dvDIBZfd3DQIvy3SaJ82qalOp9sEY/BtsqczqT4/RAbmgrXyPfNF5e1nQ7bjQ8LDFCP3JxoWcur
 hTYnhB4gUwzhg4I1TTYLCifBNPZY0pM400kRsW6vCYMYVX2NXlk5atzowqJXEvylnKRCjl9Q46T
 Hfl0s1XmkK6zfTVamqEPv4yhVMgx0p00SzTcAB4+At68/3792AX/LOhqW3QEEQtQqmEtUzVRvDu
 U4Ci7DFZQOSK0rt0h+mC6qpwoH9R3TmB3ephjD36dNV9Y039PHCdfmH3KjmJND2HUGK5u6BZDgU
 5x2XmTO8t1wSgV77E4LADFnzRWN678lR6DC1XArKGsU7e5+KRszLZGYSnIZSegY2gojwzkxY/O5
 lxRup8oaY+XUGR78XU213VPF/UAW2TRSXO4RcTvDIU2OpI3l5EweeU4Sf85uU=
X-Received: by 2002:a05:6830:64c8:b0:7d7:5bb2:568d with SMTP id
 46e09a7af769-7d7825771e3mr1924422a34.28.1773407526988; 
 Fri, 13 Mar 2026 06:12:06 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7d76ae90586sm6733728a34.22.2026.03.13.06.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:12:06 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>,
 Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 02/65] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Date: Fri, 13 Mar 2026 07:09:09 -0600
Message-ID: <20260313131045.2526422-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131045.2526422-1-jim.cromie@gmail.com>
References: <20260313131045.2526422-1-jim.cromie@gmail.com>
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
---
 lib/dynamic_debug.c | 83 +++++++++++++++++++++++++--------------------
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
2.53.0

