Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63122C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 21:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1FB10E267;
	Tue, 30 Jun 2026 21:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9Zn2+PX";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6811610E267
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 21:00:14 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e53230b82so219796685a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 14:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782853213; cv=none;
 d=google.com; s=arc-20260327;
 b=Q6ejOFND0Zhosa86PK1YPClwExtIIwbVwPOvgVB3iPpqERlIwoUxsQAWG0o82oqqbe
 bHzf52xcXk3yBC5z5YMc/Ci7lGUhRAi+yr8hlcS8xofRKx0gVI56nejc9QjvtHAfFplx
 32gT/yEj+mMEr6h5K9aiNwGNP1OlycWySiaEAeGdabGjtBjcIEWIN4WI+f+BfiyXBsZu
 p/74gY9ZLaWfHlYkTqmBeqGWLAfDyN117UM/T+422W9vOUkidGirhtd+t4zh1c0ngw3l
 rqqgkZrTAQml+AHLrkWcG7BkTH5W9URvQcJt7FZJ6FKtGMJcwFIh6XDjzbOpdH/loUVC
 iqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EgCyGv30NMm39mWfJMCDXGwOAoiuN8E+w++th3P1d4Y=;
 fh=+iOQG/OL4kctmPHETl0XS22vSntZdyhA+6p5ge2BAIc=;
 b=G02ngngLm6P/9RKRfi6SJ6Km3bP63NOtoiRYDxv5oi4TEYWiZxLGXtg0xlyxmM3Px+
 cR4kD8FrjoxJGBvuiZ05gELAqlzSrgGY5zuqxeWYF5C3s3VYbdsCfuVALF3p1gb+s0Yy
 MqS+7rFTFfc3tHqJZI7pb2QO8NzETYV+EEZtNsXB0Jv+o90qnL8ckB+5hPqHv7vS4HRV
 pndtt/vIqY3Yquc7bTF00YFS9Q9nTqoxyzSi/ZYhc3Ho92MpLeaxZSO0hgG00azltm3H
 90PK9Uyez7kfSUpBbY1JlN6j4iRBQg0h6CoHXyvVedqA9hFriTv/B3eWocBYkEWV21M6
 +A8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782853213; x=1783458013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgCyGv30NMm39mWfJMCDXGwOAoiuN8E+w++th3P1d4Y=;
 b=H9Zn2+PXzA67RdDlKcxc3GAxUyAOfDFubCFPZPCZFzG4lavx2SsXNJDKRfwbfjpoK3
 vWYitSBTkV7ehGQ6bh8SBizUnyc6p17llW503KbAMUOmRcyEXpWjanccFM05FFamiMVp
 SDrRD0svnCV+MckLb1Smk+QQwMZC+weMb8M9mig+LentHLzZMp1UpiVFzFKPd1budaqO
 1SgCO/zoz4drroUgmI8RTxD2E+jQhHi/B5quyk1PRBvDXby6kTvPY2WHvzoUYq1TMouM
 JsI6gJ/52gP3rcY+UCJ3aPegz7KJLIKg+sxhiMewk3cHNyaqicy1EvUg4JCCdTkxGlRm
 vZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782853213; x=1783458013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EgCyGv30NMm39mWfJMCDXGwOAoiuN8E+w++th3P1d4Y=;
 b=dPAlh1TQ88arkdn+jbPHYS5MHwa784Rat8VWot4SQMpB1gd4rc8Y/x0HpCYlBoq43f
 RB5u77mhpz4THqELHhWYQXkMVP/3VwxN4s0ereuw6CENwAkKd3d0b2tkM6cy4Q8WbGa7
 Jbs0BPhHxC8WKGn5AFG69y4Z6uYjhmlrXWDgzYsyC57M7F+laxnYAc+IYYGHqV0CuSre
 UJWK52LNVcXsTTI/Nvi6z4yuuhkdbHlUsx/CwQAlHvyo/MClkeFscFE/69O++uBuO8aQ
 /DrEXPezFH1L3MJsqROkaz1E+m6Hxk16B/Qgz8hhR02fEuIc7P6zGFYH3+YVBSGdOmv5
 6foQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xrF6TBO2+n0R1k+sdWcTLmXFO0B8EGVYFPSad1uvAOPQZh/PSVpA7O9bQVUF5Nnhoxf994f52wLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiKoOw0PPLxWCvp51b6gn4V7D9wBM9YXmRZP4ChdmoDGN3tDBx
 7kbRCq993GB4tlyC8HPC+oT2iaUOQxOpp05CmYr8vaEFLquij85atF1rC1dieWRj/ar+DUzdUIT
 +OdNwOv2sval/uKX3z4GXr7jWcLAx03Q=
X-Gm-Gg: AfdE7ckEaC5s5r522oMiU90ViELUd7rZ/jJ8ldX0Og3p/UIP9OIDmlo3iqgDJAMfymd
 agre8uRpAPFI8Pf2RWcbHVGfnYG1O9SBNN0zauonN7m+F0uLHA6bcDmqkdwMy2KlHoC9WylzUvE
 RlIfuYPiPnxovFRKD99m74H4Wf74UE4mQHuSwE9Fi9OK98PUtYR1T+mGZUhMBZLtToTsadWY8l7
 Xn1Fs09hNW4sb5hp2i+o/+4FJ0NscHTR1TAsoj43xWsFMQ8cj44darGlFBdE6R21uRbIvjn1TJ7
 HxrvhaSXkD66WH2pDTzRrE8KN8rKvjmotNbKKY6Kl8w2Myp/qUr0O+9HSw==
X-Received: by 2002:a05:620a:40cd:b0:920:33be:6b8f with SMTP id
 af79cd13be357-92e6249e10bmr936458885a.15.1782853213141; Tue, 30 Jun 2026
 14:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
 <20260630115150.GD7481@nvidia.com>
 <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
In-Reply-To: <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 1 Jul 2026 07:00:01 +1000
X-Gm-Features: AVVi8Cc264cdsAwWcTNgXcSy4Dlde3raPUzh5BXDR3lW4spWmriH3ZokA0QJI48
Message-ID: <CAPM=9ty=fiCTrfwE4VUGUDak7paNcKwVo9t171FyYP4VyGM=4A@mail.gmail.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>, iommu@lists.linux-foundation.org, 
 Alistair Popple <apopple@nvidia.com>, Matthew Brost <matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 1 Jul 2026 at 06:45, Dave Airlie <airlied@gmail.com> wrote:
>
> On Tue, 30 Jun 2026 at 21:51, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Jun 30, 2026 at 01:24:57PM +0200, Christian K=C3=B6nig wrote:
> >
> > > > Today I finally hit up iommu.strict=3D1 makes things a lot happier,
> > > > non-strict IOMMU seems to allow a race between dma_unmap_page and
> > > > free_page where the unmap goes into the IOMMU flush queue, where th=
e
> > > > actual unmap are delayed until something triggers a flush later, an=
d
> > > > the ATS translations stay alive past when they should, and after th=
e
> > > > page has been allocated by some subsequent user.
> > >
> > > Try disabling ATS, that was a common source of problems during HW
> > > bringup for us in the past.
> >
> > The spark HW cannot run without ATS.
> >
> > > > 2. split ttm page unmap/free into two stages, and force an iommu
> > > > flush/ATS sync operation after the unmap before the free. (I don't
> > > > think iommu has an interface for this).
> > >
> > > Yeah that idea already came up on similar issues as well. I
> > > certainly wouldn't be opposed to that.
> >
> > Only for debugging, it is completely wrong to rely on this for
> > functionality.
> >
> > > You either have to use memory fences which use the same path as the
> > > DMA operations itself
> >
> > Yes, in a PCIe system generally something like the GPU TLB
> > invalidation command will complete and flush the fabric path to quiet
> > the DMAs. That won't be true on spark though.
> >
> > Dave could be facing a fabric issue. AFAIK the ATS invalidation that
> > the iommu=3Dstrict pushses should fence the fabric so would resolve a
> > missing fabric fence. I suppose if you don't see any evidence of a
> > non-present ATS response explosion with strict then this would be a
> > really good theory.
>
> It's definitely a fabric issue, the iommu ATS invalidation is what
> "fixes" it, but I'm not figuring out how to flush it from the GPU
> side, and I'm not seeing where the official driver does this either,
> guess I have to keep digging. Maybe Alistair knows something.
>
> >
> > However, the GPU must have another way to inject a fabric fence. The
> > production driver does not rely on ATS fencing to synchronize memory
> > operations!

From the production driver, there definitely was some issues in the
past, however this seems possibly fixed with mmu notifiers, but for
these memory allocations I'm doing I'm not using MMU notifiers at all.

#if defined(NV_MMU_NOTIFIER_OPS_HAS_ARCH_INVALIDATE_SECONDARY_TLBS)
    #define UVM_ATS_SMMU_WAR_REQUIRED() 0
#elif NVCPU_IS_AARCH64
    #define UVM_ATS_SMMU_WAR_REQUIRED() 1
#else
    #define UVM_ATS_SMMU_WAR_REQUIRED() 0
#endif

#if UVM_ATS_SMMU_WAR_REQUIRED()
void uvm_ats_smmu_invalidate_tlbs(uvm_gpu_va_space_t *gpu_va_space,
NvU64 addr, size_t size)
{
    struct mm_struct *mm =3D gpu_va_space->va_space->va_space_mm.mm;
    uvm_parent_gpu_t *parent_gpu =3D gpu_va_space->gpu->parent;
    struct {
        NvU64 low;
        NvU64 high;
    } *vcmdq;
    unsigned long vcmdq_prod;
    NvU64 end;
    uvm_spin_loop_t spin;
    NvU16 asid;

    if (!parent_gpu->ats.smmu_war.smmu_cmdqv_base)
        return;

    asid =3D arm64_mm_context_get(mm);
    vcmdq =3D kmap(parent_gpu->ats.smmu_war.smmu_cmdq);
    uvm_mutex_lock(&parent_gpu->ats.smmu_war.smmu_lock);
    vcmdq_prod =3D parent_gpu->ats.smmu_war.smmu_prod;

    // Our queue management is very simple. The mutex prevents multiple
    // producers writing to the queue and all our commands require waiting =
for
    // the queue to drain so we know it's empty. If we can't fit enough com=
mands
    // in the queue we just invalidate the whole ASID.
    //
    // The command queue is a cirular buffer with the MSB representing a wr=
ap
    // bit that must toggle on each wrap. See the SMMU architecture
    // specification for more details.
    //
    // SMMU_VCMDQ_CMDQ_ENTRIES - 1 because we need to leave space for the
    // CMD_SYNC.
    if ((size >> PAGE_SHIFT) > min(UVM_MAX_TLBI_OPS,
SMMU_VCMDQ_CMDQ_ENTRIES - 1)) {
        vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].low =3D CMDQ_OP_TLBI_EL=
2_ASID;
        vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].low |=3D (NvU64) asid <=
< 48;
        vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].high =3D 0;
        vcmdq_prod++;
    }
    else {
        for (end =3D addr + size; addr < end; addr +=3D PAGE_SIZE) {
            vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].low =3D
CMDQ_OP_TLBI_EL2_VA;
            vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].low |=3D (NvU64)
asid << 48;
            vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].high =3D addr &
~((1UL << 12) - 1);
            vcmdq_prod++;
        }
    }

    vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].low =3D CMDQ_OP_CMD_SYNC;
    vcmdq[vcmdq_prod % SMMU_VCMDQ_CMDQ_ENTRIES].high =3D 0x0;
    vcmdq_prod++;

    // MSB is the wrap bit
    vcmdq_prod &=3D (1UL << (SMMU_VCMDQ_CMDQ_BASE_LOG2SIZE + 1)) - 1;
    parent_gpu->ats.smmu_war.smmu_prod =3D vcmdq_prod;
    smmu_vcmdq_write32(parent_gpu->ats.smmu_war.smmu_cmdqv_base,
SMMU_VCMDQ_PROD, parent_gpu->ats.smmu_war.smmu_prod);

    UVM_SPIN_WHILE(
        (smmu_vcmdq_read32(parent_gpu->ats.smmu_war.smmu_cmdqv_base,
SMMU_VCMDQ_CONS) & GENMASK(19, 0)) !=3D vcmdq_prod,
        &spin);

    uvm_mutex_unlock(&parent_gpu->ats.smmu_war.smmu_lock);
    kunmap(parent_gpu->ats.smmu_war.smmu_cmdq);
    arm64_mm_context_put(mm);
}
#endif
