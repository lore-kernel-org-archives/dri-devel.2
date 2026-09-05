Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87946C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B445910E378;
	Sat,  5 Sep 2026 18:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YhQngST0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5610310E378
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12C1941666;
 Sat,  5 Sep 2026 18:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB61F00A3A;
 Sat,  5 Sep 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632790;
 bh=BBedQDYvgjsWBln0fClCrY+xEoRNYLJ7I1yLjHvW8Pg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YhQngST06nMhJeEDTN/lw7GO1BbzW8Uxe7T7dk1WAjEqCGi6p205dJssNMbFKAgt3
 s1lJkvKr/7UL4Q5mUhEi6LULwdcvNqGGV5YVJuuSGysDZ7PTszoFLVj6Las9EnDq1v
 C4/ZLYmAXOSBUZJdDiBWxGC3v4qYRIRNXY2d7uJJW3V6tNWU/kwzTXGsz7KzuGwk/z
 nljpKxjQSnXnhDqKa9y2aiOXHcLzJ7VXOMGRHffw2uwGyeLnifuLP/wKsf3LFweJNj
 3/5fM9LaU/DqkfInAKNArb9gefQlOKRoE8ABSKiLp0FqYwMsnbggwSFvMP7Vj76oA1
 t56ebQrvLJTZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/43] kbuild, dyndbg: clean up builtin module-name
 ambiguities
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-18-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-18-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:26:29 +0000
Message-Id: <20260905182629.B2DB61F00A3A@smtp.kernel.org>
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
- [High] Unescaped spaces in module name break /proc/dynamic_debug/control =
space-delimited format
--

commit 545163420f0539e2fb3305855828cee4c4817daf
Author: Jim Cromie <jim.cromie@gmail.com>

kbuild, dyndbg: clean up builtin module-name ambiguities

This commit changes dynamic debug to derive the module name from
KBUILD_DD_MODNAME for built-in modules to resolve ambiguities. It applies a
clean heuristic to generate subsystem namespaces based on the directory path
and module target.

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 0a4fdd8bd975d..2d1544b30185f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -23,6 +23,15 @@ modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fix,=
$(modname)) \
>  		 -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
>  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> =20
> +# Dynamic debug subsystem modname with clean heuristic and Makefile over=
ride support
> +dd_modname_override =3D $(firstword $(DD_MODNAME_$(target-stem).o) $(DD_=
MODNAME))
> +dd_obj :=3D $(patsubst drivers/%,%,$(obj))
> +dd_modname_default =3D $(if $(filter $(notdir $(dd_obj)),$(__modname)),$=
(dd_obj),$(addprefix $(dd_obj)/,$(__modname)))
> +dd_modname =3D $(if $(dd_modname_override),$(dd_modname_override),$(dd_m=
odname_default))
> +dd_modname_flags =3D -DKBUILD_DD_MODNAME=3D$(call stringify,$(dd_modname=
))

[Severity: High]
Does this Makefile definition correctly handle spaces in $(__modname)?

When an object file is shared by multiple built-in modules, kbuild populates
$(__modname) with a space-separated list of module names (e.g., "mod1 mod2"=
).
The dd_modname_default definition above prepends the path, resulting in a
string with spaces like "dir/mod1 dir/mod2".

Because dd_modname_flags directly stringifies this into KBUILD_DD_MODNAME
without substituting the spaces with colons or other safe characters, this
string gets printed directly into the /proc/dynamic_debug/control file by
ddebug_proc_show():

lib/dynamic_debug.c:ddebug_proc_show() {
    ...
    seq_printf(m, "%s:%u [%s]%s =3D%s \"",
               trim_prefix(dp->filename), dp->lineno,
               iter->table->mod_name, dp->function,
               ddebug_describe_flags(dp->flags, &flags));
    ...
}

Will this unescaped space add an extra column and break the documented
space-delimited format of /proc/dynamic_debug/control, causing ABI breakage
for userspace parsing tools?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D18
