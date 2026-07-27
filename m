Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F9C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B3710E093;
	Mon, 27 Jul 2026 18:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qXG5ZGrl";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F74410E093
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:53:57 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84e27035206so3032937b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785178437; cv=none;
 d=google.com; s=arc-20260327;
 b=PH/M3kzhTBwKcXyeOVQ58CctbqcdRiu4kGR9lr5u5C8xpmn4rPvbbvuZIzsRDlk38I
 t0ZNkVj3zi583IW/F6DRM9AH22HBSIlGmY8U+H8zbMjPMTUjhhRnR6+xEsI1wXja9PqM
 +6dIws4ETVhS4L95aKc5lqw0GSlFApFQk6TzhiSb6c4JVl8C+b628DLTuzIbE4eDUIeh
 +AfYxSoo8kyeChMeWIYP8nAqAL76amNIAm6XZBbRFwC4mY5/2T+3cpKkyEJ2taOVSn5H
 1NuYCpMU4F8XsoXxtYfPpnJjAj0WI9Q5Dd0MBQrQpleBMBwjchCTmYhPKcy4JejlfTnp
 xlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
 fh=HZI0I939twrxRuP1O6ZiH3edBIvx6zR5Ju+cRQWNK1M=;
 b=aS4vsI7fTJxU4g0z9WBER5pSjXk5lIMwWBvG24yhjk/Udp3gLk2FnpW5fMGbzlYHZA
 5fSG53aUI4uc5kmdkSUGr7h2Now+SI5YDmolh9j4Gc0oW2RlUy0fhccAVlyqfMb5GInS
 70tFrcQcg1zCFDHydYSFKvGMMgYIFxkRJXgm7iT5GN7JD/3g/0368GlmUcL4VRqoLeUG
 IXvg9KmcJg5XWAJn4gSw7eHYjy3nCPHhTGa3emkE+hdVqDSO9jWePzlFxhiBML6HOBif
 WHfGOYsns9Ifo0SltWEnl/h5W25T1hb+4Hu9qTwyrWQJe9xuHmJCYNBTxBmMBM1XDcz0
 Ac8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785178437; x=1785783237;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
 b=qXG5ZGrlWscn703UjBbrrckMxnNQ6w/rEYKZqmwGbH/LXXE60BLNBAEzaf6CyYp7mw
 iX48vYiV98Gr3CWmpPQ0j1LhpKXZlZvCAsfiFNGCqUZzSgn9+5ZCMZrM9BVQWgueYKO5
 uKYpieX0PcaL5zlc+AOXPYO6vjvciuVbpL4Rf5c9wB9fQwS52fq+Dn4U48a+dF/NtsAg
 pxwm9s0yPIxiNB08IRcPJzCFIxJsrTr0Lsn0O8fao8+oYlONLYnfzV40tT79esZbngBg
 A7mblzRkirVJ1GQuBZO1KNg0bagvKjmcURk1CIeh6BYAdCGojtSVFT0kfWNxVfF8HjxF
 xRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785178437; x=1785783237;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
 b=aqvfxu2U6Z85sKnYjjGL7Bn4tO299pI5jKcwD5XOGZ/aUz/sXKrkdgaoa3Dls+/DUL
 IAwQ+KkqALKcmiXMZLZETHjEVzBdmEQvZfwfcPG4g6TlbeXwBlqPPGTBZHodcC7qaNuE
 l8fxf3HV8pmdWaNVqZFblYwdKLegehRJz4NVgFxWjWHkE7k/Xfbk9wNwUOurP8GX1MWe
 MhEvGuIF2ZPODi5P6LYACtUdMUnpDj3eNaYvKhZlRH30eO7zuiNHwBTI0EvDw+YWiNtH
 3RPU6x1/C4n0MGJ3loceLUPdKGksNo4VUX6hX14FtOXDnjOSCgTowG0d/ePnpylz4SJ9
 WI7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8aOLGOCv73sj6d8K7Q8oqpldUW0OKyC8otrgzHrXskqLclexX6EWWF6EVqZKnBg/rD4+EDecEWRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgRUPRhNXt17E6sL0KhEzOUPYe0DVKzegO+8A5jAyFnVUULx9u
 MIefJJGHvuTmo7/RxUpRyIFGHwPx8BeZ78DsXRfS/oaBf+KwEEKEdYtDIxEeaQeKbPLIk7abNOv
 XJt0HWrohnZMYxJLZ4e8rTL8pbfXxv9ncWm6+EKa2
X-Gm-Gg: AR+sD13it2kdO5CqIvgEos8sc+nVe0biMM2i4QflAKPLrVQdq9CwdimrEqu67eAZGQp
 jpy3HvpyVTE3qXnnz2K+3P6GQkruUMtsK51J630SbUUP2qUfRcvqGxM2Cigo717EGUcC5tsL5x9
 EOBkmEWKLfuBezfVrB3O7k4h2sbbaKFuehv0IUdbb+p1nqg8jwaXh/ztX10lq0sAz4e4Fv8l9oc
 y2EHt3Td89wF/AAQ6tddZxIHbxYNODZ1Efq2+B2JGqHVoHc1eDeFaidYnmtK1/rzFtgw7O9eejK
 6Dn1nQpVEpMwa8YoYod6I9lJceDx/XSiyfnj7pQnP3060L5E
X-Received: by 2002:a05:6a20:6a05:b0:3c3:7a0a:18a7 with SMTP id
 adf61e73a8af0-3c6c7fb20d4mr796670637.55.1785178436210; Mon, 27 Jul 2026
 11:53:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com>
 <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
 <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 11:53:55 -0700
X-Gm-Features: AUfX_mylYj_x8eQp0BvgfyW8gHfhB_jFskLbUbWzV0Fgf00qZT4Qn9h3hPlqeKo
Message-ID: <CAEvNRgGYc0B1YyhDhS0Khfm3N85hbkYGMTfDLiXYn+WHTLF2EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for
 importers
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
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

Xu Yilun <yilun.xu@linux.intel.com> writes:

>> > If VFIO can create one
>
> It is an interesting idea to let VFIO create a guest_memfd instance, if
> DMABUF doesn't work. But to achieve this goal, I think we still need to
> refactor guest_memfd to allow for different memory/MMIO resource
> exporters/creators, and different resource importers/users like KVM MMU
> & IOMMUFD.
>

Yup I think both ways we'd need some level of integration from both
sides :)

>>
>> At guest_memfd creation time, guest_memfd is always created for a
>> KVM. This is the first place where it is bound to a kvm instance. This
>> is one place where it helps Yilun with Confidential VMs, so KVM can be
>> sure that the memory was meant for a specific CoCo kvm and not any VM.
>>
>> I think it might be weird to have VFIO take a kvm fd to create a
>> guest_memfd?
>
> I think having VFIO create a guest_memfd is better than having KVM
> create a guest_memfd on behalf of VFIO.
>
> The lifecycle of the MMIO resources should be managed by VFIO, cause
> the availability of these MMIO resouces are impacted by device
> operations, e.g., device reset, PCI Memory Space Enable (MSE) ...
> You can't export MMIO resources to KVM MMU without VFIO's awareness.
>

Thanks for explaining the above!

Do you mean that as long as VFIO knows that some addresses are not
usable, those addressses have to be removed from the stage 2 page tables
that KVM manages?

> And VFIO doesn't have to take a kvm fd paramter to create a guest_memfd,
> VFIO has got the kvm instance via KVM_DEV_VFIO_FILE_ADD.
>

I'm new to this - looks to me KVM_DEV_VFIO_FILE_ADD is for linking VFIO
to KVM but some mmap-ing is also required (pre-CoCo) to set up memslots?

With CoCo, setting up memslots would use some fd (guest_memfd wrapping
VFIO or the VFIO-created guest_memfd like you were suggesting) and I'd
think there will still be some notifiers between KVM and VFIO for the
mapping.

Btw is it right to say that KVM_DEV_VFIO_FILE_ADD is only in the case of
setting up irqchip? Is irqchip a requirement for Confidential IO?


Hope you also had a chance to look at [1] that David Woodhouse is
working on :)

[1] https://lore.kernel.org/all/1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org/

>>
>> I was thinking that the userspace VMM could do something like:
>>
>>   int vfio_fd = open("/dev/vfio/devices/vfio0");
>>   int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });
