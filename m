Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63914C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19D710EDF1;
	Tue, 22 Sep 2026 17:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="BbLIZkNP";
	dkim-atps=neutral
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610EC10EDF8
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 17:26:46 +0000 (UTC)
Received: by mail-oi2-f13.google.com with SMTP id
 46e09a7af769-80a71781323so141796a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790098005; x=1790702805; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZsMda0uwAQyf/r755/L9LfI3ibTlAaDp5ifNzI89+Ro=;
 b=BbLIZkNPP6FxTwTXAQHrfNT/R5Sv5MP2p1243ng+C8mYZbt889VoNqmyD8xLENKDIy
 BhegGluhgyyfeEWDPltXeAXbbB2WGsX0qiKcXl8Y+8aqsB2TM8oR7nVJ4ZbDEkPnHBOx
 Grwm04pkKA9jAbEKselE4Xa52Eh1Ii904UtsrWLibS27mR3snBeA14NIoZEQ0DlQ0Wa0
 Tj+Q9qjb15UPaCKT2w+HAzk+rC5+7JLmhNA04VmK2T0ou/igj6Ui7lNXsDhjPEs7yBnc
 hSmja1M6mVzXt71oEbB/pWOq9FFqvrOuzjtffUiK7YS4IMIItv+8njENahPWOxUCkyLz
 KaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098005; x=1790702805;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsMda0uwAQyf/r755/L9LfI3ibTlAaDp5ifNzI89+Ro=;
 b=XsSFsc2e//zLvckll4G3DkgCXdU9xetzDtdKxzhzIT9KlzFSeTeUfrFDF0FmyqAH+4
 vSpWQT4VcxCuPOIwii/J53weYfR5v2L+BBjhcs1ck758X9ucLsFGgh19mjFvswCpu+6x
 aaTNq42DRnD3bb4HUfY90Lu3GnZ0vq/E/NHpV00g5LDnxeb3xlZWYMXf38MMyZqsF0rS
 +gHGX+n/LG5CaB9IPn1CFHB4F28RpJkoIEx+wxRl1gVHhzInfvJ2tzmhRWfN8Lahrt0i
 zjaLxi7Cwpeb3rSx0vP7/d7r6gUhJU6Mgre3pVK6OkJlUXczwSj7zXQ9WvB1yKgO4sJL
 LNKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByNc/X7BzlXMoX5SMzTdWkF+aXgKi6nCz36VsRKsZ90iNKwDwoY/DctogllvI8EpqHa6Z1I+GY67uM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l45TIe2bF5XdX/k6SGyzs3vvAN2DcJRzigIMY7GpH1xJwSqu2i
 q3cEpjHUXc69hWBs20WSIH1PWeV2ZpM3cWTdIkJvi3ngM03E6ASq0dmoU1MhKAy0Zzk=
X-Gm-Gg: AYBFou27f2J6U8g8EAa3fFZPzZppA2elPc/h3TQm1fjsTIvKWhhBMQUACCTmjgv0607
 jE1JrOmYBAT0MME2gBCacNpSCDhZxArHi6qcnHrTJXwMV2j7TYh4KNsDZunRFkGd/zOPBcoBQUc
 nyqpnf9SgTczKON2zvzSvGHTqzjKu4asRkyTztoVMF8XkHSD6EtETh5pE6S+1VlLPA2kcK/PzFW
 uCKudeCb5d4q7tWrKsA8t5AvT6QI9nmvRfyqL3B8LLRzHNzfdVaxa+UcsxIG2LXocd3pWQGwdgZ
 i5lHMkzRv+KZGl1AbAMK5DXuItmsD2aQyTFg/fhQNkVaDuBX4NSi739//IowIm0rB1guEDxOmW3
 V2iSgGOw1vJJOS+cte/qkVkOovHxqR3bXgUjqVjcgwKZTNWhBUilutN1Jd1xg1yIXRYRGAvVRry
 mqQ69ac/84Wx+x8Kvdv5OU8xRmzeh/557QavXkwZZBMwBs
X-Received: by 2002:a05:6830:82ee:b0:7e9:e488:3bce with SMTP id
 46e09a7af769-815f0071c0bmr324985a34.6.1790098005310; 
 Tue, 22 Sep 2026 10:26:45 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81603fc79dcsm103564a34.14.2026.09.22.10.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:26:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x93id-0000000AWlt-1Oeu;
 Tue, 22 Sep 2026 13:51:47 -0300
Date: Tue, 22 Sep 2026 13:51:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260922165147.GD1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKsFofudnTYpXj1@arm.com>
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

On Tue, Sep 22, 2026 at 05:25:58PM +0100, Catalin Marinas wrote:
> Does the memset() post sharing logic work for pKVM as well? If nothing
> clears it, we have a small window where guest data is leaked to the
> host.

Same question for RMM? Or did they define that the RMM zeros on these
transitions?

Jason
