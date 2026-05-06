Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9262CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0229710EDE5;
	Wed,  6 May 2026 15:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="STDn1RSW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1470D10EDE5
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:29:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8409143DBC;
 Wed,  6 May 2026 15:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DBCC2BCC7;
 Wed,  6 May 2026 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778081383;
 bh=UzMH2u1MU8F8phCcA9cvtgS+wSBo2orCoIMTn8w+YRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=STDn1RSWQtQf5vQAmkckEpHw+vLcrntjTrcGNB2Vatv/Z6fCUX2vp9pfzwOUSuFu7
 +mdGkigx/ldWmmEm+YSTEzOjCANn8lR6dtfuu1cBebE1lJDWyqzF32ynbLILRxumZ/
 115NwbwoMhlAIz1AIAjb2v8dc+P+ohamlniLb15kqZEMaZgzCa4P+42sgnNmy4coZz
 VQRB7/nPKpidYRftVvm9evvu37ksRbGq7zqZZMNxL+bHFMKD7k60VO8NLebkXOMw2L
 o7CQ0+rY8nrjlfXaFym19/+wafjPVLYQFcUjcFzaPq326lovpu5sJuS9aLX8TgrTqd
 eEnWjzOAqtXBw==
Date: Wed, 6 May 2026 18:29:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Message-ID: <20260506152937.GJ11063@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
 <20260501131236.278ac431@shazbot.org>
 <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
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

On Wed, May 06, 2026 at 02:53:31PM +0100, Matt Evans wrote:
> Hi Alex,
> 
> On 01/05/2026 20:12, Alex Williamson wrote:
> > 
> > On Thu, 16 Apr 2026 06:17:44 -0700
> > Matt Evans <mattev@meta.com> wrote:
> > 
> > > vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
> > > revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
> > > the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
> > > second/underflowing kref_put() then wait_for_completion() on a
> > > completion that never fires.  Fixed by predicating on revocation
> > > status.
> > > 
> > > This could happen if PCI_COMMAND_MEMORY is cleared before closing the
> > > device fd (but the scenario is more likely to hit when future commits
> > > add more methods to revoke DMABUFs).
> > > 
> > > Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
> > > Signed-off-by: Matt Evans <mattev@meta.com>
> > > ---
> > > 
> > > (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
> > > and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
> > > context, so including in this series.)
> > 
> > We really need a fix for this split out from this series, It's already
> > been shown[1] that this is trivially reachable.  Carlos proposed[2] a
> > similar solution to the one below.  I was concurrently working on the
> > issued and suggested an alternative[3].  Let's pick a solution for
> > 7.1-rc.  Thanks,
> 
> It looks like [3] is progressing, so I'll drop this one when I can rebase
> onto it.
> 
> I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the
> priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on
> vdev only changing whilst resv is held to resolve a race between a fault and
> cleanup (see patch 7 of this series).  The handler takes resv so that it can
> stably test vdev in order to take memory_lock.

I think that you should rely on priv->revoked and not on priv->vdev.

Thanks

> 
> Must your fix change vdev outside of holding resv?  I'm still sketching
> alternatives; at first glance perhaps the fault handler could rely on vdev
> being valid if !revoked, which can be tested holding [only] resv.
> 
> 
> Thanks,
> 
> Matt
> 
> > 
> > Alex
> > 
> > [1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
> > [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
> > [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
> > 
> > > drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > index 281ba7d69567..04478b7415a0 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> > >   	down_write(&vdev->memory_lock);
> > >   	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> > > +		bool was_revoked;
> > > +
> > >   		if (!get_file_active(&priv->dmabuf->file))
> > >   			continue;
> > >   		dma_resv_lock(priv->dmabuf->resv, NULL);
> > >   		list_del_init(&priv->dmabufs_elm);
> > >   		priv->vdev = NULL;
> > > +		was_revoked = priv->revoked;
> > >   		priv->revoked = true;
> > >   		dma_buf_invalidate_mappings(priv->dmabuf);
> > >   		dma_resv_wait_timeout(priv->dmabuf->resv,
> > >   				      DMA_RESV_USAGE_BOOKKEEP, false,
> > >   				      MAX_SCHEDULE_TIMEOUT);
> > >   		dma_resv_unlock(priv->dmabuf->resv);
> > > -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > -		wait_for_completion(&priv->comp);
> > > +		if (!was_revoked) {
> > > +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > +			wait_for_completion(&priv->comp);
> > > +		}
> > >   		vfio_device_put_registration(&vdev->vdev);
> > >   		fput(priv->dmabuf->file);
> > >   	}
> > 
> 
