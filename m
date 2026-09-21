Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC95EC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 22:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA30910E110;
	Mon, 21 Sep 2026 22:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="gyPjGwgQ";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A1810E110
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=qZS43diFWuKFB0VBv8plxFaiwRVC4Irdx/++kTMpBxo=; b=gyPjGwgQcjCiyKhPbAXmYXw3xl
 +buvxHWSp3dQP9gg+OFi4M/6hYfsK9hkbTOt+ZvqPIGXQOdn5PU89otUyejBoLdwzF8gSa3NCjV98
 lz9UjLBaq3YW2PjpxssUBJNyxcwoWW10iFN/pSwPlVTuHtKzvXVkxbhw5DGsy7/XnnHEQLU/NjxW2
 LQX/gwFq0FxkNvESlQz0OyVDfnDGP5D0KSVxMysAdcUzk+IEM07qO4sFfRGEIWR6XNjL0vMGIpo0a
 H+jfAaaHqUub5uXEZz+NZ/KTIo7bmibu/gMd53QCePldE1dSdT1wo37SkjCqDEmdx+nhjJePGNp8X
 U0f8N5jA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1x8mJo-0000000F5pd-2GHB;
 Mon, 21 Sep 2026 16:17:01 -0600
Message-ID: <85bb90f0-5a02-4e35-9ed6-ad7e67c1c0d8@deltatee.com>
Date: Mon, 21 Sep 2026 16:16:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
References: <20260920-fix-p2p-acs-v4-0-v7-0-ca0828ab697c@nvidia.com>
 <20260920-fix-p2p-acs-v4-0-v7-15-ca0828ab697c@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260920-fix-p2p-acs-v4-0-v7-15-ca0828ab697c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com,
 gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org,
 ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, rdunlap@infradead.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 tdave@nvidia.com, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 15/19] PCI/P2PDMA: Document TLP-class routing
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



On 2026-09-20 05:41, Leon Romanovsky wrote:
> +A path is bus addressable only where both directions route directly, so with
> +nothing enabled every class is.

I don't understand the sentence.


Logan
