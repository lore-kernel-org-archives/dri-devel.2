Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A65C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC0B10F094;
	Wed,  9 Sep 2026 10:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EidrLEHV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A507810F0A1
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948385; x=1820484385;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bwe8ueFgkRUK7cPbsVZZk79yrlXrgNNapKy5WVmgg00=;
 b=EidrLEHVYTCxOpcIsDW1PMnarC1CikY+ES0WNd0j5VQ/GfVsMSmlW+dm
 ERLFLxLDdVFg+sU7StVJZ7FmPHpINVGpTAIGBaG20bkPkxoEN3XnqWXbU
 RhVRdLEKp+9RxPm3rySq+xyHcRbF7kwhE6QQ6uYxj22TY+BiYm4j9siOw
 9ZcH3e7W69WC7Y+DdGVGvIW/0c/YKGrvnh7jx0pyH8RqxCMIah/zWids+
 r3KbpxRnh8NCAOM9kYrauCct6Cg1MHhdo+LQNzl1FS6UYQMkbOFQg/SOQ
 5Mx9Dlixga7OIambpF87Vqnqo44miPzzXCOIa+izU34QckCLvgP3NXJ2F Q==;
X-CSE-ConnectionGUID: vAdhZkWnTI6ItPH+k+La9g==
X-CSE-MsgGUID: Y48Q+a4pRQCacqYCD5N95w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99697462"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="99697462"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:06:25 -0700
X-CSE-ConnectionGUID: HC5neVHUQJWRFKY2Yx7yPQ==
X-CSE-MsgGUID: kXYKXkXES2CGygqarjhkZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="265065592"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.163])
 ([10.102.88.163])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:06:23 -0700
Message-ID: <a38fed2b-ad33-447b-84f7-b6020c9b4072@linux.intel.com>
Date: Wed, 9 Sep 2026 12:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add support for getting and setting command
 queue priority
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260831121617.395523-1-andrzej.kacprowski@linux.intel.com>
 <20260831123327.110C91F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260831123327.110C91F00A3D@smtp.kernel.org>
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

On 31-Aug-26 2:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing CAP_SYS_NICE or DRM_MASTER check for elevated job priorities (REALTIME / FOCUS), allowing unprivileged users to monopolize the NPU.
> --
> 
> commit 57cf0d7005a7761ad6193ea568802164b7fac6db
> Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> accel/ivpu: Add support for getting and setting command queue priority
> 
> This commit adds a new DRM_IVPU_PARAM_CMDQ_PRIORITY parameter to query and
> update the scheduling priority of an existing command queue. The priority
> can be changed on a queue that already has pending jobs, propagating the
> change to firmware in hardware scheduling mode.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
>> index ebb2c865b09a0..b3de5dd29d1e8 100644
>> --- a/drivers/accel/ivpu/ivpu_job.c
>> +++ b/drivers/accel/ivpu/ivpu_job.c
> 
> [ ... ]
> 
>> @@ -1127,6 +1132,86 @@ int ivpu_cmdq_destroy_ioctl(struct drm_device *dev, void *data, struct drm_file
>>   	return ret;
>>   }
>>   
>> +static int ivpu_cmdq_priority_args_check(struct ivpu_device *vdev, u32 cmdq_id, u64 priority)
>> +{
>> +	if (!ivpu_is_capable(vdev, DRM_IVPU_CAP_CMDQ_SET_PRIORITY)) {
>> +		ivpu_dbg(vdev, IOCTL, "Command queue priority not supported\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (cmdq_id < IVPU_CMDQ_MIN_ID || cmdq_id > IVPU_CMDQ_MAX_ID) {
>> +		ivpu_dbg(vdev, IOCTL, "Invalid command queue ID %u\n", cmdq_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (priority > DRM_IVPU_JOB_PRIORITY_REALTIME)
>> +		return -EINVAL;
> 
> [Severity: High]
> This is a pre-existing issue, but is there a missing capability check for
> elevated priorities here?
> 
> An unprivileged user who opens the NPU device can call the IVPU_SET_PARAM
> ioctl with DRM_IVPU_PARAM_CMDQ_PRIORITY and set the priority to
> DRM_IVPU_JOB_PRIORITY_REALTIME. Without a CAP_SYS_NICE or DRM_MASTER check,
> could a malicious or buggy application elevate its command queue priority to
> monopolize the hardware and starve other processes?
> 
> I notice this same behavior appears to be pre-existing in
> ivpu_cmdq_create_ioctl() as well, where queues can be created with realtime
> priority by any user. Should these priority levels be restricted?
> 

The Intel NPU is not a display/graphics device and has no notion of 
DRM_MASTER which is typically the display server process.

Using CAP_SYS_NICE has a bit more merit however:
- strict CAP_SYS_NICE check in KMD will break existing use cases
- no other accel drivers use CAP_SYS_NICE

Current strategy is to allow OS level AI runtime to control NPU workload 
priority - dynamic priority change was added to
support that use case.

I will take it into consideration for future driver updates, but it
cannot be immediately solved in this patch.

- Andrzej
>> +
>> +	return 0;
>> +}
>> +
>> +int ivpu_cmdq_get_priority(struct ivpu_file_priv *file_priv, u32 cmdq_id, u64 *priority)
>> +{
> 
> [ ... ]
> 

