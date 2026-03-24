Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67BEFEC0E6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E8F10E5EF;
	Tue, 24 Mar 2026 17:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="pWFv8/ic";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3066B10E5EF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:20 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-899fbf92bdbso66560796d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1774375039; x=1774979839; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DGPmxoTTtNhn7YbNdJRS1EkbAYPcolSO8E8zMkGnzu8=;
 b=pWFv8/ico0iOuIJBDexr1xeixTp4AOFQnzDBCv43TGrTryFS+7y2RE69LlRzenBo46
 vwaSLSsouhXgfbSd5cCuJPjQ/I16xRd5iOHgds2wA7RXLQegU07jQ+hSO8z+7VHKNkAC
 SmP+34ZbJp0Gp/DREB2zvFvtcqYerwbsRD5SlDhHxYV1gMUsDKyYFiCCRmUoh+XJJyem
 B8QXbrSFIlSFywnAWbsWHzFScM1EYLqLlmWRybnHc3GRJqi8G+9q3uY1u9sHmDUbPvuh
 PWPzgqf/rsKwUdxT8M0+jXqn/30TleaQT3L+0RML/ZNI0+TXFqUSEi4ayiBBIaMWdidu
 y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774375039; x=1774979839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGPmxoTTtNhn7YbNdJRS1EkbAYPcolSO8E8zMkGnzu8=;
 b=cS1vt9HDPo7XT/Hanes+mO2EsyC1a6n9dgMpw0WTxnRUz4dCtefwFbs1NEGY6HbSkP
 PfFqywI7vDIR6DbI8/XAn/qjeODwuHvCzJcT2ByvTv9CPUCdbXuM221knTJ3piSDPvHr
 rXKmrDnhGpLkK/GTjyf2TuUmE2wpDw8VB6SNnxRSLCapb1XUhZ4IoDBZRszQR1KxYm8N
 KxUc5hFeuPvRhZ8vDPths2NmZsgIzhQ7O/dRdLlifuRKxA/VoXnfmQrs+KmHB7RWT8Dp
 ufYorzSnoOCten+51TBinfvcYZhnNv32fSPxIWIP/JVRoyqjzzci9qC+ukWdH7fwhJB/
 Wd+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlQmxXZx3peKwHKasLclQV/sB+xSaXjCVdc1Vybz4yzQyidWHNKpo0waIv35mUoAf1Ml532fEoxrg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFj1iOsC0jZUpbE777AVJoPQwwb5euPHP+vmEYJXBqqXQuCRtD
 W3pD9Ox2SNEoXr90/+mQBkpvcjSmKvNQA6nWsFNnxK6UbeokQ/y7pO8WhjQiGwFGVQs=
X-Gm-Gg: ATEYQzzxFOBivZ+36d5unjxxvW4XcyvdfEnf4gdbNbcMk9/lxeE39/vJCBIY+oY5pBV
 uuj0KOSFaDXki34nGVDyLO6o7wwqN+wVcjKWKlB/ZjJWVQY1IwaaFPKQHBsH/6/Ku9jZJLXkY1/
 KB2Fd2nKz9/mkGPP6oL1fDXq562FwJkcLRSExr+UcIyaf5mgGj087AwHMww9KoJ4DBKiNHnL6yt
 yyD3UkMuZoT+hOtmoSh7R2d3PuJLavfB62h5DLESjzr/7Ma4CtyJzOVIAaAJvQJi5/c/fsfAFG9
 mTh0yZvhNgr1z/t7tuxtwDI3LfLZWBO/7SqUzsYAayQm2Ci2M0S1zDWI40S3gSSRiVU3c8qGHXN
 Vf6Dbzr0wQ4hep7PbKm98M0FNIguTT3f7xQeUJOakgL2T3JTZdMGbZtUlh7CKAEWPl4JLScsH0f
 ygbuD18DDrMOHwFz+bYszsvOjc9vxi+sDrkKa7zwJ/V4Si+rtJz0DjqCDE52OHER8MHydmSA==
X-Received: by 2002:a05:6214:4293:b0:89a:125f:37dd with SMTP id
 6a1803df08f44-89cc4ace974mr7595006d6.49.1774375038919; 
 Tue, 24 Mar 2026 10:57:18 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85251b04sm116985626d6.17.2026.03.24.10.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:57:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w560D-00000000Isw-1b4r;
 Tue, 24 Mar 2026 14:57:17 -0300
Date: Tue, 24 Mar 2026 14:57:17 -0300
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
Message-ID: <20260324175717.GE8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com> <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
 <20260324122416.GD8437@ziepe.ca>
 <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgf54qwA2D1Xa4rnruJ4Nfp5BsB=T_pB3hzz9HBjh22TL17uA@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 05:36:23PM +0000, Mostafa Saleh wrote:
> But it's not about drivers in that case, it's about many places
> (SWIOTLB and DMA-direct) calling set_memory_decrypted() without clear
> ownership so in some cases they step on each other's toes, and I don't
> think that will get simpler with yet another caller in this series

I don't understand how this can be, ownership is clear. SWIOTLB owns
the buffer, dma alloc coherent owns the buffer, user owns the
buffer. There should be no other cases, and they don't step on each
other unless the APIs are being used wrong.

> I am fine with the API design you mentioned, but I believe that it
> needs clear documentation specifying who is responsible for
> decryption. The code should provide wrappers checking for these cases
> instead of having is_swiotlb_for_alloc() and force_dma_unencrypted()
> everywhere in DMA-direct.

Redoingt how dma-api works internally is some other project... It
would be nice if swiotlb would sort of recursively DMA map using the
new flag instead of open coding it but that is pretty minor.

Jason
