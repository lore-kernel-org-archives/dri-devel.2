Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B895C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDB910E2FD;
	Wed, 16 Sep 2026 16:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mvnePnaj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8C410E2FD
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:24:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C6AA43BC4;
 Wed, 16 Sep 2026 16:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6241F000FF;
 Wed, 16 Sep 2026 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789575867;
 bh=4SQlnidzW+1l/xiJhjGGyJPT2AkWd+OwVikR6YFgf60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mvnePnajS2kW8kE6SyqZiwiPWT8nmGc1YqZWv7Pezdg49sqPu/3YsARD9GpHbvF+T
 iq/w0Cs9vZ/NF1rR6Tet9325N+9XnhIBqqVXaBigLr/c9NqidAtSBC0u1Hr1I4JbdH
 LiZfNlOZcNX/+fEiqDDAoC2ca3egwWkoUlBoq5VDcclYQy2c5k7I8T9uM0u0rNTiYK
 T7lT/0jbOlSXLxbKzNg3QUJSwXOA4HxWr26dvsuCKUZvHJ3vP803fz5BlsBHjpku69
 0p3EhiTJVUOMMny86iVfDJ15GdaDJ9jv6ea52Wl66fLKhvgM+/KdVGe00l1gj9wHCY
 xkkBDD5eiPlXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-24-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-24-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:24:26 +0000
Message-Id: <20260916162426.BF6241F000FF@smtp.kernel.org>
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
- [Medium] selftests: dyndbg: load-time parameters truncated due to shell q=
uoting bug
--

commit f2f3cad7addd566a67a218932463053f35d4d782
Author: Jim Cromie <jim.cromie@gmail.com>

selftests/dyndbg: Enable FT_classmap_inheritance

Exercise classmap state inheritance between supermod and submod,
verifying that class settings and controlling parameter states propagate
from parent classmap definitions to dependent class users upon module
load and during runtime reconfiguration.

> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/t=
ools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index 09a8dbf239dcf..51338ebc74bf8 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
[ ... ]
> @@ -298,6 +299,78 @@ function FT_basic_queries {
>      ddcmd "file $f =3D_" "$f"
>  }
> =20
> +function FT_classmap_inheritance {
> +    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
> +
> +    ifrmmod test_dynamic_debug_submod
> +    ifrmmod test_dynamic_debug
> +
> +    # modprobe with plain-old +p & 3 class enablements
> +    my_modprobe test_dynamic_debug \
> +	"dyndbg=3D+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +pm"

[Severity: Medium]
Are these load-time parameters truncated during module load due to how the
shell handles quotes?

When bash evaluates and strips the double quotes before executing modprobe,
modprobe constructs the kernel options string without adding quotes around
the parameters. The kernel's parse_args() function (using next_arg() in
lib/cmdline.c) splits module parameters at unquoted spaces.

This means it treats D2_CORE and +pf as separate unknown parameters. The
dyndbg parsing logic executes +p but fails on the truncated class command,
completely ignoring the actual class configurations.

Does this defeat the test's intent to verify load-time classmap inheritance,
allowing it to pass only because the golden hash recorded the incorrectly
applied +p state?

It appears this space-splitting flaw persists through the end of the patch
series, and the newly added FT_test_classes also replicates it.

> +    verify_control_slice '\[test_dynamic_debug\]'
> +
> +    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
> +    verify_control_slice '\[test_dynamic_debug\]'
> +
> +    my_modprobe test_dynamic_debug_submod
> +    verify_control_slice 'test_dynamic_debug_submod'
> +
> +    # fresh start, to clear all above flags (test-fn limits)
> +    ifrmmod test_dynamic_debug_submod
> +    ifrmmod test_dynamic_debug
> +
> +    # load submod, which loads supermod
> +    my_modprobe test_dynamic_debug_submod \
> +	"dyndbg=3D+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf"

[Severity: Medium]
Does this submod load suffer from the same space-splitting issue?

> +    verify_control_slice 'test_dynamic_debug'
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D24
