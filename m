Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7D606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQ2rz7zB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BD910F7CE;
	Tue, 10 Nov 2026 15:50:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1252510F7DC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60D0563A3F;
 Tue, 10 Nov 2026 15:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8415B1F0089F;
 Tue, 10 Nov 2026 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794325842;
 bh=ZUw5z1eM2NFz4khMwpmWruXLJlm01GUhS15bXvEkmbo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=nQ2rz7zB4Y2lnwHdGpoFBI2xx+VUgVa9x2d6GcUxdt0hXimnKhgOUKkngq6GMMTzr
 PP3dEryfLHyVApZGqRbnfZ3uymSIr5eGTzvBWbukshagJPyXejDNrdOPHlzIGx7YV7
 OgurmVm9QE6xPP3UKwI4tf5974MX/9Q9C7TLhXVtBl0MdEbW2GxqBYFzrcPPQ6Sn1L
 I5OUWbnEMjodgQOItGQ8fD5KFPsvHktQw8ypOPTF8sSrdUkUWS+63KKX6TWuEIck0s
 c3QX+fT5jkTA1FnhYnjEPnZI26Zc137tm2EX1Xo8xINBwYzqxbV3PRt++95VlLWggF
 sJkNE57DfdnOQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 16:50:31 +0100
Message-Id: <DMRNF7IZQ1YI.1MRPH47QJC9XC@kernel.org>
Subject: Re: [PATCH v2 11/12] gpu: nova-core: publish typed SR-IOV PF APIs
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-12-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-12-xinmengs@nvidia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index dc6febeee65..99beab18987 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -35,6 +35,12 @@
>      }, //
>  };
> =20
> +#[cfg(CONFIG_PCI_IOV)]
> +use kernel::types::ForLt;
> +
> +#[cfg(CONFIG_PCI_IOV)]
> +use crate::vgpu::vgpu_api::NovaCoreVfApi;
> +
>  /// Counter for generating unique auxiliary device IDs.
>  static AUXILIARY_ID_COUNTER: Atomic<u32> =3D Atomic::new(0);
> =20
> @@ -42,6 +48,10 @@
>  pub(crate) struct NovaCore<'bound> {
>      /// Firmware-control registration.
>      _fwctl: fwctl::Registration<'bound, NovaCoreFwCtl>,
> +    #[cfg(CONFIG_PCI_IOV)]
> +    #[allow(clippy::type_complexity)]
> +    #[pin]
> +    _vf_registration: pci::VfRegistration<'bound, ForLt!(NovaCoreVfApi<'=
_>)>,
>      #[pin]
>      pub(crate) gpu: Gpu<'bound>,
>      bar: pci::Bar<'bound, BAR0_SIZE>,
> @@ -114,6 +124,11 @@ fn probe<'bound>(
>          pin_init::pin_init_scope(move || {
>              dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> =20
> +            #[cfg(CONFIG_PCI_IOV)]
> +            if pdev.is_virtfn() {
> +                return Err(ENODEV);
> +            }

There's a lot of config guards, but we should actually stub the correspondi=
ng
functions, so they work regardless.

I suggest something like the diff in [2], that should be worked into the IO=
V
series.

> +
>              pdev.enable_device_mem()?;
>              pdev.set_master();
> =20
> @@ -144,6 +159,18 @@ fn probe<'bound>(
>                  // Run optional GPU selftests.
>                  #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
>                  _: { gpu.run_selftests(pdev) },
> +                #[cfg(CONFIG_PCI_IOV)]
> +                _vf_registration <- {
> +                    // SAFETY: `gpu` is initialized at its pinned addres=
s and
> +                    // outlives the registration and its borrowed API da=
ta.
> +                    let gpu =3D unsafe { &(*this.as_ptr()).gpu };

You can use pin-init self-reference for this, see also [1].

> +                    let api =3D NovaCoreVfApi::new(gpu, pdev);
> +                    // SAFETY: Probe has exclusive access to the registr=
ation
> +                    // slot and no VFs are enabled before successful pro=
be. The
> +                    // registration keeps PF services available until VF=
 removal
> +                    // completes and is dropped before its borrowed GPU =
resources.

VFs not being enabled before successful probe is not a safety requirement, =
the
API does ensure this.

The only requirement is to store it in the driver's bus device private data=
.

> +                    unsafe { pci::VfRegistration::new(pdev, Ok(api)) }
> +                },
>                  _reg: auxiliary::Registration::new(
>                      pdev.as_ref(),
>                      c"nova-drm",
> @@ -176,4 +203,24 @@ fn probe<'bound>(
>              }))
>          })
>      }
> +
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_enable<'bound, 'callback>(
> +        _dev: &'bound pci::Device<Core<'_>>,
> +        _this: Pin<&Self::Data<'bound>>,
> +        token: pci::SriovEnable<'callback>,
> +    ) -> Result<pci::SriovEnabled<'callback>> {
> +        let num_vfs =3D token.num_vfs();
> +        token.enable(num_vfs)

NIT: Maybe provide a pci::SriovEnable::enable_all() helper for this in the =
core code.

> +    }
> +
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_disable<'bound>(
> +        _dev: &'bound pci::Device<Core<'_>>,
> +        _this: Pin<&Self::Data<'bound>>,
> +        token: pci::SriovDisable<'_>,
> +    ) -> Result {
> +        token.disable();
> +        Ok(())
> +    }
>  }

[1] https://lore.kernel.org/nova-gpu/20261110152746.140351-1-dakr@kernel.or=
g/

[2] Diff for IOV series

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a8540f90b13c..0185baa7aacc 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -41,6 +41,27 @@ __rust_helper u32 rust_helper_pci_ext_cap_next(u32 heade=
r)
 }

 #ifndef CONFIG_PCI_IOV
+__rust_helper int rust_helper_pci_iov_vf_id(struct pci_dev *pdev)
+{
+	return pci_iov_vf_id(pdev);
+}
+
+__rust_helper int rust_helper_pci_enable_sriov(struct pci_dev *pdev,
+					    int nr_virtfn)
+{
+	return pci_enable_sriov(pdev, nr_virtfn);
+}
+
+__rust_helper void rust_helper_pci_disable_sriov(struct pci_dev *pdev)
+{
+	pci_disable_sriov(pdev);
+}
+
+__rust_helper int rust_helper_pci_num_vf(struct pci_dev *pdev)
+{
+	return pci_num_vf(pdev);
+}
+
 __rust_helper unsigned int
 rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
 {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0bcbf73bb363..dcdef0eb1ae2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -36,7 +36,6 @@
 mod cap;
 mod id;
 mod io;
-#[cfg(CONFIG_PCI_IOV)]
 mod iov;
 mod irq;

@@ -60,7 +59,6 @@
     Extended,
     Normal, //
 };
-#[cfg(CONFIG_PCI_IOV)]
 pub use self::iov::{
     SriovDisable,
     SriovEnable,
@@ -96,7 +94,6 @@ unsafe fn register(
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result {
-        #[cfg(CONFIG_PCI_IOV)]
         build_assert!(
             T::HAS_SRIOV_ENABLE =3D=3D T::HAS_SRIOV_DISABLE,
             "PCI drivers must implement both sriov_enable and sriov_disabl=
e"
@@ -116,7 +113,6 @@ unsafe fn register(
             if let Some(ops) =3D T::PM_OPS {
                 (*pdrv.get()).driver.pm =3D ops.raw;
             }
-            #[cfg(CONFIG_PCI_IOV)]
             if T::HAS_SRIOV_ENABLE {
                 (*pdrv.get()).sriov_configure =3D Some(Self::sriov_configu=
re_callback);
             }
@@ -592,6 +588,8 @@ fn runtime_resume<'bound>(dev: &Device<device::Bound>, =
this: Pin<&Self::Data<'bo

     /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
     ///
+    /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
+    ///
     /// Called when userspace writes a nonzero VF count to `sriov_numvfs`.=
 The token carries the
     /// requested count and permission to enable VFs on this PF. Return th=
e guard obtained from
     /// [`SriovEnable::enable()`] after completing setup; dropping it roll=
s back the enable.
@@ -624,7 +622,6 @@ fn runtime_resume<'bound>(dev: &Device<device::Bound>, =
this: Pin<&Self::Data<'bo
     ///     Ok(enabled)
     /// }
     /// ```
-    #[cfg(CONFIG_PCI_IOV)]
     fn sriov_enable<'a>(
         dev: &'a Device<device::Core<'_>>,
         data: Pin<&Self::Data<'a>>,
@@ -636,6 +633,8 @@ fn sriov_enable<'a>(

     /// Disables all VFs of a PF in response to a userspace request.
     ///
+    /// This callback is only invoked when `CONFIG_PCI_IOV` is enabled.
+    ///
     /// Called when userspace writes zero to `sriov_numvfs`. Call [`SriovD=
isable::disable()`]
     /// while resources used by VF drivers are still available. Returning =
an error before calling
     /// it leaves the VFs enabled. Returning success requires that all VFs=
 have been disabled.
@@ -661,7 +660,6 @@ fn sriov_enable<'a>(
     ///     Ok(())
     /// }
     /// ```
-    #[cfg(CONFIG_PCI_IOV)]
     fn sriov_disable<'a>(
         dev: &'a Device<device::Core<'_>>,
         data: Pin<&Self::Data<'a>>,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index c5b6fd31d1e4..abba5eeaa49b 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -23,12 +23,50 @@
 };
 use core::{
     any::TypeId,
+    ffi::c_void,
     marker::PhantomPinned,
     mem::ManuallyDrop, //
 };

+/// Returns the PF's registration pointer, or null when SR-IOV is disabled=
.
+///
+/// # Safety
+///
+/// `pdev` must point to a live PCI device. The caller must exclude concur=
rent changes to its
+/// registration pointer.
+unsafe fn vf_registration_data_ptr(pdev: *mut bindings::pci_dev) -> *mut c=
_void {
+    #[cfg(CONFIG_PCI_IOV)]
+    {
+        // SAFETY: The caller guarantees the device's validity and exclude=
s concurrent changes.
+        unsafe { (*pdev).vf_registration_data_rust }
+    }
+    #[cfg(not(CONFIG_PCI_IOV))]
+    {
+        let _ =3D pdev;
+        core::ptr::null_mut()
+    }
+}
+
+/// Updates the PF's registration pointer, doing nothing when SR-IOV is di=
sabled.
+///
+/// # Safety
+///
+/// `pdev` must point to a live PCI device. The caller must exclude concur=
rent access to its
+/// registration pointer and uphold the invariants of any published regist=
ration data.
+unsafe fn set_vf_registration_data_ptr(pdev: *mut bindings::pci_dev, data:=
 *mut c_void) {
+    #[cfg(CONFIG_PCI_IOV)]
+    // SAFETY: The caller guarantees the device's validity and exclusive a=
ccess to its slot.
+    unsafe {
+        (*pdev).vf_registration_data_rust =3D data;
+    }
+    #[cfg(not(CONFIG_PCI_IOV))]
+    let _ =3D (pdev, data);
+}
+
 impl Device<device::Core<'_>> {
     /// Returns the number of Virtual Functions (VF) enabled for a Physica=
l Function (PF).
+    ///
+    /// Returns zero when `CONFIG_PCI_IOV` is disabled.
     #[inline]
     pub fn num_vf(&self) -> u16 {
         // SAFETY: `self.as_raw()` is valid and this call runs in the PCI =
core callback context.
@@ -110,7 +148,7 @@ pub fn enable(self, num_vfs: u16) -> Result<SriovEnable=
d<'a>> {

         // SAFETY: The PF's driver data and registration remain installed =
throughout this callback.
         // The registration owns final VF teardown after the enable guard =
is disarmed.
-        if unsafe { (*self.pdev.as_raw()).vf_registration_data_rust }.is_n=
ull() {
+        if unsafe { vf_registration_data_ptr(self.pdev.as_raw()) }.is_null=
() {
             return Err(ENODEV);
         }

@@ -225,6 +263,9 @@ fn new<E>(data: impl PinInit<F::Of<'a>, E>) -> impl Pin=
Init<Self, E> {
 /// [`Device::vf_registration_data_with()`] and [`Device::vf_registration_=
data()`].
 ///
 /// Drop disables SR-IOV before clearing the registration pointer and rele=
asing the data.
+///
+/// When `CONFIG_PCI_IOV` is disabled, the registration still initializes,=
 pins and owns its data,
+/// but does not publish it to VF drivers.
 #[pin_data(PinnedDrop)]
 pub struct VfRegistration<'a, F: ForLt + 'static> {
     pdev: &'a Device<device::Bound>,
@@ -262,7 +303,7 @@ pub unsafe fn new<'core, I>(
                     return Err(EBUSY);
                 }
                 // SAFETY: The core callback serializes changes to this de=
vice's registration.
-                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.=
is_null() {
+                if !unsafe { vf_registration_data_ptr(pdev.as_raw()) }.is_=
null() {
                     return Err(EBUSY);
                 }
             },
@@ -272,15 +313,17 @@ pub unsafe fn new<'core, I>(
             _: {
                 // The data initializer may have registered another object=
 on this device.
                 // SAFETY: The captured core context still serializes regi=
stration changes.
-                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust }.=
is_null() {
+                if !unsafe { vf_registration_data_ptr(pdev.as_raw()) }.is_=
null() {
                     return Err(EBUSY);
                 }

                 // SAFETY: The data is initialized and pinned, the slot is=
 unoccupied, and
                 // no VF can access it yet. No fallible work follows publi=
cation.
                 unsafe {
-                    (*pdev.as_raw()).vf_registration_data_rust =3D
-                        core::ptr::from_ref(inner.as_ref().get_ref()).cast=
_mut().cast();
+                    set_vf_registration_data_ptr(
+                        pdev.as_raw(),
+                        core::ptr::from_ref(inner.as_ref().get_ref()).cast=
_mut().cast(),
+                    );
                 }
             },
         })
@@ -297,7 +340,7 @@ fn drop(self: Pin<&mut Self>) {

         // SAFETY: The device is valid and all VF remove callbacks have co=
mpleted, so no VF
         // can access the registration pointer. The data remains alive unt=
il this returns.
-        unsafe { (*self.pdev.as_raw()).vf_registration_data_rust =3D core:=
:ptr::null_mut() };
+        unsafe { set_vf_registration_data_ptr(self.pdev.as_raw(), core::pt=
r::null_mut()) };
     }
 }

@@ -310,6 +353,8 @@ unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> wh=
ere for<'a> F::Of<'a>: Se

 impl Device<device::Bound> {
     /// Return the zero-based VF index within its PF, or an error for a no=
n-VF device.
+    ///
+    /// Returns [`ENOSYS`] when `CONFIG_PCI_IOV` is disabled.
     pub fn vf_id(&self) -> Result<u32> {
         // SAFETY: `self.as_raw()` points to a live PCI device; the helper=
 checks VF membership.
         let id =3D unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
@@ -324,6 +369,7 @@ pub fn vf_id(&self) -> Result<u32> {
     ///
     /// The data lifetime must be hidden behind a higher-ranked closure in=
dependently of the
     /// reference lifetime, or `F` must be covariant in its encoded lifeti=
me.
+    #[cfg(CONFIG_PCI_IOV)]
     unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Re=
sult<Pin<&F::Of<'_>>> {
         if !self.is_virtfn() {
             return Err(ENODEV);
@@ -333,7 +379,7 @@ unsafe fn vf_registration_data_pinned<F: ForLt + 'stati=
c>(&self) -> Result<Pin<&
         // VF removal completes, and the PF keeps the registration install=
ed until then.
         let ptr =3D unsafe {
             let pf =3D (*self.as_raw()).__bindgen_anon_1.physfn;
-            (*pf).vf_registration_data_rust
+            vf_registration_data_ptr(pf)
         };

         if ptr.is_null() {
@@ -360,11 +406,23 @@ unsafe fn vf_registration_data_pinned<F: ForLt + 'sta=
tic>(&self) -> Result<Pin<&
         Ok(unsafe { Pin::new_unchecked(&*data_ptr) })
     }

+    /// Returns [`ENODEV`] because no VF registration can be published.
+    ///
+    /// # Safety
+    ///
+    /// The data lifetime must be hidden behind a higher-ranked closure in=
dependently of the
+    /// reference lifetime, or `F` must be covariant in its encoded lifeti=
me.
+    #[cfg(not(CONFIG_PCI_IOV))]
+    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> Re=
sult<Pin<&F::Of<'_>>> {
+        Err(ENODEV)
+    }
+
     /// Access the VF registration data through a closure with an HRTB lif=
etime.
     ///
     /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Retur=
ns
     /// [`ENODEV`] if this is not a VF or no data was registered,
     /// or [`EINVAL`] if `F` does not match the type registered by the PF.
+    /// Returns [`ENODEV`] when `CONFIG_PCI_IOV` is disabled.
     ///
     /// The reference is borrowed from this VF, while the registration dat=
a's lifetime remains
     /// abstract so the closure cannot store shorter-lived references in i=
nvariant data.
