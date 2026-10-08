Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF36CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D945110E790;
	Thu,  8 Oct 2026 08:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J2W25oWF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D0710E790
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 08:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791447651; x=1822983651;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZOIBcSZ+pZ8/Sg3bkmfaa12gLr/fkBW8KjJyrywkEbI=;
 b=J2W25oWFYYbw57w18uLKnLlKyl484WZgY7hVtsGQu+NBEShaSCAVi+sj
 1hrQNI4GxwUPtcGcpX8yUW3ahwwX2q5DY1kVzHDsc3iqFTsq3LLhMuNCq
 GmH1OnK6ZRaMBjp1+E/Lm3+1K8dNGOZobUbJeoomAWGRSkTLf/FvjWcBR
 Jyhj7u6IFIoy+WwL1cND3Cz/cSN6PRVrZVHS1ganO/P5iHXsSqHjERZnI
 SxyGb9UcrsJiYfo9ukhfiXL6de3Zm8mFF82S78tTLCHXyj5EBMFpxtDl0
 2WdVjowciDfqwRQ/287LcnDhdmQCmotfzVh6yNr6H0Up+CHidU7spFa1g A==;
X-CSE-ConnectionGUID: K1aak7RCRsilxjjEFG6MXw==
X-CSE-MsgGUID: e1Q5mxXdSVSnbsF63vVP+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="111999"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="111999"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 01:20:51 -0700
X-CSE-ConnectionGUID: mSfOOjJUQM+ll2kQfHO74Q==
X-CSE-MsgGUID: OIyMwq2QSVK5XQ5o9MqqcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="329515"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 01:20:49 -0700
Message-ID: <d6dcf540-4a89-45a0-b430-0b221e79099e@linux.intel.com>
Date: Thu, 8 Oct 2026 10:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Limit DMA address width to 42 bits on 40XX
 and later
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261006093740.2304835-1-karol.wachowski@linux.intel.com>
 <7f0de0ca-87d6-41c2-a19a-028bbac8650f@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <7f0de0ca-87d6-41c2-a19a-028bbac8650f@linux.intel.com>
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

On 06-Oct-26 11:42, Dawid Osuchowski wrote:
> On 2026-10-06 11:37 AM, Karol Wachowski wrote:
>> On 40XX and later the NPU does not treat address bits 42 and above as
>> part of the memory address, as the hardware uses them internally, but
>> ivpu sets a 48-bit DMA mask for these generations.
>>
>> In practice the IOMMU capabilities already limit the DMA addresses to
>> 42 bits, so this does not fix an observed problem. Set the DMA mask to
>> 42 bits anyway, so the driver does not depend on the IOMMU
>> configuration to stay within the range the NPU can address. 37XX keeps
>> its 38-bit mask.
>>
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, pushed to drm-misc-next.

> 
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ 
>> ivpu_drv.c
>> index ab1a9448c2cc..6b71edf566e7 100644
>> --- a/drivers/accel/ivpu/ivpu_drv.c
>> +++ b/drivers/accel/ivpu/ivpu_drv.c
>> @@ -709,7 +709,7 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
>>       }
>>       if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX)
>> -        dma_bits = 48;
>> +        dma_bits = 42;
>>       else
>>           dma_bits = 38;
> 

