Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A503C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679EA10EB76;
	Tue, 21 Jul 2026 21:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="in+oPhEO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF84810EB76
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:18:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A011437B4;
 Tue, 21 Jul 2026 21:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBE1F000E9;
 Tue, 21 Jul 2026 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784668694;
 bh=mXQKFfeBIvyQMbFSB56/rrzSiZVK3LbSSb9i7/0lvYE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=in+oPhEOlrQ6pGPM6u3uG4oq4AxZMaRbZevr1JgcbefOrOMELy937j6YxJGMnWm8A
 DVEzs4HMnwZDyjc6odH04ovCQUJgOhHoGKgVxkYfST1fTKOTz2i/C8Ahkb6BoNEoSt
 qGsQG4GG3L/Uj0N8DzIh4rBJltCsmxH57c0z26rRyJdNdiKN5QL4wJycv5ebw8P0YO
 HJS23lkonRYfoWVfTwqp2Ei9TxgQCbO9qqJrbg5LRy8C7BGgiEA4orTz6ZEoBAfUDf
 JsQ9a6tH9b4Ky1PY6l0JaId7mriVHcxr0FX+Yqaf3AEE5ERXCn2ku01GHtrikmSrKC
 hFRgu9XHLIqpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/29] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-28-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-28-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:18:13 +0000
Message-Id: <20260721211814.01EBE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] ddebug_sync_classbits unconditionally treats LEVEL_NUM parameters =
as bitmasks, corrupting stored verbosity levels and incorrectly configuring=
 callsites.
- [High] Incorrect arithmetic for used classmaps with offsets completely br=
eaks class control and leads to out-of-bounds array reads.
- [High] Module classmap initialization silently fails because configuratio=
n queries are executed before the module is published to the global trackin=
g list.
- [Medium] ddebug_match_apply_kparam fails to verify that the kernel parame=
ter's class map matches the target map, applying all loaded dyndbg paramete=
rs indiscriminately.
- [Medium] Unprotected read-modify-write on shared classmap bits causes a d=
ata race during concurrent module loads or sysfs writes.
--

--- Patch [28]: [PATCH v7 28/29] dyndbg-API: replace DECLARE_DYNDBG_CLASSMA=
P ---
commit bd4f2adcad3c31e1b42bccb83f503513dbc0eb2e
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This patch replaces DECLARE_DYNDBG_CLASSMAP with two new macros:
DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE. It splits the
classmap declarations into definitions (exported by core) and uses (from
drivers) to solve initialization ordering issues and avoid duplicate classm=
ap
allocations.

> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -160,20 +163,39 @@ static void v3pr_info_dq(const struct ddebug_query =
*query, const char *msg)
[ ... ]
>  static struct ddebug_class_map *ddebug_find_valid_class(struct _ddebug_i=
nfo const *di,
>  							 const char *query_class,
>  							 int *class_id)
>  {
[ ... ]
> +	for_subvec(i, cli, di, users) {
> +		idx =3D match_string(cli->map->class_names, cli->map->length, query_cl=
ass);
> +		if (idx >=3D 0) {
> +			v2pr_di_info(di, "class-ref: %s -> %s.%s ",
> +				    cli->mod_name, cli->map->mod_name, query_class);
> +			*class_id =3D idx + cli->map->base - cli->offset;

[Severity: High]
Should this subtract the offset? When a module uses a classmap with a non-z=
ero
offset, subtracting it here instead of adding it appears to yield the wrong
class ID, breaking sysfs control ID mapping.

> +			return cli->map;
> +		}
> +	}
> +	*class_id =3D -ENOENT;
> +	return NULL;
>  }
[ ... ]
> @@ -1090,12 +1113,17 @@ static bool ddebug_class_in_range(const int class=
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
Does this compute a negative array index? If an unrelated callsite falls in
the unadjusted range checked by ddebug_class_in_range(), subtracting both
base and offset from dp->class_id could result in a negative index. This
could lead to an out-of-bounds read on cli->map->class_names.

> +
>  	return NULL;
>  }
[ ... ]
> @@ -1176,6 +1204,87 @@ static const struct proc_ops proc_fops =3D {
[ ... ]
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +
> +	/* clamp initial bitvec, mask off hi-bits */
> +	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
> +		*dcp->bits &=3D CLASSMAP_BITMASK(dcp->map->length);

[Severity: High]
Does this logic corrupt LEVEL_NUM classmaps? By unconditionally treating the
union field *dcp->bits as a bitmask, this overwrites the integer level stor=
ed
in *dcp->lvl for DD_CLASS_TYPE_LEVEL_NUM. Treating an integer level as a
bitmask seems to incorrectly enable disjoint classes and corrupt the stored
verbosity level.

[Severity: Medium]
Could this unprotected read-modify-write on *dcp->bits cause a data race?
Since this can execute during concurrent module loads or sysfs writes witho=
ut
ddebug_lock, it looks like concurrent updates to the shared parent classmap
bitmask could be lost.

> +		v2pr_info("preset classbits: %x\n", *dcp->bits);
> +	}
> +	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) clas=
s-param */
> +	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
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
> +		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
> +		vpr_cm_info(map, " %s maps ", mod_name);
> +		ddebug_sync_classbits(kp, mod_name);

[Severity: Medium]
Is a check comparing dcp->map to map missing here? Because this verifies
kp->ops but omits verifying that the kernel parameter's class map matches t=
he
target map, it seems all dyndbg parameters of the defining module will be
applied to every classmap indiscriminately.

> +	}
> +}
[ ... ]
> @@ -1213,6 +1322,7 @@ static int ddebug_add_module(struct _ddebug_info *d=
i)
[ ... ]
> +	if (dt->info.maps.len)
> +		ddebug_apply_class_maps(&dt->info);
> +	if (dt->info.users.len)
> +		ddebug_apply_class_users(&dt->info);
> =20
>  	mutex_lock(&ddebug_lock);
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);

[Severity: High]
Will module classmap initialization fail here? The initialization functions
ddebug_apply_class_maps() and ddebug_apply_class_users() execute queries
against the global ddebug_tables list. Since list_add_tail() is called
after these functions return, it appears ddebug_change() will fail to find
the newly loaded module, silently dropping the initial configuration.

> =20
> -	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name=
);
> +	vpr_info("%3u debug prints in module %s\n",
> +		 dt->info.descs.len, dt->info.mod_name);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D28
