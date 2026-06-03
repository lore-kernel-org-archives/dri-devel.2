Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FDCD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5C510F738;
	Wed,  3 Jun 2026 01:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="UTWxA2Xe";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7932E10F737
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:11:38 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9154ca1aa1dso23196785a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780449097; x=1781053897; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
 b=UTWxA2XeKN0sV88pNRJ6bmcl3aHgugDE0OmJVFsspOTCXJJi8we3ZOLmknTtPMEezV
 jsmf+JrRwFMFjojhcBxU1dU+cUrpMBDrlrxDh/jbKpdsiaVm49UK6U32AZvVCz+H5zm3
 wnLaMb530uNgs8QaiNRSUIPC/m/ArO50PPHWUE8A7cRvhmcrw0Sf73NBGjyZ/fVjgsH/
 BLmsz2SJw9mTl7r974ATESmwRZmos9UUkULx60cPDTHJLzXlHo0dXbaSnpHrXViROVta
 X83KoqHTWEOTtMN8FgU8WEl4DAkcOOvsCHYy82NIXVEOiVpLYpGfqwxQiii6zJeGuXTy
 +Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780449097; x=1781053897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkcXxIwae3ZkBqRFobExjF5BmBij71a6Agx7B+x/coo=;
 b=MJ2vrgSFpXNbTbp8BmNP+IW22emFToFkQ+dWCzDrUjafzFiLdosLMORnZH6QQltUQp
 99bD1Iy0b9+J1LYXLc3pxbY3lOUt6cUgGcXMNW+n8nI08h5A1e/0hhdMKz2ajVu48868
 XRgasgvebWbmK2oGwDcvYkbEPZqNWp6UwQiWtJ4SW4qO6NIsY8XbTrRco3W9XXRDNgng
 CmTEeHDM3sLKndQFlA0odwm88tbru6njBiX4x2NS7dZxTz3XQ69/EH9m0u94zqNhAFtt
 hjrIs2CXa1/JPyKofD9EHQBTb/bC+JBeWRHtY9YbSTKHPyKqpbtyC3RdLV4TtoTcBvmv
 MR9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GFrJouhiOLzWROR4ebytKSR8i3uDTYdLnLeuK2zepVsJ/HcBLe3lrl7DGQAWGFLsky0JD17OMijA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIL0Zo3f1pMRo1djB/zvbq0yPpsdXurK8pZpuagAEifWpzlsYI
 +Oyq51pYWS8/c70ho9cD7nNn9Ek/oQb8YM2pxJfTRQjQn88fFVGaNHKnAJjIVBUcHao=
X-Gm-Gg: Acq92OHFtnOPwFY2DTeOfAfIUjafOFSWlGsDwv3TuxAFBSKi5ScyxbhYrfKKtudtriE
 PcfxEoCsGjgp8LwdpR8fGjkUvFatyy+Ntd4RoHveC4+HOb2O7quEDnrtDjS7IZYRnK10DthAEGY
 F8PHukZXORurzR1QFq6akuoTDDGt/7OED32EfVfRLYRylfI7wL52WAgkdwVZ77by2vvEcgoMXIG
 hWB7+OmdpdprmO2C6QHRtOI+WMx3H0F8DDxKRfX6eG2CSePCcjcM1VJXBbjVFya7Q+F3nG72r4q
 fpwJ8OShGPmWaHMO914uM73nSduUZfObwBzFvu1fO16mQ0htOsaBDcPeHkBRxCBQrn3HtnoKxyT
 zONW7hCCMifui4YWgQ6PliBHG0WfG1216RuFthuotT2/R7lzgVe3AfNNp6oeaOYLoJer3pL9cDU
 NlTyoLUoPSO1X21Zb7se1dFqL+illiKG4D8G/h9sdZoqXIzV8WTacNCpeEbmyDpOueXuUdNfLGq
 99dDOqYN0GdfvZKaF74M/EQvAc=
X-Received: by 2002:a05:620a:31a9:b0:911:c5c0:d5f2 with SMTP id
 af79cd13be357-9158b5cbe4dmr170236985a.1.1780449097421; 
 Tue, 02 Jun 2026 18:11:37 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fb2sm107640685a.5.2026.06.02.18.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:11:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUa8u-00000004yOx-1sfF;
 Tue, 02 Jun 2026 22:11:36 -0300
Date: Tue, 2 Jun 2026 22:11:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org,
 robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
 steven.price@arm.com, suravee.suthikulpanit@amd.com,
 tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
 will@kernel.org, xlpang@linux.alibaba.com,
 alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 05/30] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260603011136.GR2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
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

On Tue, Jun 02, 2026 at 06:46:12PM +0800, Guanghui Feng wrote:
> +static __always_inline int __do_iova_to_phys_length(struct pt_range *range,
> +					       void *arg, unsigned int level,
> +					       struct pt_table_p *table,
> +					       pt_level_fn_t descend_fn)
>  {
>  	struct pt_state pts = pt_init(range, level, table);
> -	pt_oaddr_t *res = arg;
> +	struct iova_to_phys_length_data *data = arg;
>  
>  	switch (pt_load_single_entry(&pts)) {
>  	case PT_ENTRY_EMPTY:
> @@ -159,45 +164,53 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> -		return 0;
> +		break;
>  	}
> -	return -ENOENT;
> +
> +	data->phys = pt_entry_oa_exact(&pts);
> +	data->length = log2_to_int(pt_entry_oa_lg2sz(&pts));

I really do want this to accumulate the contiguous length if we are
changing things like this.

As I said before only iommufd needs to do this, the other drivers
don't have to, but the wrapper should take care to give a consistent
result so we don't have callers open coding another inefficient loop
on top.

vfio and iommufd should call it exactly once and then move on.

Jason
