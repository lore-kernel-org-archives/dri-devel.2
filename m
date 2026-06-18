Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53425CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E83F10F41D;
	Thu, 18 Jun 2026 23:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZUfg4Rc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8551F10F41D
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 23:22:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EB984087B;
 Thu, 18 Jun 2026 23:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169481F000E9;
 Thu, 18 Jun 2026 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781824935;
 bh=c21vL7DKoyInzn8/f9pw+br9drzU/UUo6wZZ47Uim90=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KZUfg4RckpCTTybIkNQUwY/qY9Dafz3CZUOzhoBvciekDcPTDgnYsBU7BN67jx7cg
 3gPEnTCXTzcGoacvyCd+kVUCwQUmCivhiWbg6acMftYRPtVS8ymvECbT0bZkWEPpjz
 wTP0rD0O0oNSU5r1eO6s7aKATSsMFwATgYKp+O5Qc6zjPzO0QDKF/x5+txRKBmMHig
 jVepHWzVdYeeLOwpSePP8EdhTcTPhcNyomLJwLhwpKwZHQp4RlGdil339fMsFD9x/I
 5X04JD4uIkm73NnojclEAhSo86HW9f/PLbaialqeAK1KUoiMrB+sRIwdcRAjc7Vfn4
 wIt12TbIDbUmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] rust: auxiliary: add registration_data_with()
 for ForLt types
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260618230834.812007-4-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 23:22:14 +0000
Message-Id: <20260618232215.169481F000E9@smtp.kernel.org>
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
- [Low] Small forwarding functions in abstractions are missing `#[inline]` =
annotations.
--

commit 703db32948a8690227e0f13e2618862778e2205c
Author: Danilo Krummrich <dakr@kernel.org>

rust: auxiliary: add registration_data_with() for ForLt types

This commit adds registration_data_with() to allow non-covariant ForLt
types to be registered by taking an HRTB closure, avoiding concrete lifetime
selection. It also extracts shared logic into a private
registration_data_pinned() helper and relaxes the Registration bound.

> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 40a0af74a8e5c..8013c0fcd82d8 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs

[ ... ]

> @@ -300,17 +298,57 @@ pub fn registration_data<F: CovariantForLt + 'stati=
c>(&self) -> Result<Pin<&F::O

[ ... ]

> +    pub fn registration_data_with<F: ForLt + 'static, R>(
> +        &self,
> +        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
> +    ) -> Result<R> {

[Severity: Low]
This isn't a bug, but according to the Rust subsystem guidelines, small or
forwarding functions in abstractions should be annotated with #[inline].
Should this newly added forwarding function have an #[inline] attribute?

> +        // SAFETY: The HRTB closure prevents the caller from smuggling i=
n references with a
> +        // concrete short lifetime, making the round-trip from `'static`=
 sound regardless of
> +        // variance.
> +        let pinned =3D unsafe { self.registration_data_pinned::<F>()? };
> +
> +        Ok(f(pinned))
> +    }

[ ... ]

> +    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Resu=
lt<Pin<&F::Of<'_>>> {

[Severity: Low]
This isn't a bug, but since this function was modified to become a small
forwarding function to registration_data_pinned(), should it also receive
an #[inline] annotation to match the subsystem guidelines?

> +        // SAFETY: `CovariantForLt` guarantees covariance, which makes t=
he lifetime shortening
> +        // from `'static` to `'_` performed by `registration_data_pinned=
` sound.
> +        unsafe { self.registration_data_pinned::<F>() }
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618230834.8120=
07-1-dakr@kernel.org?part=3D3
