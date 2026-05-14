Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9566CD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 19:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C741C10E170;
	Thu, 14 May 2026 19:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="IMZQQBlk";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC4810E170
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 19:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778785194; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YPR7GBJToEeqRtv8HWtn23wZUB0lztq3jFzE/XVy1IWdAncNoP7DG0vg5Gmp2q/bWz5rK6IBo5KBpHRKILRJGQ8jLQmtCCCDwdTsuQMoYO3AuflVfqYRai4HDWqqnZnKm+vwJWq3g56xWHpYSXEmThh+NeVHvV+mN3whs/3HOR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778785194;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qelSeKsMQl4VDT2VXj+KY7L5fpuxA0yPXVlURbeTUzM=; 
 b=Ym5r9Z6kQe1kSqdUsypyMNsI9qi35h8lJum/TvanZuarIIbI6BE2j4BsgFhlej8sHifu9wH60KXBGk68IA0A4pCtQEjQFtvLJKHfJTXiQ5lGdDULHYpEbffqlVTJJWlec6jppPTHRHVWQwVz8sJdftnDZctb8/83jOXiTovn8Ks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778785194; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=qelSeKsMQl4VDT2VXj+KY7L5fpuxA0yPXVlURbeTUzM=;
 b=IMZQQBlkLpJYMTuua3UPpAcN5t0cuSLhuOyoEvJLN3UR2QZHsmppCC6WVDpLcwoB
 7BVvFZIuyhBpWT2rEq+IrE2C5wae6DG8iTU8EHGw9hcSvxI9lqxd+wdpHBd6ISJLduJ
 BcgKQi7AQfu7EMi7mc1YRsfdiWTPGWRFgcKvdTBY=
Received: by mx.zohomail.com with SMTPS id 1778785191961267.0462243779699;
 Thu, 14 May 2026 11:59:51 -0700 (PDT)
Date: Thu, 14 May 2026 11:59:50 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 daniel.almeida@collabora.com, acourbot@nvidia.com,
 apopple@nvidia.com, ecourtney@nvidia.com, lyude@redhat.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, driver-core@lists.linux.dev,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] rust: drm: Higher-Ranked Lifetime private data
Message-ID: <agYbppHWXk_hW99M@um790>
References: <20260506221027.858481-1-dakr@kernel.org>
 <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org>
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

On Thu, May 07, 2026 at 11:38:37AM +0200, Danilo Krummrich wrote:
> On Thu May 7, 2026 at 12:05 AM CEST, Danilo Krummrich wrote:
> > Danilo Krummrich (6):
> >   rust: drm: Add Driver::ParentDevice associated type
> >   rust: drm: Add UnbindGuard for drm_dev_enter/exit critical sections
> >   rust: drm: Add RegistrationData to drm::Driver
> >   rust: drm: Wrap ioctl dispatch in UnbindGuard
> >   rust: drm: Pass registration data to ioctl handlers
> >   rust: drm: Pass bound parent device to ioctl handlers
> 
> Deborah, following up on your question in the other thread, this is roughly how
> you'd use this in Tyr.

Hi Danilo,

Thanks for this advice, I've been working on applying these changes
to Tyr's MCU/firmware boot series. One problem i've had is that we used
to be able to get an unregistered device without providing the drm::Driver
type Data like this:

let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev)?;

Then Tyr used that unregistered device to create a gem::shmem::Object
and initialize a gpuvm tree which we used to map the shared memory
to load the firmware.

Has the design changed so that the drm::Driver type Data must be
provided now to get the unregistered devices? Like this?

let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;

Just checking that this is what we need to work with? If so, I was
thinking of just simplifying the firmware boot to use a small coherent
dma allocation instead like this:
https://gitlab.freedesktop.org/dbrouwer/linux/-/merge_requests/3/diffs?commit_id=39be9140e22c6252317082a1424a66c35dc004b3

Could you let me know if this aligns with your driver core changes?

Deborah

> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 7ac3707823b6..447e53c0eecf 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -37,13 +37,17 @@
>      regs, //
>  };
> 
> -pub(crate) type IoMem = kernel::io::Mmio<SZ_2M>;
> +pub(crate) type IoMem<'bound> = kernel::io::mem::IoMem<'bound, SZ_2M>;
> 
>  pub(crate) struct TyrDrmDriver;
> 
>  /// Convenience type alias for the DRM device type for this driver.
>  pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
> 
> +pub(crate) struct RegData<'bound> {
> +    pub(crate) iomem: IoMem<'bound>,
> +}
> +
>  #[pin_data(PinnedDrop)]
>  pub(crate) struct TyrPlatformDriverData {
>      _device: ARef<TyrDrmDevice>,
> @@ -65,7 +69,7 @@ pub(crate) struct TyrDrmDeviceData {
>      pub(crate) gpu_info: GpuInfo,
>  }
> 
> -fn issue_soft_reset(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +fn issue_soft_reset(dev: &Device<Bound>, iomem: &IoMem<'_>) -> Result {
>      regs::GPU_CMD.write(iomem, regs::GPU_CMD_SOFT_RESET);
> 
>      poll::read_poll_timeout(
> @@ -133,8 +137,10 @@ fn probe(
>                  gpu_info,
>          });
> 
> +        let reg_data = RegData { iomem };
> +
>          let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> -        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), (), 0)?;
> +        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), reg_data, 0)?;
> 
>          let driver = TyrPlatformDriverData {
>              _device: tdev.into(),
> @@ -176,7 +182,7 @@ fn drop(self: Pin<&mut Self>) {
>  #[vtable]
>  impl drm::Driver for TyrDrmDriver {
>      type Data = TyrDrmDeviceData;
> -    type RegistrationData = ForLt!(());
> +    type RegistrationData = ForLt!(for<'a> RegData<'a>);
>      type File = TyrDrmFileData;
>      type Object<R: drm::DeviceContext> = drm::gem::Object<TyrObject, R>;
>      type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 9f53da7633ab..30efdf924cc2 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -10,6 +10,7 @@
>  };
> 
>  use crate::driver::{
> +    RegData,
>      TyrDrmDevice,
>      TyrDrmDriver, //
>  };
> @@ -32,10 +33,12 @@ impl TyrDrmFileData {
>      pub(crate) fn dev_query(
>          ddev: &TyrDrmDevice,
>          _pdev: &platform::Device<device::Bound>,
> -        _reg_data: &(),
> +        reg_data: &RegData<'_>,
>          devquery: &mut uapi::drm_panthor_dev_query,
>          _file: &TyrDrmFile,
>      ) -> Result<u32> {
> +        let _iomem = reg_data.iomem;
> +
>          if devquery.pointer == 0 {
>              match devquery.type_ {
>                  uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index bb0473c85bf7..f169fb1ccc03 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -34,7 +34,7 @@
>  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> 
>  impl GpuInfo {
> -    pub(crate) fn new(iomem: &IoMem) -> Self {
> +    pub(crate) fn new(iomem: &IoMem<'_>) -> Self {
>          let gpu_id = regs::GPU_ID.read(iomem);
>          let csf_id = regs::GPU_CSF_ID.read(iomem);
>          let gpu_rev = regs::GPU_REVID.read(iomem);
> @@ -206,7 +206,7 @@ fn from(value: u32) -> Self {
>  }
> 
>  /// Powers on the l2 block.
> -pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &IoMem) -> Result {
> +pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &IoMem<'_>) -> Result {
>      regs::L2_PWRON_LO.write(iomem, 1);
> 
>      poll::read_poll_timeout(
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 0881b3812afd..2b0da6019512 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -20,12 +20,12 @@
> 
>  impl<const OFFSET: usize> Register<OFFSET> {
>      #[inline]
> -    pub(crate) fn read(&self, iomem: &IoMem) -> u32 {
> +    pub(crate) fn read(&self, iomem: &IoMem<'_>) -> u32 {
>          iomem.read32(OFFSET)
>      }
> 
>      #[inline]
> -    pub(crate) fn write(&self, iomem: &IoMem, value: u32) {
> +    pub(crate) fn write(&self, iomem: &IoMem<'_>, value: u32) {
>          iomem.write32(value, OFFSET);
>      }
>  }
