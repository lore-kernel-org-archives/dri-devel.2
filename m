Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B97CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B875510F74D;
	Wed,  3 Jun 2026 01:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="W+0cbSK1";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CEA10F74B
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:17:06 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-915660e5b8eso331234185a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780449425; x=1781054225; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
 b=W+0cbSK1hizcOetseBnKXxlkGL6/hIEPQH+s3dGEmiScNkjshkZXhfIe/Yy79e+pVQ
 bzSZ6JAPr1cj3H4tI5RTe5usq+JNFPQpzhdF/Z6GQyo2sS/c9n7ybvss3hrRfeUHQHel
 Yo5JyNFN8zvpBeZ6qKLFM/HiOqrv8sl/3+tRjM6O1OTsrWYBrP1IWrQlC8bdCvLHvQKb
 HH7q/bpNFLNgRQnTtJQlF4l5Vioz9mb8tZE07TxXua4V9qKwOEIb7VT4KhGMqk0snldL
 adCk1MDJCLFC4HOD6jvPQkM3ySMYxb1wtFdEz6mTSCBvP63xLurt+XoYY9FFJ+8oYEnF
 iaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780449425; x=1781054225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0q9jHEvyutbUqJNds5rNSupxxEZQmy/I4DCyfn2tFo=;
 b=j1b0R7f2lTT16fgIkUy6HTF7046anS87+vbkatvyj9H7JL7oWdmwR0fZJTuwU7rWj5
 PnlfvspiLuDNlOd8ibBSOYXmkJBLDFKJZLkgEAad5ty2w7ygx4WId0Fx32rvwkwjLFEF
 NdpSQPMqOCNSIRmTDDfU5IGTiMq2++z9SNKK5BXpqWVBLmSg2yIRl3xD4DqAVWyvYxZY
 Z+FlAErRj/UsF2RfTFMw28oeXeGnJT0nUGjiuIHg18FqUFT4yuhlbXN9884AR440HG8m
 u56G6xIZdBqQ4LykM5xzkvsJO4BhCI3dMBrj2b9WPT6mQ1EUlB7IG6r29heSOP/DiiRQ
 1Orw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N3xLsJuSCmZJEschhUb9oCVrOuHMTZZigmpv05Fyjx8RR3vl+UyMuYLbj1locv5Vm9VmmjLKE3YU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG3VtFtsTCpWjFh3AyQOeBDQzfpn2VW7LV36iYnYEnKNGDgQ0N
 KEsFtqCSxCp9Qm4URxVyHiXHLs0VtZDPBZ0mpgi2QLc8JkrrEdBV6zf80dF4d88cW8o=
X-Gm-Gg: Acq92OGqYiw3ikeztr6mC/qARIynU/z2lhJVNlY37syQYSCdHBHuKTt85Fe5ezCxTNV
 aDbwlb37acP/Fgi2zMdpHBWGdNcmeY+oFfs6SvVyP6R4WUr1VcamjSDEhJSlPv1tSe0Pywdf7DE
 LaKZHbz4NKYglxzjIXPiRexs6B0wUdM5ejJ2ZfSqVeIGabaokZdBFXHQw/CPGPScFBKLyuPeMaB
 mTvExYKj7OtRhmGZ2a0EorP8YsgRUfnXCBNMLgjKG2EvAd47ODml6pmxNwFZqMYSgaa8lYv36qU
 hujVku2thnIqzEC67vlBwSehnDf9kJSKgYpNYyK12h69UTkQWVz+KwAkw1gKML3gyICmsaayNqD
 f/zvlRfTU5AB2M9BlAcZVoQwzEfAv+bzldZPWxGFugAA1HeeD9/gx6h7QNJ9vklrU9CtJoQKcn6
 oApZWUhxTDCqioaGJx4BCzvbrb43ZfsUaK4P4K9MQd6Nmo1HkUTQ91jA1lNZ1OXslH2Gy4wcsvj
 Jm5B8N63ug1fmf0
X-Received: by 2002:a05:620a:4455:b0:914:c788:761a with SMTP id
 af79cd13be357-9158a84f289mr254481885a.58.1780449425306; 
 Tue, 02 Jun 2026 18:17:05 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm102378285a.8.2026.06.02.18.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:17:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUaEC-00000004yu4-0q6Q;
 Tue, 02 Jun 2026 22:17:04 -0300
Date: Tue, 2 Jun 2026 22:17:04 -0300
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
Subject: Re: [PATCH v2 11/30] iommu/mtk_iommu: implement iova_to_phys_length
Message-ID: <20260603011704.GT2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-12-guanghuifeng@linux.alibaba.com>
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

On Tue, Jun 02, 2026 at 06:46:18PM +0800, Guanghui Feng wrote:
> -	pa = dom->iop->iova_to_phys(dom->iop, iova);
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	pa = dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
> +	if (pa == PHYS_ADDR_MAX)
> +		return PHYS_ADDR_MAX;

???

I guess lots of AI made this right? Please review the AI output for
the little slop things left over..

I saw enough unnecessary hunks, and goofy things like putting the
mapped_len zero in every driver instead of in the core caller.

That said it looks pretty close overall..

Jason
