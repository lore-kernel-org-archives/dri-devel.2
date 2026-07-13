Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD877C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E62710E36C;
	Mon, 13 Jul 2026 22:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qtGANoHi";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382B510E36C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 22:40:23 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so62946166b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783982421; cv=none;
 d=google.com; s=arc-20260327;
 b=mLTav+L6gLCkxQ99rQ27L+3NcJk58NO47U6HP26ysDYKuKv4L0bftfvfraWJx7aQIX
 8Y0wKkGZ7z77wBsds04kFbX2LWm0y2CdeHlMIRAnSls9o2sVeE2R7rgVu+chzjUdIqzW
 e5d679OG8Ty+sqt5Qkms+cGH5lBkGMjew4Q0KItef7kZhG1SEK7VKcbq5zEZiKT2vaCN
 3eU1VMgPQFVzMSuOiIjRnBzpFU+eIKWKNZRYo3zjl6uABxsInZUNwrAWMs9gGwexvZjM
 M9Ln3DGDDNMOURd0ZqaWmkwpqO+B1K8o86+THsL8qsGcQqTEy+4otZZ9zOlLanXMoJgq
 L1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
 fh=vzJPB96mgRMt8W18Qgp2bs1b0SDF787Ds5KyxDQaiuM=;
 b=eet4iWHHyPtrOx5MOBXDtLJPh9OhFIy0MjoR8wvimoJST/B/AWi3dD5QirO3f8QkYc
 Tt7NF4mxPWKLQC6vAmM3N2Axa8CEmCQpG0QZ9zRiBKas4e3BsG7a8HeUAI3KCqFknXEe
 KRwyo1ffR2LKvx3DQmxZjya+cqu+oXSB+DS4Ck377dSPsjzuuRRzRSF/Emvjjr6aD5bL
 kMCIKTuA8nwg5fiF0bqiN0kyioB4GxjDZx5eKiVQcPyLTJD3KoYvx11iBfyrySGbo6t8
 SDaMAsolM8Kr4lNumMJlAK3+JwUlamFpnsS52TqmPEZNYr772OoM+Lekt31NImnxouig
 I08A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783982421; x=1784587221;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
 b=qtGANoHiJWKj6R23j3exYx0UGt1xlRr16xz82vhafHxNWBKXU1c+rL7tD5LubUZjUa
 s5TjryafeTasOl+py6zTH3DyE4xMjfW6ELWXHLOhYdTVswjyrz70O3psvlrS5CawVK0F
 baO81SJHym3seJtkpVg41sJvxhsxp+rzPOJugspJ86AWXONXT1HkleW8Hc8kubgooy9I
 IkXkBfBr3u6DfJ6H+6SjBucuskKEHVWYN4FvOXTu5++patr5DDT/QzMpBGUWTSHnjXIZ
 vAPz2lhGajg7VxX/LDP85eN/fib03HmRkFv8y+nGsRp3pYqZchcFv9Tk/rFDymGCrKb8
 90/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783982421; x=1784587221;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
 b=iHcZgYhQBFZyY6MNzYA85xGkLXGrFvFS/Z/zJKLrrM9bNRjs+7yNJ1Qe0a5ElCbBw3
 BgRKupb/7cC0qJZctNYYrktp/LOnEdubU2QGR/GgWAarcXFmHnRAi9JtKfKvzu/ikWRV
 5e/ouUu6DKnh8LRAuz2wdrPtDuB31Tm2vsL5LlZkV7tFFArCXHJ9hpVeSXFADkPOR2XO
 ugNpFVR9CxOmD19ndmSN1p/OFAusqe/Nid8NHQTTnRuOu/ujahCUcxBjkgl7Un1nR/7Z
 JVFPSAj5D+lHwrqRL3o2TKmWJaqklKrcS5GngSn79tjSln1UC6iviU7ERQ6vtBUOLkW7
 I5Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxf6wcQIgxEZVkbNUBwEAXbispHd9GLTHWaa7FTg0F3WDvq+apZDT7Fv6iUYVxKjf1NVR/LgYP0y8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEs90Sjmjo6DebvlpF0fpR7a9TZZiqtOA/OttD5/5lGi28w5GB
 jAqmxlhWAkMpQdGjyMAGa/BVp01zZoFaSZ7tPQpXlM0xyVRZt0adn0NlcKJEiuaHD0b/Gk4HMZ1
 Jh5S1GEy9nG0X/yVVVDbqSllQN6dMnKpdmz5vWZWY
X-Gm-Gg: AfdE7ckj8CmZ3NOTryox9FDb7B1YP/UFC96zw7W6bmJ8Z8wKj+njPLsdIANbr6Wn8XP
 jAPZ1J5U35cmAsDSwJK3ZAApuaIFknGxAuXgAwYyZyOrmMnbTDYLRM3FObGGToI5l1S8oLOU1eZ
 cGu5UJXl14lWk2MahWBWH5vuTdfOEImuyRvyTN+CfRg/IX1V6sO5LhdIPULB65E4LFVE9Y+WYSA
 cWh/cMagBtosztc9M8szmbbjs2lfNHdzMks0ZPJRK/mBy7HDqG/7wV8yq3POyvDATq4oXwG+Ml7
 a4Q/YvE3T+c0ua14jWAzOfdvyMn+NPbN2Btnr3wG20UyrlS/PTwU5fGX2+k=
X-Received: by 2002:a17:907:398c:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c161de05ceemr462764166b.0.1783982420699; Mon, 13 Jul 2026
 15:40:20 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260713191727.GH674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com>
 <20260713191727.GH674038@nvidia.com>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 15:40:18 -0700
X-Gm-Features: AVVi8CeLrPp9U0h6s0bW1dfkDuvwNQDlx835UcZJGSgXNK2eLWnyQH0juXRBY34
Message-ID: <CAEvNRgEvGmOK3dXD4qdw5uXYD2sXNEVGT9NV2Zz-4H8VPb+KUw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 sumit.semwal@linaro.org, 
 christian.koenig@amd.com, pbonzini@redhat.com, seanjc@google.com, 
 alex.williamson@redhat.com, dan.j.williams@intel.com, aik@amd.com, 
 linux-coco@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 vivek.kasireddy@intel.com, yilun.xu@intel.com, linux-kernel@vger.kernel.org, 
 lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, 
 leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com, 
 simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
 aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com, 
 fvdl@google.com
Content-Type: text/plain; charset="UTF-8"
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

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Jul 13, 2026 at 08:08:14PM +0100, Fuad Tabba wrote:
>> On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Jason Gunthorpe <jgg@nvidia.com> writes:
>> >
>> > > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> > >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> > >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> > >> importers to fetch these data. Exporters identify VFIO dma-buf by
>> > >> successfully getting these data.
>> > >>
>> > >> VFIO dma-buf supports disabling host access to these exported MMIO
>> > >> regions when the device is converted to private. Exporters like KVM
>> > >> need to identify this type of dma-buf to decide if it is good to use.
>> > >> KVM only allows host unaccessible MMIO regions been mapped in private
>> > >> roots.
>> > >>
>> > >> Export struct kvm * handler attached to the vfio device. This
>> > >> allows KVM to do another sanity check. MMIO should only be assigned to
>> > >> a CoCo VM if its owner device is already assigned to the same VM.
>> > >
>> > > This doesn't seem right, it should be encapsulated into the standard
>> > > DMABUF API in some way.
>> > >
>> >
>> > I'd like to propose an alternative. I've been working on guest_memfd and
>> > new to the world of IO, please help me along! :)
>> >
>> > It seems like using dmabufs are used a little awkwardly here. IIUC
>> > dmabufs were originally meant to expose memory of one device to another
>> > device, mostly meant to share memory. Dmabufs do expose MMIO too, for
>> > device to device communications. Without virtualization, userspace MMIO
>> > would be done by mmap()-ing a VFIO fd and having the userspace program
>> > write to the userspace addresses.
>> >
>> > Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
>> > VFIO fd and setting up the userspace address in a KVM memslot for the
>> > guest.
>> >
>> > With CoCo, is the problem we're solving that we want KVM to know what
>> > pfns to set up in stage 2 page tables, but not via userspace addresses?
>> >
>> > guest_memfd already does that for regular host memory, tracks the
>> > private/shared-ness of the memory, tracks which struct kvm the memory
>> > belongs to.
>> >
>> > guest_memfd functions as KVM's bridge to host memory. KVM already can
>> > ask guest_memfd for the pfn to map into stage 2 page tables, and already
>> > asks guest_memfd for the shared/private state of the memory. guest_memfd
>> > already also blocks the host from faulting guest private memory
>> > (mmap()-ing is always allowed).
>> >
>> >
>> > Instead of using dmabuf as the intermediary between the MMIO PFNs and
>> > KVM, why not use guest_memfd?
>> >
>> > What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?
>>
>> This is interesting for pKVM too, provided it covers more than MMIO.
>>
>> We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
>> only for device MMIO. There is mobile hardware that doesn't tolerate scattered
>> private memory (DMA engines that can't gather, IOMMU page-table size
>> constraints), and a CMA-backed dmabuf heap is the practical way to get
>> contiguous memory at runtime.
>
> Why can't guestmemfd allocate directly from CMA? Allocating struct
> page memory through dmabuf just to put it back in a guestmemfd sounds
> very ugly to me.
>

I'd like to understand this use case better too, is using CMA through
dmabuf basically because CMA doesn't really have a direct userspace
interface? As in, for HugeTLB there's fd = memfd_create(HUGETLB) and
HugeTLBfs fds, but not CMA?

I did hope for this API shape to extend beyong VFIO and HugeTLB to
anything that has an fd today, but Frank did bring up the counter point
that not all memory has an fd.

>> HugeTLB doesn't help, it wants boot-time
>> reservation. Those pages are struct-page backed, so it's a different problem
>> from the non-struct-page MMIO case, and the shared parts still need to be
>> GUP-able.
>
> Isn't dmabuf pretty allergic to mmaping refcounted struct page backed
> memory since that wrecks its lifetime model?
>
>> More important for the API shape: conversions have to work on subsets of such a
>> region, at page granularity. A pKVM guest doesn't know what backs its memory, so
>> it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
>> given.

For my future reference, does this mean for the CMA case, some page
splitting on conversion to shared (so each page can have its own
refcount to track users) will be necessary? (and merging)

>> If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
>> use it for memory, and the guest can't be taught to care.
>
> More reasons not to involve DMABUF since guestmemfd already does all
> of this...
>
> Jason
