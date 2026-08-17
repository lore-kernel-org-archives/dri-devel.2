Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE1C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FCD10E406;
	Mon, 17 Aug 2026 13:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="E4tubxFz";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B054710E406
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:44:19 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8f186025973so31620026d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1786974258; x=1787579058; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BS4TBmNsymnramXeNmNZhBmFeFZI0B72fRANMpt3ZzQ=;
 b=E4tubxFz2pWSdmP5ruyhFzBhyX8WoksLerP77Y3BlKcaG+flAHsrGj+GsIUNgAh8/z
 XcL4Y4nl49ik1vqNQHGewqUJ8i/cfPyBuv9B5vTth24WHDYRv4t1Ie+EtjmuiDUoT3+l
 VkRAPcmEJ8mSkOFRWNGvvDF+d+6nK0azTZ5hdhk0lPdYhJ5KDo6v+tUpeRo+tmnlq2HK
 32RO8HtO7Lvy1K/A7ftmkyR+yj5ak+o2gvPJ+HtPKKXMhUxgZTwvNFIVuzfu3i9XDfze
 HJ6Dg6NXEZnDt+IE2Tn+nab3DtzLtwN6aS9CrVnM0SO1BEmcLPxQwQbqFtQSRrco9ob9
 mSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974258; x=1787579058;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BS4TBmNsymnramXeNmNZhBmFeFZI0B72fRANMpt3ZzQ=;
 b=BWXTQyyadFllS49nbsuoEi9wq0WGnm35RRpchT0dvmvpmY8SvvS36qHx5clKdceShe
 BliaAMBpBgFJtZcaBccNGeGe3RqtiVHhkNSfb1636oz61U/UNoELupAXMKZekqB1ygNl
 cleKYFceW3O7YpaGBa5RtwYGr9yPZSUZwFLNiY/zTZBoLwOBJ/tB8Im7NKr7xPzGGU38
 q6UDQIOth6xBUBgpHtOZR8xRi4mmQrURTEIYCy9BA+JEnoSlPM7FtI1XztcMCgPw3QqI
 uhh4d+J+MVEb2BIsg8DvW5ZV2ujfVe5M+TFOz2EcFQroPOb9QMDOs4sM6Nt/Yodz5LYr
 YRrw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ron9EmNEkWTDQu8ED7EqVYTFt47mMJ5Ic5A7nJRx/hUt2PIMwP0g7hUgyoVldNp/HUt/3Amox80PYo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN2GljXMY+iX62xNheeO2MGGPg5OkganQk+HiofMYHhzd9Ju0n
 GaomX3vUysuDL2P8kVm8vlVBnJOcPrYurfzs5PwOaQfMfTi1iQr5m2RSAhbnBum0z5Q=
X-Gm-Gg: AR+sD10W2WbE2tqUUFS5AgMaxRBPqkEyG9O3MBaZh6OfasHq8FonoZ3ZYc4C67gT7aK
 I99M/UYKYteDZhZXz6NgyiYEEScPlJh7SiTjV1ivBoJ9MlUMIY8IPTS1rOzs+aNre2ead+JgDWc
 gpSAoB9DkW4Qe8GbqjD25H14Suyk1C3U3vFRCapiw8YiDz6P7+cwlFNx0U3DY4lE0VV1SH//nsR
 rgYFRaMUd02L5s0WtROKnJxJm8YwuzQ5YQBnttkrAwfZ1abCsMKmOhoZuYRcjCBYVuQGyErrDyO
 OTaeLoRYkWlacf1Nh9jmjSmqu676U9UsNlJABZ1upNoauOlSH64/pa/kzdmVk0EjoQw6QBMmXpZ
 vRjlN9K6YF2izPCKGzido+K+PwkJCZ2iTOVItGezS5E9FoqkPv/ZHbE9cr3Rl6Fit2GxYqh/pQo
 mRPWYFwmeT2+V2fPb8br3h0fMJE9KCrQsQrmYmPCARcvUb7dcp
X-Received: by 2002:a05:6214:2029:b0:8f3:e97:59c6 with SMTP id
 6a1803df08f44-90a91dcd1eamr322787926d6.20.1786974258222; 
 Mon, 17 Aug 2026 06:44:18 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c45986ae7sm9166026d6.48.2026.08.17.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:44:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wvxdQ-00000005wLX-438N;
 Mon, 17 Aug 2026 10:44:16 -0300
Date: Mon, 17 Aug 2026 10:44:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Message-ID: <20260817134416.GA1415075@ziepe.ca>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
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

On Mon, Aug 17, 2026 at 10:17:40AM +0530, Ekansh Gupta wrote:
> Register the QDA compute context bank bus (qda-compute-cb) with the
> IOMMU subsystem by adding it to the iommu_buses[] array.
> 
> The QDA driver creates synthetic devices on this bus to represent
> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
> so that the DSP memory manager can enforce per-session address space
> isolation. Without this registration, the IOMMU subsystem does not
> probe CB devices for IOMMU groups and of_dma_configure() in the bus
> dma_configure callback has no IOMMU domain to attach to.

I didn't notice a clear explanation of the proposed DT schema for this

But it looks awfully similar to the other driver that was creating a
kernel synthetic bus for actual real HW, that wasn't well liked.

What is this for? Why can't you have a normal DT binding for the
iommu with normal devices?

Jason
