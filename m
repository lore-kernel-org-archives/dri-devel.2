Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1023606A688
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LoMiAxTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7AF10F5D6;
	Tue, 24 Nov 2026 14:00:48 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100F210F5D1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:00:42 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so1089074666b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795528840; x=1796133640; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
 b=LoMiAxTjV4eorbaLjY1PpY8GS4BMTD1RVMTJVe3OjejInLKAbrB7v9hnviDjelJfjH
 1p6JIVi4yXb6IqeKSSAwLvQyJM+lfK70rWd9rpAXaYtbhuHSCQdoHAGUaAiJFqWk1E9s
 ql7Sqp8wDeKRk78Xo9Y6DqCakWDmzHObQjaZXXJ88N/h/wLlWsADpGU0/AsCB37MZ+jd
 wvWcKGXdtNIOnbk3MzOoRBKCPKxpZLdkgW6MhdUouXBJBZIByn8NHc1so1kywFlfxTne
 iH3haIHAafNLDCCbphTFyura/83l84D7uZDMYmA+PlflDgNif1fDbF5Vu3w1gcn7+7o9
 9GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528840; x=1796133640;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
 b=mZMBbuw5NspnqI/JsdjRJglwPzx3d12sJdR9C6xGxgB/C8QsAd6xAz5RbCutHXashW
 98RqJvzcAvlhod1iVo98lKRZDC5OuUg4/pBTMLB0/5VoAYHU9LSFJNlf+eiOK5liNsxj
 3BduP3Twn/WVloVxGMHu5ppCpLMlfhjFaTy+KYseKI8kCRxiwQCN7CchLg/epUp5pJx0
 f6nGUu2b7Sc1wrN2co5nqvphWP2ElJireD4bTHqG0TiRG5mlBM051xxJ2l8lNBQl1L4c
 fHL222GZ+djVyIgno6qvNFmu8jKzGVXfNJDUuskaSFaVgUQuWNRVjpTG2qZDdhzm279k
 eAkg==
X-Forwarded-Encrypted: i=1;
 AL+hErFleBlJP4ACpGxiYSNDrzU70F6M/p7H9Aq7sTzrWRF+wpUETSLGJDGlqnO0mL8ULtAafy5ZYSP59wA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/3QqRGqXLmrFuCH48srvoZmLbcjBXfbqz2BaWniXfycxJgpr04
 k4Alvf7mKVmbi2u+tjWYoeZHLnUJJv5iN4s3xGp97tFKIKpVGd7ktnT6ZjpKnce3+ec=
X-Gm-Gg: AZFdTZf1rQZUF7rbPi2dE39CjgC0qtd48BY9exh6A4efo/1AuNiua6g43jiuG7kIb44
 26/HGdREQ+pMlCQKJjbJHBUzp7dJy5Z+Xcl3nrsbZJ4A7PkRDB1BbFxFx26QykhLCFh/zteqU0N
 hubUqd6MXqI76PfOf7sBl3kBPEpLH0sXJrmUt0MbDx2My8hjB7OkOJtT7izFkN3njVN2RuYvq4H
 83GVt6wQIkaoPjeFp2Q2UVSE/Rxsgh4PipWlLrL0ECF9MszJixmzOEDhqYLg59DYkZy0HiYOj35
 g3UmT/TUe+64wcD8vv2nLbG3Q9xqmyuUBWQdDLyIRN6U2Xa+c8m+hLkL7BleVvQR+EBO8wM1/Fd
 V/oUXuTRIht/NKyyd25+BDLNkokOESW2HnBR3LphiBEf8+MV+mlbUymzU4xIVl94eDWj5/mIAa1
 6kIoiKbf1PB5S3x8X+yi0QVz0KaPeSHFMZNYUoNuPIRepAPufQiIFxWVxW0qe5tV5ZUsYa+4bkx
 /qOPa/aIUJsZztrchp7fjU3S5zVEdO2lCWxwkfw6g0aHmN4Y+yyjct43IdaCJ2WX9GqCfVlLOgZ
 wKleow==
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c51315851d7mr1405271066b.4.1795528839874; 
 Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cc257sm6492195a12.13.2026.11.24.06.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVr4W-00000000QnE-3MAi;
 Tue, 24 Nov 2026 10:00:36 -0400
Date: Tue, 24 Nov 2026 10:00:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
 treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
 Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261124140036.GM9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:37:41PM +0100, Christian König wrote:
> > Part of the design of this series was to allow the conversion away
> > from SGT to be done incrementally without breaking compatibility.
> 
> Do you know the joke from the hitchhikers guide to the galaxy where
> the dolphins are happy for exactly the same reasons?
> 
> I'm pushing against this plan for exactly the same reason because I
> think it will make the conversation away from SGT even more
> problematic than it already is.

I think it is well proven that trying to do big bang conversions in
software doesn't work well. :(
 
> > So it is effectively this:
> > 
> >> The framework should then either connect the SGT directly if both
> >> importer and export are using the "classic" interface 
> 
> Yeah but that should not be a separate mapping type, it's rather
> that we just convert back and forth from DMA addresses to SGT for
> compatibility reasons.

The mapping type is to support ualink/etc that don't do "DMA".

Only DMA API can create dma_addr_t's, you can't reuse those types for
something else.

And you still need a scheme to negotiate exactly what kind of
connection you need. Focusing on the SGT is missing the big picture of
why this was organized like this.

> > As this is actually quite complicated and needs discussion exactly
> > what it will look like.
> 
> Actually that is the easy step I think because quite a lot of
> drivers already convert the SGT to a DMA addr array outside of the
> DMA-buf framework anyway.

Given the importer an array is not so bad. Getting the sgt out of the
importer will be a debate.

Jason
