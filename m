Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17AAC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2E1886A4;
	Mon,  6 Jul 2026 12:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="oEkKybDz";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7A810E16D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:31:28 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92e5cb052edso217849985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783341088; x=1783945888; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GCAkWMdkF5ipjGr4p830BCh9C6481Wk1fl4Ld4QNg9g=;
 b=oEkKybDzQrQLUdJkh3m+bEIyZm3NpHoJnH7KtbTcefVzcuVOPWptPDCWcNTBIq97kw
 y3q5gr+rOF4JXKg9fjsEujHxq1HxunONto8DcYIw2FvDYh2LCRBGAl/1AeZ2S/UOxexZ
 ufXT42JHKZnhLVBsZCyvpkm8+nrM9JaoKSfi2vcgI4Zl89WNzXmaCgLYIdzgfZLOdrsg
 dMhogEfIjhUbRkHR8j3WhD/qHc/2Gy+hv9ELbnCH/qnbB837z+A2AOOLJFd6FVfiv9Cb
 j/O177Br8R1lJEU9qFEqDpQ+8xXmdNYfEC/hv090cyQgcH05lj1oAVMFBA8q0JpK/COE
 yU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341088; x=1783945888;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GCAkWMdkF5ipjGr4p830BCh9C6481Wk1fl4Ld4QNg9g=;
 b=lHayDShgcg7TqMrmKcUQ7PxPrUMwZuxPSzMe7xqFHHUDBKl3wZYtTtZaA1B4dwnv6B
 V4aQtQUoIslyPDm1WnI985pFEPVW7/HKYazC7XIsX13fOWHa8Hty/sZu6QoOWThkHXeW
 To6ia/6rW+rEioEg+H2HfSQzbbAUpeKfk2fypo77EXpbqoQZwRgCx7kbLlGylJhirTwR
 YxlBanYyhEbGS/a7r9RnKmcCKz9Se5o04izpSKq3n4NRziPjUNx1NIxeh82/W9wC4TsR
 1FT/YTxDyCxQpqflFDUxtMvbolMtBu3mnyfJ1KQKVK+AgEp2U23vxaILSMie9nMBos30
 5cwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+9LhUwlwOFfjXl46SioxsoEttSCmSiAY0NnbI7omjCYKIJwETy/ft05Y+BbqwTP3RZ17i+PeSeEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPCcLovlHsvIv7Kmnrcq/jQ3nZPgXoWzYIYriQRlMEHA7ck9a5
 Kl6TNZ3N4zFyHIDpJrRW1XHX6Ygg4ib6U5wcuSNlj6VXCAqdA75taDlVNGjG04schC8=
X-Gm-Gg: AfdE7cnaqAu8nvIl0ae2QkEvXlpOJ90sx319tJAQflNRKyAEkVh+qdZt5ivltzdVUuK
 Kcsdq0wgeDsncmDw+FwPpkhHD0QMsQWWWoFpn1ndKxyNHI+xRHdzzrg5BjrlXuzOmZ5fxryTnp9
 8cmA6Q7rJEn0meTPVqHZUdcIeWADEaVzoyY6DOgNuH1zIIKuKr4olvKMoHF3B/12D9JSVTMX9pd
 oC5sjncgBqebSdXo/U7yvboT+SU6BDh8HgipJjc+rAA6Pc3fLbDX74qXSE7+VcRpZ4WV0lDlCA4
 6atV9m8nUlVh/zF5hfD7Y5InOw/eIgVfovYYnFm9mPi93T2RJPxZgIQu8ZmNNC8ROxd5Irx7OJi
 DhvzU2LnyMBhOQBFOr39ZYrJlkb1hYKbfMM+d9uQuZ6BCDtjWud+YDTa1G7hS
X-Received: by 2002:a05:620a:618e:b0:916:10f6:780f with SMTP id
 af79cd13be357-92ebb5665f8mr45100485a.27.1783341087397; 
 Mon, 06 Jul 2026 05:31:27 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cbe3e2sm918463385a.35.2026.07.06.05.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:31:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wgiTt-00000000Sbw-383D;
 Mon, 06 Jul 2026 09:31:25 -0300
Date: Mon, 6 Jul 2026 09:31:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 Andi Shyti <andi.shyti@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
Message-ID: <20260706123125.GA107792@ziepe.ca>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
 <20260703203502.GC1978949@ziepe.ca>
 <utb5awup2vypdhtcxk3vlczwrqbl3ypae6ftbwrlrkdqfnk4ft@aurl5kme27ac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <utb5awup2vypdhtcxk3vlczwrqbl3ypae6ftbwrlrkdqfnk4ft@aurl5kme27ac>
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

On Mon, Jul 06, 2026 at 07:43:14AM +0000, Krzysztof Karas wrote:

> > I agree we shouldn't overcomplicate iommu_dma_map_sg(), so the
> > simplest fix is to introduce a SG_MAX_LENGTH set to UINT_MAX/2,
> > justified by the logic in iommu_dma_map_sg(). Fixup the core sg_alloc
> > code to respect that. WARN_ON in iommu_dma_map_sg() if a malformed
> > scatterlist entry is presented. Add a WARN_ON under DMA debugging
> > kconfig as well for the physical path.
>
> So instead of addressing this in iommu, we should focus on
> guarding in sg logic to prevent the overflows? 

You should focus on creating valid scatterlists..

> Or would you rather have this as additional, separate fix placed in
> this series?

I think this patch should be changed to check the length and
WARN_ON. It is a kernel bug to pass a malformed scatterlist.

You'll need other patches before this to not create illegal SGs in
whatever mapping path you are using.

Jason
