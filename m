Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD3CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E4D10F354;
	Thu, 18 Jun 2026 16:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="A2sOokYu";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDE010F367
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781798799;
 bh=nT0xci6xmaOOUm65thHxa9cEY6e60prHEPD/nsZss18=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A2sOokYu0KAx3YqxmulMKI2EgCyBAa0qfekbD+vwpUYn4p0rrGiAHRX3n4nHIrmut
 0Mtgi6mUrSIjr8tTnsQArEujPGNV6K3b4p4gCDjWRfEvglLfKvlJz1fXovM/EnftMZ
 KDzO/3K86W7nMo6jPXyiY3eA3MV8YdKjU3b1oxvpQkxhdzw/SDO6lmXLngVd28iYlc
 tuDQqc6hMqzA1IhK2vC0xTRb1seqmPwmEn4iYbVhV7AM1LagBoyCwHe+A0uimz5qBQ
 A8aLKzuIF3iIA2qyeovzgWoB02LtNKximKmKa1pUgTmNcIQurI5KACIs0nHkopJRQw
 txy7UV+RmsYQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519) (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gh5FN4FcVz4w0H;
 Fri, 19 Jun 2026 02:06:32 +1000 (AEST)
Message-ID: <62970f4b-e624-403f-9cdc-02438c820d23@ozlabs.org>
Date: Thu, 18 Jun 2026 17:06:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
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
 <20260610154327.37758-7-matt@ozlabs.org> <aixgZQiBQKgS7yIM@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <aixgZQiBQKgS7yIM@google.com>
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

On 12/06/2026 20:39, Pranjal Shrivastava wrote:
> On Wed, Jun 10, 2026 at 04:43:20PM +0100, Matt Evans wrote:
>> Previously, vfio_pci_zap_bars() (and the wrapper
>> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
>> calls to vfio_pci_dma_buf_move().
>>
>> This commit replaces them with a unified new function,
>> vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
>> and the unmap_mapping_range(), making it harder for callers to omit
>> one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
>> the write memory_lock before zapping, and adds a new
>> vfio_pci_unrevoke_bars() for the re-enable path.
>>
>> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the
>> unmap_mapping_range() to zap is no longer performed for vfio-pci since
>> the DMABUFs used for BAR mappings already zap PTEs when the
>> vfio_pci_dma_buf_move() occurs.
>>
>> However, it must be assumed that VFIO drivers which override the .mmap
>> op could create mappings _not_ backed by DMABUFs.  So, the zap is
>> still performed on revoke if .mmap is overridden, using a new
>> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
>> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
>> vfio_pci_core_mmap() and so still uses DMABUFs.
>>
>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  8 +++
>>  drivers/vfio/pci/vfio_pci_config.c            | 30 ++++----
>>  drivers/vfio/pci/vfio_pci_core.c              | 70 +++++++++++++------
>>  drivers/vfio/pci/vfio_pci_priv.h              |  3 +-
>>  include/linux/vfio_pci_core.h                 |  1 +
>>  5 files changed, 73 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 86362ec424a5..51990f6d66d5 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1692,6 +1692,14 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
>>  	if (ret)
>>  		goto out_put_vdev;
>>  
>> +	/*
>> +	 * hisi_acc_vfio_pci_mmap() calls down to
>> +	 * vfio_pci_core_mmap(), so BAR mappings are still
>> +	 * DMABUF-backed.  They don't require a zap on revoke, so opt
>> +	 * out:
>> +	 */
>> +	hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
>> +
> 
> This seems to be happening after we vfio_pci_core_register_device, which
> could be slightly problematic if another device in the same group races 
> to trigger a hot reset before we can set this to false. Could we 
> initialize this flag before registration instead?

Remember it is a safe default, so in the event of a driver not managing
to opt-out before it's required then all that happens is a redundant
unmap_mapping_range().  The default-safe was a nice suggestion from Alex
on v2.


Matt

