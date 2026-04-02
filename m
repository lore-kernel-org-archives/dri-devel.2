Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EBDD3941B
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCA210E448;
	Thu,  2 Apr 2026 12:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="YMPXLDYu";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F6C10E448
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 12:02:57 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-50904a8f421so7928091cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1775131377; x=1775736177; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+KtTbuhHgiuHy+YXQS2vChspL032vn/9QRxOV9xDd6Q=;
 b=YMPXLDYuvsRvHABo+TX5CplkjDbDjH1Ut4xWplHrekqJzXq0t9MRmJAv4p6JBbGCQK
 vsvZs3Rzt3GwStpFtsjxlVvsmRMY6dkQDpasgeDsOfmAhTI7IHZN1lwkpH50TkgnHAgN
 ErqJMhvkJVUwsG4xAIcJJ5fAgHoNf58OW/WvA8pXtt7/CDUAJfZryEKvAyUV212eTG0Z
 fnCTqtNazVBNggZkKYIlIGOERxgNRpsSd6KZASZilGsE7nIYg6OEbrvquMvG6T9eNMqc
 dBWW1jKxfdcDPtN2aqi1SImLPZE0Iy1//HTu1KXHN0smrddhbf36YwTcCBC1sCqW8jPF
 Jfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775131377; x=1775736177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KtTbuhHgiuHy+YXQS2vChspL032vn/9QRxOV9xDd6Q=;
 b=Flm+29U6Lqcd1Vti4SaYHO90uWRVOo8qZCAVAaWUAhdQIm4QSKg0SYaeOt2PyxluyZ
 rsS1Lwh1wZTqWkke5wuFWUPodrazHZ3KxYCF8knHIwYXlEWyOmtj+3DnzScmJUZZWluV
 7Pq7zyexK9RoIpv+LMQ8tLRyrSPlTcKVHGoFXT9oWMTtLIyCLbuMH2MuOjA7v229PIQP
 A8Lu9Gt1PpvQtYCiOSD2RcIi7MaxRvIx6nTnZsBJRPR09IfUpd02ys7pNuSl/rbpOq74
 XDRpJIYxi45bP992W3Xay/iZaE0XL9iXdBVhb+t5PX81JuAiO1qKvQhik19S694PxHot
 CVgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUHitctXoPtdrEvlaeDQjvyMMtD0pA+u6fyVcccNK/FqWap9SIqFkG0UbFF6Be4ATxFbsVT2JZ2zo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzmg3/XUoMnw+4GpQ5zi+LJXkbaeeAgCTptkxpV5CNaqfHMBdR/
 1Q+CWEzWYypgEya9qTzVmLclSr4G0tz0hHwbkmOY3p58T9afTDdolSTxvu0tMChVrT8=
X-Gm-Gg: ATEYQzzx7odfVXx1TzLog4eASYPjroCKZLOAeNVCJrX/ntNyJWJWjObyJveQbiPyiuk
 ywSbshDgu6Kd01L8MK0s5ld87OqrynsLxB2VKmpTjsRBh0WCpgIDSImnkLfsLljhTOra6bDHMRc
 ucCW3D7KDT2CJSPv8cd1GJBDXvy7FXDsIfll6RDlryrdKCflsJPaIrZS0Dp7IvyMUpzI2x5zWaU
 8RJnXRX4P7/Baila5YBH2Ok5zUDfaHnWXM82btTprsunT+sFV+IMVOvuzHsP1zJnyfB8M2gXfzb
 FERhqAEEnkNo+fGqC+j3j8D9JNKx/lbb4negoRb2f10z6DNLS016kOi+jsbgtudHDiwFOF2kKVg
 JPiAiw+RFuiXJVO3OA0JL0gEPS2vsRH4hygF5MY15HstlhiR670bglUfzRgqVZUgXjbbwPVo7Uy
 45+bJYILnt/UA99hbDGiE+7P5jZXGz9vdL0wHoUSVnAOVVMq/LbP40xEWwtbRFmv64Cj+OQQ==
X-Received: by 2002:a05:622a:a18b:b0:50b:538e:93b1 with SMTP id
 d75a77b69052e-50d3bb64108mr80844141cf.5.1775131376396; 
 Thu, 02 Apr 2026 05:02:56 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b8da5cbsm20265321cf.31.2026.04.02.05.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:02:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w8GlC-0000000Bm0s-1xCy;
 Thu, 02 Apr 2026 09:02:54 -0300
Date: Thu, 2 Apr 2026 09:02:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Brian Starkey <brian.starkey@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev, nd@arm.com
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to allocate
 explicitly shared/decrypted memory
Message-ID: <20260402120254.GB2551565@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <4s75rtsmdfrze4rscbqzyrjyrko7n6sehe7agrngqag2cna5bz@eflmf4kwjocj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4s75rtsmdfrze4rscbqzyrjyrko7n6sehe7agrngqag2cna5bz@eflmf4kwjocj>
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

On Thu, Apr 02, 2026 at 10:52:34AM +0100, Brian Starkey wrote:
> I'm not clear why the heap depends on !CONFIG_HIGHMEM, but I also
> don't know anything about SEV/TDX.

It is because the CC apis, set_memory_decrypted()/etc are slightly
mis-designed. They take in a vaddr to represent the address instead of
a phys_addr_t or a page *

This means the user has to use page_address() and then the whole thing
is incompatible with highmem.

Which is fine, highmem and CC are never turned on together.

Jason
