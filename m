Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4407D105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E17C10EC06;
	Fri, 13 Mar 2026 13:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B7Oc/sGg";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933BF10EC0F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:05 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-46703fb602fso906870b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408245; x=1774013045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdG+Un7f/ck3xLwdvB5oV2R2xxQrjM1Me1J1P6bJ/B8=;
 b=B7Oc/sGgi6eQp3zRYL7zvnA1Ug7pae6MPp0eajBrt85vu6cVF+5JeMHGPtT2dZyC7G
 95A7cskUVuwzMPMJfNAwwQB40rKRVbNiD60EeHLYyst6SgW/eufChX6mn3MJlzlcZU2K
 OqRwmTxsCACxFb8KAs7hDMC3EhNDY45DUulWPp7SdsS0KrNCl4KGa9dHs9IBfoPqhEsj
 7sFQnVSbO6ccpe8EUPIeYEA2v6jiC4WBczsUkKbl7ewVayHoo1Klhjl2C8rTeOi2jFk+
 hZLCni8as0ywPgg9NaFVMqx7woPRc6g5lE1v/GnK7qp91OS6nICUL0jKaPT+b9M6RDwK
 yWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408245; x=1774013045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qdG+Un7f/ck3xLwdvB5oV2R2xxQrjM1Me1J1P6bJ/B8=;
 b=S40knf7lbUOhVlZcB8FquH+zLsGo3VgXAbxZleWmcWNLWF2xPqNchW6r9d/mi6jm8z
 AZR9FTYI9C2c1nyr5JkADIyWwV3K6ByAReVZ41HbLJrAHUcgzQHKiHv4H1/GDX6LHv14
 i1+26IbpBfTqmKiTkeetTUH8W241jwgM+g8sNJojaJXEL/Rf53hFD7Pn7AbBAOGKXtb0
 4fBGNYdy8Ip/UP4LVaoHIINGkeFPr4xB6FStk07LOfj3YacahTfsfi+XfIfM6VT2l23b
 eatp/rmeRfrqCPlIc/lxQrLH4hze2ji/2vKOjWkYfEpdxAUzEwJCmmQtcHUEX4hK9048
 13EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG69rM4ap6SC/STQBAQNqmsm2KsTe3stz6GEu7gI/oiLhJtK7WgbTZrVOBq8xPzNDvTUuIMaP1p6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoLyercWhaCyisGWhAjDLxJtAwul30Pv6zuBx6VCTOAFPGDTHO
 IiRwgp9n5CfKlOCs+092e0tc9Glg/ZMqOx/lSWRPVi5Yt/ZiCVaTsQmg
X-Gm-Gg: ATEYQzwpHFwoG/u5BSnWM6GLdcrL5uP6DZgpEZ61EdYtBiTjpKweoH9Xwf7tOUZhD9t
 fD4rCq1cBdLE+pD4PhVRUIfM9hg0pdSmQC5pTK4SVsx2Exg0jixSruYR2aPdNiE1TH6sHNk650n
 8kuC2dikL6IvDpuEQD6PEETQvd8V8t687aMA5TF9FyXYLXzmGLZ7Zj3d6Pw6yKvmT6JNwUxJFjy
 qqmML4OUD2AboFucs5c35WS60wthzoqSPSGSrLvbYjjVhK0TB9IDgJtm1+oz1yT4MHleQGg0g6O
 06hvSid3u/OWuFCNF7FnRylyHCKqU34yJJJRy8eaZ8mgV3oAlN1R1wbyd2HshITg2Zh/I3ZPsDY
 kCiE/9R2QtcPREljuGppNKTjnbCsG6PSG9UBTXvLIaFX1XKv5ylqC6kHCLUrRgz2nDL9MhlDe4e
 lLbU5Pp++0JopMvexVj4rSPCMtpqUj3bwegQmm9Fieb6brCZE7
X-Received: by 2002:a05:6808:4783:b0:466:f60b:19c5 with SMTP id
 5614622812f47-46757052ad7mr1017669b6e.6.1773408244642; 
 Fri, 13 Mar 2026 06:24:04 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:04 -0700 (PDT)
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
Subject: [PATCH v11 31/65] dyndbg: add
 DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)
Date: Fri, 13 Mar 2026 07:19:56 -0600
Message-ID: <20260313132103.2529746-32-jim.cromie@gmail.com>
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

Allow a module to use 2 classmaps together that would otherwise have a
class_id range conflict.

Suppose a drm-driver does:

  DYNAMIC_DEBUG_CLASSMAP_USE(drm_debug_classes);
  DYNAMIC_DEBUG_CLASSMAP_USE(drm_accel_xfer_debug);

If (for some reason) drm-accel cannot define their constants to avoid
DRM's drm_debug_category 0..10 reservations, we would have a conflict
with reserved-ids.

In this case a driver needing to use both would _USE_ one of them with
an offset to avoid the conflict.  This will handle most foreseeable
cases; perhaps a 3-X-3 of classmap-defns X classmap-users would get
too awkward and fiddly.

This is an untested interface extension, so drop this patch if it
feels too speculative, knowing theres at least a notional solution
should the situation arise.

NB: this gets a checkpatch warning about unused _offset arg,
apparently because the arg is 5 lines down, and out of the chunk
context window.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 27 ++++++++++++++++++++++-----
 lib/dynamic_debug.c           | 19 ++++++++++++-------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a1454db1bcb0..0d1245aefc69 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -88,7 +88,7 @@ struct _ddebug_class_map {
 struct _ddebug_class_user {
 	char *mod_name;
 	struct _ddebug_class_map *map;
-	const int offset;	/* user offset to re-number the used map */
+	const int offset;	/* offset from map->base */
 };
 
 /*
@@ -239,11 +239,28 @@ struct _ddebug_class_param {
  *
  * This tells dyndbg that the module has prdbgs with classids defined
  * in the named classmap.  This qualifies "class NAME" >controls on
- * the user module, and ignores unknown names.
+ * the user module, and ignores unknown names. This is a wrapper for
+ * DYNAMIC_DEBUG_CLASSMAP_USE_() with a base offset of 0.
  */
-#define DYNAMIC_DEBUG_CLASSMAP_USE(_var)				\
-	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0, __UNIQUE_ID(_ddebug_class_user))
-#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _offset, _uname)		\
+#define DYNAMIC_DEBUG_CLASSMAP_USE(_var) \
+	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0)
+
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_USE_ - refer to a classmap with a manual offset.
+ * @_var:   name of the exported classmap var to use.
+ * @_offset:  an integer offset to add to the class IDs of the used map.
+ *
+ * This is an extended version of DYNAMIC_DEBUG_CLASSMAP_USE(). It should
+ * only be used to resolve class ID conflicts when a module uses multiple
+ * classmaps that have overlapping ID ranges.
+ *
+ * The final class IDs for the used map will be calculated as:
+ * original_map_base + class_index + @_offset.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _offset)			\
+	__DYNAMIC_DEBUG_CLASSMAP_USE(_var, _offset, __UNIQUE_ID(_ddebug_class_user))
+
+#define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _offset, _uname)		\
 	extern struct _ddebug_class_map _var;				\
 	static struct _ddebug_class_user __aligned(8) __used		\
 	__section("__dyndbg_class_users") _uname = {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e9fa0c8868db..2083a8546460 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -198,7 +198,7 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 		if (idx >= 0) {
 			vpr_di_info(di, "class-ref: %s -> %s.%s ",
 				    cli->mod_name, cli->map->mod_name, query_class);
-			*class_id = idx + cli->map->base;
+			*class_id = idx + cli->map->base - cli->offset;
 			return cli->map;
 		}
 	}
@@ -206,12 +206,17 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 	return NULL;
 }
 
-static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class_map *map)
+static bool ddebug_class_map_in_range(const int class_id, const struct _ddebug_class_map *map)
 {
 	return (class_id >= map->base &&
 		class_id < map->base + map->length);
 }
 
+static bool ddebug_class_user_in_range(const int class_id, const struct _ddebug_class_user *user)
+{
+	return ddebug_class_map_in_range(class_id - user->offset, user->map);
+}
+
 static struct _ddebug_class_map *
 ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
 {
@@ -220,11 +225,11 @@ ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (ddebug_class_in_range(class_id, map))
+		if (ddebug_class_map_in_range(class_id, map))
 			return map;
 
 	for_subvec(i, cli, di, users)
-		if (ddebug_class_in_range(class_id, cli->map))
+		if (ddebug_class_user_in_range(class_id, cli))
 			return cli->map;
 
 	return NULL;
@@ -1178,12 +1183,12 @@ static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp
 	int i;
 
 	for_subvec(i, map, di, maps)
-		if (ddebug_class_in_range(dp->class_id, map))
+		if (ddebug_class_map_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	for_subvec(i, cli, di, users)
-		if (ddebug_class_in_range(dp->class_id, cli->map))
-			return cli->map->class_names[dp->class_id - cli->map->base];
+		if (ddebug_class_user_in_range(dp->class_id, cli))
+			return cli->map->class_names[dp->class_id - cli->map->base - cli->offset];
 
 	return NULL;
 }
-- 
2.53.0

