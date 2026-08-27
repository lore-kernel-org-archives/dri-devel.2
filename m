Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ED0C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6FB10F1F6;
	Thu, 27 Aug 2026 23:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lwsU5v8y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF35D10F1F4;
 Thu, 27 Aug 2026 23:44:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7870A424B5;
 Thu, 27 Aug 2026 23:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B605D1F000E9;
 Thu, 27 Aug 2026 23:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787874265;
 bh=GK+I+uB8a3r0gHn2Xh5Vw5VczDgj6/e+0zafz1lDjwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lwsU5v8y5+Vg4AEUp/7Ye32zrfn9YizvPF5ZfSL57IQaEWu9gN6Pb18i9ihwwy+Mu
 57QWTtpi0By1jpQXIEFdlJnd6+E4FiHB6/+/pR5DCQtD3CrzW0oCQA/dkMPborFTgl
 EyfykI5ajGYLeTrOzECEQwZQIH291mrATzeXC0UGKQWSzn45v/zfX7bSqQIk7DHLlq
 eLPsg2XIf52Z8J1AIGY7qfR5h9V2EjPjS5mauCNSR6Pstd3kb1EHDukq3HWJ70EPY4
 lL2AupiBVXIjTvFbNTt8JSTfAWSXWfrMbybgeiuVjgqSZXsZ0Kfojo404ZzI3ZZXOn
 SyWQt5p8L3LHg==
Date: Fri, 28 Aug 2026 01:44:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 7/8] drm/i915/gt/selftests: Use drm_* prints in gt
 selftest helpers
Message-ID: <apDLMng-T7W2R04z@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-8-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-8-krzysztof.karas@intel.com>
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

> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> index b893a8fde895..6f5962eaca3b 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> @@ -202,8 +202,10 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  	engine->serial++;
>  	flush_delayed_work(&engine->heartbeat.work);
>  	if (!delayed_work_pending(&engine->heartbeat.work)) {
> -		pr_err("%s: heartbeat not running\n",
> -		       engine->name);
> +		struct drm_printer m = drm_err_printer(&engine->i915->drm, "heartbeat off");
> +
> +		drm_printf(&m, "%s: heartbeat not running\n", engine->name);
> +

I don't get this change, why don't you just use drm_err()?

Thanks,
Andi

>  		err = -EINVAL;
>  		goto err_pm;
