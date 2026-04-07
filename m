Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D1EDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CAB10E08C;
	Tue,  7 Apr 2026 09:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="fqCsOI9C";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2D210E08C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:25:20 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so4354131f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775553918; x=1776158718;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ChD0onF1gDOUOLYFpD7x1c0kz7T4QILlyJ39777mmvM=;
 b=fqCsOI9CbcXxJS5URrOQUtL35aqwZFMTzCcNf0Bj6Js8H9/stuvlvcZstvhBy2pIML
 fPqf0P/BbXA94lkZZef0sNdGm5ysN/R/kWr0xHbCpiLftnUPagGuINbuqut+k4QEZ+hF
 qR7cfpY9ztaI3eIrEm7G8yxsb19ISG9mKPUcoKSd28LrN2TJxje1ULsI2UHkt2mCSkx3
 OQDmySUVmf+mr9rql7XbSB4q2NKVRZ9Trj0ln02hSTeVEHs5NGTbnzOdv+tP3GMkbMOz
 mB0O5xDOLmUbInutoG8xymzXduwCOh4v7RImr3EudExsF4vTYzkO+J9LFLqrigiR6PJq
 3P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553918; x=1776158718;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChD0onF1gDOUOLYFpD7x1c0kz7T4QILlyJ39777mmvM=;
 b=AI3lQlJ2zSLaWX+xeG4TU9ET+KPavDRr580udjY3MhS42mtZB0sioyYm6HvsMA8FoN
 6L7bXeZdY48mEY+az5irdyy6BD2VeYujXBoqPlcgkftFYA9080uhzOmFpflM759TBK9Y
 yWk5NXB5O9H1w+Gf7EIB/xQ1sThrZOtfJqhO5Vl3FHPTB3+rifRYJ48EJ4n58eTGWLGQ
 Pr5grsj1oZImyUdlTAOCDb1RwaegTt5cNXZFp7kZheMbPub7i8OQ0fm+Bg+9xMWFgsKw
 KVRFZIl6mIQTJ0MxgM85dU8fp61iC4xK70PFAwfEeHzeiBEeUv4i4nO4jD15Leq86VkJ
 eyHg==
X-Gm-Message-State: AOJu0YyiQbgi+CDYiOrJAZ3x3fN+BH7Y8IDJphQ+R1/lMD72YlmI/x/C
 Arum2IechRZ/ZehyYH+rAMspaD6ztPXCutrvyYe61JJx1eyRAq9kKKSKHDiJrwck4IE=
X-Gm-Gg: AeBDiesO5GxdQ8o16fsPaYVoq6V3/VV1Syk+sc9UMFUn54uXGDGZtJY1ijYrykEFYUY
 MRtC04JNTOr4m/SW/PLqsgMly7AL/+lB7TN43JJ5cEmFTU4wBw+wE4zXN9qMRlSZl2/L7PUOQYv
 cCvU2nMImVvzP9UXk5B3n9UQ1cBdbruncAC8m+jjTnkQYDAq61jzewYbGZFx/xfq8Fefmgln/vy
 rFC2lLvToKlP7XuUzPoJzi68uZ3CB3g3Iuk05LbaSS5oPYEILlIbD3dF30qF5Pn5MJju7UOenki
 GyfeXhGMxKS31ywjWNAuXck3ipsE0Movp0RHT0wWq3olBQpt+e1SrXRq+Of9xfxUSi79Tr0K0H+
 nawh7jb7Z4kWjKW8zUv6owkz6yff2ycUOUSy9hxYH7Y4yhoxjLLCGssOL2RF2Pr/o23sEDwceG+
 kKPh+8EnEnmZowsYrrl/zwd5TxQnnyQ8E=
X-Received: by 2002:a05:6000:4201:b0:43c:f95c:3e66 with SMTP id
 ffacd0b85a97d-43d29294b62mr24203622f8f.21.1775553918478; 
 Tue, 07 Apr 2026 02:25:18 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5016sm52091538f8f.33.2026.04.07.02.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:25:17 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:25:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
Message-ID: <5l5ack3pgpajrkbcactkiyvfi5pir3jn5eg6tmohcrdgiuqtn5@odbwbvsn4vrj>
References: <20260402141103.598495-1-jiri@resnulli.us>
 <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3N70j8ZZs5DNhx6fhRi=Aa_+2xY1JHcW+uDoaV2+Sngw@mail.gmail.com>
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

Mon, Apr 06, 2026 at 10:20:33PM +0200, tjmercier@google.com wrote:
>On Thu, Apr 2, 2026 at 7:11 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Document the system_cc_shared dma-buf heap that was introduced
>> recently. Describe its purpose, availability conditions and
>> relation to confidential computing VMs.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
>> index 05445c83b79a..591732393e7d 100644
>> --- a/Documentation/userspace-api/dma-buf-heaps.rst
>> +++ b/Documentation/userspace-api/dma-buf-heaps.rst
>> @@ -16,6 +16,14 @@ following heaps:
>>
>>   - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
>>
>> + - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
>> +   buffers using shared (decrypted) memory. It is only present on
>> +   confidential computing (CoCo) VMs where memory encryption is active
>> +   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
>> +   bit cleared, making them accessible for device DMA without TDISP
>> +   support. On non-CoCo VMs configurations, this heap is
>
>"non-CoCo VM configurations"
>
>> +   not registered.
>
>Doesn't seem like you need to wrap this line.
>
>with that: Reviewed-by: T.J.Mercier <tjmercier@google.com>

Okay. Thanks!


>
>> +
>>   - The ``default_cma_region`` heap allocates physically contiguous,
>>     cacheable, buffers. Only present if a CMA region is present. Such a
>>     region is usually created either through the kernel commandline
>
>Each paragraph starting with '-' confused me for a second there. Those
>aren't part of the diff. :)
