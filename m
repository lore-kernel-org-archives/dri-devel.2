Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14739CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E57110E950;
	Wed, 27 May 2026 19:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cO8tamrr";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACB010E943
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779909710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZterGxckWHgSwB+TG3pddpMGlY1PsUnuASXhPAQRUCU=;
 b=cO8tamrragzYBa8FIUdVwcCLfEwqIx3fTRaD6xcS497Kwo9ZeOYWm9SD0uKzqTTzW2G9kV
 ny93j6rHijFAy1J4OJH6R7AsTJvHWv6RHr1dcBsELHlhVY/5/uLMImxq1kABrYtoALNUzU
 8rvDoLMhk9HmOI5M7Qiv3SxdqXi+VAQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401--32aVGN4Pm6Tjbf9QiDBtg-1; Wed, 27 May 2026 15:21:48 -0400
X-MC-Unique: -32aVGN4Pm6Tjbf9QiDBtg-1
X-Mimecast-MFC-AGG-ID: -32aVGN4Pm6Tjbf9QiDBtg_1779909708
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516eaf9fb76so81757841cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779909708; x=1780514508;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZterGxckWHgSwB+TG3pddpMGlY1PsUnuASXhPAQRUCU=;
 b=mFgN6ms+uFYkHFPuKDHIDEEcSmZgyzjHOiJ0+SYD7xulSrpEQCfoRHYFmcpS+USePP
 XddxJWAa1D7fXxe2B8Vfljs1sYVyz/QGi9TcVP7fuDwKhcubk3MfCU2ldIeOF1lO1GOJ
 YFpyPbef0FR0QI0s1coBd/G4IUIcCzqXEHX+4XtiOIirpgytlejjlkP1k0ql3hCIa+TS
 eMcMwo3nL8etnCUpz1uFasS1MKAjyLpomhYfjWg9zDjUzZVNsj2gJCmf5khkToq9GZS6
 f6/Y51JVjhhob+K7khtY9AKXtXgt4Ev/XqDOt+vZeqcBVRx4avu2tuSQoUmpptV3knrs
 gpoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fLnsfTfLbUZOTLk7i+nkyrHc+J9d0X4DQufyR7uKGWSFnuEX2OFh2eQhrVb1HfxDYmWntiRdjYug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPFhf7R23aV0R42XZk0La7zS76WVU7bGp+0o+Zq2xwMBZ8muww
 d/b7pPAlHEsSMgGNLsjLKkAxeYSuVjcx7RJz79Wgf8n+p4ZxfCX9YsoVR9qxdH/550CsMjpj8cP
 RJXeTEL7VZqysyabWHfVyOM+piLUPWux4FtN1ak89z56u8akp3UceaDltJxyHxZELc6SS1g==
X-Gm-Gg: Acq92OEmnibjyA8SLMpXkpATNbwiHpdbTY6SRldaLzSb7af9OZ/2VtldEiGBnAvKZr7
 JOSWhOdmo+oDinuuLQIWe5sVk37iKZzuQF1mbDyatnRSvYzvMIxaJgg0HnzSZ8gM+9e7fa3D96H
 QKYeGDe9uvnnhGbuancsvd6aw5J+mUBtqUoQWNCNV7Z4ZZdiIaReBvHfjwFALMsZ8XFuD6RDfTg
 KI6WW2ju8rYDLy+Y++ZW6Ztc26FTRCsnvrc5nrm3Qt8TVHqGei6/yKImuGS/8VN1ZTgEXek9BGY
 0EtACbAzmnKNMQiirkdrhNpP+AWxUdl/A23VsWdQuq5Sib8WjN1G/zDuYw6s+Po5nyl45jr56CO
 Ro8p7r52vF7N9d9bgLLOWmJoUlkVI
X-Received: by 2002:a05:622a:9:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-516d4644e3emr328871201cf.29.1779909707615; 
 Wed, 27 May 2026 12:21:47 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-516d4644e3emr328870551cf.29.1779909707018; 
 Wed, 27 May 2026 12:21:47 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706b08199sm51665911cf.29.2026.05.27.12.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:21:46 -0700 (PDT)
Message-ID: <b1865396f13f67b600f3548caa8ff907cfee9403.camel@redhat.com>
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
Date: Wed, 27 May 2026 15:21:45 -0400
In-Reply-To: <20260506221027.858481-4-dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-4-dakr@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qksrUjZA_1DFzBJ3eoaMYG8LovVFEe2BPmTwHLrbSk4_1779909708
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

So I just realized while working on rebasing rvkms - I'm not sure
RegistrationData is the right name for this. If you recall, I described
3 different DeviceContext types in the patches I sent for adding
DeviceContext and explicitly mentioned one of them isn't used yet:

* Uninit
* Initialized (the unused one)
* Registered

The thing is we probably want the RegistrationData available starting
from Initialized, not from Registered. The reason being - setting up a
DRM device with KMS support can often require performing a modeset
_before_ the device is registered.

Furthermore, the C callbacks that are used for such modesets are
exactly the same callbacks used for modesets after registration - which
implies that the DeviceContext we'll be working with in nearly all of
the modeset callbacks is going to be &Device<T, Initialized> - not
&Device<T, Registered>. And as you might imagine, it would be pretty
painful for a KMS driver not to be able to use RegistrationData from
any of its modesetting callbacks.

We don't specify a type for Initialized yet, but in preparation for
that we probably should give this a name such as DeviceData or
DriverData - not RegistrationData.

On Thu, 2026-05-07 at 00:06 +0200, Danilo Krummrich wrote:
> Add a RegistrationData associated type to drm::Driver. This is a
> ForLt
> type whose lifetime is tied to the parent bus device binding scope.
>=20
> Registration<T> takes ownership of the data via Pin<KBox<_>>, erasing
> the lifetime to 'static for storage. The pointer is written to
> drm::Device before drm_dev_register() to ensure it is already in
> place
> when ioctls arrive.
>=20
> UnbindGuard::registration_data() provides access with the lifetime
> shortened from 'static via ForLt::cast_ref. Since
> Registration::drop()
> calls drm_dev_unplug() -- which performs an SRCU barrier waiting for
> all
> drm_dev_enter() critical sections to complete -- the data is
> guaranteed
> to remain valid for the duration of any UnbindGuard.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/nova/driver.rs |=C2=A0 6 ++-
> =C2=A0drivers/gpu/drm/tyr/driver.rs=C2=A0 |=C2=A0 6 ++-
> =C2=A0rust/kernel/drm/device.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++=
+++++++++
> =C2=A0rust/kernel/drm/driver.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 89 ++++++=
+++++++++++++++++++++-----
> --
> =C2=A0rust/kernel/drm/mod.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
> =C2=A05 files changed, 121 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nova/driver.rs
> b/drivers/gpu/drm/nova/driver.rs
> index 9d4100f01ea7..54a3391371ba 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -12,7 +12,8 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioctl, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> -=C2=A0=C2=A0=C2=A0 sync::aref::ARef, //
> +=C2=A0=C2=A0=C2=A0 sync::aref::ARef,
> +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> =C2=A0};
> =C2=A0
> =C2=A0use crate::file::File;
> @@ -63,7 +64,7 @@ fn probe(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let data =3D try_pin_ini=
t!(NovaData { adev: adev.into() });
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Unregis=
teredDevice::<Self>::new(adev, data)?;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Registration=
::new_foreign_owned(drm,
> adev.as_ref(), 0)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D drm::Registration=
::new_foreign_owned(drm,
> adev.as_ref(), (), 0)?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self { drm: drm.into(=
) })
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -72,6 +73,7 @@ fn probe(
> =C2=A0#[vtable]
> =C2=A0impl drm::Driver for NovaDriver {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Data =3D NovaData;
> +=C2=A0=C2=A0=C2=A0 type RegistrationData =3D ForLt!(());
> =C2=A0=C2=A0=C2=A0=C2=A0 type File =3D File;
> =C2=A0=C2=A0=C2=A0=C2=A0 type Object<Ctx: drm::DeviceContext> =3D gem::Ob=
ject<NovaObject,
> Ctx>;
> =C2=A0=C2=A0=C2=A0=C2=A0 type ParentDevice<Ctx: DeviceContext> =3D auxili=
ary::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/driver.rs
> b/drivers/gpu/drm/tyr/driver.rs
> index 747745d23f31..7ac3707823b6 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -25,7 +25,8 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aref::ARef,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mutex, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> -=C2=A0=C2=A0=C2=A0 time, //
> +=C2=A0=C2=A0=C2=A0 time,
> +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> =C2=A0};
> =C2=A0
> =C2=A0use crate::{
> @@ -133,7 +134,7 @@ fn probe(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 });
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(),
> 0)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let tdev =3D
> drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), (),
> 0)?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let driver =3D TyrPlatfo=
rmDriverData {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
_device: tdev.into(),
> @@ -175,6 +176,7 @@ fn drop(self: Pin<&mut Self>) {
> =C2=A0#[vtable]
> =C2=A0impl drm::Driver for TyrDrmDriver {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Data =3D TyrDrmDeviceData;
> +=C2=A0=C2=A0=C2=A0 type RegistrationData =3D ForLt!(());
> =C2=A0=C2=A0=C2=A0=C2=A0 type File =3D TyrDrmFileData;
> =C2=A0=C2=A0=C2=A0=C2=A0 type Object<R: drm::DeviceContext> =3D drm::gem:=
:Object<TyrObject,
> R>;
> =C2=A0=C2=A0=C2=A0=C2=A0 type ParentDevice<Ctx: DeviceContext> =3D platfo=
rm::Device<Ctx>;
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index bb685165032d..11edbe6f9f42 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -23,6 +23,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AlwaysRefCounted, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 types::{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ForLt,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NotThreadSafe,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opaque, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> @@ -35,6 +36,7 @@
> =C2=A0};
> =C2=A0use core::{
> =C2=A0=C2=A0=C2=A0=C2=A0 alloc::Layout,
> +=C2=A0=C2=A0=C2=A0 cell::UnsafeCell,
> =C2=A0=C2=A0=C2=A0=C2=A0 marker::PhantomData,
> =C2=A0=C2=A0=C2=A0=C2=A0 mem,
> =C2=A0=C2=A0=C2=A0=C2=A0 ops::Deref,
> @@ -239,6 +241,9 @@ pub fn new(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
unsafe { bindings::drm_dev_put(drm_dev) };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })?;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `raw_drm` is valid=
; no concurrent access before
> registration.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { (*raw_drm.as_ptr()).=
registration_data =3D
> UnsafeCell::new(NonNull::dangling()) };
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The reference=
 count is one, and now we take
> ownership of that reference as a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // `drm::Device`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT: We just cr=
eated the device above, but have yet
> to call `drm_dev_register`.
> @@ -270,6 +275,7 @@ pub fn new(
> =C2=A0pub struct Device<T: drm::Driver, C: DeviceContext =3D Registered> =
{
> =C2=A0=C2=A0=C2=A0=C2=A0 dev: Opaque<bindings::drm_device>,
> =C2=A0=C2=A0=C2=A0=C2=A0 data: T::Data,
> +=C2=A0=C2=A0=C2=A0 pub(super) registration_data:
> UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
> =C2=A0=C2=A0=C2=A0=C2=A0 _ctx: PhantomData<C>,
> =C2=A0}
> =C2=A0
> @@ -278,6 +284,23 @@ pub(crate) fn as_raw(&self) -> *mut
> bindings::drm_device {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.dev.get()
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /// Returns a reference to the registration data with=
 lifetime
> shortened
> +=C2=A0=C2=A0=C2=A0 /// from `'static`.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// # Safety
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The caller must ensure the parent bus device is b=
ound. This
> is
> +=C2=A0=C2=A0=C2=A0 /// typically guaranteed by holding an active `drm_de=
v_enter()`
> critical
> +=C2=A0=C2=A0=C2=A0 /// section (e.g. via [`UnbindGuard`]).
> +=C2=A0=C2=A0=C2=A0 #[doc(hidden)]
> +=C2=A0=C2=A0=C2=A0 pub unsafe fn raw_registration_data(&self) ->
> &<T::RegistrationData as ForLt>::Of<'_> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Caller guarantees =
the parent bus device is bound,
> hence
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // the pointer is valid.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let static_ref =3D unsafe {
> (*self.registration_data.get()).as_ref() };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T::RegistrationData::cast_ref=
(static_ref)
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /// # Safety
> =C2=A0=C2=A0=C2=A0=C2=A0 ///
> =C2=A0=C2=A0=C2=A0=C2=A0 /// `ptr` must be a valid pointer to a `struct d=
evice` embedded
> in `Self`.
> @@ -391,6 +414,23 @@ pub struct UnbindGuard<'a, T: drm::Driver> {
> =C2=A0=C2=A0=C2=A0=C2=A0 idx: i32,
> =C2=A0}
> =C2=A0
> +impl<T: drm::Driver> UnbindGuard<'_, T> {
> +=C2=A0=C2=A0=C2=A0 /// Returns a reference to the registration data with=
 its
> lifetime shortened from `'static`
> +=C2=A0=C2=A0=C2=A0 /// to the guard's borrow lifetime.
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// The data is owned by
> [`Registration`](drm::driver::Registration) and is guaranteed to
> +=C2=A0=C2=A0=C2=A0 /// remain valid for the duration of this guard, sinc=
e
> +=C2=A0=C2=A0=C2=A0 /// [`Registration`](drm::driver::Registration)'s `dr=
op` calls
> +=C2=A0=C2=A0=C2=A0 /// `drm_dev_unplug()` which waits for all `drm_dev_e=
nter()`
> critical sections to complete.
> +=C2=A0=C2=A0=C2=A0 pub fn registration_data(&self) -> &<T::RegistrationD=
ata as
> ForLt>::Of<'_> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: The pointer was se=
t in `Registration::new()`
> before `drm_dev_register()`, and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // is only invalidated after =
`drm_dev_unplug()` in
> `Registration::drop()`. Since we hold
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // an active `drm_dev_enter()=
` critical section, the SRCU
> barrier in `drm_dev_unplug()`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // guarantees the pointer is =
still valid.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { self.dev.raw_registr=
ation_data() }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> =C2=A0impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D T::ParentDevice<device::Bound>;
> =C2=A0
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 751a68bb27e1..3a49ef324ada 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -11,7 +11,8 @@
> =C2=A0=C2=A0=C2=A0=C2=A0 drm,
> =C2=A0=C2=A0=C2=A0=C2=A0 error::to_result,
> =C2=A0=C2=A0=C2=A0=C2=A0 prelude::*,
> -=C2=A0=C2=A0=C2=A0 sync::aref::ARef, //
> +=C2=A0=C2=A0=C2=A0 sync::aref::ARef,
> +=C2=A0=C2=A0=C2=A0 types::ForLt, //
> =C2=A0};
> =C2=A0use core::{
> =C2=A0=C2=A0=C2=A0=C2=A0 mem,
> @@ -108,6 +109,16 @@ pub trait Driver {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Context data associated with the DRM driver
> =C2=A0=C2=A0=C2=A0=C2=A0 type Data: Sync + Send;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 /// Data owned by the [`Registration`] and accessible=
 through
> [`drm::device::UnbindGuard`].
> +=C2=A0=C2=A0=C2=A0 ///
> +=C2=A0=C2=A0=C2=A0 /// This is a [`ForLt`](trait@ForLt) type whose lifet=
ime is tied
> to the parent bus
> +=C2=A0=C2=A0=C2=A0 /// device binding scope.
> +=C2=A0=C2=A0=C2=A0 /// The data is only accessible while the parent bus =
device is
> bound (i.e. within a
> +=C2=A0=C2=A0=C2=A0 /// `drm_dev_enter/exit` critical section), and refer=
ences
> handed out by
> +=C2=A0=C2=A0=C2=A0 ///
> [`UnbindGuard::registration_data()`](drm::device::UnbindGuard::regist
> ration_data) have
> +=C2=A0=C2=A0=C2=A0 /// their lifetime shortened accordingly via
> [`ForLt::cast_ref`].
> +=C2=A0=C2=A0=C2=A0 type RegistrationData: ForLt;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 /// The type used to manage memory for this driv=
er.
> =C2=A0=C2=A0=C2=A0=C2=A0 type Object<Ctx: drm::DeviceContext>: AllocImpl;
> =C2=A0
> @@ -127,12 +138,44 @@ pub trait Driver {
> =C2=A0/// The registration type of a `drm::Device`.
> =C2=A0///
> =C2=A0/// Once the `Registration` structure is dropped, the device is
> unregistered.
> -pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
> +pub struct Registration<T: Driver> {
> +=C2=A0=C2=A0=C2=A0 drm: ARef<drm::Device<T>>,
> +=C2=A0=C2=A0=C2=A0 #[allow(dead_code)]
> +=C2=A0=C2=A0=C2=A0 reg_data: Pin<KBox<<T::RegistrationData as
> ForLt>::Of<'static>>>,
> +}
> =C2=A0
> -impl<T: Driver> Registration<T> {
> -=C2=A0=C2=A0=C2=A0 fn new(drm: drm::UnregisteredDevice<T>, flags: usize)=
 ->
> Result<Self> {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm.as_raw()` is =
valid by the invariants of
> `drm::Device`.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_result(unsafe { bindings::=
drm_dev_register(drm.as_raw(),
> flags) })?;
> +impl<T: Driver> Registration<T>
> +where
> +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send,
> +{
> +=C2=A0=C2=A0=C2=A0 fn new<'bound, E>(
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm: drm::UnregisteredDevice<=
T>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_data: impl PinInit<<T::Re=
gistrationData as
> ForLt>::Of<'bound>, E>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags: usize,
> +=C2=A0=C2=A0=C2=A0 ) -> Result<Self>
> +=C2=A0=C2=A0=C2=A0 where
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error: From<E>,
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg_data: Pin<KBox<<T::Re=
gistrationData as
> ForLt>::Of<'bound>>> =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBox:=
:pin_init(reg_data, GFP_KERNEL)?;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `ForLt` guarantees=
 covariance; lifetimes do not
> affect layout.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg_data: Pin<KBox<<T::Re=
gistrationData as
> ForLt>::Of<'static>>> =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { mem::transmute(reg_data) };
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Store the registration dat=
a pointer in the device before
> registration, so that it is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // visible once ioctls can be=
 called.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: No concurrent acce=
ss; the device is not yet
> registered.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { *drm.registration_da=
ta.get() =3D
> NonNull::from(Pin::get_ref(reg_data.as_ref())) }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `drm` is a valid, =
initialized but not yet
> registered DRM device.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ret =3D unsafe { bindings=
::drm_dev_register(drm.as_raw(),
> flags) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if let Err(e) =3D to_result(r=
et) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SA=
FETY: No concurrent access; registration failed.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsaf=
e { *drm.registration_data.get() =3D
> NonNull::dangling() };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n Err(e);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We just calle=
d `drm_dev_register` above
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new =3D NonNull::fro=
m(unsafe { drm.assume_ctx() });
> @@ -144,46 +187,55 @@ fn new(drm: drm::UnregisteredDevice<T>, flags:
> usize) -> Result<Self> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // one reference to the =
device - which we take ownership
> over here.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let new =3D unsafe { ARe=
f::from_raw(new) };
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self(new))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self { drm: new, reg_data =
})
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Registers a new
> [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
> =C2=A0=C2=A0=C2=A0=C2=A0 ///
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Ownership of the [`Registration`] object is =
passed to
> [`devres::register`].
> -=C2=A0=C2=A0=C2=A0 pub fn new_foreign_owned<'a>(
> +=C2=A0=C2=A0=C2=A0 pub fn new_foreign_owned<'bound, E>(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm: drm::UnregisteredDe=
vice<T>,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a device::Device<devic=
e::Bound>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'bound device::Device<d=
evice::Bound>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_data: impl PinInit<<T::Re=
gistrationData as
> ForLt>::Of<'bound>, E>,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags: usize,
> -=C2=A0=C2=A0=C2=A0 ) -> Result<&'a drm::Device<T>>
> +=C2=A0=C2=A0=C2=A0 ) -> Result<&'bound drm::Device<T>>
> =C2=A0=C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T: 'static,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error: From<E>,
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if drm.as_ref().as_raw()=
 !=3D dev.as_raw() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return Err(EINVAL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg =3D Registration::<T>=
::new(drm, flags)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg =3D Registration::<T>=
::new(drm, reg_data, flags)?;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let drm =3D NonNull::fro=
m(reg.device());
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devres::register(dev, reg, GF=
P_KERNEL)?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devres::register::<_, core::c=
onvert::Infallible>(dev, reg,
> GFP_KERNEL)?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Since `reg` w=
as passed to devres::register(), the
> device now owns the lifetime
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // of the DRM registration - =
ensuring that this references
> lives for at least as long as 'a.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // of the DRM registration - =
ensuring that this reference
> lives for
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // at least as long as 'bound=
.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { drm.as_ref()=
 })
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Returns a reference to the `Device` instance=
 for this
> registration.
> =C2=A0=C2=A0=C2=A0=C2=A0 pub fn device(&self) -> &drm::Device<T> {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.drm
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> =C2=A0// SAFETY: `Registration` doesn't offer any methods or access to
> fields when shared between
> =C2=A0// threads, hence it's safe to share it.
> -unsafe impl<T: Driver> Sync for Registration<T> {}
> +unsafe impl<T: Driver> Sync for Registration<T> where
> +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
> =C2=A0
> =C2=A0// SAFETY: Registration with and unregistration from the DRM
> subsystem can happen from any thread.
> -unsafe impl<T: Driver> Send for Registration<T> {}
> +unsafe impl<T: Driver> Send for Registration<T> where
> +=C2=A0=C2=A0=C2=A0 for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
> =C2=A0
> =C2=A0impl<T: Driver> Drop for Registration<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> @@ -195,6 +247,9 @@ fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: Safe by the i=
nvariant of `ARef<drm::Device<T>>`.
> The existence of this
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // `Registration` also g=
uarantees that this `drm::Device` is
> actually registered.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_dev_un=
plug(self.0.as_raw()) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_dev_un=
plug(self.drm.as_raw()) };
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // After drm_dev_unplug(), th=
e SRCU barrier guarantees that
> all UnbindGuard critical
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // sections have completed, s=
o no one holds a reference to
> reg_data anymore.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // reg_data is dropped here a=
utomatically.
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index 64a43cb0fe57..6c0ba9c82b92 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -11,6 +11,7 @@
> =C2=A0pub use self::device::Device;
> =C2=A0pub use self::device::DeviceContext;
> =C2=A0pub use self::device::Registered;
> +pub use self::device::UnbindGuard;
> =C2=A0pub use self::device::Uninit;
> =C2=A0pub use self::device::UnregisteredDevice;
> =C2=A0pub use self::driver::Driver;

