Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D4C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9128710E117;
	Fri,  3 Jul 2026 16:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="fj/yRT1z";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D782810E117
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:22:38 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-51c16ac21acso3748221cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783095757; x=1783700557; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WtYDAcSKBPogYImT0V6Zc6UNBhRbPfbijSs6cr/aWvg=;
 b=fj/yRT1zpqCz5toR708JNeTjVZyE9R2LoFFJ3LmAYF16M4ntgd7NXV8UiW6KwBqYJt
 pidiqaTMMigyjlEZvz0WcQIJQwV2mRCvzs8vdNa+gkTpmB4qDYAGs/f6IACZS+NAyqK2
 dUVBQAe4646MGoOxMjNVS8bWjOosLCG5zyXuz4BgjDBS7OqxjxPnCq37nUq+dfxxro/+
 /9yGTjeRTIpcdrn6IJwTb0gLfceCl6T/7Hhwo/QCvfeSCMgFHfkw2JY3ut57zibMJYaq
 d0dpYdyma8oHqyDDGlODLNOwFN0XTkrtDzkQgI7J2eoyL1t1l/9bn2rdGHFFQ+2RoHeL
 syUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783095757; x=1783700557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WtYDAcSKBPogYImT0V6Zc6UNBhRbPfbijSs6cr/aWvg=;
 b=Xr/YV8gbzI5zrjPOdGUpl9BM4f2uTIx5CZ1VojJQ1CG8JQh4PV+xEox+4vgKD3aERT
 0QkCAWglnW7RMMcDL/MWSIumiZJsD8T5BeQTgTdymyhGFAGndENzLsXRGMnr1e9STsiI
 mrOO9JlLVXcIcZUHNFpyug7ENx6rV2uiQb58Bq1ldWr48BaPBkrvU1iZ5MgXfNXVGnwe
 VwkgqZ0KnXTFvqRh6E8xqb7FhlRnJ2JLDE6ix2XxDWsk8b/LG4czPSjxr4VewsGeyuc+
 en1sv6Rt668laCP9d+SSIaMyLhD2DAT23Ez8tk13Zm2SV+hX6Zsh/I8zDjFfoPJWkprM
 B6dA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++Zf1GgxcwwoyogFwDGbJsoegFVJos5eV0wWpMwM4zoz5S0Bbz1R5koOoOQhVUV2/EXB+K4P3RZu8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEFDomotGUnyyczLwWwJFvdwUYHC7qzkI/s7Fik2bPoStQooE7
 HVERIwsst+avagOZnu+2pip3YAuoZXAmDfp2hAxYJwu494R8SMBeOJ40mlcd56yW/8o=
X-Gm-Gg: AfdE7cl0pBGzotUB32m1lqj8uhCmRX/wQv8/+LfJpWkVpVoAh1P3Ga5YVGYmevB3/A0
 fnivy9PKzQ2cw+8t2Z+uakY8oH1FW8Ot5Cbluzpx6XyO6o6qyQkzy2GegScH0J5RGaA+RES0/C1
 RJ+GzREuBJjyTBqSLy5ZtvHf8e4dkQMYrauaConfRbFOxuRW3k3rq24CI/IC6n07XTiMpR53jSy
 UChnKf0e8+BuwITGBIrn3hj+Pwg7CP6rFhPyii5bi2R5TYwM+/fC8S51dwDzNlgGZ9sig7AIkHj
 tcOYcgWN2t/FpVsmVwYH9RbA/pmZ4nViO6pLApKSYXsTURpBSq1YyGV6wOmkOaXYL/Pba8SrlVd
 pBT8ymOZ6220ZpfaLl8ztq5rHZB4Ax8wrQ5wA/9klWHGN+w+9GeCVnrs8/A0ghTqyz4deg+rNGt
 Ms/AksAycJR0XRJiFlSF0OhUDruscpZ2uxGgj++y0dB6jPy1CrP6ZDbXeA2Kwx4T7srPEI5S6gw
 JXWaA==
X-Received: by 2002:a05:622a:15:b0:51c:17cd:1fe8 with SMTP id
 d75a77b69052e-51c4c2c1c37mr3358691cf.33.1783095757387; 
 Fri, 03 Jul 2026 09:22:37 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm20593451cf.17.2026.07.03.09.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 09:22:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wfgey-00000008C3v-04o6;
 Fri, 03 Jul 2026 13:22:36 -0300
Date: Fri, 3 Jul 2026 13:22:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260703162236.GX7525@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-4-krzysztof.karas@intel.com>
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

On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses a single
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>  1) silently wrapping the value
>  2) smaller than desired mappings produced by iommu_map_sg
>  3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for previous
> scatterlist length field.

Urk, this is unfortunate, it means we cannot map certain kinds of
scatterlists? Meaning there is a condition that makes a scatterlist
ill formed?

This seems like something that needs to be more clearly documented and
we need to ensure at least the common scatterlist builders don't hit
it..

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..c403057577df 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1493,8 +1493,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> -			iova_len += pad_len;
> +			if (overflows_type(prev->length + pad_len, prev->length)) {
> +				/*
> +				 * For large mappings spanning multiple GBs we
> +				 * may not be able to fit all needed padding into
> +				 * sg->length.
> +				 */
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			} else {
> +				prev->length += pad_len;
> +				iova_len += pad_len;
> +			}

It is better to use
  check_add_overflow(prev->length, pad_len, &prev->length)

instead of overflows_type()..

Jason
