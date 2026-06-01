Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B51CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9246E11326E;
	Mon,  1 Jun 2026 12:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXe3kdln";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997B911326E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 12:05:43 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so2530352f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780315542; x=1780920342; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ech87mZQ32X3CZj+LUnUER+oXQssLV3xJ3OsaeZimlc=;
 b=PXe3kdlnrrKTuFBX8x5y4gTXAufgzlwy+FGNxC2b7uz/J1DgDQGkrn8AdKonawNMjd
 ofwfewZw+31o3+YgwKnhsvfrnlvw9gqeKyyJycSNrN3pXZ/RrCY6tcBbDIHawTMMrvlm
 eiKLEdgWNVjc6n54WP8RqWPs0umz08yiOrFVLQW6J9HNt8+KB096p9AfRJ3PCDi3fG69
 oMv3Gtl5F0yF5a0RAjySkJK6JvKqgdtFBk/RdxEjK0323uYgtPln/SbElI6X3lpLvLNq
 LLh9GVmNrowV7oxNARBM9LzUxwKcjJxwA5qmZPTc2sPDLnISeqG6NS8rbMCy0wpRyZGT
 EQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780315542; x=1780920342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ech87mZQ32X3CZj+LUnUER+oXQssLV3xJ3OsaeZimlc=;
 b=mUQ3XE7TkzIxyAj8Kotmgwdj1qCBN+f7MfP/uHk9W3Ip7JwuWgNgx+pPkYeCKK0PN7
 WAEH0NoywPUaimfamPAHXIT6ebV7ZjX7nFva6xG/7rL36iJClDJIi9u1N/YX4fBi5rfP
 4jr6n+af5jIbtJEAe+77ekvxzRSAr9mLVuba67j3QIs03fYN8AN2+VkPxp0Mf6AVB5KI
 iDkd3m0uEdzm5KeCbWjx8nquf7k7WB5W8RU6cctA56Ai4PmkypgZQRbN3539jGEaY20v
 0kS9J9uWWPkfbk3tW4yTE5HW/LwxInT/7S9PO+Z00dC/iVY/0nzWt64yFCvvVABCvWar
 qwag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jp7Cy077LF9jyH31Yv+EWHgv9PPTHSn3rY68HxwLEByPeiCFFE04NsCxh9BSOjH8UTLAPEcjGqyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwkDIq1t9WDNXgf0YZivgKXqFAxCNMTrUQULs/9avGVKpz/qIq
 xNHjIG3Xfoj/180JFS00zBfJeffBjM8l67+7GiyqeTnq4hjCqiaOqmr4
X-Gm-Gg: Acq92OH43Vl5XS4xEJ8P1FsbwHae+AzMAFZsQn+zfyAa+AhGS1EXl1HUAvq8+edL5IF
 3ZKSd645yc8oKj8iqMJ3xJ/6T94qjttcfDDPEp1kd4fATLwugG9jY3D5kPfuqpfgbCrxhgeqJ35
 3Voe4kg2mmz7KZgtYFrkQ18DjlXejusAy0jrbMNsNpw0ZhJSAa4OFwFqSIDEzaR60I31si6TR33
 D8YqlRP616C3/edd+VibRDJXH4Ytm/uyTQ+AiUNOLzSj71ayyURcJZnqe5UfrlDtMOF3FM+Nbvv
 pErUgjmyyJglYchTTW014TDUCUTQXBGXskgad4FDphpeEmGdEZ0A8zhV4tPqg4uSlVm5v2VEsuv
 Oyemipp/G8EgHK+jOQsLVDt8rr+fPoblW3cgR+X9lELcbEr5Xl5ZIrAawzTCTWjbkKkkXpfBU0e
 lIgNskSMfKBeL0pKtz5huTOiwYkbUpUXjnTs3/IzV2Aw==
X-Received: by 2002:a05:600c:1913:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490af632efamr7899045e9.7.1780315542019; 
 Mon, 01 Jun 2026 05:05:42 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 05:05:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:03 +0000
Subject: [PATCH v3 17/24] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-17-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=2772;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZfklE9gj7vCfD3eea9V5X8HvMt8Vi5qjDtQN6GjxEN8=;
 b=n8nbwWaKVqGnAekTc7n4FU2ddyIF+UIcZ6wRa5fDPjwBR201R0OD3zGDuaEJfEr7LlWKf47jD
 m33YXSb5mcNDMK+V9++XRt+r3LXwU+PrmjEmwe2Tl6yun1FRoZoWzIK
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
index 34d002e0a08c..41bbb72ef730 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -129,6 +129,20 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
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
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -156,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1160,8 +1174,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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

