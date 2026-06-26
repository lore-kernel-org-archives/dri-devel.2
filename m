Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EFFC43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CE410E20F;
	Fri, 26 Jun 2026 18:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nfJdRvTI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB29010E20F
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 18:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4391A60A68;
 Fri, 26 Jun 2026 18:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFA61F00A3A;
 Fri, 26 Jun 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782499574;
 bh=3Gvo+G/2K9GYr2kz4HtZsmXw8TlF40NkahgCHVH6JJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nfJdRvTIawPb2q3zgUs+ni2ROHv3TkJv9Np9SnDg2ouXlLf8WAxBNPyPOs6+HLmr4
 4T8XW7ienTarD/1KwPGDmQB0ZvzbL1+euKid87VKC+D5kAJw24bO0TRTK4/lXxd1sU
 zR6EkKs/fn27p85WnQN6vNd4q1Yh/+QAr+/QoHUWEpxNjBDmLefqgYMKKD+gVLrHJ6
 CSZKnirii1+QHQZ4YJ5DqV/dQ8EM3DM5PEps66mjjChqiIMHkEdYaYc5/SIWbAkyDA
 rKsqs5wiiugi3MhHl5x0+ZUPfPH7jxXAlrwCxSYee3Z/r0VhNhH0L7iFErDOP6h1th
 F5ztRkIjNQoBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] rust: pci: return DevresLt from Bar::into_devres()
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626183630.2585057-7-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-7-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:46:13 +0000
Message-Id: <20260626184613.ABFA61F00A3A@smtp.kernel.org>
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
- [Low] Missing default generic parameter `SIZE =3D 0` on the `DevresBar` t=
ype alias.
--

commit 017789d5b34f5d46a0492fb61faa312b02cc8a26
Author: Danilo Krummrich <dakr@kernel.org>
rust: pci: return DevresLt from Bar::into_devres()

This commit updates Bar::into_devres() to return DevresLt, which can shorten
the stored static lifetime back to the caller's borrow lifetime. It impleme=
nts
CovariantForLt and ForLt for Bar and adds a DevresBar type alias.

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 0461e01aaa20e..7a0d2d74129d1 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
[ ... ]
> @@ -151,6 +155,19 @@ pub struct Bar<'a, const SIZE: usize =3D 0> {
>      num: i32,
>  }
> =20
> +impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
> +    type Of<'a> =3D Bar<'a, SIZE>;
> +}
> +
> +// SAFETY: `Bar<'a, SIZE>` is covariant over `'a`; it holds `&'a Device<=
Bound>`,
> +// which is covariant.
> +unsafe impl<const SIZE: usize> CovariantForLt for Bar<'static, SIZE> {}
> +
> +/// A device-managed PCI BAR mapping.
> +///
> +/// See [`Bar::into_devres`].
> +pub type DevresBar<const SIZE: usize> =3D DevresLt<Bar<'static, SIZE>>;

[Severity: Low]
This isn't a bug, but should DevresBar provide a default size parameter to
match the underlying Bar struct?

The Bar struct defines its size parameter with a default of 0 as seen in the
context above, but the new DevresBar alias omits this default. This omission
requires callers to explicitly specify the size when using the alias, which
creates a slight inconsistency in API ergonomics between the base type and =
its
device-managed counterpart.

Would it make sense to define it as:
pub type DevresBar<const SIZE: usize =3D 0> =3D DevresLt<Bar<'static, SIZE>=
>; ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626183630.2585=
057-1-dakr@kernel.org?part=3D6
