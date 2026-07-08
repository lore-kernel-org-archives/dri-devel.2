Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A670AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F226F10EFAF;
	Wed,  8 Jul 2026 02:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fxJkV46j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA5C10EFA6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2646643449;
 Wed,  8 Jul 2026 02:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFE51F000E9;
 Wed,  8 Jul 2026 02:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783478178;
 bh=Q4nZO6LkStnu6nuAlAsPAdpKbB1V7GfqWqiS784BE7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fxJkV46jTxvf421g8yIpKWQPgBIJwFdx7uZ2VJB7HLo4S1mIQ8/ovV5jelMoGKtjq
 5H68zhYjdVmpjCKptMTwJstjRtZlt9D0RBeL4ieAkFCcK6HtPJg7nn2LbQjMO6hAoz
 r5MVZrd88RtybNN2esACW/YSrg5VwrR/ewf7wvTorhGM/a392VqTSyNw15hD1H/793
 3fLTaqMvr5zYsqIRRxzXZBDp8pEMN5bQ8cRjv/3ztRlVW1G8Vt2vUoUUIn6f6R1hlT
 KkrSz1HyyoCfJQR2fJ7WwHKp8aDHmdSOCZDvEWwATpW8XjXIRoPAHKPUw67hBl231x
 uv7MtPjOaZWpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/24] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-dd-maint-2-v6-24-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-24-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:36:17 +0000
Message-Id: <20260708023617.CEFE51F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] ddebug_match_apply_kparam() applies all dyndbg kernel parameters f=
rom the defining module indiscriminately instead of filtering for the speci=
fic classmap being matched.
- [High] ddebug_sync_classbits() corrupts LEVEL_NUM classmaps by unconditio=
nally treating the numerical verbosity level as a bitmask.
- [High] Incorrect offset math in ddebug_find_valid_class() prevents dynami=
c debug control of offset classmaps.
- [High] Out-of-bounds array read in ddebug_class_name() due to an incorrec=
t range check.
- [High] Initialization queries silently fail because the module is not yet=
 added to the global ddebug_tables list.
- [High] Unprotected read-modify-write on a shared kernel parameter in ddeb=
ug_sync_classbits().
- [Medium] TOCTOU race due to lockless access of shared parameter pointer i=
n ddebug_apply_class_bitmap().
--

--- Patch [24]: [PATCH v6 24/24] dyndbg-API: replace DECLARE_DYNDBG_CLASSMA=
P ---
commit 25c55a40c5e12d9e90d3e7947e7b90b45af6e5f9
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit deprecates DECLARE_DYNDBG_CLASSMAP and replaces it with
DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE. It separates
classmap definitions from their usage across dependent modules like DRM
drivers. This separation allows dynamic debug to initialize driver callsites
independently after each is loaded.

> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -160,20 +163,39 @@ static void v3pr_info_dq(const struct ddebug_query =
*query, const char *msg)
[ ... ]
>  static struct ddebug_class_map *ddebug_find_valid_class(struct _ddebug_i=
nfo const *di,
>  							 const char *query_class,
>  							 int *class_id)
>  {
>  	struct ddebug_class_map *map;
> +	struct ddebug_class_user *cli;
>  	int i, idx;
> =20
> -	for_subvec(i, map, &dt->info, maps) {
> -		idx =3D match_string(map->class_names, map->length, class_string);
> +	for_subvec(i, map, di, maps) {
> +		idx =3D match_string(map->class_names, map->length, query_class);
>  		if (idx >=3D 0) {
> +			v2pr_di_info(di, "good-class: %s.%s ", map->mod_name, query_class);
>  			*class_id =3D idx + map->base;
>  			return map;
>  		}
>  	}
> +	for_subvec(i, cli, di, users) {
> +		idx =3D match_string(cli->map->class_names, cli->map->length, query_cl=
ass);
> +		if (idx >=3D 0) {
> +			v2pr_di_info(di, "class-ref: %s -> %s.%s ",
> +				    cli->mod_name, cli->map->mod_name, query_class);
> +			*class_id =3D idx + cli->map->base - cli->offset;

[Severity: High]
Does this math prevent matching against the actual callsites in the target
module?

When a user writes to the debugfs control file, the lookup must incorporate
the offset mathematically. Subtracting the offset instead of adding it yiel=
ds
a mismatched or negative class ID.

This will prevent finding the callsites in the user module.

> +			return cli->map;
> +		}
> +	}
>  	*class_id =3D -ENOENT;
>  	return NULL;
>  }
[ ... ]
> @@ -1089,12 +1112,17 @@ static bool ddebug_class_in_range(const int class=
_id, const struct ddebug_class_
>  static const char *ddebug_class_name(struct _ddebug_info *di, struct _dd=
ebug *dp)
>  {
>  	struct ddebug_class_map *map;
> +	struct ddebug_class_user *cli;
>  	int i;
> =20
>  	for_subvec(i, map, di, maps)
>  		if (ddebug_class_in_range(dp->class_id, map))
>  			return map->class_names[dp->class_id - map->base];
> =20
> +	for_subvec(i, cli, di, users)
> +		if (ddebug_class_in_range(dp->class_id, cli->map))
> +			return cli->map->class_names[dp->class_id - cli->map->base - cli->off=
set];

[Severity: High]
Could this result in an out-of-bounds array read with a negative index?

If a descriptor's actual class ID falls within the original map's un-offset
range from a different use declaration, the ddebug_class_in_range() check
might pass because it ignores the offset.

The subsequent array access subtracts the offset, which can result in a
strictly negative array index and an out-of-bounds read when reading from
the debugfs control file.

> +
>  	return NULL;
>  }
[ ... ]
> @@ -1175,6 +1203,87 @@ static const struct proc_ops proc_fops =3D {
>  	.proc_write =3D ddebug_proc_write
>  };
> =20
> +#define vpr_cm_info(cm_p, msg_fmt, ...) ({				\
> +	struct ddebug_class_map const *_cm =3D cm_p;			\
> +	v2pr_info(msg_fmt "%s [%d..%d] %s..%s\n", ##__VA_ARGS__,	\
> +		  _cm->mod_name, _cm->base, _cm->base + _cm->length,	\
> +		  _cm->class_names[0], _cm->class_names[_cm->length - 1]); \
> +	})
> +
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +
> +	/* clamp initial bitvec, mask off hi-bits */
> +	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
> +		*dcp->bits &=3D CLASSMAP_BITMASK(dcp->map->length);

[Severity: High]
Does this unconditionally operate on the union as a bitmask, without checki=
ng
the map type?

When processing a DD_CLASS_TYPE_LEVEL_NUM classmap, *dcp->bits aliases
*dcp->lvl. Performing a bitwise AND with CLASSMAP_BITMASK incorrectly clamps
the numerical level to a bitmask value, which breaks verbosity level
initialization.

[Severity: High]
Is this unprotected read-modify-write on a shared kernel parameter safe
during concurrent module loads?

When multiple dependent modules load simultaneously, they can concurrently
enter ddebug_sync_classbits() and perform an unprotected bitwise AND on the
shared provider parameter. This can corrupt the state if the parameter is
actively being modified.

> +		v2pr_info("preset classbits: %x\n", *dcp->bits);
> +	}
> +	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) clas=
s-param */
> +	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);

[Severity: Medium]
Is there a race condition when dcp->bits is passed here and accessed
locklessly?

ddebug_apply_class_bitmap() iterates over the classmap length and repeatedly
dereferences this pointer locklessly. Because the loop contains external
function calls, the compiler must reload it. Concurrent sysfs writes could
cause the loop to fetch different states on different iterations, leaving
the debug state inconsistent.

> +	ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
> +}
> +
> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +				      const struct ddebug_class_map *map,
> +				      const char *mod_name)
> +{
> +	struct ddebug_class_param *dcp;
> +
> +	if (kp->ops !=3D &param_ops_dyndbg_classes)
> +		return;
> +
> +	dcp =3D (struct ddebug_class_param *)kp->arg;
> +
> +	if (dcp) {

[Severity: High]
Does this apply all dyndbg kernel parameters from the defining module
indiscriminately?

When a user module references a classmap, the parameters are iterated over.
Because there is no filter checking if dcp->map matches map before applying
the state, it applies the state of all dyndbg parameters defined by the
provider module.

If class names overlap between an unused classmap and the user module's own
classmaps, the user module's debug state could be incorrectly altered.

> +		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
> +		vpr_cm_info(map, " %s maps ", mod_name);
> +		ddebug_sync_classbits(kp, mod_name);
> +	}
> +}
[ ... ]
> @@ -1240,12 +1351,19 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	 */
>  	dt->info =3D *di;
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
> +	dd_set_module_subrange(i, cli, &dt->info, users);
> +
> +	if (dt->info.maps.len)
> +		ddebug_apply_class_maps(&dt->info);
> +	if (dt->info.users.len)
> +		ddebug_apply_class_users(&dt->info);

[Severity: High]
Are initialization queries silently failing here because the module is not =
yet
added to the global list?

ddebug_apply_class_maps() and ddebug_apply_class_users() ultimately call
ddebug_change(), which searches the global ddebug_tables list. Because the
new module is added to ddebug_tables after these functions return,
ddebug_change() fails to find the newly loading module.

This results in zero matches, silently dropping the initial state and leavi=
ng
drivers that rely on provider kernel parameters uninitialized.

> =20
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D24
