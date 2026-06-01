Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1311CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11565113371;
	Mon,  1 Jun 2026 13:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="GikXUdgM";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0A113371
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:43:25 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8ce9df31840so11369226d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780321404; x=1780926204; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
 b=GikXUdgMRM1cQAOpFHJEFrmia0m7JqCV6srxb8v30g8hyo3EOQlj5/obzxT8n0uFQk
 pkvAViGnIwHJnS4mbPJRPfh4PKFx8rPOw55ub+Igf98o9YTLM5HuZ8A4ZdtYi2GEIcxM
 nsKwAFrEYuTg9v1eMj93hhcpDpvJ4EgY3fs7/kKrorYivXWqrZQe29+oHMv3IjfFQnEr
 6bqkh+F1BtpYm4XBUlv3tECQRndBp89vhLPrHj6BZS/dnQHWFCsuBgr3WEWBVsqToqee
 WbbkcrvkWxqgbwLN+nRi3KsoklygDsBhzwZqIECjLTaxwDpOTx34xP06/VDf0sFENkSl
 EdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780321404; x=1780926204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
 b=APWM66TRfxRAmMlIjeKAE3Q6CjeMIQB/GYDb4QBrvsNdaoxb8l8IMDeHZPKbNHcHhF
 vt/0/XEGOnxu9ud3EKWaOrB109ofItFc2CnfIMGXYHYqHZZDIGSluWmm8jJBZC0abMqV
 rA11rHKS40pXekDI7+uE/2h6Ky6vSbZtGN9xqtNqgL5iaYRBsON+mrqEd3nv8dyLCrzK
 Udm903zOaYlqwAcAskPMOSBzwQCS9nRl9ShTobLw25WhxoiFTzCiiJqHC8ex7iSMaRyX
 44RIGswUUX2tHSdO4vvemJJCz5KhtoH4OpOCy37OIOQbJ3sWsLxYlCFzRe0LUnM/B85U
 H0hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JlyHhOwAgmhJbvWggG2VoIcKLlCmr0gFry04m1VOh15kwb252XImVzF2MmEZET0N4Dp5YIxCvi6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEqqYSMVDawxZaFIiN5luEfk9f4Yt6OvP99b9dGaI7WOHDON1A
 as3Td9meGZ2Y5uUlrytGBK07jl83P/1dSHoT/XjrW97U5FXbWEsF4iADoFOpAz1j1W8=
X-Gm-Gg: Acq92OGyol0mh4eVsU8anl4RAA5pHEuuYekpEQThUmcsTJHgR/EMFLt3tpmzgEDevJu
 2RczU9ru8L9TQly2HcokpsnwpJsH8flYscqzMwzQha4zgXw5mjrFoy2Hi6Q0JFkDxvlQ4wlUidF
 8URL1mL4tfBNvs4qvUdjoVmdJR3Kd6ETY1wB3ucf7XRXfWM90Txi1C60qcbhSe4UBeIjNB7S+10
 YURq65jt0Drz8lpBIHA69keroOdmQV7CMDJ5Ivb+ooax9495So+sfuHt32TejLtdyAo33ZYQF4N
 ruDGKUq97Z3W1EGpwLXDt1CjFUaWuWwGQxvTAkTpsiARieacL7cGq7Gw0HU9UE03XS4BHMHJ6pT
 U1n8GilzTcXv1iK+b+luAqDIcf4m4cYmcEr9Ytb9KmACdxmusEjJwtfo/NgdVbiRhtk+B9aAbLf
 oJuSDA/buQ6fdJWX1Nrt/pNvEFZCvXSKAldQhr/sZ3HR3cZyTuPEqzBJXcDydHEY9pUjo3g1q9X
 Ornk2Av8fudPj4/Mh5j+FDUNyo=
X-Received: by 2002:a05:6214:2e41:b0:8cb:fd76:e904 with SMTP id
 6a1803df08f44-8ccefd62159mr193200966d6.17.1780321404292; 
 Mon, 01 Jun 2026 06:43:24 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea042373sm94107096d6.9.2026.06.01.06.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU2vK-00000001iEk-2KA6;
 Mon, 01 Jun 2026 10:43:22 -0300
Date: Mon, 1 Jun 2026 10:43:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org, xlpang@linux.alibaba.com,
 oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
 wei.guo.simon@linux.alibaba.com,
 alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260601134322.GY2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
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

On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > +/**
> > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > + * @domain: IOMMU domain to query
> > > + * @iova: IO virtual address to translate
> > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > + *
> > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > + * PTE mapping at @iova through @mapped_length.
> > > + *
> > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > + */
> > When introducing the new function I would like to fix this 0 error as
> > well, it should return PHYS_MAX for error
> 
> Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> all use a return value of 0 as an invalid state, so 0 is used as the
> representation of an invalid state to maintain compatibility.

I know, but this bad choice has already caused bugs so if we are
changing everything I would prefer we fix it.

> > > +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> > > +				       dma_addr_t iova,
> > > +				       size_t *mapped_length)
> > >   {
> > > +	if (mapped_length)
> > > +		*mapped_length = 0;
> > > +
> > >   	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> > >   		return iova;
> > >   	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> > >   		return 0;
> > Any domain that doesn't have an op should fail, blocked is one example
> 
> In accordance with the implementation of iommu_iova_to_phys, it returns a
> phy value of 0 in invalid states.

Detect the invalid states by looking at ops not domain->type

> > I suggest you approach the patch plan a little differently, the first
> > patches should implement the new function and an iommput
> > implementation
> > 
> > Arrange things so the normal iova_to_phys calls the new function if it
> > is available and discards the length.
> > 
> > Then convert callers that can take advantage of it. Have the fallback
> > path also compute the length by iterating internally.
> > 
> > Finally one patch per driver implementing the new op, this could even
> > be a second series.
> > 
> > Don't remove iova_to_phys(), it is fine for things that don't need the
> > length.
> 
> Does this mean retaining the iommu_iova_to_phys implementation but
> implementing it through domain->ops->iova_to_phys_length (mapped_length is
> NULL)?

Yes

Jason
