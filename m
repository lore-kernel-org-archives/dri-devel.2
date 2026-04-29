Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AEAFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680F7896E9;
	Wed, 29 Apr 2026 08:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YOxE2rGC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CBD896E9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777452299; x=1808988299;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=G44wO/6/OCPRVyVCQ3QHoVj28iTpTTLYYvHmhvc+YK8=;
 b=YOxE2rGCR+WB32KPs5Q5Apko2ry9p2FznixpxZF3GGoshYjHfswkRoAT
 2+fn1cDxd0FBPNOJ1H4xRSaoyDzTUh0WVG3QYwz3hXmrLZnY5avMNbDAj
 HUconB2s+gFvlZPhHsIucl0YY57cKXaHVJ/hkk8WTKBhTebF84ieQ2EB9
 bud2rCyXtH1Q+rc0Dspqq5YSptq9r/hwSnEDe2PKXswaQCyQlBFcBUdTl
 AbAB8FJVba+1aW2Zsu21s2zEsllljOnsPg8qnueljwesDG8tfyRLs+F5D
 R6JQwd0G5Eehw45hqufGrm40CvMsOx0nfAABWgux/rwwa9f8/95HEGOg1 w==;
X-CSE-ConnectionGUID: a7m7w0EQSuaPoHP+xwbHcg==
X-CSE-MsgGUID: HetGKXzTR4GQ5tlDHRgIgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89465971"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="89465971"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 01:44:59 -0700
X-CSE-ConnectionGUID: FynI2zDMRTG5LeBudT4ZIA==
X-CSE-MsgGUID: q/9DKebSQzen3fTAaYupzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; d="scan'208";a="238179632"
Received: from unknown (HELO [10.102.88.27]) ([10.102.88.27])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 01:44:58 -0700
Message-ID: <1639628f-fb48-4b83-9869-c8a15e413e48@linux.intel.com>
Date: Wed, 29 Apr 2026 10:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: accel/ivpu: Remove myself and add Andrzej as
 maintainer
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com
References: <20260429083958.2148777-1-maciej.falkowski@linux.intel.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260429083958.2148777-1-maciej.falkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/29/2026 10:39 AM, Maciej Falkowski wrote:
> As I will be departing from my current position, I will
> no longer maintain the driver, and remove myself from
> ivpu's maintainers entry. Andrzej will support Karol
> in maintaining the driver.
> 
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74d114884b34..54b941d6e8b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7835,8 +7835,8 @@ F:	drivers/soc/ti/smartreflex.c
>  F:	include/linux/power/smartreflex.h
>  
>  DRM ACCEL DRIVERS FOR INTEL VPU
> -M:	Maciej Falkowski <maciej.falkowski@linux.intel.com>
>  M:	Karol Wachowski <karol.wachowski@linux.intel.com>
> +M:	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
