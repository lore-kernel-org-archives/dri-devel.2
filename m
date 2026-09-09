Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68953C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEDA10EF6C;
	Wed,  9 Sep 2026 06:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SRMqDHtj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DF710EF6C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:57:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D085E405EF;
 Wed,  9 Sep 2026 06:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3B51F00A3A;
 Wed,  9 Sep 2026 06:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788937053;
 bh=ZvqW/atL4f9kKL0k9mFAISWX2mImmWeaRPGdhCoXmeM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SRMqDHtjWsp5r8tl8Zmb6nncpj+5O7dl6aMeFJE1zvFf5Fv9G5n5A39Wjqm0L6SiK
 WRBpO94o2jHGxrtw2JF09Y0SaqmFfV3AhpDqhgq+iQ0B1XEoQux4eeo1zJPP4C4SN4
 ap5aiS1cgUsPVl9TFinjfZ/UTRTKDmxwJptaobnTvsaKkQI5DfCHMU64k5Rp4kLMB3
 9WFCRI+GW/6n0Fz/JOgN3ecu3TVZQqr/dEYiNZUukDNdr0Oms6k2mBzvzqBYxYoKPL
 w9Ykddn5+I2L2/4XG+B6dK3p2PLyjBQ0+OkWvO+hrrFJOGneQKSC6TvtJDy0yJzQGu
 7eakYGaVNeqCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] rust: auxiliary: let registration_data_with()
 closures return covariant sub-fields
To: "Alistair Popple" <apopple@nvidia.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, gary@garyguo.net
In-Reply-To: <20260909064506.910162-2-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-2-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:57:33 +0000
Message-Id: <20260909065733.7F3B51F00A3A@smtp.kernel.org>
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
- [High] Safe methods `registration_data_with` and `registration_data` can =
cause a Use-After-Free because `Registration::drop` frees the registration =
data but leaves a dangling pointer in the underlying C struct.
--

commit f7dbc67a0cd0bf4fcd048c32f110a8ba459452b3
Author: Alistair Popple <apopple@nvidia.com>

rust: auxiliary: let registration_data_with() closures return covariant sub=
-fields

The closure passed to registration_data_with() currently receives
Pin<&'a F::Of<'a>> with 'a universally quantified. This prevents the
closure from returning references derived from the registration data,
even for sub-fields that are covariant in their lifetime. By tying the
outer reference to the &self lifetime, the closure can coerce covariant
sub-fields and return them directly.

Link: https://lore.kernel.org/nova-gpu/DL3WPTVM033J.33RWYCZOC67Z1@kernel.or=
g/

> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 60dfbec8f3302..06f816420790a 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs

[ ... ]

> @@ -314,13 +318,14 @@ unsafe fn registration_data_pinned<F: ForLt + 'stat=
ic>(&self) -> Result<Pin<&F::
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
>      #[inline]
> -    pub fn registration_data_with<F: ForLt + 'static, R>(
> -        &self,
> -        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
> +    pub fn registration_data_with<'this, F: ForLt + 'static, R>(
> +        &'this self,
> +        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
>      ) -> Result<R> {

[Severity: High]
This is a pre-existing issue, but can this safe method cause a use-after-fr=
ee
if a child driver or a detached kernel thread retains an ARef<Device> after
the parent's unbind event?

Looking at Registration::drop in rust/kernel/auxiliary.rs, it frees the
registration data but does not clear the registration_data_rust pointer in
the underlying C struct:

Registration::drop() {
    ...
    // SAFETY: registration_data was set in new() via into_foreign().
    drop(unsafe {
        Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
            (*self.adev.as_ptr()).registration_data_rust,
        )
    });
    ...
}

If a safely retained Device is then used to call registration_data_with(), =
the
internal registration_data_pinned() method will bypass the null check and
read from the dangling pointer:

Device::registration_data_pinned() {
    let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
    if ptr.is_null() {
        ...
        return Err(ENOENT);
    }
    ...
    let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
    ...
}

Could Registration::drop be updated to clear registration_data_rust to NULL
before freeing the data to prevent this issue? Or does this also need
additional synchronization to handle concurrent access safely?

> -        // SAFETY: The HRTB closure prevents the caller from smuggling i=
n references with a
> -        // concrete short lifetime, making the round-trip from `'static`=
 sound regardless of
> -        // variance.
> +        // SAFETY: The HRTB on the inner type prevents the caller from e=
xploiting a specific
> +        // choice of `'a`. Covariant sub-fields can be safely coerced to=
 `'this`, while
> +        // invariant fields cannot be coerced and thus cannot escape wit=
h an incorrect
> +        // lifetime.
>          let pinned =3D unsafe { self.registration_data_pinned::<F>()? };
> =20
>          Ok(f(pinned))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064506.9101=
62-1-apopple@nvidia.com?part=3D1
