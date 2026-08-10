Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A866C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892E010E12D;
	Mon, 10 Aug 2026 14:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kOsVkUtS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFDE10E12D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:16:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F216F60052;
 Mon, 10 Aug 2026 14:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDB51F000E9;
 Mon, 10 Aug 2026 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786371391;
 bh=8VrYvTcGNejwrmJbNtxEDVpPHvafF3DMMH20ThlCNJQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kOsVkUtS9oG6nCg5CSg+Y2FRijRKeDs6/dRbWsG/saoCqjQeNginEEU06iM77z3jq
 2mCC77yLVg5d80GymrN9ZQ99YIqUXqHR/z+89o6X/8RaOTv4llEcQShqK7HhqF7Kyp
 LS6BhqLTSUJ5wZ5P5TwijTjDs3tyK42/nBZNOW1DocY4YdLDE5L1d2P2SAQEQ77cZC
 +OfLQIWmjcFzCSi2guloHoRTGC2h/I6L+wRgFgevy3ItkRfXLObnMOyQDCi2V7Byfd
 t78xHakeJ1JbPS9rCr4+6Gm2v+d5L5ZmocQNyDE3izPiJg3xiKoGXt3fcXG0Eug5B/
 GbOaP54MG6mfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-12-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-12-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:16:30 +0000
Message-Id: <20260810141631.5BDB51F000E9@smtp.kernel.org>
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
- [Low] The `io_read!` macro invocation uses a runtime loop variable `i` wi=
th the `[build: i]` syntax, which relies on the optimizer to eliminate the =
bounds check and may cause a build failure.
--

--- Patch [12]: [PATCH v2 12/12] gpu: nova-core: mm: Add PRAMIN aperture se=
lf-tests ---
commit e3c26c738212001e40a3ab7fef15d2c8cf5421b5
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add PRAMIN aperture self-tests

This commit adds self-tests for the PRAMIN aperture mechanism to verify
correct operation, alignment requirements, and corner cases during GPU prob=
e.
The tests are default disabled and gated behind CONFIG_NOVA_CORE_SELFTESTS.

> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/m=
m/pramin.rs
> --- a/drivers/gpu/nova-core/mm/pramin.rs
> +++ b/drivers/gpu/nova-core/mm/pramin.rs

[ ... ]

> +    fn test_u32_as_bytes(
> +        dev: &device::Device<device::Bound>,
> +        pramin: &mut Pramin<'_>,
> +        base: VramAddress,
> +    ) -> Result {
> +        let addr =3D base + 0x10;
> +        let val: u32 =3D 0xDEADBEEF;
> +        pramin.window_at::<u32>(addr)?.view().write_val(val);
> +
> +        let window =3D pramin.window_at::<[u8; 4]>(addr)?;
> +        for (i, &expected) in val.to_le_bytes().iter().enumerate() {
> +            selftest_assert_eq!(dev, io_read!(window.view(), [build: i])=
, expected);

[Severity: Low]
Will this cause a link-time build failure if the optimizer does not unroll
the loop?

The io_read! macro invocation in test_u32_as_bytes uses the runtime loop
variable i with the [build: i] syntax. This relies on LLVM optimization
heuristics to unroll the loop and resolve the value statically at build
time.

If the compiler fails to unroll this loop, the code will retain a call to
rust_build_error, which results in an undefined symbol linker error unless
CONFIG_RUST_BUILD_ASSERT_ALLOW is explicitly enabled.

Should this be rewritten to manually unroll the four reads, or use a
runtime index rather than [build: i]?

> +        }
> +        Ok(())
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-pramin-spl=
it-v2-0-65a00b3c7309@nvidia.com?part=3D12
