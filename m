Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1D9CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5635010E80A;
	Mon,  1 Jun 2026 14:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="DmLEbyVG";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAE510E80A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 14:31:46 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8ccf01ba514so21235306d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780324305; x=1780929105; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
 b=DmLEbyVG8klqnY3tCbL26+vx1w8B+r7H0BL4zbqWrAtQQ3Fj9V5MGHY/Hy9YuWvJlp
 1acCxSHZouomPJGFmZoNY6L120PZoNkn1ONbB90Sb/WqlD1x/WTrTZBxV4Fbz08smQst
 oJ/ctcOCv19EVB6X84jzyfPUnf2zOpKrMg8lZTZhqwaQJTLj1ZGc/HSDlja4gQIXZET7
 5QNneirHed9OYNtj+aXBJW2fRggwSEGcrfmRNuJ4TuOfENhCJ1a7SgGoOSRJKR1nvEaS
 GzaFWQd+5HWmb3qJixd5lSkq0dCQAFbZjRmhc5eu1AfQtf915hjT4WQqNaEQ7NHq5xLx
 Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324305; x=1780929105;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvsjMwD/preuv2Qmrdbeq0ug8WdJ2lDONAxR5Koyc4Q=;
 b=YmEGFlC4GmBBGTUnMr4WoMmepGGwmMEhJitGUzYP/8QYeT1utyko1AflyTGAOgBw7H
 q3+pQgNu0D9idMKx13ukA2oNv6vdIDcz7OoxF7LfI+RW6h6n0oFwp7V9mgpwB3HZUjrd
 BahjYWVErmTnRqAAD8f+fAgYtvae5NKedhsG4XnWsSEVVP0HmhzVDhmHb/iM1x0o14LP
 NaWlWTklo055CgWaim+OdCIymcSG4cCHNCAlawKdmsBrZfB2w6ag4Udwl0c2oKyuAv/r
 Z5i9pbYsvZwZd5Z5u5yGRjVvjrA2wzeh6Cmcev6HYWDGPkzPbMFI/5P+ZyXLtGfn40oX
 BR/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NmQmDW6Y45aw2algLCiNgn2LuAQQYXEjvEpt6qmnB7z/7l7uGB4yiZyDRmD9UnTFsGCPCZ7uR27M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr8UxZdYOhIyF2k99uZgZpKrVuVcjr0wP1gHeVM+Aimfv6l5ZW
 WqqSgVpNspPX9XAxA3u52065sBG2xD5IyjN+AqY1EtntsnwUjbXlq4qtwrVpRsj1FBQ=
X-Gm-Gg: Acq92OGu8vv0WwNCfM2Ke3sPkNdO/B55NxsTzO/21Opoopt9qMoLRY7ojm2xatzUnjf
 r1WZcmG2CyRu4Qb5WyENJq4ffN7KZ3w4iMoFfBgSYSgLTqagku3Kzw1YcHIwXqMRAYz7om4jb4B
 P9mvXN4im3VL5QMtzsAR1muBz55/hdSc779yHnsQnuPpqMmPz03WjDYZhnblNFpRh9tnLNLT15U
 U0jsyv+oXH73T92AzDIu/TybDDcqPj6DnSFOBnVkwVVO3yImNDQjAaqtfenRrWjxkSdiRvS9rWu
 narcw8DpO9+kWnL4TofxANc1SGi8VdfeOm0O49HFIcJhtmZq61b9mhnh0gf6y7k9VWzmnR0lCOm
 xbBr5PJ8Wv/iQVmvkOp0Kr6kzbrYJyslm7PCgwvGFdpACuL5HMVosz5NyqZZQy2TGGGGK0Xf3oq
 9YiF7DV/XwJKUzODe2E8nq+ZXvUSsOiAunUVajIHqvlEhks03IWbvrsh2SQ8dEasSFYdDqI0hlX
 xSRPoQgQrf9ddvF
X-Received: by 2002:a05:6214:2502:b0:8ce:b2e9:a4b9 with SMTP id
 6a1803df08f44-8ceb2e9a80cmr38343386d6.12.1780324305009; 
 Mon, 01 Jun 2026 07:31:45 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea064f97sm94142866d6.13.2026.06.01.07.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:31:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wU3g7-00000001mzs-39uT;
 Mon, 01 Jun 2026 11:31:43 -0300
Date: Mon, 1 Jun 2026 11:31:43 -0300
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
Message-ID: <20260601143143.GZ2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
 <20260601134322.GY2487554@ziepe.ca>
 <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff2a4364-8463-42cb-9a2b-fae1ef64c423@linux.alibaba.com>
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

On Mon, Jun 01, 2026 at 10:14:27PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/6/1 21:43, Jason Gunthorpe 写道:
> > On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > > > +/**
> > > > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > > > + * @domain: IOMMU domain to query
> > > > > + * @iova: IO virtual address to translate
> > > > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > > > + *
> > > > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > > > + * PTE mapping at @iova through @mapped_length.
> > > > > + *
> > > > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > > > + */
> > > > When introducing the new function I would like to fix this 0 error as
> > > > well, it should return PHYS_MAX for error
> > > Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> > > all use a return value of 0 as an invalid state, so 0 is used as the
> > > representation of an invalid state to maintain compatibility.
> > I know, but this bad choice has already caused bugs so if we are
> > changing everything I would prefer we fix it.
> 
> OK, there are a lot of changes in the current commit. This issue will be
> fixed in a subsequent series patch.

If you follow the plan I gave you then introduce the new function
using the new return code and only support it in iommupt, then you can
convert the other drivers to the new function one by one including the
return code.

Jason
