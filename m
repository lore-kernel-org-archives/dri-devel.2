Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35111C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B8610F41E;
	Fri, 28 Aug 2026 16:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KqGAITVt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEE210F41D;
 Fri, 28 Aug 2026 16:28:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED61E40431;
 Fri, 28 Aug 2026 16:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52C91F000E9;
 Fri, 28 Aug 2026 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787934530;
 bh=HsaeOPFwNN89ZD9VTILhla0V6UZExcfLY5FvBTtgOG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KqGAITVtMLhMykQkSwu9ddnZ+e+k6Cl9bpzWd8Yf0Uy35iM/N0vFLygx5t2nzSeLU
 URjPnuTcEJAosCriCYrjHuFl4vhoS3HOoPEAmNZpB+b7bidoEy4wxRPqsg19rfBlBS
 /ifT2+93mxKeuD8Wn2hVrC910Aup2LpQVZ5zisqqDpuUVweFIfnXcpM9FIQkUnod3K
 PhyKdxXCvHnz4uy2P2Hc5AcTxQH0BVaWhWrCywqRG8Cavwwg5HEWZSCxlPuH/uq9zM
 IN7Toioc44c5bZ7N7/fuhcBb2Hu/rI17wFVt4/0EnyxJ0jkZmzoFTUNAm+lw50s7Vi
 zqCr68xjEydPA==
Date: Fri, 28 Aug 2026 18:28:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 6/8] drm/i915/gt/selftests: Use drm_* prints in gt
 selftest helpers
Message-ID: <apG2famw80-J8oP0@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-7-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-7-krzysztof.karas@intel.com>
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

> @@ -23,6 +25,7 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
>  	     gpu_freq <= consts.max_gpu_freq;
>  	     gpu_freq++) {
>  		struct intel_rps *rps = &llc_to_gt(llc)->rps;
> +		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;
>  

As you are at it, you can remove this ugly blank line here.

Andi

>  		unsigned int ia_freq, ring_freq, found;
>  		u32 val;
