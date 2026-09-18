Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26F2C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FB710E17B;
	Fri, 18 Sep 2026 20:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="LpbRADbv";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5992910E17B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=+EF6n2UXLQQ4v0vXMKg6Y5r9VaSza1T1e5xKD84icBs=; b=LpbRADbvXs4zcm1gcSJ/IPKA2+
 8pCG8wQ4vU8xEayNsVIpQtVu2w1Nwg8LQd8duRi1DwAYGFnU0hvPEmG/rSpADy6Q7ZFKWjoJqGXdm
 rcW8Ccio2xDGOgAp727lrKANRiUkgh47M0eGk0Ugelg5fR3CnP1/jOy7webBXflq5xov3dWxDVVfo
 NbFqrA/HTjijqZZSECvbpTznw/Jy3lDNQMbZieByyOlbKXY8+dcnCMfxRPIvhz2K1G5dk+iBhIL5p
 kCAslwv0+dLXAceOJ1kdAYJkC9/Ehq3eceNcR5oJozk6F94tPoFARUO0qwHeNnrsF1XSTvzRiRK3u
 G+mX4C+A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1x7fam-0000000Csdo-14eH;
 Fri, 18 Sep 2026 14:54:14 -0600
Message-ID: <43948cef-5a40-4ff3-8dd5-081d203f6b42@deltatee.com>
Date: Fri, 18 Sep 2026 14:53:44 -0600
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
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-6-5ef07ec9ef06@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260914-fix-p2p-acs-v4-0-v6-6-5ef07ec9ef06@nvidia.com>
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
Subject: Re: [PATCH v6 06/18] PCI/P2PDMA: Document directional ACS routing
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



On 2026-09-14 05:22, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> P2PDMA documentation describes ACS controls as path-wide, although Request
> and Completion controls apply to different transaction directions and only
> affect peer-versus-upstream decisions at the path divergence.
> 
> Document the fixed client and provider roles, the divergence port checked
> for each TLP direction, and the conservative handling of unreadable ACS
> state. Clarify which controls disable_acs_redir changes.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++----
>  Documentation/driver-api/pci/p2pdma.rst         | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..43a25f3f94fd 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5291,10 +5291,11 @@ Kernel parameters
>  		disable_acs_redir=<pci_dev>[; ...]
>  				Specify one or more PCI devices (in the format
>  				specified above) separated by semicolons.
> -				Each device specified will have the PCI ACS
> -				redirect capabilities forced off which will
> -				allow P2P traffic between devices through
> -				bridges without forcing it upstream. Note:
> +				Each device specified will have the PCI ACS P2P
> +				Request Redirect, Completion Redirect, and Egress
> +				Control features forced off. This may allow P2P
> +				traffic through bridges that would otherwise be
> +				redirected upstream. Note:
>  				this removes isolation between devices and
>  				may put more devices in an IOMMU group.

Seems like the new sentence and the following existing note are saying
very similar things. Maybe we could drop the 'Note' and say something like:


"This may allow P2P traffic through bridges that would otherwise be
redirected upstream and thus this removes isolation between devices and
may cause affected devices to share an IOMMU group."


Besides that minor nit:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


