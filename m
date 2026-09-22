Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414FBC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9A810ECC3;
	Tue, 22 Sep 2026 12:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MuCtWeuR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DFF10ECC0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:36:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0D7C6021C;
 Tue, 22 Sep 2026 12:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97E01F000FF;
 Tue, 22 Sep 2026 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790080578;
 bh=e8jEFDIQdj/6PCVPYHhb+B1mkEyy2Vun3YT5Knv9+0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MuCtWeuRM7rLshflK17VSzwNNN9VWJkssfWRXD5apmhbgLlW5lYNO1p/To2vK5x6Y
 XRDzq4inR+PPLwwxJ+ftJz7TlOniL1neUDWCujIXobjmGk16h3WxJtusgz+YHcGwE/
 YDYUSH3C4BO8pU01Z39pzb2okuE9sIZU92H8Z8dZQBuAOGvKAfsyNjtHZG4ynjvpyd
 waWzpPR8tTkzLO3bYXksDo1h7HSuj1C+U7e4xXVZVM2Z1mEOiT93GJH9r6wC5tDTAz
 FRKUkc/pquxp6so676ZAk9qNUyQfxWuFrhCTk6yFHXbpQP6PDGDHOeEuuVn/7xKEx/
 MKeSo+xU6mxCQ==
Date: Tue, 22 Sep 2026 15:36:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kevin.tian@intel.com, jgg@nvidia.com, nicolinc@nvidia.com,
 dri-devel@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] dma-buf: remove pci-p2pdma include from dma-buf.h v2
Message-ID: <20260922123613.GF563127@unreal>
References: <20260921123613.683042-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921123613.683042-1-christian.koenig@amd.com>
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

On Mon, Sep 21, 2026 at 02:36:13PM +0200, Christian König wrote:
> That is unecessary here and creates an unwanted dependency to the PCI
> subsystem.
> 
> Use forward declare in dma-buf-mapping.h instead.
> 
> v2: switch to forward declare
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---

It is better to put the changelog below the `---` line, as this information
does not add anything useful for readers of the Git log.

>  include/linux/dma-buf-mapping.h | 2 ++
>  include/linux/dma-buf.h         | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)

I would expect #include <linux/pci-p2pdma.h> to be in
drivers/dma-buf/dma-buf-mapping.c instead.

Thanks

> 
> diff --git a/include/linux/dma-buf-mapping.h b/include/linux/dma-buf-mapping.h
> index 09bde3f748e4..64c03608cce7 100644
> --- a/include/linux/dma-buf-mapping.h
> +++ b/include/linux/dma-buf-mapping.h
> @@ -7,6 +7,8 @@
>  #define __DMA_BUF_MAPPING_H__
>  #include <linux/dma-buf.h>
>  
> +struct p2pdma_provider;
> +
>  struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>  					 struct p2pdma_provider *provider,
>  					 struct phys_vec *phys_vec,
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..159271fcf3d2 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -22,7 +22,6 @@
>  #include <linux/fs.h>
>  #include <linux/dma-fence.h>
>  #include <linux/wait.h>
> -#include <linux/pci-p2pdma.h>
>  
>  struct device;
>  struct dma_buf;
> -- 
> 2.43.0
> 
