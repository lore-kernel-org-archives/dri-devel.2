Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B235ACD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 23:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847A1112C92;
	Sun, 31 May 2026 23:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="bViyywUs";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BD7112C92
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 23:54:24 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-517583cb07aso1421841cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780271663; x=1780876463; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
 b=bViyywUsq4Fjuv69O/NfZqF4VvPrCVSH07B7sIL2kmr5wgmu6i9Z7C8avh3tFbZVfm
 Q2Zud4Wg0nvsjcMfL2EmsTkjoB18TMRusON8kvnSHzD3Vv0ode7MnZn4iW+wk6TxEuMX
 Oqtn7Pfd2KH4V8ZzoufKRTmia349pqaKZ7Vk7utfazVUebx/k9g2xzxo/avIWBeg/CM1
 woYUVPrUAcNU/bxB6mDRHTc+lxGBIwREFmgB3wl6UWATJ8lZcxPZ8KdERESf1QYFb7OV
 15W4yjFijji32YCOkXTwfSXkH0GKQaYCbNV9xh2clKGPqGI4K8MlA+BABYb+VoZ03cK9
 LIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780271663; x=1780876463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrKWJ1NykkXFbiCeCeA4esCrNiqvK/wMlJLwP88BqrM=;
 b=jtDtvppI5Fw97mfMYMXgVaAG50Ue0XgMv+INZsryzvuEZhOQM9FKtS8ANtWBizArl+
 cEjmPlXHyejMTogm62EqS4tbrvDYoEIBPwW/yhHhfJKa3+UgECiHObyZMhefZFbkzjBK
 HIItHNfGnZjTZZLLdmlj/RsoJ7U9Fs1eVpr2pJMogpCbiyZfPEZ7UzIhht2TikxcTqpb
 zCb/83gmfEnVsL/q3ozzBU22XPwLUAZA+7HQ13TeON7KNrC3DW1o+Io+FT5Qi796gBEA
 wsW1OSqH2lB+eoDr7M2LtGMLX/uaWa8oalqb8E/B5zqehqaG7YZGoQSH2Q7WBlBjg+uz
 L3Gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gEnNBGFR35YcnGvfg1xNtJElKD210ZGKdlOdLTXz58HuYukst5pcGCWpZ81Q3MO8x0wx8lOjlAwg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4ka7mEz5OApsrcRL1it5RwiBsZpl8OiVjviOMqnrrFSFKHK9C
 F9/a/vnkvHj+2+mzJzmSAkzz+TdWyHjBMDUgFaUATgcKxRN8uzhP+TYLRnRGSlZavLg=
X-Gm-Gg: Acq92OHwAMh7lBy+7Ba5t9LpZaccf7wdkJgw/ATFAX5Wh8ia6KMsFyoulHnAMA76xi1
 hR3JgYCE7ewH/NUvFJyGTHBuvZqzQ9mi3as/bu3BFHZ3uB9TQft9Y+oiYGBUxi4VYHjoKftQsDv
 ighak6MrqUaAV//phXPhRFYEvqMSt76pzpckgISPCcnfQjBaDzLavC8m2zRk31reF0RPe71behV
 Khso2BpUacJJCA3eS7DIzKD30Fkct+E1TNnSOPulmprRil/NRpIHkh98AzM12ko9n36Oq5L0j8O
 0N+HL8Lf8eau/npfb/9ZAqs7ZU7FELSE1sBNASd7QdtBC9VXChGalANKNQ+qPzKQsweN9VBbSgv
 IGIEWwxoOKQS19J3jxSW0vbIrBLdbyuwo+adFgbaIs4EJ8KWG6N/Bd9EQo7NpMfTJl6O13XO5ic
 mvRkcwZrWHZ0mcFNkiMcNO1L/1yaiaGWZsyVhjrZNx2ZvqiB5l344jTwhlXBEWlWEYlzvK8y4tp
 J8kdJVJMA0/dPCBepWoZnhEQz0=
X-Received: by 2002:a05:622a:646:b0:516:d943:175e with SMTP id
 d75a77b69052e-5173a77ad04mr129763061cf.25.1780271663054; 
 Sun, 31 May 2026 16:54:23 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1ca972sm78588116d6.30.2026.05.31.16.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 16:54:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wTpz3-00000001Lqf-3yz5;
 Sun, 31 May 2026 20:54:21 -0300
Date: Sun, 31 May 2026 20:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
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
 wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260531235421.GW2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
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

On Sun, May 31, 2026 at 05:36:31PM +0800, Guanghui Feng wrote:
> @@ -159,45 +164,51 @@ static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
>  	case PT_ENTRY_TABLE:
>  		return pt_descend(&pts, arg, descend_fn);
>  	case PT_ENTRY_OA:
> -		*res = pt_entry_oa_exact(&pts);
> +		data->phys = pt_entry_oa_exact(&pts);
> +		data->length = BIT(pt_entry_oa_lg2sz(&pts));

BIT is the wrong function, it uses the wrong type. log2_to_int() is
type'd properly

This also needs to keep walking and accumulating length for
consecutive PTEs until it reaches a non-contiguity.

The other drivers don't need to have that complexity.

Jason
