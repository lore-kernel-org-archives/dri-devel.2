Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2C0CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B3110E30D;
	Tue,  6 Oct 2026 09:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O4XnkTvh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FC110E30D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279736; x=1822815736;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aM6DyMeBRbAxT3xwvV/zJR/ZfO/2PlY8E8Yl7bYajgY=;
 b=O4XnkTvh2hYUVP4uurMCe67oxTTCc2T+L1BIxiT5eIEER0hl7W9y4J+t
 fLuUJVAwPC8sevolcqdB78NcX4J4MsRxvGmv39vzQqXIi1apcFeFdvq4t
 MOCdpyhcnWIbn0exi6SmODiG6sU2Fb+vGPtrSSEfD1FLIsAyPMQBIa8Ih
 eUASpA2YGl5EiP4/dVj4uO7W7iQMbrqg8CbutNcUn90x5BEudbMHmzejh
 /6YHHthxVsMvhELEQBs/gd4M9PnFUQ23/6LtLHHo+sXjpb8VjoHAHoiVx
 JscwjrugF+4ZwpnyPZeDjRwBm2QWqHMAv/rsniLyS8wko5i01irB39k5y g==;
X-CSE-ConnectionGUID: BRDgLuENRz6G31z3dWM5iA==
X-CSE-MsgGUID: au7tKpR4SuqBbyYSqWXKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="103335993"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="103335993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:42:16 -0700
X-CSE-ConnectionGUID: 8/tyf8hxRTqZzCYXyQy/Ag==
X-CSE-MsgGUID: MGaAhksDTUuvBjJfURkOAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276613203"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [10.102.89.94])
 ([10.102.89.94])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:42:14 -0700
Message-ID: <7f0de0ca-87d6-41c2-a19a-028bbac8650f@linux.intel.com>
Date: Tue, 6 Oct 2026 11:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Limit DMA address width to 42 bits on 40XX
 and later
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261006093740.2304835-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20261006093740.2304835-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026-10-06 11:37 AM, Karol Wachowski wrote:
> On 40XX and later the NPU does not treat address bits 42 and above as
> part of the memory address, as the hardware uses them internally, but
> ivpu sets a 48-bit DMA mask for these generations.
> 
> In practice the IOMMU capabilities already limit the DMA addresses to
> 42 bits, so this does not fix an observed problem. Set the DMA mask to
> 42 bits anyway, so the driver does not depend on the IOMMU
> configuration to stay within the range the NPU can address. 37XX keeps
> its 38-bit mask.
> 

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index ab1a9448c2cc..6b71edf566e7 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -709,7 +709,7 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
>   	}
>   
>   	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX)
> -		dma_bits = 48;
> +		dma_bits = 42;
>   	else
>   		dma_bits = 38;
>   

