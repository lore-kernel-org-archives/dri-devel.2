Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0CECD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5A210E0C3;
	Sun, 14 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZYW3AYN2";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9AF10F581
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1781277119;
 bh=LGhEStMN1twSMyySBf4VeZi6kVB0lNhii41/7Nxgj/o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZYW3AYN2lt0C4fdn5658+N+D5H4ZMpvntD3tZcbQEQ1G1COmkwUF0bYZ/2Ch/N5GA
 btIJVKOyRJuZI95bEHMsLm3BDQDiWnrTiwYJ1slrBLhFqv0X5u0ASOM2VjrU6tNvDD
 77qSt3c+ldoLWD1PJzc4aiyTB3OXRtWxcqNYuRTtaaBVm6eGBFDjs1Of0qNtOqT8Et
 Xq2d6uDzfUf7ZT857fqdvMYnnVsdwi2ACxBnLpiybGowDBvlYUIcBf/O17+TxsCa+l
 dser9fVVvhuSttx+faBPPLtTv5hgYgE1gs14upSe07vZa5kGsr5APAv6Ugh6mSe0So
 1BMC3+miyrxPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4gcNK46vZgz4x6q;
 Sat, 13 Jun 2026 01:11:52 +1000 (AEST)
Message-ID: <9812ae0f-8f22-4d62-a706-4c7232a5656b@ozlabs.org>
Date: Fri, 12 Jun 2026 16:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] vfio/pci: Add mmap() for DMABUFs
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
 <DM6PR11MB3690A65EA9D8A9B77AF93E198C182@DM6PR11MB3690.namprd11.prod.outlook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB3690A65EA9D8A9B77AF93E198C182@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

On 12/06/2026 09:27, Tian, Kevin wrote:
>> From: Matt Evans <matt@ozlabs.org>
>> Sent: Wednesday, June 10, 2026 11:43 PM
>>
> [...]
>>
>>  vfio/pci: Support mmap() of a VFIO DMABUF
>>
>>    Adds mmap() for a DMABUF fd exported from vfio-pci.
>>
>>    It was a goal to keep the VFIO device fd lifetime behaviour
>>    unchanged with respect to the DMABUFs.  An application can close
>>    all device fds, and this will revoke/clean up all DMABUFs; no
>>    mappings or other access can be performed now.  When enabling
>>    mmap() of the DMABUFs, this means access through the VMA is also
>>    revoked.  This complicates the fault handler because whilst the
>>    DMABUF exists, it has no guarantee that the corresponding VFIO
>>    device is still alive.  Adds synchronisation ensuring the vdev is
>>    available before vdev->memory_lock is touched; this holds the
>>    device registration so that even if the buffer has been cleaned up,
>>    vdev hasn't been freed and so the lock can be safely taken.
>>
>>    This commit makes VFIO_PCI_CORE depend on PCI_P2PDMA_CORE
>> (commit
>>    1) to bring in (only) the P2PDMA provider code.
> 
> the last sentence is stale as the dependency is now added in patch4.

Right, will fix.

>>
>> End
>> ===
>>
>> This is based on VFIO next (e.g. at b9285405c5f6).
>>
> 
> Sashiko failed to apply this series. Is there dependent work in vfio-next?
> 
> otherwise getting a Sashiko review is helpful here.

It _did_ depend on (at least the context of) some fixes in vfio-next.
Looks like it'll rebase on master now those are merged.  I should've
re-checked this for v3, oops. :|

(FWIW, I had Robot Claude Opus 4.8 to review several times up to v3.
But I agree, Sashiko would be interesting too.  Can it be manually
triggered with branch guidance?)


Thanks,


Matt


