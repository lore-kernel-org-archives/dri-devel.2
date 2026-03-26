Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59C10AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF5B10EBD0;
	Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tMhdV3y0";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311AE10E088
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:52 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-41708f6aa5fso873789fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551291; x=1775156091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=tMhdV3y0uNAit1NPUDKpeMuyxSR3KaTzieYsf4jPxDQXjeAPKt7RsQa1zQ+gOG+mcb
 LD+K/mcR2TUHmFima8Gu+8XlKzURZSJUboOmRByRf7JLp326cn4AejxTBR7ZhZB72Uvu
 ObsnCuP6yHLxRGHtPzAksqEejfNTLG5qUpS3/W8Dd6B0XK1lGZn3qHPcbivuEGZpKgcr
 T57w4kod94LcIngFYiv6kNhy1bd14HrGAz1SOEM1MX+Q5EnLCjJxGWes2j9e1TgskM/2
 Q6B36olFAmpGVO6WxSvDd4v9tBKrLF4OlDpJV+F3tt+Ij9dWVK0D9nGG+Od94hmVqj5Q
 UDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551291; x=1775156091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=KUUYzBdi88KeQdWm5Q4IdeXLoEOks0cU3lJi0QP04Im9RqpZ/7LXNWl1JDuXLJZVgQ
 H7PgxfJTMtpDRT8XTZ2m9hgJcBTmJiGghsjIk7zcvJlICPfM1wlM/yC+DkdjMJYR1ZKw
 8AdXqo5jaSlWbhZZR63O7C9ERhsu+GPhw54aMaMuOFDNaLDha2Ebykkr+Rr0EnvGITjW
 V/S3tdvnJA51SSvISMgh3f/gvHmKsv2FSJjuED+YOucTmsfoq4yvGWsYDT1fSg2dZjh+
 wagzM6IRr+kjKUaq4u77WVIAuDaaRAJS5vhL8oAo7at2DKI+bVUgwaRQGKWstPYOQHNu
 gIqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbLAKh1diHhpAeClBpmH0mDTMM2jJ1woKSGkhvXWb/DJIbsILbxokQR8RrUNr7Ux89YSlc1k8+6Jk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAO1gKsK1wUwUa58wIztTAO2GTlVMuw3GLACB1op1Cut8KvfPY
 d77OgwiT75jJxUYN2eu2oxzqw+D13lbjuE4w8Qr+3htASDJecFk7GzxL
X-Gm-Gg: ATEYQzwp9piwIzCouyCGykRURNOFhuJdn1G6ruupXChcuZqgO+X/4Td8ZUN2dL/48AS
 Vu0ofKBFaGO/LrFlR/aET6nnBbE9120BfzB/fbVkhz6n58qYD41N0NTt/eISJfzJfwJ1MeLMvKk
 OCQf+XNUgWIBAVugm5Zk9nD5DMbZ+YEgReFH54Hai2kfuHyWRq5t2MKAODXhvt/DrarRgxxKXMw
 kaqIpoq8AZvSlGCUp2XANq5TqSZT1mVylhoadnG6wXzw8H3JdI2VFWWrLS5afWVxmiCg055Ay/D
 ww96F3PkjmDsAVa9KoroFYYE7kYm+tQnG9aCujzCGEU0BihNb387qcGiA4xlpTtm4KfWt9lqcjT
 BoE5kbjn9uvulI9uBVEoFPB49OJAXRYgWrkYbgEtG7fi2vepzBl2PlzFgJdzrmSpFyt2L1yUf9q
 6Mw7WIA+39ZE4DYTOvjA1pFBaq0Elf3dRtdcXfieFGqLopEpAvx/2Xe3GEmek=
X-Received: by 2002:a05:6871:520d:b0:41c:47b7:1f24 with SMTP id
 586e51a60fabf-41ca6e37d7cmr4505067fac.21.1774551291322; 
 Thu, 26 Mar 2026 11:54:51 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:50 -0700 (PDT)
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
Subject: [PATCH v12 14/69] dyndbg: reduce verbose/debug clutter
Date: Thu, 26 Mar 2026 12:53:18 -0600
Message-ID: <20260326185413.1205870-15-jim.cromie@gmail.com>
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

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also reduce verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9575b92a8deb..3ae9ecabdad1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -276,9 +276,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -511,7 +508,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -525,7 +521,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -541,7 +536,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -551,7 +546,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -569,10 +564,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1246,11 +1238,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
-- 
2.53.0

