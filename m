Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCECC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6379E10E04F;
	Fri, 28 Aug 2026 16:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G6460aN2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CAD10E04F;
 Fri, 28 Aug 2026 16:23:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D98B860052;
 Fri, 28 Aug 2026 16:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09A1F000E9;
 Fri, 28 Aug 2026 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787934219;
 bh=blZUOYqg4FebhcA1YNSqubk1MWJ/06+wHJi854XNvP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G6460aN2TDxPKiSUc7305G+lyOCpCOEURBf0Nk9TEqkWr4zdtHFiwmzHryzLuCLLm
 4r/SG5pyhVYuKMDStqrrcPnkRnMmjRIK6iJZpSPuYKpU9/Whwif0LAd9d3xzkh+6Dx
 PxLklKyvpOJ4jg1jR8PQ6GCD2GquK+qsev07WeE8Bqf+Rh/IsVAHuPfG8+7Qag9jXn
 /myFFUpWcTZBvBQ4S0iIYxUmPHBuGyrX9f4X7TUyOkkGmsyjlGgwJK6aVs7a2OHf2i
 CS5aqSp8hCMjX/NHdW1tDcNZ8BoinvX03+ZEv48KgsuS+qHowQr2d1+F9dCjL+CM6N
 nTNtZ9H5G4pZQ==
Date: Fri, 28 Aug 2026 18:23:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 5/8] drm/i915/gt/selftests: Use drm_* prints in gt
 standalone tests
Message-ID: <apG1E47gWGa9neSx@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-6-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-6-krzysztof.karas@intel.com>
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

...

> @@ -80,8 +83,9 @@ int live_rc6_manual(void *arg)
>  	res[1] = rc6_residency(rc6);
>  	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
>  	if ((res[1] - res[0]) >> 10) {
> -		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
> -		       (res[1] - res[0]) >> 10);
> +		drm_err(&i915->drm,
> +			"RC6 residency increased by %lldus while disabled for 1000ms!\n",
> +			(res[1] - res[0]) >> 10);

yeah... I think here we should be using gt_err()

>  		err = -EINVAL;
>  		goto out_unlock;
>  	}
> @@ -92,10 +96,12 @@ int live_rc6_manual(void *arg)
>  
>  		if (!rc0_power) {
>  			if (rc0_freq)
> -				pr_err("No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
> -				       rc0_freq);
> +				drm_dbg(&i915->drm,
> +					"No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
> +					rc0_freq);

this is moving from _err level to _dbg level.

Andi

>  			else
> -				pr_err("No power and freq measured while in RC0\n");
> +				drm_err(&i915->drm,
> +					"No power and freq measured while in RC0\n");
>  			err = -EINVAL;
>  			goto out_unlock;
>  		}
