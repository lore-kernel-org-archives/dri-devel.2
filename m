Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54264CD3427
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 23:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631AA10E21A;
	Fri,  1 May 2026 23:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="F2cGfHWm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+UnRXDT";
	dkim-atps=neutral
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D1210E21A
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 23:19:24 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 5AEF11D000B4;
 Fri,  1 May 2026 19:19:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 01 May 2026 19:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777677563;
 x=1777763963; bh=Gn1kzdG+Ds6ZJFEuC5q+IHNvX34UkktXQuXgtwLzw7U=; b=
 F2cGfHWmNHx2BifEsL3sjqkhfBBL/KvFTMcTxiSWQ4gnaPMSK6ACYINi2Ivd6+Le
 srqFv/ffL8VhFoKvAap7FRWnAJifdlXSvrpZXLXfhuQq9m/LEb1Xfwls0BLPkoqn
 2naDYNH1s20XUd6e9ZQyHFrda6Imnqin8YjrpqcXmlHlxVCQZcfoHn0l74UmESHs
 LLLxzd2kdsSIkv6nty2rwqO3ljFoKWc7QDBCFN4coJGPUJfKGffVbzGcqFsS1AWt
 wIFigc7P/TsoDXZ12q+xnh6yzUD2Z2kE3QJJ9qylucEiPKSt0yYIgL/cEeubkOi1
 K2t7hveqxCggzxKDustifQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777677563; x=
 1777763963; bh=Gn1kzdG+Ds6ZJFEuC5q+IHNvX34UkktXQuXgtwLzw7U=; b=p
 +UnRXDT6JMUSibW0UOwuqw+kpUhlR4AZpjO7Ra7n9nOTV82ybKC7Xh+/eWHu0BtE
 f9KFDwDtCyBh9u+0xt3vFikMKdkqfkpjaBCxharrWoW6CMXMvQ68OzFdD8uhkDIt
 ZGn7TSmFR0PwZgALVeg3ong44r5NHebqAN8mKEUsLiG37/MkDqrXlfxJn5LxexFu
 GWt9PQqfI9DrlxIBA9e3I0ie289R1e45RxYAOGo86kne4XwBWNJrmqqlgxTRwbWO
 jLO+SYVjOumswPiU782ECjAVOogcEKTXS5l2b7o59p3FRqCYq+hr/FJQZNjsc5hs
 WhZiLaTu3CmJrqzcMWJqA==
X-ME-Sender: <xms:-jT1aS2_ib_hYL1Ffyudu4H-8FqoxGJBjJAAEbNNz9NAAipjrkTkfw>
 <xme:-jT1aTe-V-aJYmUAshUOrH3VLVdTnVcvzTL_bLA0wcNK0pZ5W5wCXlJrS9mXHut0-
 NwJpabxyhTj1zGu2gymMwKoFc3p-75PPPU6anTeWYfYtJqFWQUd>
X-ME-Received: <xmr:-jT1aW4gYXDWj4libaJpnvL5NWhMrmdaqQduClYgQRI9FaS6kkyAB-gJfz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludehtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfgjfhfogggtgfesthejfedtredtvdenucfhrhhomheptehlvgigucgh
 ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
 htvghrnhepgeekjeehvddtleelvddvkeeugfeileegueelvefhgffhgffghfejhfefheeu
 ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedvtddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
 hopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesnhhvihguihgr
 rdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtoheptg
 hhrhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtohhmpdhrtghpthhtohepmhhnghih
 rggurghmsegrmhgriihonhdruggvpdhrtghpthhtohepughmrghtlhgrtghksehgohhogh
 hlvgdrtghomhdprhgtphhtthhopegsjhhorhhnsehkvghrnhgvlhdrohhrghdprhgtphht
 thhopehsuhhmihhtrdhsvghmfigrlheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:-jT1aW85QSblAay0Uh0UO55QLwC9OGW5CT1crdzdhdcPPirnFxbkjA>
 <xmx:-jT1adJPfSFhWGBcOiATRlmftLdihj-tFOd7eIis78GjG37D_zZXQA>
 <xmx:-jT1aZhcuFPCtjWDAwENfDRdnSOsAu2mj67-tFRFNhY6gSSapDZpWw>
 <xmx:-jT1aW0KivO0etBfbJ4ta2ZsKDpmVbuf5zZqbzo0a5wggK5uQG3Oeg>
 <xmx:-zT1aW_WfKbGzolsAOC3oDO9dzEi5qcIWtPCXvV9vCCZwzHY6ZkzmNo9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 19:19:21 -0400 (EDT)
Date: Fri, 1 May 2026 17:19:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Pranjal
 Shrivastava <praan@google.com>, Alistair Popple <apopple@nvidia.com>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <kvm@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 6/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20260501171919.42659174@shazbot.org>
In-Reply-To: <20260416131815.2729131-7-mattev@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-7-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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

On Thu, 16 Apr 2026 06:17:49 -0700
Matt Evans <mattev@meta.com> wrote:

> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls of vfio_pci_dma_buf_move().
> 
> This commit replaces them a unified new function,
> vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
> and the unmap_mapping_range(), making it harder for callers to omit
> one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
> the write memory_lock before zapping, and adds a new
> vfio_pci_unrevoke_bars() for the re-enable path.
> 
> However, as of "vfio/pci: Convert BAR mmap() to use a DMABUF" the
> unmap_mapping_range() to zap is entirely redundant for plain vfio-pci,
> since the DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
> 
> One exception remains as a FIXME: in nvgrace-gpu, some BAR VMAs
> conditionally use custom vm_ops, which have not moved to be backed by
> DMABUFs.  If these BARs are mmap()ed, the vdev enables the existing
> behaviour of unmap_mapping_range() for the device fd address space.

What's the plan here?  Is this a temporary FIXME or a place to prove
that dmabuf for mmap works beyond the core use case?

> 
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c |  5 +++
>  drivers/vfio/pci/vfio_pci_config.c  | 30 ++++++--------
>  drivers/vfio/pci/vfio_pci_core.c    | 62 +++++++++++++++++++----------
>  drivers/vfio/pci/vfio_pci_priv.h    |  3 +-
>  include/linux/vfio_pci_core.h       |  1 +
>  5 files changed, 62 insertions(+), 39 deletions(-)
> 
...  
> @@ -1229,7 +1228,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	if (!vdev->reset_works)
>  		return -EINVAL;
>  
> -	vfio_pci_zap_and_down_write_memory_lock(vdev);
> +	vfio_pci_lock_zap_revoke_bars(vdev);
>  
>  	/*
>  	 * This function can be invoked while the power state is non-D0. If
> @@ -1242,10 +1241,9 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> -	vfio_pci_dma_buf_move(vdev, true);

This seems subtle enough to be troublesome.  I wonder if Leon didn't
intentionally place the dmabuf revoke after the device is in D0 to
allow the driver to interact with the device.  I think the lock needs
to come before the power state change to avoid racing a user induced
state change.  Thanks,

Alex
