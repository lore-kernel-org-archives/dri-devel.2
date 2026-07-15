Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944D7C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15AF10E21D;
	Wed, 15 Jul 2026 21:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aT84rZAH";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D1010E21D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 21:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784152298; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c8IJ1Z+ISdPolbAxctlW0ByV4k37S1BF16cRomwXt6z6lpicLxT7ECLN71zGJxrDp9UmkA1elZLnwJPR9KtHKyZDBaIjJdAvIA0qADQkIfxkafyhgA5FpCRcdUpzuGDQU6Rdk7lVm/U9iwnfcsMOxhKexam6qPYdl1RJ3O4SQA4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784152298;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=geA4Xgu+0y0toezP6eG/IwF1SEgMkg+3hbLUWNRXmls=; 
 b=E4s3kf8ym62NTs+fqKGiu9jF2GAbsLWnbp8LmDwlSR5pLjSbpZxSbEOLrE3zp5i3cYD62lIZF/aenxjQ3x0x5CbYImfUx4UbjTC6NvuhyySBLhoCrP5CJ6lH8emIRwWbLPA0rWMjf259N7Qu2ccT3YjZKvoSHQSY9VRfiXB2MDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784152298; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=geA4Xgu+0y0toezP6eG/IwF1SEgMkg+3hbLUWNRXmls=;
 b=aT84rZAHXsDxBEHil8/IYFbC8g1oa48DPi5MbSA0L9Xmp6yLUh7hX1opb6y/sEON
 I5WrNGkmC+qmTJvggMoXWuLen0SsKU7PjUNNLCycCpI/r3Ij9Khka320q9tH/1Zgfdz
 A1R8K2R4M8cUePDLj9tIlQX+KtYRm3jYp5XhZW24=
Received: by mx.zohomail.com with SMTPS id 1784152296224659.8358740201076;
 Wed, 15 Jul 2026 14:51:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 1/7] drm/tyr: add resources to RegistrationData
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260709-fw-boot-b4-v6-1-ca391e1a4108@collabora.com>
Date: Wed, 15 Jul 2026 18:51:17 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, acourbot@nvidia.com, alvin.sun@linux.dev,
 laura.nao@collabora.com, work@onurozkan.dev, beata.michalska@arm.com,
 steven.price@arm.com, lyude@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D445C5B-6C4D-49CE-98B2-3BCD68014626@collabora.com>
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-1-ca391e1a4108@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 9 Jul 2026, at 18:36, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> Currently Tyr is not storing any resources in its drm::Driver
> RegistrationData.
>=20
> Move Tyr's device-private resources and gpu information from
> drm::Driver::Data to drm::Driver::RegistrationData. This allows Tyr to
> access this data safely within the lifetime of its binding to its =
parent
> platform device and while registered with userspace.
>=20
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/driver.rs | 42 =
+++++++++++++++++++++---------------------
> drivers/gpu/drm/tyr/file.rs   | 11 ++++++-----
> 2 files changed, 27 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs =
b/drivers/gpu/drm/tyr/driver.rs
> index 8348c6cd3929..46ce5c41e310 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -6,6 +6,7 @@
>         OptionalClk, //
>     },
>     device::{
> +        Bound,
>         Core,
>         Device,
>         DeviceContext, //
> @@ -27,10 +28,7 @@
>     regulator,
>     regulator::Regulator,
>     sizes::SZ_2M,
> -    sync::{
> -        aref::ARef,
> -        Mutex, //
> -    },
> +    sync::Mutex,
>     time, //
> };
>=20
> @@ -53,13 +51,17 @@
>=20
> #[pin_data(PinnedDrop)]
> pub(crate) struct TyrPlatformDriverData<'bound> {
> -    _device: ARef<TyrDrmDevice>,
>     _reg: drm::Registration<'bound, TyrDrmDriver>,
> }
>=20
> +/// Data owned by the DRM [`Registration`].
> +///
> +/// This data can have references tied to the parent platform device =
binding scope
> +/// and is accessible only while the DRM device is registered with =
userspace.
> #[pin_data]
> -pub(crate) struct TyrDrmDeviceData {
> -    pub(crate) pdev: ARef<platform::Device>,
> +pub(crate) struct TyrDrmRegistrationData<'bound> {
> +    /// Parent platform device.
> +    pub(crate) pdev: &'bound platform::Device<Bound>,
>=20
>     #[pin]
>     clks: Mutex<Clocks>,
> @@ -67,9 +69,10 @@ pub(crate) struct TyrDrmDeviceData {
>     #[pin]
>     regulators: Mutex<Regulators>,
>=20
> -    /// Some information on the GPU.
> -    ///
> -    /// This is mainly queried by userspace, i.e.: Mesa.
> +    /// GPU MMIO register mapping.
> +    pub(crate) iomem: IoMem<'bound>,
> +
> +    /// GPU information read from hardware during probe.
>     pub(crate) gpu_info: GpuInfo,
> }
>=20
> @@ -134,10 +137,10 @@ fn probe<'bound>(
>         // other threads of execution.
>         unsafe { =
pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
>=20
> -        let platform: ARef<platform::Device> =3D pdev.into();
> +        let unreg_dev =3D =
drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
>=20
> -        let data =3D try_pin_init!(TyrDrmDeviceData {
> -                pdev: platform.clone(),
> +        let reg_data =3D try_pin_init!(TyrDrmRegistrationData {
> +                pdev,
>                 clks <- new_mutex!(Clocks {
>                     core: core_clk,
>                     stacks: stacks_clk,
> @@ -147,18 +150,15 @@ fn probe<'bound>(
>                     _mali: mali_regulator,
>                     _sram: sram_regulator,
>                 }),
> +                iomem,
>                 gpu_info,
>         });
>=20
> -        let tdev =3D =
drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
>         // SAFETY: `reg` is stored in `TyrPlatformDriverData` and =
dropped when the driver is
>         // unbound; it is never forgotten.
> -        let reg =3D unsafe { drm::Registration::new(pdev.as_ref(), =
tdev, (), 0)? };
> +        let reg =3D unsafe { drm::Registration::new(pdev.as_ref(), =
unreg_dev, reg_data, 0)? };
>=20
> -        let driver =3D TyrPlatformDriverData {
> -            _device: reg.device().into(),
> -            _reg: reg,
> -        };
> +        let driver =3D TyrPlatformDriverData { _reg: reg };
>=20
>         // We need this to be dev_info!() because dev_dbg!() does not =
work at
>         // all in Rust for now, and we need to see whether probe =
succeeded.
> @@ -184,8 +184,8 @@ fn drop(self: Pin<&mut Self>) {}
>=20
> #[vtable]
> impl drm::Driver for TyrDrmDriver {
> -    type Data =3D TyrDrmDeviceData;
> -    type RegistrationData<'a> =3D ();
> +    type Data =3D ();
> +    type RegistrationData<'bound> =3D TyrDrmRegistrationData<'bound>;
>     type File =3D TyrDrmFileData;
>     type Object =3D drm::gem::shmem::Object<BoData>;
>     type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index b686041d5d6b..9f60a90d4948 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -12,7 +12,8 @@
>=20
> use crate::driver::{
>     TyrDrmDevice,
> -    TyrDrmDriver, //
> +    TyrDrmDriver,
> +    TyrDrmRegistrationData, //
> };
>=20
> #[pin_data]
> @@ -31,15 +32,15 @@ fn open(_dev: &drm::Device<Self::Driver>) -> =
Result<Pin<KBox<Self>>> {
>=20
> impl TyrDrmFileData {
>     pub(crate) fn dev_query(
> -        ddev: &TyrDrmDevice<Registered>,
> -        _reg_data: &(),
> +        _ddev: &TyrDrmDevice<Registered>,
> +        reg_data: &TyrDrmRegistrationData<'_>,
>         devquery: &mut uapi::drm_panthor_dev_query,
>         _file: &TyrDrmFile,
>     ) -> Result<u32> {
>         if devquery.pointer =3D=3D 0 {
>             match devquery.type_ {
>                 =
uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO =3D> {
> -                    devquery.size =3D =
core::mem::size_of_val(&ddev.gpu_info) as u32;
> +                    devquery.size =3D =
core::mem::size_of_val(&reg_data.gpu_info) as u32;
>                     Ok(0)
>                 }
>                 _ =3D> Err(EINVAL),
> @@ -53,7 +54,7 @@ pub(crate) fn dev_query(
>                     )
>                     .writer();
>=20
> -                    writer.write(&ddev.gpu_info)?;
> +                    writer.write(&reg_data.gpu_info)?;
>=20
>                     Ok(0)
>                 }
>=20
> --=20
> 2.54.0
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
