Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DB606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LT42WofC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B0210E535;
	Fri, 30 Oct 2026 06:18:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAEF10E535
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793341098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eTZV97Ej9NaW0OXMDYyzer66TWfx/oJeH5f1Fz/FjJ8=;
 b=LT42WofC5ow2dA0G585aoMNyUWs7EfEbEBq+l0SuFWGlonsFt+yz/fKzimjoI0dvYg5Rxl
 V6iPrrxq8arCUrdfwCuqphBNyhmMWW+hb90/NJ71qvEEi9CEClf0y8ArJfgO6ahJO689YC
 u1tiGgma1vsQhdsQI87EiLWvsDqzmr0=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-OQ8YzFeXNiG4ePkwcYfofg-1; Fri, 30 Oct 2026 02:18:16 -0400
X-MC-Unique: OQ8YzFeXNiG4ePkwcYfofg-1
X-Mimecast-MFC-AGG-ID: OQ8YzFeXNiG4ePkwcYfofg_1793341095
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a71dd190b0so1384679c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 23:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793341095; x=1793945895;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eTZV97Ej9NaW0OXMDYyzer66TWfx/oJeH5f1Fz/FjJ8=;
 b=SYHdv1Dgwep+6Cgpu8F+RyyW37TWfCPA+5FByev22oehX72kaBzLFEwXrrNXDNgSI7
 tzJhKCsli2UUWt9dyGnGiIcwxqSAWN2ViFwxXdufguJLt9/Tuaf12x2t7Wgp5gWMaYZw
 jJLay9y35EJIbo/PxSU+nkVY8PFpjQ1lyzp20ByBu4cpA5UYM5gaHldvH3Ht/INY8SqU
 ci8Q5YqOsblFIFdAadb8oD8gI6xbG2puhSIzL7EtniC9bbMurmT/eLKx1//Ey0qLt4ht
 u9Vd30pYfCA4u0oDqtvCSvt/2LSB+BsOGppOVKVFrGV4FxS3bDMeLTOGaJZ4ULA3Vmvj
 Zgzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVNlg6gQ4L9h7xTFZLhS6m5sHRem4+v4vGe6deOYB+MYgZmPoWDIJRn9QjEdWT2AlvB8oajCl0ZmU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIWORB73hjB5KtDPV9U4tm8JXV7x+Jh37hAFLa67Coen1GQ3aA1
 Nh1FbzhWYxOfCVzgrqrtKkOMECZH7AK2wjUV51swJb6DGY9YHKVvyVqCeB4ElScPgqJMWIyZ4NC
 9yQ4pqvwcXYBsM/Z/cfppKIdQS/eRYkdlEwEcHnx08YPFumfbgJJKnw3hsWBNLMzrBtI/5c/C88
 MQCOOf7OLyvTLWmrB2k9KsicSkfUk/BpoBwzIrIoFoggZV
X-Gm-Gg: AYBFou3keTgBPH1Tn/Sm/jYRHrf02HeJ7zQKRs0riusQ88ERu1ozMNUvqWZr6MJdZge
 S/7XBo602z+88h7pJou6ZlxPkC1KccqKh+z1M1VkHpyL7Mla6TRfHYNMTlvrliMeYnVsUnue/kt
 6mecZV+x8dTbgubFiGFShnBrmFv3hofST9AbY3sRUGp4NPOwtT/2GGt5YA2yhMBwg6GSktHOvG1
 cZUnyjUoTrJ7Hcd
X-Received: by 2002:a05:7022:1110:b0:14d:c9e:a356 with SMTP id
 a92af1059eb24-1ac59dd07f5mr1814771c88.12.1793341095073; 
 Thu, 29 Oct 2026 23:18:15 -0700 (PDT)
X-Received: by 2002:a05:7022:1110:b0:14d:c9e:a356 with SMTP id
 a92af1059eb24-1ac59dd07f5mr1814741c88.12.1793341094352; Thu, 29 Oct 2026
 23:18:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
In-Reply-To: <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Fri, 30 Oct 2026 16:18:02 +1000
X-Gm-Features: AclHuK88iNghoc0nbnd9bSpg2G3pjafRIlnCWpsBWxMaTs6XeV8gBZNH_byemeI
Message-ID: <CAMwc25q7=Sy_yoUdSXU1r-KudqG5wGSkK+9k2E8e7PxGSkqhjg@mail.gmail.com>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3vdef2YBYZRDO1MBogdL-N6OPHqP8M9a6bhhZ3TyDC0_1793341095
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

> This is related to the comment made by Sashiko, but in which cases are
> we expecting `total_fb_end` to be `None` here? Is this the same set of
> systems for which `buddy_params` will be `None`? If so both arguments
> should be merged into a new type to remove the ability to represent
> invalid state where one is `Some` and the other is `None`.

Indeed I've been working on a patchset to better define the concept
for total_fb_end, so this patchset can work on top in a proper manner.

The question of whether total_fb_end == Some(0) or total_fb_end ==
None is a sufficient indicator for no framebuffer, and I suppose we
have to make a choice before we can land this patch, anyone got an opinion?

> >
> >      /// Access the [`GpuBuddy`] allocator.
> > -    pub(crate) fn buddy(&self) -> &GpuBuddy {
> > -        &self.buddy
> > +    pub(crate) fn buddy(&self) -> Result<&GpuBuddy> {
> > +        self.buddy.as_ref().ok_or(ENODEV)
> >      }
>
> For this kind of accessor to an `Option` it is considered more idiomatic
> to just return an `Option` and let the caller decide how to handle the
> error, but in this case it just seems to be a private convenience method
> used only by submodules, so doing that would defeat its purpose.
> Instead, can we make it private?

possibly, I'll look before resubmitting anything.
>
> <...>
> > diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
> > index 77431c509a89..fd404b0734bb 100644
> > --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> > +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
> > @@ -81,7 +81,7 @@ pub(super) fn new(pdb_addr: VramAddress) -> Self {
> >      /// Allocate and zero a physical page table page.
> >      fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<PreparedPtPage> {
> >          let blocks = KBox::pin_init(
> > -            mm.buddy().alloc_blocks(
> > +            mm.buddy()?.alloc_blocks(
> >                  GpuBuddyAllocMode::Simple,
> >                  SZ_4K.into_safe_cast(),
> >                  Alignment::new::<SZ_4K>(),
> > @@ -94,7 +94,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
> >
> >          // Zero via PRAMIN.
> >          let window = mm
> > -            .pramin_mut()
> > +            .pramin_mut()?
> >              .window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
> >          for i in 0..PAGE_SIZE / 8 {
> >              io_write!(window.view(), [build: i], 0);
> > @@ -120,7 +120,7 @@ fn ensure_single_pte_path(
> >          for _ in 0..max_iter {
> >              let result = self
> >                  .walker
> > -                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr| {
> > +                .walk_pde_levels(mm.pramin_mut()?, vfn, |install_addr| {
> >                      pt_pages.get(&install_addr).and_then(|p| {
> >                          p.alloc
> >                              .iter()
> > @@ -197,7 +197,7 @@ pub(super) fn install_mappings(
> >          writable: bool,
> >      ) -> Result {
> >          {
> > -            let pramin = mm.pramin_mut();
> > +            let pramin = mm.pramin_mut()?;
> >
> >              // Drain prepared PT pages, install all pending PDEs.
> >              let mut cursor = pt_pages.cursor_front_mut();
> > @@ -255,7 +255,7 @@ pub(super) fn invalidate_ptes(
> >          let invalid_pte = M::Pte::invalid();
> >
> >          {
> > -            let pramin = mm.pramin_mut();
> > +            let pramin = mm.pramin_mut()?;
>
> I'll let Eliot comment on this in more depth as I am not very familiar
> with this module, but I'd like to avoid these runtime checks if
> possible. On systems without a framebuffer, we should not even be able
> to call these methods, so I'd like to enforce it at that level.
>
> Ideally, we would consolidate all the state requiring a framebuffer into
> a new type (i.e. my first comment, but pushed further), and put it
> behind a single `Option` that solely tells us whether the system has a
> framebuffer or not. Then methods requiring a framebuffer can be passed a
> reference to that type and work without runtime checking its presence.

I think we have to get to handling instmem maps in bar2 properly
before we can completely encapsulate everything.

Ideally instmem would have one API for allocation and it would be
backed on systems with VRAM with vram allocations, and with dma
allocations on 0-fb systems.

Then we would have to store the instmem backing in some sort of
encapsulation that hides the pramin/vram buddy/bar2 handling and
device handle for dma alloc handling

Does that make sense?

Dave.

