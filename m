Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDACDCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFBB10E410;
	Tue, 26 May 2026 12:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="AADBRHu9";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B7B10E410
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 12:26:59 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-912475287a5so1168178485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1779798418; x=1780403218; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QQVPF5z8tEWy9hSyAGSwHCVBtb21IOuG2HFA7xrSBPI=;
 b=AADBRHu9olTbM3pFiAaTDrZFpLOUIw54Db+7N9zC+dqhHXr7y4WNZN2y50/n5tLlG1
 bX6xh8qUBD9SrkTJnOFhwL+VMzZzZr4jwPBESc3FzHRV92CESYTETu3ecy0ewo9ch+5K
 g3fw43pKI4+LNVTe7WF2qx+19pxCjMZCokaGg/hpx1H5fJmVdnpKhWJ4vGHPaPzQnkq7
 16GlM0HfGj/gUSM9VC7ljYwqwRHRqVoMKXsdSw19Es5MoJLIYzGmn05Zp2c/gzM/gPL9
 BecKhbDDgL1hkUoSeXhJQKGTUG2+FjxE+tvBrK5KyBo+aNWzOZuB5OJfLm0ygqUkeI96
 mOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798418; x=1780403218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQVPF5z8tEWy9hSyAGSwHCVBtb21IOuG2HFA7xrSBPI=;
 b=AZrYEFwlpJ+WIYf6ZggV/M9EIuuEKsl5N6PLMxnmC238GvC7qkdmIRS00HYzcuIQC0
 ceHr2oIdcwPe67pSQts7nuJJnQnU88p2o5xgKQ+NHOhlapzT7OWr1VC5YVB6jNAlxSXk
 y2elLETaaC2EPsMtmnrqa9ExewIVunYHJYa9nRQ+l8q9A+hBNqXgc6YByAED6qyYA78j
 +5NFBYBUGlGjIeOHOzdNv6Idf/lrmB/JrVlmAkujTpwTeAt5d1MKLidZw5y4N3uUVRug
 kWBRbkjjy/M0FiopPesSbaPPXR/+TY0yVpxrksA7I99qt9PHMgpgR2zeDyG4VIlQvHSg
 m5GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Wct774JwlWXL5GBJRaUSTseWN46yUzKCuBy5CfJytrCFma63u0FIVUmmtFSqpZksRe9URXa47BaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1IacGFoEY6U05N6Fc4UDl97yCeOP490ZpTdK3bSN30cIbXgdd
 WFowj6RQXViHxrzVW1m1IBlDxqVsGeF/GiNAtGuL3qrV8EKThkm7RcbPnZO+ttgqylo=
X-Gm-Gg: Acq92OH+3KgNSrTd5SKNbaSYHanFcpI571P/WVUHEn1KreOlGRen0eOejd9dyBcnt7N
 tv/yvR4lJ+/pGC/BsvHNqIWmBmZO19bCbHO384h2ymJHenBGWEDbRFWe2aKX3+Bg8atQZE1WAYE
 YPEl7FembiLvWQ93epFimzicQc4zJ9nTXzKa5i3w27mG+Q2IUNXp55FidQz1A71w1Rka7VWcGkt
 2MUVTOs75YOXJIFTzDFd9KIfKHzOJ+V115RFpBnTLuFF7ZMl+bxZKG/Lg2rMndK9AFs7FCTiOyX
 Z/zWz1/Dw8fwaMn6+VGtBVSANY9qJPWMPfLvVPwqzznX0csAHwjSEvk2EXD/78BXLzcs5eU1Xvq
 kNob1p597Qf8QN2lG+Zc7MkXpLOA+MKBZYUnsmciXai6BG5ESZB9uBqAiYsSufs7IfY4oi2NjRz
 yGqiU20N9/hnvFylnk2HeFvYXCPToOMAZrHXwSeaQzdFeu8Xbbyv4llV8HllUQvX9dufNopOZAq
 DXda9c96YPQW78W
X-Received: by 2002:a05:620a:29d5:b0:914:c7b6:e29c with SMTP id
 af79cd13be357-914c7b6e6a4mr1836526485a.56.1779798418003; 
 Tue, 26 May 2026 05:26:58 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f8801390sm215458285a.36.2026.05.26.05.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 05:26:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wRqs4-0000000DONN-3pnp;
 Tue, 26 May 2026 09:26:56 -0300
Date: Tue, 26 May 2026 09:26:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: take dma_resv lock before dma_buf_unpin() in
 release path
Message-ID: <20260526122656.GE2487554@ziepe.ca>
References: <20260526111034.4079-1-Ankit.Soni@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526111034.4079-1-Ankit.Soni@amd.com>
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

On Tue, May 26, 2026 at 11:10:34AM +0000, Ankit Soni wrote:
> dma_buf_unpin() requires the caller to hold the exporter's dma_resv
> lock:
> 
>   void dma_buf_unpin(struct dma_buf_attachment *attach)
>   {
>           ...
>           dma_resv_assert_held(dmabuf->resv);
>           ...
>   }
> 
> iopt_release_pages() calls dma_buf_unpin() without taking that lock,
> so every iommufd_ioas_destroy()/iommufd_ioas_unmap() that releases
> the last reference on a DMABUF-backed iopt_pages triggers a WARN.
> This was hit while running tools/testing/selftests/iommu/iommufd:

Any idea why this is comming up now? Did I run the tests without some
kind of debug option to turn on that assertion maybe?

Jason
