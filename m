Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D9E10AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9691010EBA2;
	Thu, 26 Mar 2026 18:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D823dePZ";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23A010EBA2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:57 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-467161c4b89so726109b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551297; x=1775156097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R72DzlYh9MokOK1r/XXtR9MDuFmHujj2u63MvUuPRVY=;
 b=D823dePZIphZsWPbz5YiznN5vUvSMv0PzCya4dx7BvEc+rCuKXVkL/FmfGwjhowdgf
 MiuJobxdEveUXOQBkXgFpDn4aTW1+eiresqzwASNU00HOCsEDQgVPJCdEHOW0GKHnTm3
 IwvNtng8nz/gsfQ/DlESflAu7s987H/5zA3+Ci8a7jfG56nQ51QBMKo/KhIs1XepX3jw
 iHB3/U4pNEhkC90DfFoSkOlZldRryCypeXJ79yS7TtpgLZwnIA3eQTTmmF0XhTcyv5wx
 +yBmnsWO3gD3VyUuHddOkqr6FM7V/qTfAXmOJ5VCNZ5hTR6eueLAjxwLm95Kjrddkikf
 SLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551297; x=1775156097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R72DzlYh9MokOK1r/XXtR9MDuFmHujj2u63MvUuPRVY=;
 b=kulo3WgtH2ND9m3U7ZVOlHg6fdf+FYhUw8MF2evvmLVtw//SknBylVKjuMxjcK981S
 q9BkaA8Ysw/ERI9WGju7iirpKgNIXTlHeKCQeCxSq71pJV46IlA+3cmTHq08iqWhxbXC
 08Zk8ch8+8a6kn1u87rYfNcRyDPim2kYGAL4BXEuEkZD/zuZRI2Gqqb/CZLygKT/A+F8
 SmvvdiW1cP1RuUriaGlcnluRF4zXfM2Mm5Nf8rPEHcVyiKEaCzL6mRHePe3eCkrAZ8A3
 BLz1qOjesJNFQQHTlLesicNZhYHiQywG/fFZ1iLL6+MccQj3hsqXTDOMCk/vYsxn4uTc
 O+Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3LYQb4CopWvDb6PAQ0meN3Cg5wOFIzU+yTvLeVptSeNt5vq3RnP+crHO3SaSOinU05svJmX7h19I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa4OJhhBDqW9DwPVnNhfKaJYF7pDuZmdFrfw1sYfoDboWFfo9S
 OrZbV2OmAlyztfXsAxzlkBjKbCjdqWa8KoF6cgHDIduFr5AHv79gUAgL
X-Gm-Gg: ATEYQzzSU85+DMIW/BWMrdHCM5ArTCEfCPebyzd8iZg2dfAMW10AFY7x8a/SbxxrplH
 ZTPxOGpfh8Be3GDUStJOeyWtYtR7xCfZyMQ5gM0yxhJosURMEXPZoPt6pZpBpwOpXfOTeKKUo4D
 MP31btOwUcYU+YuPWQ6IxAF/hZvHboSDANUBH94YNWnjtgdciKO5W+N4WjThZEkVKh0Sz/Rs6xT
 DtFKowV2ds2hPHRS6GPmSfXODb3czEvhplTpbJ8oCtGwmwmD8jfSoyjI751+kmQNc7mTC5z/qoc
 xA1x5139TNNJNuGQfiCGiKceAGFL3wmSvH16CapTrvaEW3NYhZ+UaG0dQMymeI2JkuvaV0pkl/x
 ZywRdhRqCWz/a/oQqHhpwIxXx96Rnl5ReC8n+1t6g/XSsILi1d6g3EAE513eqa3uXWRHnrbCjq4
 ojGPGjYsNPkeunUKNjZg8mCD3LgUqQjT9zcwS37h5cG1OmjJav
X-Received: by 2002:a05:6808:c299:b0:467:14c7:a8ae with SMTP id
 5614622812f47-46a5c5f7c5cmr3888707b6e.21.1774551297062; 
 Thu, 26 Mar 2026 11:54:57 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:56 -0700 (PDT)
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
Subject: [PATCH v12 18/69] dyndbg: macrofy a 2-index for-loop pattern
Date: Thu, 26 Mar 2026 12:53:22 -0600
Message-ID: <20260326185413.1205870-19-jim.cromie@gmail.com>
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

The macro needs a lot from its caller: it needs 2 local vars, 1 of
which is a ref to a contained struct with named members.  To support
these requirements, add:

1. __ASSERT_IS_LVALUE(_X):
   ie: ((void)sizeof((void)0, &(x)))

2. __ASSERT_HAS_VEC_MEMBERS(_X, _Y):
   compile-time check that the _Y "vector" exists
   ie: _X->_Y and _X->num_##_Y are lvalues.

The for_subvec() macro then invokes these in the initialization of the
for-loop; they disappear at runtime.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 94a66c8537ab..8f614eba8ace 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -129,6 +129,28 @@ do {								\
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
+#define __ASSERT_IS_LVALUE(x) ((void)sizeof((void)0, &(x)))
+#define __ASSERT_HAS_VEC_MEMBER(_box, _vec) \
+	(void)sizeof((_box)->_vec + (_box)->num_##_vec)
+
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for (__ASSERT_IS_LVALUE(_i),			\
+		__ASSERT_IS_LVALUE(_sp),		\
+		__ASSERT_HAS_VEC_MEMBER(_box, _vec),	\
+		(_i) = 0,				\
+		(_sp) = (_box)->_vec;			\
+	     (_i) < (_box)->num_##_vec;			\
+	     (_i)++, (_sp)++)		/* { block } */
+
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
@@ -156,7 +178,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1232,8 +1254,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
2.53.0

