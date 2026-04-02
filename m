Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5F6D6AAF8
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7C610F31B;
	Thu,  2 Apr 2026 19:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MBFPo/v+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD0110F31B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775158357; x=1806694357;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3givjIwyB9IlZitZWLexJwgsRyIp5OUoSDVC2L/f3n4=;
 b=MBFPo/v+bIkcOtCyDpg+X8Ck2YD0XhOkmkZFZPIqjBt+jIeSdMsNbvHs
 uGynItzPY0hBWpyzVEWVEjKdaoJP/+lyeFWg4Bs8DkGW9YDJ4TWljPevP
 WKWeSz+XheIBB3FoatIVzQWGgBAG63I9ngachT/2SVqGyvN5qYmnCQvaV
 JNc35ocyE/aE3m+XxiZ8134dU5bOndrPfvLRgQ1LyeotTyd/mDK/nahEK
 2zDj+34+PjdvpabPakqCFLpPnO/xdDWiISalj8Fb+4YkLmNa1y1PNo9gg
 DGA/xkBEh8Sc/c8K90zpQLsz2mcmo1LbbvXKufw8BsNqnV6GyT3nKDzRo g==;
X-CSE-ConnectionGUID: BkJTKY5jSYqlhGShVNK1dQ==
X-CSE-MsgGUID: Dv0Sru2nQqKB47cTcBPnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76241876"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="76241876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 12:32:37 -0700
X-CSE-ConnectionGUID: VRrZIspYR/aPvzXmtChnzw==
X-CSE-MsgGUID: PyPmil9CSzqLn0aw17y+aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; d="scan'208";a="226233226"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106])
 ([10.94.253.106])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 12:32:36 -0700
Message-ID: <a8a892a2-2814-4e86-b313-43c5319260fa@linux.intel.com>
Date: Thu, 2 Apr 2026 21:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Trigger recovery on TDR with OS scheduling
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, maciej.falkowski@linux.intel.com,
 lizhi.hou@amd.com, andrzej.kacprowski@linux.intel.com
References: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
 <97b595b6-9ce4-41bd-9071-b42bd23da215@oss.qualcomm.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <97b595b6-9ce4-41bd-9071-b42bd23da215@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/2/2026 9:27 PM, Jeff Hugo wrote:
> On 4/2/2026 6:55 AM, Karol Wachowski wrote:
>> With OS scheduling mode the driver cannot determine which context
>> caused the timeout, so context abort cannot be used. Instead of
>> queuing context_abort_work, directly trigger full device recovery
>> when a job timeout (TDR) occurs in OS scheduling mode.
>>
>> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of
>> device recovery on TDR")
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Thanks, applied to drm-misc-next-fixes.

Karol
