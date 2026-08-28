Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F23C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B64810F400;
	Fri, 28 Aug 2026 15:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VYc3Vpln";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE24A10F400;
 Fri, 28 Aug 2026 15:58:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42D6543711;
 Fri, 28 Aug 2026 15:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F481F000E9;
 Fri, 28 Aug 2026 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787932736;
 bh=5V6Yhxljm33b9yQJUxlxNak1ZmFVOeRY8D2K/LuntJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VYc3VplnV+Bp2zpvvjkrDbztaZx55wzb4XHQFiXPRNGi0qPjYJf6Q3dspVzNmFQdu
 ot5X3T5V8IaJbTedEUlC32D0pvu0iNbfF3JdDcENpLYXymVjsxOLeEXs7SoqTp+vvg
 Y7EEKpfjio1sFWD8/T1+4eB5yKlb0WCuT7U6yIloMnEIM6flnn/OTIAyrQalgbUxTE
 znO47R793igVkUCA6grj03sKuUhOk4UZsRytFTr74jCt62AyMFTGPxpR2ZMGhBTEKC
 qS7O/C9hQZ+jBEfHinWIaEALhFRA6Bpae742CpuptRiC30Ov8oHT+pdvHMvggaWSBN
 VzzVWMlPgRazQ==
Date: Fri, 28 Aug 2026 17:58:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 3/8] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Message-ID: <apGvvt1ALs0MkssY@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-4-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-4-krzysztof.karas@intel.com>
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

Hi krzysztof,

>  	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
>  				  struct drm_i915_private, drm);
>  	if (IS_ERR(i915)) {
> -		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
> +		dev_err(&pdev->dev,
> +			"Failed to allocate mock GEM device: err=%ld\n",
> +			PTR_ERR(i915));

good choice here to use dev_err(...);

Reviewed-by: Andi Shyti <andi.shyti@linux.inte.com>

Also here you forgot to add my r-b. People normally spend time to
do reviews and it's not nice to ignore them.

Andi

>  		devres_release_group(&pdev->dev, NULL);
>  		put_device(&pdev->dev);
>  
> -- 
> 2.34.1
> 
