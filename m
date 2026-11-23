Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852A606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matt3o12.de header.i=@matt3o12.de header.a=rsa-sha256 header.s=securedbylima-20230709 header.b=MQ7zupQl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5FF10E82A;
	Mon, 23 Nov 2026 20:39:59 +0000 (UTC)
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC7610EB73
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:39:52 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1795466390;
 bh=XALVTHWMsgu1a0FxagPF6ryKmWly2pkY8mk75dxeV4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MQ7zupQleLZOjBgocgFfXMWGtGg9t/Q0IYuYF4fU4bBMU4QixbgpQmT0gLWAzfJE8
 7Z5KDnFZ/6RrjZ7AKIY53W393WoFqDZOCbOtLlVxdhVH3A4gWDMQntHZofFJm33ey0
 phRPbppo8PplLK4gLTQ8O37fsrzPm4dl9FkPR+SDvYWowC7MYwknGb0pvX1hJvJInV
 DUZVJJReacAQvt86SCbulwtykCQMm5Yhu5GokSORQpnE5TzxVYosJkQv4bV02cjQKn
 NdqorE9EDdzKH8ipR96f5vZNi2hdQgjG3h31nZX8pBh/RqTF9amkqU/O8YERZ0tlNy
 ehBul6c5iBNag==
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Matteo Kloiber <kernel@matt3o12.de>
Subject: [RFC PATCH 1/3] rust: pci, platform: pass InitTokens to probe()
Date: Mon, 23 Nov 2026 21:39:24 +0100
Message-ID: <20261123203926.1787169-2-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261123203926.1787169-1-kernel@matt3o12.de>
References: <20261123203926.1787169-1-kernel@matt3o12.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some capabilities should only be available to a driver while it binds
to a device, for example configuring the device for DMA before any
memory is allocated or mapped. A probe-time token lets the type system
enforce such ordering, but adding a new argument to probe() for every
token would touch every driver each time.

Add an InitTokens struct to the PCI and platform buses and pass it to
Driver::probe(). Buses add new tokens as fields of this struct. It is
marked #[non_exhaustive], so drivers destructure it with `..` and
adding tokens later does not break them.

The struct carries no tokens yet. Update all drivers, samples and
doctests to accept and ignore it.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com
Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
---
 drivers/cpufreq/rcpufreq_dt.rs        |  1 +
 drivers/gpu/drm/tyr/driver.rs         |  1 +
 drivers/gpu/nova-core/driver.rs       |  1 +
 drivers/pwm/pwm_th1520.rs             |  1 +
 rust/kernel/cpufreq.rs                |  1 +
 rust/kernel/io/mem.rs                 |  2 ++
 rust/kernel/pci.rs                    | 10 +++++++++-
 rust/kernel/platform.rs               | 10 +++++++++-
 samples/rust/rust_debugfs.rs          |  1 +
 samples/rust/rust_dma.rs              |  1 +
 samples/rust/rust_driver_auxiliary.rs |  1 +
 samples/rust/rust_driver_pci.rs       |  1 +
 samples/rust/rust_driver_platform.rs  |  1 +
 samples/rust/rust_i2c_client.rs       |  1 +
 samples/rust/rust_soc.rs              |  1 +
 15 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 2b1f18b7a1e7..a6e314f4d809 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -212,6 +212,7 @@ impl platform::Driver for CPUFreqDTDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 557f2ec0a767..7650ade4ad72 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -119,6 +119,7 @@ impl platform::Driver for TyrPlatformDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d6bc972d47c7..e42987e35846 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -100,6 +100,7 @@ impl pci::Driver for NovaCoreDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
+        _tokens: pci::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 728993998446..2486333c4a91 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -316,6 +316,7 @@ impl platform::Driver for Th1520PwmPlatformDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b75d692846a2..0032264fe72c 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -916,6 +916,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 ///     fn probe<'bound>(
 ///         pdev: &'bound platform::Device<Core<'_>>,
+///         _tokens: platform::InitTokens<'bound>,
 ///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         cpufreq::Registration::<SampleDriver>::new_foreign_owned(pdev.as_ref())?;
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 32a919099dcd..50dedd32d1a7 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -70,6 +70,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///
     ///    fn probe<'bound>(
     ///       pdev: &'bound platform::Device<Core<'_>>,
+    ///       _tokens: platform::InitTokens<'bound>,
     ///       info: Option<&'bound Self::IdInfo>,
     ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
@@ -130,6 +131,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(self) -> Result<ExclusiveIoMem<'
     ///
     ///    fn probe<'bound>(
     ///       pdev: &'bound platform::Device<Core<'_>>,
+    ///       _tokens: platform::InitTokens<'bound>,
     ///       info: Option<&'bound Self::IdInfo>,
     ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..fdb2934eda0d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -128,7 +128,7 @@ extern "C" fn probe_callback(
         let info = unsafe { id.info_unchecked_opt::<T::IdInfo>() };
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let data = T::probe(pdev, InitTokens { _p: PhantomData }, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -261,6 +261,12 @@ macro_rules! pci_device_table {
     };
 }
 
+/// Initialization tokens passed to a PCI driver's [`Driver::probe`] callback.
+#[non_exhaustive]
+pub struct InitTokens<'bound> {
+    _p: PhantomData<&'bound ()>,
+}
+
 /// The PCI driver trait.
 ///
 /// # Examples
@@ -288,6 +294,7 @@ macro_rules! pci_device_table {
 ///
 ///     fn probe<'bound>(
 ///         _pdev: &'bound pci::Device<Core<'_>>,
+///         _tokens: pci::InitTokens<'bound>,
 ///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
@@ -317,6 +324,7 @@ pub trait Driver {
     /// attempt to initialize the device here.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
+        tokens: InitTokens<'bound>,
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ac0a012ae1bb..a7b33e229a30 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -104,7 +104,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         let info = unsafe { <Self as driver::Adapter>::id_info(pdev.as_ref()) };
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let data = T::probe(pdev, InitTokens { _p: PhantomData }, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -159,6 +159,12 @@ macro_rules! module_platform_driver {
     };
 }
 
+/// Initialization tokens passed to a platform driver's [`Driver::probe`] callback.
+#[non_exhaustive]
+pub struct InitTokens<'bound> {
+    _p: PhantomData<&'bound ()>,
+}
+
 /// The platform driver trait.
 ///
 /// Drivers must implement this trait in order to get a platform driver registered.
@@ -199,6 +205,7 @@ macro_rules! module_platform_driver {
 ///
 ///     fn probe<'bound>(
 ///         _pdev: &'bound platform::Device<Core<'_>>,
+///         _tokens: platform::InitTokens<'bound>,
 ///         _id_info: Option<&'bound Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
@@ -229,6 +236,7 @@ pub trait Driver {
     /// Implementers should attempt to initialize the device here.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
+        tokens: InitTokens<'bound>,
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 77c19a437695..d0cc2b624835 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -122,6 +122,7 @@ impl platform::Driver for RustDebugFs {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         RustDebugFs::new(pdev).pin_chain(|this| {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index ffb693544673..25ce01f2d224 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -76,6 +76,7 @@ impl pci::Driver for DmaSampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
+        _tokens: pci::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 0bee16faecc6..20d2b6d0fb77 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -98,6 +98,7 @@ impl pci::Driver for ParentDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
+        _tokens: pci::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         try_pin_init!(ParentData {
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 13b035a95756..f658efcd11bf 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -147,6 +147,7 @@ impl pci::Driver for SampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
+        _tokens: pci::InitTokens<'bound>,
         info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let vendor = pdev.vendor_id();
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 710145b3605a..80b08d32435f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -105,6 +105,7 @@ impl platform::Driver for SampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index c8a23875ef5b..93b207699860 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -110,6 +110,7 @@ impl platform::Driver for SampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<device::Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index f5e5f2f9adf7..f54c173fed94 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -41,6 +41,7 @@ impl platform::Driver for SampleSocDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
+        _tokens: platform::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self, Error> + 'bound {
         dev_dbg!(pdev, "Probe Rust SoC driver sample.\n");
-- 
2.51.2

