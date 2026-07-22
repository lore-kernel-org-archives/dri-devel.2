Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC2C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1361110E467;
	Wed, 22 Jul 2026 14:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OuU3C+PW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01FD10E467
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:59:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC0FA600AB;
 Wed, 22 Jul 2026 14:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D6E1F00A3A;
 Wed, 22 Jul 2026 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784732372;
 bh=J/LlYtIU4QqNTHUdq7bnxbSZBe42xwMTZUB4NPKZFvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OuU3C+PWaagQKn6QO82oiKmAWLecCl0Emd2furRwhtBMGPx3AxFfrJaSp1KIpB3Vj
 MQ5DVKJ4MoMdIGPPhsfcfGk2a33bhneGcNMWZfVz+e36mr9pv+y+yd+72pSnYtdfsP
 qvWZRPlUwyenASjzvAyADcnrhiIEx+yt8UihRnnhuiGU55NyDaD7/KwGzQxgswA28i
 Eq21zImUyV0sVuGcFAfHEfU0N4tyZCrA3PSZug0eK9SyX3ZMb2+1jYILdnbt4t6Dsg
 KPyfKLpaTPUEx7YSuxxdQFOpKbEaY8J/S/UuuBYQN1mddPCyrGW2WuuYMmjXey6taP
 EwxWCUN2nms6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] rust: xarray: Add support for index reservations
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722144931.1070312-6-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
 <20260722144931.1070312-6-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:59:31 +0000
Message-Id: <20260722145932.69D6E1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling `XArray::reserve()` or dropping `Reservation` while holdin=
g the XArray lock (`Guard`) causes a guaranteed A-A self-deadlock.
- [High] SAFETY and INVARIANT comments in `XArray::reserve` and `Reservatio=
n::drop` are factually wrong, reference nonexistent variables, and actively=
 promote deadlocking code.
- [Medium] The `Reservation::drop` behavior allows multiple threads to acci=
dentally destroy each other's reservations, leading to unexpected `-ENOMEM`=
 errors during atomic stores.
--

--- Patch [4]: [PATCH v6 4/6] rust: xarray: Add support for index reservati=
ons ---
commit b249894b0dc68234b47a8d9e38c201513786806c
Author: Philipp Stanner <phasta@kernel.org>

rust: xarray: Add support for index reservations

This commit adds support for xa_reserve() to the Rust XArray abstractions
by introducing reserve() and a Reservation drop guard.

> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index 987c9c0c21989..fa5d47935f0a7 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
[ ... ]
> @@ -147,6 +150,46 @@ pub fn lock(&self) -> Guard<'_, T> {
>              _not_send: NotThreadSafe,
>          }
>      }
> +
> +    /// Reserve memory in the XArray at the appropriate index. If this c=
all
> +    /// succeeds, later storing at the index will not require an allocat=
ion.
> +    ///
> +    /// Loading from reserved entries will return `None`.
> +    pub fn reserve(&self, index: usize, gfp: alloc::Flags) -> Result<Res=
ervation<'_, T>> {
> +        // SAFETY:
> +        // - `self.xa.xa` is always valid by the type invariant.
> +        // - The caller holds the lock.
> +        //
> +        // INVARIANT: `new` came from `T::into_foreign`.

[Severity: High]
The safety comment in reserve() explicitly states "The caller holds the
lock." However, both xa_reserve() and xa_release() internally acquire the
xa_lock spinlock.

If the caller follows this documentation and acquires the lock via
XArray::lock() before calling reserve(), won't this result in an A-A
self-deadlock when xa_reserve() attempts to acquire the same non-reentrant
spinlock?

Also, this isn't a bug, but the INVARIANT references a nonexistent variable
new. Is this a copy-paste error from another function?

> +        let ret =3D unsafe { bindings::xa_reserve(self.xa.get(), index, =
gfp.as_raw()) };
> +        match ret {
> +            0 =3D> Ok(Reservation { xa: self, index }),

[Severity: Medium]
In C, xa_reserve() returns 0 both when it successfully reserves an empty
slot and when the slot is already reserved (XA_ZERO_ENTRY).

If two threads concurrently call reserve() on the same index, won't both
succeed and receive a Reservation guard?

When the first thread's guard drops and unconditionally calls xa_release(),
won't it overwrite XA_ZERO_ENTRY with NULL, silently destroying the second
thread's active reservation and potentially leading to an unexpected -ENOMEM
on a later atomic store?

> +            _ =3D> Err(Error::from_errno(ret)),
> +        }
> +    }
> +}
> +
> +/// An index reservation object.
> +///
> +/// As long as you keep this object alive, your reservation will stay va=
lid. If
> +/// someone has stored to this index in the meantime, dropping your rese=
rvation
> +/// does nothing, which is why you can always drop this reservation obje=
ct once
> +/// you performed your store operation.
> +///
> +/// Refer to the main C xarray documentation for more details.
> +pub struct Reservation<'a, T: ForeignOwnable> {
> +    xa: &'a XArray<T>,
> +    index: usize,
> +}
> +
> +impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY:
> +        // - `self.xa` is always valid by the type invariant.
> +        // - If `self.id` is not used or has been stored to by a racing =
party,

[Severity: High]
This isn't a bug, but the safety comment here in the drop() method
references self.id which does not exist on this struct. Should this be
self.index instead?

> +        //   `xa_release()` will do nothing.
> +        unsafe { bindings::xa_release(self.xa.xa.get(), self.index) };

[Severity: High]
Since xa_release() internally acquires the xa_lock spinlock, will this
cause a deadlock if the Reservation guard is dropped in Drop for Reservation
while the caller still holds the XArray::lock() guard?

> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722144931.1070=
312-2-phasta@kernel.org?part=3D4
