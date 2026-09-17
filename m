Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A6C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11F510E45C;
	Thu, 17 Sep 2026 08:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XwLUdBkz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F7B10E45C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789632537; x=1821168537;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Yobk6heVxctqxr2mlbmcRBpI0WJzUEDDTC0ybpvphDQ=;
 b=XwLUdBkz6/OU1OUCX4JSj7NcE31FSctsbDVtKrq/N3NHxXHCSrXJaM4b
 uc7RPMKZERqry1lk6hozkVapqX3gYCbBYddeZj85I2UBDDdXv2va7tDYc
 aG+oMvCjqzSfb0oUe34ngaYiDlwXwtDOoiC1LJ3916Nu33Bi7onSS3qCg
 nxEPvV5AjFGbYBUEXj4C2m+jdGYuoUnfvYVBI8iFxV1U5nOTLBZOPboKq
 Yg9I8CGYNEu/D9ymnJ1HmioJ7RpZmErh5S7PEBNsOsmBoA7Q+laDT2FIk
 veyfP1Ufakf673eADVkLcuPh+JzEwsuESUCTnEx0WzzTvrlsFzZbSOfGg w==;
X-CSE-ConnectionGUID: jnQ+dw/oS7Klhav+3tZLeg==
X-CSE-MsgGUID: +qETNnh7Sv6siS36ItKPNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89896472"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89896472"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:08:56 -0700
X-CSE-ConnectionGUID: 40ykZD70SHCV91zllPiq6g==
X-CSE-MsgGUID: svGeHbhgTyu75M251Asybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="275603378"
Received: from mocoilea-mobl1.ger.corp.intel.com (HELO [10.245.32.242])
 ([10.245.32.242])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:08:54 -0700
Message-ID: <ce048cc5-010b-4483-8b90-d1cf8e220875@linux.intel.com>
Date: Thu, 17 Sep 2026 10:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Synchronize context abort work with device
 reset
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, Jozef Wludzik <jozef.wludzik@intel.com>
References: <20260914083006.892645-1-karol.wachowski@linux.intel.com>
 <c90719c7-ce9f-42f5-a182-82e00eaaeb31@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <c90719c7-ce9f-42f5-a182-82e00eaaeb31@linux.intel.com>
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

On 15-Sep-26 10:46, Dawid Osuchowski wrote:
> On 2026-09-14 10:30 AM, Karol Wachowski wrote:
>> From: Jozef Wludzik <jozef.wludzik@intel.com>
>>
>> Acquire pm->reset_lock in ivpu_context_abort_work_fn() to prevent it
>> from running concurrently with a device reset. If the lock cannot be
>> acquired immediately, skip the abort work to avoid racing with reset.
>> The device power management is disabled during reset.
>>
> 
> Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks, applied to drm-misc-next.


>> Signed-off-by: Jozef Wludzik <jozef.wludzik@intel.com>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_job.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)

