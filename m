Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8167CA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4FB10F151;
	Wed, 30 Sep 2026 02:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZJCH25gv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8CA10F151
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:52:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30B92411F1;
 Wed, 30 Sep 2026 02:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB5B1F00893;
 Wed, 30 Sep 2026 02:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790736775;
 bh=UQ56mV9ei+TG6KJ2daN4mf+RaXjfcaYw2cF7464r2ok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZJCH25gvAsGL2QbiZgBrVwDMC+/OYVeXu9XOUMr/6yOcreO2NQMedmzK81DPOtk9H
 kPBZ/Vf6cu46clVyMUWETeMZkarJK5GzPpdpcHtAzZPPLwvY1NGgzKczmdn3wUWUQG
 DmQPRi6F1qFkHwbkgzbO9JT6DcwzMM0F6CkYPyueSVGHnvgVgrnQxL/uERXCWb6daw
 qkG37mj6WRVsFgMGQOe0oD6jfZYeWyGfENXB84GUYD5TJKSOlB/sVAentCOytmjq+h
 VPBEsnZ/sTZ2qf8ZMHLNAFDOz89V9rEEj96EjjwhBT3gwC9xjwbjYUrCMFBLMuTtZW
 cyOTZq+Gu0RmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 gary@garyguo.net, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 02:52:54 +0000
Message-Id: <20260930025254.AEB5B1F00893@smtp.kernel.org>
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
- [High] rust: id_pool: panic on find_unused_id with 0-capacity pool
--

commit 424a508011ab0d65530fe9badebd792ee11ae3f5
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN

This patch modifies IdPool::with_capacity to no longer round up the initial
capacity to BitmapVec::MAX_INLINE_LEN, allowing for a capacity of 0. It also
adjusts grow_request to ensure that a 0-capacity pool grows to at least
BitmapVec::MAX_INLINE_LEN instead of remaining 0.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 06a4c71c4c6c9..4f329249df9d0 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>      }
> =20
>      /// Constructs a new [`IdPool`] with space for a specific number of =
bits.
> -    ///
> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_=
LEN`].
> -    ///
> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      #[inline]
>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, A=
llocError> {
> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>          let map =3D BitmapVec::new(num_ids, flags)?;
>          Ok(Self { map })
>      }

[Severity: High]
Can allowing a capacity of 0 here introduce a regression where finding unus=
ed
IDs triggers a kernel panic?

If a user initializes a 0-capacity pool and calls find_unused_id() or
reserve_ids(), the offset is passed directly to the underlying Bitmap
functions.

For example, in IdPool::find_unused_id():

rust/kernel/id_pool.rs:IdPool::find_unused_id() {
    ...
    Some(UnusedId {
        id: self.map.next_zero_bit(offset)?,
        pool: self,
    })
    ...
}

The underlying Bitmap::next_zero_bit() function enforces a bounds check
via bitmap_assert!(start < self.len()).

For a 0-capacity pool with start=3D0, this evaluates to 0 < 0, triggering an
unconditional panic when the CONFIG_RUST_BITMAP_HARDENED configuration is
enabled.

Should we handle 0-capacity gracefully and return None to signal the need f=
or
a grow_request() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-chid-v9-0-=
0d6cca376cff@nvidia.com?part=3D8
