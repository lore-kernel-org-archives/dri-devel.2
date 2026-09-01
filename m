Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF4AC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D588E10E636;
	Tue,  1 Sep 2026 10:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZnLVANCZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA82310E636
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 10:27:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 385BE405A8;
 Tue,  1 Sep 2026 10:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597521F000E9;
 Tue,  1 Sep 2026 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788258461;
 bh=BxpNmtosXBLcejVvVlsO0MWlW4PxIZtHHw+hJL+JV3k=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ZnLVANCZ8CZoCqBMfmsgwuXdtcB011s0hQrurqb+Ef81pWLP++1DIcwVCQLbZGsOo
 eWYSIgnGLejrN//AequtxdK7KhQ+Hll8osCsrZGGag/2l7LnC0HUm3VlC/JVAjM3Km
 sq3WCc5QWCPBARwbPh1uSmpu3Jm/AhDY4Vuj/r1xhNp6eMaAGEpKGpOgbhCY70jERK
 jDKISlZHgKBLOjYD62HFFHjW4mAo2KmzAuyldqCuoWHPIk7KNg23wsnZtM24eogw/p
 glSqqzId01li2r/SA2O0g6T6QsPwqX73S2KSCPgbuo36Cv70p/Xp/TP4eX6d5wJn5W
 AMJRRKPLs5ptw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:27:36 +0200
Message-Id: <DL3WPTVM033J.33RWYCZOC67Z1@kernel.org>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "M Henning" <mhenning@darkrefraction.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Benno Lossin"
 <lossin@kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
 <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
In-Reply-To: <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
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

On Mon Aug 31, 2026 at 10:42 PM CEST, Gary Guo wrote:
> I think if you change the signatue of `registration_data_with` slightly:
>
>     pub fn registration_data_with<'this, F: ForLt + 'static, R>(
>         &'this self,
>         f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
>                                     ^ note this is changed from 'a to 'th=
is
>     ) -> Result<R>;
>
> then there will be an implied bound available inside the callback where '=
a
> outlives 'this, and thus the function callback is able to perform coercio=
n of
> any T<'a> to T<'this> provided that `T` is covariant over lifetime `'a`.
>
> [ The coercion won't work when doing abstract `F::Of` on the bus abstract=
ion
> side, but for any user it is dealing with concrete types so the compiler =
sees
> specific types and thus can check variance ]
>
> Then your projection can just be
>
>     aux.registration_data_project(|x| &x.field)
>
> I haven't tried it out but I think it should work.

I gave this a shot and it seems to work out, it's a good simplification. I =
think
we don't even need a dedicated project method in this case. We could add an
alias for with() just to clarify the intent, but not sure that's worth.

@Alistair: Here's the diff I tested this with:

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 798b14f33e20..9babaa0b9a5f 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -13,6 +13,7 @@
         gem::BaseObject,
         Registered, //
     },
+    num::Bounded,
     prelude::*,
     transmute::AsBytes,
     uaccess::UserSlice,
@@ -32,10 +33,12 @@

 impl GpuInfo {
     fn new(reg_data: &DrmRegData<'_>) -> Self {
+        let spec =3D reg_data.api.with(|api| api.get_ref().spec());
+
         reg_data.api.with(|api| {
             Self(uapi::drm_nova_gpu_info {
-                architecture: api.architecture(),
-                implementation: api.implementation(),
+                architecture: u32::from(Bounded::from(spec.chipset.arch())=
),
+                implementation: spec.chipset.implementation(),
                 vram_size: api.vram_size(),
                 gpu_name: api.gpu_name(),
                 gpu_short_name: api.gpu_short_name(),
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index c9ae48d278af..6825d3562d56 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -13,6 +13,8 @@
     types::ForLt, //
 };

+pub use crate::gpu::Spec;
+
 use crate::gpu::{
     Gpu, //
 };
@@ -44,14 +46,9 @@ pub fn handle(adev: &auxiliary::Device<Bound>) -> Result=
<NovaCoreApiHandle<'_>>
         NovaCoreApiHandle::of(adev)
     }

-    /// Returns the architecture identifier of this GPU.
-    pub fn architecture(&self) -> u32 {
-        self.gpu.spec.chipset.arch() as u32
-    }
-
-    /// Returns the implementation identifier of this GPU.
-    pub fn implementation(&self) -> u32 {
-        self.gpu.spec.chipset.implementation()
+    /// Returns the GPU [`Spec`].
+    pub fn spec(&self) -> &Spec {
+        &self.gpu.spec
     }

     /// Returns the size of the PCIe BAR used for accessing VRAM, typicall=
y
@@ -78,7 +75,9 @@ fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self>=
 {
     }

     /// Access the [`NovaCoreApi`] through a closure.
-    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>)=
 -> R) -> R {
+    ///
+    /// References to covariant sub-fields can be returned from the closur=
e directly.
+    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'a NovaCoreApi<'b>>)=
 -> R) -> R {
         self.adev
             .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
             .expect("TypeId was validated in NovaCoreApiHandle::of()")
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 166f4bb55752..04b97b0f89f4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -42,7 +42,8 @@ macro_rules! define_chipset {
         ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
-        pub(crate) enum Chipset {
+        #[allow(missing_docs)]
+        pub enum Chipset {
             $($variant =3D $value),*,
         }

@@ -119,7 +120,8 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 });

 impl Chipset {
-    pub(crate) const fn arch(self) -> Architecture {
+    /// Returns the [`Architecture`] generation of this chipset.
+    pub const fn arch(self) -> Architecture {
         match self {
             Self::TU102 | Self::TU104 | Self::TU106 | Self::TU117 | Self::=
TU116 =3D> {
                 Architecture::Turing
@@ -138,8 +140,8 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }

-    /// Returns the implementation identifier of this chipset.
-    pub(crate) const fn implementation(self) -> u32 {
+    /// Returns the implementation identifier of this chipset within its a=
rchitecture.
+    pub const fn implementation(self) -> u32 {
         self as u32 & 0xf
     }

@@ -167,7 +169,8 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Resul=
t {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
     #[repr(u32)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    #[allow(missing_docs)]
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
         Turing =3D uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_TURIN=
G,
         Ampere =3D uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_AMPER=
E,
         Hopper =3D uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_HOPPE=
R,
@@ -202,8 +205,9 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Resul=
t {

 /// Structure holding a basic description of the GPU: `Chipset` and `Revis=
ion`.
 #[derive(Clone, Copy)]
-pub(crate) struct Spec {
-    pub(crate) chipset: Chipset,
+pub struct Spec {
+    /// The GPU chipset.
+    pub chipset: Chipset,
     revision: Revision,
 }

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 60dfbec8f330..06f816420790 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -305,6 +305,10 @@ unsafe fn registration_data_pinned<F: ForLt + 'static>=
(&self) -> Result<Pin<&F::
     /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The c=
losure receives a pinned
     /// reference to the registration data.
     ///
+    /// The outer reference carries the `&self` lifetime while the inner t=
ype carries the HRTB
+    /// lifetime `'a`, implying `'a` outlives `&self`. This allows the clo=
sure to coerce covariant
+    /// sub-fields (e.g. `&'a T` to the caller's lifetime) and return them=
 directly in `R`.
+    ///
     /// For covariant types that implement [`trait@CovariantForLt`], prefe=
r
     /// [`registration_data`](Self::registration_data) which returns a dir=
ect reference.
     ///
@@ -314,13 +318,14 @@ unsafe fn registration_data_pinned<F: ForLt + 'static=
>(&self) -> Result<Pin<&F::
     /// Returns [`ENOENT`] if no registration data has been set, e.g. when=
 the device was
     /// registered by a C driver.
     #[inline]
-    pub fn registration_data_with<F: ForLt + 'static, R>(
-        &self,
-        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
+    pub fn registration_data_with<'this, F: ForLt + 'static, R>(
+        &'this self,
+        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
     ) -> Result<R> {
-        // SAFETY: The HRTB closure prevents the caller from smuggling in =
references with a
-        // concrete short lifetime, making the round-trip from `'static` s=
ound regardless of
-        // variance.
+        // SAFETY: The HRTB on the inner type prevents the caller from exp=
loiting a specific
+        // choice of `'a`. Covariant sub-fields can be safely coerced to `=
'this`, while
+        // invariant fields cannot be coerced and thus cannot escape with =
an incorrect
+        // lifetime.
         let pinned =3D unsafe { self.registration_data_pinned::<F>()? };

         Ok(f(pinned))
