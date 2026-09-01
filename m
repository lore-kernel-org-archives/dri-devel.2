Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43681C61DFD
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 01:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D30210E01F;
	Tue,  1 Sep 2026 01:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P/NVNpfN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43A910E01F;
 Tue,  1 Sep 2026 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788227684; x=1819763684;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8j3yKBNCNYtJNjNV4QzVd1BUyQ4mtd8C/5g9FVd6us0=;
 b=P/NVNpfN/v3AxYdyi79Wf9eYKo2VXC8Zb6I7ECjybi5ACV4be77V6D/d
 gbQmue3ceCxgvCBpKmyVsHXKroSolOwLAjnbSz/k14EhxKBaJTTu1dJke
 wlUWfx36NqCpIeLgI7R6oyVzd73cB0WD4+qG2L5cxQEqkhhDV4ed0kDg/
 X+q4AuHfWSX9JwigVkOc371+Bl2RlvR8ms8/B70tvU6yuA5KeMq/8NbKf
 MxdeDz/h3bBUaBh0Jj/VA1eWFoDvFHuFjJHTfUPMeIm9so2kF8NfADqX+
 01dC4YIx/jdwHsOHPMtHVEXehXcqdXZhBeZ8CYfVF8G83XnUT5gwSmMVU Q==;
X-CSE-ConnectionGUID: C2oywbrYQHyHcuE93iQo4g==
X-CSE-MsgGUID: OjHbc564Q1mTmIOrkBAPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88768507"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88768507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 18:54:43 -0700
X-CSE-ConnectionGUID: bXhHWCv4So2yLTu58moeiw==
X-CSE-MsgGUID: Q9rcCi5rSGuWhAy+fOUhbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="268416299"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239])
 ([10.124.241.239])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 18:54:42 -0700
Message-ID: <bc3efbe7-440f-480e-9bff-8efa65227fff@linux.intel.com>
Date: Tue, 1 Sep 2026 09:54:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf: Fix null pointer access in
 is_include_guest_event()
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
References: <20260831235030.6737-1-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260831235030.6737-1-vinay.belgaumkar@intel.com>
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


On 9/1/2026 7:50 AM, Vinay Belgaumkar wrote:
> A kernel panic is observed when an application has a perf connection open
> and the driver managing the pmu event unbinds. The issue occurs when
> perf_pmu_unregister() is called while there is an active perf session. The
> null pointer error is seen when the event is freed through __free_event()
> and mediated_pmu_unaccount_event is called. There is a missing null check
> inside is_include_guest_event(). Also call mediated_pmu_unaccount_event()
> inside __pmu_detach_event() similar to __free_event().
>
> Signature of the failure:
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
> While here, also add a null check inside perf_event_read_local() which can
> cause a similar crash. Sashiko pointed out a possible race between when we
> check for revoked state here and then actually access event-pmu inside
> __perf_event_read_cpu(). So, add another null check there.
>
> v2: Add another check to prevent null access (sashiko)
> v3: Use READ_ONCE for checking pmu state (sashiko)
> v4: READ_ONCE for the pmu check as well (sashiko)

Thanks for finding and reporting this issue.

Please rewrite the change log and explicitly show the call-chain and tell
why NULL pointer is accessed.

e.g, pmu_detach_event() clears the event->pmu to null and then put_event()
calls mediated_pmu_unaccount_event() and then trigger the NULL pointer access.


>
> Fixes: eff95e170275 ("perf: Add APIs to create/release mediated guest vPMUs")
> Cc: Alexander Kanevskiy <alexander.kanevskiy@intel.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Assisted-by: Claude:Claude-Sonnet-5
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 94ca277e0819..4f8c5191ef2c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4794,6 +4794,9 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>  		return event_cpu;
>  
> +	if (!READ_ONCE(event->pmu))
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>  		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
>  
> @@ -4917,6 +4920,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  		goto out;
>  	}
>  
> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +

The above two changes has nothing to do with the fix of null pointer
access, better move them into a separate patch.
Thanks.


>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally
> @@ -6350,6 +6358,9 @@ static DEFINE_MUTEX(perf_mediated_pmu_mutex);
>  /* !exclude_guest event of PMU with PERF_PMU_CAP_MEDIATED_VPMU */
>  static inline bool is_include_guest_event(struct perf_event *event)
>  {
> +	if (!event->pmu)
> +		return false;
> +
>  	if ((event->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) &&
>  	    !event->attr.exclude_guest)
>  		return true;
> @@ -12977,6 +12988,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
>  	exclusive_event_destroy(event);
>  	module_put(pmu->module);
>  
> +	mediated_pmu_unaccount_event(event);
>  	event->pmu = NULL; /* force fault instead of UAF */
>  }
>  
