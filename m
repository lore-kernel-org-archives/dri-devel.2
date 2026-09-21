Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E17FC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6730210E05A;
	Mon, 21 Sep 2026 15:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S4E3DtfF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD6010E05A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790003003; x=1821539003;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IbeDwZ+7oz9OB+PaSKVwiska41rwL948uzX5PD1ESew=;
 b=S4E3DtfFGzoSNUjFmDedNjTHDX6dtXiunws1U41RFTi3GJUxI/1yQjGH
 wu1pwMu87lrZRJr0vZMUDNVUmtp9dTYvx+ZibjDze6wdTRTOMGmITgF/E
 C4mKrwwP1J7ODAxrCpWC6AEB7xXXqLXWB/G9K1sSXdGeJxECIewqhTXuC
 ak37iGt8N+jgdxQrn1Kq3UABygAaqs6clAQhKmGucbBoAoHDWx1/i/fhC
 Smi0T2qGouAP3GA0YmG7fEiRO4yFUYzmzDPPT68yIyZuWOJUUmwHFvbb6
 ChVV9pTVgXBrWx1czxUmPqokuBL0LmBDJheyPdk63qJh1nW2ZseQpK26Z w==;
X-CSE-ConnectionGUID: k1Clc4GSTMapznlECy+jZg==
X-CSE-MsgGUID: QgYAFJlOQxikdWupCPTS1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90390349"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="90390349"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:56:28 -0700
X-CSE-ConnectionGUID: xMT0kHaQTQyFmtHCXQakDA==
X-CSE-MsgGUID: QPCnh7EXTtiC7vJpJiW+Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3985532"
Received: from eoghanoc-mobl1.ger.corp.intel.com (HELO [10.245.112.245])
 ([10.245.112.245])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:56:26 -0700
Message-ID: <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
Date: Mon, 21 Sep 2026 16:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jakub Pawlak <jakub.pawlak@intel.com>,
 stable@vger.kernel.org
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
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

On 2026-09-14 10:43 AM, Karol Wachowski wrote:
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Use separate flag to mark a job timeout as a reason
> of starting context_abort_work. This allows to distinguish
> engine reset reason and clearly adjust reset procedure flow.
> 
> The flag is cleared in ivpu_prepare_for_reset(), which every
> recovery and suspend path already funnels through, so that the
> state is clean after recovery.
> 
> Cc: <stable@vger.kernel.org> # v7.1+
> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
> Changes in v2:
>   - add Cc: tag
>   - link to v1: https://lore.kernel.org/dri-devel/20260914082800.892044-1-karol.wachowski@linux.intel.com/T/#u
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 3 ++-
>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>   drivers/accel/ivpu/ivpu_job.c | 7 +++----
>   drivers/accel/ivpu/ivpu_mmu.c | 1 -
>   drivers/accel/ivpu/ivpu_pm.c  | 1 +
>   5 files changed, 7 insertions(+), 7 deletions(-)


