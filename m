Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DF4CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871E410EDDE;
	Thu,  2 Apr 2026 05:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="p8XIiW60";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CAC10EDDE
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:35:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260402053531euoutp01701f36c7e36e7ffcbba4b90af5f52533~ic3C0Vwoh1326513265euoutp01G
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:35:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260402053531euoutp01701f36c7e36e7ffcbba4b90af5f52533~ic3C0Vwoh1326513265euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1775108131;
 bh=a2ALkW+kbFi61LCOo/jIn51RH7T6kZmUYLT9OKC04kY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=p8XIiW60yygB4duGaUeoZzDfligbEwHtpLxRKPqjeP2cqMQWJ+aTAA2Z0f9PB4ogv
 WDtvy6XPjlMBFeX6dzvhvNPWVy42IetKV0iqUCf17GbTcsP+CcfJqQS7K4Q0Ue+mmb
 7tV4tDH1JCgqUAho30DqQ2/fTx8iM0loupZzjumw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260402053530eucas1p1f0754eb1edb4acdb0d52b31d9ff6c4f9~ic3B75IsG1210612106eucas1p1C;
 Thu,  2 Apr 2026 05:35:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260402053528eusmtip1ac753cbaaed704e10d0c4a64bfd0adad~ic3A3bQA60232302323eusmtip1d;
 Thu,  2 Apr 2026 05:35:28 +0000 (GMT)
Message-ID: <f6de2c2d-132c-4344-9b58-6e6ef1eb15a6@samsung.com>
Date: Thu, 2 Apr 2026 07:35:28 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly shared/decrypted memory
To: Sumit Semwal <sumit.semwal@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, christian.koenig@amd.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAO_48GEUXpcFBiyJAMgTcGPSq56-mZ0qnO3FrFRM2LoGd8W6HA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260402053530eucas1p1f0754eb1edb4acdb0d52b31d9ff6c4f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260402044147eucas1p25971b90eb6aa1ef03a2a1136d812f039
X-EPHeader: CA
X-CMS-RootMailID: 20260402044147eucas1p25971b90eb6aa1ef03a2a1136d812f039
References: <20260325192352.437608-1-jiri@resnulli.us>
 <CGME20260402044147eucas1p25971b90eb6aa1ef03a2a1136d812f039@eucas1p2.samsung.com>
 <CAO_48GEUXpcFBiyJAMgTcGPSq56-mZ0qnO3FrFRM2LoGd8W6HA@mail.gmail.com>
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

On 02.04.2026 06:41, Sumit Semwal wrote:
> On Thu, 26 Mar 2026 at 00:53, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
>> run with private/encrypted memory which creates a challenge
>> for devices that do not support DMA to it (no TDISP support).
>>
>> For kernel-only DMA operations, swiotlb bounce buffering provides a
>> transparent solution by copying data through shared memory.
>> However, the only way to get this memory into userspace is via the DMA
>> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
>> the use of the memory to a single DMA device, and is incompatible with
>> pin_user_pages().
>>
>> These limitations are particularly problematic for the RDMA subsystem
>> which makes heavy use of pin_user_pages() and expects flexible memory
>> usage between many different DMA devices.
>>
>> This patch series enables userspace to explicitly request shared
>> (decrypted) memory allocations from new dma-buf system_cc_shared heap.
>> Userspace can mmap this memory and pass the dma-buf fd to other
>> existing importers such as RDMA or DRM devices to access the
>> memory. The DMA API is improved to allow the dma heap exporter to DMA
>> map the shared memory to each importing device.
> Thank you for the patch series, it looks good to me.
>
> Marek, if you are ok, please could you take it through your tree, with my
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

I've applied both patches to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

