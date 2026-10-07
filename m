Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F4ECA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C8010E611;
	Wed,  7 Oct 2026 16:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jhPZgAs6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6FB10E407
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 16:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791389881; x=1822925881;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QoUzk8J5g1hjckbO218Bq/04HkLzeJUa0Q5nUI1QfU8=;
 b=jhPZgAs6S9BJx1Wd70bAot/rMWCYKFgyUy5owIrpbl67YtxryKd2EpPT
 8p2FK+lm+ySqzuSx7Hfc+ncUNyCMSW0m7dc2Qe68m7XHeZc9xbJWukNiT
 rWFo8M4FRhWzltD38Wjha7/Im5otbE6w1z4iOHhZY+FgXZV4DkCtYxLkd
 7sacgQdNQcEiPAP4DJTi+klPDlUIV2GbmZjEELhRLCSsvyQ4D/dInS47d
 RVPhKzDwcMJ+FkMGOOG0bXOLiC8kJ+YV0DFl/UzPqivld0lhCfSJiCXYS
 ZiXK0l9RGhLr7ZZ0oruuG2c0t3r7m49oMWtot/p5iFPrwu/7f9MZDE3et w==;
X-CSE-ConnectionGUID: trod3ZeETUeqR3YprIeX4A==
X-CSE-MsgGUID: o5HxMZPOQ2WM0KrRWmTvEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="165965"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="165965"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 09:18:01 -0700
X-CSE-ConnectionGUID: 8AEPxnKqQ4qLJzptFxz1ow==
X-CSE-MsgGUID: RMI+MXeYSt6Ml15UXMUMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="282297087"
Received: from orewaldx-mobl.ger.corp.intel.com (HELO [10.245.113.139])
 ([10.245.113.139])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 09:17:59 -0700
Message-ID: <f3030543-45f3-4719-b8a9-4fd6226263e6@linux.intel.com>
Date: Wed, 7 Oct 2026 18:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261007102414.2661045-1-andrzej.kacprowski@linux.intel.com>
 <sashiko-outbox-162864@kernel.org>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <sashiko-outbox-162864@kernel.org>
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

On 07-Oct-26 12:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] accel/ivpu: IRQ disable depth leak in FW_TEST mode due to unbalanced disable_irq()
> --
> 
> commit 03c00af9f26af13756e29777951597b1aedc577d
> Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
> 
> When driver is operating in IVPU_TEST_MODE_FW_TEST debug mode
> it should boot the firmware, but skip communication with
> the firmware. There is no need to enable interrupts or send messages.
> The output of the firmware test will be available in the
> firmware log.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
>> index 647684219e9d3..d66abf645e7b9 100644
>> --- a/drivers/accel/ivpu/ivpu_drv.c
>> +++ b/drivers/accel/ivpu/ivpu_drv.c
> 
> [ ... ]
> 
>> @@ -487,6 +484,9 @@ int ivpu_boot(struct ivpu_device *vdev)
>>   		return ret;
>>   	}
>>   
>> +	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
>> +		return 0;
>> +
> 
> [Severity: High]
> Does this early return cause an IRQ disable depth leak?
> 
> Since ivpu_boot() skips the call to enable_irq() when IVPU_TEST_MODE_FW_TEST
> is enabled, it breaks the enable/disable symmetry.
> 
> Later, during teardown paths like ivpu_prepare_for_reset(), disable_irq()
> is called unconditionally:
> 
> drivers/accel/ivpu/ivpu_drv.c:ivpu_prepare_for_reset() {
>      ...
>      disable_irq(vdev->irq);
>      ...
> }
> 
> Calling disable_irq() without a matching enable_irq() increments the disable
> depth on each suspend/resume cycle. If the user dynamically disables FW_TEST
> mode via sysfs, subsequent enable_irq() calls will only decrement the
> accumulated depth by 1, leaving the physical interrupt permanently disabled.
> 
>>   	ret = ivpu_wait_for_ready(vdev);
>>   	if (ret) {
>>   		ivpu_err(vdev, "Failed to boot the firmware: %d\n", ret);
> 
Will be addressed in v2 patch.
