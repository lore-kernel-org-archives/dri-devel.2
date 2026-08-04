Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7ECC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACBB10EB15;
	Tue,  4 Aug 2026 16:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="YTGNKiHl";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBEE10E109
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=msNOem7p+wuff5GBoLB08T6D1Qgn/zf/MKSf7PCUJ9I=; b=YTGNKiHlWOxB29f/0WDUBxevAz
 wWQbgY4hcj9VuegwPDCW2O4ETw3h8yU99cJ3iWAuHfgW7zaVgtGVRDyZw/PtB5CEn9YTipJb4Ur2j
 XsKoAzfajZggFn6Yxm+fui4u+uD21U7vZ867CgVMajfYVICR5XKEQfUzD+k6J7SBFCqtY3HqTl2ow
 T/ZdOTGzYJH/3mSW58cfeT5FvL8m4FUlfkUVbx+SXzbgPZqp7KKJ6XfR6+TtEjqUhA7rXGKsfHZLr
 /epv48dfzHRXf1VRSFETvL3hqBFaBaWPxZGPTVGOn6SuylnrPYL05zybmbOygD+pgG9mR5Y1rgm38
 daV/hkjA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1wrHrS-00000006NYF-3B7f;
 Tue, 04 Aug 2026 10:19:27 -0600
Message-ID: <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
Date: Tue, 4 Aug 2026 10:19:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: matt@ozlabs.org, leon@kernel.org, jgg@nvidia.com,
 alex@shazbot.org, amastro@fb.com, bhelgaas@google.com, kevin.tian@intel.com,
 praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org,
 sumit.semwal@linaro.org, ankita@nvidia.com, christian.koenig@amd.com,
 apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 liulongfang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2026-08-04 09:42, Matt Evans wrote:
> 
> Just shoving an #ifdef in mlx5 isn't right, so would be grateful for
> your advice on the most tasteful resolution:
> 
>  1. Imagining future drivers might use pcim_p2pdma_provider(), maybe
>     p2pdma could export a `pcim_p2pdma_supported()` or similar which
>     returns whether CONFIG_PCI_P2PDMA is present and P2P can ever work.
>     A user of pcim_p2pdma_provider() is required to also check if P2P is
>     overall supported.
> 
>     Ugliness aside, a driver could use #ifdef CONFIG_PCI_P2PDMA to test
>     whether P2P is expected to work, except that doesn't stop modules
>     falling into the same trap.  I think a function export is better.
> 
>  2. And/or a test (such the function from #1, or an #ifdef) in the IB
>     core DMABUF path, to avoid individual drivers from doing the test in
>     their .mmap_get_pfns().  Other future drivers would be expected to
>     do similar.
> 
> Any better ideas?  Sorry I didn't catch this earlier in the review
> cycles, I know we've looked at this patch a few times now.

I see the problem now. Yes, it's a bit tricky and I don't have a great
answer. But the proposed solution seems very confusing. I definitely
don't think we should be adding ifdefs in the IB core for this.

For me, this is mainly a naming problem as there's a bunch of ways to
address it in the code. The question is what do we call p2pdma vs. core
p2pdma in a way that makes the distinction more obvious.

There's a vague convention for this already: the term 'p2pmem' is often
used for cases where the driver uses the allocator, etc. (I think I had
this intention when I wrote the code and have since forgotten about it).
I'm thinking we should lean into that more and instead of introducing
CONFIG_PCI_P2PDMA_CORE we introduce CONFIG_PCI_P2PMEM and move all that
code into it's own file, potentially renaming some functions. Then, in
the end, we would probably have a pcim_p2pdma_supported() function and a
pcim_p2pmem_supported() function, the latter being used by existing use
cases.

Logan
