Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094EDC79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F93410E0FD;
	Wed,  9 Sep 2026 01:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GNg/7bXw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DE010E0FD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:17:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F4A040319;
 Wed,  9 Sep 2026 01:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC081F00A3A;
 Wed,  9 Sep 2026 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916641;
 bh=0xXKFyA5MyNJRjVNbpbkZHcpK2+w394cJQ5/L9Gbt6w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GNg/7bXwCgB38z6LGRTLZh0SwUsqSP276hDetEO4RtsWYzHGpg3+aRllYsIgLHhNz
 pcSkDO6f2Z7E4Wiet9DoH2M9BDfr8Pp8D0vQfcJTeiRIpE68k/cgcpA64UTv5ba5w5
 8/4fptv8FoqHRGySXsGw6P7/nPxQktwPjTMViyoC9ocxGcSnxpfSfiwIJ9jnzzvLbz
 IM2OPzbkEvvONbHPj0K7f/S70H0S1bz97hnxu1arg2tGHhbeth50ItA0gQUhvw4vKc
 uA/RzOtxtMuX2uNlmsQPFJTLoIMQE8CnO9FlUVVpG5fxcHF3CgbAJsIfpiEZG4FISH
 F7m4vG2niG8qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 33/39] dyndbg: resolve "protection" of class'd pr_debug
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-33-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-33-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:17:21 +0000
Message-Id: <20260909011721.BBC081F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The function `ddebug_apply_class_maps` is enclosed in an `#if 0` b=
lock, preventing `controlling_param` from being initialized for defining mo=
dules. This breaks the protection mechanism for parameterized classmaps and=
 fails to apply boot/load-time kernel parameters to the defining module's c=
allsites.
- [Medium] The module is exposed to userspace queries via `ddebug_tables` b=
efore its `map->controlling_param` protection state is initialized, creatin=
g a data race and TOCTOU vulnerability where concurrent classless queries c=
an bypass protection.
--

commit 3a846cbf484a221d77612af005e27faf83c306df
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: resolve "protection" of class'd pr_debug

This commit adds protection for dynamically debugged classes against
class-less queries by using sysfs parameters. It sets a controlling
parameter for parameterized classmaps to prevent accidental modification
from queries that lack a specific class identifier.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e6f5a524d63b6..8c90b1e4cd33e 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1297,25 +1358,35 @@ static void ddebug_sync_classbits(const struct ke=
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
> +		map->controlling_param =3D dcp;

[Severity: Medium]
Could this lockless write to map->controlling_param cause a data race?

When a module is loaded, ddebug_add_module() adds the module to the
ddebug_tables list under the ddebug_lock:

mutex_lock(&ddebug_lock);
list_add_tail(&dt->link, &ddebug_tables);
mutex_unlock(&ddebug_lock);

It then drops the lock and calls ddebug_apply_class_users(), which reaches
this code and locklessly writes to map->controlling_param.

Since the module is already visible in ddebug_tables before this
initialization completes, could a concurrent classless sysfs query bypass
protection by evaluating ddebug_class_wants_protection() on a newly added
module before controlling_param is set?

> +		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
> +		vpr_cm_info(map, " %s maps ", mod_name);
> +		ddebug_sync_classbits(kp, mod_name);
>  	}
>  }

[ ... ]

> @@ -1338,6 +1409,26 @@ static void ddebug_apply_params(const struct ddebu=
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

[Severity: High]
Does this disabled code block break the intended protection for parameteriz=
ed
classmaps defined within the module?

Because ddebug_apply_class_maps() is enclosed in an #if 0 block, the
controlling_param is never initialized for the module defining the classmap.
As a result, ddebug_class_wants_protection() will evaluate to false because
site_map->controlling_param is NULL.

Will this cause boot and load-time kernel parameters (like drm.debug=3DVAL)
to not be applied to the defining module's callsites, allowing class-less
queries to improperly modify them?

> +
>  static void ddebug_apply_class_users(const struct _ddebug_info *di)
>  {
>  	struct ddebug_class_user *cli;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D33
