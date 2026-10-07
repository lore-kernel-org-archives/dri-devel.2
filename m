Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7176ACA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6CD10EFFB;
	Wed,  7 Oct 2026 10:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aB0CPojg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D16310EFFB
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:51:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4C95601FB;
 Wed,  7 Oct 2026 10:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D201F0089B;
 Wed,  7 Oct 2026 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791370268;
 bh=weSi5GskMQcEeS2NiW1uUS0DljvEtWiOygax9Ns7zp8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aB0CPojga/mp5PJnUHNynUO3VHoezNfPEjLWND7BpXC8J4A+Z4VctOV0EybFyiCXA
 LlYp+FK1nbqf0as+ZbN6Tco7T6z4qAB/edMjNHhgXQLk3WDy3+/9RYGLamn/UHJ+Pp
 ZvLlvcbTDFnXxNsYhj+fHc24kE1SenB9XFzDFjNDvZ5EQI6v5LFoC1yibaRNzuHplB
 nBKlna6sthqpyLF2Tss+WOBkeYgO+5N12aegqpOwKWgyeVLO4QbzHaORjfSK8R82Rm
 mx+WM6PP8z8AH0dvvVRwbAyph4bkrTOMGqFmFAVWepY6r/5+2/mVscuFGz5Re0tPOD
 1k9ZJmr0mZRvw==
Date: Wed, 7 Oct 2026 13:51:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
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
Subject: Re: [PATCH v9 04/18] PCI/P2PDMA: Evaluate ACS controls at the path
 divergence
Message-ID: <20261007105104.GD7822@unreal>
References: <20261001-fix-p2p-acs-v4-0-v9-4-1a8e0f50ddd9@nvidia.com>
 <20261006210848.GA712422@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006210848.GA712422@bhelgaas>
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

On Tue, Oct 06, 2026 at 04:08:48PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 01, 2026 at 02:55:12PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > ACS redirect controls choose between peer and upstream routes only at the
> > path divergence. Applying them below that point rejects valid nested
> > topologies because traffic already has only an upstream route.
> 
> I guess the point here is that prior to this patch,
> calc_map_type_and_dist() returned PCI_P2PDMA_MAP_NOT_SUPPORTED in a
> case where it didn't need to?  Can you include an example to make this
> concrete?

One possible example I had in mind while preparing the presentation [1] was
ability to connect devices to different switches. Despite devices and switches
support P2P, but from the P2P subsystem's point of view, traffic between them
was not P2P (see slide 4).

This support will become even more important when we reach the point of
enabling P2P inside a VM. It will allow us to hide the underlying PCI
topology from the VM.

Thanks

[1] http://lpc.events/event/20/contributions/2508/
