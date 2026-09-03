Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DCEC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352B510E080;
	Thu,  3 Sep 2026 01:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CDqWOf3q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C8B10E080;
 Thu,  3 Sep 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788400205; x=1819936205;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RB+qkzgXOajuFs7t+kc7qNYg3ZXIf2RN4UH/sDGF6xs=;
 b=CDqWOf3q2lz2abEJD9XuF+i2MyxqNpnS7AVrmLey9fl+NsgFG/TwIEuQ
 OKJ1CkfsnqlVny0P80+B7gcVccVFby+LF7b0pZVUguSPSP3CWSOXFvN5t
 gvkAxXihV2bUJI8eKjxGo6JS5FcC6qjMmeoPhC8oN25GAlmglGMOhpKZi
 +rDXHkHQ6/2y+K/hetwgTVZl+rYD6Us7AAexLNtAA/Qc2nAY7aSx2wwiv
 pTJXh64TFsnS7Ll4Z4yMYF63ZvR74q63lUQGarspNVp/3Z1vy0hEcA32e
 sN2AyQIDiVLI/Y6yEzGDkg+vvryZe+YcnvYtVEoAyzD0/hcGxtIshiYpE Q==;
X-CSE-ConnectionGUID: bmEyqYIgRPmkc3Ws9sAr8Q==
X-CSE-MsgGUID: HcdhhSdqSpWqYn5kAR9GMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88894021"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88894021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 18:50:04 -0700
X-CSE-ConnectionGUID: HTTHZw57Ss+IXX6mnOSh9A==
X-CSE-MsgGUID: 843YS63vQrS+MxPp1Gin+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="269586042"
Received: from unknown (HELO [10.238.4.78]) ([10.238.4.78])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 18:50:03 -0700
Message-ID: <ac4f8622-333c-4017-adbd-3fda756fd2f4@linux.intel.com>
Date: Thu, 3 Sep 2026 09:50:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] perf: Fix null pointer access in
 is_include_guest_event()
To: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Alexander Kanevskiy <alexander.kanevskiy@intel.com>
References: <20260902154852.742844-1-vinay.belgaumkar@intel.com>
 <20260902154852.742844-2-vinay.belgaumkar@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260902154852.742844-2-vinay.belgaumkar@intel.com>
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


On 9/2/2026 11:48 PM, Vinay Belgaumkar wrote:
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
> cause of this crash. Adding a check inside is_include_guest_event() ensures
> we don't accidentally access a null pmu ptr. In addition to this, we will
> now call mediated_pmu_unaccount_event() before clearing the pmu ptr so that
> nr_include_guest_events counts are maintained correctly.
>
> v5: Improve commit message and split patch into 2 (Dapeng)

Please remove this history info when you send to the patches to upstream
community.

Others look good to me.


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
