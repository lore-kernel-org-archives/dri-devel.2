Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A9CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F4210EF93;
	Wed,  8 Jul 2026 02:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqF2ihCB";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A5B10EF8D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:19:00 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-49fa951b2c6so164326b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783477140; x=1784081940; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k3atFQ3HfHjIkDoR1IKy8zbGv01SGi/asouemJLY7Wc=;
 b=hqF2ihCB2VtLTGgTvkcF3hwH87IDn6ZPu6VSogMW4OBKl5dhziAiFY3AdS5zqTjNHw
 GCD38EQSQMmRQyyPWMFQBWl0mWf+gIpue/f5NH9TpolMrxiejDqSFIqb4pMDhcNlbZXh
 9AfsS3+D3w9nzEiK/FvWajR1AvkkQT0nHDScpM/DiS4ZKWWPPrM+/gYfZw86LsfFuv6T
 +oDaEv7XbXpZuk88A76chC8mG2lncxOkd8g5vEGyAddYLB8Dw1dUqsTXyGwgkHNJnkGT
 Sl296E6vCktaImAEi9SaSTtjmpKHkrYc7ZryaZQSgym+vMAOyp4opfyZWz8HoVimr/C4
 5LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783477140; x=1784081940;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k3atFQ3HfHjIkDoR1IKy8zbGv01SGi/asouemJLY7Wc=;
 b=BgnX8PXK9PqHKgk0skYS0EJS6rpskp1iguZ9ECaLidUTof/0K6tL10jCgI9upMa3Q3
 ZVu6RKHHQrV9fnQM9am0uc5mC9Vlj+goO/8eZGg5FdvQazAj2uvLEy7e2HBYTY68EZgY
 cq/JO3qhfCqyOt9StnipcdLc+8s5X730YVDR2hrRfovZN0Snv7BLw35IJzbeKScLC4HZ
 ktIeisO4VGJjHRK5efKDnvXzho5gICoHMSUqVeMaTyobIHrRfePi7TyA6E6fbOu1ofrp
 fWsdWORdchfGx4PlP23i1jLedky7h2R555tTdpwRKA1B0KivhtPKV2iCYqOFkKdixMTM
 +NCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M49ikN3rNzl7FVVnH+7Yf598AUxBb/A/AtThB5AWpFuq1SZwzR5HmHOGMlE6PxEWvwLVSPs0LfGM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYLzzqGA4WjEWoeTS84lcTuc5W4Qbg4dtULV/xO5ShwPl3ByRn
 rr22LZ65kzgnVrBxIbmLVilacH+epXR1/oN1jhAm9u5aJ2evTx2hzNLv
X-Gm-Gg: AfdE7ckdBwyBjdVhzsOXnIH9Mut23uBuedPsp0bB1i27NVwl4a5Zihk3JewrUKO37YF
 Melu3AsS/2DhCfMRQa7qbSPIm1/305dU4WdUUc/gVSiIBK7dlMA8LZVHEf2zqDkvsV1dmZoQapA
 anB8ty5ntgbVWORaDFq6OKGvS1hvROEeR1GllKesLhxFmQR9KsMkC9n2kwS1u0eUNwftXzZMOSI
 AvxdKuw7+V6cMwmoxYNAal4RZCLrGs7wmQ+PZu0Mn0OgOFBLRJiRyjvvYnpvEwmuNFN0IV3Shbv
 8C3vh2mNoSVeQfizm7gO4taXzZC+2E/OzeKCDCQVKP0CXjXlI/Xv4S7lP3vC3i6PvQTve8sM48O
 yiKZTAfQjdar+nPArkKe9SHz39ndnyFlukd+eVkG9+QRakEG/YHq11HGnp8/fqvPkoq/ZCb1n2p
 isflNmbFjSNcPfejmKPAginsYg2A53rAaCHM5h55Qno2Nu6Os9hp4=
X-Received: by 2002:a05:6808:124b:b0:496:e0:a47b with SMTP id
 5614622812f47-4a2039be59bmr318703b6e.20.1783477139780; 
 Tue, 07 Jul 2026 19:18:59 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 19:18:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:18 -0600
Subject: [PATCH v6 18/24] dyndbg: macrofy a 2-index for-loop pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-18-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=f1LMLcm7HpUCjY0LgwqyXWI/nbYSKkJlJGfL377JIvQ=;
 b=trvcg9ZaNLsNIpDb6Uahb5ZcOJlCuDAsyAa+3eRBSZB7MO61jqTE3zrEhQimlEmwi6binJuG6
 P6IJQn6YMJGAAWzMGNmmmraV/JO+uz6t5b2sQ/9PueOX3S0uipM51O6
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
2.55.0

