Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3260A260A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onlB7k+k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E98910F314;
	Wed, 11 Nov 2026 12:16:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087DC10F314
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:16:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FEEF4381A;
 Wed, 11 Nov 2026 12:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C291F00A05;
 Wed, 11 Nov 2026 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794399366;
 bh=qc1N5Uc+wy8ltC14m/VdOEe2OVJ/DsFDi7Wdu8p3PFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=onlB7k+kkABml/t8+gkpZvXlK49IkjHX0Ie3jRPouDS1A37DXNb3sWucYH9w1UmkJ
 XbuCu4sR7afiwRAvdfhrIkNZqmMAbjVZsOd2YwvLkM0Oja5F5phRdXIVlHZ8Q6u4al
 wo6iIi7sN/Qln9v5Pm/OlG6P7GoTC+kacdGWaaJjGJePEmUwIu/Du8hFGyKVovLqU7
 kHBCtP4zKeQ3IzCrEMOwBcWq9gSg7u38qZkj7SbT1NsgYAMgJ8fnM3buiBS51WY+wP
 T9rECHE6S532kCq9g6YcpisTsaqIxxuzx88iv4PcnNkIycJDOHa3Ik1ey4T3i2e1J7
 /+IZl1Op9qp8A==
Date: Wed, 11 Nov 2026 14:16:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
Subject: Re: [PATCH v13 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261111121602.GQ8635@unreal>
References: <20261105-fix-p2p-acs-v4-0-v13-0-3dd065907c3b@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-fix-p2p-acs-v4-0-v13-0-3dd065907c3b@nvidia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:04:31PM +0200, Leon Romanovsky wrote:
> Punch line for Linus from Jason:
> "Enhance detecting if the PCI fabric can support a peer to peer path
> by evaluating the full bi-directional fabric path over each of the
> three traffic type ACS controls. Expand the number of fabric
> configurations where the P2P algorithm makes the correct determination
> of support to include non-uniform ACS and situations where translated
> takes different routes from untranslated."

Bjorn,

Just a friendly reminder.

Thanks,
