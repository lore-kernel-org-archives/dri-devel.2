Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C08FD8769
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361D010E64B;
	Tue, 17 Mar 2026 13:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fPNhBPaR";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301A710E64B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 13:37:06 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48374014a77so62973055e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773754625; x=1774359425;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bvyHox0ngaRcTYY5mmOslDzHoAOd+VMSoOGA/5ZJGB4=;
 b=fPNhBPaRqb4D90LfWHfVxUH+JxHs2MlTVqm/pnZ3avmmOkbSpfCjlOVzgSh5uPUE8f
 dWiqO0nOVUEQiDzRy6XSg8k6HPdhSacmDb01Y5gJPESdvuP+GPOVQoYkUcMY+XXsBT+R
 JIIfNrIQkj9UatWhL0/bBwdQTTIHo4DyNfCZN7oTFWt4oQFPp7roQjTsRTAXdjgNFr9X
 misHu3AhSPWQkuB5sdGYWDfASJq4XRdoBDY++HarIXHUlJTkCYvBynkoExgT6mr59miF
 3lRG2bZTuGtVNVo/S2z6VT8JcE/52OATrnq3Zt7plZK0tsnMOPkgz7XzQ9udXAlN5Wun
 bgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773754625; x=1774359425;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvyHox0ngaRcTYY5mmOslDzHoAOd+VMSoOGA/5ZJGB4=;
 b=Qn0YH8d6WAIog4DrEV2vohrsSYUa8VnSf3pJRLPDaG7r5NCAiVe5BXcud1ammV2KTN
 tXEGv1aNayBlVTlVChwzDysOyvQGBKNx5rT8kD3lvTDdi+HCDHyfZ0T+o2ERFxFiLmCG
 e1OqC/lgokJZ+bkW54C50i+d7l0ocJGFT5AswFdlaroP9jkgDVYx7n7dhRaOuMc3OIVq
 eEgINUCxa8eKoYG8KvBwtZTw/7hGkkprsIaTz9zTBI0Rq2rvaC6b8MyXlKRQDSQv19SG
 pIzr2e2to2y+SM06AQOb6d9f+4LfljDiVrT3mn7VAeF2Md0J4rIHC3hCFB641icCyxg5
 nZtg==
X-Gm-Message-State: AOJu0YxTQWGjZfU4GtCSJSiXFmYFrkRJZSc3qAFHOBXUM6GQCLlsSYqC
 ITOB+V3e+7dMkdQ+fmWUgKGISGYyVbNOIkFw0lQ2gqcXF3vMM/AJBDiwdxcWnSdmaOY=
X-Gm-Gg: ATEYQzxa+eXoE5q8PtleHY+t+rX/4cR0fzoSxcV1D+xU0TrCbisgMGEvtJm9wjbDpRu
 SHLgTdERy1N2EDcrtuUckvwr+p58oXSJDr7aw3uYRkVCEtnlb1lmt5dhy9cUNLbr3vgnP4Upoc8
 2/u4+z9gpXkswjpY8fIOoco7GAQgcHpPMf08QfbuVgPPlSA0qJ/aKN1ZErK/uUBQL85LqW8RSSx
 +2+IVhnn58RlOgbcxKffJEvfDO9IBEiuplddBxEuPK9TyHom18jvEj11M/D/+fRHsRFAU7Doc4P
 9JkZcC7HZQ5DgWrAMy2zAqWAKXUhWWCzgkQjNgcxoHXkqF0IFLx3UO/0EBvBQCuO2DKNx2BseOS
 3iK9GkiN8yNmJIOyht/sRTA+m6zoZE7F/yA9ItBZ2c2XCC3lW/gHdzPYBVVkr1faQ1eliMfDCFt
 gbAUgsp4rXQMP9WysEfR7PjahuR2oQnRk=
X-Received: by 2002:a05:600c:a011:b0:485:6cd3:f7ac with SMTP id
 5b1f17b1804b1-4856ce33d33mr90044845e9.20.1773754625122; 
 Tue, 17 Mar 2026 06:37:05 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaa3b66sm76702495e9.11.2026.03.17.06.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:37:04 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:37:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mostafa Saleh <smostafa@google.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <xdy5anped2koy47cuxbbqocyypisl7lagwvpuokpzpggohk2dp@yilc5ihictph>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ablV_f_l7wD2m63E@google.com>
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

Tue, Mar 17, 2026 at 02:24:13PM +0100, smostafa@google.com wrote:
>Hi Jiri,
>
>On Thu, Mar 05, 2026 at 01:36:39PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
>> run with encrypted/protected memory which creates a challenge
>> for devices that do not support DMA to it (no TDISP support).
>> 
>> For kernel-only DMA operations, swiotlb bounce buffering provides a
>> transparent solution by copying data through decrypted memory.
>> However, the only way to get this memory into userspace is via the DMA
>> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
>> the use of the memory to a single DMA device, and is incompatible with
>> pin_user_pages().
>> 
>> These limitations are particularly problematic for the RDMA subsystem
>> which makes heavy use of pin_user_pages() and expects flexible memory
>> usage between many different DMA devices.
>> 
>> This patch series enables userspace to explicitly request decrypted
>> (shared) memory allocations from the dma-buf system heap.
>> Userspace can mmap this memory and pass the dma-buf fd to other
>> existing importers such as RDMA or DRM devices to access the
>> memory. The DMA API is improved to allow the dma heap exporter to DMA
>> map the shared memory to each importing device.
>
>I have been looking into a similar problem with restricted-dma[1] and
>the inability of the DMA API to recognize that a block of memory is
>already decrypted.
>
>However, in your case, adding a new attr “DMA_ATTR_CC_DECRYPTED” works
>well as dma-buf owns the memory, and is both responsible for the
>set_memory_decrypted() and passing the DMA attrs.
>
>On the other hand, for restricted-dma, the memory decryption is deep
>in the DMA direct memory allocation and the DMA API callers (for ex
>virtio drivers) are clueless about it and can’t pass any attrs.
>My proposal was specific to restricted-dma and won’t work for your case.
>
>I am wondering if the kernel should have a more solid, unified method
>for identifying already-decrypted memory instead. Perhaps we need a
>way for the DMA API to natively recognize the encryption state of a
>physical page (working alongside force_dma_unencrypted(dev)), rather
>than relying on caller-provided attributes?

I actually had it originally implemented probably in the similar way you
suggest. I had a bit in page/folio struct to indicate the
"shared/decrypted" state. However I was told that adding such bit is
basically a no-go. Isn't that right?


>
>[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com/
>
>Thanks,
>Mostafa
>
>
>> 
>> Jiri Pirko (2):
>>   dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
>>   dma-buf: heaps: system: add system_cc_decrypted heap for explicitly
>>     decrypted memory
>> 
>>  drivers/dma-buf/heaps/system_heap.c | 103 ++++++++++++++++++++++++++--
>>  include/linux/dma-mapping.h         |   6 ++
>>  include/trace/events/dma.h          |   3 +-
>>  kernel/dma/direct.h                 |  14 +++-
>>  4 files changed, 117 insertions(+), 9 deletions(-)
>> 
>> -- 
>> 2.51.1
>> 
