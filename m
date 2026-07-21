Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2726C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468FE10E74F;
	Tue, 21 Jul 2026 17:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F7Pv6cBA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8092910EACC
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:05:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2713C41948;
 Tue, 21 Jul 2026 17:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BF1F00A3A;
 Tue, 21 Jul 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653518;
 bh=N+bxkTJ7tT9DCrGv6gt/O/lLk6W86SN0pJH5Ldnv4yo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F7Pv6cBAaio/wG6CT4sZ3nSGxPVu/S7z/q1SAv2Lt9a+RM9UASi/7Ek8w/9eLKDaL
 QUBfHznP9WTvIXiCuJNp1cYtEFv/K6NJQvve8gGY/5HW4ROD40EIzwbpdQ2A0MeAYh
 fr73XNB7CvJCVRUELtpRu/SQdlyt55Lf5ZWhDKaL/CgXfEDavFisD+1CDAs1f1JyV4
 2EDxp9xjP/31/zXU0GqD6RYyNTUGHzpkdO4+mVp+kLWBh44EoMVfIvqDHXx18jznlK
 SaNKmJ2G6nJedB3ByyhmCCsQ74TmL+aCaYFyx7oHeKhNG6/Pk4M8dXP6D/TADC56yL
 AaB/ChmATUPFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] rust: io: add subregion method with compile-time
 check
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:05:17 +0000
Message-Id: <20260721170517.A74BF1F00A3A@smtp.kernel.org>
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
- [High] The `subregion` method incorrectly initializes the new subregion's=
 runtime size using `ptr.len() - OFFSET` instead of `NEW_SIZE`, defeating e=
ncapsulation and enabling out-of-bounds MMIO accesses.
--

--- Patch [7]: [PATCH 07/10] rust: io: add subregion method with compile-ti=
me check ---
commit 3d97a4ac48567402f60659310de26681110a1c61
Author: Gary Guo <gary@garyguo.net>

rust: io: add subregion method with compile-time check

This commit adds a compile-time checked subregion helper function to Region.
This allows drivers to obtain a safely constrained subregion for relative
register access.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0f8b166a6d3bb..f31d37c8a3d58 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +    /// Create a subregion with provided offset and size.
> +    #[inline]
> +    pub fn subregion<'a, const OFFSET: usize, const NEW_SIZE: usize, IO>(
> +        io: IO,
> +    ) -> <IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>
> +    where
> +        IO: IoBase<'a, Target =3D Self>,
> +    {
> +        const_assert!(
> +            OFFSET + NEW_SIZE <=3D SIZE && OFFSET.is_multiple_of(4) && N=
EW_SIZE.is_multiple_of(4)
> +        );
> +
> +        let view =3D io.as_view();
> +        let ptr =3D IO::Backend::as_ptr(view) as *mut [u8];
> +        let new_ptr =3D Region::ptr_from_raw_parts_mut(
> +            ptr.cast::<u8>().wrapping_add(OFFSET),
> +            ptr.len() - OFFSET,

[Severity: High]
Does this improperly initialize the new subregion's runtime size using
ptr.len() - OFFSET instead of NEW_SIZE?

If a parent driver creates a localized subregion specifying a NEW_SIZE and
delegates it to a sub-device driver, the sub-device could mistakenly execute
fallible MMIO operations beyond the intended NEW_SIZE.

Because the runtime dynamic bounds checking will evaluate against
ptr.len() - OFFSET instead of the constrained size, out-of-bounds accesses
would improperly succeed and could corrupt adjacent registers.

Should this be updated to pass NEW_SIZE to ptr_from_raw_parts_mut?

> +        );
> +
> +        // SAFETY: We have checked that the new region is a subregion an=
d it is aligned, hence it is
> +        // a valid projection.
> +        unsafe { IO::Backend::project_view(view, new_ptr) }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D7
