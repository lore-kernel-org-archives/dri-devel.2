Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A35CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FE510EF01;
	Wed, 17 Jun 2026 09:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z63GtVAn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2BE10EF01
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:25:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96136600AA;
 Wed, 17 Jun 2026 09:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC1C1F000E9;
 Wed, 17 Jun 2026 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781688356;
 bh=kNmA5R3v1h2GDeEpX7P6zR+iU210JS6UXSK5tbKyMCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z63GtVAnM9NeW3gc0rqRwmF1LOtifNmvF8NAE6seJFxwvSzQ49A2iUaGhLRp+kf7b
 y1LHKg+lNZ96uhLoh4qkUKHKUb4U2endrZi8748Y3lFHA9oGJzbOoOSoZqEGxdeM24
 WxdZSogWzShUc8EdhB+0I8NQwDqIQfE50cCwQi+c2rXhzA5KQtcqdG8VGet0SgOy8j
 Vyk/2yAclKoqFgloi2uv6SeZkI+ZyXHRnBGISXh8vD7t+xxJuCapPGOIak6pxZtcv2
 L51XpN8+2XYutplBlxzaLsgs1DKzcqcPQ44L3c+JoZOnXf5uNmz0kN6H9EqYa0pxqo
 1+tUJsR0u6g5w==
Date: Wed, 17 Jun 2026 12:25:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Message-ID: <20260617092550.GT327369@unreal>
References: <20260615065912.2177918-1-zhipingz@meta.com>
 <20260615065912.2177918-5-zhipingz@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615065912.2177918-5-zhipingz@meta.com>
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

On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> peer-to-peer access to a PCIe endpoint and use it to program
> requester-side TPH on the outbound mkey. If the exporter has no
> metadata, fall back to the existing no-TPH path.
> 
> Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> steering tags into local ST entries when table mode is active, and add
> mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> index.
> 
> For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> creation and release it again when the MR is returned to the pool or
> the backing mkey is destroyed, while leaving the generic FRMR pool core
> unchanged.
> 
> Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> modular mlx5_ib builds link cleanly.

The commit message explains *what* the patch does, but it lacks context on
*why* the change is needed. The 'what' is mostly clear from reading the code;
the important part missing here is the rationale behind the change.

Thanks
