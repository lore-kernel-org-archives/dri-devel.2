Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E8C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1A410EFF2;
	Thu, 20 Aug 2026 10:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="j+P63FT+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6563310EFF0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787223477; x=1818759477;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GY5hnVFpWGwIECu/SjGu54iNFrH3zriuAgLvJZ/8Ifs=;
 b=j+P63FT+s4tdkszuDqpAXlx4nxZYKsPTZZkc+vkuxE9I1rFWGLjqmsGe
 JObj2gm7dRxMIuK/DO41KCOPTuwEbhHg2UXFxKxfZxNzgkO7Cgreychfu
 F0YGF/KOxZ4o+wNdcBkrXCAKeZlLYqRPtRkv7gwviAzEYe7Kjt/Z1pKnz
 Gc9jZGdA7NlYOW9Saw2xkMRflwzI3V6ln87xLsJ1m04AeA0L60se2x7yf
 TrM6k80+3gzh/z39PlvaQHhibLkBHlfoQQYIFevEg0DMDodTOltRzfZV/
 z+aclSAA7ac4AJjr/yp+qZOqA0t9qkenTzLe+lQha5zSRDAxSJLJBK/34 g==;
X-CSE-ConnectionGUID: BQejbKrvQxyCMEKCNEFwWw==
X-CSE-MsgGUID: asx8ap8oQ1C710/I9UV+wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86703566"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="86703566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:57:57 -0700
X-CSE-ConnectionGUID: 1ti4DCGAQ8203MwhzykkqA==
X-CSE-MsgGUID: qQ++OvJOQXe6kOLLqNxnQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="271189421"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39])
 ([10.94.252.39])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:57:55 -0700
Message-ID: <e24bf522-bb35-4a47-8404-563badf2ecf8@linux.intel.com>
Date: Thu, 20 Aug 2026 12:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] accel/ivpu: Use drm_warn_ratelimited macro
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
 <20260820104811.803146-3-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260820104811.803146-3-dawid.osuchowski@linux.intel.com>
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

On 20-Aug-26 12:48, Dawid Osuchowski wrote:
> Fix ivpu_warn_ratelimited() to properly use WARN logging level instead
> of an ERROR.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 86d7c9966cac..8f29f1dc52b9 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -91,7 +91,7 @@
>   	drm_warn(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
>   
>   #define ivpu_warn_ratelimited(vdev, fmt, ...) \
> -	drm_err_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
> +	drm_warn_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
>   
>   #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
>   

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
