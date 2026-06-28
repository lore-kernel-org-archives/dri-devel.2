Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51120C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 09:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F68D10E5AC;
	Sun, 28 Jun 2026 09:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J9MMAlOu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD3C10E5AC
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 09:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4557B4091A;
 Sun, 28 Jun 2026 09:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BB1F000E9;
 Sun, 28 Jun 2026 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782639426;
 bh=4jMbyawPfP607rzTm8dvsPRWuTuL2WG3lfWHHb0MQBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J9MMAlOuYwCjVAByQEGBv1WS5zsa4joqU/haPA5pB/uhFX439DUBgJ2TtBUYwCEvv
 a0AN6Cy8mUosL15+/gp7I2GQ8ucFKSWhGojWhFo0HGi4RSEOkXpNQnf6cjrO9nVsFe
 un2WSXGujTLLRrAt2PPO3XWkb+gkrFLOZIdsjbqUXhLQR1b82ooZNKabGGKQdyvBvD
 6lW5JQDVKN+HeXBgfwl06dIR+yfUaouU2qpPYilh44BDcmAORMzdjDF2vH3MixkRtM
 Hbd5qNf/w2voBjPGlB3wM2JGVwqAkgGPBWIX5x1IUF1PXG5poovKWrZRY7rej1l4Mw
 6AM+/W+TtFBAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260628092853.16550-1-trev@trevrosa.dev>
References: <20260628092853.16550-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 09:37:05 +0000
Message-Id: <20260628093705.CB2BB1F000E9@smtp.kernel.org>
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
- [Low] Un-updated AlwaysRefCounted trait implementations cause conditional=
 compilation and rustdoc test errors.
--

commit 5db284043a909f35f9aed5c1467a5f9cf863972d
Author: Trevor Chan <trev@trevrosa.dev>
rust: aref: make `AlwaysRefCounted::inc_ref` an associated function

This commit changes the AlwaysRefCounted::inc_ref function from a method
to an associated function to prevent accidental calls. It updates the
implementors of this trait to reflect this change.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index b721b2e00b986..2ae2130d5bb1d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -44,7 +44,10 @@
>  /// alive.)
>  pub unsafe trait AlwaysRefCounted {
>      /// Increments the reference count on the object.
> -    fn inc_ref(&self);
> +    ///
> +    /// This function should not be called accidentally; a type might de=
clare their own `inc_ref`
> +    /// function and it shouldn't be confused with this one.
> +    fn inc_ref(obj: &Self);

[Severity: Low]
Will this change break the build for conditionally compiled modules and
rustdoc tests that still use the old method signature?

When compiling with CONFIG_RUST_DRM_GPUVM, CONFIG_PM_OPP, or
CONFIG_RUST_PWM_ABSTRACTIONS enabled, it appears this will result in
compiler error E0185 because the following implementations were not updated:

rust/kernel/drm/gpuvm/mod.rs:
unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVm<T> {
    fn inc_ref(&self) {

rust/kernel/drm/gpuvm/vm_bo.rs:
unsafe impl<T: DriverGpuVm> AlwaysRefCounted for GpuVmBo<T> {
    fn inc_ref(&self) {

rust/kernel/opp.rs:
unsafe impl AlwaysRefCounted for OPP {
    #[inline]
    fn inc_ref(&self) {

rust/kernel/pwm.rs:
unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
    #[inline]
    fn inc_ref(&self) {

Additionally, a rustdoc test in rust/kernel/sync/aref.rs for ARef::into_raw
still implements it using the old signature:

    /// unsafe impl AlwaysRefCounted for Empty {
    ///     fn inc_ref(&self) {}

Should these implementations be updated to use fn inc_ref(obj: &Self) to
match the new trait definition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628092853.1655=
0-1-trev@trevrosa.dev?part=3D1
