Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3554DC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8D210E720;
	Mon, 31 Aug 2026 08:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YxqFYfcb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D22610E707;
 Mon, 31 Aug 2026 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788165330; x=1819701330;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=KONziSVWIVwvs3RiyygREUQiZGGQWT8Eas/ziempUzo=;
 b=YxqFYfcbm2QzQWyokMs7v3KelLbj34rAwnfURQENkVq75FbL7oHVDom+
 0+ya03LRhS4j9OvuEcZI+UQgvvHOVlRHccpRiXx4EvQ/z0uW3Lu2xT2HM
 rAWiESbThzldg3lCk04vcOnNr5Xp6F0YeF5N/v6iyQxzFn8oz2Jbc1r9x
 B+6G3qJeq6Fu+RRbksxRn9S1uIaLN7vwEbE/xH4m830z2tRJzm/IFxxHS
 aoZ3GSUnkvx1dArRm7MfE4ta+MMak/f16E2f0+lbRrqBrzuYjQ9Cmn6j0
 +xBKWU9Ni2apyBrUQOmXUJx86t0bK0mil2nflzZMLTCsaInko2Wm8QVDW g==;
X-CSE-ConnectionGUID: U2eXNCQER1eL+y4r9VVv9Q==
X-CSE-MsgGUID: l5c1Byl7Rh+DjppRXLXzzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92376715"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="92376715"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:35:30 -0700
X-CSE-ConnectionGUID: SrTUOPGLTjiuOymxSMLcQQ==
X-CSE-MsgGUID: /sQ6RjObQmmlN9I0LIbpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="274007191"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 01:35:28 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Krzysztof Karas
 <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 2/8] drm/i915/selftests: Use drm_* prints in live
 selftests
In-Reply-To: <apGaXnTIuHa5mbti@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-3-krzysztof.karas@intel.com>
 <apGaXnTIuHa5mbti@zenone.zhora.eu>
Date: Mon, 31 Aug 2026 11:35:25 +0300
Message-ID: <c037c57d1176cdf182208dc8228b8afd3d8f8838@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 28 Aug 2026, Andi Shyti <andi.shyti@kernel.org> wrote:
> Hi Krzysztof,
>
> ...
>
>>  static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>>  				unsigned int num_ranges,
>> -				bool is_watertight)
>> +				bool is_watertight,
>> +				const struct drm_device *drm)

First, we generally don't pass around struct drm_device *, it's struct
drm_i915_private * in i915.

Second, the highest level context parameters should be first. This one
looks like an afterthought.

>>  {
>>  	unsigned int i;
>>  	s32 prev;
>> @@ -36,22 +39,22 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>>  	for (i = 0, prev = -1; i < num_ranges; i++, ranges++) {
>>  		/* Check that the table is watertight */
>>  		if (is_watertight && (prev + 1) != (s32)ranges->start) {
>> -			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
>> -			       __func__, i, ranges->start, ranges->end, prev);
>> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
>> +				__func__, i, ranges->start, ranges->end, prev);
>>  			return -EINVAL;
>>  		}
>>  
>>  		/* Check that the table never goes backwards */
>>  		if (prev >= (s32)ranges->start) {
>> -			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
>> -			       __func__, i, ranges->start, ranges->end, prev);
>> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
>> +				__func__, i, ranges->start, ranges->end, prev);
>>  			return -EINVAL;
>>  		}
>>  
>>  		/* Check that the entry is valid */
>>  		if (ranges->start >= ranges->end) {
>> -			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
>> -			       __func__, i, ranges->start, ranges->end);
>> +			drm_err(drm, "%s: entry[%d]:(%x, %x) has negative length\n",
>> +				__func__, i, ranges->start, ranges->end);
>>  			return -EINVAL;
>>  		}
>>  
>> @@ -126,7 +129,8 @@ int intel_uncore_mock_selftests(void)
>>  	for (i = 0; i < ARRAY_SIZE(fw); i++) {
>>  		err = intel_fw_table_check(fw[i].ranges,
>>  					   fw[i].num_ranges,
>> -					   fw[i].is_watertight);
>> +					   fw[i].is_watertight,
>> +					   NULL);
>
> arrghh! Here we are again at the drm_err(NULL,...) case.
>
> You could eventually do in intel_fw_table_check()
>
> 	if (drm)
> 		drm_err(drm, ...);
> 	else
> 		pr_err(...);

drm_err() handles NULL drm_device just fine.

>
> but I think it's not worth the effort, just leave pr_err().
> Besides, passing the drm device is quite out of the scope of the
> function itself, it's just odd!

But agreed.

BR,
Jani.

>
> Andi
>
>>  		if (err)
>>  			return err;
>>  	}

-- 
Jani Nikula, Intel
