Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EC8C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684D410E2BB;
	Fri, 28 Aug 2026 16:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iqf++G6+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E98510E053;
 Fri, 28 Aug 2026 16:18:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBDB042CBF;
 Fri, 28 Aug 2026 16:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD951F000E9;
 Fri, 28 Aug 2026 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787933919;
 bh=BirV+6RY9hMI9hxhDc0eVXi2sWCmx7NDCojQTLO4lUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Iqf++G6+Upm9Wfb1exWIDg17JiVQUAd6HVNcx3D3JLUc+Jb1NvAG6NxOW7MPs9svT
 zFexjtqFsvtAPKFhah9bjGXJrkRG37GpBFAXgmuyT4cgONhyMhCR7nFK+aQgNNDCIR
 BmMLF++CNv0FTVrFq2WXw4cPl4lYhnYKx6k20kgg7jivn9LkTUg2S7C/wpSsrJzf2U
 ibynO9AXux6fhrCVEFuBJr7pZ/ZWQ1wTDPpw9bnSX50oELUItFUfcDq7CG3mEWkH/z
 1mwGkQT1q5xW2zSMNjYbU+O2HygBVSwGJkFW6tJT8wOAHhvYydd6ZeYWtN5e/e3UUq
 oBplr9WuWPsjg==
Date: Fri, 28 Aug 2026 18:18:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 4/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
Message-ID: <apGwueLe3rE7gPLj@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-5-krzysztof.karas@intel.com>
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

On Fri, Aug 28, 2026 at 10:03:35AM +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Assisted-by: GitHub-Copilot:claude-opus-5

what a ride!

While reviewing everything I was thinking whether it would make
sense to add an i915_err() like xe and gt.

...

> @@ -540,7 +551,7 @@ static void spinner_kill(struct timer_list *timer)
>  	struct spinner_timer *st = timer_container_of(st, timer, timer);
>  
>  	igt_spinner_end(&st->spin);
> -	pr_info("%s\n", __func__);
> +	drm_info(st->spin.hws->base.dev, "killing spinner\n");

considering that you kept the __func__ reference everywhere else,
you could have also kept it here. I like that you have added a
message, though.

As you are going to resend, anyway, please fix this little nit.

>  }

...

>  	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
> -	pr_info("%s: %zd KiB copy: %lld MiB/s\n",
> -		ce->engine->name, sz >> 10,
> -		div64_u64(mul_u32_u32(4 * sz,
> -				      1000 * 1000 * 1000),
> -			  t[1] + 2 * t[2] + t[3]) >> 20);
> +	drm_info(&ce->engine->i915->drm, "%s: %zd KiB copy: %lld MiB/s\n",

Not a binding comment: rq->i915 would have made it a bit shorter.

> +		 ce->engine->name, sz >> 10,
> +		 div64_u64(mul_u32_u32(4 * sz, 1000 * 1000 * 1000),
> +			   t[1] + 2 * t[2] + t[3]) >> 20);
>  	return 0;
>  }

...

> @@ -1211,7 +1231,7 @@ live_gpu_reset_workarounds(void *arg)
>  	if (!lists)
>  		return -ENOMEM;
>  
> -	pr_info("Verifying after GPU reset...\n");
> +	drm_info(&gt->i915->drm, "Verifying after GPU reset...\n");

I'm thinking whether it's better to use gt_info() when we have
the gt reference.

Andi

>  
>  	igt_global_reset_lock(gt);
>  	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
