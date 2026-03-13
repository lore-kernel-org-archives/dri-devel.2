Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D026C105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6431610EBF7;
	Fri, 13 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZM9S4sd";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E690210EBFC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:26 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-464bc03efd8so1514682b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408206; x=1774013006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBYomo+y0fMuoiYBGpthmpNvx8Y41pycbs0VlWTcMIg=;
 b=UZM9S4sdkGpGxrMIdeGHuzc0BkHSdiyN96WL+0GCG/naM6Uf+0UFgglWJ5Mo1uADA5
 BcE7ghQWe+G/lpWJ28HQ7hEKcbRVkedIA7tyxSm0IV7S1r0H2PNxUcL5+1umsjsJeVcT
 prrHz8l23c32jRz3y5/nNgK0XokVX1USct9742BFVjkD/8bjdfNl+GALI7CnUI92KTDp
 u3ZBcuLx8+VEGbRq9iZ6ysgUGyW9a8iu/fsfQOY4UOP3+fPQ/QuiQG54MiNqdQIbNNGu
 T+GsD9tMQMYAKYoVHQiy3YbW8UqAY8S8zIuaqSUSK8W7NEWddrs8t0UlMPscV0fQmqWb
 YvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408206; x=1774013006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dBYomo+y0fMuoiYBGpthmpNvx8Y41pycbs0VlWTcMIg=;
 b=N7y06uJNBPKSnGBl1Lb1TaEMrS8YKDSZfI7zJBYiF1B29Enk/ZW5zIYRS0TtAXdJ5H
 +yo0fFj+hLp/WmZmtlAo/PBLRTe1lDmZA0dqJ/esRpChbiX0bBjkmb3Wa4f1J+jMdfdu
 zmOci/nwJakfchZI/EtqUVgiUB5Jir7FOKvoJP7lB1T4KxqL6N5nLCU0EOnY7bAY6eDY
 JgU2C5ZH9IZkYrD8k3+a7pvvTT8eihXcCcpCk4TGqF/5ZO9iXaJFJ7fC8tai4B2mqCb1
 OkPEFZVNbiCyd58ML/lzuJn08FVZZnNZg8eB//AZjaeRhHBj6qXFkzcYEWeWVgkQI+hj
 czjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU13O8yyI/Lo90yiZ2c+O5LweNfJoI88L/QHGvyVr9wlqeQkk9ebkwGtvWpZ+s6mf10lWU9k97J5Qc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOt7yGZL8XBCf4WI44CSAzIlvi+9M6Gqn/cwNxg5rks77Xw9jo
 WsOgaE4K73ir/5ivTAa4c2rdTK74ZPpgDbiWbuOe0RZ7rUHA+qLVYESE
X-Gm-Gg: ATEYQzybS2+72h0OCUKCOuXobxNYVxpEYNisgvnx4PdH7+GBzsIdz0jvb2WLZOJDcvK
 mjcI2ItVr86igW1dUTVkDvmf1KRxtrf2mthxolspnwVIda6WeD2wWcy5C29cwRwyaK2scCpbLpa
 xFhVSNmDJMAEsseA8OW81EIsQts/MEVgOKRaA7tdwnHxkHueMbtTOVr6AB1pxER34k+mLpdaIiM
 +t2LhwpP+xCYhmRqVSB5ZrljgvgLnSelAizztMx01gW0NWN1ka1IsOIDCmz5Nxk0y1sIv8aeED1
 dT0aZAMwpDMEiG3kaH+rC0UDxm3EEMomzFdk8b6FwcxxTCfrl2FOF+hJzEIhun+KW+ef9j41AMg
 fCB7w2a9FZYc0+MndU74SFGWsAngLBizE3WN4PLD+td895vF+x8FPnPo+ZE37cf7Y8DGWXUB4Lt
 TDjOXzv0oSXj6+seNH6QlcNJ7gJFPaiV8vw13MiV4dzmVMahTq
X-Received: by 2002:a05:6808:221f:b0:455:d5d1:8ac0 with SMTP id
 5614622812f47-467574375ccmr1562149b6e.53.1773408205979; 
 Fri, 13 Mar 2026 06:23:25 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:25 -0700 (PDT)
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
Subject: [PATCH v11 15/65] dyndbg: macrofy a 2-index for-loop pattern
Date: Fri, 13 Mar 2026 07:19:40 -0600
Message-ID: <20260313132103.2529746-16-jim.cromie@gmail.com>
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
   ie: _X->_Y and _X->num##_Y are lvalues.

The for_subvec() macro then invokes these before the for-loop itself;
they disappear at runtime.  They do cause a "complex macro" CHECK from
checkpatch --strict.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 94a66c8537ab..cb7bfe8729a7 100644
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
+	((void)sizeof((_box)->_vec + (_box)->num##_vec))
+
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for (__ASSERT_IS_LVALUE(_i),			\
+		__ASSERT_IS_LVALUE(_sp),		\
+		__ASSERT_HAS_VEC_MEMBER(_box, _vec),	\
+		(_i) = 0,				\
+		(_sp) = (_box)->_vec;			\
+	     (_i) < (_box)->num##_vec;			\
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

