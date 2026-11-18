Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ef1MtHjR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF17F10E740;
	Wed, 18 Nov 2026 08:05:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AD010E76E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794989104; x=1826525104;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XlKMKL/pYXQeh7adDpDkdCsyRNwSDFhWhUZt0OSipHg=;
 b=ef1MtHjRZYdGwdETQmZ36TAR8OS7dNN63I6JdkNgf9FQ6JlI4k/FaTIr
 ZorI/pr+GFFYxTvmOrbitFZhU+PYom2kHdzcMQWiqe3FUO4Ovt+OhX20K
 ZmrePUWGMZV990VR7yb3vdXwwhm/N9PszK//TVwnYMMLI2AGkTEWyNHQ0
 1W9n5g3+6JXl2auOYemw9ZS+652ohkbVfZshIkPtCIfLnMpDWhYjXaBsV
 H27MSVcjeYL69c0R+Ga9T3GZr9a2WVMT8U5yHMI+5cudtXSpAaYX2trc2
 DVIHML5YGRqCcgWggquJKdwB+fHB5O2iiO3XG4k794jATDYiOkyqfnazt g==;
X-CSE-ConnectionGUID: WX+iunWwSWmoDWT0cYZ//w==
X-CSE-MsgGUID: VDDdpiz5Ql+LmGayQPFsRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3866205"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3866205"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:04:56 -0800
X-CSE-ConnectionGUID: CiGSPustT1Cf9l+yJ9HcmA==
X-CSE-MsgGUID: TNSujRRHRHCfrVoao9YGuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9956414"
Received: from unknown (HELO [10.94.255.201]) ([10.94.255.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 00:04:55 -0800
Message-ID: <d87dbef5-e8b1-418c-87c8-e1ba55fb4b68@linux.intel.com>
Date: Wed, 18 Nov 2026 09:04:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Remove sched_mode module parameter
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20261117204419.2841928-1-andrzej.kacprowski@linux.intel.com>
 <2f3d94d3-1f9d-4a88-b500-ce42ff85949d@oss.qualcomm.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <2f3d94d3-1f9d-4a88-b500-ce42ff85949d@oss.qualcomm.com>
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

On 17-Nov-26 21:52, Jeff Hugo wrote:
> On 11/17/2026 1:44 PM, Andrzej Kacprowski wrote:
>> OS scheduling supports only a limited subset of NPU functionality and
>> is not intended for production use. However, the sched_mode module
>> parameter exposes it as a regular configuration option, and the driver
>> silently falls back to it when the firmware JSM API is older than 3.24.
>>
>> Make hardware scheduling the only production mode:
>> - remove the sched_mode module parameter,
>> - require BOOT API 3.17 and JSM API 3.24 or newer, and fail probe with
>>    a message requesting a firmware update otherwise,
>> - allow OS scheduling on pre-60XX devices only through the
>>    IVPU_TEST_MODE_HWS_DISABLE test_mode bit, for debugging.
>>
>> The initial 37xx and 40xx firmware added to linux-firmware in March 2025
>> reports BOOT and JSM APIs 3.27, meeting both minimum requirements.
>>
>> Extend IVPU_FW_CHECK_API_COMPAT() to accept minimum major and minor
>> versions so both API requirements can be checked explicitly.
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Thanks, applied to drm-misc-next.
