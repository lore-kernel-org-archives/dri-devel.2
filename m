Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FE0C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2744810F1C9;
	Thu, 13 Aug 2026 07:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UFeQi+HF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CA010F1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:44:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1777543781;
 Thu, 13 Aug 2026 07:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D771F000E9;
 Thu, 13 Aug 2026 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786607065;
 bh=Rv1vqy9s5R8xQTD8oSz33FcDFQMDhFbTcuZeDgw0Dh4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UFeQi+HF8Q47RjNl+y/9T/wO6qml7sqHSZEzvVGW5LOJ7n+C9xGbO2viGLVeG3mHF
 A1k4CJsonbKFujr4Vn2EyYD1FpaKNeVqw7dStt0pEJwmIP7Jtx97pAl4hVlR2nzyDt
 jJdfgAnUX4OcfM4o1TWSV4thyNeq3Z/NAI+p753mJjT+KyiUznS0nj7bjT8h1dNgqq
 br9dw0xi5Ah9W8BQ1lnuiNmaMAE84DoUTdcGq5fom6M2lr56lbLlKmq9MME0RsL5gT
 gf4PeDkCDSMf2ETgfpQ5PAPK8XKcHFwbj9GwdryvBWKzmJ5hZgeEd8ONDmAHdJ0/GA
 VdKsCqPwea9rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] rust: id_pool: add contiguous area allocation
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260813-chid-v6-4-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
 <20260813-chid-v6-4-160be5dfb5bd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:44:24 +0000
Message-Id: <20260813074424.B5D771F000E9@smtp.kernel.org>
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
- [High] `IdPool::alloc_area` panics under `CONFIG_RUST_BITMAP_HARDENED` wh=
en `offset >=3D capacity()` instead of returning `None` to trigger dynamic =
growth
--

--- Patch [4]: [PATCH v6 4/7] rust: id_pool: add contiguous area allocation=
 ---
commit 8aa0c8588b18c055db8bdd7090bd5d9190acf589
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: add contiguous area allocation

Add IdPool::alloc_area which allocates a contiguous area with the
given offset, count, and alignment.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44a..a4a2ff417fe81 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
[ ... ]
> @@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> O=
ption<UnusedId<'_>> {
>      pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
> +
> +    /// Allocates a contiguous area of `count` IDs at or after `offset`.
> +    ///
> +    /// The start of the returned area is a multiple of `align`.
> +    ///
> +    /// Returns the allocated range upon success, or [`None`] if no such=
 area could be found.
> +    #[inline]
> +    #[must_use]
> +    pub fn alloc_area(
> +        &mut self,
> +        offset: usize,
> +        count: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Option<Range<usize>> {

[Severity: High]
Does this panic under CONFIG_RUST_BITMAP_HARDENED if offset is greater than
or equal to the pool's capacity?

When offset is passed directly to BitmapVec::next_zero_area(), the hardened
build of the bitmap operations will assert that the start offset is less
than the length.

If a caller dynamically searches for contiguous areas and their sliding win=
dow
goes beyond the current capacity, could this crash the kernel rather than
safely returning None to trigger a dynamic growth request?

> +        let start =3D self.map.next_zero_area(offset, count, align)?;
> +        self.map.set(start, count);
> +        Some(start..start + count.get())
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-chid-v6-0-=
160be5dfb5bd@nvidia.com?part=3D4
