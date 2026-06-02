Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A2CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D13B10EAE2;
	Tue,  2 Jun 2026 01:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="G2VrHdYu";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A632010EAE2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 01:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780362739; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YNVotoy/11mP7yWuIqYPWhD7yVW+IAMztNOS0tyBaK/0CPpblTaJR+R4Hla+yetVTgxygMgvuZdEInFPwVJcfNE4g/Hne5gPjaMCiiT1TcS2IjPmvYbc0UFJGYMYF3mh9KaDpGGZYvTSmYla8UJqsAMjn4H7jHo/BdfksgesIoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780362739;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=herxlzjkdjjg1P2+eKLyivOcEeIKlLQO1FQFEJDKKD8=; 
 b=FPY1e2nml5UkA9fO3JQIFEIr3CwhthDAsBpcrLF6zc5s5uxgL4w7PdFL6PIolOiB101S3BdhpdhKjO8WdCvWSQEm9F/w4bUOe+J07u/EsAXLJ180gdUBiFUqcNCVnnTja3//sZPrWikTjx5JsBr4+8FZB8UBxkU5+A4Mtfe9hTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780362739; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=herxlzjkdjjg1P2+eKLyivOcEeIKlLQO1FQFEJDKKD8=;
 b=G2VrHdYuDto7jD+2fdwse5VGoG/1YSo+fUShpPWMq8Zc3mxj6l/7c/RJ7BLrd/W1
 pKMWD/jWsz5i0KIXif6fTtbZmV76/b+2w+SUmuTT+sGg2TW7j3jFq0Dan83oylAor/+
 gtiNdL3nFjfwRr5pFE3sUY3pqYkNGsXP3EmYBndg=
Received: by mx.zohomail.com with SMTPS id 1780362737418258.7491888496602;
 Mon, 1 Jun 2026 18:12:17 -0700 (PDT)
Date: Mon, 1 Jun 2026 18:12:16 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, daniel.almeida@collabora.com,
 boris.brezillon@collabora.com, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
Message-ID: <ah4t8IPo1L6XZMy_@um790>
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-3-dakr@kernel.org>
 <ah1SSN8_dCEA4Osz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah1SSN8_dCEA4Osz@google.com>
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

On Mon, Jun 01, 2026 at 09:35:04AM +0000, Alice Ryhl wrote:
> On Fri, May 29, 2026 at 02:00:54AM +0200, Danilo Krummrich wrote:
> > Now that IoMem is lifetime-parameterized, use it directly in probe
> > rather than wrapping it in Devres and Arc. The I/O memory mapping is
> > only used during probe and not stored in driver data, so device-managed
> > revocation is unnecessary.
> > 
> > This removes the Devres access(dev) pattern from issue_soft_reset(),
> > GpuInfo::new(), and l2_power_on(), simplifying register access.
> > 
> > Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> > -pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
> > +pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
> 
> It'd make more sense for me to put 'b or 'bound here.
> 
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
> > +        let gpu_info = GpuInfo::new(&iomem);
> 
> 
> While this change is fine, I notice that we don't actually keep the
> iomem alive past the probe method. I assume we're going to need that,
> which leads to the question of whether we can store the iomem in the
> places we need it.
> 
> As far as I can tell, we can store it in TyrPlatformDriverData but not
> in TyrDrmDeviceData, is that right?

I'm still getting my head around how this applies to tyr's firmware
series, but yes we stop storing iomem in TyrDrmDeviceData, but we won't
store it in TyrPlatformDriverData.
Instead there is a new struct "RegistrationData" that will store the iomem
like this:

#[vtable]
impl drm::Driver for TyrDrmDriver {
    type Data = TyrDrmDeviceData;
    type RegistrationData = TyrDrmRegistrationData<'static>;

And then in probe something like:

 let reg_data = try_pin_init!(TyrDrmRegistrationData {
  pdev: platform.clone(),
  fw: firmware,
  clks <- new_mutex!(Clocks {
    core: core_clk,
    stacks: stacks_clk,
    coregroup: coregroup_clk,
  }),
  regulators <- new_mutex!(Regulators {
    _mali: mali_regulator,
    _sram: sram_regulator,
  }),
  iomem,
  gpu_info,
 });

 drm::driver::Registration::new_foreign_owned(ddev, pdev.as_ref(), reg_data, 0)?;


> 
> I guess it does make sense because the io memory goes away if the
> underlying platform device (the bus) goes away, even if the drm device
> still exists due to open fds from userspace.
> 
> Alice
