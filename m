Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA56606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UL2yP0Gs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE711121E6;
	Thu,  5 Nov 2026 08:50:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397411121E6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793868653; x=1825404653;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iBtDM4F2rKcVXmGFQvjZaELXwmTPbnqaasc47XTd41U=;
 b=UL2yP0GsvR/8k1+zJOZl6aGqOA7+L6upKOor/9ydZhxq8SICL8i9yzXm
 CrakSZ7s5XZ1HHaPCdB585atzgbyaTKb2vjVW4cd2rWvEYTB1VyvYksiX
 mbI+gpcB6greRK+LD81HAifn+lysXyMXYhHRQBaEwjkbEbSmJdF+Fiavq
 m7g/Gni/UmMgOCejrkwkKpQJlncAy49M0vit+B+HOUJFxI+glWIyRZ3Dm
 n8ErOQOjDnDaopmaUdFDGmgKzqYAwjjMkul1OmPIap6tH99CCC4HavZe8
 QlSZTyAPKlmqcd4Zch3zElfJ4Blf9h/oC4jhwTnaT4XM0cqTU0WXtmorY w==;
X-CSE-ConnectionGUID: Hlszgp5jSTGnfZrvrDXXqg==
X-CSE-MsgGUID: 4UwRDSLnSDKIkcCYxJkY/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2666393"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2666393"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:50:52 -0800
X-CSE-ConnectionGUID: aZoC3X9NRjOvkjx8JXZu8g==
X-CSE-MsgGUID: Fhbrn+VcQrS191cEtj9BjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7022237"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:50:50 -0800
Message-ID: <a6ccf741-9542-47ee-a1bc-b9df9fdcf6c4@linux.intel.com>
Date: Thu, 5 Nov 2026 09:50:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Limit SSIDs to 128 on all generations
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
References: <20261104182515.3198239-1-karol.wachowski@linux.intel.com>
 <a4a95bdd-349f-487e-9ed0-98a70a07ee15@oss.qualcomm.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <a4a95bdd-349f-487e-9ed0-98a70a07ee15@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04-Nov-26 19:42, Jeff Hugo wrote:
> On 11/4/2026 11:25 AM, Karol Wachowski wrote:
>> Some generations support only 128 SSIDs, while the KMD configured 256
>> CD table entries and allowed user contexts up to SSID 130. Align the
>> limit across all generations.
>>
>> Limit the CD table to 128 entries and the user SSID range to 2-127, so
>> root can create 126 contexts and non-root users 64. Also fix the off by
>> one SSID bounds checks against the CD table size.
>>
>> Before this patch the driver allowed 128 user contexts. Now the limit
>> is 128 SSIDs in total, which leaves 126 user contexts, so the only cost
>> is 2 contexts for root. Non-root users keep 64. In return the SSID
>> range, the CD table size and the bounds checks all match, testing gets
>> simpler because exact limits can be checked instead of loose minimums,
>> and the userspace interface is consistent with the same limits on all
>> generations.
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Thank you! applied to drm-misc-next.
