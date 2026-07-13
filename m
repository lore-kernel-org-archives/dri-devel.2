Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E42FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEAC10E374;
	Mon, 13 Jul 2026 23:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VQvFIpw9";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE8A10E374
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 23:16:04 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1361792a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783984564; cv=none;
 d=google.com; s=arc-20260327;
 b=VwbAy/wZ7S7Cmxjbnqj265lDJZzKitk/VdFjhMhN5IKPuod8aC6+xe/tUDLaKh7gDr
 m50Gs/lmtM8djkrfOp0mq0CHCwDb3FSZlV6B3bJzfbCtxu7+XF4fluEh0CPbNa0Bh6yq
 NedMeXI6Xjjop5Cq+3isC5vxVjWH8w1wyD9yIX8Fe5Ctj3W6bIgyFz9AM0w3l2YXOY7w
 GNmxmZXQ4V889p+8mMTGomsT5pI258qEkDd6nhGE6fbBIX+93Dk0d7wjWBMMJfpbur21
 0264mU4pSAIbFEyN03KBUxu5+84hzBSGDs6MhGe4KidnwUdU5tlDFdNDegParDb9pNRv
 3pFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
 fh=wSMEt3efUrGL7bQylPkSgxS+sR0LTCkS6l0xy4Dr3es=;
 b=FJvKNvOGVbUTvgaGXvlFjkC/b11SfLo8Ra8cIaA59h0Ccrcz2NwnRuR0rzEWdmnBa3
 Lzkcn+PedEZsqaNVQ9GRiIdmyh5J9gbrIq64i4usn9JHaqCA2gduhRVeXnNmAzLkwAP9
 fSVw9H2vXR0Y4BwGwOa/DsbpThtRTbpK8c8hjksx+i2LUwxP0aC4QMx9lVzu2Wzfw9tj
 TH1h2clZsc8Ngk7ghsEwqovUFmYstohI7dQ2Ewk1NeBt4XRxxqlYm3VFrbwdZiiJ0N5h
 rr/+3QjeHqRL4/6eUvchfLIv+fM3UtvgZ3IEsyHvUQEYKUAXRnrSbyfjV7cIqc6LOERs
 7gPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783984564; x=1784589364;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
 b=VQvFIpw97XUntahkUGjryH+q+4VMWK9QTodcScMA1khND9HAReJqAKCGPWmloA7ttR
 0OjAvikjvpq69cK7Pq8Z3MXrNKrqb09ODnmoyOhNfIg1KT9lFPvTBEc0FlCTAssBQz8X
 CobyNRtM9aQKGjqsVbs48yk7nCv29hbGxJ9cf6S4p/Bnfdm2Vj+Y/ypmRV1XpXbfoaCQ
 7dR+1kjMbFZ01H+pV1XJlP6GB/48HQK4E1vHcP7JZ26ERymyXDhVI/+Mbwtu9dkAUxeW
 eHTQ95p5HWzVf9NAQmS7qaL7pWOgqvsmWJHnIPo8MxD3nXvam9xxq1WNUIX49cEfcIBJ
 1WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783984564; x=1784589364;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
 b=qnxnLO8asi4SpfRttnrYtrEjXBxrIt0b21bKKHS25l/8mgtBxkNaCDSxHQ8XDOpffz
 1Fhpr8F5LpuANjPGfrgZk86jIqZJuRZHP9F1dybXqj+ehDsAKpTq1uJlSSME1/xS6P1N
 iPhwL/2uFDfbqRZdAIozapqExHBr7zpAjG9s9O76itAQNP/CBxnJzTohpGtDY7l8Cb89
 wPQvloqmpfisah78gRR14IMjZJBxOd9MxesdhO6pWRAgw9jpMGOEmggCNriAx/pIywaR
 FOyC4cO/VlAxoNe1//s6AEd7/MAO3XmIwQbP+tq3gDdgK1MRGn+JXNcEDiMbjKFQDk18
 E6lA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdLv2hdo/Z86uNTIogQOPaqjrC5eFK7fDK5+tG4gZnbWOgkkH5Q9pfk6jTXa8wxqh6j7d4cKRyDLo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznu5Z5gewVhXd2frx1d3aaL6NpSBxmVCGMHMx1L5x9FjXzH6em
 JZFvNhzB13bXKgUxA2vPkK0IYkeGN6hRt+0dJstqF8FcK1KnUV8HGHnEyPn4PSruJB2X05bJU9i
 3Lvy0iS2oX4L1rNg8V49ElGxTLg3+O4Rg5HiN0Mht
X-Gm-Gg: AfdE7cmnn/hM61iRI5tPZMOcrywWEjJEFIXOA6pwmb4zkSiNfvVwmFvPcxHDl5/f0+F
 GBWi5UTcvZDk9P/QAgLDQmnm/9VBHCSa0WYujsxypKz9/o33iJsGNCw2IDYwIQUmiFvnRm/EnU8
 S0S/z8A0QCLFooKHv0brja/w4HmIJ6xgijl5vMpawSpM376/NYfB3L9bSYwmTuKWzDRYDUjZrTA
 zuZJp9ful8UpoQE3WN1q5lx+nf8YTHhQs5TkzW2dqX4mj/AS4MywNwOp3y/hJU9wUEGIdsEEWf3
 qTj7sGuvlr9mA3YfzrXVsl8BBT2pgLmLXddNpDnSD7KRoPi3kcjVGlQ7eFo=
X-Received: by 2002:a05:6a20:cd8f:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3c110a7b287mr11689858637.29.1783984563364; Mon, 13 Jul 2026
 16:16:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260712221934.GF674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 16:16:02 -0700
X-Gm-Features: AVVi8CczeGanVcGdhsy5HlDfD2XYPmjZautNceRH5dXiMXcxQCHaSODxjV4xdX8
Message-ID: <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Jason Gunthorpe <jgg@nvidia.com>
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
 aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
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

> On Sat, Jul 11, 2026 at 06:01:31PM -0700, Ackerley Tng wrote:
>
>> In the course of a CoCo guest's operation, will the guest need to
>> convert between private/shared MMIO? Will the guest need some pages
>> shared and others private? If these are required operations, guest_memfd
>> already provides the tracking and is going to have a conversion ioctl
>> very soon. Instead of further extending dmabuf to track more things, how
>> about letting guest_memfd track it?
>
> Use another FD type was sort of my fallback if we couldn't get DMABUF
> into something workable. I'm kind of surprised to see guestmemfd
> proposed as the other FD, but I don't know much about its insides.
>

For now guest_memfd only supports 4K pages, so the interfaces we're
interested in are:

+ The .fault() handler, which core mm calls to service any page
  faults. For this, guest_memfd first checks if the page is shared, and
  if so, proceeds to return a struct page.
    + For VFIO, guest_memfd could call vfio_pci_mmap_huge_fault() and do
      vmf_insert_pfn().
+ The kvm_gmem_get_pfn() function, which kvm calls to get a pfn and a
  max_order to set up stage 2 page tables. Now guest_memfd returns
  folio_pfn(folio) and max_order = 0 since guest_memfd only supports
  PAGE_SIZE pages now.
    + For VFIO, guest_memfd would need some way to get the PFN, so
      probably something like dma_buf_get_pfn_unlocked() [1], but
      probably from VFIO instead of dmabuf. Perhaps pci_resource_start()
      is good enough to get a pfn.

[1] https://lore.kernel.org/all/20250529053513.1592088-2-yilun.xu@linux.intel.com/

> If VFIO can create one

At guest_memfd creation time, guest_memfd is always created for a
KVM. This is the first place where it is bound to a kvm instance. This
is one place where it helps Yilun with Confidential VMs, so KVM can be
sure that the memory was meant for a specific CoCo kvm and not any VM.

I think it might be weird to have VFIO take a kvm fd to create a
guest_memfd?

I was thinking that the userspace VMM could do something like:

  int vfio_fd = open("/dev/vfio/devices/vfio0");
  int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });

and creating from a template fd would also disable/close the vfio_fd so
that the following will fail:

  addr = mmap(vfio_fd);  // Maybe this should fail too?
  *addr = 1;             // But this should definitely fail so that
                         // guest_memfd gets to block private writes.

> and fill it with MMIO physical addresses then
> maybe it is OK?
>
> Jason

What interface would be used fill a guest_memfd with MMIO physical
addresses?

When a vdev is associated with a vfio file, can some other vfio file be
created that can also do MMIO to the vdev's PFNs? Would I be able to set
something to block any future associations to those PFNs? This will help
guest_memfd to prevent any other writes to private PFNs.
