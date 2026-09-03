Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBFAC624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669E210E126;
	Thu,  3 Sep 2026 20:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LnMSXc0n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825F810E126
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 20:34:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FB4143ECB;
 Thu,  3 Sep 2026 20:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71661F000E9;
 Thu,  3 Sep 2026 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788467673;
 bh=EqrNiBjV5RlXYnlSS2QkYfayJgyCYHp0OIW8RZQ3v4s=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=LnMSXc0njky9VyJCSsnFqNgzqtMngAh7Z0QpIoS6l+MtCS0LhNRzx2aMVrtJaL8VX
 1Q9l862qXtEvUevgCQa1jQ981epaEu9ArFksrJWZQLq5qWveKzivlI93W2/mdRtsT5
 cSapprbL74wfyf2jKR2Ls7FHgUr4uyhk2t1H/PAkm5Ptn2HM+p207G1P+KBs9lq4B7
 yPegIWu7jOyJVz4SPCnSH1bP7GBmdmF3H6WJk+xJcoiXPK6cz6DSiIpvCdhmAFO/SR
 PQxw4hD0ww/Ug5aVhx65LWv0gZbn7RWfJYAsMsrOGPyrBsTt0NpMsfBX3mxqVab4L6
 wYP//HOPS6GOA==
Date: Thu, 3 Sep 2026 15:34:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Message-ID: <20260903203431.GA2238823@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
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

On Tue, Aug 25, 2026 at 09:28:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
> 
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
> 
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It looks like 2/2 might be updated, and it probably makes sense to
merge them both together, but let me know if you want me to take this.

> ---
>  Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> index d3f406cca694..63cff9e4d2c9 100644
> --- a/Documentation/driver-api/pci/p2pdma.rst
> +++ b/Documentation/driver-api/pci/p2pdma.rst
> @@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
>  is used to determine the mapping type. The phys_addr_t-based DMA API is used to
>  establish the dma_addr_t.
>  
> -Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
> +Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
>  to remove() it must deliver an invalidation shutdown to all DMABUF importing
> -drivers through move_notify() and synchronously DMA unmap all the MMIO.
> +drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
> +the MMIO. Importers unable to complete that unmap within bounded time have to
> +be rejected when they attach, which dma_buf_attach_revocable() checks for.
>  
>  No importing driver can continue to have a DMA map to the MMIO after the
>  exporting driver has destroyed its p2p_provider.
> 
> -- 
> 2.55.0
> 
