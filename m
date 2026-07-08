Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E37FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7C710EF96;
	Wed,  8 Jul 2026 02:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j9FCkhUU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD07010EF96
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:29:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45427403E9;
 Wed,  8 Jul 2026 02:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D9A1F000E9;
 Wed,  8 Jul 2026 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783477754;
 bh=k5FK9fj0tsq5G7Zi7kn0ng1piuUturOtAJQLbB1FYN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j9FCkhUUsFjQjoI3dwbX46vH1Trbv3df14HFowaXWEFtDiFLqFnrXvyVnU1cELoRf
 5HvlkPn3z5cK/Mk82wZaleU1cyyMCFDv8yQGmyFpNWP19QpiRGKu+K0TTOql8DclJF
 qwA5/uogDIVROONv1pLipC6NTcr498FxCuWDht8EzX3dtgBI5VT319flYeqfSDeIjU
 +Bo4MkjIhJMl/blHYofjkmJBukgxy6RT/jaeFhlwqFXIm/kXQdhCCCDu25Bdm552yt
 abveP6RGOIYuOS502iqB5XV2uZeWjcUI8Akc5OSIwZum2r6qj2FYRNusHifueqRdIS
 EghzN4ccbox6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/24] dyndbg: refactor param_set_dyndbg_classes and
 below
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-dd-maint-2-v6-15-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-15-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:29:13 +0000
Message-Id: <20260708022913.E3D9A1F000E9@smtp.kernel.org>
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
- [Medium] param_set_dyndbg_module_classes() fails to initialize debug quer=
ies for a newly probed module because it incorrectly uses the global class =
parameter state as the baseline (`old_bits`).
--

--- Patch [15]: [PATCH v6 15/24] dyndbg: refactor param_set_dyndbg_classes =
and below ---
commit 041ecc33e02248dbfd09801bededdf6047b80f6e
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: refactor param_set_dyndbg_classes and below

This commit refactors the param_set_dyndbg_classes callchain to allow
module-specific settings by passing a modname parameter down to
ddebug_apply_class_bitmap and ddebug_exec_queries. It also adds a check
to announce bit changes only when they actually change.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index ce42e03f1600a..0fc9cd14e2d20 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -682,8 +692,8 @@ int param_set_dyndbg_classes(const char *instr, const=
 struct kernel_param *kp)
>  				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
>  			inrep &=3D CLASSMAP_BITMASK(map->length);
>  		}
> -		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
> -		totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
> +		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
> +		totct +=3D ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
>  		*dcp->bits =3D inrep;
>  		break;
>  	case DD_CLASS_TYPE_LEVEL_NUM:
> @@ -696,7 +706,7 @@ int param_set_dyndbg_classes(const char *instr, const=
 struct kernel_param *kp)
>  		old_bits =3D CLASSMAP_BITMASK(*dcp->lvl);
>  		new_bits =3D CLASSMAP_BITMASK(inrep);
>  		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
> -		totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
> +		totct +=3D ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_na=
me);

[Severity: Medium]
Does this skip enabling debug queries for newly probed modules if the global
state already has those bits set?

When param_set_dyndbg_module_classes() is called for a newly probed module
(mod_name !=3D NULL), it passes the global class parameter state as the old
state (dcp->bits and old_bits respectively) instead of 0.

If a global parameter was previously set (e.g., drm.debug=3D2), those bits =
are
already present in the global state. The optimization loop in
ddebug_apply_class_bitmap() checks this:

lib/dynamic_debug.c:ddebug_apply_class_bitmap() {
    ...
    for (bi =3D 0; bi < map->length; bi++) {
        if (test_bit(bi, new_bits) =3D=3D test_bit(bi, old_bits))
            continue;
    ...
}

Because the new module's target state matches the global state, it skips
executing the queries, even though the newly loaded module actually starts
with a default state of 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D15
