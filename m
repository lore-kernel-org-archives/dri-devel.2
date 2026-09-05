Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F448C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE62F10E494;
	Sat,  5 Sep 2026 18:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IemEyPV2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6F10E494
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E13D40343;
 Sat,  5 Sep 2026 18:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541AC1F00A3D;
 Sat,  5 Sep 2026 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633194;
 bh=rqS2Nuv3cQJQWEgcR1m8EG3IpZx9dnPCRgFu6i1/i1I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IemEyPV2OlYjv3GLqjSkUz2kNpoEO0jAltpxIBNyaaI5bAYV8fXxUbk+dWnxIUc67
 bMoJhrTS2492pZj9hA5vbmLeokjDwL1UlqGsKmeRz+AdxGfSQ8xCo1UC3YlJoClPc/
 RYwLwvpuHftxTJ7f9983XovcHGkiTzKFmCYDKfow1ZbUwEtAwEm1ekmBtk/CEkJr3A
 2DeHlPKpGsHn1JQT3k/tTMBqJrbNfj6azPccHNl9j6DeH/ZfF54/lr+iFzQlWwjp1i
 60/CHzT4RTditHTEreGNogoU7ADk0F7CIdpyB6N4DnOOAKdjWKxwjFGVuA7SszQ5V4
 XGT5ERXSG7v+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 36/43] dyndbg: resolve "protection" of class'd pr_debug
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-36-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-36-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:33:13 +0000
Message-Id: <20260905183314.541AC1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'controlling_param' field in 'struct ddebug_class_map' is ne=
ver assigned and its initialization path is disabled, completely breaking t=
he intended protection mechanism for class'd pr_debugs.
--

commit 6f4d594fc681c54264d43b5caa68a2316a8b157d
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: resolve "protection" of class'd pr_debug

This commit aims to protect class'd pr_debugs from unintended changes by
unclassed legacy queries (like `echo -p > /proc/dynamic_debug/control`).
It introduces a link from `ddebug_class_map` to `controlling_param` and
intends to check it to decide whether to protect the class map.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 93a5a481c8b8c..a5d813ad323a1 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> +static inline bool ddebug_class_has_param(const struct ddebug_class_map =
*map)
> +{
> +	return !!(map->controlling_param);
> +}
> +
> +/* re-framed as a policy choice */
> +#define ddebug_class_wants_protection(map) (ddebug_class_has_param(map))
> +
>  /*
>   * Search the tables for _ddebug's which match the given `query' and
>   * apply the `flags' and `mask' to them.  Returns number of matching

[ ... ]

> @@ -256,7 +299,28 @@ static bool ddebug_match_desc(const struct ddebug_qu=
ery *query,
>  	    dp->lineno > query->last_lineno)
>  		return false;
> =20
> -	return true;
> +	/*
> +	 * above are all satisfied, so we can make final decisions:
> +	 * 1- class FOO or implied class __DEFAULT__
> +	 * 2- site.is_classed or not
> +	 */
> +	if (query->class_string) {
> +		/* class FOO given, exact match required */
> +		return (dp->class_id =3D=3D selected_class);
> +	}
> +	/* query class __DEFAULT__ by omission. */
> +	if (dp->class_id =3D=3D _DPRINTK_CLASS_DFLT) {
> +		/* un-classed site */
> +		return true;
> +	}
> +	/* site is class'd */
> +	site_map =3D ddebug_find_map_by_class_id(di, dp->class_id);
> +	if (!site_map) {
> +		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", d=
p->class_id, di->mod_name);
> +		return false;
> +	}
> +	/* module(-param) decides protection */
> +	return !ddebug_class_wants_protection(site_map);
>  }

[Severity: Medium]
Will `ddebug_class_wants_protection()` always evaluate to false?

Because `map->controlling_param` appears to never be initialized, it seems
this will always return false, which causes the function to return true
and bypass the intended protection for class'd pr_debugs against unclassed
legacy queries.

[ ... ]

> @@ -1298,16 +1359,25 @@ static void ddebug_sync_classbits(const struct ke=
rnel_param *kp, const char *mod
>  	}
>  }
> =20
> -static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> -				      const struct ddebug_class_map *map,
> -				      const char *mod_name)
> +static struct ddebug_class_param *
> +ddebug_get_classmap_kparam(const struct kernel_param *kp,
> +			   const struct ddebug_class_map *map)
>  {
>  	struct ddebug_class_param *dcp;
> =20
>  	if (kp->ops !=3D &param_ops_dyndbg_classes)
> -		return;
> +		return NULL;
> =20
>  	dcp =3D (struct ddebug_class_param *)kp->arg;
> +	return (map =3D=3D dcp->map)
> +		? dcp : (struct ddebug_class_param *)NULL;
> +}
> +
> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +				      struct ddebug_class_map *map,
> +				      const char *mod_name)
> +{
> +	struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp, map);
> =20
>  	if (dcp && dcp->map =3D=3D map) {
>  		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
>  		vpr_cm_info(map, " %s maps ", mod_name);
>  		ddebug_sync_classbits(kp, mod_name);
>  	}
>  }

[Severity: Medium]
Was the assignment `map->controlling_param =3D dcp;` intended to be added h=
ere?

The commit message states that the patch "sets it in
ddebug_match_apply_kparam()", but the assignment seems to be missing.
Adding the assignment locklessly could also introduce a data race here.

[ ... ]

> @@ -1339,6 +1409,26 @@ static void ddebug_apply_params(const struct ddebu=
g_class_map *cm, const char *m
>  	}
>  }
> =20
> +#if 0
> +/*
> + * called from add_module, ie early. it can find controlling kparams,
> + * which can/does? enable protection of this classmap from class-less
> + * queries, on the grounds that the user created the kparam, means to
> + * use it, and expects it to reflect reality.  We should oblige him,
> + * and protect those classmaps from classless "-p" changes.
> + */
> +static void ddebug_apply_class_maps(const struct _ddebug_info *di)
> +{
> +	struct ddebug_class_map *cm;
> +	int i;
> +
> +	for_subvec(i, cm, di, maps)
> +		ddebug_apply_params(cm, cm->mod_name);
> +
> +	v2pr_di_info(di, "attached %d class-maps to ", i);
> +}
> +#endif
> +
>  static void ddebug_apply_class_users(const struct _ddebug_info *di)
>  {

[Severity: Medium]
Does the `#if 0` block around `ddebug_apply_class_maps()` prevent
`ddebug_match_apply_kparam()` from ever being called for the defining modul=
e?

If this function is disabled, the parameter initialization appears unreacha=
ble
for the defining module's map, even if the assignment was added to
`ddebug_match_apply_kparam()`.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D36
