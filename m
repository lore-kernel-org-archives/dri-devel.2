Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F7606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K5VdJXxZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6F510E67F;
	Tue, 24 Nov 2026 10:38:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B48310E558
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795516676; x=1827052676;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=I4v+wONK1FXSVueaXbyLGJ1AmJLwnyimTD98hqISR48=;
 b=K5VdJXxZ2A5g/2ZSja0CgTptIL+M21HkprMC6sZ8JcLcp7s9hsNJ7uLs
 e2fxPbH/aVNO4Ap/aVAw8jFnyv7lGILbdUBpmPZDdHvS0Jl8sHGNEjBQn
 dfv1grjZ046MvGTmvahlobFF0vU1X0xhlBhXW2DZGqTH9TD3WYlDh+w13
 NYebQpT8OsRAzToDWzDM/6yHoAINNX76dmZDDNpIV5bmMPjPPsyQkL0on
 9LPhLRePXhrRi4zIS7rZHcp2eegIBtBsXcGQ+iHAV0WfgbHDA9pDtj0PO
 ASptwgS2EcOSa31FDBPIE9jOxurF6PIl4c11uLdefBFBQ75yt3V+YN58J A==;
X-CSE-ConnectionGUID: 3ak2GC0cQHSPF3KPIhrfIw==
X-CSE-MsgGUID: xWM4ctqpR3qS9royFFpA8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4234915"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4234915"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:37:54 -0800
X-CSE-ConnectionGUID: rLQ1pzOpQbGZ5wKVY0VZCA==
X-CSE-MsgGUID: FyFWJ1/yR22HkL/u1Z00Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13542398"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [10.102.89.37])
 ([10.102.89.37])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:37:53 -0800
Message-ID: <134f5d27-332d-4314-9d9d-43a45ae17532@linux.intel.com>
Date: Tue, 24 Nov 2026 11:37:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Dawid Osuchowski as Intel VPU maintainer
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, linux-kernel@vger.kernel.org
References: <20261123122007.2580451-1-dawid.osuchowski@linux.intel.com>
 <d9b91e95-243d-4e3c-92b0-0355dca59a63@linux.intel.com>
 <e3e03774-f066-4cfa-88dc-183fb06d80e5@oss.qualcomm.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <e3e03774-f066-4cfa-88dc-183fb06d80e5@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-23 5:31 PM, Jeff Hugo wrote:
> On 11/23/2026 5:38 AM, Karol Wachowski wrote:
>> On 23-Nov-26 13:20, Dawid Osuchowski wrote:
>>> Add myself as a new accel/ivpu driver maintainer.
>>>
>>> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>>> ---
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index bcade5bfbafe..0afa391498d0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8198,6 +8198,7 @@ F:    include/linux/power/smartreflex.h
>>>   DRM ACCEL DRIVERS FOR INTEL VPU
>>>   M:    Karol Wachowski <karol.wachowski@linux.intel.com>
>>>   M:    Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>>> +M:    Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>>>   L:    dri-devel@lists.freedesktop.org
>>>   S:    Supported
>>>   T:    git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>
>> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Applied to drm-misc-next. Seems my commit rights work :)
