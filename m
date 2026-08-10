Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E59C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA0110E747;
	Mon, 10 Aug 2026 08:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FgCcplyy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571E10E733
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:48:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D465600B1;
 Mon, 10 Aug 2026 08:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2471F00A3A;
 Mon, 10 Aug 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786351689;
 bh=xUqvM4nrUHcdvbLBFSSxN+4h0sKMVy2v1Nnqev1wp+U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FgCcplyygEhQck55j+GYBLVPPcUSgkhJAAsd1RUcf7ptluSEC/FVcknY25KN+7Hlf
 jL2EqZm8yIMB+m107W0fqtRDkvqLxT5/MF5u4ul2z10WrxFG2OJ7Kb6GjQbROK6JPN
 yZycjBy/2/HiSwWsXuOwsWJshfE5NiX40a0DVU0iiT7Q0t0ybmKgcfnndiGYfNUZo4
 a2izpKwb0WnzpuPacSbY739u1U0RCpwsdFqItHiUM7m73sycZBYvR9N8gLbpozj9xz
 hV+8fZ+U5uFW32T0bqNiKKwjHoSuuXntI8riiHCXd3UDs1iB27uKxcTNBwnLj97gLr
 AL6AokhDExipw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] rust: bitmap: restrict bitmap length to at most
 i32::MAX
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260810-chid-v4-2-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
 <20260810-chid-v4-2-c9f206fdcb97@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 08:48:08 +0000
Message-Id: <20260810084809.8B2471F00A3A@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the safe Rust AP=
I for `Bitmap` allows data races (Undefined Behavior). The methods `set_bit=
_atomic` and `clear_bit_atomic` are marked as `safe` and take a shared refe=
rence `&self` to perform atomic mutations. However, `Bitmap` (and `BitmapVe=
c` via `Deref`) implements `Sync`, meaning `&Bitmap` can be shared across m=
ultiple threads. Other safe methods like `next_bit`, `last_bit`, and `copy_=
and_extend` (via the `src` parameter) also take `&self` but perform non-ato=
mic reads. This allows safe Rust code to execute concurrent atomic writes a=
nd non-atomic reads on the same memory, violating Rust's memory model and c=
ausing Undefined Behavior (a data race). The safety comment in `set_bit_ato=
mic` incorrectly states 'the caller has ensured that there is no mix of non=
-atomic and atomic operations', but since the method is marked safe, the co=
mpiler cannot enforce this.
--

--- Patch [2]: [PATCH v4 2/5] rust: bitmap: restrict bitmap length to at mo=
st i32::MAX ---
commit d989729ee19564d93c5d59130c2e1ac3974ea804
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: bitmap: restrict bitmap length to at most i32::MAX

This patch restricts the maximum size of a Bitmap to i32::MAX bits to match
BitmapVec. It updates the unsafe requirements for Bitmap::from_raw and
from_raw_mut to reflect this limit. It also corrects potential out-of-bounds
writes in copy_and_extend caused by u32 cast truncations.

Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc2..0d481d761f2ac 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs

[ ... ]

> @@ -415,7 +420,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
>      #[inline]
>      pub fn copy_and_extend(&mut self, src: &Bitmap) {

[Severity: High]
This isn't a bug introduced by this patch, but does the safe Rust API for
Bitmap allow data races?

The set_bit_atomic() and clear_bit_atomic() methods are marked as safe and
take a shared reference to perform atomic mutations. However, Bitmap
implements Sync, meaning it can be shared across multiple threads.

Other safe methods like next_bit(), last_bit(), and copy_and_extend() (via
the src parameter here) also take a shared reference but perform non-atomic
reads. This allows safe Rust code to execute concurrent atomic writes and
non-atomic reads on the same memory, violating the memory model.

The safety comment in set_bit_atomic() states the caller has ensured there =
is
no mix of non-atomic and atomic operations, but since the method is marked
safe, the compiler cannot enforce this.

Could the API be updated to prevent safe code from triggering a data race?

>          let len =3D core::cmp::min(src.len(), self.len());
> -        // SAFETY: access to `self` and `src` is within bounds.
> +        // SAFETY: access to `self` and `src` is within bounds. Both len=
gths fit in `u32`
> +        // because a `Bitmap` is at most `i32::MAX` bits, so the casts a=
re lossless.
>          unsafe {
>              bindings::bitmap_copy_and_extend(
>                  self.as_mut_ptr(),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-chid-v4-0-=
c9f206fdcb97@nvidia.com?part=3D2
