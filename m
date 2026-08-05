Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F769C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCFC10E1EE;
	Wed,  5 Aug 2026 16:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="pLiGjIXv";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2FE10E1EE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1785947320;
 bh=yiJ0+hNTlQaOQvii0b1/wQkPz1RfzFD08P9jZ5t1mCM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pLiGjIXvuuBR0foWf+7hbol+tQ2nqtHgBTowXwiG/iVfYgg5DzvokbKKtw7zqgG/R
 AuiEghtscPfI8zQ+ywOuqeT7a8ZJe83SbP8PeAW5Q0v07W5NbGH38FDIF8xH7Kh3+/
 pETfzzbLWjT37tneMWCwUDqIToWOJNUEq1adNmvrFxXfNHk3rNc/9BfSyMdY04nbZu
 Uqymsh6DW9R7SRZc526cKtU95caOMNzc6cK1iJUkzdUR5a4nKPU27UW6wLYUJrxU83
 bmzxNoG1faU5G84PcehHrAa+OC2MGPmnLqCBCOcDueljKnUVfjoKSOgp7EEqeM/EH0
 4ox3yohMVB8Qg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hFbSb5XpRz4w9d;
 Thu, 06 Aug 2026 02:28:31 +1000 (AEST)
Message-ID: <554c73c8-bc17-4336-8e38-f4cfe8d8b3fe@ozlabs.org>
Date: Wed, 5 Aug 2026 17:28:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
 <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
 <20260805003914.GK27883@nvidia.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260805003914.GK27883@nvidia.com>
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

Hi both (Logan thanks for your comments!),

On 05/08/2026 01:39, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 10:19:11AM -0600, Logan Gunthorpe wrote:
> 
>> There's a vague convention for this already: the term 'p2pmem' is often
>> used for cases where the driver uses the allocator, etc. (I think I had
>> this intention when I wrote the code and have since forgotten about
>> it).
> 
> I've been calling it the genalloc layer and the core layer. p2pmem
> would be OK to refer to the genalloc stuff. So if you want to have
> CONFIG_PCI_P2PDMA and CONFIG_PCI_P2PMEM that seem sOk
> 
>> code into it's own file, potentially renaming some functions. Then, in
>> the end, we would probably have a pcim_p2pdma_supported() function and a
>> pcim_p2pmem_supported() function, the latter being used by existing use
>> cases.
> 
> Not quite sure why we need this?

( [1] )

> Matt, the mlx5 stuff is the same as VFIO, it just uses the "core"
> layer and does not use the genalloc. So there shouldn't be an issue
> here, if the genalloc is off then the mlx5 stuff should still
> work. There shouldn't be a case where CONFIG_PCI_P2PDMA=y and mlx5 is
> broken?

Oh, when CONFIG_PCI_P2PDMA=y it's all good.

The issue is when CONFIG_PCI_P2PDMA=n, as mlx5 still seems to permit a
DMABUF export solely because pcim_p2pdma_provider() succeeds.  (This
patch's CONFIG_PCI_P2PDMA_CORE enables that.)  mlx5 assumes that getting
a provider means P2P DMA is also available.

Later, DMABUF attach would fail, but it'd be good to keep the original
failure mode where UVERBS_METHOD_DMABUF_ALLOC fails early if no P2PDMA.

I was thinking something trivial like the following would let things
like IB fail the DMABUF_ALLOC early still, instead of making the
assupmtion that having a provider means having P2P DMA.  E.g. OK
provider's available, but test for P2P DMA support too:

 bool pcim_p2pdma_supported(void)
 {
 #ifdef CONFIG_P2PDMA
	return true;
 #else
	/* CONFIG_P2PDMA_CORE only */
	return false;
 #endif
 }

I can't yet see places [1] would be used (IIUC that's indicating "core
is present"? and feels ~similar to _provider returning something) but I
don't know all the consumers well enough yet.  Agree the two groups of
functionality could be named more distinctly, though.


Cheers,


Matt

(PS: Wanted to v.tactfully ask, as I'm eager to avoid as much
renaming/refactoring in this pair of P2PDMA patches as possible since
folks now seem happy with them, what could be a fix in this series vs a
revisit.)


> Did some of APIs get mixed into the genalloc family that should not
> have?
> 
> Jason
> 


