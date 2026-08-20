Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DDAC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2E710EFE4;
	Thu, 20 Aug 2026 10:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UgCvBdbA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D1E10EFEC
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787223455; x=1818759455;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lPp8pyqazfzG37eqxZn73DpfeX5sMPNuBRvD7LHxDZ4=;
 b=UgCvBdbARHCowQjL7PqbPmddOgLTehnooohh9sEH2XVR/k+cGkSYszAW
 54xA7jOHo9AWq7M6rZmwko9eSBrGFyABMJA2KDKnuiMeNxCGnLTma0sb4
 wKQsRWOqtCknobk7t3bWva8brOoFTMlMl2+liI+QZmW8LugGICi020LJo
 V6eLDSI4NHaZOykaOiJMalMIK3V1grRgq0u6UtBsp9H1n1HBMy98aQC0m
 d5Ym3WnuvE0yM4/zc2kKZXuHDHkcEFbLc+Sb8/9HnjmBhNnd+8SJGQW7N
 1MvXA+3bs6K2i8/1ZOQpGS1sACuGs4leIZi1OfHYFlO92Wu2s2ZYb4Jnz A==;
X-CSE-ConnectionGUID: JWcqRx7gQiG1Sq4XkiwCKA==
X-CSE-MsgGUID: Wp8vwLL7Sk69PrrqemBEGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86703543"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="86703543"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:57:35 -0700
X-CSE-ConnectionGUID: uFSLr3LDT+SqmimI7K5QSw==
X-CSE-MsgGUID: vikvf6+vRJ2vie86vD5e1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="271189397"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39])
 ([10.94.252.39])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:57:33 -0700
Message-ID: <1b4796e8-1277-4a9f-9b26-23086389d226@linux.intel.com>
Date: Thu, 20 Aug 2026 12:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] drm/print: add drm_warn_ratelimited logging
 macro
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
 <20260820104811.803146-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260820104811.803146-2-dawid.osuchowski@linux.intel.com>
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
> Add a drm_warn_ratelimited() macro to complement the existing
> drm_err_ratelimited(), providing rate-limited logging at warning level
> for drivers that need it.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   include/drm/drm_print.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 2adc5ac688e1..0805903c093b 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -644,6 +644,9 @@ static inline struct device *__drm_to_dev(const struct drm_device *drm)
>   #define drm_err_ratelimited(drm, fmt, ...)				\
>   	__drm_printk((drm), err, _ratelimited, "*ERROR* " fmt, ##__VA_ARGS__)
>   
> +#define drm_warn_ratelimited(drm, fmt, ...)				\
> +	__drm_printk((drm), warn, _ratelimited, fmt, ##__VA_ARGS__)
> +
>   
>   #define drm_dbg_core(drm, fmt, ...)					\
>   	drm_dev_dbg(__drm_to_dev(drm), DRM_UT_CORE, fmt, ##__VA_ARGS__)

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
