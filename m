Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7777B10AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E347810EBC2;
	Thu, 26 Mar 2026 18:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCXoe5FA";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3083A10EB43
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:38 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-466f1c3c627so782761b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551277; x=1775156077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHUGvvDPJX5utgpnBEa/SBdGHOtXvC1eEVKqa9t2R0g=;
 b=DCXoe5FAy2foi5+D3Zzs9QnFxkjZyfnYh6DbIQB9hW+viUosHqEd+L7JLolsBbnFK8
 8zEzIbSmU6ti5XaZnI8a1Vuz8xVocxKUZdutv039DdDjs3O2wZvm4EPbW70l1z5w3/zT
 sqb5/rsdLpiNlJ+2yktn7c1Qj3LfSPOOAkgFOLKc6Fz9L9tdpesOV9D84wYOf4hgEu62
 Ag+Sh+GQkv+cez/h+zIp9tNEcFtBMAW623vyk6PMbGjSlVLa6bgEqm1olAPfFbEbR2uZ
 l11z+Zc0TE/TDTragRrAtT0oHs+qG5Xg3kJefzwvn0MgbAokVlHwSQLTu2TJ/BKJTOea
 qrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551277; x=1775156077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHUGvvDPJX5utgpnBEa/SBdGHOtXvC1eEVKqa9t2R0g=;
 b=FzpELV2edq1ehQcD7MfTtaqGM2eQkIKBR/Rf1g/PIdrY/yIHJjI0DOXZ1PlEb4UeZ/
 wlIFpIRx49YBEEH/wcnDn6ab0xsxO+AUVKhwibTm4taaToNl+yTfV7dJhBoeIbBt7kIq
 UPgZ7T9AWw0c7YsIXcQwGmXHt2VuDD19LT26PAiQfbpQvFe4R1BOQlggW7LWl4QHd4YC
 p3wzDisnEtz1Y+oMag/NosxNdorQorn4aMxePY6GEitJZn0Im+nZKTl0/w2WNWuzZ8gl
 tiaknQ2T9UDvr9S/5wmLFGZP/BGPChkTXvJVMBQeves3cfD+qnXkyNVpHiYR/1qZ0pDC
 XnBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjG87OmFADELLt4pQJUG1ZSpT7qpk51A1YQQgV5Fs3xJrZcaK9DyI4Rsazwq2McbFww924+MvVtvM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRDCcVRvOFMEU1xX/mT6GbEBBxm4k3jaHIB62oHo/Io3pSFufZ
 udZUP1/+mFyFK9rj1BEymUCiSHiZOINH13xrpuG84YYyCx4WXZ5QW8ls
X-Gm-Gg: ATEYQzyfcYfwEnvRuPZbcS1+7Llrk95yE40+K+8Uv4QX91bn+mfRwwF3KWAWP7Z8gwE
 sE5KOc/MN8gINdXWKNlnHJLHMzsUbkd81r4F7/0Rx8v978YuQWtcddwn2pNbh0kpODUER03B7x6
 DDPjPWWTDPG4TBe21631+J4isIuxnnzMat8O2wnNNf++G0NzRDHhnmB4oaSprdGWFS5caH7K4r4
 aRqiOvTN6kgPCUziQWHqfIqbaCeCyoU3WOa1cWHpOkj5MkwIYP1g+Ncv6nJlSbBdFLDhX+hjhm4
 b/V0aH9exPnIbUZERd2Mvq8T9cIKHtT//2n/qAw63VKs8mkDU0aWSMDpZkuQmtlLe51VGCsQsSG
 y/daBt4bIzuo0Sxpx0wlX2d2r80mhqJtKmqUbAYegWYdAXcecIyoJzlQOTd4EyOK4zmPAlnGouD
 LhGWGlrcaKCDODLstfWAq2cNpDAM5GrPv/QC5+Oi0oCt3T3DaV
X-Received: by 2002:a05:6808:17aa:b0:467:bfa:bdae with SMTP id
 5614622812f47-46a5c61027dmr3861126b6e.20.1774551277359; 
 Thu, 26 Mar 2026 11:54:37 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 05/69] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Date: Thu, 26 Mar 2026 12:53:09 -0600
Message-ID: <20260326185413.1205870-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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

