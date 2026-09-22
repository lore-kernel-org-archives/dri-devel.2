Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751B4C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64F210E432;
	Tue, 22 Sep 2026 09:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P93Y2JwM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCD110E67C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:28:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85DD360200;
 Tue, 22 Sep 2026 09:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460301F000FF;
 Tue, 22 Sep 2026 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790069279;
 bh=koizuzCvTqcQymkCuZR6nRMdDkAOhPlxoac5NyN6ips=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P93Y2JwMRUD+FjDX9JvlrJ4sdffhqSpMhQ3xyG2fMIU7w46V1TqTlurEZHFvSSmnp
 2eCbfQf/foqQ/lkHF+f7ldipUiwNNQN7Y6VjMqHQ9MMC12Ja10TNRz+PBB7dYo63HN
 1p45XqVVe6G71spiFanf/g1AOhtAq6jjqqf2EPcBv4PQIobYrP49/5M4kREllclt/X
 L5hwGCaBqXR9wDzE2cl68BHXQw4yQaN9tbvaZwd7fHT0B6gO8IZMywYJuK8wPdg+xf
 2ZFKuqemyBIUzzqWh1b1M3W+Dt4g4n1tpq/O+4GBRiuEtrGT7YOxV1miHkxHvRpX74
 sSTSkzvA+KpeQ==
Date: Tue, 22 Sep 2026 12:27:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 15/19] PCI/P2PDMA: Document TLP-class routing
Message-ID: <20260922092754.GC563127@unreal>
References: <20260920-fix-p2p-acs-v4-0-v7-0-ca0828ab697c@nvidia.com>
 <20260920-fix-p2p-acs-v4-0-v7-15-ca0828ab697c@nvidia.com>
 <85bb90f0-5a02-4e35-9ed6-ad7e67c1c0d8@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bb90f0-5a02-4e35-9ed6-ad7e67c1c0d8@deltatee.com>
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

On Mon, Sep 21, 2026 at 04:16:56PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-09-20 05:41, Leon Romanovsky wrote:
> > +A path is bus addressable only where both directions route directly, so with
> > +nothing enabled every class is.
> 
> I don't understand the sentence.

I tried to say that we need both Requests and Completions route
directly.

Claude suggested something like that:
---------------------------------------------------------------------------
Combining the two tables gives the mapping type: a class is bus addressable
when its Request and its Completions both route directly, a blocked Request
is not supported because Translation Blocking rejects the Address Type
wherever the Request is addressed, and anything else goes through the host
bridge. With no ACS control set anywhere, every class routes directly.
---------------------------------------------------------------------------

Thanks

> 
> 
> Logan
