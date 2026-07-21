Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0981C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D48010E3C5;
	Tue, 21 Jul 2026 21:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LiAcVsfQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5036410E3C5
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:13:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94B0D600FC;
 Tue, 21 Jul 2026 21:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172D21F00A3A;
 Tue, 21 Jul 2026 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784668381;
 bh=0aHuKPzw5r+UQJ2O1NSpcCR0rev6JAbn2QH3XshSR5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LiAcVsfQ0TfJcNRXqVwyzLCKDma35ziHbvA8E3ROKXU973plo8iPCkNMDtnbZmDN6
 GCKi4ClKwUcWfPZEX8zFrEFpJNoguYQ4WcV9kqCSXu+XMQX+1q7VuKa6d6JNljg1pI
 Dr/62roLVXl1eNsrdFjgehyA8+oJn9G28jLX3Q5guSrq2NbgsANUFda2HT4NyZrGyh
 bIrTTKJhhDWt+vIQCKqebWY95SpAmAZKj8uO0emXDubMJadd4g7LhcAV0AVIGGMOJp
 pTYC5Wk0XI4yJdgawTjJ0ufCtTDvAO9x2i7XG+OmDCSL1UoEIEVgLub218o6Pn7h4z
 pBVRsT9h31qeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/29] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-26-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-26-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:13:00 +0000
Message-Id: <20260721211301.172D21F00A3A@smtp.kernel.org>
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
- [Medium] When processing a built-in module that has no class maps, `ddebu=
g_attach_module_classes()` fails to reset `dt->info.maps.len` to 0, causing=
 the module to erroneously inherit the global array of all built-in class m=
aps.
--

--- Patch [26]: [PATCH v7 26/29] dyndbg: move mod_name down from struct dde=
bug_table to _ddebug_info ---
commit bd18115a5b87d80ee2f5c15c166c46a301cbd184
Author: Jim Cromie <jim.cromie@gmail.com>

    dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
   =20
    struct _ddebug_info already has most of dyndbg's info for a module;
    push debug_table.mod_name down into it, finishing the encapsulation.

This commit moves the module name from struct ddebug_table into
struct _ddebug_info. This encapsulates the module information, allowing
several callchains to pass _ddebug_info directly rather than the full table.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e7742fcca50ba..905277fa495b4 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1187,7 +1187,7 @@ static void ddebug_attach_module_classes(struct dde=
bug_table *dt, struct _ddebug
>  	 * and length of the subrange at its edges.
>  	 */
>  	for_subvec(i, cm, di, maps) {
> -		if (!strcmp(cm->mod_name, dt->mod_name)) {
> +		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
>  			if (!nc) {
>  				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d=
\n",
>  					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
> @@ -1201,7 +1201,7 @@ static void ddebug_attach_module_classes(struct dde=
bug_table *dt, struct _ddebug
>  	}
>  	if (nc) {
>  		dt->info.maps.len =3D nc;
> -		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> +		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
>  	}
>  }

[Severity: Medium]
When processing a built-in module that has no class maps, does
ddebug_attach_module_classes() fail to reset dt->info.maps.len to 0?

During boot, dynamic_debug_init() creates a stack variable di where maps.st=
art
and maps.len cover the entire __dyndbg_class_maps section. For each built-in
module, ddebug_add_module(&di) is called. It performs a shallow copy
dt->info =3D *di, assigning the full length.

It then calls ddebug_attach_module_classes(). If the module has no class ma=
ps,
the loop finds no matches (nc =3D=3D 0), skipping the if (nc) block:

	if (nc) {
		dt->info.maps.len =3D nc;
		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
	}

Because of this, does dt->info.maps.len improperly retain the length of all
built-in class maps, causing the module to erroneously inherit the global a=
rray
of all built-in class maps?

This logic error could allow users to apply unrelated class strings to a
module's debug prints via the control interface, leading to incorrect funct=
ional
behavior of the dynamic debug API.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D26
