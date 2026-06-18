Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4384CCD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33C910EBC7;
	Thu, 18 Jun 2026 03:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T7mj0Bee";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9120810EBC7
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:57:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA21860008;
 Thu, 18 Jun 2026 03:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E731F000E9;
 Thu, 18 Jun 2026 03:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781755066;
 bh=Ae/ghmOszOFotEz1VU+LDL715sTR4BwbGCrZFG0sbvk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T7mj0BeeiQK9ZihpB+ukKNBD1XmHaOeF5v6i+6Ki9zOJvEyuTGFF1hOpQE4l/wQrI
 h2aIKzR2uW173En8qUkFUgkNvpT1NEeSXVUttD10fujRtoJ/AEMDnhZ84HbByoM22I
 t3itYn5qeoqbd0rUaNxEwB3b84LBZlVZWl1UDK21M1maT6PZulf7foFp1quMQnOplV
 lmEcCgiQvU5mpvA7aeDQ/xVAWY6dFZVDB7fbKtIugMOFzS5Dtnej4LAdWJf/gKAVIW
 0LgEHuvjzTRq/Hxc2W/H08tJXWAtZDpErFAzfAMuOpwNEhLOVKencLP1tkDKPHg4Gu
 41EVrirIFAdYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] rust: clk: add devres-managed clks
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260618-clk-type-state-v4-2-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
 <20260618-clk-type-state-v4-2-8be082786080@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:57:45 +0000
Message-Id: <20260618035746.49E731F000E9@smtp.kernel.org>
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

New issues:
- [Low] Missing `#[inline]` annotations on small abstraction functions.

Pre-existing issues:
- [High] Error path in `devm_clk_get_optional_enabled_with_rate` triggers u=
nbalanced `clk_disable_unprepare`.
--

commit 6968c407fbf832032a4c2355e55f45330a6b1049
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: clk: add devres-managed clks

The clk API allows fine-grained control, but some drivers might be
more interested in a "set and forget" API. Expand the current API to
support this by automatically disabling, unpreparing and freeing the
clock when the device is unbound from the bus.

> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index a62e4c7e252e3..692ee88ca772a 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -95,6 +95,49 @@ impl Sealed for super::Prepared {}
>          impl Sealed for super::Enabled {}
>      }
> =20
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.
> +    ///
> +    /// [`devres`]: crate::devres::Devres
> +    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Resu=
lt {

[Severity: Low]
Should this small forwarding function be annotated with #[inline]?
According to the Rust subsystem guidelines, functions in abstractions
that are small or simply forward to a binding call require this annotation.

> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a va=
lid
> +        // device pointer.
> +        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(=
), name) })?;
> +        Ok(())
> +    }
> +
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.
> +    ///
> +    /// This does not print any error messages if the clock is not found.
> +    ///
> +    /// [`devres`]: crate::devres::Devres
> +    pub fn devm_enable_optional(dev: &Device<Bound>, name: Option<&CStr>=
) -> Result {

[Severity: Low]
Does this function also need an #[inline] annotation since it just
forwards to a C binding?

> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +        // SAFETY: It is safe to call [`devm_clk_get_optional_enabled`] =
with a
> +        // valid device pointer.
> +        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(de=
v.as_raw(), name) })?;
> +        Ok(())
> +    }
> +
> +    /// Same as [`devm_enable_optional`], but also sets the rate.
> +    pub fn devm_enable_optional_with_rate(
> +        dev: &Device<Bound>,
> +        name: Option<&CStr>,
> +        rate: Hertz,
> +    ) -> Result {

[Severity: Low]
Should this small wrapper function be annotated with #[inline] to comply
with the Rust subsystem guidelines for abstractions?

> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +        // SAFETY: It is safe to call
> +        // [`devm_clk_get_optional_enabled_with_rate`] with a valid devi=
ce
> +        // pointer.
> +        from_err_ptr(unsafe {
> +            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw=
(), name, rate.as_hz())

[Severity: High]
This is a pre-existing issue, but does the underlying C function
devm_clk_get_optional_enabled_with_rate() have an unbalanced
clk_disable_unprepare() on its error path?

Looking at drivers/clk/clk-devres.c:devm_clk_get_optional_enabled_with_rate=
(),
it registers a devres entry with clk_disable_unprepare() as the cleanup
action.

If clk_set_rate() or clk_prepare_enable() fails, the error path executes
devm_clk_put(), which releases the devres entry and immediately invokes the
cleanup action:

drivers/clk/clk-devres.c:devm_clk_get_optional_enabled_with_rate() {
    ...
out_put_clk:
    devm_clk_put(dev, clk);
    return ERR_PTR(ret);
}

Because the clock was never successfully prepared or enabled, won't this
underflow the clock's enable/prepare counts? For a shared clock, could this
prematurely disable the clock for other devices?

> +        })?;
> +        Ok(())
> +    }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-clk-type-s=
tate-v4-0-8be082786080@collabora.com?part=3D2
