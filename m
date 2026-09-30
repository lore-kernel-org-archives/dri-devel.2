Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4ECA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894CB10E412;
	Wed, 30 Sep 2026 16:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="oJd0k2Wk";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AA910E412
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:52:39 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dd046b87so4176447c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790787158; x=1791391958; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
 b=oJd0k2WknAu1I2oApmG9MzPFUjcBnsquelAp447esW1+kxRd5claR0sMUJ4cZUQ1yn
 qIkhfV6/eqiz80Wn5weTAOJBs8yhSKQOU41tMZ8Zwqag8BsLAUHUqgIhpGkknAbFw6Es
 bgfIVzlvdR34DXatXRRmuYP08UnSkZq0sB6Oisir9+Dr/g/UNT7XjGI8Qh18Jl/yma4O
 pXrgI9j6jnOKvS8RuGz3ITJv1i9yWflQsqCiVQeqa5qWTnzIbaFbwsH+hEzJKx3WnFqH
 EwisNctyvK69x0z3qPDWN0SIPGoF1IbkcSz4ck3HYhivetAaGic10mFLc5hSBE9q7qDk
 Y+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787158; x=1791391958;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=USoosmtGDycX1a/Va/WTZ2HKM0YP5/LMRYBi/jK/1WU=;
 b=K1cgq66c1bmeNaKY7fzmCOBkGi21L9r7HWZicAaxJ2dVP5dD21sU0nWt1ubzd7sRdI
 bC5eHOxpC1Deda73pkbwYNkwx9Z1a6rE4wSd84nT+bKful1qigU0QQpSN87DjXlddQVB
 P3nd2WUauwiyh/gyxbP1fGgP1NGNExyDwIN3tRF0h2kvXw9AOH/yXMOH9f663D6CwCKj
 4OU/LVm6HqfHE/r4fWeofrYzTjumczzJuDJ3K6LVwiwG1D8cpk/dmSp/KW7QWa2Kby2W
 COaOEKUSkNoG1+ADgC5bB+TwDgMT4aq3tPBqrUS6rIncY5scSGdaANo8MekbJld8Z2A6
 e6dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8dDMXmoElR0H7schAKKyKmXLUrAZKvvyrjc/rrUQpC089TahrET8m/aqsTLDjiOh7aaMJD4+KDr8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfUuhKYrHMqwHDk0SyWKsvCO3ttmHHHrpJnG4n99FdJiUdsXhd
 nPsReWeGyE/Nd2rqAYFkg+3R4eeBb5ojRJllHFA/iZZdNjuBpYfb/+kB1XyMo8y+t+A=
X-Gm-Gg: AYBFou2USCPv1OSmF9qN6lXyj+KSr/j6yusbQ2nR6B9xHVs0FdV8GiiqVP6egM8P/YM
 rvCA7ijz2asWNIUQo9jJdW6j1WgCJ3HRpVBSWk30DXrC6pqLpwAvW42toNhHSnnT5bdfa1pnuMh
 oqjbeUToKHQFMUQVuFOyOvIY56CNnU8q9xieaxC63is+QTG/j/UlV88i0J884tPzV/ngiUrpj8F
 tchX+0QoBDW7vr4clBUr6bqAHerP1/9I7x/w58wCdl6AfhUKiy4Ok7eCMv52QJeM/vERV5Rnc0n
 Tj6lTr9D4coXEWiHgCOgeg36MOQSHpb9r0CnmC72n8B7rtz0R1eLbYwcu3ruUUAClhMrsW4jVby
 blZJXL7CT+e7gCSmm1E5LxDY2YBRMQm7O5/rBAIBb05Nzgo3aO9o1nNZ0Q4aLr+A0PTvzfadhOa
 f7SBQh1tpPjegA40r8BFYuU2cPjlzxcLJPeVHKjwDOveu4Fw==
X-Received: by 2002:a05:7022:4595:b0:143:297c:276c with SMTP id
 a92af1059eb24-14d330b1ca2mr3017652c88.33.1790787158196; 
 Wed, 30 Sep 2026 09:52:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14d313b9c38sm4523537c88.1.2026.09.30.09.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:52:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xBxXo-0000000C7JB-1eI9;
 Wed, 30 Sep 2026 13:52:36 -0300
Date: Wed, 30 Sep 2026 13:52:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <20260930165236.GS163130@ziepe.ca>
References: <20260929132305.GJ563127@unreal>
 <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
 <20260930143237.GI3401365@unreal>
 <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
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

On Wed, Sep 30, 2026 at 04:57:04PM +0200, Thomas Hellström wrote:

> Returning again to Jason's series. Let's say we'd add just the mapping
> type infrastructure, converted users of pcie_p2pdma only to use that
> and then we'd have access to per-mapping-type data. This could actually
> be done as a prereq for this series and merged separately. It's a
> couple of patches only.

I'm happy to say I found someone here to pick it up again, so we
should see something on it after LPC!

Jason
