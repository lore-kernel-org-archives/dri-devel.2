Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327A110E9D6;
	Mon, 29 Jun 2026 17:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="DrnVVqD2";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5ACD10E9D6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1782754012;
 bh=y6eTx+9vg9xblvO487zhAd78ZW9yRyedKnZlH9n/Q1A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DrnVVqD25H/vFxEfW5d4xHnG7Pc1MM3ub184VCpBbrQ08+Vf4/gSGAFi9Ztv5RPIp
 +DPnMkZN0Rq1BNhf0To8wcmDt8naUQB/8DUZdLPKIhznKdibD3VFtLP4xlygASScPR
 jsVI3JtM7hii5yp3iVe3S/QopyVb9AmjDxnbUO6kZpGnB12C8gZHGGf8mnv9GP31s1
 jGj2WBAOwoUMmvyKZ0acx9Ot5s11nbcNxJo7i0ahlb/jltZ5HKISUIJeH/IQPiAlDQ
 t1Iw8z5AmbdTwwik49LDPiro0BE7UDScxaB0rz4itKI4TL3Oha7z1PZvGdCOzBO/iz
 D06sFOHWNMXaA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gptVs3yzbz4w9j;
 Tue, 30 Jun 2026 03:26:45 +1000 (AEST)
Message-ID: <cc4e8b75-5b25-417c-898b-35b3fa41ccb2@ozlabs.org>
Date: Mon, 29 Jun 2026 18:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
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
 <20260610154327.37758-7-matt@ozlabs.org>
 <DM6PR11MB3690CA709415069FFA5121838CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB3690CA709415069FFA5121838CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
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

On 16/06/2026 10:18, Tian, Kevin wrote:
>> From: Matt Evans <matt@ozlabs.org>
>> Sent: Wednesday, June 10, 2026 11:43 PM
>>
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
> 
> It's unusual to have three verbs (lock/zap/revoke) in one function name.
> 
> I wonder whether it's simpler to have:
> 	vfio_pci_zap_bars_locked() 	// caller already holds the lock
> 	vfio_pci_zap_bars()
> 
> 'revoke' is just a side-effect of 'zap', not necessarily to highlight it in
> the name.

(Just found this one unacknowledged, apologies.)  If you reckon it's a
handful, sure I can shorten them.

As it already has ..._unrevoke_bars(), it makes sense to use
..._revoke_bars() and ..._lock_revoke_bars().  IMHO the zap is a
secondary effect, and "revoke the BARs" means to make them inaccessible
from both DMA and CPU.

I don't want to go down the path of _locked() though right now; I just
want to tidy the current pattern without pulling new duties up to the
call sites.

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
> 
> the cost of unmap_mapping_range() is trivial when there is no mmap
> on the device fd.
> 
> so it could be simpler by always doing:
> 
> 	vfio_pci_dma_buf_move();
> 	unmap_mapping_range();
> 
> and remove the flag.

I did consider this.  I do agree it's cheap, but I still prefer to avoid
unnecessary activities (just to decouple and insulate against things
somehow changing in future).  From previous postings, others didn't seem
to mind the flag approach, at least.

Thanks,


Matt

