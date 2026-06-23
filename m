Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE07CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DA310ECB6;
	Tue, 23 Jun 2026 20:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fv87oPOK";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F2A10ECB6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:55:47 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c6b7bd4e8dso13965ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782248147; x=1782852947;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
 b=fv87oPOKZWrsaMi3jcyEHW9gbDge6nJIXL3FxAgbWb2aOPCNnAA275Ke5fkb8KumVF
 6EzYgD2WZt63YGyhUYRZ+uUqHguP+/1V28kWLZ0fkk/0pUqVsZzIYvgRdz3oQ5uexjbD
 zsX76bSqhdM17ief2bLSGGS91jHLHhtHcaLSKGs+d0KmlPVv7c/TdLKtybpGfqn4Cq69
 P439t47Eng8rYCfYnmwaRMUng49BPHnRbkgSRaPr+tdCdq4r5532P6LsKGaGIx9jY0BP
 CWMsojwSAqQ6iOVQ/xTh+whGzmW9Xk/JO+jLX2OSbfm+wu4AuKHCVvt5ALlkJ3xQV+ww
 ZX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782248147; x=1782852947;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tDNBIwJuw+D53Ki5EAv9tDfTFhNZX4Fj7K/EJveLoSA=;
 b=GLCWdbIOGyQQZwLoIsFLMBjHiRChXWu9y0C//FZiZVnUE+VcUQfLyv+ia3QSI5Pn5m
 +MRTgKi+6Qxx2smDNE/0ouUAD/gtloTk/p03OSUTY+TuVfZ5JMsyqlq5llfY9wLv3wNe
 7Eyz3bP3qys/u9OrYCKTJDvVu2ktlcnFktB0oWes4fmRKPCL2SdImG/UTUYM8nBvVQP6
 8Ohj8GSSVEJg/c1N0bd6zH20kDbndfGAzyD1STKzSCpJ/dMeyVomTgu2I6pSJ5FLwy6r
 KbN32DCTrAzlAqCH05yXoa5l8BkYBmlNXL5WEyIIfEWov/+uHnaLoFA9JMAqZOol8PRs
 o9Pw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGQPE7HoKOxhgssZzMsR5KXFZPyDYukAQkej2zsiECmY5nsXHqqbeXJtQg6lEkETMT0GF+EXaHNFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCXFlHvGoanyRWbsu4aezK2ms5t1Vfvxxboko/HgIlhUdch3E+
 Er6SbjqxeU3rSm6GL1C6GvBxmFL3EvyBKH2aPTIwlUAYTP0jYAIuFTrMmU3zMKwhyg==
X-Gm-Gg: AfdE7cmfOIduEpukFB0MKSDO+rp93G4SXqWr8YwU2XtWATh0MIhtar2I+Mhhhq7ymnf
 CaPCDd40M6RCMQAV4xsZFzuDhIeSbny8cM/Dw0cOIhOluppSGfXjD7xQcJM9TDGM718880VDCy/
 zklnfRoZqvrCmBxE8dZvay4feRMpbni82QQsj4d10Z1eZBwO+tdX7p1IiRzN/LTHcaGi8FPHBdm
 UGmCc3xZ8L1bYQN/qX1exydUncp9OMxguSGojytdX2dZwIU3M0kzCEj3HmhBJFx7E3dZqjIX9zy
 xNFEm8QXiCak2eoyy3QvM/7ZWMQt4WhgZYLefp/la9w0PjKdElgtZn66YAszPTuDWkdTod32tL2
 YCFLSEBCmLLyVHTtYlQBvRsOawlHMZhmCKyIK5t5QkiGcQYCAe/f/mRWOLDGt9qyzYS71u7UesH
 NkqlqN70ec+hTTjcyDuB2rjPLvl7VTtO1fWUGFsINmvftEp2P3Ag==
X-Received: by 2002:a17:902:f689:b0:2bf:3741:5b76 with SMTP id
 d9443c01a7336-2c7e26b7724mr203255ad.3.1782248140960; 
 Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d1b0fsm54433b3a.28.2026.06.23.13.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:55:40 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:55:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Hu <xuehaohu@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 jmoroni@google.com, kpberry@google.com, chriscli@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <ajryxMaT5evDUxaq@google.com>
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

Hi David,

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
> 
> The read, write and similar system calls limit transfers to INT_MAX
> (even on 64bit) and a lot of driver code will need fixing it longer
> lengths are allowed though.
> io_uring better enforce the same limits.
> So the transfers can come directly from userspace.
> 
> Not only that but you also need a single physically contiguous buffer.
> Good luck allocating that!
> 
> Now maybe there are some peer-to-peer places where the large buffer
> is device memory, but they will be unusual and probably need
> special treatment anyway.
> 

I agree that traditional VFS read/write face the MAX_RW_COUNT limit 
(~2GB), and io_uring has its limits, but I'm a little confused by the
push to enforce these limits here in the SGL code?

File I/O seems to be only one side of the picture. In my view, this fix
is necessary and certainly has a use-case:

For example, the RDMA subsystem has the capability to import dmabufs [1],
which gives rise to use cases for dmabuf beyond standard file ops 
(via VFS/io_uring). 

In these scenarios, GPU HBM can be exported as dmabufs. With recent GPUs,
HBM capacity can be in the order of hundreds of GBs [2]. RDMA can employ
infrastructure like the vfio-dmabuf-exporter [3] or similar dmabuf 
exporters to frequently move huge blocks of data via P2PDMA.

If we restrict incoming dmabuf transfers to fit within VFS-centric 
limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
it to manage a significantly higher number of memory registrations. By 
cleanly splitting these massive contiguous device buffers into 
page-aligned SGL entries, we directly improve the efficiency of P2P 
transfers and memory registration.

Since this change doesn't seem to have a negative impact on standard file
I/O or break existing VFS constraints, I'm curious why we shouldn't 
support splitting these >4GB P2P transfers? Am I missing something?

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/infiniband/core/umem_dmabuf.c#L174 
[2] https://nvdam.widen.net/s/fdvdqvfvj2/hopper-h200-nvl-product-brief (Table 2-2)
[3] https://elixir.bootlin.com/linux/v7.1.1/source/drivers/vfio/pci/vfio_pci_dmabuf.c#L297
