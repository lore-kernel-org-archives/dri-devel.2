Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CD8C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6355B10F424;
	Fri, 28 Aug 2026 16:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OZC3EwTP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A6E10E4C2;
 Fri, 28 Aug 2026 16:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EACE2415F4;
 Fri, 28 Aug 2026 16:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C21C1F000E9;
 Fri, 28 Aug 2026 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787934972;
 bh=jB/zs8T6j89DVrKcLb/XOC0QlPksM+BmL6qPgL2oGXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OZC3EwTPZvMHskRNO8MM1yPHrJg/xGo9J9uzt3VG8ai9YmN7GXvM+ysAxkNSTbzXF
 XJHBfMAm2aWOn/6tQ3pVGQDzfN1+A7bKNhYhdHWxN9ciDRfLLS8+vDKgVRidTM0zRy
 ptj0ait2jBXvV4guBuOxlKhj+82VC53mjeaDEdV+xLuZkuWObXmASlkGvkeGuK0+LV
 8sUKs65EyIfs3vIq5jfFqMAi6fGKryUFhf1dSqRsOrphoYP0t6nFx0bGyiFCcaPKt8
 IeYdogQggwJ7Q91X7A5YG9FrLmF5TBc8n9xX3EcGnDY+K9PX95zyNYI5nZjDR6kMkc
 yvBQMEoRF4wnA==
Date: Fri, 28 Aug 2026 18:36:09 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 8/8] drm/i915/selftests: Add drm_device to selftest
 wrappers
Message-ID: <apG3p9fNjXBverf-@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-9-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-9-krzysztof.karas@intel.com>
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

Hi Krzysztof,

...

> @@ -88,24 +89,25 @@ int __i915_subtests(const char *caller,
>  		    int (*teardown)(int err, void *data),
>  		    const struct i915_subtest *st,
>  		    unsigned int count,
> -		    void *data);
> -#define i915_subtests(T, data) \
> +		    void *data,
> +		    struct drm_device *device);
> +#define i915_subtests(T, data, device) \
>  	__i915_subtests(__func__, \
>  			__i915_nop_setup, __i915_nop_teardown, \
> -			T, ARRAY_SIZE(T), data)
> -#define i915_live_subtests(T, data) ({ \
> +			T, ARRAY_SIZE(T), data, device)
> +#define i915_live_subtests(T, data, device) ({ \
>  	typecheck(struct drm_i915_private *, data); \
>  	(data)->gt[0]->uc.guc.submission_state.sched_disable_delay_ms = 0; \
>  	__i915_subtests(__func__, \
>  			__i915_live_setup, __i915_live_teardown, \
> -			T, ARRAY_SIZE(T), data); \
> +			T, ARRAY_SIZE(T), data, device); \
>  })
> -#define intel_gt_live_subtests(T, data) ({ \
> +#define intel_gt_live_subtests(T, data, device) ({ \

As I stated in my previous review, here perhaps it's better to
use gt_*() and we can drop this change. What do you think?

Andi

>  	typecheck(struct intel_gt *, data); \
>  	(data)->uc.guc.submission_state.sched_disable_delay_ms = 0; \
>  	__i915_subtests(__func__, \
>  			__intel_gt_live_setup, __intel_gt_live_teardown, \
> -			T, ARRAY_SIZE(T), data); \
> +			T, ARRAY_SIZE(T), data, device); \
>  })
