Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88595CD5BD1
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 00:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D086610F73D;
	Fri, 29 May 2026 00:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QOOz2+RB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE59A10F73D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 00:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780013723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+G3+OJ2EMfZLqcfCGJgH1Cr8Dt21vYGjcNBJfQCjeI=;
 b=QOOz2+RBC7SX4bZAgp5+opJVgaKWiSiA3HznKexzzsY2VUfVd8Ja8EqGB4hGsSJYLi/Qcw
 aRH70yJ/gNHh0F+WQPfFKKBkjJJnHFj8N02mw63yCCdtuuhVpOQ1KfW5Y5rPFjfPjVbbHQ
 IeFrD5bIBtC6eBVbTVvqRbHQtvPpVXY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ZMBjrslrPBySR7BriSf1cA-1; Thu, 28 May 2026 20:15:22 -0400
X-MC-Unique: ZMBjrslrPBySR7BriSf1cA-1
X-Mimecast-MFC-AGG-ID: ZMBjrslrPBySR7BriSf1cA_1780013721
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so330528171cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 17:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780013721; x=1780618521;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+G3+OJ2EMfZLqcfCGJgH1Cr8Dt21vYGjcNBJfQCjeI=;
 b=SueaR1CCCxua7yhXtf+oxAUnKWQY1foRdXqaOeCaW6E4sEXalUz7q3s6bHw6yejTjn
 6u5OnVrGFvFkjwLRuCi40vX3+hcexqHhx5DPv2VL9ZztmTGrRaWEZJJQGf06EXMuNdUo
 x4fUdRCneeAwAvxDJsUI4vZ1EZTQ0P6yeb0orMacRxD/odFYqhJtKxhGpAHh4Dup3SXx
 1o+8Ze83BecWuIWJkeUArcSzWrG8qmnFl3xWHHGU7YOfitgAO8F73HwqA29QDBculflS
 ZPxP+oJnXWl51N/CMlTNMudBKChCeL/m7kW3UCDh71RgEn9WQZKt6AYdpBFDU5KEw+w6
 1wHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8td2j9eJdftEW6U3umWnwnwNJGtSp2r5R/2IDzW9t6ARKGTds0EzOCJBIc53olT49AK1eN8o85Miw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynjbSJAd6POAh79LcwObxMNSQrbl2O1qhiBCvyK5zOERd2Hdiz
 MtvLnjUCa5pz7B4n824Il9yqgq/SuOrKvkfunNV0KZ8PD2N/hT3HE/m9PaqWwkUVPMLnohr/Nlj
 cY84b4X2YKoNofY02AFb+I5QFTfOAJ/spPGtrClLb+FHLgCCmXRlxFRArSzO1oNc7LboiWw==
X-Gm-Gg: Acq92OG9rdwlGP2Vg5qU6lmQhBvSaGnxkI+oN2gHaoKBGJhl46lNy28mupuAxEOH19Y
 RoSkHYiBStqGU36ePKz2Q73XASWaSXdpZpIlBpBkzsmJC2K/lORSHaFTbQUq14MhbCYcFOnfw9/
 BqzOEMKdZmXwvySCGoc7vjkojTS2xtA0yoyy55RWqAVio/BYNPSJZgjENFKx+GDhDUIk+r15fen
 6q/JmHnUyRW4sePnXXWw/EEKfDURCgMoS5L5iVGNZD4vny2fHyIwnlCcGHYkAXQnoJ/cSfpt/rA
 IwlVwDsMCwnA48EdpDL2zVXiAGgOmAJ+05UI5E1ONyp0NdDrWgxXEZk5ju036zUJlULkI8LO+RS
 Mmo22ebF/UUYYxt6Npo2j2qhcDSPj
X-Received: by 2002:a05:622a:4a85:b0:516:dffe:b9ab with SMTP id
 d75a77b69052e-5172dbbc8d8mr9482931cf.14.1780013721445; 
 Thu, 28 May 2026 17:15:21 -0700 (PDT)
X-Received: by 2002:a05:622a:4a85:b0:516:dffe:b9ab with SMTP id
 d75a77b69052e-5172dbbc8d8mr9482301cf.14.1780013720884; 
 Thu, 28 May 2026 17:15:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5172ebc7d23sm3465091cf.29.2026.05.28.17.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:15:20 -0700 (PDT)
Message-ID: <c393d06629007dc9fe76224d7b8a594b10c07edf.camel@redhat.com>
Subject: Re: [PATCH 3/6] rust: drm: Add RegistrationData to drm::Driver
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 airlied@gmail.com, 	simona@ffwll.ch, daniel.almeida@collabora.com,
 acourbot@nvidia.com, 	apopple@nvidia.com, ecourtney@nvidia.com,
 deborah.brouwer@collabora.com, 	ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, 	lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
Date: Thu, 28 May 2026 20:15:19 -0400
In-Reply-To: <b1865396f13f67b600f3548caa8ff907cfee9403.camel@redhat.com>
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-4-dakr@kernel.org>
 <b1865396f13f67b600f3548caa8ff907cfee9403.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3eHvXuHk5BJCXdfpkI4wl1MjaawDEIq_ygPMFJTIiJI_1780013721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Actually - thinking about this more now that I've been back at getting
rvkms ready and trying to make KMS initialization work in rust again: I
noticed I completely missed the fact that we now have a
`drm::Driver::Data` associated type and -separately- have a
`drm::Driver::RegistrationData` trait with this patch series. Which
means `RegistrationData` is probably a perfectly fine name for this and
you can disregard my previous comment.

FWIW: now that I've noticed this, that might simplify things w/r/t what
KMS needs here from DeviceContext and allow me to go from modeling
DeviceContext around 3 stages (Uninit, Initialized, Registered), to
just 2 stages (Initialized, Registered). The purpose of having a
separate Uninit and Initialized had been to workaround not having
access to `drm::Driver::Data` when a driver performs an atomic commit
before userspace registration, which would be a big ergonomic issue for
implementing a lot of atomic KMS callbacks.

But if that's not an issue with this patch series, then it probably
makes more sense for me to respin that DeviceContext patch series to
reflect that since that simplifies things a lot for the KMS side. For
your patch series, it just means you have to replace "Uninit" with
"Initialized" in the next version.

I will send out a respin with this tomorrow after working on respinning
the gem shmem patch series, since that shouldn't take me very long at
all.

On Wed, 2026-05-27 at 15:21 -0400, lyude@redhat.com wrote:
> So I just realized while working on rebasing rvkms - I'm not sure
> RegistrationData is the right name for this. If you recall, I
> described
> 3 different DeviceContext types in the patches I sent for adding
> DeviceContext and explicitly mentioned one of them isn't used yet:
>=20
> * Uninit
> * Initialized (the unused one)
> * Registered
>=20
> The thing is we probably want the RegistrationData available starting
> from Initialized, not from Registered. The reason being - setting up
> a
> DRM device with KMS support can often require performing a modeset
> _before_ the device is registered.
>=20
> Furthermore, the C callbacks that are used for such modesets are
> exactly the same callbacks used for modesets after registration -
> which
> implies that the DeviceContext we'll be working with in nearly all of
> the modeset callbacks is going to be &Device<T, Initialized> - not
> &Device<T, Registered>. And as you might imagine, it would be pretty
> painful for a KMS driver not to be able to use RegistrationData from
> any of its modesetting callbacks.
>=20
> We don't specify a type for Initialized yet, but in preparation for
> that we probably should give this a name such as DeviceData or
> DriverData - not RegistrationData.
>=20
> On Thu, 2026-05-07 at 00:06 +0200, Danilo Krummrich wrote:
> > Add a RegistrationData associated type to drm::Driver. This is a
> > ForLt
> > type whose lifetime is tied to the parent bus device binding scope.
> >=20
> > Registration<T> takes ownership of the data via Pin<KBox<_>>,
> > erasing
> > the lifetime to 'static for storage. The pointer is written to
> > drm::Device before drm_dev_register() to ensure it is already in
> > place
> > when ioctls arrive.
> >=20
> > UnbindGuard::registration_data() provides access with the lifetime
> > shortened from 'static via ForLt::cast_ref. Since
> > Registration::drop()
> > calls drm_dev_unplug() -- which performs an SRCU barrier waiting
> > for
> > all
> > drm_dev_enter() critical sections to complete -- the data is
> > guaranteed
> > to remain valid for the duration of any UnbindGuard.
> >=20
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> > =C2=A0drivers/gpu/drm/nova/driver.rs |=C2=A0 6 ++-
> > =C2=A0drivers/gpu/drm/tyr/driver.rs=C2=A0 |=C2=A0 6 ++-
> > =C2=A0rust/kernel/drm/device.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++=
+++++++++++
> > =C2=A0rust/kernel/drm/driver.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 89 ++++=
+++++++++++++++++++++++---
> > --
> > --
> > =C2=A0rust/kernel/drm/mod.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
> > =C2=A05 files changed, 121 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nova/driver.rs
> > b/drivers/gpu/drm/nova/driver.rs
> > index 9d4100f01ea7..54a3391371ba 100644
> > --- a/drivers/gpu/drm/nova/driver.rs
> > +++ b/drivers/gpu/drm/nova/driver.rs
> > @@ -12,7 +12,8 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioctl, //
> > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> > -=C2=A0=C2=A0=C2=A0 sync::aref::ARef, //
> > +=C2=A0=C2=A0=C2=A0 sync::aref::ARef,
> > +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> > =C2=A0};
> > =C2=A0
> > =C2=A0use crate::file::File;
> > @@ -63,7 +64,7 @@ fn probe(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let data =3D try_pin_i=
nit!(NovaData { adev: adev.into() });
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Unreg=
isteredDevice::<Self>::new(adev,
> > data)?;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Registrati=
on::new_foreign_owned(drm,
> > adev.as_ref(), 0)?;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Registrati=
on::new_foreign_owned(drm,
> > adev.as_ref(), (), 0)?;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self { drm: drm.int=
o() })
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > @@ -72,6 +73,7 @@ fn probe(
> > =C2=A0#[vtable]
> > =C2=A0impl drm::Driver for NovaDriver {
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Data =3D NovaData;
> > +=C2=A0=C2=A0=C2=A0 type RegistrationData =3D ForLt!(());
> > =C2=A0=C2=A0=C2=A0=C2=A0 type File =3D File;
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Object<Ctx: drm::DeviceContext> =3D gem::=
Object<NovaObject,
> > Ctx>;
> > =C2=A0=C2=A0=C2=A0=C2=A0 type ParentDevice<Ctx: DeviceContext> =3D
> > auxiliary::Device<Ctx>;
> > diff --git a/drivers/gpu/drm/tyr/driver.rs
> > b/drivers/gpu/drm/tyr/driver.rs
> > index 747745d23f31..7ac3707823b6 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -25,7 +25,8 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aref::ARef,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mutex, //
> > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > -=C2=A0=C2=A0=C2=A0 time, //
> > +=C2=A0=C2=A0=C2=A0 time,
> > +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> > =C2=A0};
> > =C2=A0
> > =C2=A0use crate::{
> > @@ -133,7 +134,7 @@ fn probe(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 });
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> > drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> > drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(),
> > 0)?;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> > drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(),
> > (),
> > 0)?;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let driver =3D TyrPlat=
formDriverData {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 _device: tdev.into(),
> > @@ -175,6 +176,7 @@ fn drop(self: Pin<&mut Self>) {
> > =C2=A0#[vtable]
> > =C2=A0impl drm::Driver for TyrDrmDriver {
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Data =3D TyrDrmDeviceData;
> > +=C2=A0=C2=A0=C2=A0 type RegistrationData =3D ForLt!(());
> > =C2=A0=C2=A0=C2=A0=C2=A0 type File =3D TyrDrmFileData;
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Object<R: drm::DeviceContext> =3D
> > drm::gem::Object<TyrObject,
> > R>;
> > =C2=A0=C2=A0=C2=A0=C2=A0 type ParentDevice<Ctx: DeviceContext> =3D plat=
form::Device<Ctx>;
> > diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> > index bb685165032d..11edbe6f9f42 100644
> > --- a/rust/kernel/drm/device.rs
> > +++ b/rust/kernel/drm/device.rs
> > @@ -23,6 +23,7 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AlwaysRefCounted, //
> > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0 types::{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ForLt,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NotThreadSafe,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opaque, //
> > =C2=A0=C2=A0=C2=A0=C2=A0 },
> > @@ -35,6 +36,7 @@
> > =C2=A0};
> > =C2=A0use core::{
> > =C2=A0=C2=A0=C2=A0=C2=A0 alloc::Layout,
> > +=C2=A0=C2=A0=C2=A0 cell::UnsafeCell,
> > =C2=A0=C2=A0=C2=A0=C2=A0 marker::PhantomData,
> > =C2=A0=C2=A0=C2=A0=C2=A0 mem,
> > =C2=A0=C2=A0=C2=A0=C2=A0 ops::Deref,
> > @@ -239,6 +241,9 @@ pub fn new(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsafe { bindings::drm_dev_put(drm_dev) };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `raw_drm` is val=
id; no concurrent access before
> > registration.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*raw_drm.as_ptr()=
).registration_data =3D
> > UnsafeCell::new(NonNull::dangling()) };
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The referen=
ce count is one, and now we take
> > ownership of that reference as a
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // `drm::Device`.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: We just =
created the device above, but have
> > yet
> > to call `drm_dev_register`.
> > @@ -270,6 +275,7 @@ pub fn new(
> > =C2=A0pub struct Device<T: drm::Driver, C: DeviceContext =3D Registered=
> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 dev: Opaque<bindings::drm_device>,
> > =C2=A0=C2=A0=C2=A0=C2=A0 data: T::Data,
> > +=C2=A0=C2=A0=C2=A0 pub(super) registration_data:
> > UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
> > =C2=A0=C2=A0=C2=A0=C2=A0 _ctx: PhantomData<C>,
> > =C2=A0}
> > =C2=A0
> > @@ -278,6 +284,23 @@ pub(crate) fn as_raw(&self) -> *mut
> > bindings::drm_device {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.dev.get()
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 /// Returns a reference to the registration data wi=
th lifetime
> > shortened
> > +=C2=A0=C2=A0=C2=A0 /// from `'static`.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// # Safety
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// The caller must ensure the parent bus device is=
 bound.
> > This
> > is
> > +=C2=A0=C2=A0=C2=A0 /// typically guaranteed by holding an active
> > `drm_dev_enter()`
> > critical
> > +=C2=A0=C2=A0=C2=A0 /// section (e.g. via [`UnbindGuard`]).
> > +=C2=A0=C2=A0=C2=A0 #[doc(hidden)]
> > +=C2=A0=C2=A0=C2=A0 pub unsafe fn raw_registration_data(&self) ->
> > &<T::RegistrationData as ForLt>::Of<'_> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Caller guarantee=
s the parent bus device is
> > bound,
> > hence
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // the pointer is valid.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let static_ref =3D unsafe {
> > (*self.registration_data.get()).as_ref() };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::RegistrationData::cast_r=
ef(static_ref)
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// # Safety
> > =C2=A0=C2=A0=C2=A0=C2=A0 ///
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// `ptr` must be a valid pointer to a `struct=
 device`
> > embedded
> > in `Self`.
> > @@ -391,6 +414,23 @@ pub struct UnbindGuard<'a, T: drm::Driver> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 idx: i32,
> > =C2=A0}
> > =C2=A0
> > +impl<T: drm::Driver> UnbindGuard<'_, T> {
> > +=C2=A0=C2=A0=C2=A0 /// Returns a reference to the registration data wi=
th its
> > lifetime shortened from `'static`
> > +=C2=A0=C2=A0=C2=A0 /// to the guard's borrow lifetime.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// The data is owned by
> > [`Registration`](drm::driver::Registration) and is guaranteed to
> > +=C2=A0=C2=A0=C2=A0 /// remain valid for the duration of this guard, si=
nce
> > +=C2=A0=C2=A0=C2=A0 /// [`Registration`](drm::driver::Registration)'s `=
drop` calls
> > +=C2=A0=C2=A0=C2=A0 /// `drm_dev_unplug()` which waits for all `drm_dev=
_enter()`
> > critical sections to complete.
> > +=C2=A0=C2=A0=C2=A0 pub fn registration_data(&self) -> &<T::Registratio=
nData as
> > ForLt>::Of<'_> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The pointer was =
set in `Registration::new()`
> > before `drm_dev_register()`, and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // is only invalidated afte=
r `drm_dev_unplug()` in
> > `Registration::drop()`. Since we hold
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // an active `drm_dev_enter=
()` critical section, the SRCU
> > barrier in `drm_dev_unplug()`
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // guarantees the pointer i=
s still valid.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { self.dev.raw_regis=
tration_data() }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > =C2=A0impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D T::ParentDevice<device::Bound>=
;
> > =C2=A0
> > diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> > index 751a68bb27e1..3a49ef324ada 100644
> > --- a/rust/kernel/drm/driver.rs
> > +++ b/rust/kernel/drm/driver.rs
> > @@ -11,7 +11,8 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0 drm,
> > =C2=A0=C2=A0=C2=A0=C2=A0 error::to_result,
> > =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> > -=C2=A0=C2=A0=C2=A0 sync::aref::ARef, //
> > +=C2=A0=C2=A0=C2=A0 sync::aref::ARef,
> > +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> > =C2=A0};
> > =C2=A0use core::{
> > =C2=A0=C2=A0=C2=A0=C2=A0 mem,
> > @@ -108,6 +109,16 @@ pub trait Driver {
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Context data associated with the DRM drive=
r
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Data: Sync + Send;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 /// Data owned by the [`Registration`] and accessib=
le through
> > [`drm::device::UnbindGuard`].
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This is a [`ForLt`](trait@ForLt) type whose lif=
etime is
> > tied
> > to the parent bus
> > +=C2=A0=C2=A0=C2=A0 /// device binding scope.
> > +=C2=A0=C2=A0=C2=A0 /// The data is only accessible while the parent bu=
s device is
> > bound (i.e. within a
> > +=C2=A0=C2=A0=C2=A0 /// `drm_dev_enter/exit` critical section), and ref=
erences
> > handed out by
> > +=C2=A0=C2=A0=C2=A0 ///
> > [`UnbindGuard::registration_data()`](drm::device::UnbindGuard::regi
> > st
> > ration_data) have
> > +=C2=A0=C2=A0=C2=A0 /// their lifetime shortened accordingly via
> > [`ForLt::cast_ref`].
> > +=C2=A0=C2=A0=C2=A0 type RegistrationData: ForLt;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// The type used to manage memory for this dr=
iver.
> > =C2=A0=C2=A0=C2=A0=C2=A0 type Object<Ctx: drm::DeviceContext>: AllocImp=
l;
> > =C2=A0
> > @@ -127,12 +138,44 @@ pub trait Driver {
> > =C2=A0/// The registration type of a `drm::Device`.
> > =C2=A0///
> > =C2=A0/// Once the `Registration` structure is dropped, the device is
> > unregistered.
> > -pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
> > +pub struct Registration<T: Driver> {
> > +=C2=A0=C2=A0=C2=A0 drm: ARef<drm::Device<T>>,
> > +=C2=A0=C2=A0=C2=A0 #[allow(dead_code)]
> > +=C2=A0=C2=A0=C2=A0 reg_data: Pin<KBox<<T::RegistrationData as
> > ForLt>::Of<'static>>>,
> > +}
> > =C2=A0
> > -impl<T: Driver> Registration<T> {
> > -=C2=A0=C2=A0=C2=A0 fn new(drm: drm::UnregisteredDevice<T>, flags: usiz=
e) ->
> > Result<Self> {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm.as_raw()` i=
s valid by the invariants of
> > `drm::Device`.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe {
> > bindings::drm_dev_register(drm.as_raw(),
> > flags) })?;
> > +impl<T: Driver> Registration<T>
> > +where
> > +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Sen=
d,
> > +{
> > +=C2=A0=C2=A0=C2=A0 fn new<'bound, E>(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm: drm::UnregisteredDevic=
e<T>,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_data: impl PinInit<<T::=
RegistrationData as
> > ForLt>::Of<'bound>, E>,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags: usize,
> > +=C2=A0=C2=A0=C2=A0 ) -> Result<Self>
> > +=C2=A0=C2=A0=C2=A0 where
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error: From<E>,
> > +=C2=A0=C2=A0=C2=A0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg_data: Pin<KBox<<T::=
RegistrationData as
> > ForLt>::Of<'bound>>> =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBo=
x::pin_init(reg_data, GFP_KERNEL)?;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `ForLt` guarante=
es covariance; lifetimes do not
> > affect layout.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg_data: Pin<KBox<<T::=
RegistrationData as
> > ForLt>::Of<'static>>> =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
afe { mem::transmute(reg_data) };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Store the registration d=
ata pointer in the device
> > before
> > registration, so that it is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // visible once ioctls can =
be called.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: No concurrent ac=
cess; the device is not yet
> > registered.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *drm.registration_=
data.get() =3D
> > NonNull::from(Pin::get_ref(reg_data.as_ref())) }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm` is a valid=
, initialized but not yet
> > registered DRM device.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ret =3D unsafe {
> > bindings::drm_dev_register(drm.as_raw(),
> > flags) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if let Err(e) =3D to_result=
(ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
SAFETY: No concurrent access; registration failed.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
afe { *drm.registration_data.get() =3D
> > NonNull::dangling() };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn Err(e);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just cal=
led `drm_dev_register` above
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new =3D NonNull::f=
rom(unsafe { drm.assume_ctx() });
> > @@ -144,46 +187,55 @@ fn new(drm: drm::UnregisteredDevice<T>,
> > flags:
> > usize) -> Result<Self> {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // one reference to th=
e device - which we take ownership
> > over here.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new =3D unsafe { A=
Ref::from_raw(new) };
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self(new))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self { drm: new, reg_dat=
a })
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Registers a new
> > [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
> > =C2=A0=C2=A0=C2=A0=C2=A0 ///
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Ownership of the [`Registration`] object i=
s passed to
> > [`devres::register`].
> > -=C2=A0=C2=A0=C2=A0 pub fn new_foreign_owned<'a>(
> > +=C2=A0=C2=A0=C2=A0 pub fn new_foreign_owned<'bound, E>(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm: drm::Unregistered=
Device<T>,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a device::Device<dev=
ice::Bound>,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'bound device::Device=
<device::Bound>,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_data: impl PinInit<<T::=
RegistrationData as
> > ForLt>::Of<'bound>, E>,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags: usize,
> > -=C2=A0=C2=A0=C2=A0 ) -> Result<&'a drm::Device<T>>
> > +=C2=A0=C2=A0=C2=A0 ) -> Result<&'bound drm::Device<T>>
> > =C2=A0=C2=A0=C2=A0=C2=A0 where
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: 'static,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error: From<E>,
> > =C2=A0=C2=A0=C2=A0=C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if drm.as_ref().as_raw=
() !=3D dev.as_raw() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return Err(EINVAL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg =3D Registration::<=
T>::new(drm, flags)?;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg =3D Registration::<=
T>::new(drm, reg_data, flags)?;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D NonNull::f=
rom(reg.device());
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devres::register(dev, reg, =
GFP_KERNEL)?;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devres::register::<_, core:=
:convert::Infallible>(dev, reg,
> > GFP_KERNEL)?;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Since `reg`=
 was passed to devres::register(),
> > the
> > device now owns the lifetime
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // of the DRM registration =
- ensuring that this references
> > lives for at least as long as 'a.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // of the DRM registration =
- ensuring that this reference
> > lives for
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // at least as long as 'bou=
nd.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { drm.as_ref=
() })
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 /// Returns a reference to the `Device` instan=
ce for this
> > registration.
> > =C2=A0=C2=A0=C2=A0=C2=A0 pub fn device(&self) -> &drm::Device<T> {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.drm
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > =C2=A0
> > =C2=A0// SAFETY: `Registration` doesn't offer any methods or access to
> > fields when shared between
> > =C2=A0// threads, hence it's safe to share it.
> > -unsafe impl<T: Driver> Sync for Registration<T> {}
> > +unsafe impl<T: Driver> Sync for Registration<T> where
> > +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Sen=
d
> > +{
> > +}
> > =C2=A0
> > =C2=A0// SAFETY: Registration with and unregistration from the DRM
> > subsystem can happen from any thread.
> > -unsafe impl<T: Driver> Send for Registration<T> {}
> > +unsafe impl<T: Driver> Send for Registration<T> where
> > +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Sen=
d
> > +{
> > +}
> > =C2=A0
> > =C2=A0impl<T: Driver> Drop for Registration<T> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> > @@ -195,6 +247,9 @@ fn drop(&mut self) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Safe by the=
 invariant of
> > `ARef<drm::Device<T>>`.
> > The existence of this
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // `Registration` also=
 guarantees that this `drm::Device`
> > is
> > actually registered.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_dev_=
unplug(self.0.as_raw()) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_dev_=
unplug(self.drm.as_raw()) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // After drm_dev_unplug(), =
the SRCU barrier guarantees
> > that
> > all UnbindGuard critical
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // sections have completed,=
 so no one holds a reference to
> > reg_data anymore.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // reg_data is dropped here=
 automatically.
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0}
> > diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> > index 64a43cb0fe57..6c0ba9c82b92 100644
> > --- a/rust/kernel/drm/mod.rs
> > +++ b/rust/kernel/drm/mod.rs
> > @@ -11,6 +11,7 @@
> > =C2=A0pub use self::device::Device;
> > =C2=A0pub use self::device::DeviceContext;
> > =C2=A0pub use self::device::Registered;
> > +pub use self::device::UnbindGuard;
> > =C2=A0pub use self::device::Uninit;
> > =C2=A0pub use self::device::UnregisteredDevice;
> > =C2=A0pub use self::driver::Driver;

