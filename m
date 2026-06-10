Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14DDCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B7710EA99;
	Wed, 10 Jun 2026 16:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aCjQO0gl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C9210EA8E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:39:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F645435A6;
 Wed, 10 Jun 2026 16:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4120B1F00893;
 Wed, 10 Jun 2026 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781109586;
 bh=C5yZnnuIZx0eg8btj+8fLipi6owPMvQ39mkGD/+gVkI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aCjQO0glLE4r5VO3Xznjj03VYOBOdRZeGvb7GAYprTIKEoHBDTwZlfnpVBj2ydt2t
 MMMamEmlxa04hQUUawrX4i0IeQpbOx70ixHPUTt3ZZK6dJpm5dcOQvbxdNMs2WCPt5
 cBrwAEjs0VdJUuMp8E08f4mf4TBrB9gfgSD/IS7JKRHcs4YoFeUGvsLGmCmeGDmnPf
 FeV/klFkkTDLT1uX9wDPwEevXApbNLV8GFmSlw8F1oyd+0mDTldIgCEyN+Ss2qKn9r
 5MPhnXMW+hFb7rVoiQob3sW5VF51y/2kmsz+W7eK8x5S4QaqXNp+boUXSNlhV47F4R
 Oy64ZHGFug6dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/4] rust: drm: gem: shmem: Add vmap functions
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260610162433.923550-3-lyude@redhat.com>
References: <20260610162433.923550-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:39:45 +0000
Message-Id: <20260610163946.4120B1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] VMap unconditionally implements Send and Sync without requiring it=
s generic parameter R to be Send or Sync.
- [High] The Sync implementation for VMap combined with its IoCapable trait=
 implementations allows safe concurrent volatile writes to the same memory =
location, causing a data race.
- [Medium] Off-by-one error in vmap_io kunit test loop prematurely terminat=
es the test, preventing verification of the final byte.
- [Low] Struct VMap fails to compile due to unused generic type parameters =
D and C.
--

commit 2c1f27a93b4873be7178ca4b1861ef62ac59a6b1
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: shmem: Add vmap functions

This commit hooks up vmap creation for gem shmem objects in the Rust bindin=
gs,
allowing mappings to be created for their contents.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index bfbf2bb25eac1..d4afc06d1be50 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> +/// A reference to a virtual mapping for an shmem-based GEM object in ke=
rnel address space.
> +///
> +/// # Invariants
> +///
> +/// - The size of `owner` is >=3D SIZE.
> +/// - The memory pointed to by `addr` remains valid at least until this =
object is dropped.
> +pub struct VMap<D, R, C =3D Registered, const SIZE: usize =3D 0>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +    addr: *mut c_void,
> +    owner: R,
> +}

[Severity: Low]
Does this struct compile successfully?

The generic type parameters D and C are used in the where clause but not in
any fields. Would this trigger a compiler error (E0392) requiring a
PhantomData field to compute variance?

[ ... ]

> +// SAFETY: VMaps are safe to send across threads.
> +unsafe impl<D, R, C, const SIZE: usize> Send for VMap<D, R, C, SIZE>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +}
> +
> +// SAFETY: VMaps are safe to access from multiple threads.
> +unsafe impl<D, R, C, const SIZE: usize> Sync for VMap<D, R, C, SIZE>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +}

[Severity: High]
Are these unconditional Send and Sync implementations sound?

If a caller provides a custom type for R that implements Deref but is !Send
or !Sync (such as a type using non-atomic reference counting), VMap would
still be allowed across threads. When the VMap is dropped on another thread,
the !Send R would be dropped there, resulting in a data race.

Should these implementations require explicit Send and Sync bounds on R?

[ ... ]

> +macro_rules! impl_vmap_io_capable {
> +    ($ty:ty) =3D> {
> +        impl<D, R, C, const SIZE: usize> IoCapable<$ty> for VMap<D, R, C=
, SIZE>
> +        where
> +            D: DriverObject,
> +            C: DeviceContext,
> +            R: Deref<Target =3D Object<D, C>>,
> +        {
> +            #[inline]
> +            unsafe fn io_read(&self, address: usize) -> $ty {
> +                let ptr =3D address as *mut $ty;
> +
> +                // SAFETY: The safety contract of `io_read` guarantees t=
hat address is a valid
> +                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> +                // aligned.
> +                unsafe { ptr::read_volatile(ptr) }
> +            }
> +
> +            #[inline]
> +            unsafe fn io_write(&self, value: $ty, address: usize) {
> +                let ptr =3D address as *mut $ty;
> +
> +                // SAFETY: The safety contract of `io_write` guarantees =
that address is a valid
> +                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> +                // aligned.
> +                unsafe { ptr::write_volatile(ptr, value) }
> +            }
> +        }
> +    };
> +}

[Severity: High]
Can this result in a data race?

Since VMap implements the Sync trait, shared references (&VMap) can be safe=
ly
sent to multiple threads. This IoCapable implementation powers safe Io trait
accessors (like write8) using ptr::write_volatile, which is not atomic.

According to the Rust memory model, concurrent volatile writes from multiple
threads to the same memory location constitute a data race. Should this
synchronize access to avoid undefined behavior?

[ ... ]

> +    #[test]
> +    fn vmap_io() -> Result {
> +        let (_dev, drm) =3D create_drm_dev()?;
> +
> +        let obj =3D Object::<KunitObject, _>::new(&drm, PAGE_SIZE, Objec=
tConfig::default(), ())?;
> +
> +        let vmap =3D obj.vmap::<PAGE_SIZE>()?;
> +
> +        vmap.write8(0xDE, 0x0);
> +        assert_eq!(vmap.read8(0x0), 0xDE);
> +        vmap.write32(0xFEDCBA98, 0x20);
> +
> +        assert_eq!(vmap.read32(0x20), 0xFEDCBA98);
> +
> +        // Ensure the ordering in memory is correct
> +        let offsets =3D (0x20..0x23).into_iter();
> +        let expected =3D 0xFEDCBA98_u32.to_ne_bytes().into_iter();
> +        for (offset, expected) in offsets.zip(expected) {
> +            assert_eq!(vmap.read8(offset), expected);
> +        }
> +
> +        Ok(())
> +    }
> +}

[Severity: Medium]
Does this loop skip the 4th byte verification?

The offsets iterator (0x20..0x23) produces exactly 3 elements (0x20, 0x21,
and 0x22). Because zip stops when the shortest iterator is exhausted, it
appears the 4th byte at offset 0x23 is silently skipped and never verified.

Should this be (0x20..=3D0x23) or (0x20..0x24) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610162433.9235=
50-1-lyude@redhat.com?part=3D2
