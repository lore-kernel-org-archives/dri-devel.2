Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A3110AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DBB10EBD8;
	Thu, 26 Mar 2026 18:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4Lv29qf";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52CEC10EBC6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:20 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so935685fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551319; x=1775156119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J42RjL3XW7iYvn8zHG5csoL/H2RaSYA/baR8+V+mULo=;
 b=i4Lv29qfH6N3bLTT6fIAyQtJz4OY+E+yBfsb9OTHWnK27Ju9PSAMJus5HLp+c7XlWO
 mnjiislFaqyuzUKaDSmWMZIOr321Vsr1r9hp9NPIcvBo9rsAUuuFyEwBxMg1z9T6cuMc
 UrN3F+XzL2/U35jRMqHfkgVvrzyF6v6dYct+7r1v7rBVE8tG4kB5JAHCr+9zanQQH3a/
 DFhAsyHkRR2En0Igx56zLxmmuoJAvvpDkuKJ9U5DWNz3LdDzWBfa/MT/bH2WXfwEZrs3
 UNzAI+3T+ft+uglRcsAYXtyH40kIAYb8jIkgKNXM79kSkosOrCH0GoqCLiDtOjJYGkfT
 ovpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551319; x=1775156119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J42RjL3XW7iYvn8zHG5csoL/H2RaSYA/baR8+V+mULo=;
 b=ozDgLkwN0NzVEh2L3GJOK56ZMeeMAJqxoJeJwUYt4YCtTF71rVrHa0V11ahVif/KJP
 tY2xrFitEkdVRLY+k5JCWB0J0wYDk3WOPM46sjxPshNfNUtBqDvsRxqqLEcwqMIqDBgl
 mGC7fJq3t7FnhHHfYnCms18jUynTKtCE57AOxkBzpScthj6Zk9FP29DUIvL6idhjt4zZ
 cD33UXJE/TCmDQsKfwtPvnUlkYZO0W1vdRzWGOhDIdCnuX4jVMvdYV4wIrxjru7CEAry
 OrwI7h5adjiU/k4PcClUwITV2NZAL+1CIf/rZ4xRpHe6O09RtQg9Ju+k7HGnIiRh3dAn
 R1ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6bgsZj1k2oTHoCThoV4K5naPJ0V8KNcivDvJd9Ik6XeeRQKhhtiG3qwuMMAEy3ABgjhSHNQr4pSI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz8mmILT1eI1ee4Avw9abuu8FyDVkAP+KjUon3HIhaA7VgJaZ5
 UU1duP8zuN3safRDZEhugwrVusRq2dkJSHWr5Nl6IRjW77TZ4RgCrzul
X-Gm-Gg: ATEYQzx3j/oYukoVitIv7zOM2Mzk6MK+oYb3vIwGySrM7GqucOvE/R6B1z5IG5mE4AS
 Mw7BIRu3QnVNYOTi8+L6P2h0UJaTHuXY+JKaxO/qgpjJxBqKNlVuLJpRTizmgcEVt+gpLJFO+mF
 jcWLg5BypiicrTvLqs12Lgg8uor6rSSnu7QqIFhxU+11izFUp7jwYgMG8qWyldjFOMsv+S+2E2Q
 7kVKBFs2aWIQVsG03bWOsAO8pyzQfi80uIhM/5yk6Sf0e4PGJJGk7sVtSOOOltfFytLiC0bN9M4
 jaibo75Z9A2SjBhzrxC10nvi1lMVQn2hxGWDFTNobZ/VPWyb+c6jAEEn1PBvo/RfQr4YdAf0+R/
 lMzScSbDqOD3n0FVacWGS5+68dGceBNngGwmNsVcY3ClyPGm8o0KyZ7RwF2/AChnFxKiTH4Yx8B
 PlBUf8g4s5HJRfDurn/tg2cAcCC4BvksiP1zM/eQroLIImAuWz
X-Received: by 2002:a05:6870:d8cc:b0:417:c2d1:fc36 with SMTP id
 586e51a60fabf-41ca7051971mr4708391fac.33.1774551319350; 
 Thu, 26 Mar 2026 11:55:19 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:18 -0700 (PDT)
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
Subject: [PATCH v12 33/69] dyndbg: resolve "protection" of class'd pr_debug
Date: Thu, 26 Mar 2026 12:53:37 -0600
Message-ID: <20260326185413.1205870-34-jim.cromie@gmail.com>
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

classmap-v1 code protected class'd pr_debugs from unintended
changes by unclassed/_DFLT queries:

  # - to declutter examples:
  alias ddcmd='echo $* > /proc/dynamic_debug/control'

  # IOW, this should NOT alter drm.debug settings
  ddcmd -p

  # Instead, you must name the class to change it.
  # Protective but tedious
  ddcmd class DRM_UT_CORE +p

  # Or do it the (old school) subsystem way
  # This is ABI !!
  echo 1 > /sys/module/drm/parameters/debug

Since the debug sysfs-node is ABI, if dyndbg is going to implement it,
it must also honor its settings; it must at least protect against
accidental changes to its classes from legacy queries.

The protection allows all previously conceived queries to work the way
they always have; ie select the same set of pr_debugs, despite the
inclusion of whole new classes of pr_debugs.

But that choice has 2 downsides:

1. "name the class to change it" makes a tedious long-winded
interface, needing many commands to set DRM_UT_* one at a time.

2. It makes the class keyword special in some sense; the other
keywords skip only on query mismatch, otherwise the code falls thru to
adjust the pr-debug site.

 Jason Baron	didn't like v1 on point 2.
 Louis Chauvet	didn't like recent rev on point 1 tedium.

But that said: /sys/ is ABI, so this must be reliable:

  #> echo 0x1f > /sys/module/drm/parameters/debug

It 'just works' without dyndbg underneath; we must deliver that same
stability.  Convenience is secondary.

The new resolution:

If ABI is the blocking issue, then no ABI means no blocking issue.
IOW, if the classmap has no presence under /sys/*, ie no PARAM, there
is no ABI to guard, and no reason to enforce a tedious interface.

In the future, if DRM wants to alter this protection, that is
practical, but I think default-on is the correct mode.

So atm classes without a PARAM are unprotected at >control, allowing
admins their shortcuts.  I think this could satisfy all viewpoints.

That said, theres also a possibility of wildcard classes:

   #> ddcmd class '*' +p

Currently, the query-class is exact-matched against each module's
classmaps.names.  This gives precise behavior, a good basis.

But class wildcards are possible, they just did'nt appear useful for
DRM, whose classmap names are a flat DRM_UT_* namespace.

IOW, theres no useful selectivity there:

   #> ddcmd class "DRM_*" +p		# these enable every DRM_* class
   #> ddcmd class "DRM_UT_*" +p

   #> ddcmd class "DRM_UT_V*" +p	# finally select just 1: DRM_UT_VBL
   #> ddcmd class "DRM_UT_D*" +p	# but this gets 3

   #> ddcmd class "D*V*" +p		# here be dragons

But there is debatable utility in the feature.

   #> ddcmd class __DEFAULT__ -p	# what about this ?
   #> ddcmd -p				# thats what this does. automatically

Anyway, this patch does:

1. adds link field from _ddebug_class_map to the .controlling_param

2. sets it in ddebug_match_apply_kparam(), during modprobe/init,
   when options like drm.debug=VAL are handled.

3. ddebug_class_has_param() now checks .controlling_param

4. ddebug_class_wants_protection() macro renames 3.
   this frames it as a separable policy decision

5. ddebug_match_desc() gets the most attention:

a. move classmap consideration to the bottom
   this insures all other constraints act 1st.
   allows simpler 'final' decisions.

b. split class choices cleanly on query:
   class FOO vs none, and class'd vs _DPRINTK_CLASS_DFLT site.

c. calls 4 when applying a class-less query to a class'd pr_debug
   here we need a new fn to find the classmap with this .class_id

d. calls new ddebug_find_classmap_by_class_id().
   when class-less query looks at a class'd pr_debug.
   finds classmap, which can then decide, currently by PARAM existence.

NOTES:

protection is only against class-less queries, explicit "class FOO"
adjustments are allowed (that is the mechanism).

The drm.debug sysfs-node heavily under-specifies the class'd pr_debugs
it controls; none of the +mfls prefixing flags have any effect, and
each callsite remains individually controllable. drm.debug just
toggles the +p flag for all the modules' class'd pr_debugs.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
-v12

minor fixup after squashing subsequent commits to previous ones
---
 include/linux/dynamic_debug.h |  14 ++--
 lib/dynamic_debug.c           | 137 ++++++++++++++++++++++++++--------
 2 files changed, 115 insertions(+), 36 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 1cae9a2f32d7..1b401f398a3c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -76,6 +76,7 @@ enum ddebug_class_map_type {
  * map @class_names 0..N to consecutive constants starting at @base.
  */
 struct _ddebug_class_map {
+	struct _ddebug_class_param *controlling_param;
 	const struct module *mod;	/* NULL for builtins */
 	const char *mod_name;		/* needed for builtins */
 	const char **class_names;
@@ -281,7 +282,12 @@ struct _ddebug_class_param {
  *
  * Creates a sysfs-param to control the classes defined by the
  * exported classmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in a private long int.
+ *
+ * Since sysfs-params are ABI, this also protects the classmap'd
+ * pr_debugs from un-class'd `echo -p > /proc/dynamic_debug/control`
+ * changes.
+ *
+ * This keeps class-state in a private long int.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
 	static unsigned long _name##_bvec;				\
@@ -294,10 +300,8 @@ struct _ddebug_class_param {
  * @_var:   name of the (exported) classmap var defining the classes/bits
  * @_flags: flags to be toggled, typically just 'p'
  *
- * Creates a sysfs-param to control the classes defined by the
- * exported clasmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in user @_bits.  This lets drm check
- * __drm_debug elsewhere too.
+ * Like DYNAMIC_DEBUG_CLASSMAP_PARAM, but maintains param-state in
+ * extern @_bits.  This lets DRM check __drm_debug elsewhere too.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
 	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6430f77c7b9c..66879a40b822 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -206,6 +206,55 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
 	return NULL;
 }
 
+static bool ddebug_class_map_in_range(const int class_id, const struct _ddebug_class_map *map)
+{
+	return (class_id >= map->base &&
+		class_id < map->base + map->length);
+}
+
+static bool ddebug_class_user_in_range(const int class_id, const struct _ddebug_class_user *user)
+{
+	return ddebug_class_map_in_range(class_id - user->offset, user->map);
+}
+
+static struct _ddebug_class_map *
+ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
+{
+	struct _ddebug_class_map *map;
+	struct _ddebug_class_user *cli;
+	int i;
+
+	for_subvec(i, map, di, maps)
+		if (ddebug_class_map_in_range(class_id, map))
+			return map;
+
+	for_subvec(i, cli, di, users)
+		if (ddebug_class_user_in_range(class_id, cli))
+			return cli->map;
+
+	return NULL;
+}
+
+/*
+ * classmaps-V1 protected classes from changes by legacy commands
+ * (those selecting _DPRINTK_CLASS_DFLT by omission).  This had the
+ * downside that saying "class FOO" for every change can get tedious.
+ *
+ * V2 is smarter, it protects class-maps if the defining module also
+ * calls DYNAMIC_DEBUG_CLASSMAP_PARAM to create a sysfs parameter.
+ * Since the author wants the knob, we should assume they intend to
+ * use it (in preference to "class FOO +p" >control), and want to
+ * trust its settings.  This gives protection when its useful, and not
+ * when its just tedious.
+ */
+static inline bool ddebug_class_has_param(const struct _ddebug_class_map *map)
+{
+	return !!(map->controlling_param);
+}
+
+/* re-framed as a policy choice */
+#define ddebug_class_wants_protection(map) (ddebug_class_has_param(map))
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -214,11 +263,10 @@ ddebug_find_valid_class(struct _ddebug_info const *di, const char *query_class,
  */
 static bool ddebug_match_desc(const struct ddebug_query *query,
 			      struct _ddebug *dp,
-			      int valid_class)
+			      struct _ddebug_info *di,
+			      int selected_class)
 {
-	/* match site against query-class */
-	if (dp->class_id != valid_class)
-		return false;
+	struct _ddebug_class_map *site_map;
 
 	/* match against the source filename */
 	if (query->filename &&
@@ -255,7 +303,28 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
-	return true;
+	/*
+	 * above are all satisfied, so we can make final decisions:
+	 * 1- class FOO or implied class __DEFAULT__
+	 * 2- site.is_classed or not
+	 */
+	if (query->class_string) {
+		/* class FOO given, exact match required */
+		return (dp->class_id == selected_class);
+	}
+	/* query class __DEFAULT__ by omission. */
+	if (dp->class_id == _DPRINTK_CLASS_DFLT) {
+		/* un-classed site */
+		return true;
+	}
+	/* site is class'd */
+	site_map = ddebug_find_map_by_class_id(di, dp->class_id);
+	if (!site_map) {
+		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", dp->class_id, di->mod_name);
+		return false;
+	}
+	/* module(-param) decides protection */
+	return !ddebug_class_wants_protection(site_map);
 }
 
 static int ddebug_change(const struct ddebug_query *query, struct flag_settings *modifiers)
@@ -265,33 +334,31 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct _ddebug_class_map *map = NULL;
-	int valid_class;
+	int selected_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
 		struct _ddebug_info *di = &dt->info;
+		struct _ddebug_class_map *mods_map;
 
 		/* match against the module name */
 		if (query->module &&
 		    !match_wildcard(query->module, di->mod_name))
 			continue;
 
+		selected_class = _DPRINTK_CLASS_DFLT;
 		if (query->class_string) {
-			map = ddebug_find_valid_class(&dt->info, query->class_string,
-						      &valid_class);
-			if (!map)
+			mods_map = ddebug_find_valid_class(di, query->class_string,
+							   &selected_class);
+			if (!mods_map)
 				continue;
-		} else {
-			/* constrain query, do not touch class'd callsites */
-			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
 		for (i = 0; i < di->descs.len; i++) {
 			struct _ddebug *dp = &di->descs.start[i];
 
-			if (!ddebug_match_desc(query, dp, valid_class))
+			if (!ddebug_match_desc(query, dp, di, selected_class))
 				continue;
 
 			nfound++;
@@ -656,6 +723,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 }
 
 /* apply a new class-param setting */
+
 static int ddebug_apply_class_bitmap(const struct _ddebug_class_param *dcp,
 				     const unsigned long *new_bits,
 				     const unsigned long old_bits,
@@ -1107,17 +1175,6 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-static bool ddebug_class_map_in_range(const int class_id, const struct _ddebug_class_map *map)
-{
-	return (class_id >= map->base &&
-		class_id < map->base + map->length);
-}
-
-static bool ddebug_class_user_in_range(const int class_id, const struct _ddebug_class_user *user)
-{
-	return ddebug_class_map_in_range(class_id - user->offset, user->map);
-}
-
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
@@ -1242,25 +1299,36 @@ static void ddebug_sync_classbits(const struct kernel_param *kp, const char *mod
 	}
 }
 
-static void ddebug_match_apply_kparam(const struct kernel_param *kp,
-				      const struct _ddebug_class_map *map,
-				      const char *mod_name)
+static struct _ddebug_class_param *
+ddebug_get_classmap_kparam(const struct kernel_param *kp,
+			   const struct _ddebug_class_map *map)
 {
 	struct _ddebug_class_param *dcp;
 
 	if (kp->ops != &param_ops_dyndbg_classes)
-		return;
+		return NULL;
 
 	dcp = (struct _ddebug_class_param *)kp->arg;
 
-	if (map == dcp->map) {
+	return (map == dcp->map)
+		? dcp : (struct _ddebug_class_param *)NULL;
+}
+
+static void ddebug_match_apply_kparam(const struct kernel_param *kp,
+				      struct _ddebug_class_map *map,
+				      const char *mod_name)
+{
+	struct _ddebug_class_param *dcp = ddebug_get_classmap_kparam(kp, map);
+
+	if (dcp) {
+		map->controlling_param = dcp;
 		v2pr_info(" kp:%s.%s =0x%lx", mod_name, kp->name, *dcp->bits);
 		vpr_cm_info(map, " %s maps ", mod_name);
 		ddebug_sync_classbits(kp, mod_name);
 	}
 }
 
-static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *mod_name)
+static void ddebug_apply_params(struct _ddebug_class_map *cm, const char *mod_name)
 {
 	const struct kernel_param *kp;
 #if IS_ENABLED(CONFIG_MODULES)
@@ -1280,6 +1348,13 @@ static void ddebug_apply_params(const struct _ddebug_class_map *cm, const char *
 	}
 }
 
+/*
+ * called from add_module, ie early. it can find controlling kparams,
+ * which can/does? enable protection of this classmap from class-less
+ * queries, on the grounds that the user created the kparam, means to
+ * use it, and expects it to reflect reality.  We should oblige him,
+ * and protect those classmaps from classless "-p" changes.
+ */
 static void ddebug_apply_class_maps(const struct _ddebug_info *di)
 {
 	struct _ddebug_class_map *cm;
-- 
2.53.0

