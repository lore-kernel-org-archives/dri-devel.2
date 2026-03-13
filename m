Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9DB105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BDA10EBF0;
	Fri, 13 Mar 2026 13:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQxb+M3M";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A45F10EBEF
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:22:54 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-466f00535cfso1534056b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408173; x=1774012973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=BQxb+M3M8sWjG7rgFPAs4psBxvxkYKcRwfWYMoD+sMfaU0Dfu78TXmNtkje/jzXwkn
 Yx1X6aM9sQG/Vp4Qa5RM8TCW5UvxAJT1fFKF6gfgk7CvELqBZHtorQp5UYv520ICwhbO
 P3nsgdW/7wz3mpI8mOb/QJIZJPVcCB/9zOMXqAoV2xT2ShurvMfvLV3BAtK/LrxSg5Z+
 DdLt+NGEgtLEJ0hQnjZKUeizQeSs2cfPLvXJqOftvB19TPOO8FF49yCJuQ0cNm3ZyqbG
 hPiVUAfPPojiGjccbZkznakIVRJWWAJXqYRPJ1wuG+9/vXfmRwo7LlVGg6660WmAg/m+
 AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408173; x=1774012973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vePjq7+VFJ5ZhNc2ZqKhZQksj6wQ9j47ntZTNCfs3mg=;
 b=a0g+fuQ5f71FFVzWrhEWfFNwnxDL0AdZ4kTMcE2R6mJqDvXT+hTo0WqrQ60LwtDuO0
 pvZ/zuRvHvBA4ZzxGFWG1duuB+mchpc4WalCNVhyhnkhjrJSngM6jtxhWwDHeVaaVJ+I
 4r/E1+hhT6t4zO+s9f8KeiW2xFw9NrC+7TrLyeTqLNACQVoCCxfgvbPVpUeXxpXDCsXG
 0/JTmXDPviflP62j3UZ9qkO0g6QP2PqgwRbS4zhSVYmDi/U3xZLBfjZ6FQ4tGc03Ccs7
 zKjkNKBnieEiLu8K7D78kQ1stGzFeqlr1zdm0Zi+BSBDQnDoY0BAk0rpti+lLg5hC2S/
 R3oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlCZNOylS4nXVEwJyhnjadvugrjnSVS3ccZQpALpBXa6DPPnwNvje4xZTnQ6T27SvSniWTKmVhi/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybuaRlogcXXJA2uxPqL29npJA9sequJOA0I5kA/6QqydME4N9M
 pUiMvceoO8FZFmwWEEOKUJT1v/EavlUV7m6H4bIP8xfJAp/sesLz55Ht
X-Gm-Gg: ATEYQzzFHz3AeKES/9DDBS5OxAboMduJ3d8iNWI0YDAAqLB+3aHVGpupC+dNJbZNo2p
 UctxzGLCwvK6QPkPlYO5ussEd2lhQYbOyhCKpZzwFXkGVYiOaovZ7LRXJ8w8HTu7xZSIl/TVY0+
 cNIo1Rqs9rXTK0ikGOXSNjflL4gS0/sQI4phftzZ3rnvm9B0dqbfVqxvFLXL+Pbj3MtWYq2SDNt
 DpjGg3lGlWGhqKYHe935XwX/UuE+a24I66d1yMr5TZ5a08o9MdCr2zXhd0lwS7Ws01mJ4UHy6Zu
 /9U916+8MuY9k1v/nWZ78epH5+ixHU63YsHbuDw+UxoWATZK2PddEJAKW07J8JqQ4PYi1Ru+6tw
 05IFwysFhKdW+gahLCBI7qdHG6FXooRIgXA9duQNEsBBZ1kNLFJ/A6gwf4qG3D0osmZe077soeV
 YZy31KSnQo3ucKek+COFI8RkJg6SY/MBoYdW1jDyVjK6lc517V
X-Received: by 2002:a05:6808:158e:b0:45e:e07d:85af with SMTP id
 5614622812f47-467570a2be8mr1583016b6e.2.1773408173272; 
 Fri, 13 Mar 2026 06:22:53 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:22:52 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
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
Date: Fri, 13 Mar 2026 07:19:27 -0600
Message-ID: <20260313132103.2529746-3-jim.cromie@gmail.com>
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

