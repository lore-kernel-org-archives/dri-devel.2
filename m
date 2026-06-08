Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4419DCD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A630410F8B5;
	Mon,  8 Jun 2026 18:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PFl1geti";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40F310F8B5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:45:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C49AB40316;
 Mon,  8 Jun 2026 18:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D101F00893;
 Mon,  8 Jun 2026 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780944346;
 bh=5gy6JmAdZIwJKYmGy9XY0i7gTh1mA7Wu8Bmrfu7R668=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PFl1getiUew3f5V5Ju+aRHkNAT7xnIN2jZofuLTCvEUsG79eGh+A6/Gx2kFWr673A
 aQ2niw+TWmBfBWQXWe5PPH669VX7URZ0KBxsFtyWm6k0jIzYMPCK4oonycfxaiILDV
 h8B5BAmKOX8xprBAx6D2G1LVDO/wkbw4NLEmHRl6p6PGf5T5nV08ejshs4bhJjQPAB
 VPzc4nwirBuVmlrdztJ5lERI2nlXLYJHzxWIogHnVpGW9C90QhPVsHdt2zcgAtn0rP
 KOPqWCWotAp4v/DozRkkMAARiD+rTZ96dTTSIGs0kqWl8wt7SO7PgzK6nC6v3ovl0b
 Yo9CX5pmDFnoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/4] rust: drm: gem: shmem: Add vmap functions
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260608183057.2001376-3-lyude@redhat.com>
References: <20260608183057.2001376-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:45:46 +0000
Message-Id: <20260608184546.88D101F00893@smtp.kernel.org>
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
- [Medium] The `vmap_io` KUnit test assumes little-endian byte ordering, ca=
using the test to fail on big-endian architectures.
- [Medium] The `VMap` struct lacks explicit `Send` and `Sync` implementatio=
ns, preventing users from safely sharing or transferring owned mappings acr=
oss threads.
- [Low] The `VMap` struct is constructed without an `// INVARIANT:` comment=
 explaining how its pointer validity invariant is satisfied.
--

commit ceea14411fbb1d31f384d7a4decb9b7c0d4302da
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: shmem: Add vmap functions

This commit adds virtual memory mapping capabilities for GEM shmem objects
to the Rust DRM bindings.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 79ebd746e9611..e0bd0695ba1f8 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -191,6 +199,77 @@ extern "C" fn free_callback(obj: *mut bindings::drm_=
gem_object) {
>          // SAFETY: We're recovering the Kbox<> we created in gem_create_=
object()
>          let _ =3D unsafe { KBox::from_raw(this) };
>      }
> +
> +    /// Attempt to create a vmap from the gem object, and confirm the si=
ze of said vmap.
> +    fn make_vmap<'a, R, const SIZE: usize>(&'a self) -> Result<VMap<T, R=
, C, SIZE>>

[ ... ]

> +        // XXX: We don't currently support iomem allocations
> +        if map.is_iomem {
> +            // SAFETY: The vmap operation above succeeded, guaranteeing =
that map points to a valid
> +            // memory mapping.
> +            unsafe { self.raw_vunmap(map) };
> +
> +            Err(ENOTSUPP)
> +        } else {
> +            Ok(VMap {
> +                // SAFETY: We checked that this is not an iomem allocati=
on, making it safe to read
> +                // vaddr.
> +                addr: unsafe { map.__bindgen_anon_1.vaddr },
> +                owner: self.into(),
> +            })

[Severity: Low]
this isn't a bug, but should there be an // INVARIANT: comment here?

According to the Rust subsystem guidelines, when a struct with an Invariants
documentation section is constructed, the code must have a comment explaini=
ng
why the invariants are satisfied. The pointer validity invariant doesn't
appear to be documented during this instantiation.

> +        }
> +    }

[ ... ]

> @@ -270,3 +348,238 @@ fn drop(&mut self) {
> +/// A reference to a virtual mapping for an shmem-based GEM object in ke=
rnel address space.
> +///
> +/// # Invariants
> +///
> +/// - The size of owner is >=3D SIZE.
> +/// - The memory pointed to by addr remains valid at least until this ob=
ject is dropped.
> +pub struct VMap<D, R, C =3D Registered, const SIZE: usize =3D 0>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +    addr: *mut c_void,
> +    owner: R,
> +}

[Severity: Medium]
Should VMap explicitly implement Send and Sync?

Since the addr field is a raw pointer, VMap and its aliases will default to
being !Send and !Sync. Would this prevent users from safely passing owned
mappings across threads or into multithreaded workqueues?

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
> +        assert_eq!(vmap.read8(0x20), 0x98);
> +        assert_eq!(vmap.read8(0x21), 0xBA);
> +        assert_eq!(vmap.read8(0x22), 0xDC);
> +        assert_eq!(vmap.read8(0x23), 0xFE);

[Severity: Medium]
Does this test assume little-endian byte ordering?

The test writes a 32-bit integer (0xFEDCBA98) using native byte ordering,
but the byte-by-byte assertions check that the first byte at the lowest
address is 0x98. On big-endian architectures, wouldn't the most significant
byte (0xFE) be stored at the lowest address, causing this test to fail?

> +
> +        Ok(())
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608183057.2001=
376-1-lyude@redhat.com?part=3D2
