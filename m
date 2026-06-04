Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF75CD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECE710E315;
	Thu,  4 Jun 2026 14:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jyvym5rM";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFE510E33D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 14:26:06 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51775f2473aso5632781cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780583166; x=1781187966; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
 b=Jyvym5rMAFUhE0ABzUwAGzacle81K4QJ/87Dicu9ZbkwnutMogrqw1SchWi7oD/pKP
 oX3Q5AjPmr6Zdb46BaWNZnGpRP8qFJs1wDc4uk6wMOZJh+lTQ5TorDJAHd+v/lXjpFqC
 4Zf5azs+m6SvdWCglvfPhBsgwI8yv6hD2NJf+75ETz53vTOdp3QMPLDgsgJIIyCGQloz
 ISpbex9CSt7Jv5PlLGOPofAiqVvlJtAjTmFI79DgSq9mwO79NzTWrZ7EDPpAYocZ/I0C
 s9eZlM8VeCNvNOcQh/m6D+qedTFnkFWUXk4oYR1JILy4GUzFOVgPR8amXk6CdA1KhEqI
 KTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780583166; x=1781187966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
 b=VwXUCGylVZRwQiRo+Qh6GztVAIj4DLa7+v+sF7seJ8XVtQJVyY/xkViDpnnhU9cD0B
 eHpZU62tG5FZ2Jww+bZCZcUHBnTXOb3h24jMuo2VFzJQBreAjgPfJlh0bPm0rNFLdKpp
 RM5l9ibFNxnu4Nn7S4cuv2GkLiHxaytoOwvTSEO2POj6oSf/p/nTmLM/R+0pXZm2O2kk
 uBXPS4Y6cF0CRkjusffNgiADts2kMbal4vVYLL3InSeKEQoZFVpl6CDwSZ6UB4aWxC/m
 dXBaGRUr6IX20WcOVsFmzpP+GmPbdWi9XM6qwIJ9PK9TmtH0n3d2ARD2WPi5PLshSL3q
 cF0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0q4f6nsYDEcovjkhlOro1DNlXyZZmLC2cQ9njHWzg+P28JzjUIRKIGB32F3463Jlv6CRNUOjXP48=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCz9hlw9m23V0aKnKXYXFC1DX0ZnSOwTdGyZaYSRzHNBv8w8VG
 BZcrcRFRjnPZ0G5/JeKmiWI2+bvPdsFTfsfgTQAmd3RwYGbSCK8Yf9X0ezeeTpJ1Ei4=
X-Gm-Gg: Acq92OG1Fs0/GSsVjPf54sBXZi3TUUp4efCF6uMWe3GJs0GT1j5GBK2wytDm6O1ZCYn
 xJBwWdnP9oV1+pCfa47/FpiZk9NWWKmsEfwOxevF6gmdz0Rtu/jWI7tnQqtujgUK3LeEaaxm0iV
 E1xZsxkI7xwl3suuwfaPsBsewk4VLwBrRkRsHl8qcYqZjIWeXQ5ebR0vLt3V2K56TpbZjUI8ZFf
 Miw58g6I1jfYsmcYFrWR45ym1iGTE+9nboL+8ykcBzaKABfWXa52rRs00XXTUDGEWjbKSdQA+0e
 R0+kVGsbFkpNFdl3vvPVBBrG+hRG93RK5UbbF5j3bki2zjZpuOySMhIhTKaz9IFqoQs4GZMv5E7
 4ljiu2ThZLQp+J1oYlahqS/H6nmNfcfUixe8w4+/ee636OktAXax26wCMKScjxngvhGXhANnSON
 fn8OTC3V2HxVt1mX0rB19sqaE/TGy5WuLONomaLjY9JRXf8MOix97dtwzCaWQR3iyV5qY9S7Ngc
 KBSwJiZaC96dOml
X-Received: by 2002:ac8:7dc6:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-517785ada2amr113397751cf.9.1780583165966; 
 Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51790d965e8sm4420111cf.16.2026.06.04.07.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wV91J-00000008IF6-09MR;
 Thu, 04 Jun 2026 11:26:05 -0300
Date: Thu, 4 Jun 2026 11:26:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
 robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
 steven.price@arm.com, suravee.suthikulpanit@amd.com,
 tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
 will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 24/32] iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260604142605.GY2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
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

On Wed, Jun 03, 2026 at 11:17:56PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size in
> +		for (i = 0; i < npages; i++) {
> +			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
> +				return;

batch_add_pfn_num()

Be mindful that the num is purposfully a u32 so that will need some
attention.

Jason
