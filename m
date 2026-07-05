Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C9DC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 17:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ED610E205;
	Sun,  5 Jul 2026 17:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KcyxY1m2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD3010E205
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 17:10:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 836C241879;
 Sun,  5 Jul 2026 17:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D667A1F000E9;
 Sun,  5 Jul 2026 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783271400;
 bh=mcoXwyCDIViVanQXi5iL1opkmjhsI27kJo5T08QRKJw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=KcyxY1m2uFCsMd7ivwACp4mtffcdKs/HI09z7yxBa7SZny9nOPUTNxXpDZuqeWI/H
 TinrGE1ilyY8+I6h6OhqYgIdpjJ8Lbo+mv1HU4fshPR8zP1WBiH50F3Uw8/qv+NO/V
 hx7Gt0+ui9LDTEZFTNMfupfKcFVgcSQ3pX6UEz/otErFuBERBRZzSpdQV4L+5fPWZY
 8Z9HPyTM5E4ru/YBExHsFxRivHuHD8hbcA7D2xvw6Sh/ioBx6/9rRTibth7F6lzLSq
 Sy1FUOwlKWkmi7dmLMkqLYTs3XpWTvEufIxzIy+2OcY1rbl6/Cfyn0EHbjEiX9S39f
 raHt2ao5yeI5Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 19:09:56 +0200
Message-Id: <DJQSY9ZY5M5F.3VI537GS00E1G@kernel.org>
Subject: Re: [RFC 1/3] gpu: nova-core: Add auxiliary bus registration data
 to nova-core
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260703064526.3630668-1-apopple@nvidia.com>
 <20260703064526.3630668-2-apopple@nvidia.com>
 <DJQNN9FRZN3C.3DQE4H9HAZ8W6@kernel.org>
In-Reply-To: <DJQNN9FRZN3C.3DQE4H9HAZ8W6@kernel.org>
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

On Sun Jul 5, 2026 at 3:00 PM CEST, Danilo Krummrich wrote:
> On Fri Jul 3, 2026 at 8:45 AM CEST, Alistair Popple wrote:
>> diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/au=
xdata.rs
>> new file mode 100644
>> index 000000000000..266b5ce4ee89
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/auxdata.rs
>
> I think it'd just call it something along the lines of api.rs, as this is=
 going
> to be the file where the entry points into nova-core will live.
>
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Nova-core auxbus data. Contains all the methods used by the auxbus =
drivers
>> +//! to interact with nova-core.
>> +
>> +use crate::gpu::Gpu;
>> +
>> +/// Auxiliary bus registration data. Used by the auxbus drivers to call=
 methods on
>> +/// the GPU.
>> +pub struct AuxData<'bound> {
>
> Since this will also be the data type that will be exposed as an API entr=
y point
> into nova-core, I'd rather call it e.g. NovaCoreApi.
>
> We should provide an assoicated function NovaCoreApi::of(), which takes a=
n &'a
> auxiliary::Device<Bound> as argument and returns &'a NovaCoreApi<'a> (at =
least
> as long as the type remains covariant).
>
> This makes it a bit cleaner since it keeps the type assertion local to a =
single
> place and makes it transparent to nova-drm that this also is the
> auxiliary::Registration private data of nova-core.
>
> (I'm already working on getting rid of the type ID check, but going throu=
gh
> NovaCoreApi::of() is cleaner regardless.)

Thinking a bit more about this, I'm still not convinced about a design wher=
e the
auxiliary::Device itself carries the type information. However, I think wit=
h the
new lifetime design this isn't necessary in the first place.

We can just call NovaCoreApi::of() once from nova-drm's probe() function an=
d
subsequently store the struct NovaCoreApi<'a> in the bus device private dat=
a,
DRM registration data, etc. Such that the only fallible path is in probe().

Please see [1] for reference, there's also a branch in [2].

Note that this only works for a covariant NovaCoreApi, once it becomes inva=
riant
we'll need something like this:

	/// Closure-based API handle for invariant registration data types.
	pub struct NovaCoreApiHandle<'a> {
	    adev: &'a auxiliary::Device<Bound>,
	}
=09
	impl<'a> NovaCoreApiHandle<'a> {
	    fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self> {
	        adev.registration_data_with::<ForLt!(NovaCoreApi<'_>), ()>(|_| ())=
?;
	        Ok(Self { adev })
	    }
=09
	    /// Access the [`NovaCoreApi`] through a closure.
	    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>)=
 -> R) -> R {
	        // PANIC: TypeId was validated in `of()`, cannot fail.
	        self.adev
	            .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
	            .unwrap()
	    }
	}

We can still improve this a bit from the auxiliary API side, but in general=
 this
should be fine (added this to the branch in [2] as well).

With this the access patterns becomes

	// Once from probe(), calls NovaCoreApiHandle::of() internally.
	let handle =3D NovaCoreApi::handle(adev)?;

and from anywhere else

	handle.with(|api| api.chipset());

[1]

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.r=
s
index 739690bc2db5..89da0f6c3ba5 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+use core::pin::Pin;
+
 use kernel::{
     auxiliary,
     device::{
@@ -17,6 +19,7 @@
=20
 use crate::file::File;
 use crate::gem::NovaObject;
+use nova_core::api::NovaCoreApi;
=20
 pub(crate) struct NovaDriver;
=20
@@ -26,6 +29,11 @@ pub(crate) struct Nova<'bound> {
     _reg: drm::Registration<'bound, NovaDriver>,
 }
=20
+/// DRM registration data, accessible from ioctl handlers via the registra=
tion guard.
+pub(crate) struct DrmRegData<'bound> {
+    pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
+}
+
 /// Convienence type alias for the DRM device type for this driver
 pub(crate) type NovaDevice<Ctx =3D drm::Normal> =3D drm::Device<NovaDriver=
, Ctx>;
=20
@@ -59,10 +67,15 @@ fn probe<'bound>(
         adev: &'bound auxiliary::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        let api =3D NovaCoreApi::of(adev)?;
+
         let drm =3D drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
+
+        let drm_data =3D DrmRegData { api };
+
         // SAFETY: `reg` is stored in `Nova` and dropped when the driver i=
s unbound; it is
         // never forgotten.
-        let reg =3D unsafe { drm::Registration::new(adev.as_ref(), drm, ()=
, 0)? };
+        let reg =3D unsafe { drm::Registration::new(adev.as_ref(), drm, dr=
m_data, 0)? };
=20
         Ok(Nova {
             drm: reg.device().into(),
@@ -74,7 +87,7 @@ fn probe<'bound>(
 #[vtable]
 impl drm::Driver for NovaDriver {
     type Data =3D ();
-    type RegistrationData<'a> =3D ();
+    type RegistrationData<'a> =3D DrmRegData<'a>;
     type File =3D File;
     type Object =3D gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> =3D auxiliary::Device<Ctx>;
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 57df54ba27bd..2488825c78cf 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -1,7 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-use crate::driver::{NovaDevice, NovaDriver};
-use crate::gem::NovaObject;
+use crate::{
+    driver::{
+        DrmRegData,
+        NovaDevice,
+        NovaDriver, //
+    },
+    gem::NovaObject,
+};
+
 use kernel::{
     alloc::flags::*,
     auxiliary,
@@ -16,9 +23,6 @@
     uapi,
 };
=20
-use kernel::types::CovariantForLt;
-use nova_core::auxdata::AuxData;
-
 pub(crate) struct File;
=20
 impl drm::file::DriverFile for File {
@@ -33,18 +37,17 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
         let adev: &auxiliary::Device<Bound> =3D dev.as_ref();
-        let pdev: &pci::Device<Bound> =3D adev.parent().try_into()?;
-        let data =3D adev.registration_data::<CovariantForLt!(AuxData<'_>)=
>()?;
+        let pdev: &pci::Device<_> =3D adev.parent().try_into()?;
=20
         let value =3D match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE =3D> pdev.resource_len(1)?,
-            uapi::NOVA_GETPARAM_GPU_CHIPSET =3D> data.chipset() as u64,
-            uapi::NOVA_GETPARAM_VRAM_SIZE =3D> data.vram_size(),
+            uapi::NOVA_GETPARAM_GPU_CHIPSET =3D> reg_data.api.chipset() as=
 u64,
+            uapi::NOVA_GETPARAM_VRAM_SIZE =3D> reg_data.api.vram_size(),
             _ =3D> return Err(EINVAL),
         };
=20
@@ -56,7 +59,7 @@ pub(crate) fn get_param(
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -70,7 +73,7 @@ pub(crate) fn gem_create(
     /// IOCTL: gem_info: Query GEM metadata.
     pub(crate) fn gem_info(
         _dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
new file mode 100644
index 000000000000..ba99d5a27805
--- /dev/null
+++ b/drivers/gpu/nova-core/api.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Nova Core API for auxiliary bus child drivers.
+
+use core::pin::Pin;
+
+use kernel::{
+    auxiliary,
+    device::Bound,
+    prelude::*,
+    types::CovariantForLt, //
+};
+
+use crate::gpu::{
+    Chipset,
+    Gpu, //
+};
+
+/// API handle for auxiliary bus child drivers to interact with nova-core.
+pub struct NovaCoreApi<'bound> {
+    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+}
+
+impl NovaCoreApi<'_> {
+    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registere=
d by nova-core.
+    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<=
'_>>> {
+        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
+    }
+
+    /// Returns the chipset of this GPU.
+    pub fn chipset(&self) -> Chipset {
+        self.gpu.spec.chipset
+    }
+
+    /// Returns the total usable VRAM size of this GPU in bytes.
+    pub fn vram_size(&self) -> u64 {
+        self.gpu.gsp_static_info.vram_size()
+    }
+}
diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxda=
ta.rs
deleted file mode 100644
index 0a07a10da327..000000000000
--- a/drivers/gpu/nova-core/auxdata.rs
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Nova-core auxbus data. Contains all the methods used by the auxbus dri=
vers
-//! to interact with nova-core.
-
-use crate::gpu::Chipset;
-use crate::gpu::Gpu;
-
-/// Auxiliary bus registration data. Used by the auxbus drivers to call me=
thods on
-/// the GPU.
-pub struct AuxData<'bound> {
-    pub(crate) gpu: &'bound Gpu<'bound>,
-}
-
-impl AuxData<'_> {
-    /// Returns the chipset of this GPU.
-    pub fn chipset(&self) -> Chipset {
-        self.gpu.spec.chipset
-    }
-
-    /// Returns the total usable VRAM size of this GPU in bytes.
-    pub fn vram_size(&self) -> u64 {
-        self.gpu.gsp_static_info.vram_size()
-    }
-}
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver=
.rs
index 8b0bebee0bdf..9cb2eecfae1c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+use core::pin::Pin;
+
 use kernel::{
     auxiliary,
     device::Core,
@@ -18,7 +20,7 @@
     types::CovariantForLt,
 };
=20
-use crate::auxdata::AuxData;
+use crate::api::NovaCoreApi;
 use crate::gpu::Gpu;
=20
 /// Counter for generating unique auxiliary device IDs.
@@ -30,7 +32,7 @@ pub(crate) struct NovaCore<'bound> {
     // device before dropping `gpu`, and drop `gpu` before `bar` because `=
Gpu`
     // borrows `bar`.
     #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, CovariantForLt!(AuxData<'_>)>,
+    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)=
>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
@@ -82,7 +84,7 @@ fn probe<'bound>(
             pdev.enable_device_mem()?;
             pdev.set_master();
=20
-            Ok(try_pin_init!(&this in NovaCore {
+            Ok(try_pin_init!(NovaCore {
                 bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/b=
ar0")?,
                 // TODO: Use `&bar` self-referential pin-init syntax once =
available.
                 //
@@ -105,14 +107,16 @@ fn probe<'bound>(
                         // For now, use a simple atomic counter that never=
 recycles IDs.
                         AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
                         crate::MODULE_NAME,
-                        AuxData {
+                        NovaCoreApi {
                             // TODO: Use `&gpu` self-referential pin-init =
syntax once available.
                             //
-                            // SAFETY: `this.gpu` is initialized before th=
is expression is evaluated
+                            // SAFETY: `gpu` is initialized before this ex=
pression is evaluated
                             // (`try_pin_init!()` initializes fields in de=
claration order), lives at
                             // a pinned stable address, and is dropped aft=
er `_reg` (struct field
                             // drop order).
-                            gpu: &*core::ptr::from_ref(&this.as_ref().gpu)=
,
+                            gpu: Pin::new_unchecked(
+                                &*core::ptr::from_ref(gpu.as_ref().get_ref=
()),
+                            ),
                         },
                     )?
                 },
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nov=
a_core.rs
index d00c8804269d..9463ae038e81 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -10,7 +10,7 @@
     InPlaceModule, //
 };
=20
-pub mod auxdata;
+pub mod api;
 mod driver;
 mod falcon;
 mod fb;

[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Dnova-api
