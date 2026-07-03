Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12899C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA4F10E672;
	Fri,  3 Jul 2026 20:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="cUKvVQjx";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5977310E672
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:35:05 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8f0d6853360so6347476d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783110904; x=1783715704; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KEqrn50FtdxGVsX9vWULW1SFinyIlJ9nzqYUDztwtgI=;
 b=cUKvVQjxmCv8O4oSe14yf6PsF0WATbn8u9c1Nzw/K6LPQzTVPe37RJFGDoR99wTdFe
 SLPwh+sVMcXsd6S2TsHh3u0lRq5A4FzJ9ZKd8sY+k/Lqu3tyefpSw8r25UIzRshARIkz
 JykzCC0Z4/xPUq5xcTyyycIlchLUQ0erTXQBgwzlpH1J16YSICRZGRYI97XfQjpYkLrs
 1q8eB9xAoT144IGKwZxXmjlFsv8rgUID16ErBuhCjCgdzbvJ9lJYXV811o/Sd8unNchE
 Rb+jZM+7eBS6OnrH6ooNCdzivMfPA0CPDOE+B3muVwPfqUG/Lxi7L2csstAkDp4MOEPo
 umfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110904; x=1783715704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEqrn50FtdxGVsX9vWULW1SFinyIlJ9nzqYUDztwtgI=;
 b=f5bBuDmrhWhSrJdcIKvTGsVIRKqzFw4Ic510RGCKe/aehQOaADH6wKakA7XHWuAHuj
 TjPvk2O0ap8RAGi9/u7UfaVXtcFfQSUEfFO+MtNDeMkkiOJXdJUO55QtMid0xXh6/+iH
 0HGESc2i8HHeE65ndpzEpUotidJqSqfUfpVFCK8ivtqm2x4CPR9NtRsR34wNDX7DQBf8
 PV1074a7FsAEHGRDsQ2Q0rVJpEK/nOj/TlfkYUHbyG0+crP4U2PFzvxKDEMB/q8AeR/1
 QTT5ZgZAMhR905lNgI8D8TRBEpA8fbIpYR6xJnyxhBBlrsvAKVoM0rIUuI3X2e3lCfKv
 2Giw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeBDD2SNq7vWaOhSG8IxhCxWoBKNlzIHMPOb0FG5lR7L5exEa15OZ07YZMw4SMZprxfUbcRz9EzQU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzThGQYEvK1IATwKZ7uQDw4EgJAiFFndCEWmJXwUcM1jUEIIBAr
 S2MYeZzdVdgmgJ9dhjIGEiSpryFGQt/9Y0m2gGva0NYDqjjdUTX70yH4SmvdgqZzhqY=
X-Gm-Gg: AfdE7cn2fFKcJVJekHa8BhmmRofaEmZuSdsLlwMIUq4b2Egs/VlBmcGp/7mM33v5yzJ
 6su9PE/t267+F6MPQbaTAtYIKTe8OwQ+KdbfftQZ1XM4HrwSomfRpGt8Iy9pGQWdb/Xxf7Bp10L
 VVof9gBt21qrYKw+3aG0c+MJROaBWLR/QfmBm6YMMxcWjMmqD7e9M2M8AzRvuaYbv+5rh+LEJd1
 wMs7GL1UMSw3SdqM+aJ0W5NYhfNvvTqagNIM3AIq/vksnsUabcrRn1jkOJ6aN6+Teqhe5ctn2Eh
 bC0IL50Iiq5u+mohxg5AClenly3MfokQELFtfMZLsf2uj7E2qRMKWi1FKQDt+HtLsSH3XwhUg5d
 3mSwrqnzeUOVCnF1fV+mTUj9IZPO4ng5o2tjHQsXujYyRzEa4gvtePVC0svA0kJeAv8Ukmt6UVu
 WDwfiyVVCiS986G7igxhHxvvVXeaFoJ46tLfZ1jNN+cx9EVFsWG9E6LXYURkCqihaTkE9smllzB
 XZIQA==
X-Received: by 2002:a05:6214:e69:b0:8ef:3407:3dd1 with SMTP id
 6a1803df08f44-8f74997c1f5mr12182176d6.6.1783110904066; 
 Fri, 03 Jul 2026 13:35:04 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46f304533sm62882746d6.18.2026.07.03.13.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:35:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wfkbG-00000008b0h-35vJ;
 Fri, 03 Jul 2026 17:35:02 -0300
Date: Fri, 3 Jul 2026 17:35:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260703203502.GC1978949@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
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

On Fri, Jul 03, 2026 at 07:58:32PM +0100, Robin Murphy wrote:
> On 03/07/2026 5:22 pm, Jason Gunthorpe wrote:
> > On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
> > > It is possible, when a very large mapping uses a single
> > > scatterlist, that padding overflows scatterlist's length field.
> > > This results in:
> > >   1) silently wrapping the value
> > >   2) smaller than desired mappings produced by iommu_map_sg
> > >   3) leaving mapped bytes in memory (no iommu_unmap)
> > > 
> > > Address this issue by adding overflow detection for previous
> > > scatterlist length field.
> > 
> > Urk, this is unfortunate, it means we cannot map certain kinds of
> > scatterlists? Meaning there is a condition that makes a scatterlist
> > ill formed?
> > 
> > This seems like something that needs to be more clearly documented and
> > we need to ensure at least the common scatterlist builders don't hit
> > it..
> 
> Well, it's taken 10 years to be caught by a test which seemingly expects the
> mapping of a single absurdly giant scatterlist to fail anyway,

If your server has 0.5TB of ram a 4G IO isn't actually that large.
Randomly getting a few contiguous 1G hugetlbfs pages is not even that
unlikely. Something like FSDAX has a very high chance of getting high
contiguity pages in files.

So I wouldn't be quite so dismissive that this is not something a real
user can hit.

> here, but I suspect this is likely just regular iova_granule rounding
> overflowing when the segment boundary is the maximum 4GB, since the largest
> representable segment length is 4GB - 1. 

It looks like the iommu_dma_map_sg() algorithm only works reliably if
the scatterlist entry size is less than UINT_MAX/2, otherwise it can
risk overflowing when it pads.

API wise I expect any arbitary input to sg_alloc_table_from_pages() to
result in a scatterlist that iommu_dma_map_sg() will map. This
patch highlights there are cornere cases where that isn't true, it
should be fixed..

I agree we shouldn't overcomplicate iommu_dma_map_sg(), so the
simplest fix is to introduce a SG_MAX_LENGTH set to UINT_MAX/2,
justified by the logic in iommu_dma_map_sg(). Fixup the core sg_alloc
code to respect that. WARN_ON in iommu_dma_map_sg() if a malformed
scatterlist entry is presented. Add a WARN_ON under DMA debugging
kconfig as well for the physical path.

DRM would then have to generate scatterlists with a max segment size.

Jason
