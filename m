Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D009CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10E310E558;
	Wed, 17 Jun 2026 16:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="d3cmRLsr";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B4310E558
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781713347;
 bh=VWZSWpCol9raRY120emry9mXxsYJnSg1XDkRzNJRvt0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d3cmRLsruG7+XddsnXKfz/us2vQszmdPYD2jYLfOc8VRFAR6c2QRzLqH++tKeIN31
 q+DBJ/WB4E9j+dyCRov31HiRDstyV+eo95cEnrb31wzDtnmKyKDw/k61nhYJj71V5E
 rsjfhHlqqtC8s2doWOCpboeLeWPieWmryM8Q7E9hHV5K27NwxAiFDzXkmRnweWPvfm
 IMSD3lfXA7iwVhPzrkqUIaiBIrnr1RGmaq53qqKE2mpSa4BxXee+o5L+TiDw8em7xC
 l3JqpVOG7ZqsZlULdFtvJPXVKqHu8nwsFYHNhjRwsM0Jv7BOX4OBhHcaSrNUu6/POi
 bEm119Xyrkc5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ggTf422vjz4wCm;
 Thu, 18 Jun 2026 02:22:19 +1000 (AEST)
Message-ID: <dc606df6-0e20-49f2-989d-da69813e9bd8@ozlabs.org>
Date: Wed, 17 Jun 2026 17:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-9-matt@ozlabs.org> <ajED1v846hZkyq9z@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <ajED1v846hZkyq9z@google.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Praan,

On 16/06/2026 09:05, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 04:43:22PM +0100, Matt Evans wrote:
>> Expand the VFIO DMABUF revocation state to three states:
>> Not revoked, temporarily revoked, and permanently revoked.
>>
>> The first two are for existing transient revocation, e.g. across a
>> function reset, and the DMABUF is put into the last in response to a
>> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF.
>>
>> VFIO_DEVICE_FEATURE_DMA_BUF passes a DMABUF by fd and requests that
>> the DMABUF is permanently revoked.  On success, it's guaranteed that
>> the buffer can never be imported/attached/mmap()ed in future, that
>> dynamic imports have been cleanly detached, and that all mappings have
>> been made inaccessible/PTEs zapped.
>>
>> This is useful for lifecycle management, to reclaim VFIO PCI BAR
>> ranges previously delegated to a subordinate client process: The
>> driver process can ensure that the loaned resources are revoked when
>> the client is deemed "done", and exported ranges can be safely re-used
>> elsewhere.
>>
>> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
>> function common to move and the new feature request path.
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c   |   6 +-
>>  drivers/vfio/pci/vfio_pci_dmabuf.c | 169 ++++++++++++++++++++++-------
>>  drivers/vfio/pci/vfio_pci_priv.h   |  19 +++-
>>  include/uapi/linux/vfio.h          |  20 ++++
>>  4 files changed, 173 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 508a5eca910a..064906b25467 100644
> 
> [...]
> 
>>  
>> +/* Set the DMABUF's revocation status (OK or temporarily/permanently revoked) */
>> +static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
>> +					enum vfio_pci_dma_buf_status new_status)
>> +{
>> +	bool was_revoked;
>> +
>> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
>> +
>> +	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
>> +	    priv->status == new_status) {
>> +		return;
>> +	}
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>> +	was_revoked = (priv->status == VFIO_PCI_DMABUF_TEMP_REVOKED);
>> +
>> +	if (new_status != VFIO_PCI_DMABUF_OK) {
>> +		priv->status = new_status; /* Temp or permanently revoked */
>> +
>> +		if (was_revoked) {
>> +			/*
>> +			 * TEMP_REVOKED is being upgraded to
>> +			 * PERM_REVOKED.  The buffer is already gone,
>> +			 * don't wait on it again.
>> +			 */
>> +			dma_resv_unlock(priv->dmabuf->resv);
>> +			return;
>> +		}
>> +	}
>> +
>> +	dma_buf_invalidate_mappings(priv->dmabuf);
> 
> Nit: We seem to be calling this even if new_status == OK, while it works
> as importers (like IOMMUFD and RDMA core) are immune to a double 
> invalidate / revoke. I'm wondering if we could move this within the 
> if (new_status != VFIO_PCI_DMABUF_OK) block? 
> 
> Since this is only needed to be called when we TEMP/PERM _REVOKE?
> 
> I'm just worried that this may overload the dma_buf_invalidate_mappings 
> to be a state-change notification instead of a revoke / invalidate
> notification.

(In case you didn't see my reply to Kevin who made a similar request: 
https://lore.kernel.org/all/31d1265b-e264-4dc6-a8c3-1b64dc9867a1@ozlabs.org/ )

Done, moved to a common `!= VFIO_PCI_DMABUF_OK` block.

Just to flag that since it's currently called for both revoke and 
un-revoke paths, someone could already rely on this as a state-change 
notification.  I don't see any current examples, but giving it a mention 
in case any readers know of any.

>> +	dma_resv_wait_timeout(priv->dmabuf->resv,
>> +			      DMA_RESV_USAGE_BOOKKEEP, false,
>> +			      MAX_SCHEDULE_TIMEOUT);
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +	if (new_status != VFIO_PCI_DMABUF_OK) {
>> +		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> +		wait_for_completion(&priv->comp);
>> +		unmap_mapping_range(priv->dmabuf->file->f_mapping,
>> +				    0, priv->size, 1);
>> +		/*
>> +		 * Re-arm the registered kref reference and the
>> +		 * completion so the post-revoke state matches the
>> +		 * post-creation state.	 An un-revoke followed by a
>> +		 * new mapping needs the kref to be non-zero before
>> +		 * kref_get(), and vfio_pci_dma_buf_cleanup()
>> +		 * delegates its drain back through this revoke
>> +		 * path on a possibly-already-revoked dma-buf.
>> +		 */
>> +		kref_init(&priv->kref);
>> +		reinit_completion(&priv->comp);
>> +	} else {
>> +		dma_resv_lock(priv->dmabuf->resv, NULL);
>> +		priv->status = VFIO_PCI_DMABUF_OK;
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +	}
>> +}
>> +
> 
> Otherwise, 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Thanks,
> Praan

Thanks!


Matt


