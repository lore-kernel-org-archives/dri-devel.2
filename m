Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD812CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D1310FE5D;
	Fri, 29 May 2026 12:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Uq95sogn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5772910FE5E
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780057655; x=1811593655;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CXuqIZDWCLi9QpcPkAQ/R27XriGKsnNHkBqh657t6Do=;
 b=Uq95sognb9+N/9K+MvXKe8i4FRBlpu0SUm430jh1wPhxkhKJ6UT6uvmc
 1zbduQ46uJDEBB+7wGn7zMCS447GEKkMRiHqAFIKOXfLlTvWQg9sP7ykQ
 zs7ZzLKpKtbNxySDJvh6dWpJhqCRzG8bxFv2ZbNAsUznlP8eolzUKS5+N
 A2ONtKVU36k8kfYtUpHidBEQXDqh9HHR66OJ0mH2VNykU1tNteClCI+fn
 1QAnjBJViAMO1oEhoZxo2l7uhdPEDsr2H2WloFZi66tK0dAoeXWR386Rp
 IgG8JrX8RIFZ6HjhlBDVZHF7zYl9UH0cidn0JwiqF62mBJDMm+YXVRhto g==;
X-CSE-ConnectionGUID: jTFOeLBLQoKvHEQ8fAjPEA==
X-CSE-MsgGUID: 163hPHSjR3qzdv4qWWDXcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80634928"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="80634928"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:27:35 -0700
X-CSE-ConnectionGUID: ztCH4yb9SK203vJ193d+XA==
X-CSE-MsgGUID: Hkhc2gMUQS6R6Vf4U8QtKw==
X-ExtLoop1: 1
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25])
 ([10.245.80.25])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:27:33 -0700
Message-ID: <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
Date: Fri, 29 May 2026 14:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
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

On 29-May-26 14:08, Andrzej Kacprowski wrote:
> Validate that the firmware runtime memory specified in the image
> header is properly aligned and sized to hold the firmware image.
> This prevents errors during memory allocation and image transfer.
> 
> Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory buffers")
> Cc: <stable@vger.kernel.org> # v7.0+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 107f8ad31050..33c50779c06b 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>   		return -EINVAL;
>   	}
>   
> +	if (!PAGE_ALIGNED(runtime_addr)) {
> +		ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", runtime_addr);
> +		return -EINVAL;
> +	}
> +
> +	if (!PAGE_ALIGNED(runtime_size)) {
> +		ivpu_err(vdev, "Runtime size %llu not page aligned\n", runtime_size);
> +		return -EINVAL;
> +	}
> +
> +	if (runtime_size < image_size) {
> +		ivpu_err(vdev, "Runtime size too small: %llu, image size: %llu\n",
> +			 runtime_size, image_size);
> +		return -EINVAL;
> +	}
> +
>   	if (!ivpu_is_within_range(image_load_addr, image_size, &vdev->hw->ranges.runtime)) {
>   		ivpu_err(vdev, "Invalid firmware load address: 0x%llx and size %llu\n",
>   			 image_load_addr, image_size);

