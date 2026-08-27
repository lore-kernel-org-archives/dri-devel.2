Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E84C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5410F1E3;
	Thu, 27 Aug 2026 23:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxqZfucN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E8510F1E2;
 Thu, 27 Aug 2026 23:32:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D3F341994;
 Thu, 27 Aug 2026 23:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43921F000E9;
 Thu, 27 Aug 2026 23:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787873574;
 bh=TmDQSTyylL1j7QvTN1tIKVv/L/dS7PAkxlE9f8RmKZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mxqZfucNnWCT1So0uPOIFKdo0Y79FdOPxX/2jr/irIn7bEBLsGWi3HTsHUNvVI6Iz
 Ke5V274RtQyLInAst08BAAEQ8nntUgYJavyiIn6cQe9SWbyAKMkPzOThzoA4x19yJg
 G/J/jWFIWQmm87haAlAq+GdDPebq3ZSONibrPXTiCtLu8iApYawlucetrig8+P6Mkh
 kY9WzRU2oZNCwmu0YvvulywFmjjy4TB6yhviMtw70DDxBw4vzZYosWr5/s3i2bwYWZ
 kHaR/7+aEyb/PqUASLsWIDapzBGlwhsFxnH94iglwiPnzeGaNzI/xZxNGpN1vkwDGQ
 Z5tkrwUrci/mQ==
Date: Fri, 28 Aug 2026 01:32:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/8] drm/i915/selftests: Use drm_* prints in live
 selftests
Message-ID: <apDIqBvvWCSJugXb@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-4-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-4-krzysztof.karas@intel.com>
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

> @@ -71,11 +73,11 @@ static int populate_ggtt(struct i915_ggtt *ggtt, struct list_head *objects)
>  		quirk_add(obj, objects);
>  		count++;
>  	} while (1);
> -	pr_debug("Filled GGTT with %lu pages [%llu total]\n",
> -		 count, ggtt->vm.total / PAGE_SIZE);
> +	drm_dbg(&ggtt->vm.i915->drm, "Filled GGTT with %lu pages [%llu total]\n",
> +		count, ggtt->vm.total / PAGE_SIZE);
>  
>  	if (list_empty(&ggtt->vm.bound_list)) {
> -		pr_err("No objects on the GGTT inactive list!\n");
> +		drm_err(&ggtt->vm.i915->drm, "No objects on the GGTT inactive list!\n");

Instead of using these long ->...->...->... just save drm locally
and you even save characters to comply with Janusz review. Same
goes for the rest.

Thanks,
Andi
