Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5673C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0230E10E2A2;
	Tue, 14 Jul 2026 06:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="FQZv3bkz";
	dkim-atps=neutral
X-Greylist: delayed 476 seconds by postgrey-1.36 at gabe;
 Tue, 14 Jul 2026 06:46:49 UTC
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A7610E2A2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:46:49 +0000 (UTC)
X-Forwarded-Encrypted: i=1;
 AHgh+RplJm8dvKF3csxxAsGyv10GN6YDN54jjhfu+SpSsi4w/vOmWWcRQYhzSiRcnmt4K5UWgG1y9UanoLM=@lists.freedesktop.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784011131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwXrIUkjii1ll+DVDzD6pSQxEm1jWrnB4GfLjhOhNmE=;
 b=FQZv3bkzBH736Guoj2IMrcQO1CsXjjVHBhY3bBTw2kwQUgJEWM9XAiLfgPC8jHV0zllvsJ
 Ai3Bw1J7DVVYAZFq0RuwC/BpENoRqleln2aqnIQyi8AfbwZgS4jMl4uDZI/URI+SZk20aM
 UvqWaemAKXufjivC7BkULw5FXM+B9z8=
X-Gm-Message-State: AOJu0YxOMRPsWgW3yq70JC7vQY0PT8h60bN9HDidFh6KAk9VRI28sBUK
 m5wzjMARF6CGV+T0IFAecK3oW+lG/oDulv60ncqaiJyXrueHnd4KJmebtGzjeQ+sanAQX6/uloy
 b7TNcmabh58kiN6NEVO/KL/DF0ahmwXjZjQUCtr+6
X-Received: by 2002:ac8:5d56:0:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-51d7bcd4bb1mr10963351cf.9.1784011118743; Mon, 13 Jul 2026
 23:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com>
 <20260713191727.GH674038@nvidia.com>
In-Reply-To: <20260713191727.GH674038@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 14 Jul 2026 07:38:01 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxZ0N3Tfnid404B4tkb_E+Z8mODTHTgBPiF6=bwZp7Hjw@mail.gmail.com>
X-Gm-Features: AUfX_mxAW6jRYwmHaZyFKiL0Q4hnn-XRmxgnYdjCPArDIPvmYwpLrjGWtt2STE0
Message-ID: <CA+EHjTxZ0N3Tfnid404B4tkb_E+Z8mODTHTgBPiF6=bwZp7Hjw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 kvm@vger.kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
 pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com, 
 dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com, yilun.xu@intel.com, 
 linux-kernel@vger.kernel.org, lukas@wunner.de, yan.y.zhao@intel.com, 
 daniel.vetter@ffwll.ch, leon@kernel.org, baolu.lu@linux.intel.com, 
 zhenzhong.duan@intel.com, tao1.su@intel.com, linux-pci@vger.kernel.org, 
 zhiw@nvidia.com, simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
 aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT
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

On Mon, 13 Jul 2026 at 20:17, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Jul 13, 2026 at 08:08:14PM +0100, Fuad Tabba wrote:
> > On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
> > >
> > > Jason Gunthorpe <jgg@nvidia.com> writes:
> > >
> > > > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
> > > >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
> > > >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
> > > >> importers to fetch these data. Exporters identify VFIO dma-buf by
> > > >> successfully getting these data.
> > > >>
> > > >> VFIO dma-buf supports disabling host access to these exported MMIO
> > > >> regions when the device is converted to private. Exporters like KVM
> > > >> need to identify this type of dma-buf to decide if it is good to use.
> > > >> KVM only allows host unaccessible MMIO regions been mapped in private
> > > >> roots.
> > > >>
> > > >> Export struct kvm * handler attached to the vfio device. This
> > > >> allows KVM to do another sanity check. MMIO should only be assigned to
> > > >> a CoCo VM if its owner device is already assigned to the same VM.
> > > >
> > > > This doesn't seem right, it should be encapsulated into the standard
> > > > DMABUF API in some way.
> > > >
> > >
> > > I'd like to propose an alternative. I've been working on guest_memfd and
> > > new to the world of IO, please help me along! :)
> > >
> > > It seems like using dmabufs are used a little awkwardly here. IIUC
> > > dmabufs were originally meant to expose memory of one device to another
> > > device, mostly meant to share memory. Dmabufs do expose MMIO too, for
> > > device to device communications. Without virtualization, userspace MMIO
> > > would be done by mmap()-ing a VFIO fd and having the userspace program
> > > write to the userspace addresses.
> > >
> > > Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
> > > VFIO fd and setting up the userspace address in a KVM memslot for the
> > > guest.
> > >
> > > With CoCo, is the problem we're solving that we want KVM to know what
> > > pfns to set up in stage 2 page tables, but not via userspace addresses?
> > >
> > > guest_memfd already does that for regular host memory, tracks the
> > > private/shared-ness of the memory, tracks which struct kvm the memory
> > > belongs to.
> > >
> > > guest_memfd functions as KVM's bridge to host memory. KVM already can
> > > ask guest_memfd for the pfn to map into stage 2 page tables, and already
> > > asks guest_memfd for the shared/private state of the memory. guest_memfd
> > > already also blocks the host from faulting guest private memory
> > > (mmap()-ing is always allowed).
> > >
> > >
> > > Instead of using dmabuf as the intermediary between the MMIO PFNs and
> > > KVM, why not use guest_memfd?
> > >
> > > What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?
> >
> > This is interesting for pKVM too, provided it covers more than MMIO.
> >
> > We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
> > only for device MMIO. There is mobile hardware that doesn't tolerate scattered
> > private memory (DMA engines that can't gather, IOMMU page-table size
> > constraints), and a CMA-backed dmabuf heap is the practical way to get
> > contiguous memory at runtime.
>
> Why can't guestmemfd allocate directly from CMA? Allocating struct
> page memory through dmabuf just to put it back in a guestmemfd sounds
> very ugly to me.

Fair, and I think you're right. If guest_memfd can allocate from CMA directly
that covers what we need for contiguous guest memory, and it's cleaner than
routing it through a dmabuf. It also keeps the shared pages struct-page backed
and GUP-able, which the CMA heap's own mmap doesn't, since it sets VM_PFNMAP.
So going through a dmabuf for plain guest RAM would have cost us the thing we
need on the shared side anyway.

Consider the request to be for guest_memfd to be able to give us physically
contiguous memory. dmabuf was the mechanism I assumed, not the requirement.


> > HugeTLB doesn't help, it wants boot-time
> > reservation. Those pages are struct-page backed, so it's a different problem
> > from the non-struct-page MMIO case, and the shared parts still need to be
> > GUP-able.
>
> Isn't dmabuf pretty allergic to mmaping refcounted struct page backed
> memory since that wrecks its lifetime model?

Yes, and that's the same point. Agreed.

> > More important for the API shape: conversions have to work on subsets of such a
> > region, at page granularity. A pKVM guest doesn't know what backs its memory, so
> > it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
> > given. If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
> > use it for memory, and the guest can't be taught to care.
>
> More reasons not to involve DMABUF since guestmemfd already does all
> of this...

Also agreed for guest RAM.

Where I do still think a dmabuf is involved is the case where the buffer isn't
guest_memfd's to allocate: it already belongs to another exporter, and the guest
needs to see that same buffer. That's structurally what you're already handling
for device memory rather than a separate guest_memfd-over-dmabuf path, so I
don't think it argues for backing ordinary guest memory with a dmabuf.

> Jason
