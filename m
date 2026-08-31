Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222F7C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5C610E301;
	Mon, 31 Aug 2026 20:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ehI0YhuJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A8610E301
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:09:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6533601DE;
 Mon, 31 Aug 2026 20:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A773C1F000E9;
 Mon, 31 Aug 2026 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788206941;
 bh=4ygFlvJcltem4BN7PhYT0mYnYEv5F0ppVgmGx6hrfEc=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=ehI0YhuJ01DhDahhb3DpeqX5TWkx2MQ6Bm611ACeX2FEtJOvaZTG2Cqb6XpsxAEXj
 ljHOR9YSjWAoduFdoftztYl5g4cgHMdGqJaKXcHbOE6L2hilUANvuEd5YIcwkQbmdr
 tRHhebjM/xvV6RWHLYmHxMpn712VoWul+ujw8Ug2EEzx4onozIfIJX0XEd13a105e+
 d3lJvHeOm1Tyqoavu3T0vstPP07KZNvUc2YJA1zJH7liZO+6cWmBGuLYGGNyDtv3sl
 ZMpdVFrQeKNfNL9S/Jtz5fu5TOtIQstsbH1YPN3eL5jqWRNWQ7Zgj0OSy0/Q/qxdnk
 DlK3k7CX5x8Mw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 22:08:56 +0200
Message-Id: <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
In-Reply-To: <20260828033531.1117754-2-apopple@nvidia.com>
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

On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> +/// API handle for the auxiliary bus child drivers to interact with nova=
-core.
> +pub struct NovaCoreApi<'bound> {
> +    #[expect(unused)]
> +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> +}
> +
> +impl NovaCoreApi<'_> {
> +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registe=
red
> +    /// by nova-core.
> +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreAp=
i<'_>>> {
> +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> +    }
> +}

CovariantForLt does not hold anymore on latest drm-rust-next, as Cmdq has a
Mutex. So, this needs ForLt now and therefore the approach that I shared in=
 [1]
a while ago. I applied the changes in [2] to fix it up.

I think the closure access through api.with(|api| ...) is fine in most case=
s,
but there are a few options if we run into cases where we consider it a bit
inconvinient.

I think it should be possible to support projections into T: 'static and
covariant fields. The reason I differentiate them is because T: 'static is =
very
convinient, but non-'static covariant types need an annoying turbofish.

For T: 'static types it would turn out like this

	let spec =3D reg_data.api.project(|api| api.spec());

such that everything that needs spec does not need to be in the closure any=
more.

For non-'static covariant fields we could have

	let foo =3D reg_data.api.project_lt::<CovariantForLt!(Foo<'_>)>(|api| api.=
foo());

but as mentioned it unfortunately needs the turbofish. Of course we could i=
nvent
a macro around it to get rid of the turbofish, but we'd still need to expli=
citly
mention the type Foo<'_>, so it doesn't buy us a lot.

This is the implementation I came up with in nova-core

	/// Projects a `'static` sub-field out of the registration data.
	///
	/// `T` is fully inferred from the closure. For projected types with a lif=
etime parameter,
	/// use [`Self::project_lt`].
	pub fn project<T: 'static>(
	    &self,
	    f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> &'b T,
	) -> &'a T {
	    self.adev
	        .registration_data_field::<ForLt!(NovaCoreApi<'_>), T>(f)
	        .expect("TypeId was validated in NovaCoreApiHandle::of()")
	}
=09
	/// Projects a covariant sub-field out of the registration data.
	///
	/// Supports projected types with a lifetime parameter via a
	/// [`CovariantForLt`](trait@CovariantForLt) encoding. Unlike [`Self::proj=
ect`], `G` cannot
	/// be inferred and must be specified explicitly.
	pub fn project_lt<G: CovariantForLt + 'static>(
	    &self,
	    f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> &'b G::Of<'b>,
	) -> &'a G::Of<'a> {
	    self.adev
	        .registration_data_project::<ForLt!(NovaCoreApi<'_>), G>(f)
	        .expect("TypeId was validated in NovaCoreApiHandle::of()")
	}

and this is what we'd need in the auxiliary bus

	/// Projects a covariant sub-field out of potentially invariant registrati=
on data.
	///
	/// `F` is the [`ForLt`](trait@ForLt) encoding of the registration data ty=
pe. `G` is the
	/// [`CovariantForLt`](trait@CovariantForLt) encoding of the projected sub=
-field type.
	///
	/// For projected types that are `'static`, prefer [`Self::registration_da=
ta_field`] which
	/// does not require a [`CovariantForLt`](trait@CovariantForLt) encoding a=
nd fully infers `T`.
	///
	/// Returns [`EINVAL`] if `F` does not match the type used by the parent d=
river when calling
	/// [`Registration::new()`]. Returns [`ENOENT`] if no registration data ha=
s been set.
	#[inline]
	pub fn registration_data_project<F, G>(
	    &self,
	    project: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> &'a G::Of<'a>,
	) -> Result<&G::Of<'_>>
	where
	    F: ForLt + 'static,
	    G: CovariantForLt + 'static,
	{
	    let ptr =3D self.registration_data_with::<F, *const ()>(|data| {
	        core::ptr::from_ref::<G::Of<'_>>(project(data)).cast::<()>()
	    })?;
=09
	    // SAFETY:
	    // - The HRTB bound on `project` ensures the returned pointer is deriv=
ed from the
	    //   registration data (nothing else lives for universally quantified =
`'a`).
	    // - `G: CovariantForLt` guarantees that shortening the lifetime of `G=
::Of` is sound.
	    // - The registration data is heap-allocated and outlives the device's=
 bound state.
	    Ok(unsafe { &*ptr.cast::<G::Of<'_>>() })
	}
=09
	/// Projects a `'static` sub-field out of potentially invariant registrati=
on data.
	///
	/// Simplified variant of [`Self::registration_data_project`] for projecte=
d types that are
	/// `'static`. Since `&'a T` is trivially covariant when `T: 'static`, no
	/// [`CovariantForLt`](trait@CovariantForLt) encoding is needed and `T` is=
 fully inferred
	/// from the closure.
	///
	/// Returns [`EINVAL`] if `F` does not match the type used by the parent d=
river when calling
	/// [`Registration::new()`]. Returns [`ENOENT`] if no registration data ha=
s been set.
	#[inline]
	pub fn registration_data_field<F: ForLt + 'static, T: 'static>(
	    &self,
	    project: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> &'a T,
	) -> Result<&T> {
	    let ptr =3D self.registration_data_with::<F, *const T>(|data| {
	        core::ptr::from_ref(project(data))
	    })?;
=09
	    // SAFETY:
	    // - The HRTB bound on `project` ensures the returned pointer is deriv=
ed from the
	    //   registration data (nothing else lives for universally quantified =
`'a`).
	    // - `T: 'static` means `&T` is trivially covariant; lifetime shorteni=
ng is sound.
	    // - The registration data is heap-allocated and outlives the device's=
 bound state.
	    Ok(unsafe { &*ptr })
	}

with the documentation being written by an LLM and unchecked.

I think at least the T: 'static projection can provide an ergonomic advanta=
ge
and might be useful to add. Please let me know what you think.

Thanks,
Danilo

[1] https://lore.kernel.org/all/DJQSY9ZY5M5F.3VI537GS00E1G@kernel.org/
[2] CovariantForLt to ForLt changes for nova-core

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.r=
s
index 7fc0baef5f04..028020213ac5 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0

-use core::pin::Pin;
-
 use kernel::{
     auxiliary,
     device::{
@@ -20,7 +18,10 @@
 use crate::file::File;
 use crate::gem::NovaObject;

-use nova_core::api::NovaCoreApi;
+use nova_core::api::{
+    NovaCoreApi,
+    NovaCoreApiHandle, //
+};

 pub(crate) struct NovaDriver;

@@ -32,7 +33,7 @@ pub(crate) struct Nova<'bound> {

 /// DRM registration data, accessible from ioctl handlers via the registra=
tion guard.
 pub(crate) struct DrmRegData<'bound> {
-    pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
+    pub(crate) api: NovaCoreApiHandle<'bound>,
 }

 /// Convienence type alias for the DRM device type for this driver
@@ -69,7 +70,7 @@ fn probe<'bound>(
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let drm =3D drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
         let reg_data =3D DrmRegData {
-            api: NovaCoreApi::of(adev)?,
+            api: NovaCoreApi::handle(adev)?,
         };
         // SAFETY: `reg` is stored in `Nova` and dropped when the driver i=
s unbound; it is
         // never forgotten.
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index e1223a29f8b1..798b14f33e20 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -32,13 +32,15 @@

 impl GpuInfo {
     fn new(reg_data: &DrmRegData<'_>) -> Self {
-        Self(uapi::drm_nova_gpu_info {
-            architecture: reg_data.api.architecture(),
-            implementation: reg_data.api.implementation(),
-            vram_size: reg_data.api.vram_size(),
-            gpu_name: reg_data.api.gpu_name(),
-            gpu_short_name: reg_data.api.gpu_short_name(),
-            gpu_gid: reg_data.api.gpu_gid(),
+        reg_data.api.with(|api| {
+            Self(uapi::drm_nova_gpu_info {
+                architecture: api.architecture(),
+                implementation: api.implementation(),
+                vram_size: api.vram_size(),
+                gpu_name: api.gpu_name(),
+                gpu_short_name: api.gpu_short_name(),
+                gpu_gid: api.gpu_gid(),
+            })
         })
     }
 }
@@ -74,7 +76,7 @@ pub(crate) fn get_param(
         _file: &drm::File<File>,
     ) -> Result<u32> {
         let value =3D match getparam.param as u32 {
-            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE =3D> reg_data.api.bar1_size(=
)?,
+            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE =3D> reg_data.api.with(|api|=
 api.bar1_size())?,
             _ =3D> return Err(EINVAL),
         };

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index ad4b62db1e5f..c9ae48d278af 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -10,7 +10,7 @@
     device::Bound,
     pci,
     prelude::*,
-    types::CovariantForLt, //
+    types::ForLt, //
 };

 use crate::gpu::{
@@ -39,10 +39,9 @@ impl NovaCoreApi<'_> {
         *self.gpu.gsp_static_info.gpu_gid()
     }

-    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registere=
d
-    /// by nova-core.
-    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<=
'_>>> {
-        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
+    /// Obtain a [`NovaCoreApiHandle`] from an auxiliary device registered=
 by nova-core.
+    pub fn handle(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHa=
ndle<'_>> {
+        NovaCoreApiHandle::of(adev)
     }

     /// Returns the architecture identifier of this GPU.
@@ -66,3 +65,22 @@ pub fn vram_size(&self) -> u64 {
         self.gpu.gsp_static_info.vram_size()
     }
 }
+
+/// Closure-based API handle for invariant registration data types.
+pub struct NovaCoreApiHandle<'a> {
+    adev: &'a auxiliary::Device<Bound>,
+}
+
+impl<'a> NovaCoreApiHandle<'a> {
+    fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self> {
+        adev.registration_data_with::<ForLt!(NovaCoreApi<'_>), ()>(|_| ())=
?;
+        Ok(Self { adev })
+    }
+
+    /// Access the [`NovaCoreApi`] through a closure.
+    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>)=
 -> R) -> R {
+        self.adev
+            .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
+            .expect("TypeId was validated in NovaCoreApiHandle::of()")
+    }
+}
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver=
.rs
index 4d3c18d6a733..025ba2869d6c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -15,7 +15,7 @@
         Atomic,
         Relaxed, //
     },
-    types::CovariantForLt,
+    types::ForLt,
 };

 use crate::{
@@ -29,7 +29,7 @@
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
     #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)=
>,
+    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
