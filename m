Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90764C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5066410F1F0;
	Thu, 27 Aug 2026 23:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MHkR0oww";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DBB10F1EF;
 Thu, 27 Aug 2026 23:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FCD8601F5;
 Thu, 27 Aug 2026 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394F61F00A3A;
 Thu, 27 Aug 2026 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787873933;
 bh=/TLEbzpPEgzcZId4pU4zc+ORTkBR6svrLOzaxnqm8d0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MHkR0owwdq4Qwgq+lH7hGRqZI+w2lzfSNyiyuTrShZC1/i7Ivf+vCnyuP9WWmGVkt
 pQTvnm2OiwQOcynLLsUpEz7duJ4tmGufiY6LRmWTiHqg9ORb5HWN+O3ASKuuiZ+2vB
 DvAWXZ4lEb0aHj8ZTZAWXSUMIadFQOiWtDkGTT9l9oSvSQrrbM7dBBqQZi5cPKxgsE
 74EuO3b0hpiSM2qnHE5NVoewTAF1vsfc9U06aRiwgFh9PxC3BnMW9F/y79ktKq1Jmt
 PzlCEUyhCwernajiVB8+xznIDxmIs4O6oybHdWs/ak90f2GRfg4fYSCBwiFeUw/uH1
 A8V7mp4lNAlbA==
Date: Fri, 28 Aug 2026 01:38:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 5/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
Message-ID: <apDJpcatw9isIKdL@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-6-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-6-krzysztof.karas@intel.com>
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

> @@ -400,11 +400,10 @@ static int intel_mmio_bases_check(void *arg)
>  			u32 base = info->mmio_bases[j].base;
>  
>  			if (ver >= prev) {
> -				pr_err("%s(%s, class:%d, instance:%d): mmio base for graphics ver %u is before the one for ver %u\n",
> -				       __func__,
> -				       intel_engine_class_repr(info->class),
> -				       info->class, info->instance,
> -				       prev, ver);
> +				drm_err(NULL,
> +					"%s(%s, class:%d, instance:%d): mmio base for graphics ver %u is before the one for ver %u\n",
> +					__func__, intel_engine_class_repr(info->class),
> +					info->class, info->instance, prev, ver);

yah! drm_err(NULL, ...) is quite pointless. If there is no way
for retrieving the drm device, then let's just stick to pr_*,
this is their role.

Thanks,
Andi

>  				return -EINVAL;
>  			}
