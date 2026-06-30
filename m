Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF325C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B10310EC55;
	Tue, 30 Jun 2026 12:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="O/HC9Mz/";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A6B10EC55
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:38:52 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ef7b7651ecso6644616d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1782823131; x=1783427931; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
 b=O/HC9Mz/Fk/ntew1+nrw1K4CAcKZMaQ+Wq49eAAJ6Xg9SML3MT8lqXpBPYQoYbzpuF
 qksoRrgmg+8lXJoH/u/HDhEeVpgWk5MchaY3D/60Mq1is+DRAOwK9fX3hoPecwl3nefl
 sOe3KRoRF8/30cMJuYqAA0T2Bs285GPXFzvfvVOGXO1UwtDUeJu9Subh4MSmBgOFlvO4
 1I6Y1rx0YHeWpn4CCEHZ/f24wp1AZ2xvMo2E+ffc+gXAZuetfxfuUGubgI4KW0rvyW8/
 YHhz2lyt4rDVTQj856vGdfjxNTVQi7ywv5H0f2u7fHmHiaIhg3Lq7T3Lh1ZOSZJyAgnV
 1k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823131; x=1783427931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usbOUHulcGkq5pslDcl5tYYUADM4pc66+J0xE33qcCE=;
 b=JvjZBCk2fufkE5TdwHQLAixaj3jsEC6nbqZKPCdlTn/szzj577Xfz7NNCsTIH3VwQX
 9zpj7LQ6HnOdySYChdvOwzAx5ECgIDBsiNR8w9LH0SvXqkQ4vDrgBw+lL09O65g0/+Fy
 DNBr9Yk+c9DPJn+nCWMQrYwNOCzChp/0czN9yMcAgAboKklhjREQS/Zz2B7Ye0zK27GF
 TQm6z3L1l1WAcOUxviIcjnEoMdHePbIeViQHAmyzoTGif32YtANTE+VlNjmL2CajnDwy
 W9L5hI294oTt18gNWm9JF4Qja8W/IGhECz5NV7wakS1em4W9ukyqmO2PhIoHr2cZXoMg
 GoLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMGbZMd+kCuT+FNcko1oAgPuI+h6XTgNypdu92X14LVXwdCkfCn7SOINyQM4/k7vyCuTAhM1LPrCk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGI0HcTQZgJg8bOVXtASVQAAH8KvZTBOlyOLMh6Bz6eMtTwUSh
 Zkbv6mrwU6hJc6DStp6e1x1+8U8ArPBKjqH55ISzDreMSf/D8BOSmNsb9wkCyN4zolQ=
X-Gm-Gg: AfdE7ckWV8Q6wt+Dh/yGLXIC0E/ggb4QOi7gObCBvfAm+y9i3CAP+IIvCr5lUOrHYJU
 A9kNPBxyNreXx9t7T3dhY6yGoZCjJKu+ZwI7Y+4wBRZbQfm3ikyiz0CT4NxtOHihUztp3AauaCM
 AHBV0RI44/iHW716zFaNE1YKsyHQykD1edLosiIl+kmtMHQnvltAKJ0ruEdK1OQM7zvypjv0Ymu
 6GeRNxMeu4/GULBtPKC2zC7nJU/nKXdR2LfqJPfmgpusv+S2utm7cqFRj6hMFS6DPbsnTmfD5wn
 BIx8mLIX70eF4Gp0AafQZSdo8em7BbpKW8lvTgaJpZuI+ehDzaCc+1hq8jMXtGyz7YKHxzaxWrD
 +woNJXSrCFDe+eaLGM4IopvkjFZ5x6YkhU3zoITfFYZwVfSWNTf0LPr8iFjDUMYsEuF2vNtw+nf
 xXOQNzZQRMG+m0NNOQYc+sjdMRFJWISYH2ggRcn3qf2aGpFiC9l3wdCpq0Th4YKg9qACk=
X-Received: by 2002:a05:6214:448e:b0:8db:480e:6944 with SMTP id
 6a1803df08f44-8f2549e5762mr17241226d6.26.1782823130931; 
 Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a7558676sm22067246d6.40.2026.06.30.05.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:38:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1weXjl-00000001qLK-2mow;
 Tue, 30 Jun 2026 09:38:49 -0300
Date: Tue, 30 Jun 2026 09:38:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, praan@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630123849.GC7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623094446.4a8fc2ed@pumpkin>
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

On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> On Tue, 23 Jun 2026 01:54:59 +0000
> David Hu <xuehaohu@google.com> wrote:
> 
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
> 
> There is a separate issue of whether this code is even needed at all.
> Where can transfers over 2G (never mind 4G) actually come from.

This is DMABUF land, you really can alocate DMABUFS of huge amounts of
physical memory, VFIO does this reliably and trivially for example. It
wouldn't come from the physical allocator.

So yes, these scenarios need to work in this code.

Jason
