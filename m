Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7441F10F787;
	Fri,  3 Jul 2026 10:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mG88gOUp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D312B10F787
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:25:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82CDA403EF;
 Fri,  3 Jul 2026 10:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152721F000E9;
 Fri,  3 Jul 2026 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783074356;
 bh=exyGr2MlyVqmAx0kk5sXCPyZ+u9DYrnUKUw4isqnJs0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mG88gOUpmcNN2pzmMdY8aNqxJhNzghwZQwL5EHfPRpdqJ8owsSn9roe9zUQosTeB+
 fbu0/qg40GW+m0HdNYXSvRZ8XFmesOjZ+x++3tsYYF7T1B6cpCddgQseo8Qsm6V6OT
 9nJIFPnsNdGqfiRQ2GPJnPbfTPmL5L6noZSmafRG0wIifxSV6g+QOt1LLVczTNM2hw
 F/i7/slGcsw54LaO2nVydzCdSzeio3/wMJm+4og5BS2cZD8qcFDwpR3RYkVo9BI4zB
 YzA400ggLaI22SsDwT37ITM+eFdAFU7pzahVNsJ2FHRI51O5CIw/otJMOmdXxeC9Mk
 kocmkeF1SHHLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:25:54 +0000
Message-Id: <20260703102556.152721F000E9@smtp.kernel.org>
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
- [Low] The construction of `UnusedArea` is missing the required `// INVARI=
ANT:` comment.
--

commit dec3af2ba5f37136507d9a42f30fab7e3072db7f
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: add contiguous area allocation

This commit adds support for contiguous area allocation to the ID pool by
introducing a new UnusedArea type that follows the same pattern as UnusedId.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44a..b471bfd974875 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
[ ... ]
> @@ -240,6 +245,33 @@ pub fn find_unused_id(&mut self, offset: usize) -> O=
ption<UnusedId<'_>> {
>      pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
> +
> +    /// Finds a contiguous area of `count` unused IDs at or after `offse=
t`.
> +    ///
> +    /// `align_mask` must be `0` (no alignment) or one less than a power=
 of two, in which case the
> +    /// start of the returned area is a multiple of that power of two.
> +    ///
> +    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such a=
rea could be found.
> +    #[inline]
> +    #[must_use]
> +    pub fn find_unused_area(
> +        &mut self,
> +        offset: usize,
> +        count: NonZero<usize>,
> +        align_mask: usize,
> +    ) -> Option<UnusedArea<'_>> {
> +        let start =3D self.map.next_zero_area(offset, count.get(), align=
_mask)?;
> +        Some(UnusedArea {
> +            range: start..start + count.get(),
> +            pool: self,
> +        })

[Severity: Low]
This isn't a bug, but should this UnusedArea instantiation include an
// INVARIANT: comment?

The Rust subsystem guidelines state that when a struct with an # Invariants
documentation section is constructed, the code should have an // INVARIANT:
comment explaining why the invariants are satisfied.

UnusedArea defines the invariant range.start <=3D range.end <=3D pool.map.l=
en().
Would it be appropriate to add a comment here detailing why the bounds
guaranteed by next_zero_area() satisfy this invariant?

> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-chid-v1-0-=
84fe8259e46e@nvidia.com?part=3D3
