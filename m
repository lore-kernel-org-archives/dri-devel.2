Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB001606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iTX7n8eq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7A210E446;
	Tue, 27 Oct 2026 16:49:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5DB10E446
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793119752; x=1824655752;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=C1TIIaga/k5KmBqCMhtb6stJtqTXJiiwCNIT/1tPjGE=;
 b=iTX7n8eqkHw5/DNqbtRBWNOQHyzq/u/8voip/H/DpZt6iYbRR0jsx5U8
 riU4+IspDMlZ2dCXhLPDvJ8Nmc91ajF5NvEXqd+34mzmTser8RLdD3rPV
 ojzqhxePUUrUxpyMIsCB/gqxEytTAz34OU3ffSiS0KsQ62abbRrP27WlS
 RX0Bw4lSt/Wt0nc31qw4nubom2JEayYDav3FVu5qrZlRRy0HtyzDYK7NA
 XPmPV3s6OxT7ZAMmaHFOPMtF13FYldCf1ehqyESonHW7/tdkifAMAKsFP
 QmHtXql5O6sHXpABUG2907w1Gghjwr40KjHBWZAEc5jK7Aur9QCL424JG w==;
X-CSE-ConnectionGUID: FgY0goSVTnqmkLWkd0fR7g==
X-CSE-MsgGUID: NEnx5TJ2QyKmjQn0lhCUpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1707175"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1707175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 09:49:12 -0700
X-CSE-ConnectionGUID: r20HOsjjRo6v/coL375vKw==
X-CSE-MsgGUID: 729X7xg0SgqW+CPvelzf4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4987269"
Received: from nkthomas-mobl.amr.corp.intel.com (HELO [10.245.83.220])
 ([10.245.83.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 09:49:12 -0700
Message-ID: <acf8c268-fbb2-42d3-a3c9-7b52f9b9b9e4@linux.intel.com>
Date: Tue, 27 Oct 2026 17:48:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Read preemption buffer size from boot params
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20261026093020.228233-1-andrzej.kacprowski@linux.intel.com>
 <sashiko-outbox-184934@kernel.org>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <sashiko-outbox-184934@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-Oct-26 11:24 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] accel/ivpu: ivpu_preemption_config_parse() rejects zero secondary buffer size
> --
> 
> commit e2bae997f3bdfe346d64fb0ce52874d7284d8b32
> Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> accel/ivpu: Read preemption buffer size from boot params
> 
> This commit updates the ivpu driver to read the preemption buffer size from
> the firmware boot parameters after cold boot during device initialization,
> falling back to the sizes in the firmware image header if not reported. It
> also updates the image header parsing logic to use
> preemption_buffer_2_max_size even when it is zero if
> preemption_buffer_1_max_size is set, and updates the firmware boot API header
> to version 3.39.1.
> 
>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>> index 96f5be23a8673..6607a5da19340 100644
>> --- a/drivers/accel/ivpu/ivpu_fw.c
>> +++ b/drivers/accel/ivpu/ivpu_fw.c
> [ ... ]
>> @@ -160,35 +165,31 @@ ivpu_fw_sched_mode_select(struct ivpu_device *vdev)
>>   static void
>>   ivpu_preemption_config_parse(struct ivpu_device *vdev, const struct vpu_firmware_header *fw_hdr)
>>   {
>> -	struct ivpu_fw_info *fw = vdev->fw;
>>   	u32 primary_preempt_buf_size, secondary_preempt_buf_size;
>>   
>> -	if (fw_hdr->preemption_buffer_1_max_size)
>> +	if (fw_hdr->preemption_buffer_1_max_size) {
>>   		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_max_size;
>> -	else
>> -		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_size;
>> -
>> -	if (fw_hdr->preemption_buffer_2_max_size)
>>   		secondary_preempt_buf_size = fw_hdr->preemption_buffer_2_max_size;
>> -	else
>> +	} else {
>> +		primary_preempt_buf_size = fw_hdr->preemption_buffer_1_size;
>>   		secondary_preempt_buf_size = fw_hdr->preemption_buffer_2_size;
>> -
>> -	ivpu_dbg(vdev, FW_BOOT, "Preemption buffer size, primary: %u, secondary: %u\n",
>> -		 primary_preempt_buf_size, secondary_preempt_buf_size);
>> +	}
>>   
>>   	if (primary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE ||
>>   	    secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE) {
>> -		ivpu_warn(vdev, "Preemption buffers size too small\n");
>> +		ivpu_warn(vdev, "Preemption buffers size too small, primary %u, secondary %u\n",
>> +			  primary_preempt_buf_size, secondary_preempt_buf_size);
>>   		return;
>>   	}
> 
> [Severity: Medium]
> When fw_hdr->preemption_buffer_1_max_size is non-zero and
> fw_hdr->preemption_buffer_2_max_size is 0, won't the
> secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE check in
> ivpu_preemption_config_parse() in drivers/accel/ivpu/ivpu_fw.c always trigger
> a warning and return early?
> 
> The commit message notes that when preemption_buffer_1_max_size is set in the
> image header, preemption_buffer_2_max_size should be used even if it is zero,
> and ivpu_preemption_buffers_create() in drivers/accel/ivpu/ivpu_job.c is
> updated to handle vdev->fw->secondary_preempt_buf_size == 0.
> 
> However, during ivpu_dev_init() -> ivpu_fw_init() -> ivpu_fw_parse() ->
> ivpu_preemption_config_parse(), if secondary_preempt_buf_size is 0, checking
> secondary_preempt_buf_size < FW_PREEMPT_BUF_MIN_SIZE (where
> FW_PREEMPT_BUF_MIN_SIZE is SZ_4K) evaluates to true and returns before
> reaching:
> 
> 	vdev->fw->primary_preempt_buf_size = ALIGN(primary_preempt_buf_size, PAGE_SIZE);
> 	vdev->fw->secondary_preempt_buf_size = ALIGN(secondary_preempt_buf_size, PAGE_SIZE);
> 
> For firmware that relies on the image header sizes
> (boot_params->preemption_buffer_size == 0) with
> preemption_buffer_1_max_size > 0 and preemption_buffer_2_max_size == 0,
> vdev->fw->primary_preempt_buf_size remains 0, ivpu_fw_postboot_init() warns
> that hardware scheduling has no preemption buffer, and
> ivpu_preemption_buffers_create() skips allocating the primary preemption
> buffer.

The case with preemption_buffer_1_max_size set and
preemption_buffer_2_max_size == 0 does not occur: all known firmware
versions set both max sizes together.

> 
> In addition, on newer firmware where the deprecated image header preemption
> buffer fields are zeroed in favor of boot_params->preemption_buffer_size,
> won't ivpu_preemption_config_parse() also emit a false-positive warning on
> every probe before the boot params are read in ivpu_fw_postboot_init()?
> "Deprecated" means the boot params size takes precedence when available; 
the image header still carries valid sizes so that older kernels keep 
working, so newer firmware does not trigger the warning.


I will post patch v2 with clarified commit message.

- Andrzej
