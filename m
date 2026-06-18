Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AA3CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0570010EBC5;
	Thu, 18 Jun 2026 03:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CeYrmCFn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 402E910EBC5
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C67D419B5;
 Thu, 18 Jun 2026 03:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD1C1F000E9;
 Thu, 18 Jun 2026 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781755019;
 bh=QycQyUjYoKF8EUQ+PFtJhdkpycEV4+28uwKeWVwZAh8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CeYrmCFnohNCTL3i+21gFvCWCy8qQ2XkPFhUW38lT+7OcHCz3HAbBhP/hZkRptTDh
 tHNXCB4JAGr0l5kbthyw8iJvg/xUxp2t/CRYBDs2gNGG9zqMsvaCKOdjkOehUyuJ8N
 G3q019EbjtFwtbJ5flpzbvNgUkoZqRM0FnNeO9kzPH3QeAJM5PuyKuf9QRXNqqK6cL
 xa5t3llZP0EqngoJntEhghOWVoXAeo5WlzkGYcvZBYtBgmGVVSwF5NosHE1R+sC1sh
 jocJGfd9LKsybB79eNU57LMXjOYQDXEQtfkMvyRayy/6H7mmgkiCoXcSDb6mGLwyB0
 izISTxuUgaa7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] rust: clk: use the type-state pattern
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
 <20260618-clk-type-state-v4-1-8be082786080@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:56:59 +0000
Message-Id: <20260618035659.BAD1C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The clock rate configuration methods (`rate()` and `set_rate()`) h=
ave been restricted exclusively to `Clk<Enabled>`, breaking support for clo=
cks with `CLK_SET_RATE_GATE` and preventing pre-enablement configuration.
- [Low] Missing `// INVARIANT:` comments when constructing `Clk` instances =
during state transitions, and safety comments incorrectly refer to a non-ex=
istent `self.0` field.
- [Low] `Clk::<Enabled>::disable()` incorrectly returns a `Result` despite =
being infallible, while `unprepare()` correctly returns the struct directly.
- [Low] Typo in the `# Invariants` documentation section regarding the `Pre=
pared` and `Enabled` states.
--

commit c6dd3e4cdd99489c0a4f27adce8b4f6ceef42c51
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: clk: use the type-state pattern

This commit switches the clock abstraction to use the type-state pattern
to enforce valid state transitions and track reference counts automatically.

Link: https://crates.io/crates/sealed [1]

> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index 7abbd0767d8cf..a62e4c7e252e3 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs

[ ... ]

> +    /// The [`Prepared`] state is associated with a single count of
> +    /// `clk_prepare()`, and the [`Enabled`] state is associated with a =
single
> +    /// count of `clk_enable()`, and the [`Prepared`] state is associate=
d with a
> +    /// single count of `clk_prepare()` and `clk_enable()`.

[Severity: Low]
Is the last part of this sentence a typo? It attributes the dual count
requirement to the Prepared state again instead of the Enabled state.

[ ... ]

> +        pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>>=
 {
> +            // We will be transferring the ownership of our `clk_get()` =
count to
> +            // `Clk<Prepared>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `self.0` is a valid argum=
ent for
> +            // [`clk_prepare`].
> +            to_result(unsafe { bindings::clk_prepare(clk.as_raw()) })
> +                .map(|()| Clk {
> +                    inner: clk.inner,
> +                    _phantom: PhantomData,
> +                })

[Severity: Low]
Should there be an '// INVARIANT:' comment when constructing this new Clk,
similar to the initialization in get_unbound()?=20

Also, does the safety comment reference 'self.0' which no longer exists=20
after the struct was refactored to use named fields? The same stale referen=
ce
and missing invariant comment appears in unprepare(), enable(), and disable=
().

[ ... ]

> +        pub fn disable(self) -> Result<Clk<Prepared>, Error<Enabled>> {
> +            // We will be transferring the ownership of our `clk_get()` =
and
> +            // `clk_enable()` counts to `Clk<Prepared>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `self.0` is a valid argum=
ent for
> +            // [`clk_disable`].
> +            unsafe { bindings::clk_disable(clk.as_raw()) };
> +
> +            Ok(Clk {
> +                inner: clk.inner,
> +                _phantom: PhantomData,
> +            })
> +        }

[Severity: Low]
Since clk_disable() is infallible, does this method need to return a Result=
?=20
The unprepare() method returns the struct directly, which avoids unnecessary
error handling for the caller.

[ ... ]

> +    impl Clk<Enabled> {
[ ... ]
>          pub fn set_rate(&self, rate: Hertz) -> Result {
>              // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
>              // [`clk_set_rate`].
>              to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rat=
e.as_hz()) })
>          }
>      }

[Severity: High]
Does restricting set_rate() and rate() to the Enabled state prevent configu=
ring
clocks that have the CLK_SET_RATE_GATE flag?=20

The C API requires clocks with this flag to be disabled before changing the=
ir=20
rate. Additionally, is it still possible to safely configure a clock's rate=
=20
before enabling it, which is often required to avoid running hardware at=20
incorrect frequencies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-clk-type-s=
tate-v4-0-8be082786080@collabora.com?part=3D1
