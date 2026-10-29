Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C58606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k+GfJLxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BB310E287;
	Thu, 29 Oct 2026 08:33:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1FD10E51B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793262803; x=1824798803;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZJguB7X0IbnaKjkBdcdAqyk+Hb5z9L7nYLjBrpAi+xY=;
 b=k+GfJLxGvZH5/Y+ehivYuzPyQ+iLTv83ocq9BArIsgTRLGrnRjJLH11V
 BDglVYrMkdNXo+FRH/js0H4W9373k+KVgzYdnvSDDYy5rsaN/JDTD/ido
 G5wo4E3du7D77Nrih2KSGl5PZi/67gFp3k/mVQvO4k64MB6cYfmxCgnUx
 3mO6S1kDQ2iB0JvlAeIwDIEqWlny0qEKpzVtMmfiAGTjJ87PSUE0sKukK
 MoIilBBKWFGdbqcFAENMJ4Fzf9TDkjmM9a3djYnU94VNE2aiZbs/JiVsf
 pspO7YEzUZfQ3yZhJERm1xk2Lgi8GJsNhule4F5zfvBgommIIKIuhXbsr Q==;
X-CSE-ConnectionGUID: qDf7M/vhRtWknJwqgeVrTg==
X-CSE-MsgGUID: nQ0IRTIxQMysEozc2KwGYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1876754"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1876754"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:33:22 -0700
X-CSE-ConnectionGUID: rPMVvMpcQoK8//F1tsLN6w==
X-CSE-MsgGUID: Kww+H4SgTW2ZdafkoovWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5609809"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:33:21 -0700
Message-ID: <4a97d32f-07cd-4752-90a7-5490dafdabfb@linux.intel.com>
Date: Thu, 29 Oct 2026 09:33:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Read preemption buffer size from boot
 params
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20261027164529.295791-1-andrzej.kacprowski@linux.intel.com>
 <1d24db8a-1251-4fbf-933a-97b908660576@linux.intel.com>
 <eecad0bc-1c70-485c-8a13-0459df71f5b3@oss.qualcomm.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <eecad0bc-1c70-485c-8a13-0459df71f5b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28-Oct-26 16:22, Jeff Hugo wrote:
> On 10/28/2026 2:59 AM, Wachowski, Karol wrote:
>> On 27-Oct-26 17:45, Andrzej Kacprowski wrote:
>>> The optimal preemption buffer size depends on the hardware and firmware
>>> configuration, which is best known to the firmware. Newer firmware
>>> reports the required size in the preemption_buffer_size field of the
>>> boot params, which it writes before signaling cold boot completion.
>>>
>>> Read the size from the boot params once, after the initial cold boot
>>> during device initialization, as the firmware does not update it
>>> afterwards. Use it as the primary preemption buffer size and skip
>>> allocating the secondary buffer. A size outside of the [2 MiB, 32 MiB]
>>> range is treated as a firmware error and fails probe. If the firmware
>>> does not report the size, keep using the sizes from the firmware image
>>> header to preserve compatibility with older firmware.
>>>
>>> The preemption buffer sizes in the image header are deprecated in
>>> favor of the boot params, meaning the boot params size takes
>>> precedence when available. Firmware still provides valid sizes in the
>>> image header so that older kernels keep working, so the image header
>>> sizes are always validated and used until the boot params are read.
>>>
>>> Simplify the image header size selection: use the max sizes for both
>>> buffers when preemption_buffer_1_max_size is set, otherwise use the
>>> regular sizes. All known firmware versions that set
>>> preemption_buffer_1_max_size also set preemption_buffer_2_max_size, so
>>> selecting each buffer size separately is not needed.
>>>
>>> Move initialization of the trace and DVFS defaults to
>>> ivpu_fw_preboot_init().
>>>
>>> Update the FW boot API header to version 3.39.1:
>>> - Add the VPU_GOV_ON_DEMAND_PER_PRIORITY and VPU_GOV_ON_DEMAND_QOS
>>>    DVFS governors
>>> - Add the preemption_buffer_size field to struct vpu_boot_params
>>> - Mark the preemption buffer sizes in the image header as deprecated
>>>    in favor of preemption_buffer_size
>>>
>>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>>
>> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Applied to drm-misc-next.
