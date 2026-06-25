Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA72ACDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E3110F38C;
	Thu, 25 Jun 2026 21:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzCfAUxH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141A910F394
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 21:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0BA443C49;
 Thu, 25 Jun 2026 21:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D26A1F00A3A;
 Thu, 25 Jun 2026 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782421618;
 bh=I76GRdAwpC74gS9JOoLgECqIycYtExF+wfz/JnHSZ7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nzCfAUxHoOWkSUCmriql46LJwdRWrcZ/U1xPXRniRh88BS3EkzQjhJ222xNbssGi4
 Cy2oCJBwD4vnOIW/eFtOCJxbr6SjhHqkcTZSkULG6Jfqeq0qDRo/V7DGv6yujLH8HW
 jTMj18ny7RWH2UycQVLzDgZMVu4P9UO1rjmm/IvI5bwAKeBAOx/tws7lnPoeRiAk2l
 Z7SWc/GagLybGrKHUmpbHuUxqVYKPs+0Mi+ZKYSGRwgcuoLpVjgOXpgsADJ111hpyf
 fkI5dKezSwrxvEgpxDqfSXsE+J6Oh3C0mOm8yRHop7G4oxux33RcQl5YmK/2DzhqlU
 xTHpJUgC++zBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/nova: use `zerocopy` in booter.rs
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260625205146.5047-4-niyudi.honda@usp.br>
References: <20260625205146.5047-1-niyudi.honda@usp.br>
 <20260625205146.5047-4-niyudi.honda@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:06:57 +0000
Message-Id: <20260625210658.4D26A1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Firmware structures are parsed using native integer types, causing=
 endianness mismatches on big-endian architectures.
--

commit f0a0d5143a0bf185e80fec9d804b5bc8f1e3c0b1
Author: Pedro Yudi Honda <niyudi.honda@usp.br>

drm/nova: use zerocopy in booter.rs

This commit replaces the transmute::FromBytes traits with their
zerocopy::FromBytes equivalents in the firmware/booter.rs file. It updates =
the
call sites and struct derivations to match the new library usage.

> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-=
core/firmware/booter.rs
> index d9313ac361af3..0cda2c50fbbe9 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs

[ ... ]

> @@ -44,7 +43,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], off=
set: usize) -> Result<S>
>      let end =3D offset.checked_add(size_of::<S>()).ok_or(EINVAL)?;
>      slice
>          .get(offset..end)
> -        .and_then(S::from_bytes_copy)
> +        .and_then(|b| S::read_from_bytes(b).ok())
>          .ok_or(EINVAL)
>  }
> =20
> @@ -53,7 +52,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], off=
set: usize) -> Result<S>
>  /// Such firmwares have an application-specific payload that needs to be=
 patched with a given
>  /// signature.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsHeaderV2 {
>      /// Offset to the start of the signatures.
>      sig_prod_offset: u32,
>      /// Size of the signatures.
>      sig_prod_size: u32,

[Severity: High]
This is a pre-existing issue, but does using native integer types like u32
in firmware structures cause endianness mismatches on big-endian architectu=
res?

When frombytes_at() reads the firmware headers directly from fixed-endian
firmware blobs into host-endian structures using S::read_from_bytes(b), the
driver will parse incorrect offset and size values on big-endian systems.

Should these structures be updated to use explicitly endian-aware types (li=
ke
kernel::types::Le32) for fields such as sig_prod_offset and sig_prod_size to
ensure correct parsing across all architectures and avoid potential
out-of-bounds memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625205146.5047=
-1-niyudi.honda@usp.br?part=3D3
