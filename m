Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395FEC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6295D10E41B;
	Tue, 22 Sep 2026 06:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WKFWodGF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2C910E41B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790056967; x=1821592967;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kGrUP8lQtbXqNkfszgaCdmZayGooSU84mNcC1IzyPvQ=;
 b=WKFWodGFr9hwb8fMuC5QFy59pUh62BGViSiN17VE3rSzrDQj8P5fRpDI
 1vHPcSsRYf//CCDxC7gZmv2OpKGBau2ujp/uEX8P/KQ1GM3TcUyh+Mgs7
 Mae7Y4awdvjfOMH7e1EWtTKtXqltkaUb9RsdTmiiVAl0P9FFhfhrdGmPI
 ZM67RIQLwT6CuV/Xbx6mcu4bOUjTtVhI0WDUYGUvnlU0Ulbp7BS8NPMo8
 K+yUqr+srGOYxDy1UAhBRAtCYp/x1CjOKxRwf6fxgBGCcfbr4R9rKIynp
 OcetRgFQtp3aDyNdsOMlWZPGBkLTIRDDX1cuH+xNHYfadcwOf36VeS5WK Q==;
X-CSE-ConnectionGUID: 5FWVrUSORcqlKzs5pR9WMA==
X-CSE-MsgGUID: k8pLLT9jQ6m1qCNoWuT7wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1134729"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1134729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 23:02:46 -0700
X-CSE-ConnectionGUID: uP2g1mAtS5W8rKM5ycBvjQ==
X-CSE-MsgGUID: j/2Iqo2cQYiYzRmpQt/klg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272182660"
Received: from jfedorov-mobl2.ccr.corp.intel.com (HELO [10.245.80.122])
 ([10.245.80.122])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 23:02:42 -0700
Message-ID: <10240e7e-858b-4283-b7cb-d4af2459a341@linux.intel.com>
Date: Tue, 22 Sep 2026 08:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Use separate flag for job timeout
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jakub Pawlak <jakub.pawlak@intel.com>,
 stable@vger.kernel.org
References: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
 <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <ac09bf4a-2b65-421a-a5f6-87c5a89ba734@linux.intel.com>
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

On 21-Sep-26 16:56, Dawid Osuchowski wrote:
> On 2026-09-14 10:43 AM, Karol Wachowski wrote:
>> From: Jakub Pawlak <jakub.pawlak@intel.com>
>>
>> Use separate flag to mark a job timeout as a reason
>> of starting context_abort_work. This allows to distinguish
>> engine reset reason and clearly adjust reset procedure flow.
>>
>> The flag is cleared in ivpu_prepare_for_reset(), which every
>> recovery and suspend path already funnels through, so that the
>> state is clean after recovery.
>>
>> Cc: <stable@vger.kernel.org> # v7.1+
>> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of 
>> device recovery on TDR")
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-fixes.

> 
>> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>> Changes in v2:
>>   - add Cc: tag
>>   - link to v1: https://lore.kernel.org/dri- 
>> devel/20260914082800.892044-1-karol.wachowski@linux.intel.com/T/#u
>> ---
>>   drivers/accel/ivpu/ivpu_drv.c | 3 ++-
>>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>>   drivers/accel/ivpu/ivpu_job.c | 7 +++----
>>   drivers/accel/ivpu/ivpu_mmu.c | 1 -
>>   drivers/accel/ivpu/ivpu_pm.c  | 1 +
>>   5 files changed, 7 insertions(+), 7 deletions(-)
> 

