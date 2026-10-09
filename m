Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECCCA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA1D710EB50;
	Fri,  9 Oct 2026 21:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WcemQ2uf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FC110EB50
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:25:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20D2C41A80;
 Fri,  9 Oct 2026 21:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE131F000FF;
 Fri,  9 Oct 2026 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791581131;
 bh=Eujz6jCIPcMtVIbI/r2x9LxmPOalmVXRMT3jQiwiujM=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=WcemQ2uf8ZGV3AkLlRVZbS0E1GNbGivMKVOJND5MaLSxczqCk4S0v1vr1tKo7uLX3
 X/cJ6wq9H/jVTMl32jw6Cj8wRaL551Vg0nVo4OsrSgGwz0roZJo7mSdjNf4rOmsaGo
 sNJj7+cCOfZdFb371B9JYg5TzZcnTkR6gzBvmQWIuBni5zPtOQHuW640QAInYCYCsC
 dMhHWiz9fVnI1YqEjo5Bm/A19lj4p6dJsQd++HlcD3Cv5Vx7jJkkl4cb7XZTR8HqCI
 U3WDzBUUqY9xyraIbghVQVKNQspifHsDCIeoFL3b0/NDIULtnR9A9d6CZmPYSFg+QB
 qnoCgjBxq7Mmw==
Date: Fri, 9 Oct 2026 16:25:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 07/18] PCI/P2PDMA: Answer routing per TLP class
Message-ID: <20261009212529.GA1086940@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-7-1a8e0f50ddd9@nvidia.com>
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

On Thu, Oct 01, 2026 at 02:55:15PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> calc_map_type_and_dist() returns one mapping type per provider and client,
> valid only for strictly ordered Requests carrying an Untranslated address.
> Clients that use Relaxed Ordering or ATS cannot ask what the fabric would
> do with their traffic.
> 
> Add enum pci_p2pdma_tlp_flags to name a class and pci_p2pdma_map_type_tlp()
> to ask about one. The topology walk and the ACS Control reads do not depend
> on the class, so decide all of them from the one walk and cache them
> together, four bits each. Every class still answers alike; the controls
> that tell them apart come next.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c | 159 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 128 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 841c86be31bb..43e225cc5735 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -492,6 +492,33 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
>  	return NULL;
>  }
>  
> +/**
> + * enum pci_p2pdma_tlp_flags - Properties of the TLPs a client will issue
> + *
> + * These describe the traffic rather than the topology, and select which ACS
> + * controls apply along the peer-to-peer path. A value of 0 means strictly
> + * ordered Requests carrying an Untranslated address.
> + *
> + * @PCI_P2PDMA_TLP_TRANSLATED: Requests carry an ATS Translated address. PCIe
> + *	r7.0 sec 6.12.3 routes those to the peer regardless of ACS P2P Request
> + *	Redirect and ACS P2P Egress Control wherever ACS Direct Translated P2P
> + *	is enabled.
> + * @PCI_P2PDMA_TLP_RELAXED_CPL: The provider returns Completions with the
> + *	Relaxed Ordering attribute set. PCIe r7.0 sec 6.12.1.1 never redirects
> + *	those, so ACS P2P Completion Redirect does not gate the path. The
> + *	Completer chooses this attribute and the specification does not require
> + *	it to copy Relaxed Ordering from the Request into the Completion, so a
> + *	caller passing this flag asserts that its provider does.

It doesn't sound right to me that Completers choose the attribute.  I
thought *Requesters* chose the RO attribute based on their design
(knowledge about which transactions require strong ordering) and their
Enable Relaxed Ordering bit.  Sec 2.2.9.1 says:

  - Completion headers must supply the same values for the Attribute
    as were supplied in the header of the corresponding Request,
    except as explicitly allowed:

    - when IDO is used (see § Section 2.2.6.4)

    - when RO is used in a Translation Completion (see § Section
      10.2.3)
