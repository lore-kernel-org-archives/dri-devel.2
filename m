Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D12F8FA6A
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7657410E88B;
	Tue, 21 Apr 2026 12:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tx0nzBlk";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF3810E88B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:10:06 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c565476d7so9227524c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776773406; x=1777378206; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HpS1oVTR3rIZCafWVa+4FbkfcJKXjhWy8xb1rynP1OU=;
 b=Tx0nzBlksZtSVZ/pL5OBfCfNygFqy2bRnTuE/K1oiKBFhBxlvTKD+mBYgq5Tj7p8OV
 C93qZv5WYKrUZZBKMk/8P150EIM2EtVQRtLXEHtKTxE30IbDC5Y/9IfSm9zDRgdOH2+F
 H5tR20gc3rRFFTW7gsfnk7gaaXUP2NXzJYqy5kbvTktmE1uOMBcKvf1KiAWss9fIB4+h
 s6CwMHOK7g8aaxRvfjzWx+lrM7z/cImSwQ816ux+pnO5c9A/jT6DXLs6b8/tgnlqHJMc
 kmWeNVcU2ZEH8gUzoEMMdVpwa2hYAkd0mv/ywu1PNdV2WYBc/rFWXVgR7PoynOHsC/bC
 37YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776773406; x=1777378206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpS1oVTR3rIZCafWVa+4FbkfcJKXjhWy8xb1rynP1OU=;
 b=RZqojNEcpgAO/Y2HBPIw0RJE48+ey4iPSMO7APN6OvJiXmn/mndGux0mkoSGknMWTl
 iltpKTkRlQBUv+kMd4GLFlR5icZUP2Ni8z9PohmvV0+WYOAKpK//1nxXOURFb74fWIAw
 TrgZQ3aXah3OeJDnuYSniyVTv8W6/nxnE+7kLu3l161fJN1Dg/pLze2UoxQe3aZmqJwE
 1FGUb0s0cTEVmvYGouGXuJkI3qzCnUXNIMweXZb4v+pXsYtFWnAb0DDFAfkQs1wCRFQZ
 l+zOCr9ikTVgvhns9e/Gpi5T3VGNN0j5S/bxSVrtI7DVILuCvDbUq47UCutYDSVc5q3n
 wlCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CW/Q4EKksRmW4vS1FFoiGYpl0TzspinBXFPkHo0QGFILuuyL/MX1Y2qawAFT5pm3RwNJ4M/vPy7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1QcUhxnG/ng7UEM8NB9i98svzpHSngjfineWsr1s19oPc93Sc
 hA9GpF6z00y5jtx/Ut4d9NxYMz6kUsyxcaMSFxFHOwATzpJY8GKUr1tS16qlSP2cGKk=
X-Gm-Gg: AeBDieutdoRkH+F4G+j0VqYajEOP5di2Bz2fB6iZ9oV3lt2ftmTgbHbD7DlkfgCd1hd
 MWam7js0vASDM9FVKNAT57jNAyfOIkF860vCcZq5ylrLWz97oqQEXxsfEI/6M4NdvyslszZd48d
 fvGsBx32XmCeWgrvGstocvVm0VrNd57PT5vXExPJ1o0z4W6Anj57BXgL+qc8lXIXdFlT9ggMtr+
 IXasL5ohi50lo4YnQOGI+I3D7smQbiR9O+XMi77DMC2KucobBwM8QgHDbspW1+CrYLd1vRUuRDa
 iH97njlE7OO9Gj2Q8IuV/5dHgY8hlzPo3r/UB9sQeiPMTnCn+yRKCtvwObB9o9b6TsKIVuMdUwh
 PTKHCQZfB1wQ5KPuhoETkjO+3mkgtENG800A+b6DIaVlE5XA2kV+MW5rnTXT6mTJOejDeK4k4K6
 qPqIPcHuw5JPoZGOXuLkU=
X-Received: by 2002:a05:7022:ff45:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-12c73fae276mr12134183c88.32.1776773406031; 
 Tue, 21 Apr 2026 05:10:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a2ac32sm19260013c88.15.2026.04.21.05.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:10:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wF9vY-00000001ErI-0ePf;
 Tue, 21 Apr 2026 09:10:04 -0300
Date: Tue, 21 Apr 2026 09:10:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260421121004.GA3611611@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
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

On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> >> You reach there when is_swiotlb_force_bounce(dev) is true and
> >> DMA_ATTR_CC_SHARED is set. What am I missing?
> >>
> >
> >So a swiotlb_force_bounce will not use swiotlb bouncing if
> >DMA_ATTR_CC_SHARED is set ? 
> 
> Correct. Bouncing does not make sense in this case, as shared memory is
> already being mapped.

It is a little bit mangled, there are many reasons force_swiotlb can
be set, but we loose them as it flows through - swiotlb_init()
just has a simple SWIOTLB_FORCE

Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
selected for CC reasons. For instance if you have the swiotlb force
command line parameter I would still expect it bounce shared memory.

Arguably I think this arch flow is misdesigned, the
is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
the correct API to check if the device can DMA to the presented
address, and it will trigger swiotlb_map() just the same without
creating this gap.

Jason
