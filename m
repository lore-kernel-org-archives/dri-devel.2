Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC16C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBC310E510;
	Wed,  2 Sep 2026 12:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="bX2hKo6P";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6677510E510
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:08:35 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-5303932c4f3so2526941cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1788350914; x=1788955714; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
 b=bX2hKo6PZSffsdSVkrJyb4vLPS2FnqSw9LtCz1wkr/gH9UX9dHlspbPOvliVyeRQYt
 Dq/yjI8z6+5tC89XnFsFnuXzHeqT0cud/34kBGUYioUyDzAdHFARy5Iuofb3f5SdmGkc
 QH6eH5bGjuIMzX09aPRqA9I77RgPTGFAECbOODu50SZkPQhMxHj+yTidOF8zOgLX+VhZ
 naq9qUkkGyb4+BmA5HI62cCszwac+L6nFm2niBXxFiy2FE586ELFIapB24DfRyXU/vFr
 45bbxVG3ti6CLbF3GDUZ7w7A6ufKSzbOnKaMmOQRzAZt45NNnQrkXjWhMBRaMTX7dfSK
 CJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350914; x=1788955714;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=puJ4uTbfv83ic1yzfkUg8CloAoVj8WRg32Yh9dx02hk=;
 b=bXBGQfTB3EsiOzjs+f4ncN9fGQSTN9cA2Y7Zdw2oEFKX4gI8MuB9fLgaZYBjgmwkUN
 tZtWcBJ7g+xay7m2tnNf5Ot3TSxMPqKotoDfFZIQeTUvSJHQAYQiA8xUDtE9QrmvPXIV
 KXluoMYBsTRrzpnl56sd+QR+6r4v3KMG+GJdZfvI1blU+HjKRC4ov9+UB+6FsFdDCX7O
 DiTJ1hAcJDMQ/J64mn/5ehge5xkZ5gVTLAtUq08g/spvQlw/SxLSTPDp6D+hN70esKXG
 8mVMTrIocBa5c9KwclTB7QJ1JUtShG1gSiDJ6iB/CIyW+OVdC8lfaI3o+Hu2DL0BCoUp
 wYvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro50UlYWEE7p4Kdd9Gx+z8kMyUQf5xLswMpukZBwe09O2Ryc1kuDo3j8sowLuuAG+AkI2RuFYxNpSs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n7O1hq7kAzmyJwwXNsGbWOUupzA4xgpV2HmI2Wv8D+/eNmDT5m
 qw3kpQD9dmndq/SuYcQDf95+BM8rMF3ffQLiTYnVlmliwpeq5OS8GF1e1FKZ947nYcc=
X-Gm-Gg: AR+sD12heUwyboM1Y9xAFAK0JqDNMDXuJyjFo8qf3w21g1cpnbaJDZ752xt3Ovo9S0s
 8DosmqNoUf3KyszRBycz4b6ILiMcvZea/soBD0SpaecL5xCxZhFf0DOfJeSYq9V0+YyuajYHXWe
 /VkPp2AoavQ2aBhHi8F89KvGsTGXq+ybZ1Erqbaf9h8IoEfEQ2m8gLYnTfLrQ6oaL0UDqumQjCz
 U/mKKm82nr6Qp9AB3ZAWxe4Vn1iAf2uYLcXizpz9/TPG2AnR8zTn2/OqC/aNim6oABTFU2rVxh3
 dU7F6SNPGIsGRmpku4aCT3GIEco3SSg+nInKIO5v5mjx9WPQYJ8QA0rzZvZMdGeuc7OoVny+cXt
 r/3x2REP988wznpnwikexIy9GLNxQ3Fz2ClBqkokz5lLBqpFclunwLDPrx2sbjbrYAAfOalGB/j
 T/fmcZxeiWuuR2WDT5OcUCovGVGyiQZSuWhQdIi5bDb+qFjoHGf5pvMpIrCBtrGhAeBVT1V4JdR
 g3cP6mcv+nORrpnpTvtC+jTFxuZppVGhDkW+OnNkPKSot/RfgVS5wWa
X-Received: by 2002:a05:622a:1452:b0:52d:9c11:8937 with SMTP id
 d75a77b69052e-53036cc0d8amr38235061cf.26.1788350913894; 
 Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53032ff4e90sm17442101cf.2.2026.09.02.05.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:08:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x1jlY-0000000E9vh-1aE2;
 Wed, 02 Sep 2026 09:08:32 -0300
Date: Wed, 2 Sep 2026 09:08:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hu <dhu@x6u.co>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com,
 david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, jmoroni@google.com, kevin.tian@intel.com,
 kpberry@google.com, leon@kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 nicolinc@nvidia.com, praan@google.com, sashiko-bot@kernel.org,
 stable@vger.kernel.org, viursachi@google.com, xuehaohu@google.com,
 Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260902120832.GB2890729@ziepe.ca>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901170849.4052816-3-dhu@x6u.co>
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

On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> From: David Hu <xuehaohu@google.com>
> 
> Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> first entry, resulting in non-page-aligned DMA addresses for all
> subsequent entries.

This patch is fine, but pedenatically a scatterlist's entry limit
should be bounded to dma_get_max_seg_size(), though I don't think it
helps this. Operating scatterlists at the size limits has proven
problematic in a number of places already...

> In addition, a non-page-aligned sgl length will trigger an edge case
> in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> buffers, we will have a `va` with lowest bit set to 1. That will lead
> to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> to find best page size for the mapping on the NIC side.

That's an IB side bug, the newer logic that joins adjacent SGLs should
have avoided it?

Jason
