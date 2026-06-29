Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39DAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDF410E990;
	Mon, 29 Jun 2026 16:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="qh88UNuk";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0B10E98F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1782750749;
 bh=lEyeCapBsVXYSpplIUA0PN6OvGWLHmv5pdfFL1Phu/8=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=qh88UNukwFc6dT9j/eKGL1AmHTkKB4THBoN2h8ulr24M43yQI7H2a3DniuYI4YQU/
 y+sEySwE1m/Yf7Z4VFExs88su0MVH5q9LvDDgm3FgbSwSerHA0qE+99HtFGQuSq59g
 FxbGAdDGAJa0us+28P1h8SwZbStEfY16odXIDBqOwMFsZRmzUmX3G24DLlJPC9HqMt
 AlrhiIGH2v4UHN+lsmYX4xgJg8hyB5WUMln6lluFMWJe2rYqxANowUQAhfaoHNwZ4s
 g1DEDbhTRfl1prBKA0d/k+37/uM3L3gfGP5wgLmM81glk8mKfiDysdxeSh8Nd0lNCJ
 lz5QMzOgdFabA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gpsJ43jdmz4x1q;
 Tue, 30 Jun 2026 02:32:20 +1000 (AEST)
Message-ID: <57055684-2008-4ba3-bfa8-674317be1a71@ozlabs.org>
Date: Mon, 29 Jun 2026 17:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-9-matt@ozlabs.org>
 <DM6PR11MB3690886693898AD755FB246F8CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <31d1265b-e264-4dc6-a8c3-1b64dc9867a1@ozlabs.org>
In-Reply-To: <31d1265b-e264-4dc6-a8c3-1b64dc9867a1@ozlabs.org>
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

Hi Kevin,


Digging this one up again,

On 17/06/2026 17:08, Matt Evans wrote:
> Hi Kevin,
> 
> On 16/06/2026 10:26, Tian, Kevin wrote:
>>> From: Matt Evans <matt@ozlabs.org>
>>> Sent: Wednesday, June 10, 2026 11:43 PM
>>>
>>> Expand the VFIO DMABUF revocation state to three states:
>>> Not revoked, temporarily revoked, and permanently revoked.
>>>
>>> The first two are for existing transient revocation, e.g. across a
>>> function reset, and the DMABUF is put into the last in response to a
>>> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF.
>>
>> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE
>>
>>>
>>> VFIO_DEVICE_FEATURE_DMA_BUF passes a DMABUF by fd and requests that
>>> the DMABUF is permanently revoked.  On success, it's guaranteed that
>>
>> ditto
> 
> Argh, thanks for catching these.  Fixed.
> 
>>> the buffer can never be imported/attached/mmap()ed in future, that
>>> dynamic imports have been cleanly detached, and that all mappings have
>>> been made inaccessible/PTEs zapped.
>>>
>>> This is useful for lifecycle management, to reclaim VFIO PCI BAR
>>> ranges previously delegated to a subordinate client process: The
>>> driver process can ensure that the loaned resources are revoked when
>>> the client is deemed "done", and exported ranges can be safely re-used
>>> elsewhere.
>>
>> probably clarify that re-use by creating a new dmabuf fd as the original
>> one is essentially zombie now.
> 
> Reworded this, plus added a note re the change below.
> 
>>>
>>> +/* Set the DMABUF's revocation status (OK or temporarily/permanently
>>> revoked) */
>>> +static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
>>> +					enum vfio_pci_dma_buf_status
>>> new_status)
>>> +{
>>> +	bool was_revoked;
>>> +
>>> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
>>> +
>>> +	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
>>> +	    priv->status == new_status) {
>>> +		return;
>>> +	}
>>
>> the only interface to request PERM_REVOKED is via the new ioctl.
>>
>> vfio_pci_core_feature_dma_buf_revoke() returns -EBADFD if
>> it's already in PERM_REVOKED.
>>
>> so this check shouldn't be reached, suggesting a warning.
> 
> Good point, both any change to PERM_REVOKED or a double-set of the same
> state indicate some caller has gone wrong.  Added a warning.

Well, after the D0/D3 reset thread, I noticed while testing that a
double-revoke will naturally happen when cleaning up a buffer that was
already revoked by a device having previously transitioned to D3.

Similarly, cleaning up a buffer that was explicitly (permanently)
revoked leads to an attempt to set TEMP whilst PERM, and this is OK too.

So the only "surprising" case is a buffer already in the PERM_REVOKED
state getting a second PERM_REVOKED (which is weeded out in the caller
as you point out).  Any new caller asking for PERM_REVOKED repeatedly is
odd, but still gets what it wants.  I really don't think a warning is
warranted just for that (it's safe either way).  Sending this
explanation separately, so you are not too disappointed if v4 reverts to
this existing condition above...  :)


Thanks,


Matt


> 
>>> +
>>> +	dma_buf_invalidate_mappings(priv->dmabuf);
>>> +	dma_resv_wait_timeout(priv->dmabuf->resv,
>>> +			      DMA_RESV_USAGE_BOOKKEEP, false,
>>> +			      MAX_SCHEDULE_TIMEOUT);
>>> +	dma_resv_unlock(priv->dmabuf->resv);
>>
>> It's existing code but while at it let's make above conditional to
>> the actual revoke path. for unrevoked it's not required given the
>> previous revoke already cleans up everything.
> 
> I noticed this too though I was consciously trying to keep the diff as
> small as possible.  But with this feedback from both you and Praan, I'll
> move this.  It's still pretty readable before/after.
> 
>> otherwise,
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> 
> Thank you.
> 
> 
> Matt
> 

