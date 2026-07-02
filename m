Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ED0C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E011A10F503;
	Thu,  2 Jul 2026 16:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODzI0an+";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF6010F503
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6a15ca0d761so1387055eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010485; x=1783615285; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kg5EcJIb7/NbC+BTLvTpewRkCYpge7iehUzwDyOw0vo=;
 b=ODzI0an+X/RlRIm19x0Cr24L1LVI97dMcGqxr6M49OJTgwBLZ4P0ysdjy2KFYKXeuw
 t+KAXxSM+N4Ajchhf1vE9x+FyGgFzoUA1qRYvGUVJVZ4ta04X5Ynvy46LefVt4hiB0Gs
 UetgXTLENtrrMkQqsX5emefFHEZ2VJqA/McZM4d4LpT+mi/0cGY3RSCYIRAFFDPWaS1/
 Eo2NS0yxBwM932rDoMs0JcM718qosPBEBqhSKpC0MIEquETPmZGn34pZ4HYB6l5EW3XQ
 lmB/4zjcW2xHYch2b0b2/eyv4eJDmmniYpQJpmS2Io6l9SS3CUNcFG7eZP67Eko+e/iT
 /+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010485; x=1783615285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kg5EcJIb7/NbC+BTLvTpewRkCYpge7iehUzwDyOw0vo=;
 b=rdMDKeONqd26pfh3iaDBnWjSpTO/YDgmdbBgal5WakdYPFfpNm8i1F+3y0iWWRRddl
 GF8uDZ0h4c/TOGOG5CRZORZ8uGJc6nEvwYi/F6vSCpsenY2ntc7PbKaE10AB+V4BxTP7
 +KuJipT7L4OQsd/+JAGHTdff+dVP9FPh0M5XBpio9BvIVduy1NzJvKYRkHc/GK+k6URi
 PEcA6QdSPR1tMt2ge4iuUiyaAyE0h7IDh5dcFavnosAaJCKn3YIY6F7P3hDgcp8YWWCF
 4UBUSzkeU5uIYkloO3Aqdhkr/hZ3u2yQRpVGTE4qX7H4gTugVnBMNhPDV1R53JUzQFkS
 H4CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jbgjWVuA3qCbzRROyCPs/rd8ESodxAMi7wp8pmG095ALPl3EHqKBjaQ8mJVijiv4ApouuJzq/BRk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzASJCo+XeioLGa2+QhfxEe352NV8XQuCPuzLpixSnbvHNosp+W
 rVldI83cxtXw8I4O2piQTupC53xCQCoEdCrA8qiCp4Abm/5esYZFOQrZ
X-Gm-Gg: AfdE7clr9uLq1TNcnhG6u5mKjJu6tODxkDx3cm1R4QRQIrCxbHIULpLsPmpOmGdvxQn
 uXAvr2SYIuQ+++vbOTz1Ok9Hu+Q36l63q58DXuWIYVx8ghMkb8zzxnotBkkHHY2L4uAav52aA0b
 VOKfc6hKVzjreK+c/+HI03C8azN5HwSg6n0jWPcKpx/pqQL3ms5AdOaiOTehdbNt7DpC9tDXAqS
 qQV4Y8kmLFpcFGH8UAtZww5sa6aFnt0dMPT9MvEDslKe0B5Me24TwMRiRTw2XTUnpUCAEfYndMo
 EAqr5WIeNJX8j+cTQN8ig052jbYbaej3RGhLjK67Rm9TS03Kw0uk+D3G1KU/2UpOlqKwWA5YHyl
 3Ot7kMTdMC5V0W0YUPXu0EZR9SxQK1ORDxmzo0HTu59kEo8IxQ0Rzt4UeR3zZh+Q1SPNLFwQV4X
 PVoxiCi4Huq+5VFY+k3g30w62W3bB2b3G8bPLYlEitVB13KwTXMGY=
X-Received: by 2002:a05:6820:199b:b0:6a1:5847:3dda with SMTP id
 006d021491bc7-6a30d8ac0c4mr3660257eaf.48.1783010485438; 
 Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:59 -0600
Subject: [PATCH v5 07/18] dyndbg: reduce verbose/debug clutter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-7-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=5280;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yIjUo04fS9hFhZVQqd7QNfMx8c7rakFHpoauTbqrYcM=;
 b=7XTGzlwc+qQjDmQhNpjyATyUsQF5hxsmAXqfHagY5YutP/SAIko8Y0nf1YEus2ocx5lasClDz
 IvHgRcyfvh+CxmkXlsh2+poPVCyXyPLinEqHzFcsXWzhHTNxYCP1byo
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

 dyndbg: query 0: "class DRM_UT_CORE +p"
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 maskp=0xffffffff
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also drop several verbose=3 messages in ddebug_add_module.  When
modprobing a module, dyndbg currently logs/says "add-module", and then
"skipping" if the module has no prdbgs.  Instead just check 1st and
return quietly.

Unmatched query diagnostics are intentionally restricted to verbose
level 3 (v3pr_info_dq) to reduce dmesg output clutter on standard
verbose levels (verbose=1 and verbose=2), aligning with the overall
de-cluttering of dynamic debug logging.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v4: rename vpr_dq_info to v3pr_dq_info to tell its active logging level
    adjust some vX levels per doc'd intentions
v2: RvB after SoB

trivial change to verbose-debug output line to output the actual
"module" keyword rather than "mod:", and do so only when the module is
constrained by the callchain (ie as part of a modprobe).

 was:   query X: "(keyword value)* [+-=]flags" mod:*
 now:   query X: "(keyword value)* [+-=]flags"
   or   query X: module FOO "keyword value)* [+-=]flags"

IOW, adjust output to reflect the input grammar more closely.

drop-info-parsed

vinfo-applied-nomatch

dyndbg: tweak verbose-levels per doc
---
 lib/dynamic_debug.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index efe12fac6363..2e321b7eb957 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,7 +128,7 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
-static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
+static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
 	int fmtlen = 0;
@@ -280,9 +280,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -491,7 +488,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -515,7 +511,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -529,7 +524,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -545,7 +539,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -574,7 +568,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	}
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
+	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
 }
@@ -597,7 +591,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		if (modname)
+			v2pr_info("query %d: module %s \"%s\"\n", i, modname, query);
+		else
+			v2pr_info("query %d: \"%s\"\n", i, query);
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1163,11 +1160,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
2.54.0

