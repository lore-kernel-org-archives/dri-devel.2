Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2CDCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD6E10F65A;
	Tue,  2 Jun 2026 22:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ot03JO3B";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D864C10F65A
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 22:49:00 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso2441929f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780440539; x=1781045339; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a5wuRkJDj9pHl8KpoGRxyvf+Yl8bVjDmoJ2Kfc5m7ZI=;
 b=ot03JO3Bg2AyetnDEgRAeo2igTzf0euQBg5dP7rJm/l1uekauQBc7gwuj28uWXr0pZ
 yicmZnbk5gdG7yn5BNrtZffpsj7PgmLGc6BvTv7i7/JGCp7x/nV+eIvj86X1Sp5cgwMT
 ld9AlAZg3pDAdaPchPnLrhobE6KFJWFnxEBoMmxAW3M3V2G1DZu/uXB/t739ahijX8+9
 OOQlr39UkQUZvDd92cQI3EReIo5hbwJkcHaFtytB7MNXWguK5DodQHuRGF3lYc4GIr5N
 QfDKnyNQDp16YcJxGG1AwXJu73VviXKea+1K/+UKYV6HdwHdXdpfRVH3dUPLDyqEYfSx
 GI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780440539; x=1781045339;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a5wuRkJDj9pHl8KpoGRxyvf+Yl8bVjDmoJ2Kfc5m7ZI=;
 b=SeZK68l2pmis8GfIAkfwSSfwApU8/RTkjoSh4aZ7EeVwhe25BAy5C2Jv+9UKfKdXqN
 hJ6Liv7SFkjoWIpprLD6HoOw45nx19PEjBkBjLMqdFfWF5idlb5xzdrtB/DJQ887Gha+
 1wPOVN9FMxuFAlgHSUhbVKKEjlEbyM4ofRVq7+HulOud2/yNQtgHtkY43vLRNis8u+0/
 ekjM8IlZDVuHIAyoNL43YkP0ledD7OMxtJERNG4OZXi/VyqrwPAUzQJlxjnro6GQX5B5
 M1S0bHFMG5H0a9NoesqNxIWXkpCWyvDhJ67hukXlinFGOOe0FyKQNm15Ov5Ol1Su5xVR
 kN+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tlVkGqfCbOPOqzYDf6CQJxixjLWAbIU/Ut8sHtkxZ5L+oAym8hdUW/J0Ly/i5OFSSl7Kb/gY2oq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2UVDaOJpgLnv8H+TIqhUD663XmyL5o/zs4B2QwO0TgtHQqU09
 GkUq01H9/r+3KprzPrC3fMpw+6wXPoMmqjSSckoByWLAfoW3eEikBLYz
X-Gm-Gg: Acq92OFTX7vB0MAoH4rJfHwuKff3i7J/jhUmgluJynORwWck600ekQFeAozeic1OaNv
 CW3jQqDJsn3TPxynWri1wVp0ulGX6w4iqVS+IW3GgM2va0c0lTHIXRzxWP0MUae9lVAjKipOO5Y
 zn1ZRmgvsEdfFIxIqdjlMwi/CjLweukCriXPmocMvrt4zZy7YlzObDc+4i/8Edl4SFe8uH5OOI6
 rJvsbcMRh3cwhPRw22oyzs3Bd3xn6Ryh9cNKKqBD9TUM+nceIOgFWq65vd+I0j899yUDuQQ3FVy
 UDKS3DaG6JyD2zAdxDVWJ33OkwyrvnujjkHt0Orx0DF94Dre/4nzur5hBbOuA/XLO0kdUPYOJcu
 vJ7vuiF1LU+WWBDc1ts7UNe29UBmqKhLNZtcufVQGJEAbbLV07koVNIN2KNeuMpYM9KbOitw+JQ
 XDiY8CF2MMnx4M3NbYqwOSVtzuZTQgH5j4hPyeaPjgew==
X-Received: by 2002:a05:600c:1d09:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-490b5e51a49mr12032925e9.16.1780440539379; 
 Tue, 02 Jun 2026 15:48:59 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 15:48:58 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:14 +0000
Subject: [PATCH v4 17/25] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-17-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4lg9KesBI/N2Rj/6xaevlfNeh5wYawcWkW4JaA+kRgg=;
 b=3P7+mdCXoJxjAUzdstBNcQwkEcs02tscKMoOPE9iAw0vT6di3+pyxw9lbgtyKlr9wFEn3rgo6
 J9clxTxMwNZDcYTI18IdMjs4v5w40CS0kYdfPFI8qc5yiKQpwOZjsfF
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
index b8a494835ef5..a593e040d1ae 100644
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
@@ -1162,8 +1176,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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

