Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B07CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B310310E8B7;
	Wed, 10 Jun 2026 11:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O0cF8Wil";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5485410E8B7
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781089798; x=1812625798;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aoPVJa/31+BYWjZmo1N3EVPmo8NiGncSpTDxDkaB2Sw=;
 b=O0cF8WilHW6OeyaYgNKRIYeIOtTJuBd6T8pxh8HfN0DCL+cfHBhLkDqY
 a5hYNOpOJyICExEF8LQHflPhvVoWu5VO/f/3qIBMy6j0fj2m8w5N4WpMc
 l1z7nk/DcLNQXt2rtwyOwXVhLQ2GRo0qxsjofeLcC1Xg4PgdiYNjiUpl6
 eREymqLTX9OaSbIT9ZYaanNLto0q3A+gxriE8tbc2M/QBV71Rb5RjFb9r
 Jq0kg0qWatv6P2FL2RvuG8ZcUbSE55Uv4eMBVa/e169EKHLoCJ/vaNok8
 vN+NGnDGkJKOqvWcUgBr1RNYeTcJm4NJ92I01kl4CAM/AJ1VF7Btwp+A9 A==;
X-CSE-ConnectionGUID: W+jOF8FHR3GTWLMLrzGhHA==
X-CSE-MsgGUID: JlZbrB04Rcao16i7bEhaBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81882368"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81882368"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:09:57 -0700
X-CSE-ConnectionGUID: Hi9gE0F0SLWTHTDOZOujJA==
X-CSE-MsgGUID: Wjrb6z6zTBmOcF+joBp8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245290573"
Received: from mgoluns-desk.ger.corp.intel.com (HELO [10.245.80.25])
 ([10.245.80.25])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:09:56 -0700
Message-ID: <42b0dcea-cf60-4e53-ba6f-ce898b7507c0@linux.intel.com>
Date: Wed, 10 Jun 2026 13:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/ivpu: Use drm_warn_ratelimited macro
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: ogabbay@kernel.org, jeff.hugo@oss.qualcomm.com,
 andrzej.kacprowski@linux.intel.com, lizhi.hou@amd.com
References: <20260610110348.1796333-1-dawid.osuchowski@linux.intel.com>
 <20260610110348.1796333-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260610110348.1796333-2-dawid.osuchowski@linux.intel.com>
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

On 10-Jun-26 13:03, Dawid Osuchowski wrote:
> Fix ivpu_warn_ratelimited() to properly use WARN logging level instead
> of an ERROR.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 9eefbbb7ba11..d5f77cf84196 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -90,7 +90,7 @@
>   	drm_warn(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
>   
>   #define ivpu_warn_ratelimited(vdev, fmt, ...) \
> -	drm_err_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
> +	drm_warn_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
>   
>   #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
>   

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
