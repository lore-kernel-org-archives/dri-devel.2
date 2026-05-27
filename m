Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22560CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 23:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A43610EA92;
	Wed, 27 May 2026 23:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="YjRaq29R";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1F310EA92;
 Wed, 27 May 2026 23:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779923029; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SjHttpvIy1GCuacEQs1rJ9FK37mcLh48SvAWw6AvsrPh8YCvL2pyJm14Ryshcdbrj2tjj+eyJCEQm7ry+rZ9bhex9mbr6TjATejtaBZ39taFU6uDne7qaDZycwkSgXSy2OxgVSYN7oP+NgdRr7xVVUv9YRSrNJPS4QgUIzQCvHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779923029;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ADoB5F9I2EB6tOm3RI08vLfD95LygOJqbnyIGFzDvvo=; 
 b=KU7Xy5VvVfIRiENHYkGvMK1u8K8D2ZhL3nqruE6kl23bhfgRINey4v3J25kVjFVt0ugCJufSSji7Kcn0RtZgq8LGQwpQBbSQdrFw2nrNzLJ3y8n18OhyfLeEQ/JJ2hV2QBuBbyY7h0GlDC7Z90ZIY2p1HBVuvO9mhpysgYzCFbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779923029; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ADoB5F9I2EB6tOm3RI08vLfD95LygOJqbnyIGFzDvvo=;
 b=YjRaq29RD3Ot659CTYIYaqKoG9DmyRTzQZUN/702qe6ekHYVJvY6OKdr/zf397aV
 /iNBCNZQQqVwlIi7OEQUy5sMN7e4N6Cb2iDqthAn4o2v5doYXIoKQ03tosnPWlmdg1i
 9UkmDyZkZKrtOk6wCmVUQ1FSp4KvF3yc3JsPoKJA=
Received: by mx.zohomail.com with SMTPS id 1779923027051702.233885515741;
 Wed, 27 May 2026 16:03:47 -0700 (PDT)
Date: Wed, 27 May 2026 16:03:46 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 daniel.almeida@collabora.com, boris.brezillon@collabora.com,
 gary@garyguo.net, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
Message-ID: <ahd4UoKVT4cM-pgA@um790>
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
 <DIS9H75POYGW.EBC1MLW466RG@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIS9H75POYGW.EBC1MLW466RG@nvidia.com>
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

On Tue, May 26, 2026 at 11:43:38AM +0900, Eliot Courtney wrote:
> On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
> > Now that IoMem is lifetime-parameterized, use it directly in probe
> > rather than wrapping it in Devres and Arc. The I/O memory mapping is
> > only used during probe and not stored in driver data, so device-managed
> > revocation is unnecessary.
> >
> > This removes the Devres access(dev) pattern from issue_soft_reset(),
> > GpuInfo::new(), and l2_power_on(), simplifying register access.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  drivers/gpu/drm/tyr/driver.rs | 19 ++++++-------------
> >  drivers/gpu/drm/tyr/gpu.rs    | 13 +++----------
> >  2 files changed, 9 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> > index 5f4c484f671f..b9a5cc5fc678 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -6,11 +6,9 @@
> >          OptionalClk, //
> >      },
> >      device::{
> > -        Bound,
> >          Core,
> >          Device, //
> >      },
> > -    devres::Devres,
> >      dma::{
> >          Device as DmaDevice,
> >          DmaMask, //
> > @@ -30,7 +28,6 @@
> >      sizes::SZ_2M,
> >      sync::{
> >          aref::ARef,
> > -        Arc,
> >          Mutex, //
> >      },
> >      time, //
> > @@ -44,7 +41,7 @@
> >      regs::gpu_control::*, //
> >  };
> >  
> > -pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
> > +pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
> >  
> >  pub(crate) struct TyrDrmDriver;
> >  
> > @@ -74,15 +71,11 @@ pub(crate) struct TyrDrmDeviceData {
> >      pub(crate) gpu_info: GpuInfo,
> >  }
> >  
> > -fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > -    let io = (*iomem).access(dev)?;
> > -    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> > +fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
> > +    iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> >  
> >      poll::read_poll_timeout(
> > -        || {
> > -            let io = (*iomem).access(dev)?;
> > -            Ok(io.read(GPU_IRQ_RAWSTAT))
> > -        },
> > +        || Ok(iomem.read(GPU_IRQ_RAWSTAT)),
> >          |status| status.reset_completed(),
> >          time::Delta::from_millis(1),
> >          time::Delta::from_millis(100),
> > @@ -123,12 +116,12 @@ fn probe<'bound>(
> >          let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
> >  
> >          let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> > -        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
> > +        let iomem = request.iomap_sized::<SZ_2M>()?;
> >  
> >          issue_soft_reset(pdev.as_ref(), &iomem)?;
> >          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> >  
> > -        let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
> > +        let gpu_info = GpuInfo::new(&iomem)?;
> >          gpu_info.log(pdev.as_ref());
> >  
> >          let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
> > diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> > index 652556026f50..3acffefaf210 100644
> > --- a/drivers/gpu/drm/tyr/gpu.rs
> > +++ b/drivers/gpu/drm/tyr/gpu.rs
> > @@ -9,7 +9,6 @@
> >          Bound,
> >          Device, //
> >      },
> > -    devres::Devres,
> >      io::{
> >          poll,
> >          register::Array,
> > @@ -40,9 +39,7 @@
> >  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> >  
> >  impl GpuInfo {
> > -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
> > -        let io = (*iomem).access(dev)?;
> > -
> > +    pub(crate) fn new(io: &IoMem<'_>) -> Result<Self> {
> 
> Perhaps a future patch can remove this now unnecessary looking Result in
> the return type.

Oh that's right now that we don't have: let io = (*iomem).access(dev)?
we don't need the Result anymore.

Danilo, I can add this fix to our fw-boot series which I'm preparing to sit
on top of these changes.

> 
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> 
