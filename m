Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDFEC9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE52110E511;
	Wed, 23 Sep 2026 22:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nqUs6+T1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE1810E3E3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:45:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C207601FD;
 Wed, 23 Sep 2026 22:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9A1F000FF;
 Wed, 23 Sep 2026 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790203520;
 bh=66YxT9lUqMPF04vwLu1dX3k5F5ETApE8UO9Zqjgu5a0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nqUs6+T1WmLtdp96/dsWMnMqNyFrHn0Q/F+RShu4iZeBY4nVCtwvs629BZYf8H4ZW
 LPuu890oXG4unQzZkYDr2NwIX96e3EgtMfuLk2aDJo/yyFiBwjy/ELsDmuCYzPc9mB
 CLfxbyhnUpW837ldQ+8M601Nd40SlaDxwVCvxwHArEYnz7ZASfLvjuOrTU5o44Xsdf
 MRqo51mGt74Vu7qXTYj95uUmgVyoBmTtPIx9gnu29Z8zgc8yc9i+Sgv0NjogIlVHxH
 zUp7s6uRSp12Q7IMzB3HBlwoUyQW/HVkTEAf4PAX5w+G5heG1VxAXEiBgNf4A8u8Ou
 OWn8T8SC6Fk4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-24-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-24-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:45:19 +0000
Message-Id: <20260923224520.0FC9A1F000FF@smtp.kernel.org>
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
- [Medium] selftests: classmap inheritance hash check excludes submod
- [Low] selftests: undocumented uncommenting of grammar testcase
--

commit 7d522a72bd526c1e41ef1a1e604e466e1e729843
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Enable FT_classmap_inheritance
   =20
Exercise classmap state inheritance between supermod and submod,
verifying that class settings and controlling parameter states propagate
from parent classmap definitions to dependent class users upon module
load and during runtime reconfiguration.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index c279c795867b6..5a805cb30e6cd 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> @@ -189,7 +190,7 @@ function FT_grammar_ok {
> =20
>      # use 4 keywords (max 9 words inc flags)
>      ddcmd "module foo file bar.c func buz class D2_CORE +_"	# 4 keywords
> -    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 key=
words
> +    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keyw=
ords

[Severity: Low]
Was this undocumented uncommenting of a grammar testcase intentional?

It modifies the behavior of an existing, separate test in FT_grammar_ok wit=
hout
documenting it in the commit message.

[ ... ]
> @@ -291,6 +292,78 @@ function FT_basic_queries {
>      ddcmd "file $f =3D_" "$f"
>  }
> =20
> +function FT_classmap_inheritance {
[ ... ]
> +    # Real-time mathematical proof that load-time (modprobe) parameter p=
arsing
> +    # and runtime (sysfs write) parameter configurations are perfectly e=
quivalent!
> +    local hash_modprobe=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug\=
]')
> +
> +    # Fresh load with default parameters, then configure them dynamicall=
y at runtime
> +    ifrmmod test_dynamic_debug_submod
> +    ifrmmod test_dynamic_debug
> +    my_modprobe test_dynamic_debug
> +    my_modprobe test_dynamic_debug_submod
> +    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
> +    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
> +
> +    local hash_sysfs=3D$(slice_and_hash_ddctrl '\[test_dynamic_debug\]')

[Severity: Medium]
Does this classmap inheritance hash check exclude the submodule?

Because of the strict regex using escaped brackets, the grep strictly match=
es
the parent module's section and filters out all [test_dynamic_debug_submod]
lines.

Consequently, the hash equivalence check only proves the parent module resp=
onds
correctly, ignoring the dependent submodule whose inheritance is supposedly
being tested in FT_classmap_inheritance.

> +    if [ "$hash_modprobe" !=3D "$hash_sysfs" ]; then
> +        echo -e "${RED}: Load-time vs runtime parameter equivalence chec=
k failed!${NC}"
> +        exit $ksft_fail
> +    else
> +        v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
> +            "and runtime (sysfs write) are equivalent!${NC}"
> +    fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-pa=
rt2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D24
