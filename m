Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE4CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4D610FE58;
	Fri, 29 May 2026 12:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qwh7z1YN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0F310FE58
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780057432; x=1811593432;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fDrEew63oKedZYzWJjWxYyWisAICIOrMMrTYw4gEUeA=;
 b=Qwh7z1YNoe1iZBCyxSBpBeZ3UC3SAzSmMGM+oom0X1TI1vCYVU5BgQG+
 cwwkBAtJiUd91LfDxtQ4t/dTi5B8XxF6IFqtFVgBHZkmo+EsoiD3JIV9J
 C0nUbMX4P844ckviVZnuBr/vF9z8fwWPke8udLoWeXOufa7dFwQoqkQCB
 Mhm/nuCaWQ12cIruic0uAChkCniud2H5XNIFDlV1CaskiHjd34JYe50yY
 JSeYMbP/G1hFJTHhR0+V8Cq1IVY7AUikp4mcVp5pzg3c5Os8t2ymnJCP3
 m3sWuufoBb1OHGg/CuD/Sfh1YBLdIGtDWUWHGTqQlecnB8VCXmn+rL5Jh w==;
X-CSE-ConnectionGUID: xHGxCWqTSG6XtX1wY/xv1Q==
X-CSE-MsgGUID: /u1HDlhVRzWeysZcYKtPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80634667"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="80634667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:23:49 -0700
X-CSE-ConnectionGUID: pZLvH75iQ/Kj7tE+ncKrRA==
X-CSE-MsgGUID: Al7sdM+RTQ2Zjc7FpR6YAQ==
X-ExtLoop1: 1
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25])
 ([10.245.80.25])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:23:47 -0700
Message-ID: <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
Date: Fri, 29 May 2026 14:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
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
> Add validation that the info size returned from the metric stream info
> query is not exceeded when checked against the allocated buffer size.
> If the firmware returns a size larger than the buffer, reject the
> operation with -EOVERFLOW instead of proceeding with an incorrect
> buffer copy.
> 
> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
> index be43851f5f32..cd176e77b9a0 100644
> --- a/drivers/accel/ivpu/ivpu_ms.c
> +++ b/drivers/accel/ivpu/ivpu_ms.c
> @@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
>   	if (ret)
>   		goto unlock;
>   
> +	if (info_size > ivpu_bo_size(bo)) {
> +		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
> +				      info_size, ivpu_bo_size(bo));
> +		ret = -EOVERFLOW;
> +		goto unlock;
> +	}
> +
>   	if (args->buffer_size < info_size) {
>   		ret = -ENOSPC;
>   		goto unlock;

