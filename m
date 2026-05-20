Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471DBCD4F5B
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 00:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B5B10E3F9;
	Wed, 20 May 2026 00:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCfsZD5U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAF010E3AD
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 00:33:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D60AA6022A;
 Wed, 20 May 2026 00:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C811F000E9;
 Wed, 20 May 2026 00:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779237207;
 bh=ZzHrNkgMnwZb5toan8EJ7cKAzy++f8P3bWuOPXwNdLc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=iCfsZD5UVLC8YOrIZt6D2el8PjgY7fqCISb1ZJ1D8YfLs3bsx1tYKOt465Rdxrsth
 /+PDkgynUPq+P1/DSrwj1aA8eomSIra0MfC2KoUSGvzSnc4E8v+OrWexFInWN6wPOO
 Qcl3/8YtZk+m2yP6NPTnO1fgUPlMV64LPdCqKot+8ouX5pO8Sy8FtNXWk+iV78ceFr
 HL4ZfyF/1E8k8nF65hCLTmpt4UuTt/adQ4+jhupKUUxjtjN7Xs+RyghrHaYlpJBURJ
 gHFU50g3AFNAtkHCXiz8ROGOXRs5617Onrg+Jid73uF94qtoz0WNEwBUk5C0QWtjnF
 MbdpbBLz20IVA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 02:33:19 +0200
Message-Id: <DIN2Y5PNWGVO.EOA9SQPOFYX2@kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-18-dakr@kernel.org>
 <DIMSZMCNTRA0.29WGE6IL25A6Q@garyguo.net>
In-Reply-To: <DIMSZMCNTRA0.29WGE6IL25A6Q@garyguo.net>
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

On Tue May 19, 2026 at 6:45 PM CEST, Gary Guo wrote:
> On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
>> +    pub fn new<'bound, E>(
>> +        parent: &'bound device::Device<device::Bound>,
>>          name: &CStr,
>>          id: u32,
>>          modname: &CStr,
>> -        data: impl PinInit<T, E>,
>> +        data: impl PinInit<F::Of<'bound>, E>,
>>      ) -> Result<Devres<Self>>
>
> I think this is unsound for the reason that I gave in another email
> https://lore.kernel.org/rust-for-linux/DIMSJVKTYX6D.AEN6OPPC2898@garyguo.=
net/.

Indeed, this has to be fixed. I looked into the options brought up in the l=
inked
reply, i.e. the "new type" approach and the "closure" approach. And after
playing around with both of them, I'm not really satisfied with either of t=
hose.

The "new type" one is simple and works, but has the disadvantage that, well=
, we
need a new type and update all callsites where we would ever want to create
registrations (mainly probe though).

The "closure" one on the other hand creates a little bit of an odd API and =
by
its nature does not allow to move pre-existing resources into the closure, =
which
is a major limitation (maybe there is some way, but if so I didn't find it)=
.

I instead went with something else: Currently we return a
Devres<auxiliary::Registration<_>>. However, since we're moving to lifetime=
s
anyway, we can just return an auxiliary::Registration<'bound, _> instead, w=
hich
makes the return type invariant over 'bound, which makes the problem go awa=
y
naturally.

Please find the diff below for reference.

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 5acece8e369a..c784426b8092 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -12,7 +12,7 @@
         RawDeviceId,
         RawDeviceIdIndex, //
     },
-    devres::Devres,
+
     driver,
     error::{
         from_result,
@@ -408,12 +408,12 @@ struct RegistrationData<T> {
 /// `self.adev` always holds a valid pointer to an initialized and registe=
red
 /// [`struct auxiliary_device`] whose `registration_data_rust` field point=
s to a
 /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
-pub struct Registration<F: ForLt + 'static> {
+pub struct Registration<'bound, F: ForLt + 'static> {
     adev: NonNull<bindings::auxiliary_device>,
-    _data: PhantomData<F>,
+    _phantom: PhantomData<(fn(&'bound ()) -> &'bound (), F)>,
 }
=20
-impl<F: ForLt> Registration<F>
+impl<'bound, F: ForLt> Registration<'bound, F>
 where
     for<'a> F::Of<'a>: Send + Sync,
 {
@@ -421,13 +421,13 @@ impl<F: ForLt> Registration<F>
     ///
     /// The `data` is owned by the registration and can be accessed throug=
h the auxiliary device
     /// via [`Device::registration_data()`].
-    pub fn new<'bound, E>(
+    pub fn new<E>(
         parent: &'bound device::Device<device::Bound>,
         name: &CStr,
         id: u32,
         modname: &CStr,
         data: impl PinInit<F::Of<'bound>, E>,
-    ) -> Result<Devres<Self>>
+    ) -> Result<Self>
     where
         Error: From<E>,
     {
@@ -439,8 +439,10 @@ pub fn new<'bound, E>(
             GFP_KERNEL,
         )?;
=20
-        // SAFETY: Lifetimes are erased and do not affect layout, so Regis=
trationData<F::Of<'bound>>
-        // and RegistrationData<F::Of<'static>> have identical representat=
ion.
+        // SAFETY: `'bound` is invariant (via `Registration`'s `PhantomDat=
a`), guaranteeing it
+        // represents the full binding scope. Lifetimes do not affect layo=
ut, so
+        // RegistrationData<F::Of<'bound>> and RegistrationData<F::Of<'sta=
tic>> have identical
+        // representation.
         let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =3D
             unsafe { core::mem::transmute(data) };
=20
@@ -487,18 +489,16 @@ pub fn new<'bound, E>(
=20
         // INVARIANT: The device will remain registered until `auxiliary_d=
evice_delete()` is
         // called, which happens in `Self::drop()`.
-        let reg =3D Self {
+        Ok(Self {
             // SAFETY: `adev` is guaranteed to be non-null, since the `KBo=
x` was allocated
             // successfully.
             adev: unsafe { NonNull::new_unchecked(adev) },
-            _data: PhantomData,
-        };
-
-        Devres::new::<core::convert::Infallible>(parent, reg)
+            _phantom: PhantomData,
+        })
     }
 }
=20
-impl<F: ForLt> Drop for Registration<F> {
+impl<F: ForLt> Drop for Registration<'_, F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` i=
s a valid registered
         // `struct auxiliary_device`.
@@ -520,7 +520,7 @@ fn drop(&mut self) {
 }
=20
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released=
 from any thread.
-unsafe impl<F: ForLt> Send for Registration<F> where for<'a> F::Of<'a>: Se=
nd {}
+unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>=
: Send {}
=20
 // SAFETY: `Registration` does not expose any methods or fields that need =
synchronization.
-unsafe impl<F: ForLt> Sync for Registration<F> where for<'a> F::Of<'a>: Se=
nd {}
+unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>=
: Send {}
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driv=
er_auxiliary.rs
index 84d18bbfafc5..efb4d97b416b 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -10,7 +10,6 @@
         Bound,
         Core, //
     },
-    devres::Devres,
     driver,
     pci,
     prelude::*,
@@ -58,29 +57,29 @@ struct Data<'bound> {
 }
=20
 #[allow(clippy::type_complexity)]
-struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
-    _reg1: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
+struct ParentDriver<'bound> {
+    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
+    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
 }
=20
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <ParentDriver as pci::Driver>::IdInfo,
+    <ParentDriver<'_> as pci::Driver>::IdInfo,
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
=20
-impl pci::Driver for ParentDriver {
+impl pci::Driver for ParentDriver<'_> {
     type IdInfo =3D ();
-    type Data<'bound> =3D Self;
+    type Data<'bound> =3D ParentDriver<'bound>;
=20
     const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
=20
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
-        Ok(Self {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        Ok(ParentDriver {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
                 AUXILIARY_NAME,
@@ -105,7 +104,7 @@ fn probe<'bound>(
     }
 }
=20
-impl ParentDriver {
+impl ParentDriver<'_> {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let data =3D adev.registration_data::<ForLt!(Data<'_>)>()?;
         let pdev =3D data.parent;
@@ -131,7 +130,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
 #[pin_data]
 struct SampleModule {
     #[pin]
-    _pci_driver: driver::Registration<pci::Adapter<ParentDriver>>,
+    _pci_driver: driver::Registration<pci::Adapter<ParentDriver<'static>>>=
,
     #[pin]
     _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver>>=
,
 }
