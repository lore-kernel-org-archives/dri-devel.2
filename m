Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF68C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7EB10EACC;
	Mon, 13 Jul 2026 19:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="BXZb1gx3";
	dkim-atps=neutral
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB3210EAED
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:09:16 +0000 (UTC)
X-Forwarded-Encrypted: i=1;
 AHgh+RpC1meIXmD+nc6pjna6NBKCoO70GPTMS8gfJ5r1TpNXyaaXraR/rCmUGoWD+M0rc7MXe57yk0q0vhE=@lists.freedesktop.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783969753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+3EWmrn9TlytCVwvSjefnIQTVg7nZtucIhvwx2Wfn4=;
 b=BXZb1gx3NFj8vrIgM4HSurMjir1DehFEYbaDkgEeNAGxi2bY9KyMknwlhWstC+mbS2DNuX
 d0R/lhCBEkMfSmNNjroLUNKYHnlfG+pEHEP8/KooQn7qV/Cb7dNWpe2l9VA08tDrDSq/DC
 MbFbsE3NiJxBAmZ6y9qWAbPQs/xayiA=
X-Gm-Message-State: AOJu0YwSKyKgKBaSXqoIK3tX63kh7yrA2gi5scXKhQhVp8m3Y3WoqMlj
 +tqmGEuGiIVxrK+Ubsx8am3SxawNTnnDm7e1Wc7lM7cw+AEOhyWjLvyjSsOZBdkWXsegYzB9ZRQ
 SchhVBcBoCOZmAD1cK0H1wJQKWhUZpXRoHmWlQJE+
X-Received: by 2002:a05:622a:4d47:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51d7bc5094cmr5957821cf.10.1783969731978; Mon, 13 Jul 2026
 12:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
In-Reply-To: <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 13 Jul 2026 20:08:14 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com>
X-Gm-Features: AUfX_mw-84x_DmgF59r9sD3Wt_uWXnd6_ELlU4FK10Faaz6XnikTNIHgvUm1jO4
Message-ID: <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Ackerley Tng <ackerleytng@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 kvm@vger.kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, pbonzini@redhat.com, 
 seanjc@google.com, alex.williamson@redhat.com, dan.j.williams@intel.com, 
 aik@amd.com, linux-coco@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 vivek.kasireddy@intel.com, yilun.xu@intel.com, linux-kernel@vger.kernel.org, 
 lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, 
 leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com, 
 simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
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

On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Jason Gunthorpe <jgg@nvidia.com> writes:
>
> > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
> >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
> >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
> >> importers to fetch these data. Exporters identify VFIO dma-buf by
> >> successfully getting these data.
> >>
> >> VFIO dma-buf supports disabling host access to these exported MMIO
> >> regions when the device is converted to private. Exporters like KVM
> >> need to identify this type of dma-buf to decide if it is good to use.
> >> KVM only allows host unaccessible MMIO regions been mapped in private
> >> roots.
> >>
> >> Export struct kvm * handler attached to the vfio device. This
> >> allows KVM to do another sanity check. MMIO should only be assigned to
> >> a CoCo VM if its owner device is already assigned to the same VM.
> >
> > This doesn't seem right, it should be encapsulated into the standard
> > DMABUF API in some way.
> >
>
> I'd like to propose an alternative. I've been working on guest_memfd and
> new to the world of IO, please help me along! :)
>
> It seems like using dmabufs are used a little awkwardly here. IIUC
> dmabufs were originally meant to expose memory of one device to another
> device, mostly meant to share memory. Dmabufs do expose MMIO too, for
> device to device communications. Without virtualization, userspace MMIO
> would be done by mmap()-ing a VFIO fd and having the userspace program
> write to the userspace addresses.
>
> Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
> VFIO fd and setting up the userspace address in a KVM memslot for the
> guest.
>
> With CoCo, is the problem we're solving that we want KVM to know what
> pfns to set up in stage 2 page tables, but not via userspace addresses?
>
> guest_memfd already does that for regular host memory, tracks the
> private/shared-ness of the memory, tracks which struct kvm the memory
> belongs to.
>
> guest_memfd functions as KVM's bridge to host memory. KVM already can
> ask guest_memfd for the pfn to map into stage 2 page tables, and already
> asks guest_memfd for the shared/private state of the memory. guest_memfd
> already also blocks the host from faulting guest private memory
> (mmap()-ing is always allowed).
>
>
> Instead of using dmabuf as the intermediary between the MMIO PFNs and
> KVM, why not use guest_memfd?
>
> What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?

This is interesting for pKVM too, provided it covers more than MMIO.

We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
only for device MMIO. There is mobile hardware that doesn't tolerate scattered
private memory (DMA engines that can't gather, IOMMU page-table size
constraints), and a CMA-backed dmabuf heap is the practical way to get
contiguous memory at runtime. HugeTLB doesn't help, it wants boot-time
reservation. Those pages are struct-page backed, so it's a different problem
from the non-struct-page MMIO case, and the shared parts still need to be
GUP-able.

More important for the API shape: conversions have to work on subsets of such a
region, at page granularity. A pKVM guest doesn't know what backs its memory, so
it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
given. If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
use it for memory, and the guest can't be taught to care.

Quentin made both points on the in-place conversion series [1], and covered the
wider framing at KVM Forum [2].

Cheers,
/fuad

[1] https://lore.kernel.org/all/od4dx6snqsl2qiocgf3jxm4dndxhrlvsfr22eveuno6nskgfdj@mxsywvku2jk5/
[2] https://www.youtube.com/watch?v=zaBxoyRepzA

>
> guest_memfd can then take the mmap() calls from userspace and .fault()
> from mm, and then forward them to VFIO or dmabuf. This way, VFIO/dmabuf
> can stick to their original functions, and the changes to VFIO/dmabuf
> would probably revolve around disabling access.
>
> Disabling access would probably involve some of these:
>
> + When guest_memfd receives the fd, it could return error for existing
>   mappings, or perhaps it could just force-unmap.
> + 1 extra flag or field to indicate that guest_memfd is controlling this
>   file, so that if userspace tries to take some actions with the
>   original VFIO or dmabuf fd, the request should be blocked.
> + Perhaps just close the original fd, like dup2(oldfd, newfd) closes
>   newfd?
>
>
> I'm about to restart work on guest_memfd HugeTLB and I'm thinking about
> a similar approach for guest_memfd HugeTLB, where perhaps the interface
> could be that userspace will give guest_memfd a HugeTLB fd at creation
> time, and then the original HugeTLB fd would be rendered unusable in the
> same way as above, perhaps like with the S_IMMUTABLE inode flag, but
> also blocking reads, and not userspace-modifiable.
>
>
> In the course of a CoCo guest's operation, will the guest need to
> convert between private/shared MMIO? Will the guest need some pages
> shared and others private? If these are required operations, guest_memfd
> already provides the tracking and is going to have a conversion ioctl
> very soon. Instead of further extending dmabuf to track more things, how
> about letting guest_memfd track it?
>
