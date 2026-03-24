Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8394DE9A77C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B24310E67F;
	Tue, 24 Mar 2026 12:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="hWmE4IB/";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FD410E679
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:24:19 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89c4feaaeb4so63098526d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1774355058; x=1774959858; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MbJdAPBjjvkAIehxkYzkMUXQO8EVBsVDqYb4hAUTKqI=;
 b=hWmE4IB/dPmsjoclnmx4sMNC+m4NoPPuOVmls/v0Hjrf7SH7kPNrD/mnddHJcTWo8F
 Ey/d1u0oFpFlT04mTJGmF/vS9g+joXPg6Tgbgc0LwXutwEJYEaeU6ULQPbobmDrKpqUb
 7OwLw/P3IPGxAIrD/hXunBOmNYFHEnKxJ0uz03sBFHovgvT6kiqEitMXkyZSUoFC9nlo
 6cAM35gBGh36j6euzx1R4cWpZr8jZEAVpNqq3+qzKsAGloFrZe4e3q+ZgKZrUr4/IqM3
 u4h8XrK+wLyoLVSly9n2+8QYTHPkI7xW2cw5QQWXkbGQe4PAYVGavrVRroku841CSy5P
 xDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774355058; x=1774959858;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbJdAPBjjvkAIehxkYzkMUXQO8EVBsVDqYb4hAUTKqI=;
 b=fP27AHInuR5tGxNI1PB2aotZ+jKj7vw7Y+U6LLq0m03eP60D3N2QG77TqakFrcMjIr
 0So3x349HxzpMapxl5gl3mmTxvY7qSHGg3TalPoPQhFvWKwIim7Hq6YwGyYxsqccouh3
 iDIs4nG1/HvU8kyIeMyzwfw4HIjTejec3frZknsjRU20SvzbhfEpDk5RJmO4qIhOZPrS
 wpDlgQ+JcKcOE0A6C8foOJC4SZnI60pJFIuwrMLUzfBO2RazHUB72rYDC7BegX2FXXRA
 TNbkTL4BtDHWxT8mSj2cvd8voQtzFPP1SgIHh2J0PS1HWLnkZpbEd6Z2jn2htIg4cErQ
 dhjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDKRDr/i44pzAiHVmvTYlAddadPuNC7b1f+ybnGfCr760RZCz22cUAklPuukDYN0x6wP5TG+2v8Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW7Z9OvqSr/qynvRRlp1iZHM7mfHxA+DUfkl/LHuOgdUBqrqsC
 Tv+qeihfTljorYVk69+K8/4i3D41SkioItA9q5460r5JjyzMDZkTbOM5SG7HIBHtPcs=
X-Gm-Gg: ATEYQzyIpNOceg0K0quocmIgVFvT8aDs6WwvG66mf/ufZo0F7S778MPQqfKIRoGNUg/
 kA8unl5qnOG9j0cVRQq4v7XJ8ASjeDFr+8MaN20LCtJHURGmrPbq9FRX09IVD5OndEd8o+sQS5s
 VNBURUeTOT/xBx8zwj2H0CXgK6urEtG7PkV5buA2nKvcEAsYAyX8HghLJcbL9vgl/h/Fx94BJ+q
 yYadnibsYxGNomLoAR+omnrreiIIVvzN2dwczYPqDc5wjdlIkgSCtNH8htFOjZQA7QEIRPE5NGd
 rb972zCW+qyW7y7GMG+caVj/5BbV1hk4Lbe19+ne91vZSM2yRSBugK3BdvRD4fqNADhb4wCwUqS
 K8+fnTJbWBkDIeBEePYQJcPRF0FnGzHSuS5VYqiNjmS/YI46Sq4DgEXIfW4Lj0SI2xcQbW5RINO
 Lsi6OQPUXb9LIrR6tioisJGAEsJ6pMVg5kVM/cn59b2Tcd5ua2lMWJMrL/GPbXZaAn8GGBnQ==
X-Received: by 2002:a05:6214:27c5:b0:899:fd64:1b72 with SMTP id
 6a1803df08f44-89c85a5bebbmr256219296d6.41.1774355057813; 
 Tue, 24 Mar 2026 05:24:17 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c8536afb4sm134637326d6.42.2026.03.24.05.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 05:24:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w50nw-00000000Gf5-2Wfl;
 Tue, 24 Mar 2026 09:24:16 -0300
Date: Tue, 24 Mar 2026 09:24:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <20260324122416.GD8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com> <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 12:14:36PM +0000, Mostafa Saleh wrote:
> On Tue, Mar 24, 2026 at 12:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
> >
> > > On the other hand, for restricted-dma, the memory decryption is deep
> > > in the DMA direct memory allocation and the DMA API callers (for ex
> > > virtio drivers) are clueless about it and can’t pass any attrs.
> > > My proposal was specific to restricted-dma and won’t work for your case.
> >
> > How is this any different from CC?
> >
> > If the device cannot dma to "encrypted" memory, whatever that means
> > for you, then the DMA API:
> >  - Makes dma alloc coherent return "decrypted" memory, and the built
> >    in mapping of coherent memory knows about this
> >  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
> >
> > There is no need for something like virtio drivers to be aware of
> > any of this.
> >
> > On the other hand if the driver deliberately allocates decrypted
> > memory without using DMA API alloc coherent then it knows it did it
> > and can pass the flag to map it.
> >
> 
> The problem is that the DMA API currently gets confused by this; it
> can end up double decrypting the memory or using the wrong functions
> as mentioned in [1]

I fully belive there are bugs, but the API design is sound. If you use
the coherent allocations from the DMA API then it knows decryption has
happened when it generates a dma_addr_t and there should be no issue.

Now, if drivers are using the DMA API wrong, like trying to double map
coherent allocations then they are broken. I also would not be
surprised to find cases like this.

Jason
