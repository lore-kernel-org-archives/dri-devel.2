Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A4CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F2910E3A0;
	Wed,  7 Oct 2026 20:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z4sH8l8a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C07510E3A0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:12:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C7A94165D;
 Wed,  7 Oct 2026 20:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD001F000FF;
 Wed,  7 Oct 2026 20:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791403979;
 bh=NkhqUzzdxA0MVE0meZ2UnW8jxa68cZXpUz1Q9eXyAVQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=Z4sH8l8au7rGkzWgZQzY7oN5d+6g+awV127IUsOmiofzHPw2d3iZ4uPMJY0ZR+ilZ
 KoqFKDy6I9mWc06+H/S5jL+G7NcSrNrgCT385iZzEM4aEXpENT0xRtSodXm5kn8cDF
 IJLMwndnxchJxpYZV1jXq7V+4WjXZ3drM6mjQY3hKen/J4KSd+2+BiMdzrC22eP7t1
 QrjHTrHcI2/t54yHDyOfwQeglJPjDztuv7yrGkeicH55awtbPQ8zKvIYBpQipXOnZk
 R93AdEVQimgazo0I0LWZRqMepJkV8aHibBQ08MFSJhA6ADdwes553hftiSxnRnYfw7
 fuIlJ781os/Sw==
Date: Wed, 7 Oct 2026 15:12:57 -0500
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
Subject: Re: [PATCH v9 01/18] PCI/P2PDMA: Document the TLP attribute
 assumptions
Message-ID: <20261007201257.GA781492@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-1-1a8e0f50ddd9@nvidia.com>
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

On Thu, Oct 01, 2026 at 02:55:09PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> P2PDMA selects a mapping without receiving the Request's ordering or
> Address Type attributes. Its ACS handles only strictly ordered Requests
> carrying an Untranslated address.
> 
> Document that the result is not defined for Relaxed Ordering or
> ATS-translated Requests because those TLP attributes can select different
> routes through the fabric.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/driver-api/pci/p2pdma.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> index 63cff9e4d2c9..80f8fec9b0e9 100644
> --- a/Documentation/driver-api/pci/p2pdma.rst
> +++ b/Documentation/driver-api/pci/p2pdma.rst
> @@ -15,6 +15,13 @@ then based on the ACS settings the transaction can route entirely within
>  the PCIe hierarchy and never reach the root port. The kernel will evaluate
>  the PCIe topology and always permit P2P in these well-defined cases.
>  
> +This evaluation assumes clients issue strictly ordered Requests carrying an
> +Untranslated address. Its result is not defined when clients use Relaxed
> +Ordering or issue ATS-translated Requests because those TLP attributes can
> +select different routes through the fabric. Unless ACS Translation Blocking
> +is enabled, a Port with ACS Direct Translated P2P enabled routes a
> +Translated Request directly to the peer regardless of the redirect controls.

This whole paragraph is removed later in the series, so kudos for
documenting the current state before it changes :)

Unrelated to anything in this series, but this doc mentions
"p2p_provider", which doesn't exist.  Should it be "p2pdma_provider"?

