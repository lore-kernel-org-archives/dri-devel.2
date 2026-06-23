Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB261CDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF71810ED5C;
	Tue, 23 Jun 2026 22:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlZZhXZ4";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419D010E233
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:53:58 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so2387885e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782255236; x=1782860036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
 b=AlZZhXZ40vhFmuecRhiDuiMiQVfxcYaZidC34hW6t0qrkohNRYH8PioK+YON0v58FE
 z7nj6cIDcQ197QWJWGscO+GVRpNBf6ZWBfhUsQ6lhAifphvZLmh9Z1mE1CmWXp4n4kfD
 F4AV0jSFkq3q3ZrniPz8QpCrCfyLETgYg86yxNY2IkapeZgjvfdMoZmwjOjRd27IPVMQ
 LoiNh8nsdzSklMCohyNadW/LR0oT1cvXYFT0IJSIiHxj2E2YLBBJpcE5ZeNM5Z+MlpaC
 AYyuoryBfEdZA4X+78U9/rizrW5lE757Lzl+hneNWToHbcUBIvpXbYoM4RwbtTnZ0Fxj
 IxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782255236; x=1782860036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kl7+6G6mEg9f9+ckJBvnEW32MGFOl9Otf3/P0x9y5MY=;
 b=LQKwehxm7taU6oSJQlkF/WdMvMn6TVCBV/nFlLuFaAwAPdytaQG4R6s2ifnEIL2Ypr
 eZ4ks/7xKTBvpFs6XN4WtMC8Ma7tIu1w+ZZC7BixAY2gNgPsr108gwfcNzCr5n3LlCIz
 KwrD9ZLk+amKrLLTapG1a7EIUNSIeuBHHuHuzhaDtPS9TJFjYYxop4s5E1NdktRyBrYK
 wGJVDf3Gugnjx50GxjwGv8wC5y7GiNwmIpLOUqMtwKyu18SlaDOUVnFvlx5A6YI6cmKr
 x5HEXODPIA7/iLd//K8lvATo2EA97bRSYHzTKYVuP2zaBGvj0a5MzyoSwA/L6wF+l+p7
 BNIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CHx5GGxUjSsi/1hulc6B8vBTv2okOeL55Uwzu96GDUOXVhl+0aSuOMSMyJeDqKiG+LGPqgN424ik=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOUCsEs+bJJLpgkitBlgLnKu1629u5Kz6LZc2Xt6YlbQomHbpn
 kLq4e3JtodAfYu1tclR56hQfPqNC8FpLrhW9HCSBxnBZ2lRo0hdbFeKs
X-Gm-Gg: AfdE7cmsMiHCU86q7U3tdjGdEMIVJ4Y5YZpgwqSznXP85+zXMiPHXWm1utudmjmKfJj
 qJPrxiog5Qg+oinrwac+FQat1etj7sPYbvcfkyxxfE0U7kkRO7cbMKOQrU/LMhbT/IdazRrWksN
 G52jiFlL+8bOwuC2BkFJdR6UsjB4qyg7dA/lFtzMv7/S7XhcgzN+4AT0km1Be0hDIAqnbMOcsBn
 BmcU+z/1/Ww+QWoO//k1kQu+ZNmgto871Q/BThjd8mXdBSL7dPDfic3ibSPPnJ+UVVvyYQZmUXD
 w82W3P5potniOt2buT60ggLTsn6USBElJ+D4KZtNK+Qu6ore6sTj6Gj9UdNkC9CA5F/CnnN7Z+a
 iXPv6mUyhkJdlNyrnwzKkfKC4tlIUFC8bq2irviZFmr9ZMWLyysQpdCMQdAykFu3dhamijUK3Ny
 hExpTI6tyMQD91GpiblUH8G+gTSDhWT1eoppyLyexZr6gLmB2XmQ==
X-Received: by 2002:a05:600c:699b:b0:492:6113:d4fc with SMTP id
 5b1f17b1804b1-4926113d5camr183865e9.17.1782255236221; 
 Tue, 23 Jun 2026 15:53:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm583674705e9.0.2026.06.23.15.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 15:53:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 23:53:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260623235350.6540eaa2@pumpkin>
In-Reply-To: <ajryxMaT5evDUxaq@google.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 23 Jun 2026 20:55:32 +0000
Pranjal Shrivastava <praan@google.com> wrote:

> On Tue, Jun 23, 2026 at 09:44:46AM +0100, David Laight wrote:
> 
> Hi David,
> 
> > On Tue, 23 Jun 2026 01:54:59 +0000
> > David Hu <xuehaohu@google.com> wrote:
> >   
> > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > first entry, resulting in non-page-aligned DMA addresses for all
> > > subsequent entries.  
> > 
> > There is a separate issue of whether this code is even needed at all.
> > Where can transfers over 2G (never mind 4G) actually come from.
> > 
> > The read, write and similar system calls limit transfers to INT_MAX
> > (even on 64bit) and a lot of driver code will need fixing it longer
> > lengths are allowed though.
> > io_uring better enforce the same limits.
> > So the transfers can come directly from userspace.
> > 
> > Not only that but you also need a single physically contiguous buffer.
> > Good luck allocating that!
> > 
> > Now maybe there are some peer-to-peer places where the large buffer
> > is device memory, but they will be unusual and probably need
> > special treatment anyway.
> >   
> 
> I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
> (~2GB), and io_uring has its limits, but I'm a little confused by the
> push to enforce these limits here in the SGL code?
> 
> File I/O seems to be only one side of the picture. In my view, this fix
> is necessary and certainly has a use-case:
> 
> For example, the RDMA subsystem has the capability to import dmabufs [1],
> which gives rise to use cases for dmabuf beyond standard file ops 
> (via VFS/io_uring). 
> 
> In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
> HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
> infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
> exporters to frequently move huge blocks of data via P2PDMA.

Ok, that explains where big buffers can come from.
I just wasn't sure.

> If we restrict incoming dmabuf transfers to fit within VFS-centric 
> limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> it to manage a significantly higher number of memory registrations. By 
> cleanly splitting these massive contiguous device buffers into 
> page-aligned SGL entries, we directly improve the efficiency of P2P 
> transfers and memory registration.

But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
a lot of io) when the quotient is always 1.
Splitting into 2G chunks is a lot cheaper.

> Since this change doesn't seem to have a negative impact on standard file
> I/O or break existing VFS constraints, I'm curious why we shouldn't 
> support splitting these >4GB P2P transfers? Am I missing something?

I was only wondering whether it was needed...
It does bring up the question of why the >4GB transfers even need splitting.
But that is another question.

If you want to split large transfers into 4G-PAGE_SIZE blocks
it is probably worth having a quick test that returns 1 for 'small' buffers.

	David

> 
> Thanks,
> Praan
> 
> [1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
> [2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
> [3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
> 

