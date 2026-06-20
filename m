Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D974CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078ED10E27A;
	Sat, 20 Jun 2026 19:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fYNZ7KB1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8966410E284
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:03:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 708E143FF2;
 Sat, 20 Jun 2026 19:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EF71F000E9;
 Sat, 20 Jun 2026 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982185;
 bh=kae77RNGoAreQfd7Ch8VhnF0C2e/MrFKkIXpmiaak5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fYNZ7KB1YNcCaZ8NZZN5bnbGplADWZ3WZvaAI6a5vs+Nrbc+hr577gb0yy4VhDEyC
 041G1szSUcTlF5TshijKDMuuNsqJlR8EQ9Y3KnnzbpN+dCeUondf27U7bA+/TYzFf+
 qqSrM11RybWyrpATRxKKJG1cTm23P0CtmfZ3POrE5jYaFaOLNRJch6GvLr3GBAqvo7
 mZuvA9LW1mGjuO+hGQjAuZ0Wd0NSQzGqkY4wDXKXhfi1cywszcMPnOfZlxjxnuqJHn
 7bgy6uTLVxAhFo8COoPHLFf5iHKYUu6EPLERdftq8YD8pGlVvUmGVIE91pbrIrvfgQ
 hhMmPcIy1TsYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] rust: drm: restrict AlwaysRefCounted to Normal
 Device context
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620184924.2247517-6-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:03:04 +0000
Message-Id: <20260620190305.11EF71F000E9@smtp.kernel.org>
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
- [Low] Incorrect use of `#[inline(always)]` on `__call_ioctl` without `bui=
ld_assert!()`.
--

commit 681c752cb3d2e7c1fa7dd279a52a3695aceaee3b
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: restrict AlwaysRefCounted to Normal Device context

This commit restricts the AlwaysRefCounted implementation for drm::Device to
the Normal context. It clarifies that registered devices represent non-owni=
ng
views and must not be independently reference-counted. The commit also
refactors DRM IOCTL handling to use a lifetime-bounded closure approach.

[ ... ]

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index cf328101dde4e..023e6da5c1e4b 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -70,6 +70,39 @@ pub mod internal {
>      pub use bindings::drm_device;
>      pub use bindings::drm_file;
>      pub use bindings::drm_ioctl_desc;
> +
> +    /// Call an ioctl handler with lifetime-bounded references.
> +    ///
> +    /// The lifetime `'a` is tied to the `_anchor` parameter. This preve=
nts handlers from
> +    /// declaring `'static` on `dev`, `data`, or `file`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `raw_data` must point to a valid, exclusively-owned instance o=
f `Data` for the duration
> +    ///   of the call.
> +    /// - `raw_file` must be a valid pointer to a `struct drm_file`.
> +    #[doc(hidden)]
> +    #[inline(always)]
> +    pub unsafe fn __call_ioctl<

[Severity: Low]
This isn't a bug, but is the #[inline(always)] attribute intended here?

According to the Rust subsystem guidelines, #[inline(always)] should only be
used for functions using build_assert!() that depend on function parameters.

For forwarding abstractions like __call_ioctl(), the standard #[inline]
attribute is preferred since it lacks parameter-dependent build-time
assertions.

> +        'a,
> +        Dev: 'a,
> +        Data: 'a,
> +        F: super::super::file::DriverFile + 'a,
> +        Ret,
> +    >(

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D5
