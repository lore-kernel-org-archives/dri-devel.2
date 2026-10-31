Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C589606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=eoW2oFIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039BC10E84F;
	Sat, 31 Oct 2026 00:10:57 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC9910E84F
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 00:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793405447; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GItZlNh31elvMwa9/kYRn9UsvQsgl6UavN8zJj2OclchqMbKn3LcmPUKT7y+QCVA1hxHV67f1tpRUIbFa5CQ1Ruj74blHjOe7k2HbNGAg31e8PeCBE1FcLaPMbSss7Kcr0W02dHGm0W8frLwJJdOKFH6MkvwaL9fqdCYqCk5Ov4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793405447;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GdDnz4pI3ov+UfCffBhq7x6t7Hr4WugUuptiC909KRE=; 
 b=LBwTDSA3wNAli8LX22ABDJQypXCnXO7Jnw2cQYxTzbAX2xhGKDJJa/dX2aQStjsufDa9bEdM2vwKawk7UVpaXVSsuUhuWY+GFGD8maKoqKSWeZvqgWb9hMWWD+IITMLFgvHLHdXZwsyS5O8KaFgSOdKd4H14GmfMz6MJfbyMWrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=eoW2oFIJW921+VN6N5JHxVuACjeBK3GmZ1Dl5aRcpZNL2ZchGwBSkKD5QGy9fiAS2akWILv1hYvZl4visvl+V5/4DriJwBMEYp/YO20DHjgtm+NXfJFmkZj0z4oy7n5sua2rEm7ETdCP/YnD/xTRdKNlfEqANftTQ3525LtBbF8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=GdDnz4pI3ov+UfCffBhq7x6t7Hr4WugUuptiC909KRE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793405444336106.11728771505375; 
 Fri, 30 Oct 2026 17:10:44 -0700 (PDT)
Date: Fri, 30 Oct 2026 17:10:43 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Ke Sun <sunke@kylinos.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v5 08/11] drm/tyr: add BO-related ioctls
Message-ID: <auUyA5-7HVhCBCC6@um790>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
 <20261027-tyr-ioctls-v5-8-59dfe98cb003@kylinos.cn>
 <auKTafNV9hQGh6We@um790>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auKTafNV9hQGh6We@um790>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.393.56
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 05:29:29PM -0700, Deborah Brouwer wrote:
> On Tue, Oct 27, 2026 at 12:41:01AM +0800, Ke Sun wrote:
> > From: Alvin Sun <alvin.sun@linux.dev>
> > 
> > Implement BO_CREATE and BO_MMAP_OFFSET so userspace can allocate GPU
> > buffers and obtain a DRM mmap offset for the generic mmap path.
> > BO_CREATE page-aligns the requested size; BO_MMAP_OFFSET rejects
> > NO_MMAP objects, which must never be CPU-mapped.
> > 
> > Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> > ---
> >  drivers/gpu/drm/tyr/driver.rs |  2 ++
> >  drivers/gpu/drm/tyr/file.rs   | 73 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/tyr/gem.rs    | 18 +++++++++--
> >  3 files changed, 90 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> > index c0f17bc4ce2c9..f4f31b24180b4 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -227,6 +227,8 @@ impl drm::Driver for TyrDrmDriver {
> >          (PANTHOR_VM_DESTROY, drm_panthor_vm_destroy, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_destroy),
> >          (PANTHOR_VM_BIND, drm_panthor_vm_bind, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_bind),
> >          (PANTHOR_VM_GET_STATE, drm_panthor_vm_get_state, ioctl::RENDER_ALLOW, TyrDrmFileData::vm_get_state),
> > +        (PANTHOR_BO_CREATE, drm_panthor_bo_create, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_create),
> > +        (PANTHOR_BO_MMAP_OFFSET, drm_panthor_bo_mmap_offset, ioctl::RENDER_ALLOW, TyrDrmFileData::bo_mmap_offset),
> >      }
> >  }
> >  
> > diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> > index 22a74b4abf3de..9ffb42f0d8851 100644
> > --- a/drivers/gpu/drm/tyr/file.rs
> > +++ b/drivers/gpu/drm/tyr/file.rs
> > @@ -250,6 +250,79 @@ pub(crate) fn vm_get_state(
> >              Ok(0)
> >          })
> >      }
> > +
> > +    pub(crate) fn bo_create(
> > +        ddev: &TyrDrmDevice<Registered>,
> > +        _reg_data: &TyrDrmRegistrationData<'_>,
> > +        bocreate: &mut uapi::drm_panthor_bo_create,
> > +        file: &TyrDrmFile,
> > +    ) -> Result<u32> {
> > +        if bocreate.size == 0
> > +            || bocreate.pad != 0
> > +            || bocreate.flags & !uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0
> > +        {
> > +            dev_dbg!(
> > +                ddev.as_ref(),
> > +                "Invalid BO_CREATE params: size={}, pad={}, flags={:#x}\n",
> > +                bocreate.size,
> > +                bocreate.pad,
> > +                bocreate.flags
> > +            );
> > +            return Err(EINVAL);
> > +        }
> 
> Panthor checks that both BO_WB_MMAP and BO_NO_MMAP are not
> set at the same time, should we do the same here?

Ah, I see you check that they are mutually exclusive later in the
series, you should probably just do that in this first patch
where you add bo_create. There is no reason for them to be
in separate patches.

> 
> Also if only BO_WB_MMAP is set, shouldn't we return EOPNOTSUPP?

I see you accept this flag later in this same series, it would be
clearer if you just accepted the BO_WB_MMAP flag directly in this
patch, there is no reason not to support it.

> 
> 
> > +
> > +        if bocreate.exclusive_vm_id != 0 {
> > +            dev_dbg!(ddev.as_ref(), "BO_CREATE: exclusive_vm_id not supported\n");
> > +            return Err(EINVAL);
> 
> Return EOPNOTSUPP because it's a valid request we just don't support it.
> 
> > +        }
> > +
> > +        let size = usize::try_from(bocreate.size).map_err(|_| {
> > +            dev_dbg!(
> > +                ddev.as_ref(),
> > +                "BO_CREATE size {:#x} too large\n",
> > +                bocreate.size
> > +            );
> > +            EINVAL
> > +        })?;
> > +        let bo = crate::gem::new_object(ddev, size, bocreate.flags)?;
> 
> Use file.inner_with() to access the platform device with the bound
> lifetime and then pass it to the new_object so that you can
> avoid accessing it later with an unsafe block. Something like:
> 
>  let bo = file.inner_with(|pfile| {
>     crate::gem::new_object(
>         ddev,
>         pfile.reg.pdev.as_ref(),
>         size,
>         bocreate.flags,
>     )
>  })?;
> 
> > +        bocreate.handle = bo.create_handle(file)?;
> > +        bocreate.size = bo.size() as u64;
> 
> use u64::from_safe_cast(bo.size())
> 
> 
> > +
> > +        Ok(0)
> > +    }
> > +
> > +    pub(crate) fn bo_mmap_offset(
> > +        ddev: &TyrDrmDevice<Registered>,
> > +        _reg_data: &TyrDrmRegistrationData<'_>,
> > +        bommap: &mut uapi::drm_panthor_bo_mmap_offset,
> > +        file: &TyrDrmFile,
> > +    ) -> Result<u32> {
> > +        if bommap.pad != 0 {
> > +            dev_dbg!(
> > +                ddev.as_ref(),
> > +                "BO mmap offset pad not zero: {}\n",
> > +                bommap.pad
> > +            );
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let bo = crate::gem::lookup_handle(file, bommap.handle).inspect_err(|_| {
> > +            dev_dbg!(ddev.as_ref(), "Invalid BO mmap handle: {}\n", bommap.handle);
> > +        })?;
> > +        if bo.flags() & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0 {
> > +            dev_dbg!(ddev.as_ref(), "BO mmap offset on NO_MMAP object\n");
> > +            return Err(EPERM);
> > +        }
> > +        bommap.offset = bo.create_mmap_offset().inspect_err(|_| {
> > +            dev_err!(
> > +                ddev.as_ref(),
> > +                "Failed to create mmap offset for handle {}\n",
> > +                bommap.handle
> > +            );
> > +        })?;
> > +
> > +        Ok(0)
> > +    }
> >  }
> >  
> >  fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> Result {
> > diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> > index 60f6363995a5a..14f3e182b98e2 100644
> > --- a/drivers/gpu/drm/tyr/gem.rs
> > +++ b/drivers/gpu/drm/tyr/gem.rs
> > @@ -38,6 +38,13 @@ pub(crate) struct BoData {
> >      flags: u32,
> >  }
> >  
> > +impl BoData {
> > +    /// Returns the flags the BO was created with.
> > +    pub(crate) fn flags(&self) -> u32 {
> > +        self.flags
> > +    }
> > +}
> > +
> >  /// Provides a way to pass arguments when creating BoData
> >  /// as required by the gem::DriverObject trait.
> >  pub(crate) struct BoCreateArgs {
> > @@ -57,7 +64,6 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
> >  pub(crate) type Bo = gem::shmem::Object<BoData>;
> >  
> >  /// Create a new GEM buffer object.
> > -#[expect(dead_code)]
> >  pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result<ARef<Bo>> {
> >      if size == 0 {
> >          return Err(EINVAL);
> > @@ -65,7 +71,7 @@ pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result
> >  
> >      let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
> >  
> > -    Bo::new(
> > +    let bo = Bo::new(
> >          ddev,
> >          aligned_size,
> >          shmem::ObjectConfig {
> > @@ -73,7 +79,13 @@ pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -> Result
> >              parent_resv_obj: None,
> >          },
> >          BoCreateArgs { flags },
> > -    )
> > +    )?;
> > +
> > +    // SAFETY: `ddev` is bound for the duration of this call.
> > +    let dev = unsafe { ddev.as_ref().as_ref().as_bound() };
> 
> You can remove this unsafe block by accessing the bound device through
> file.inner_with()
> 
> > +    bo.sg_table(dev)?;
> > +
> > +    Ok(bo)
> >  }
> >  
> >  /// Look up a GEM object by handle for a DRM file.
> > 
> > -- 
> > 2.43.0
> > 
