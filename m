Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57805C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C148910EE50;
	Thu, 10 Sep 2026 22:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TUiq862I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E7E10EE50;
 Thu, 10 Sep 2026 22:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B84442B67;
 Thu, 10 Sep 2026 22:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BB41F000FF;
 Thu, 10 Sep 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789079248;
 bh=EJZ6yLX5sNuZIqDn9O98VTW8BCQq3c8v5/T+ZMMdv9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TUiq862IMpD5600ZATeWVp+S3zDjHrMp/bG3g5cuG6RXDgymU/6ZNiXWmymSpHoTM
 4cN/GwFg2g4+tad91NkNi0jxK4XLlYdeTxwT6yWs87JAjsISSDQbR8Qfob1FYuT5Q5
 gJDeEzH2UP/1SfZ6XofEUVw604A/fECLjgwahxpz5FkTPk2TsLml2N6qU3OLejHVpc
 k5ZqRmwnhmKoOz+KTMj3pQD/ikSlPGa0ifapEIdmCeEn7yixAJYIv6dPo+ajMqNoEs
 a+Kah6/ec3eCXHfJfSnHA44HlqD/HzcJ3NTmpZz9kaM7CXxqDYlOZMWII84yjcFi6g
 iB4gpD20NHRSg==
Date: Fri, 11 Sep 2026 00:27:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 5/7] drm/i915/gem: Pull out size validation into a
 separate function
Message-ID: <aqMuklEmVVvg6yk_@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-6-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-6-krzysztof.karas@intel.com>
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

> -	if (overflows_type(size / PAGE_SIZE, page_count))
> -		return -E2BIG;
> -
> -	page_count = size / PAGE_SIZE;
> -	/*
> -	 * If there's no chance of allocating enough pages for the whole
> -	 * object, bail early.
> -	 */
> -	if (size > resource_size(&mr->region))
> -		return -ENOMEM;
> +	ret = validate_set_page_count(size, &page_count, mr);
> +	if (ret < 0)

this can be "if (ret)". Otherwise:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

> +		return ret;
