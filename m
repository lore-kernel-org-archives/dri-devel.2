Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A573FD8769
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB54310E229;
	Tue, 17 Mar 2026 13:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VBMBGuKA";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5098110E229
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 13:24:19 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4852ef20fe8so59015e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773753858; x=1774358658;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zWZeNHlOMbvwVmHsivYMTEHjYjPNUndT05044cKL2Xs=;
 b=VBMBGuKAqBp91sSEWbnTFFpecjM0MSjOX7RbUKzd/Ld4r1M+3FdFTEaCMMayhh4pqd
 wuAUcS7EMERnz7s3Q8wJsv9nP4DU07Prh2WXL4BR/Cbbnf/n1nhNLS6jmcbk2IeJXibJ
 1quQbcoJcg4OY2RnlEFv6bY1adLWCqN9Ya9XluGQSgUu7ZFZrNsEdgSRP6pRTnTd/sV3
 EuAZPlOmouyoSG6KRRDcrB8RmBB1fnM87A4c+lWYxQO+P95BqyKYsAqO6mhI+sLccbPg
 QF0Zb84T6nMFjdHpSrUb0a79bIRtReiZ+jWdGjvPZW4nyPTXxEobqIHiowPHDu/HnsGa
 IlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773753858; x=1774358658;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zWZeNHlOMbvwVmHsivYMTEHjYjPNUndT05044cKL2Xs=;
 b=DWLjjSdDyn+nj2jFrTruzX4WGFtgkoSGskRJbw2KsWW9UXcqABn91T8h4sRdzQid07
 cOMkn2OotnWKJ5z8y/xWM0S+63sumXLojGqiL0Hydn6G5hWniqf8Vj+UDa47bYTTxXvt
 sBxaVD39LZZclBlEg2VaNWfmU51lPdA9Aa59WZ9ed670Reyr7YWy9JG1s4GyCYg5AZTA
 S2hofVqrOzK8+GIqvhlHWb/kwY/qRyIIl46+H5FkZXTUIJFbI1F1r4HZ9OvrsYQyOQ20
 vO+BQQ3IDWoCwjnJiwY5383+jcEEwU6P2Lbgu7bR0PC9EoALVQ+KvFibmAswbu72EPXh
 n+8A==
X-Gm-Message-State: AOJu0YxI6cNr9CdPyq1cJ5ktbZ0Sdhn4gRUUGXNb1n3yqXBlvDq7h/ow
 aFvuz7i/qMnWNxCrv0H6HVNy2ow6rLfxDV7myxRv4kh5lERC6e8HYWq9hBkfgTqyHQ==
X-Gm-Gg: ATEYQzxNFqD7zU2I+U+0FvfVbfQxcxhwl7sjivacEK8Z/zHC/TYxfH3cm0d9QPAVH1n
 WlX6t45w6xQm21n3VcT/J2NoLlI6nzdNAkYp8Fokmf6JOpRcIXg62iJXEELDxjOhVE3UPhJx4gO
 xPpd/cNfPu1EluS6eK/Qh971fmgxbJaHLOdJyB7brgjSmqQUsP5HX8BAL/NgV9qWDzx891EJB20
 lbOPUHDJcPzUHoqDt6idR6g0FJlmwvRoBUz2TjfC5QJbuhNMQIN2EoEt0pelQR/poBxGCPIhVTU
 VzdszhLB+K4Sz9BNH33IpBvG9vG68G2xxJt8YvwuCXEnjUd19T/pkeWrIfQxYIMmScHTPQ1t0+p
 5tB+fXm0+SYnkg4chH0HLsoDWPoNaGIp6+7QjyKGGU5H80T2B5BfiRC8VV7CM6PhKZG9+CSpuRs
 oRLFjGjr6O5Qu0UGGrmNgCvOdi3aP7rMbjBxUfxfXFwW1uKB7LGKFYW2fe
X-Received: by 2002:a05:600c:4e45:b0:485:b6e4:9808 with SMTP id
 5b1f17b1804b1-485b6e49f7bmr773775e9.1.1773753857226; 
 Tue, 17 Mar 2026 06:24:17 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3322sm58975315e9.10.2026.03.17.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:24:16 -0700 (PDT)
Date: Tue, 17 Mar 2026 13:24:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, jgg@ziepe.ca, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <ablV_f_l7wD2m63E@google.com>
References: <20260305123641.164164-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305123641.164164-1-jiri@resnulli.us>
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

Hi Jiri,

On Thu, Mar 05, 2026 at 01:36:39PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> run with encrypted/protected memory which creates a challenge
> for devices that do not support DMA to it (no TDISP support).
> 
> For kernel-only DMA operations, swiotlb bounce buffering provides a
> transparent solution by copying data through decrypted memory.
> However, the only way to get this memory into userspace is via the DMA
> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> the use of the memory to a single DMA device, and is incompatible with
> pin_user_pages().
> 
> These limitations are particularly problematic for the RDMA subsystem
> which makes heavy use of pin_user_pages() and expects flexible memory
> usage between many different DMA devices.
> 
> This patch series enables userspace to explicitly request decrypted
> (shared) memory allocations from the dma-buf system heap.
> Userspace can mmap this memory and pass the dma-buf fd to other
> existing importers such as RDMA or DRM devices to access the
> memory. The DMA API is improved to allow the dma heap exporter to DMA
> map the shared memory to each importing device.

I have been looking into a similar problem with restricted-dma[1] and
the inability of the DMA API to recognize that a block of memory is
already decrypted.

However, in your case, adding a new attr “DMA_ATTR_CC_DECRYPTED” works
well as dma-buf owns the memory, and is both responsible for the
set_memory_decrypted() and passing the DMA attrs.

On the other hand, for restricted-dma, the memory decryption is deep
in the DMA direct memory allocation and the DMA API callers (for ex
virtio drivers) are clueless about it and can’t pass any attrs.
My proposal was specific to restricted-dma and won’t work for your case.

I am wondering if the kernel should have a more solid, unified method
for identifying already-decrypted memory instead. Perhaps we need a
way for the DMA API to natively recognize the encryption state of a
physical page (working alongside force_dma_unencrypted(dev)), rather
than relying on caller-provided attributes?

[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com/

Thanks,
Mostafa


> 
> Jiri Pirko (2):
>   dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
>   dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
>     decrypted memory
> 
>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
>  include/linux/dma-mapping.h         |   6 ++
>  include/trace/events/dma.h          |   3 +-
>  kernel/dma/direct.h                 |  14 +++-
>  4 files changed, 117 insertions(+), 9 deletions(-)
> 
> -- 
> 2.51.1
> 
