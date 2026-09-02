Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A84C61DD3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 00:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2362110EF84;
	Wed,  2 Sep 2026 00:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DKk7DqAc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F57510EF76;
 Wed,  2 Sep 2026 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788310492; x=1819846492;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=S2jRmT3i4CUHeBAmwKFhWwEWN2ceCfdeY5JxH6o4MBg=;
 b=DKk7DqAc6/FE4XFPHd7JPXCFN+ijYD+X0V8RS2IahZPCLpkoiuqJ4DXD
 tYjuIvNb70eu+Qmh9djKHWbYYZHJQUyEICJi1HJm/CG94buAe/2/1g9wG
 29+1JWXq1nwstJaagkmKsLiH6aD86yAjrmsLQt1QUTUk50TIDHZMDO7R2
 kFIYzJc85wj3Pe0zrQWIMTXA/hqvLWqHbcqeJHfTaCxD5vD0xcjel8kZt
 KsiDnqokEkB5tvbjd6EEgiEbK6Wz68A2O0g2f0VJ7ygF0TK/PP9UjNk1l
 JH3BwLqcVPp2l1u6D4wpLP390aUb6tWK6YUDyL7kQi1cbmCWZjiqB/bwf Q==;
X-CSE-ConnectionGUID: RgC1GnhzTFqEQ5+btC7lLQ==
X-CSE-MsgGUID: BKcLZgEbScGxpWOf5gAqYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92626697"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92626697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 17:54:50 -0700
X-CSE-ConnectionGUID: 6jThSNJbRXW4XHMxVAKrGw==
X-CSE-MsgGUID: bqJkn67PTt613PaKElruHQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239])
 ([10.124.241.239])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 17:54:48 -0700
Message-ID: <a908eb14-ede0-4002-8880-5e2718be8180@linux.intel.com>
Date: Wed, 2 Sep 2026 08:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] perf: Fix null pointer access in
 is_include_guest_event()
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
References: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
 <20260901211915.127704-2-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260901211915.127704-2-vinay.belgaumkar@intel.com>
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


On 9/2/2026 5:19 AM, Vinay Belgaumkar wrote:
> A typical module unload occurring event when there is an active perf
> connection leads to freeing of the pmu pointer. The call log is something
> like:
>  ..
>  __pmu_detach_event
>  pmu_detach_event
>  pmu_detach_events
>  perf_pmu_unregister
>  ..
>
> __pmu_detach_event() sets event->pmu to null. When the perf connection
> finally is closed, the following stack trace is observed:
>
>  Oops: general protection fault, kernel NULL pointer dereference
>  ...
>  RIP: 0010:_free_event+0x3e/0x370
>  ...
>  Call Trace:
>  ...
>  perf_event_release_kernel+0x260/0x2d0
>  perf_release+0x12/0x20
>
> A call to mediated_pmu_unaccount_event() inside _free_event() is the root
> cause of this crash. Adding a check to is_include_guest_event() ensures
> we don't accidentally access a null ptr.

Better mention adding an extra mediated_pmu_unaccount_event() call before
clearing event->pmu to ensure the nr_include_guest_events count is
correctly decreased.


>
> v2: Add another check to prevent null access (sashiko)
> v3: Use READ_ONCE for checking pmu state (sashiko)
> v4: READ_ONCE for the pmu check as well (sashiko)
> v5: Improve commit message and split patch into 2 (Dapeng)

Please remove this version history in the formal patch.

Others look good to me. Thanks.


>
> Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
> Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Assisted-by: Claude:Claude-Sonnet-5
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 94ca277e0819..f19d27ac411d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6350,6 +6350,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
>  static inline bool is_include_guest_event(struct perf_event *event)
>  {
> +	if (!event->pmu)
> +		return false;
> +
>  	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
>  	    !event->attr.exclude_guest)
>  		return true;
> @@ -12977,6 +12980,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
>  	exclusive_event_destroy(event);
>  	module_put(pmu->module);
>  
> +	mediated_pmu_unaccount_event(event);
>  	event->pmu = NULL; /* force fault instead of UAF */
>  }
>  
