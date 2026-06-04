Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60637CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BB810E0FB;
	Thu,  4 Jun 2026 13:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SiEFj0cx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD24610E0FB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:12:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42D8E6024D;
 Thu,  4 Jun 2026 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5331F00893;
 Thu,  4 Jun 2026 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780578776;
 bh=qjHjZ0FE5DnNYPjajht26SMXxfaRKL/yW63UwXhfEyE=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=SiEFj0cxAUAur+XCpvpwapGl8CpB7ZP4AU0BqDowV0fVDBBjwuhsM9BUFvrSTN31V
 C4iBItK9mKsuTUxeid9EncaJIqzmyyR42fX99Kaght68YxcWN2XuYkEZLmvo0IbR9f
 FUVQG8UwOI3ED2rMzCramjBD6wObD5CUXiIs/XUYaukRAwvXYdYnElddJrsh/TkEKY
 eJWuucHAULtYOuACu7WX79fjUU/SYVKXTsZmDUFXbMF0esM+QhiRc/w8wioMUfdv8I
 O1dVAptnMfRgC5rfSaRFs5bjgLo6ztN3f5MUtNkE1jXdaRhwvlHtHtlsNVYPoWIUh/
 DTjkR/Ob4VOjw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 15:12:50 +0200
Message-Id: <DJ0AHUXK4V11.8FGPD9P9NVE4@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/tyr: move probe resources into registration data
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <laura.nao@collabora.com>, <boris.brezillon@collabora.com>,
 <samitolvanen@google.com>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
References: <20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com>
In-Reply-To: <20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com>
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

On Thu Jun 4, 2026 at 1:19 AM CEST, Deborah Brouwer wrote:
> @@ -59,21 +61,36 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
>  }
> =20
>  #[pin_data]
> -pub(crate) struct TyrDrmDeviceData {
> +pub(crate) struct TyrDrmDeviceData;
> +
> +/// Resources kept alive by the DRM registration.
> +#[pin_data]
> +pub(crate) struct TyrDrmRegistrationData<'bound> {
> +    /// Parent platform device.
>      pub(crate) pdev: ARef<platform::Device>,

This can just be &'bound platform::Device, or even &'bound platform::Device=
<Bound>.

> =20
> +    /// Firmware sections.
> +    pub(crate) fw: Arc<Firmware<'bound>>,

This doesn't seem like it needs to be reference counted; at least from the
context I have from this patch.

> +
>      #[pin]
>      clks: Mutex<Clocks>,
> =20
>      #[pin]
>      regulators: Mutex<Regulators>,
> =20
> +    /// GPU MMIO register mapping.
> +    pub(crate) iomem: Arc<IoMem<'bound>>,

This may not need to be reference counted either; at least eventually.

It seems like this reference count only exists, so you are able to also sto=
re it
in struct Firmware.

This goes away once pin-init has the self-referential feature.

If there is no other reason for this reference count, you could temporarily=
 do
what we do in nova-core [1] and obtain a &'bound IoMem<'bound> reference to
store in struct Firmware unsafely.

[1] https://lore.kernel.org/nova-gpu/20260525225838.276108-2-dakr@kernel.or=
g/

> +
>      /// Some information on the GPU.
>      ///
>      /// This is mainly queried by userspace, i.e.: Mesa.
>      pub(crate) gpu_info: GpuInfo,
>  }
> =20
> +impl ForLt for TyrDrmRegistrationData<'static> {
> +    type Of<'bound> =3D TyrDrmRegistrationData<'bound>;
> +}

This isn't wrong, but the intention is to use the ForLt! macro for this.

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index acf5080a5467..694958509da7 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -87,9 +87,6 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
     pub(crate) gpu_info: GpuInfo,
 }
=20
-impl ForLt for TyrDrmRegistrationData<'static> {
-    type Of<'bound> =3D TyrDrmRegistrationData<'bound>;
-}
=20
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
     iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
@@ -221,7 +218,7 @@ fn drop(self: Pin<&mut Self>) {}
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data =3D TyrDrmDeviceData;
-    type RegistrationData =3D TyrDrmRegistrationData<'static>;
+    type RegistrationData =3D ForLt!(TyrDrmRegistrationData<'_>);
     type File =3D TyrDrmFileData;
     type Object<R: drm::DeviceContext> =3D drm::gem::shmem::Object<BoData,=
 R>;
     type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;

> +
>  fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
>      iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> =20
> @@ -119,7 +136,7 @@ fn probe<'bound>(
>          let sram_regulator =3D Regulator::<regulator::Enabled>::get(pdev=
.as_ref(), c"sram")?;
> =20
>          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem =3D request.iomap_sized::<SZ_2M>()?;
> +        let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERN=
EL)?;
> =20
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> @@ -137,8 +154,23 @@ fn probe<'bound>(
> =20
>          let platform: ARef<platform::Device> =3D pdev.into();
> =20
> -        let data =3D try_pin_init!(TyrDrmDeviceData {
> +        let dev_data =3D try_pin_init!(TyrDrmDeviceData {});
> +
> +        let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(p=
dev, dev_data)?;

Keeping TyrDrmDeviceData and calling the above try_pin_init! seems unnecess=
ary;
you can just pass Ok(()) to drm::UnregisteredDevice::new().

> +
> +        let mmu =3D Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
> +
> +        let firmware =3D Firmware::new(
> +            pdev,
> +            iomem.clone(),
> +            &unreg_dev,
> +            mmu.as_arc_borrow(),
> +            &gpu_info,
> +        )?;
> +
> +        let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
>                  pdev: platform.clone(),
> +                fw: firmware,
>                  clks <- new_mutex!(Clocks {
>                      core: core_clk,
>                      stacks: stacks_clk,
> @@ -148,11 +180,16 @@ fn probe<'bound>(
>                      _mali: mali_regulator,
>                      _sram: sram_regulator,
>                  }),
> +                iomem,
>                  gpu_info,
>          });
> =20
> -        let tdev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, =
data)?;
> -        let reg =3D drm::Registration::new(pdev.as_ref(), tdev, (), 0)?;
> +        // SAFETY: `reg` is stored in the platform driver data and is no=
t leaked or
> +        // forgotten, so it is dropped before the `'bound` registration =
data can become
> +        // invalid.
> +        let reg =3D unsafe {
> +            drm::driver::Registration::new_with_lt(pdev.as_ref(), unreg_=
dev, reg_data, 0)?

This is re-exported as drm::Registration.

> +        };
