Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5E3FED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E9B10E355;
	Tue, 17 Mar 2026 15:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dlgtXz3v";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 882A510E355
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:40:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852af55981so92845e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773762006; x=1774366806;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CDw4r5ujTl31OHrtYbqvixsT9t+9enT6zG9dzarVNeI=;
 b=dlgtXz3vzRrwcW8lha4uQqsq0UqM9gcCn1Qkfb9ah76hFlppxbt7drFE4CMcVjCbT3
 xWwkJkUBWSLd55csohLZOYrGv7kpCnEbeuECbq92PEjNe8xjvvz806uysz5sHViRN+EN
 BqO00hvMQl+qUhmJiA/bOdf35sOEMpzXrzWH6UW3kOvEwg7DPLBZ6TUwDwcWBi4Xs6YY
 00uj9OA54mg1DRAL4F9MnZTYFTMd7jgOJ7uA62VLhoI9exY6SVEu6Gr2DOO+IOy7KfUb
 pJlT6ZzngWJQCAZZvMslpTROPW3ngk7qdlQjEAr+FXTMIx2bWs4R0PyhpvLDTkU1028Z
 SSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773762006; x=1774366806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDw4r5ujTl31OHrtYbqvixsT9t+9enT6zG9dzarVNeI=;
 b=AIRkFXGRh9uqki9NmZuA6oLOcjo1R1Px+DpEWSqxON2hLWZ11pVEphRrEaDVK5P6te
 gbgu1badJbrCWtGPSCQKme3aXuhr78Pg5VQRDux9Ul5c6KG+wTYcy/yvFHiwDiqZu1sK
 WgdHnOhPAQT32tXGgUIgMhqsPaPs4wqUcY02tCrZR9ZOG+hjwcKPD7rpettT5gZjWFLu
 dx9uGYwsQJ68wdIqTYET++1vXXG097soJEMFcMTjs6IPMIn6DLiHR3y5Jb/41+mBpvgp
 30a8iP86BeAwjJCLXILq2brHA/MxRcYuM23j1B5gJ9bSuQ1LZhBMW+R5QJs/dl+pPzkF
 J6Bg==
X-Gm-Message-State: AOJu0YzDD4AVDSBayXgiVc/F6x6coFYx4q+3j/p+q5iltcjMeQWOci4w
 QADXqGz/zemOOMaT04M3ESQTlsliphwfMKmpI9Hk+iMRbP2pfAtOYv3e5DazQhBpdw==
X-Gm-Gg: ATEYQzwBOoU0tAMQYzX1zVp2B/yluGE+V4ESqBmmEFDN9MPlVjwU7Yx0q9dZDz4B4Ij
 D/+QycnickFJ/Exg14nzBXAzp+A3DBHwdWiZYCC8OQaQtmupnnwNgfsRpNTZhHTrKD5GAuORYdD
 p/wXhdUFN+dZUWxSoPazlOxyVRNHskqibP1pOJfT9fQiyOnXv4LYr6EeKhtxuTLmYnHmcp++7uG
 0X7YlXx6T7j/NtNrTi33MFs/N9wffHgTG1+wx8mz4Plxze93j8uuorT8rN0KUYLHn+I7nRUqM+/
 2MdozH15I5Uf6oprW+wuSQh9LrzZKlm7H+UkIsEFI28w9w+eamHXu4OaT+sU4NH75fVL8u6sMf/
 hIoMaloSPMjKieijpRNWCKQ+29xEg/qHET36jrp+eXHbroMWmcpWZoXMM9wvCdpx/93Sji4LC7s
 TLpISs8lQMAvleZDC7uAaRURzIVIuGtM63+9v+mkTMlw5COxIaQMNyLjW7
X-Received: by 2002:a7b:cb8b:0:b0:483:6f85:b16e with SMTP id
 5b1f17b1804b1-485709958a2mr850705e9.3.1773762005359; 
 Tue, 17 Mar 2026 08:40:05 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3396sm72909465e9.9.2026.03.17.08.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:40:04 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:40:01 +0000
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
Message-ID: <abl10SQ4tdasfErt@google.com>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
 <xdy5anped2koy47cuxbbqocyypisl7lagwvpuokpzpggohk2dp@yilc5ihictph>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xdy5anped2koy47cuxbbqocyypisl7lagwvpuokpzpggohk2dp@yilc5ihictph>
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

On Tue, Mar 17, 2026 at 02:37:02PM +0100, Jiri Pirko wrote:
> Tue, Mar 17, 2026 at 02:24:13PM +0100, smostafa@google.com wrote:
> >Hi Jiri,
> >
> >On Thu, Mar 05, 2026 at 01:36:39PM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> >> run with encrypted/protected memory which creates a challenge
> >> for devices that do not support DMA to it (no TDISP support).
> >> 
> >> For kernel-only DMA operations, swiotlb bounce buffering provides a
> >> transparent solution by copying data through decrypted memory.
> >> However, the only way to get this memory into userspace is via the DMA
> >> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> >> the use of the memory to a single DMA device, and is incompatible with
> >> pin_user_pages().
> >> 
> >> These limitations are particularly problematic for the RDMA subsystem
> >> which makes heavy use of pin_user_pages() and expects flexible memory
> >> usage between many different DMA devices.
> >> 
> >> This patch series enables userspace to explicitly request decrypted
> >> (shared) memory allocations from the dma-buf system heap.
> >> Userspace can mmap this memory and pass the dma-buf fd to other
> >> existing importers such as RDMA or DRM devices to access the
> >> memory. The DMA API is improved to allow the dma heap exporter to DMA
> >> map the shared memory to each importing device.
> >
> >I have been looking into a similar problem with restricted-dma[1] and
> >the inability of the DMA API to recognize that a block of memory is
> >already decrypted.
> >
> >However, in your case, adding a new attr “DMA_ATTR_CC_DECRYPTED” works
> >well as dma-buf owns the memory, and is both responsible for the
> >set_memory_decrypted() and passing the DMA attrs.
> >
> >On the other hand, for restricted-dma, the memory decryption is deep
> >in the DMA direct memory allocation and the DMA API callers (for ex
> >virtio drivers) are clueless about it and can’t pass any attrs.
> >My proposal was specific to restricted-dma and won’t work for your case.
> >
> >I am wondering if the kernel should have a more solid, unified method
> >for identifying already-decrypted memory instead. Perhaps we need a
> >way for the DMA API to natively recognize the encryption state of a
> >physical page (working alongside force_dma_unencrypted(dev)), rather
> >than relying on caller-provided attributes?
> 
> I actually had it originally implemented probably in the similar way you
> suggest. I had a bit in page/folio struct to indicate the
> "shared/decrypted" state. However I was told that adding such bit is
> basically a no-go. Isn't that right?
> 

Yes, I believe it’s discouraged to add new fields to the struct page.
But I see the memory encryption API is spilling in different places
and I am not sure if that’s a good enough justification for that or
maybe we just need to re-architect it.
For the restricted-dma stuff, we don’t actually care about the
address, a device can either handle encryption or not, so relying on
force_dma_unencrypted(struct device *) which is implemented by the
architecture is enough, and we just need to integrate that so it
can be used from SWIOTLB and DMA-direct (and other places)
consistently. (although that might not be a simple as it sounds)

I am not sure in the dma-buf case if that would be enough, but
another way to have this per page and to avoid encoding this in
struct page, is to push this problem to the arch code and it can
rely on things as the page table (I believe ARM CCA have a bit
for that)

Anyway, I think there should be some boundaries in the kernel that
defines that instead of each subsystem having its assumptions,
especially memory encryption/decryption problems that can easily
cause security issues.

Thanks,
Mostafa

> 
> >
> >[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com/
> >
> >Thanks,
> >Mostafa
> >
> >
> >> 
> >> Jiri Pirko (2):
> >>   dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
> >>   dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
> >>     decrypted memory
> >> 
> >>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
> >>  include/linux/dma-mapping.h         |   6 ++
> >>  include/trace/events/dma.h          |   3 +-
> >>  kernel/dma/direct.h                 |  14 +++-
> >>  4 files changed, 117 insertions(+), 9 deletions(-)
> >> 
> >> -- 
> >> 2.51.1
> >> 
