Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F85C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A57310F22C;
	Wed, 23 Sep 2026 22:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AzM+XDE5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E009910F222
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:47:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3615760211;
 Wed, 23 Sep 2026 22:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDB11F000FF;
 Wed, 23 Sep 2026 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790203678;
 bh=aiefSjdeEoopnq//Y4ByOxpgvdN6hsTmkRuDe5tsSXU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AzM+XDE53mOxdg5n8+7T4rh6Hc/zzAFGyI+e7oorEALPmnjelZNQmc4B85VgOkjc3
 QpWitdfhB+tnrFZfw+IF9WYplX8IRB7CUqU8xMRRjvo46/mOrO3J9SYhJ5svR3pzG4
 PVRu7GOmZyeAzUTkkV/VAX+PNzVZgYUsoEVQIbDx1jt7Uuf/oCdX8AT19RM2jSXHCE
 +Ahy8ZYZrDW/K3XCCSiKaDmVegXIcDm4U2D130dpnOlo1KzrIoMOjWj0EJy1LwC+em
 a+rEIp8JHUHjWVtSb8vC8kXbywp5bbhba9Y3vrQ0VBaAoiXa4jywAWv6hiNiBv6Qu9
 lFtiLlQWij3aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/38] dyndbg: replace classmap list with an
 array-slice
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-17-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:47:58 +0000
Message-Id: <20260923224758.ABDB11F000FF@smtp.kernel.org>
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
- [Medium] dyndbg: interleaved classmaps are orphaned due to contiguous sli=
ce assumption
--

commit 8936e7007afda568cebc34aa496a40887ac6a5a1
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: replace classmap list with an array-slice

Classmaps are currently individually list-linked onto dyndbg's per-module
ddebug_table for operation. This commit replaces the list building operation
with an approach that treats packed classmaps as an array-start-address and
array-length, reusing the select-by-modname condition to find the bounds.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> -					 struct ddebug_class_map *classes,
> -					 int num_classes)
> +static void ddebug_attach_module_classes(struct ddebug_table *dt, struct=
 _ddebug_info *di)
>  {
>  	struct ddebug_class_map *cm;
> -	int i, j, ct =3D 0;
> +	int i, nc =3D 0;
> =20
> -	for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> +	/*
> +	 * Find this module's classmaps in a subrange/wholerange of
> +	 * the builtin/modular classmap vector/section.  Save the start
> +	 * and length of the subrange at its edges.
> +	 */
> +	for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++) {

[Severity: Medium]
Since the scan in ddebug_attach_module_classes() always restarts at index 0,
could this cause regressions if multiple descriptor tables exist for the
same interleaved module? When distinct compiled objects share the same
KBUILD_MODNAME, it seems they might all incorrectly bind to the first block
instead of finding their respective fragments.

> =20
>  		if (!strcmp(cm->mod_name, dt->mod_name)) {

[ ... ]

> +			if (!nc) {
> +				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d=
\n",
> +					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
> +				dt->classes =3D cm;
> +			}
> +			nc++;
> +		} else if (nc) {
> +			/* end of matching classmaps */
> +			break;
>  		}
>  	}

[Severity: Medium]
Does this premature break in ddebug_attach_module_classes() enforce an
assumption that classmaps are strictly contiguous?

If classmaps for a module are interleaved, breaking early means only the
first contiguous block is bound. Subsequent classmap fragments might be
permanently orphaned, leaving class'd pr_debug calls in those fragments
uncontrolled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D17
