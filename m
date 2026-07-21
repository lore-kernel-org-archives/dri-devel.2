Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0370C44538
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B5110EB54;
	Tue, 21 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UeWyyY23";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC68910EB47
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:25 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso4247404a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667445; x=1785272245; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
 b=UeWyyY23aAv9NVykpJal6MrTZIjKCBJhNHRTcY7nF7seiB9isEtbbdqVucZaC1Rix0
 bUK1izwMYty9AaWLhUsknI9kqsUhBbRECP/0IkxBueNIl4dJUl927u4Ka0YAKPkujQO0
 2U6H6j99aAaCE9daquKFQsPfZ+mxGRuFr9QJm9DI75QOY5pcYS95GCx7c94tJMIMysgb
 eQR49rCLnTCynYMGWms74NeLtiCIxzm1Z03a2oF+knZpMO0sWrfG6sAPPniA20SgFL5G
 yqPI0NMg52X7D02y+j45lmwXigTu6yiyt307bd3cEx1GWbb30RDoT9+AJfpMFJZ22ce0
 nPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667445; x=1785272245;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
 b=BEuP0LVTCb3BnwrinZ25V0m+x9d6f0kD5FDF+AzXoIZxNk8M3UEcn/ZWHQA3rYjUny
 Eas7wCjW3yOkhf7AEUNaMY07s/HKDl52RMVimL9JGmnthx7jtfinqqaQC6GgO5ATi5S8
 gDVTENWkUVRaOQSKsUIEbuNUmfPNbk7UshCi6BMLS5uibKJhOFUShVD8Yrs1vHHyJgWX
 AdmscS7RZj37UW52k7mC5gzGmdwPZt+Pg29+BIDwPA7Q6esiLRJPkEBW9izSfkUpy1PV
 lHRSlxxQAYojKdK1PoF0M6HKpWC5I35LbFl3eFQ3TwnqG0IoJAgHPjj7IIEj70pqPt83
 PPLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RolvHPBSm+lZE0gJ6J72bs+VMeJCNag0Ruey4BU6ZtX9fhsd3Pd28D2aZZ1q7tqKM17nzzqlZByohI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaSmVO+bCC5r4KFVPnWUsxpprIHF39qP6LQuhq6AFrdYGlCLGu
 AoRFEUsphX5Jq/F4Dr3aR8H4ZQpSclPJG8ssc+yaeFFdPAFAcTTTITHD
X-Gm-Gg: AfdE7cn0avl7C8ysxL+4moDh1UwY78NHexKWyUC2m5hwKAkfPEyoK+x3buoVeQbqxE6
 Jwnl/VU2rD2xB4P9ALX9SbQlne3UFHcX3nQ6fLQ6ivTlvBKqZf1hiWIjHAwE+E1cfZRWSKYH1D9
 98wRaV/yUk2pZuIu24o4qA04GLcojYy91N8q6Bi2SK0wFKHbAumNFp2N6sTX08f+XP43WAvvVjU
 3clS54SOjCELoGTVN9vc5aGLxqgWz6LfDPdUl64bqbo/ir1WNmtesW+k7cH7gg89FFX4tNfbqGD
 gn+6pwEB4hFKBgpb2Nsg9bpYdazLtk4jnthzlsSz7UjwJ1uYB+0MU/zEuESSDd+/ffoh0ziHIp+
 8xp/B4LGEvSb259tzT6+6ea1g4vGZnbOuQNlGR+G6sNgScEN8R0Za7qTUxBL8pEH6hdamVCRwYY
 wlq81rK4OlUu8TtL7ZdQnB63jA2ntcKz+dnYIC9JdqStafjasikgqTbBrJVm1swUMJy6kP71Ypp
 vGifKjlhPVZyLuwTxZC1h9eYRzk/eQfZW/+
X-Received: by 2002:a05:6830:210f:b0:7e9:cd7a:7c34 with SMTP id
 46e09a7af769-7ed9aa2704dmr10974468a34.10.1784667444956; 
 Tue, 21 Jul 2026 13:57:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:00 -0600
Subject: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from
 ddebug_change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
 b=2XzxbK4At2mhCtWlDgUBewmM96HOIsSDXExdTJnlSiRicQ7UHFWSgn/VLr8QVNpxM7l+fgvKD
 oMYVGG1pNqlAHlEDdHhtjwJVkr7ZMz8SuBiYDkJcn6YDkhh/KneVxGV
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

