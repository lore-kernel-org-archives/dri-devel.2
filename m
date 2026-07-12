Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E2EC44506
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 01:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F6010E40C;
	Sun, 12 Jul 2026 01:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gFwK0IJG";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8AE10E40C
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 01:01:34 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1493611a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 18:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783818094; cv=none;
 d=google.com; s=arc-20260327;
 b=WHc6vOsAxzbe5vhpjazZXOllYOW7r4idPt93rbXgx84+hrheZxaJS55ENxfc1/cNwM
 JV1E7JJ7RujfxhjxYLsH28ywqQVgovIE/moDSVddOnGqRsQ+Yl4MkCaRJ2fAZ8aTxkpe
 elsqR74+zCBTjZxdbnh8mdveFgXp82EFCRivGM2eG0tjn/U3zJ7ZmUEG5cdXTeJT2Jna
 HS0/iIpxGv4rVauj5LyoqElG2ZlVLyy0+XOfiNZZY5prDIHjuZyn1M1rPwbCDSVgBGgY
 n+OjEcOWJyLIBR6GX47e7P7XFp7qBrUOSak140w6LjXqBgM51/gbRWgWpZsST/KodKSd
 7+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
 fh=EXPQ0wjnhSbb+PeYaYTsfW5EgERkfYMONf9nZyKIZtE=;
 b=D5xiDKHI7gldfY9jh+vsUeGmwmKh1m0Yp4K6CprcaZinIHktX8ocvK0iyvgujWbz81
 G5uNxFcglmpsrx4rZcDeETo9Y4w/diK3VY4G8RVIoFp94eof5xA1/oQUagxfyZKSu/uq
 noPwmQCXJYpanil0Nk15XQBcAdZRIY4V9qXjv9SwCNglKQb1Geg+FiWm9+zteyqAMuMv
 E1GkHVi5NZ1D6ax55FaHMvyTQxIBmU9bupkzbHx5ITysPXXdCsbrtz1aRDyV7lThCIvz
 vZNhbKSNtrBvTb5ORbdy7tHKIeGbcvEpXVuzU2Yj4XWv9zzzgmgmedSDM5203PmrTvhl
 R56w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783818094; x=1784422894;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
 b=gFwK0IJGqEjN+sqT6f25AU5gwl/+cvaem3CpqnlHV7gXa7y6H6a5zgb/UB5jZ2DCkk
 V4Y+HxvsMcNpQKd8C3yyVCnRpK4orfIZ/BZAwjo08KP82nMKBFZRzA1Rmtw1kqYRk4AI
 oYb00rDFxOxhYM2Ps5bDh+WLhWCJfAyVCnnrbCL/iOqotDSUcThtMXgo5Y2TSPQF90I9
 bqfOPx8q27lgozB3kwa+afNWSNrz3N0GWvS7sVhQ4NQ5cS0Fc6A4HaUaY+IVxOR5+COE
 0i3Lterhv4UBJEUoPkDw0VTcLqpBdyk38sk8QaT9T9rRAvzh5MxbeiEg2HIUMdFkKNDk
 UZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783818094; x=1784422894;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
 b=BJph5RWtnQ3AVYSCHdTyVylLjboTJVNG2670CDzuXyZqykJo/v2ykk8q4iZviuc3ss
 P1SuPl2ioMJ2lFBSbZ8++79jHj2dc85qBBXXXXy5E5DAh8Zo6TdxcKMGnFrZhrQrFrq/
 AkNJxcL/Redo/6UG/7XM3Qc6Z/rgstoxE+KrAr1F2dlLm5fltxURKJNJToNTQPQn+Fek
 NlU5u86ZOHTSg8ufeU2bLwcWWRynwwT8HS0QH/uTs6l5+X4Ml7Zrxco8QhSrhSwLahTJ
 TGvYD3YVwY0p/h892hWb5syy7O4H1jv2jQS5okx9I56d8gDH+YfIjZM+fbPmr0KwZLJa
 4jgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiAU7xaPtvREEAqDpzXGsQV/MY3UDRzWfeoTzXX8ZQ7tB/HB1pWzfimPjnIY3KHsWj1KgzRgvL3vA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykYdFXVv9KKy+zOQSzk/iaPyTpG+t4ls/1PMyQ7cuEHN9OkzpM
 E1e0EwS/q4r+jEmWD8K+fIbf8OhIyfNYxjgnkHnX27HWdrUycTvqHvhPcTmVkcQiBJS/3qQjk6M
 TvkMVQcFvF2cHGUNwp0sjGvJo/40nhBv/FlcoWVo+
X-Gm-Gg: AfdE7cnd6AjaTfnwHn4XivVxlpeFUvrCwbjGF+qe8CArbhgclUdIZTzeQtjiTLCy2EU
 iv21t8qS54Bn9T70JJR1DKqcsJSS62Iuj0FWTv/5kFD7E+kXGJOZWWagS1gCaU/pFYYd+OjkAZ2
 xaJdvMTeOFT03hao4+jmFS8ExmWU6/ZUrw5Yk2B9KW/2cpahrj6pJFD+Hqr7fMlsD87m26bN0Nr
 9BR6ioT4xH3YC8NOEX/FtbOVl41ZU0Ea25sqfWU788P0xZRIRV+dHt3DcR4MfcIOwv2Bqn4qc1t
 4f7ARetbNOir5GU1hWGHV1McwMLM
X-Received: by 2002:a05:6a21:3990:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3c11075f8f6mr4812182637.9.1783818093599; Sat, 11 Jul 2026
 18:01:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20250602133009.GC233377@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
MIME-Version: 1.0
Date: Sat, 11 Jul 2026 18:01:31 -0700
X-Gm-Features: AVVi8Cd0bGOMjMsYrL4vU20fXx-xb2mKPsbs-m9K5p8jfizmd9no0laxFphKWjw
Message-ID: <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
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

> On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> importers to fetch these data. Exporters identify VFIO dma-buf by
>> successfully getting these data.
>>
>> VFIO dma-buf supports disabling host access to these exported MMIO
>> regions when the device is converted to private. Exporters like KVM
>> need to identify this type of dma-buf to decide if it is good to use.
>> KVM only allows host unaccessible MMIO regions been mapped in private
>> roots.
>>
>> Export struct kvm * handler attached to the vfio device. This
>> allows KVM to do another sanity check. MMIO should only be assigned to
>> a CoCo VM if its owner device is already assigned to the same VM.
>
> This doesn't seem right, it should be encapsulated into the standard
> DMABUF API in some way.
>

I'd like to propose an alternative. I've been working on guest_memfd and
new to the world of IO, please help me along! :)

It seems like using dmabufs are used a little awkwardly here. IIUC
dmabufs were originally meant to expose memory of one device to another
device, mostly meant to share memory. Dmabufs do expose MMIO too, for
device to device communications. Without virtualization, userspace MMIO
would be done by mmap()-ing a VFIO fd and having the userspace program
write to the userspace addresses.

Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
VFIO fd and setting up the userspace address in a KVM memslot for the
guest.

With CoCo, is the problem we're solving that we want KVM to know what
pfns to set up in stage 2 page tables, but not via userspace addresses?

guest_memfd already does that for regular host memory, tracks the
private/shared-ness of the memory, tracks which struct kvm the memory
belongs to.

guest_memfd functions as KVM's bridge to host memory. KVM already can
ask guest_memfd for the pfn to map into stage 2 page tables, and already
asks guest_memfd for the shared/private state of the memory. guest_memfd
already also blocks the host from faulting guest private memory
(mmap()-ing is always allowed).


Instead of using dmabuf as the intermediary between the MMIO PFNs and
KVM, why not use guest_memfd?

What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?

guest_memfd can then take the mmap() calls from userspace and .fault()
from mm, and then forward them to VFIO or dmabuf. This way, VFIO/dmabuf
can stick to their original functions, and the changes to VFIO/dmabuf
would probably revolve around disabling access.

Disabling access would probably involve some of these:

+ When guest_memfd receives the fd, it could return error for existing
  mappings, or perhaps it could just force-unmap.
+ 1 extra flag or field to indicate that guest_memfd is controlling this
  file, so that if userspace tries to take some actions with the
  original VFIO or dmabuf fd, the request should be blocked.
+ Perhaps just close the original fd, like dup2(oldfd, newfd) closes
  newfd?


I'm about to restart work on guest_memfd HugeTLB and I'm thinking about
a similar approach for guest_memfd HugeTLB, where perhaps the interface
could be that userspace will give guest_memfd a HugeTLB fd at creation
time, and then the original HugeTLB fd would be rendered unusable in the
same way as above, perhaps like with the S_IMMUTABLE inode flag, but
also blocking reads, and not userspace-modifiable.


In the course of a CoCo guest's operation, will the guest need to
convert between private/shared MMIO? Will the guest need some pages
shared and others private? If these are required operations, guest_memfd
already provides the tracking and is going to have a conversion ioctl
very soon. Instead of further extending dmabuf to track more things, how
about letting guest_memfd track it?
