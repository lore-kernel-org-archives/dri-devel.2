Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65EB105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1674910EBFB;
	Fri, 13 Mar 2026 13:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IYeqMaEM";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A2810EBF4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:18 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-46704177543so1450552b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408198; x=1774012998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=IYeqMaEMsi0LSzryetP9LXkyDznlZDZuB6mxuWZbPlfYRG/6YhtgstRhr/tbhHmp2o
 vH/d86Yxfe87ZEmMd984Dx14A3hEmUMQphc6UtIIzjzdc+Lf0kVfYvxcvtaYLdO8GqEU
 bYToyy9rwdYic/IAYLRYM7RsWG7jTjOKyX/F6zxDlJlYGRd6zMhoZz7jyCCXglK+4kKQ
 0vxvvde5GKn9/dLBi5/QjGsH+Dqap553SH7nshPsMwoQ3hc9XrZOpMdtyJA4Cea1t79y
 7YQt6/0F5GtZIfVkGz2XFKb0K//c64SGdvDZ82oQrpdN+DrlY6wngLTb7wbnaI6EXNVn
 UsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408198; x=1774012998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sNdSdlXltBKavjCpq8HaVo39jGQFAT2gyMj0g9RRu6w=;
 b=NsYTsoCzxPHBi3LVmMD5N6l+7x3W92Lbd0oi4utxCjVlEne+9QO1Rrm4x6FKUhZT7D
 hqwek7Y9f3NAxCrgnMLQC8ZYDNnkIIy0nV8+OoDbQ9o4C0iRYASZ6CCG4TGCehWtgoma
 pbGGKmXOSZRm/whHNNpJOtVHItUT/Gj2WVK008sIPKoBzvEEgjg0eVLmc18OhCnRDcs3
 5SduNolFUQX0tFR520ko/KasXxnP9abxr7u+MwbXE767IbrOG4CmVA6PFQPkc0bHrpVF
 nO86K/nU/FB8JIiHpgm+qDHK8ZIg+Kx5q1UYBCtu+6BVZ9h5io2FoTJg+06QoP7VE+fG
 1Dcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1PvPAihOWoY6i5pwydTaTYNoOaHLmSSRBIA2bqTN33OtGMLShFFv9rQ1WHNOpY05HMbn1di2LlNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhBZIYc4aZ/reepsCtocTBRkYRKDu+VGeoRRKHrFnMX1GCcMVr
 PTIWijYCUX9Jpg3bJRYDCoZ0xJfSgW9l9mTN1uwlicGjpxEjvRkjUsmA
X-Gm-Gg: ATEYQzxzMv+KTvYCO0Pn61TmYZ7/yTMNv+OZkKGpGfi+EBZ1PBDUDA4w1u4En9Z26gK
 cNSjOlMkoMrQFjo9JSfQk1iQSVKvc0JE6ebWJlDTO9hxqzZOg6WeCWP3q2njiQNIAa6YyibVckz
 FM3oZxV3WCM6RN2hyxjOcVTjiz3cnhf/OQbDdvKS07LokdxcD7iNP5CA6s/0sIjExWt9nbwQACR
 xiHLDEeWz/DoYc1E++uaCHsfddpS7swaGGHUyiRWI5XQqdHvwK5ln2duMBVPtp6nybduJJjwT4i
 aV7sSyFmefphO8kZeUV8L5Jz7lL+V0L6PRsNY4/VRmpumlpCxThZ3b4E+MsHUnj4xXfJNA3HOcM
 VA06AQHtiyZgvHewE0OwfzPBNF4mg3gMR03sWO7c4jiEOv6sh3U+mfHXGbREWKYVwNEo5vuG/6c
 s+cPYdC/wqaKWgKCXdjh8Mqgbi8VrPxH3gopsnjN6sP049VKli
X-Received: by 2002:a05:6808:1b10:b0:467:254:b90 with SMTP id
 5614622812f47-4675704a335mr1610159b6e.10.1773408197894; 
 Fri, 13 Mar 2026 06:23:17 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 11/65] dyndbg: reduce verbose/debug clutter
Date: Fri, 13 Mar 2026 07:19:36 -0600
Message-ID: <20260313132103.2529746-12-jim.cromie@gmail.com>
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

