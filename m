Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2F9C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14C810E48C;
	Wed, 16 Sep 2026 16:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fMdoiVCl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F3310E48C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:56:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9483411F1;
 Wed, 16 Sep 2026 16:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6148A1F000FF;
 Wed, 16 Sep 2026 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577780;
 bh=S3g6xYYlbmO2Ve8K8DLvb+2r9RmCjeNeWyDLqiGiLqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fMdoiVCl8H3+zC3SU/J5a4Ri5KRxy9M4GyXRJX1KQZMwCuZWwkdhRJHd4RjgefGW8
 I94PZF3Dl6dRN6y4j6M8/BfC5i6lvEpCHIskZqMD60hbHsw1iHKyP+rNust37Gg2U3
 fbPLEVrLcD2NsMLv+iMrEIGQq580RCMXLtDPvOeOx3X34mgCZrc0n3XjhkIfmK6j+Z
 h6Ln/o7KXyPmPEC6C7t1hF5LeRQbHNlkLz8kEYM/W5ASN9YcP27hpmRj/JBGyTgiIB
 hCs36J7S5eJmcyDLRrWneFjHmzOOicev2yhIf/8oA1NN4mOiJFezgJo3ynKHiYeq26
 Q0iL43mrEMosQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 32/38] dyndbg: resolve "protection" of class'd pr_debug
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-32-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-32-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:56:19 +0000
Message-Id: <20260916165620.6148A1F000FF@smtp.kernel.org>
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
- [High] dyndbg: module's own classmaps bypass protection due to missing co=
ntrolling_param init
- [Medium] dyndbg: data race on map->controlling_param due to lockless init=
ialization
--

commit 5ffc9f5551765ac7c4413f320b8e9d1977dbe99a
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: resolve "protection" of class'd pr_debug

This commit updates the protection mechanism for class'd pr_debug callsites
against unclassed queries. It introduces a requirement that a sysfs paramet=
er
(controlling_param) must be present for a classmap to be protected.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c023d07623f29..ac54a0499369c 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -257,7 +300,28 @@ static bool ddebug_match_desc(const struct ddebug_qu=
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

[Severity: High]
Does this code inadvertently bypass ABI protection for a module's own
class'd pr_debug sites?

Since the ddebug_apply_class_maps() block was removed in v10, it appears
ddebug_add_module() only initializes user maps (by calling
ddebug_apply_class_users() when dt->info.users.len > 0), and misses
initializing the defining module's own native classmaps.

Consequently, if a module defines a classmap and parameter but has no
loaded dependent modules, map->controlling_param remains NULL. This causes
ddebug_class_wants_protection() to default to false, allowing unclassed
legacy queries to incorrectly modify these protected sites.

>  }
> =20

[ ... ]

> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +				      struct ddebug_class_map *map,
> +				      const char *mod_name)
> +{
> +	struct ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp, map);
> =20
>  	if (dcp && dcp->map =3D=3D map) {
> +		map->controlling_param =3D dcp;

[Severity: Medium]
Can this assignment introduce a data race?

In ddebug_add_module(), the new debug table is published to the globally
visible ddebug_tables list under ddebug_lock, but the lock is released
before calling ddebug_apply_class_users().

Since ddebug_match_apply_kparam() is subsequently called without locks,
concurrent threads processing ddebug_change() could hold ddebug_lock
and read map->controlling_param while it is being updated here, leading
to a data race.

>  		v2pr_info(" kp:%s.%s =3D0x%x", mod_name, kp->name, *dcp->bits);
>  		vpr_cm_info(map, " %s maps ", mod_name);
>  		ddebug_sync_classbits(kp, mod_name);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D32
