Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FE2FDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB7610E0AB;
	Thu, 23 Apr 2026 22:46:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="NemNG8R8";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D47610E0AB
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:46:28 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8d933da14f0so672821185a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776984387; x=1777589187; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
 b=NemNG8R8v3FePFkWiHvfImyhlqiUK7cHzC8uxhbOUIRoyua/EMbagGwy5oX0WqmBYI
 QEMNZhWVVfPkoN9T9kPifF1v2TjyDN7SPXzqdomXRnNOjPiN20GvzidszQa+4SsHURw0
 HBxdbQDxS1XFbfAkhwmy6vRvLWpSGI7GqF9y4LGRK+hHkrEcISJtpyOJr/fj8pAkX2Om
 KrA3KoZwPxlOfGO0roFHvAPdHDSWLYGN2JclpmBDn7p8IAuAkGqvXWh7lFvqbxkTi5bk
 feR7bENRJYvFPz44AnCOvKxyapN1bGlKTb1g6fiB3/qQp6i9a6Ra+zRH6Lf4/M9w4XI2
 RKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776984387; x=1777589187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOyCcpWY9ETk6/DQ/Zzf9IsC2/j7viPfylDYdsbXpuw=;
 b=r8V1gy5PlYYYta/BAd96Joip1nA2u0c2ZxqAIo99uQMWlILbF7W0r0qVeCtpxSxAFS
 sKUU75+he91wKIXERWh6kk76YFE67QAZiRJ2Q1at+PCoxavjJoMSo/w/HwWi3hnshdBb
 XL02wLUTplxQio7SWyCD7KAOuMrzo5Bi3dkRjCa4g6bw42aRUssB+4/c50KW7+5T/ufg
 4cqcvY83evEpf+jgmNT1QRQ2XiUQcnuD/sScwD7vWCuKAMARGnwXagaixNfJOsATtC6a
 XzpJz8yYu+nyXGjybZkmsB3spssLwNlyf73WEpiSNTgS3O1xf1mgfU+p6lavlpQNIBva
 d7/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DWBSFpm6SqrWuftJvnonmDKZqzfyqT5WBcL9aGwO2TB6bIY/sTXcJnhZa77EX/ggZsSSCz4ua8wY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxB/BW7eeAkt7f7vP5h+I6w1Gcqmv5drVX5viBNOV2M8DHMdIKQ
 3YFetNk1xwEPcGHObLNZN3upXB70UFJmR93qVnCBAz4IIvPQG3jh3rk5FHDnPSVAjEo=
X-Gm-Gg: AeBDies+HlKKxlAPOkvPP1u6OI9WJdlVKZnQiuQ5yYvw0Gr82YsqA/wCHA2YZUNfwXA
 b8sqs9E4XMMu1ymaR5A2K9+qV85AxwsMeeIgVL1JfQjkuPvRhT50RWuuMWPslCea+V3SM0WpEC5
 5esGjxZTzCVIBZMnFNvss2aourDM4ytRLYiRpIxkzU+55wxIlG508hvPHeN2NnvF4W7IOypLfr3
 tlLRjI8xpce96GrVh5z+TxqezzqBVNtTFXpmMUb8CnMlwhwOJyDvVBQdyODR9JkRg3605/8c2MY
 qco5sYgxFj4itB4zJz4pITAcAHYMauDv57XQLanLJ9xOzOGVpU6ATrrb9HYGdClDa6GXxN1LLtp
 NtSFJyZkuI3PVsBPgnYhgmZ1kPCs7ezWkg4vdz/SX0io37DvN2rUDi8VRiMIk/OehVBUOUMBXjI
 g/SZNLYaobMvVRGiFti5kW99rIfKDIZ+2NTtMzIW//iMn9CVXnCbgG1Y7pIeiSPaECq1DgNFkVc
 pOLHEYKyZI6AXWZsl4aATxgTQw=
X-Received: by 2002:a05:620a:440d:b0:8ef:74c9:daa7 with SMTP id
 af79cd13be357-8ef74c9e32fmr1451093685a.8.1776984387201; 
 Thu, 23 Apr 2026 15:46:27 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d98c15a9sm1970538185a.43.2026.04.23.15.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 15:46:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wG2oU-0000000GMBz-0jKo;
 Thu, 23 Apr 2026 19:46:26 -0300
Date: Thu, 23 Apr 2026 19:46:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423224626.GV3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
 <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423132016.4a25e074@shazbot.org>
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

On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:

> My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> processing hint.  It would fdget() the dmabuf fd, validate it's a
> dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> find the matching vfio_pci_dma_buf via priv under memory_lock, and
> stuff the provided TPH values into the object.  It would be left to the
> user to sequence setting the TPH values on the dmabuf before the dmabuf
> is consumed by the importer.
> 
> Is that a more reasonable uAPI?  Thanks,

Off hand I think it can work, with the proviso that if userspace uses
the dmabuf before setting the tph the importer may ignore it. I don't
think that is a problem in practice.

Jason
