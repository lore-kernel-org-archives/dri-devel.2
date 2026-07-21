Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9441CC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA1610EB68;
	Tue, 21 Jul 2026 20:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M3SY5FZv";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC18310EB45
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:57:39 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso4048544a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784667459; x=1785272259; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j4aVJpn3vfy3xA0GhAwM1FOdL9CLIB76+lVPPxbP18Q=;
 b=M3SY5FZvN7sJJSOEfsvVAIAXSdP7cPQ/YDgshfXSTIn46mnC15cWeaFOuorsT6VE+R
 s2W3WpEiYGsfcTw/QwUDlsjyRe4/dsl5O+ze97oTh+6ewhmgycA269Yau7HwYjPvoIaj
 0lSZqs/maGzhmQ1MYGXvMqNImy5Y5DJvD7Tbht5a23gyYd998AMizHS5QOffeWlr56FM
 U+sthTEYOk7it/roR3gXXIxcEKns2Mpyz4tNj0QWIW/oa/X80Kcjv/9LIAOV7kV7Ytlx
 cyX9pthcYyMEwak8CQmyt8b4TOw0An0gC5QJ+q3/4xzHg1BaLDkX1jVd016kgBA2O2wn
 pc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784667459; x=1785272259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j4aVJpn3vfy3xA0GhAwM1FOdL9CLIB76+lVPPxbP18Q=;
 b=D3MYTLoxRVugb+jPgdeLK2UDidOuyOqE4ulyj3dudsBKx9B/kOXkPEuzB7GTMFZ5Fg
 A8r7yTFP5DebGhwGEQyEEJfSLoaSrCBRv6QcJVXA60Tal3FmhxYEsyePzQYXiwNFmvZZ
 ZDtClhNbhMkYf1YjXlQGrkny6jdzUYsx2jQbvTrCxT8ILMpDm2b5Vdi/kjJbobK45oxf
 gASYqA3sV2mILmKJoSbYVMEfMmK6TWhGMEZNZEZsFWViAc+r9YQZCzUZGWohCiq18lNg
 Y6efXybzJoKYPts2x2oxevu5un+/6H7QUoXzwCpd5cbIf6ACFjntb6W7KesgpZd8NfGL
 98uw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7avbc3qPwwWlXvOHbtmAJc18HDBBAwxoOrJ4E3C+PZIgjFPRDXLK3dZ8A9ZPpAl7VxTAfca3c50M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM6f3pLttU1/WNwQ/07FU51L/V0AWhD8sNDcjwE06IWEM1O2fe
 sFibqIvA9mJePuHl9yw8jX/zNjBMA2Mf75/Mb3jMpUPDzZVFJ3/oBETW
X-Gm-Gg: AfdE7cnTmhi7y+mU3MEnziR5ctHEucyCEWT+eyLvYkuVP+iZUAK9WvPjln2Jz411rTU
 0se6dV+oR5/Ka+qIw2Evv0Iadh/fMro2O6a/JUkMAYzUinMgjorCa6EcsDZYdAXHAJng5ljuA7V
 Iv6wMrmk1qD0W9WvupRLNYPtmBg8Nr1VBcZOhCMtEDtl+LkMrEVg9QxM6zg9AUGPdCRxxYmwbuR
 slGajIwr6BbXiwP7CEtGbBrKDv6xuqMngzWc+uUIwUtyb1x047I3sqJvLSAoKMkEEZFRizBc3Y1
 5glu64VkxtkTlZ5fRDWJglkC3vXLmQdRDzJ0/oRjt1hMe0rtS+asrYqF7tA/LndyvXbCRn6Xl3C
 4mPzRV19Qot/icWm/9TL9BFA+CGbGn9SgtFyen0SnhSl+uMDjUVDBXqWeinEQ83L7DWibOfrZY1
 Omdhh9mcgERlcsK3+ZTX5IQuBvMcPHtrmseYJ4GqDDubyvHLfenmrhJSquHqYI3H44VFGOM77TR
 LIBnDs2FhSkBoSRP7nDv4/jaA==
X-Received: by 2002:a05:6830:6aeb:b0:7e9:e860:6e7 with SMTP id
 46e09a7af769-7eda4d72f70mr10535815a34.30.1784667458978; 
 Tue, 21 Jul 2026 13:57:38 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:57:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:12 -0600
Subject: [PATCH v7 23/29] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-23-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=WOmyylvrbCAUj/PLsv+3DwmsEySP9ZA6ob9OIeZJi90=;
 b=02Iv05IbxKt1QWjxVRLF70St4DFAX5xXM9zyzq9Rm+AajqCCP2nj8VKq4vfdRX1wOgILqsa/b
 12PseQGUzacDbQt+tP427j5AG06Pxl8LgVAKYqL2Oy2TqvTcllkf2zu
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
index 5abf6ff6be52..59e3c0eccbed 100644
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
@@ -1168,8 +1182,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
2.55.0

