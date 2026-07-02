Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37314C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6736110F50D;
	Thu,  2 Jul 2026 16:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PY2giO9G";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EE110F50B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:34 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-44ce4d7883bso222855fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010494; x=1783615294; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y22IAHS2DQHIuwdJSUGvICtgOAsEzbta+k4+G2yELGI=;
 b=PY2giO9GRrxGMLnmmkfb7DBeK7hLr/mgNpxA9YZNrMAe4bMAtdaGjTlU20eF1IvDmP
 4ZkfeWeUxuLqwYcyq7XrFmi9YSMnmRCki152YmxROWIpqjd1XQMlSGHzPGuM9acZXcdV
 3fIZLB1TYaNIVEuETeO3pFUZ9SjfUQkUf9TeVRSAEbAFd80HaRyv+tnDjreGZMEoMqFL
 VqZ6Cn5Sv1sQ0I52N6IFdGJVg7Xl3N0sUiXewGcZUYrKrje5ViSrCIuFhSRL/tq0MckP
 A+iSudk68HEUvTrourB/VO+q0s0HUFOPjU0IHpsrXblJhKi/G20Omv+waCl1uwBWvR24
 q7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010494; x=1783615294;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y22IAHS2DQHIuwdJSUGvICtgOAsEzbta+k4+G2yELGI=;
 b=RjkLK33sOjODODFzAQK+Vbq+dIoe53ZZo7WB4DvR03mFCGfsla9a2uvY708Brk4BVj
 +jF+z+N/FoDVz+Hw1C/ypySqsTgZWd5dOWGW1fU2/Q2nJwbvhrv8xj3PrLJYKgH9GMMz
 z7XziaZZzyLuCcUmP0BSJ+pKo5Kw5qmrUu1T0UIBWMF5q6EhIQ6ItcQeDdsvDnc1Rgd+
 dSuI8MBlwRzFdtrYeB3Ugo/c7caoUuJM7UqI50cjait5adqtntHSRTn/icRs/CCovd9r
 65wmu8mbMRuDRLgp64wDn5D02PUTk+l1+vbyXKK+Dx0E7oGyBENOn8qdjZRqlwv3B5Am
 BCAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2qJT5crUCV9VfGRFLq6Yk9lcjzrgUkc1YpSjv4Kne6FPdR5NBg636pDLOpYGWpGry15/x2N3Gfp4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/2tNedOFkNk/Kf8UZ+oNURMCr3WH29b8Jz9IfqgAw5XPktr3o
 BrYyyrmtRTPJkC0ygYaY2Bsy2g5Tn/Zzi/7mmEonkPt4Yav1v9haw82U
X-Gm-Gg: AfdE7ckDrh2TVyoK6LN0isKR1TB/Bf7GOY4xrHxpvW6NqcK0TSukRyAtm0cmEVsb+ox
 83nI3qI+Yd8o11rfQ+webNhENRfTdnOO8hMo1VIcLQ/6upoaFaP7bK5NpuljwmZ0SxuvxjBgOPY
 xSGC5rjBteulym9bfjy6Ckxq5H8PhenpnP6ltKkhw0CoDoBHwj2yaIyen8zr+T5NhAqMq8FU6od
 YpDC8XqTkA8KiR0zescLmhzJBidl9iqO0PveJ2xwIbsjAaQ+0wAcUX125yyfBk+Mmu62YMFbnYh
 IiLlgrj2aLwNb0u72nimZthmZNcN28xOS1IAUFk5oag89K8S+beHKdxK9lRNuNoMYSsPKP2hT4s
 JBGjUTs3fnMZhgoKlqzlQ+fX3b5JTN6ObxJ6/4YE7vkUS080w8HoQS++ZR1acW/8rddLP9bOdR6
 lqmMWvJxehRLeBjVotlYnqzbjoW4nbtf+o7S8mmHQNEii5PlqbpAI=
X-Received: by 2002:a05:6870:a24a:b0:447:534c:8a85 with SMTP id
 586e51a60fabf-44cab72dbf7mr4223853fac.18.1783010493890; 
 Thu, 02 Jul 2026 09:41:33 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:05 -0600
Subject: [PATCH v5 13/18] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-13-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=P7lO9A8LPVkryGsY8RIV4ZKJga8IqX0oHHS7prrgxeo=;
 b=ZiFRjEQiBoPzgQl6ZTTsrHxeLEogZj8ZTL25G5df3P3s4Sjm5hzaZ+RcbiN9KKPPzRnwz2kQ0
 YGjKn7AsmcgBmT4HfFcylcgtMeY+kn8FVpTH3iojpRO7wDqkeTltnqP
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

dynamic-debug currently has 2 __sections (__dyndbg, __dyndb_classes),
struct _ddebug_info keeps track of them both, with 2 members each:
_vec and _vec#_len.

We need to loop over these sections, with index and record pointer,
making ref to both _vec and _vec_len.  This is already fiddly and
error-prone, and will get worse as we add a 3rd section.

Lets instead embed/abstract the fiddly-ness in the `for_subvec()`
macro, and avoid repeating it going forward.

This is a for-loop macro expander, so it syntactically expects to
precede either a single statement or a { block } of them, and the
usual typeof or do-while-0 tricks are unavailable to fix the
multiple-expansion warning.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b699ed23d26..d99c69b9ad12 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -149,6 +149,20 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a member in @_box
+ */
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for ((_i) = 0, (_sp) = (_box)->_vec;		\
+	     (_i) < (_box)->num_##_vec;			\
+	     (_i)++, (_sp)++)		/* { block } */
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
@@ -156,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1167,8 +1181,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",

-- 
2.54.0

