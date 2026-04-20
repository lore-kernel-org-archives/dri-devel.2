Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE16F5A8C9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C782910E1F9;
	Mon, 20 Apr 2026 22:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="EFm2Sj1I";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BEBB10E1F9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:56:21 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-479e7e88fb5so417766b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776725780; x=1777330580; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HxETj+r6/c62h5v/ZQo9q8wwwtXio08jZSnj3FSr8os=;
 b=EFm2Sj1IwyNKKzMrTjIbGSxbh03UBP782gx9i2V4oI4SlqV1VrlgRaWSh2x4K6nI3C
 5LhNAj2ZX5GiLqbGfQoWT5GHFximognXRjsjWWPKcfYSMeW2Vh3tGM2zQGWROntwkZbM
 yUK6LrIWV+zPvYQI5Zrr7KesoXW7qxMYWpYfqheV9tfi+kcVbUR6Oix4WcuHJZcDERux
 1bNgEdy51n5B68Ih/APC38PidsCbaZ2nuIPjKkRkhxL2SmwrUF7haeqOROZNkPYHhUYS
 QbBhtL7d+otrYFSDD2uIArXxWC8Np8GfyHlkMt/YLXCuxmD41OCjIebckq9ZvrpfwzvE
 t3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776725780; x=1777330580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxETj+r6/c62h5v/ZQo9q8wwwtXio08jZSnj3FSr8os=;
 b=dt02z9rjfL0RUEBuVn3ThubMAT1VKBFnHU0xa2wXRi6EMN3BZFyrxZiRIGSWOIl1i3
 yUc4v8P1Q0ZNzNLPr9qPbMNwd0dYavroUZqTBAm089f7cn7L2zSIk8OhlEFPEYIcviAE
 B11c6OTtBrKTeBG8xu/1BTwqMlsoB2bXiGx2X18CM03CWsbJy0Pf6h0gaOMsAjXtzmLv
 LxOZbzHTP/nZu8AIlfNBH4QxDl4J7319bQfCXvJ+5a5jHD0HuOfT2MomSQ3GsETAV2oO
 GzUN4saoc1lbayRWOMga7Aau1T2LRl9LphVw5e4PycUdOSenWTswS3DfRf6G0Hq4RqXs
 Ls1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zb98tST5ALeCOlNLqGWSRItk+EGaddpD+Ejk7+Ze0wrNhvlsmcCr1rQch7g/ME8liY9FLiO33fIQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrcLJ+qByXZV9WC635Kjag2AEmryuYMxxQnvONaFrHxLdxwCxR
 UUAa8ISOUn39pfCoRrCZEvrdTbykvvaoVlXPGPCstyhk1AtVLNoqkAMF9Ifv9GLZidk=
X-Gm-Gg: AeBDiesQJrCK6bEQPMwHmyvmrTdxb9CJ0SC51E1Qhf8BFdTxrPw3WS2k5gom+beHhYr
 0HUCIxrAQObYAgloU3O9u6f83er1xbeNSBFgBkUHWP6QV76oEI6FQv83nK/LpqIR3f63XYEoApv
 28ukhcTLaRZ9lF27Rfby9gzBcbM6tPbYurym4pujAv9bTvlGhQPIyelsFJKqYVNBKpfVZmcJsqa
 41gpubUfI8yUzZcdACr/zqDMTkSuSjXeqssV26FPNrV3pf/9EpdIPqmLN3tjZVcXy2e7HP0qzj3
 dtMrLqCZh2l+6aN0E4bLhbXc4wqXWWbBCL7fwd8M5guW3nmd1nApwyx1/MdZnITG54Wbj6GRTWQ
 FHBvCv4+0VtZT1TXEEAuih/Fo7nFimTRDpCgV0sC1idKLCmN+hqjfz+c91RnBE8CRbAJaSL+QAt
 Yf6PqO5wSM
X-Received: by 2002:a05:6808:448a:b0:479:d2d3:a399 with SMTP id
 5614622812f47-479d2d3bdb0mr3331712b6e.15.1776725780355; 
 Mon, 20 Apr 2026 15:56:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fc19273sm7702863b6e.0.2026.04.20.15.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:56:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wExXO-0000000F7qQ-3pLG;
 Mon, 20 Apr 2026 19:56:18 -0300
Date: Mon, 20 Apr 2026 19:56:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ekansh.gupta@oss.qualcomm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Message-ID: <20260420225618.GP2577880@ziepe.ca>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
 <2026041418-volley-composer-6363@gregkh>
 <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>
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

On Wed, Apr 15, 2026 at 11:04:26PM +0530, Vishnu Reddy wrote:
> Looks like the device have specific iommu configuration (via
> of_dma_configure()), then using the auxbus or faux bus types does not have
> the bus notifier calls to iommu_release_device(). Please correct me if I
> misunderstood?

I think the general feeling is the open coding of_dma_configure()
calls in host1x are not desirable, it should only ever be called from
bus code.

If you need to create struct device instances bound to the iommu
somehow this needs to be much robustly designed than wrappering the
host1x stuff in a new bus.

Jason
