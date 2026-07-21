Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA73C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 21:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F49D10EB6A;
	Tue, 21 Jul 2026 21:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ClNMTze0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C309010EB6A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 21:11:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A715E42AE9;
 Tue, 21 Jul 2026 21:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF051F00A3A;
 Tue, 21 Jul 2026 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784668304;
 bh=0ScPYnj5IbReOtaBBVv19khK4LHuX+DAL4QUToVNaHc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ClNMTze0kvnbNqESR93ledbA0gLqb3fQuVclocihIPp8VerF1ZrYxb38SH0v3y9wH
 puTyYo76xm2ki7eBLpRqlBZuVCh0av/9S6FOmklI8We3XaKF85j7X044+TGyZBvvo/
 YEy4NesTtdS/L9zejDRmFdtjxa3oM5s3QQXgQFhvK0xoQhJEMhMcRxAjetDyVd/qMN
 balJLqSQub/6/vHDlm16c3qRVkTm9Rq+uyArbiWCEO2uc94a6KOAdJyVR8vGAtiycl
 IvtfQJBZwHRggHUDX/f+nWxcEeYp7HCYK3K8ECJi+ebYzQh63i3mup0o6A6eROvxde
 m4LRIP/cQfKoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classes and
 below
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260721-dd-maint-2-v7-20-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
 <20260721-dd-maint-2-v7-20-010fbe73b311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 21:11:43 +0000
Message-Id: <20260721211144.5FF051F00A3A@smtp.kernel.org>
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
- [Medium] The refactored `param_set_dyndbg_module_classes` is structurally=
 incapable of correctly applying existing global classmap settings to newly=
 loaded modules, and it corrupts the global state.
--

--- Patch [20]: [PATCH v7 20/29] dyndbg: refactor param_set_dyndbg_classes =
and below ---
commit fd7e6888285afde6b911cef67e7e2452e7180dba
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: refactor param_set_dyndbg_classes and below

This commit refactors the param_set_dyndbg_classes callchain to support
module-specific classmap updates, primarily intended for modprobe handling.
It splits the function into upper and lower parts, threading a modname
parameter through to ddebug_exec_queries. It also adds a check in
ddebug_apply_class_bitmap to skip printing if bits haven't changed.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index f66e5373e61e2..a619cefd801f7 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct dde=
bug_class_param *dcp,
>  	int matches =3D 0;
>  	int bi, ct;
> =20
> -	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
> +	if (*new_bits !=3D *old_bits)
> +		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
> +			  *old_bits, query_modname ?: "'*'");
> =20
>  	for (bi =3D 0; bi < map->length; bi++) {
>  		if (test_bit(bi, new_bits) =3D=3D test_bit(bi, old_bits))
>  			continue;

[Severity: Medium]
When applying the current global state to a newly probed module, will this
continue statement incorrectly skip all configuration queries?

Since old_bits represents the global state, test_bit() will evaluate to true
when applying the same global configuration to a new module, silently
skipping required query updates.

>  		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
>  			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
> =20
[ ... ]
> @@ -683,8 +693,8 @@ int param_set_dyndbg_classes(const char *instr, const=
 struct kernel_param *kp)
>  				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
>  			inrep &=3D CLASSMAP_BITMASK(map->length);
>  		}
> -		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> -		totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
> +		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
> +		totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
>  		*dcp->bits =3D inrep;

[Severity: Medium]
Does this code inadvertently corrupt the global state if a module-specific
override is applied?

It appears that *dcp->bits (the global parameter state) is unconditionally
overwritten with inrep, even when a mod_name is provided.

Should the state update be conditional on mod_name being NULL, to prevent
modprobe handling from modifying the global state?

>  		break;
>  	case DD_CLASS_TYPE_LEVEL_NUM:
> @@ -697,7 +707,7 @@ int param_set_dyndbg_classes(const char *instr, const=
 struct kernel_param *kp)
>  		old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
>  		new_bits =3D CLASSMAP_BITMASK(inrep);
>  		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
> -		totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
> +		totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_na=
me);
>  		*dcp->lvl =3D inrep;

[Severity: Medium]
Similarly, is the global *dcp->lvl state unconditionally overwritten here
when a module-specific override is applied for LEVEL_NUM map types?

>  		break;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dd-maint-2=
-v7-0-010fbe73b311@gmail.com?part=3D20
