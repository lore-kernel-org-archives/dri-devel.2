Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFC0C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 00:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B9F10EF8D;
	Wed,  2 Sep 2026 00:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n3chE2cm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103B210EF8B;
 Wed,  2 Sep 2026 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788310535; x=1819846535;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6n3FYhGfwlTRZB1CO/Fs5VWpgSYsGMMkcCMblN/leOg=;
 b=n3chE2cm8LpKL5Es2as8WKWpFrtsBK2aeBckmjbBCLxCdRmjIbZNFEiP
 Ijrb7bk92UbCayBaEBZUPNxdXu2zROPP8CNXQMCAaP9XJ1Lj8Se6kcf8+
 By5dxyCMCVjwhf0iH4DIePbW8xvuos/PUw2m4sP/dPu7lRVTV2MbvwGXX
 NUUt1gFgnwFw+EAjCaZ1qhI0Bz3gWSGZacu0vZoIVNfYc2VA+mpIm979o
 ep1BEXo+iph1L7zE6mth5jPWVnbkJfDs4DLKwE5epcK8cavtdMBpZoijQ
 xScwRuGAfYeL/2hm8Vru5/PF5RYjWz4UO1onUL3QUGyhLjHKamQtFQnTg A==;
X-CSE-ConnectionGUID: ibspg/0sQWGgfgoYTFg19Q==
X-CSE-MsgGUID: H2NTxZwqTHKdPVsRKUblcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99090453"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="99090453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 17:55:34 -0700
X-CSE-ConnectionGUID: 6LQfxdCsQIKzfrY2PZwcoQ==
X-CSE-MsgGUID: esvl8ikTT8OdI2d81AbO3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="292774389"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239])
 ([10.124.241.239])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 17:55:32 -0700
Message-ID: <6afe83f1-ad57-4b87-aa18-f08bb7376d64@linux.intel.com>
Date: Wed, 2 Sep 2026 08:55:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] perf: Add checks to prevent null ptr access
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
 <20260901211915.127704-3-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260901211915.127704-3-vinay.belgaumkar@intel.com>
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

LGTM. Thanks.

On 9/2/2026 5:19 AM, Vinay Belgaumkar wrote:
> Sashiko recommended some additional checks to prevent null pointer
> access. Check for revoked states inside perf_event_read_local(), as
> the pmu event may have already been freed at this point. Add a null
> check inside __perf_event_read_cpu() as well before accessing the pmu
> ptr.
>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> ---
>  kernel/events/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f19d27ac411d..bb90034a2054 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>  
>  static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>  {
> +	struct pmu *pmu = READ_ONCE(event->pmu);
>  	int local_cpu = smp_processor_id();
>  	u16 local_pkg, event_pkg;
>  
>  	if ((unsigned)event_cpu >= nr_cpu_ids)
>  		return event_cpu;
>  
> +	if (!pmu)
> +		return -ENODEV;
> +
>  	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
> +										event_cpu);
>  
>  		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>  			return local_cpu;
> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  		goto out;
>  	}
>  
> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Get the event CPU numbers, and adjust them to local if the event is
>  	 * a per-package event that can be read locally
