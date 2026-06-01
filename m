Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFACD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0452A113277;
	Mon,  1 Jun 2026 12:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGqr6fSG";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D31113277
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:33 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so89557025e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315532; x=1780920332; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b2M5oRZ/p2EuYw6GIpW+wKMVVLqveBuY5+15T3rurn0=;
 b=nGqr6fSG05i9LstX1a5ztcSirSSr9hYIxxpyvLnftk6zkVGL+fCIpJT6hKmTTmZfAy
 1xdx5olemVniw8O5wfMsG+L2ucTFhzJaEVNnVZs3ovijGj0+tkeWN52N1HCwXSA7M0Cx
 x6EII0gdNjexzI3lx9ZlIpCJmWcshAh74CTevRck8r71qlUDM0rGw5h1BxU45Z5oAXm+
 OWLbvggB9r1QVI11ej1McQrKldgFG6xadIu4X70aTWJU0MKcC68aiw/NvUjANgQM8yZr
 qcchwSYRlNU9SyfqcXAnwF2gHkHhngWCe+Cc2J84IT0p3ryjKIEByO6G4ItVNP2gXZGn
 hiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315532; x=1780920332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b2M5oRZ/p2EuYw6GIpW+wKMVVLqveBuY5+15T3rurn0=;
 b=qDzsc13clXqpaA5H5ELYe/Iu9UH6XjICUo5f9jyGFNONQklrTVVz+ia2Hb2P94XVUP
 X3X9vVeceDIQReewDPPKebxE9n4joGwuEfWzVHYtjz5Lx4i1IPyUFyQHQhzLQGkQMOOP
 KzoRknfi3J8hAEb4mPfYwriMrUII2k9RudPIEAVv8MU4cSfQ2nKR2sY2ufNW5ZK/SHkL
 9zhTmq5/SaPRW2EIU4M3M+h+Bc6D29adGDZ0Z1hvLNS2dODAv0BBS8FVndwkqx7QZkLa
 ltjH6YSTlDgOdEoIQjzaJt1oGYYs7sGHseewBA+kVc6mp6iSMa0YnfFt1/VOPfDp9PIZ
 Tajg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VBvhu95CC0QOBRlnGiVOJhY2W4KZ+65KAR3lIShjeBQOp6Xv1/2tRAPgf87ibLmaUVcef+KO9qyM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzkfXaEKnB4nEjzobZ4aeBbzaGw8fkfrgIw1F2xW6GCyi9n7In
 DGkx6GYFQZSSyOYbsm0+DKHqrKrvX+4JuXrndhH1tRtN8JRI/smqgTwD
X-Gm-Gg: Acq92OFQaWWk2OFnT/4n7DCL2ijBHrUvGB7leRmEj4hwFpKQSYxK1IIn1xJaiw+V1Rj
 grPsBhOY5xxDdppQrfYXk74ROh4SIKlBtBPjlnHRz4KNAEi0xlzkVPfHWooLjQLMdQQ7rICBy+5
 iQIMhHCNeL3ZByUue0mmI2GC7JE9sMXoW60H/S0zHK4Xb7wGKDeyHGhuT+Het1tZ4RbkoBM0das
 niiJa/W0fkTDc/F3BWYh7YjL/0tNflcjAFOQq42gjz867NYh5iTm51O0/UUSaCll1Q8RSK1UtFW
 uzxN/LGHaMAFuYJ70uFG/XC/8RKhxJxq3Flg6brv6NtYgeeLT690CiGKmyynLFHmEvmlZSEnlXP
 auwjdr+Eys4MzoiO+WGNCc/a3Oc3Rt1vHT5aRYj27DA9YBXpujj8HehMRxyjycTvV4oj5eFAQQN
 5e0UbbgQKYPNrkvg50GSzEKexvlKDW1t4yHm8FTxWcYA==
X-Received: by 2002:a05:600c:190e:b0:490:a9d6:8f2f with SMTP id
 5b1f17b1804b1-490af3ace6cmr14372945e9.4.1780315531775; 
 Mon, 01 Jun 2026 05:05:31 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:59 +0000
Subject: [PATCH v3 13/24] dyndbg: reduce verbose/debug clutter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-13-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=4140;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DidtLQdtySXkRLzEbeRMwRKF7/hq+UTu6iYkRqLCz0k=;
 b=YYxJCdy3bIfqzVtI7FPcxytUyCArgoEmIQX5xynIfWnMP6R26XQ00vt4jmSbcsr2kARUaWXJ8
 I8YccdeO8g2C/E7Kz7Hlr44VpQYzxfYPEdiewhboS7gJR892v3FDMlw
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

Also drop several verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

RvB after SoB

trivial change to verbose-debug output line to output the actual
"module" keyword rather than "mod:", and do so only when the module is
constrained by the callchain (ie as part of a modprobe).

 was:   query X: "(keyword value)* [+-=]flags" mod:*
 now:   query X: "(keyword value)* [+-=]flags"
   or   query X: module FOO "keyword value)* [+-=]flags"

IOW, adjust output to reflect the input grammar more closely.

drop-info-parsed

vinfo-applied-nomatch
---
 lib/dynamic_debug.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0377d9f8dcd1..bacb55f960fa 100644
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
 
@@ -487,7 +484,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -511,7 +507,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -525,7 +520,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -541,7 +535,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -593,7 +587,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: %s%s \"%s\"\n", i,
+			 modname ? "module " : "", modname ?: "", query);
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1159,11 +1154,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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

