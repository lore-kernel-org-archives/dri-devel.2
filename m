Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA1AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2DA10EF9B;
	Wed,  8 Jul 2026 02:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bin+eUsv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBE410EF9B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:30:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4D1060008;
 Wed,  8 Jul 2026 02:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B36C1F00A3A;
 Wed,  8 Jul 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783477812;
 bh=/Y9bXGOGds2SV23NBgSA4BmvMOo9SAYk4oMrGXOeh9g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bin+eUsvALL4F89ejgLExP2IXqLqrG64yhOOC1z4qD1fa/H7xBLlBdSogeP43COgD
 4P167Zbgf41tgtGaYA7OdhF/ao1K16flc+wJtVqKZ5Xh5eao/TF+NhiBIlh6OGurs5
 mGfE7OGP/TfRVFSBigmz0t2frRUAquSe993LmwDkal5KEqs0TFd2aGh1BJjiJtSsE4
 wVXg/aS+vBB6mU6PSWy2LVuBfbk4UnXeyiFJIaEQFWUbFAHFxrJ9kiu1oBzpjxd1Jz
 46SONfw9CfjcCYcJJ9o9u9wBwDub9j7w5Cjd9cbvpgh3q7a8i5P6pBzw+uOg0WhdOA
 Uuv6xkEv4tmiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/24] dyndbg,module: make proper substructs in
 _ddebug_info
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260707-dd-maint-2-v6-20-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-20-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:30:11 +0000
Message-Id: <20260708023012.3B36C1F00A3A@smtp.kernel.org>
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
- [Medium] Built-in modules without class maps erroneously inherit all glob=
al class maps
- [Low] Build failure in DRM subsystem due to struct name typo
--

--- Patch [20]: [PATCH v6 20/24] dyndbg,module: make proper substructs in _=
ddebug_info ---
commit 715ff68bbb0cbb69dec753531f42001f8daeef9e
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg,module: make proper substructs in _ddebug_info

recompose struct _ddebug_info, inserting proper sub-structs.

The struct _ddebug_info has 2 pairs of _vec, num_##_vec fields, for
descs and classes respectively.  for_subvec() makes walking these
vectors less cumbersome, now lets move those field pairs into their
own "vec" structs: _ddebug_descs & _ddebug_class_maps, and re-compose
struct _ddebug_info to contain them cleanly.  This also lets us get
rid of for_subvec()'s num_##_vec paste-up.

> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 711ae6606c6ea..da2171186c6bf 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -69,7 +69,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYP=
E_DISJOINT_BITS, 0,
>  			"DRM_UT_DP",
>  			"DRM_UT_DRMRES");
> =20
> -static struct ddebug_class_param drm_debug_bitmap =3D {
> +static struct _ddebug_class_param drm_debug_bitmap =3D {

[Severity: Low]
Will this cause a build failure?=20

The struct defined in include/linux/dynamic_debug.h is named=20
ddebug_class_param, without the leading underscore.

[ ... ]

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index af05f4ae3b55e..5a884cbd6294a 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1184,12 +1185,12 @@ static void ddebug_attach_module_classes(struct d=
debug_table *dt, struct _ddebug
>  	 * the builtin/modular classmap vector/section.  Save the start
>  	 * and length of the subrange at its edges.
>  	 */
> -	for_subvec(i, cm, di, classes) {
> +	for_subvec(i, cm, di, maps) {

[ ... ]

>  	if (nc) {
> -		dt->num_classes =3D nc;
> +		dt->info.maps.len =3D nc;
>  		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
>  	}
>  }
> @@ -1211,10 +1212,10 @@ static int ddebug_add_module(struct _ddebug_info =
*di, const char *modname)

[ ... ]

>  	dt->mod_name =3D modname;
> -	dt->ddebugs =3D di->descs;
> -	dt->num_ddebugs =3D di->num_descs;
> +	dt->info =3D *di;
> =20
>  	INIT_LIST_HEAD(&dt->link);
> =20
> -	if (di->classes && di->num_classes)
> +	if (di->maps.len)
>  		ddebug_attach_module_classes(dt, di);

[Severity: Medium]
If a built-in module has no class maps, does it unintentionally inherit=20
the global list of class maps here?
       =20
When dt->info is assigned *di, it copies the global maps array, including=20
the global di->maps.len.=20

If the module has no class maps, ddebug_attach_module_classes() will run,=20
but nc remains 0. Since dt->info.maps.len is only updated when nc > 0:

	if (nc) {
		dt->info.maps.len =3D nc;
		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
	}

It won't be cleared to 0, leaving the module with the full global list of=20
class maps. Should dt->info.maps.len be explicitly cleared when no module
classes are found?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D20
