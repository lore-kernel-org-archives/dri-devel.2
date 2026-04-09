Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB5F364A3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F90210E010;
	Thu,  9 Apr 2026 16:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="ihm2ALh+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C93410E004
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 16:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775753732; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ChSHW0n9brhDITMVosONVeA97SgPYjC1fEeYcVNh90FG73tE21zNWUC3yxvSZcJVDxmhF2+xo/Udwe8ac+Sjbk6roJaABGkoHfvhMnrdfBremSijCQQQpoT+r66rXZEqQb77fiUQwNm2ksaWdznMOXkphXtWRV2iTRJKtvJU8E4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775753732;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IAmUjsiH/TVRLXqtjhMhJJ/qDVZYPY+bsnUPVnBAXI0=; 
 b=L7oHSqKd3fz71XQvx4aMkJmsqCLR73VUWcxL1bhNTWTjPBvqkAsd7E2jv4y1XRcKRtSpliZ63URaOOgFLsfm2e8aGLLO7AA2zYxFy2A6hqSKnpX/d8/RT3rsA99qR3jqxLUGuxSlD89PJPShadulWXPgk9soaKfaPeFveUHgmlk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775753732; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=IAmUjsiH/TVRLXqtjhMhJJ/qDVZYPY+bsnUPVnBAXI0=;
 b=ihm2ALh+gUPry632mKpY7cWiNLT0TC51wiBoMo+HAQ2R9j609/9xy3TCyVkq4oyS
 FMzx+NtWT4zhad1EvSgd6nYlmQc0XMSLVz1ed7y1mVtGvwoYeK2KHAidNvR3frig4H8
 fGFxExeVY8TBryOtgXtvRsHHb2nxSRRUYSef446g=
Received: by mx.zohomail.com with SMTPS id 1775753729735680.1713108300631;
 Thu, 9 Apr 2026 09:55:29 -0700 (PDT)
Date: Thu, 9 Apr 2026 09:55:28 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v4 1/6] drm/tyr: Use register! macro for GPU_CONTROL
Message-ID: <adfaALk-8Gn0yps7@um790>
References: <20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com>
 <20260402-tyr-use-register-macro-v4-v4-1-96a8d42f8bd1@collabora.com>
 <DHOJSH0AII57.2U2V9ZWH23EAC@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHOJSH0AII57.2U2V9ZWH23EAC@garyguo.net>
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

On Thu, Apr 09, 2026 at 11:21:54AM +0100, Gary Guo wrote:
> On Fri Apr 3, 2026 at 12:35 AM BST, Deborah Brouwer wrote:
> > From: Daniel Almeida <daniel.almeida@collabora.com>
> >
> > Convert the GPU_CONTROL register definitions to use the `register!` macro.
> >
> > Using the `register!` macro allows us to replace manual bit masks and
> > shifts with typed register and field accessors, which makes the code
> > easier to read and avoids errors from bit manipulation.
> >
> > Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> >  drivers/gpu/drm/tyr/driver.rs |  24 +-
> >  drivers/gpu/drm/tyr/gpu.rs    | 232 +++++------
> >  drivers/gpu/drm/tyr/regs.rs   | 909 +++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 969 insertions(+), 196 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> > index 611434641580574ec6b5afa49a8fe79888bb7ace..3ebb5e08bfca342f136e8d365b1d9dcb6cc3dbca 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -13,7 +13,10 @@
> >      devres::Devres,
> >      drm,
> >      drm::ioctl,
> > -    io::poll,
> > +    io::{
> > +        poll,
> > +        Io, //
> > +    },
> >      new_mutex,
> >      of,
> >      platform,
> > @@ -33,8 +36,11 @@
> >      file::TyrDrmFileData,
> >      gem::TyrObject,
> >      gpu,
> > -    gpu::GpuInfo,
> > -    regs, //
> > +    gpu::{
> > +        gpu_info_log, //
> > +        GpuInfo,
> > +    },
> > +    regs::gpu_control::*, //
> >  };
> >  
> >  pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
> > @@ -78,11 +84,15 @@ unsafe impl Send for TyrDrmDeviceData {}
> >  unsafe impl Sync for TyrDrmDeviceData {}
> >  
> >  fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> > +    let io = (*iomem).access(dev)?;
> > +    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> >  
> >      poll::read_poll_timeout(
> > -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> > -        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
> > +        || {
> > +            let io = (*iomem).access(dev)?;
> > +            Ok(io.read(GPU_IRQ_RAWSTAT))
> > +        },
> > +        |status| status.reset_completed(),
> >          time::Delta::from_millis(1),
> >          time::Delta::from_millis(100),
> >      )
> > @@ -127,7 +137,7 @@ fn probe(
> >          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> >  
> >          let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
> > -        gpu_info.log(pdev);
> > +        gpu_info_log(pdev.as_ref(), &iomem)?;
> 
> This causes all registers to be re-read again for some reason?
> 
> Why is the function signature of `gpu_info_log` changing from a method to a
> standalone function? The commit message doesn't mention any.

I think i was originally trying to get rid of GpuInfo altogether which
was not possible, so you're right these reads are redundant.

I will change it back to a method for v5.

> 
> >  
> >          let platform: ARef<platform::Device> = pdev.into();
> >  
> > diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> > index a88775160f981e899e9c9b58debbda33e1b7244d..8ae39137a1d190ef026351d47a6cdd89063ed0fb 100644
> > --- a/drivers/gpu/drm/tyr/gpu.rs
> > +++ b/drivers/gpu/drm/tyr/gpu.rs
> > @@ -5,14 +5,16 @@
> >      DerefMut, //
> >  };
> >  use kernel::{
> > -    bits::genmask_u32,
> >      device::{
> >          Bound,
> >          Device, //
> >      },
> >      devres::Devres,
> > -    io::poll,
> > -    platform,
> > +    io::{
> > +        poll,
> > +        register::Array,
> > +        Io, //
> > +    },
> >      prelude::*,
> >      time::Delta,
> >      transmute::AsBytes,
> > @@ -21,7 +23,10 @@
> >  
> >  use crate::{
> >      driver::IoMem,
> > -    regs, //
> > +    regs::{
> > +        gpu_control::*,
> > +        join_u64, //
> > +    }, //
> >  };
> >  
> >  /// Struct containing information that can be queried by userspace. This is read from
> > @@ -29,120 +34,55 @@
> >  ///
> >  /// # Invariants
> >  ///
> > -/// - The layout of this struct identical to the C `struct drm_panthor_gpu_info`.
> > +/// - The layout of this struct is identical to the C `struct drm_panthor_gpu_info`.
> >  #[repr(transparent)]
> >  #[derive(Clone, Copy)]
> >  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> >  
> >  impl GpuInfo {
> >      pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
> > -        let gpu_id = regs::GPU_ID.read(dev, iomem)?;
> > -        let csf_id = regs::GPU_CSF_ID.read(dev, iomem)?;
> > -        let gpu_rev = regs::GPU_REVID.read(dev, iomem)?;
> > -        let core_features = regs::GPU_CORE_FEATURES.read(dev, iomem)?;
> > -        let l2_features = regs::GPU_L2_FEATURES.read(dev, iomem)?;
> > -        let tiler_features = regs::GPU_TILER_FEATURES.read(dev, iomem)?;
> > -        let mem_features = regs::GPU_MEM_FEATURES.read(dev, iomem)?;
> > -        let mmu_features = regs::GPU_MMU_FEATURES.read(dev, iomem)?;
> > -        let thread_features = regs::GPU_THREAD_FEATURES.read(dev, iomem)?;
> > -        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(dev, iomem)?;
> > -        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(dev, iomem)?;
> > -        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(dev, iomem)?;
> > -        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(dev, iomem)?;
> > -
> > -        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(dev, iomem)?;
> > -
> > -        let as_present = regs::GPU_AS_PRESENT.read(dev, iomem)?;
> > -
> > -        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(dev, iomem)?);
> > -        let shader_present =
> > -            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(dev, iomem)?) << 32;
> > -
> > -        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(dev, iomem)?);
> > -        let tiler_present =
> > -            tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(dev, iomem)?) << 32;
> > -
> > -        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(dev, iomem)?);
> > -        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(dev, iomem)?) << 32;
> > +        let io = (*iomem).access(dev)?;
> >  
> >          Ok(Self(uapi::drm_panthor_gpu_info {
> > -            gpu_id,
> > -            gpu_rev,
> > -            csf_id,
> > -            l2_features,
> > -            tiler_features,
> > -            mem_features,
> > -            mmu_features,
> > -            thread_features,
> > -            max_threads,
> > -            thread_max_workgroup_size,
> > -            thread_max_barrier_size,
> > -            coherency_features,
> > -            // TODO: Add texture_features_{1,2,3}.
> > -            texture_features: [texture_features, 0, 0, 0],
> > -            as_present,
> > +            gpu_id: io.read(GPU_ID).into_raw(),
> > +            gpu_rev: io.read(REVIDR).into_raw(),
> > +            csf_id: io.read(CSF_ID).into_raw(),
> > +            l2_features: io.read(L2_FEATURES).into_raw(),
> > +            tiler_features: io.read(TILER_FEATURES).into_raw(),
> > +            mem_features: io.read(MEM_FEATURES).into_raw(),
> > +            mmu_features: io.read(MMU_FEATURES).into_raw(),
> > +            thread_features: io.read(THREAD_FEATURES).into_raw(),
> > +            max_threads: io.read(THREAD_MAX_THREADS).into_raw(),
> > +            thread_max_workgroup_size: io.read(THREAD_MAX_WORKGROUP_SIZE).into_raw(),
> > +            thread_max_barrier_size: io.read(THREAD_MAX_BARRIER_SIZE).into_raw(),
> > +            coherency_features: io.read(COHERENCY_FEATURES).into_raw(),
> > +            texture_features: [
> > +                io.read(TEXTURE_FEATURES::at(0)).supported_formats().get(),
> > +                io.read(TEXTURE_FEATURES::at(1)).supported_formats().get(),
> > +                io.read(TEXTURE_FEATURES::at(2)).supported_formats().get(),
> > +                io.read(TEXTURE_FEATURES::at(3)).supported_formats().get(),
> > +            ],
> > +            as_present: io.read(AS_PRESENT).into_raw(),
> >              selected_coherency: uapi::drm_panthor_gpu_coherency_DRM_PANTHOR_GPU_COHERENCY_NONE,
> > -            shader_present,
> > -            l2_present,
> > -            tiler_present,
> > -            core_features,
> > +            shader_present: join_u64(
> > +                io.read(SHADER_PRESENT_LO).into_raw(),
> > +                io.read(SHADER_PRESENT_HI).into_raw(),
> > +            ),
> > +            l2_present: join_u64(
> > +                io.read(L2_PRESENT_LO).into_raw(),
> > +                io.read(L2_PRESENT_HI).into_raw(),
> > +            ),
> > +            tiler_present: join_u64(
> > +                io.read(TILER_PRESENT_LO).into_raw(),
> > +                io.read(TILER_PRESENT_HI).into_raw(),
> > +            ),
> > +            core_features: io.read(CORE_FEATURES).into_raw(),
> > +            // Padding must be zero.
> >              pad: 0,
> > +            //GPU_FEATURES register is not available; it was introduced in arch 11.x.
> >              gpu_features: 0,
> >          }))
> >      }
> > -
> > -    pub(crate) fn log(&self, pdev: &platform::Device) {
> > -        let gpu_id = GpuId::from(self.gpu_id);
> > -
> > -        let model_name = if let Some(model) = GPU_MODELS
> > -            .iter()
> > -            .find(|&f| f.arch_major == gpu_id.arch_major && f.prod_major == gpu_id.prod_major)
> > -        {
> > -            model.name
> > -        } else {
> > -            "unknown"
> > -        };
> > -
> > -        dev_info!(
> > -            pdev,
> > -            "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> > -            model_name,
> > -            self.gpu_id >> 16,
> > -            gpu_id.ver_major,
> > -            gpu_id.ver_minor,
> > -            gpu_id.ver_status
> > -        );
> > -
> > -        dev_info!(
> > -            pdev,
> > -            "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
> > -            self.l2_features,
> > -            self.tiler_features,
> > -            self.mem_features,
> > -            self.mmu_features,
> > -            self.as_present
> > -        );
> > -
> > -        dev_info!(
> > -            pdev,
> > -            "shader_present=0x{:016x} l2_present=0x{:016x} tiler_present=0x{:016x}",
> > -            self.shader_present,
> > -            self.l2_present,
> > -            self.tiler_present
> > -        );
> > -    }
> > -
> > -    /// Returns the number of virtual address bits supported by the GPU.
> > -    #[expect(dead_code)]
> > -    pub(crate) fn va_bits(&self) -> u32 {
> > -        self.mmu_features & genmask_u32(0..=7)
> > -    }
> > -
> > -    /// Returns the number of physical address bits supported by the GPU.
> > -    #[expect(dead_code)]
> > -    pub(crate) fn pa_bits(&self) -> u32 {
> > -        (self.mmu_features >> 8) & genmask_u32(0..=7)
> > -    }
> >  }
> >  
> >  impl Deref for GpuInfo {
> > @@ -182,38 +122,68 @@ struct GpuModels {
> >      prod_major: 7,
> >  }];
> >  
> > -#[allow(dead_code)]
> > -pub(crate) struct GpuId {
> > -    pub(crate) arch_major: u32,
> > -    pub(crate) arch_minor: u32,
> > -    pub(crate) arch_rev: u32,
> > -    pub(crate) prod_major: u32,
> > -    pub(crate) ver_major: u32,
> > -    pub(crate) ver_minor: u32,
> > -    pub(crate) ver_status: u32,
> > -}
> > -
> > -impl From<u32> for GpuId {
> > -    fn from(value: u32) -> Self {
> > -        GpuId {
> > -            arch_major: (value & genmask_u32(28..=31)) >> 28,
> > -            arch_minor: (value & genmask_u32(24..=27)) >> 24,
> > -            arch_rev: (value & genmask_u32(20..=23)) >> 20,
> > -            prod_major: (value & genmask_u32(16..=19)) >> 16,
> > -            ver_major: (value & genmask_u32(12..=15)) >> 12,
> > -            ver_minor: (value & genmask_u32(4..=11)) >> 4,
> > -            ver_status: value & genmask_u32(0..=3),
> > -        }
> > -    }
> > +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > +    let io = (*iomem).access(dev)?;
> > +    let gpu_id = io.read(GPU_ID);
> > +
> > +    let model_name = if let Some(model) = GPU_MODELS.iter().find(|&f| {
> > +        f.arch_major == gpu_id.arch_major().get() && f.prod_major == gpu_id.prod_major().get()
> > +    }) {
> > +        model.name
> > +    } else {
> > +        "unknown"
> > +    };
> > +
> > +    dev_info!(
> > +        dev,
> > +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> > +        model_name,
> > +        gpu_id.into_raw() >> 16,
> > +        gpu_id.ver_major().get(),
> > +        gpu_id.ver_minor().get(),
> > +        gpu_id.ver_status().get()
> > +    );
> > +
> > +    dev_info!(
> > +        dev,
> > +        "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
> > +        io.read(L2_FEATURES).into_raw(),
> > +        io.read(TILER_FEATURES).into_raw(),
> > +        io.read(MEM_FEATURES).into_raw(),
> > +        io.read(MMU_FEATURES).into_raw(),
> > +        io.read(AS_PRESENT).into_raw(),
> > +    );
> 
> Without the signature change the old code is all accessing from self.

Ack.

> 
> Best,
> Gary
> 
> > +
> > +    dev_info!(
> > +        dev,
> > +        "shader_present=0x{:016x} l2_present=0x{:016x} tiler_present=0x{:016x}",
> > +        join_u64(
> > +            io.read(SHADER_PRESENT_LO).into_raw(),
> > +            io.read(SHADER_PRESENT_HI).into_raw(),
> > +        ),
> > +        join_u64(
> > +            io.read(L2_PRESENT_LO).into_raw(),
> > +            io.read(L2_PRESENT_HI).into_raw(),
> > +        ),
> > +        join_u64(
> > +            io.read(TILER_PRESENT_LO).into_raw(),
> > +            io.read(TILER_PRESENT_HI).into_raw(),
> > +        ),
> > +    );
> > +    Ok(())
> >  }
> >  
> > [snip]
