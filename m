Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD3CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EDF10E049;
	Fri, 22 May 2026 13:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="T6zGXEvU";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB7010E049
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:22:43 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8b4eb1fd5d0so90148936d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1779456162; x=1780060962; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iQuBEkHkP60iYe92EnrAsVFZKioHOoQ3fMLBNw/bYhY=;
 b=T6zGXEvUlm18Ubn5b3mSwNBJWVzWp8m89W5Ig9HRCAHQBpdZxq4e1ZD9BkQn4CbAIo
 85SIMxO0Yll4Q5ERPY2wp8xAXsmrtxEuHjCBL9tWux1nNqJbvg62w4YSN+lp7+Rn0qvx
 GvIysMsbxdbFcWC1bWR2bIvQlWCts4TlIj81a+QVr8SIeKgvsLK4korOjv/eX+h2elaF
 U29CrykRYNB2JTm31P5Uazd04h3c6mRsToZY/CF86sh0vv+pDLZrbtHxT/qSjgXLhMjq
 pEYsncj+kUcY+604pbcRi2Fo6Q8qEE9/fFnRoo02II0uZNYJTKzd0bwNUH777vEEKRHT
 d0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456162; x=1780060962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQuBEkHkP60iYe92EnrAsVFZKioHOoQ3fMLBNw/bYhY=;
 b=StEDqmXM1L4OJP845/6cD2CUgC3sNn9+8pLd5NbJKRa8bCpQkaOeZ5hHn/nNbzM3Qz
 laYs+HaHRO6dVgp4BzCn9Xot/Po8Qny6mjqu8/5OOE68JGVb8pSbz0fsnd7Yo1BQ2j+L
 w8dyvcthDmTa5kV83Ws8abD5hz5SY6KdElLQXzqtFeltvkzMIFixyYEMZyRib1rgsU8s
 m8MrnxmekmZFMIac8AAOVgjZqvztVYOa9IikIvcMgrLGWuF55rwApapP/qwz9wlgg8m4
 0Tllvd0Gf4R8gyyHNzapPfPbQZZLl8/6M+XT2XLOHgBlgL4EN06u4Z5IRFHJbtBnTfgF
 9VCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U+lmr++gZ7DOYsDt3NNcPkQdC4KmDUGm97QSN5q37ov4ZrCAMroW9jxZHiO1dM6NAX/dS88UJT7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyuAQUCyCBq6Q4Hlc9cMoVqJKxZloek2awzF1LLQkK3MD4YQAo
 JY3W8dmw+bHra4rLMZVYYTUAhbtGdG6PVE9lqZbV6x/qWTFsG81dE9/59RTR9LSnIz4=
X-Gm-Gg: Acq92OHJGX8ERvUrnBpbJqdxSKOeRqZ2j0BndUDVNMgaIhwSkFC57ZmX9iko/bwlqsC
 ZhidEveQMoSrMXkGp/DyVJd6EsFpqBZDXxiF/H9P9g5QuIaxHMnIDMacV+F4q7ekCDAnsB1i3Sr
 uCsOyZDU7EsnoWl6gGlVjiAaUoMrw7dzJqeX0issLGml3E7xwTbGfTMBUg4IaHlCS6wPDr97dlU
 gd3KlqDOnixrKL7yS6dlWVZSYYq7lUEy15Sd8fAnmQCxJ38ndHORQ2Opga7uXK/RiT6ux1luhlh
 mi/ZPE+9dLaWhuBSDOa8M39EeEmmq3JBW23sWYIlxHKyLGbMUFjwlegvE2rRhr8+6m9rGDB07Jp
 NLo2AkqjTiqEHO5J/jtdoff9p2ur+ZoYfVa7xFciY6vSZHhnSuq5tfq38BowuxzB5wzurEMGSDN
 +76H12evcA/RM3taT6Z3dwAdhm8YTlktWXhsAy41QllW9j4TyBInj5EflN8EpQxGxdaxpWtisJX
 fDJGw==
X-Received: by 2002:a05:620a:a2da:10b0:914:ba0a:b62 with SMTP id
 af79cd13be357-914ba0a0df1mr206635885a.49.1779456161602; 
 Fri, 22 May 2026 06:22:41 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914bb8c7dc7sm116726285a.6.2026.05.22.06.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:22:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wQPpo-00000003hPg-2B15;
 Fri, 22 May 2026 10:22:40 -0300
Date: Fri, 22 May 2026 10:22:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260522132240.GD7702@ziepe.ca>
References: <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca> <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
 <20260426130531.GF804026@ziepe.ca> <yq5azf1s6aic.fsf@kernel.org>
 <20260521175420.GA7702@ziepe.ca> <yq5aqzn45a81.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzn45a81.fsf@kernel.org>
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

On Fri, May 22, 2026 at 10:09:26AM +0530, Aneesh Kumar K.V wrote:

> Can I convert this as an independent patch with your SOB?

Sure,

Maybe you can ignore it for your series, the intersection of CC and
P2P is non-existant right now. HW doesn't support it. Make the DMA API
follow the design assuming this patch is applied.

Jason
