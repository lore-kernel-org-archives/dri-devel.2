Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C51BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A7610E664;
	Wed, 29 Apr 2026 12:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FX9GUlUb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2404210E664
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777467465; x=1809003465;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=55eTgoMHWKIoeSkzmKaw4s+Bfn69LGKpEZLYbDuEK+Y=;
 b=FX9GUlUbtwMCWpZ+4ex1apQ4TeAgLSIh6rnXBXSM75H9dFCs0+73maaF
 IWZpgI3y/kfIWc9fMFoVFpUCITfgohMnRKrwFDHg6acrm5wkzzJQT1xQ8
 pY0cn/aRJ8yAH8wVgOnc0g1Lrups59y6bdqJkcvlX5/B1w/GjHJObzlXu
 Mo2DcLRFe3jb/1vPOO3NFGGTjRXVL30QZRE4maRKHxZujFCel5bSzMilV
 6SjheaFVUylrzbIjaVWiOITYZA1s2HxggcR0aA1Pgsueknv3U8nsYiHHX
 YF8+LVZWYdICQdthvGhsYTil9Z2q8CfqovhICJIxNqO9Knx28por/dfnL Q==;
X-CSE-ConnectionGUID: dcX/dv4VSW2h1iTZzpX6KA==
X-CSE-MsgGUID: lmVcH8f4QEyDo+2kvJioLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="80968137"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="80968137"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 05:57:44 -0700
X-CSE-ConnectionGUID: GpctQaS4TKa+FlbSWauJVA==
X-CSE-MsgGUID: IUGJVGDKQ/eLrqLULEybFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="236037214"
Received: from ksoboci-mobl.ger.corp.intel.com (HELO [10.246.22.156])
 ([10.246.22.156])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 05:57:43 -0700
Message-ID: <f99a346a-b5e1-47f9-9d49-2dd90d655044@linux.intel.com>
Date: Wed, 29 Apr 2026 14:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: accel/ivpu: Remove myself and add Andrzej as
 maintainer
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com
References: <20260429083958.2148777-1-maciej.falkowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260429083958.2148777-1-maciej.falkowski@linux.intel.com>
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

On 29-Apr-26 10:39 AM, Maciej Falkowski wrote:
> As I will be departing from my current position, I will
> no longer maintain the driver, and remove myself from
> ivpu's maintainers entry. Andrzej will support Karol
> in maintaining the driver.
> 
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74d114884b34..54b941d6e8b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7835,8 +7835,8 @@ F:	drivers/soc/ti/smartreflex.c
>   F:	include/linux/power/smartreflex.h
>   
>   DRM ACCEL DRIVERS FOR INTEL VPU
> -M:	Maciej Falkowski <maciej.falkowski@linux.intel.com>
>   M:	Karol Wachowski <karol.wachowski@linux.intel.com>
> +M:	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
