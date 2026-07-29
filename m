Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC03DC54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DCF89F27;
	Wed, 29 Jul 2026 12:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cza126NN";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 30E1889F27;
 Wed, 29 Jul 2026 12:43:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 957571684;
 Wed, 29 Jul 2026 05:43:10 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970013F66F;
 Wed, 29 Jul 2026 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785328994; bh=WQuy6wDcjMkD2ClUQsZ/7ZMCTaygWPENfKsVb3uRDfk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cza126NNeWRrJvg3V4NcGUBbwBV+9Z9nCo1So7P8Rht1Ta/l9Pav8RDYgc08M10HT
 QPHuLOBp87wGZOCGd79CK7eQ8zq+F3UcF2zW8QJGhHsxpx6JbjdRV4VzGLhNh+Iq82
 ahablYuII2UapL3ll2JkPs5goXnlDYIpWA0Kiknw=
Message-ID: <766354f0-968e-4bb3-a824-589398174d1f@arm.com>
Date: Wed, 29 Jul 2026 13:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/dma: Catch scatterlist length overflows
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-3-krzysztof.karas@intel.com>
 <DKB1JMBPFCNM.2PUIUI31WOCHF@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DKB1JMBPFCNM.2PUIUI31WOCHF@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 29/07/2026 1:07 pm, Sebastian Brzezinka wrote:
> Hi,
> On Thu Jul 23, 2026 at 12:25 PM CEST, Krzysztof Karas wrote:
>> It is possible, when a very large mapping uses only one
>> scatterlist, that padding overflows scatterlist's length field.
>> This results in:
>>   1) silently wrapping the value
>>   2) smaller than desired mappings produced by iommu_map_sg
>>   3) leaving mapped bytes in memory (no iommu_unmap)
>>
>> Address this issue by adding overflow detection for scatterlist
>> length field.
>>
>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
>> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> v4:
>>   * Added value wrap check before s->length assignment (Robin);
>>
>>   drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 381b60d9e7ce..3ca3196a41b0 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/iommu-dma.h>
>>   #include <linux/iova.h>
>>   #include <linux/irq.h>
>> +#include <linux/limits.h>
>>   #include <linux/list_sort.h>
>>   #include <linux/memremap.h>
>>   #include <linux/mm.h>
>> @@ -1477,6 +1478,12 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>>   		sg_dma_len(s) = s_length;
>>   		s->offset -= s_iova_off;
>>   		s_length = iova_align(iovad, s_length + s_iova_off);
>> +		if ((s_length & UINT_MAX) == 0) {
> Might be better to go with  s_length > UINT_MAX . Right now it's 64 &
> 32, so only the lower bits count. Or just ignore this comment  it if
> it's intended.

Yes, this code also needs to support 32-bit size_t, wherein the overflow 
already happens within the calculation of s_length itself.

Thanks,
Robin.
