Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160D8C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A5A10E209;
	Tue, 25 Aug 2026 20:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deltatee.com header.i=@deltatee.com header.b="KmUw93Qi";
	dkim-atps=neutral
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D8A10E209
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=iegiTVChsTubBoauxaUiIv53UrAdzumP4GLHq70u8/E=; b=KmUw93Qi4EK4PCsI+Cf9iO+Arr
 IeuyZ8J8sGF1u8kJroNzDYpfc3+4SA83vLG5jx9NrrZ7MFbeTB9fU7dAZEEplF9u/f6eIZs3tq353
 ZFzTjnOacR7Say4PM4LLDcgTJD88UBdGJ0ioIxt9qbzXuv8Vu1/KsJVNqWohig7I00ORmiRzJmIZR
 e/MUJXx1VYByD07Z/gn13XMCWmWzurH4r47RCEa5dUZBvlqYZ+Zy7T2CQAO5LWorNOSBdnz1tNZMA
 hmZxC3bLnaem4UYSJ5tf2nsLR77mS59euUlZPJwXPc2ZEuZ+HNHmXMHRv0BddBQvX66G0VXpoIf45
 pEI42wBA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1wyxOg-00000006MiZ-3aPa;
 Tue, 25 Aug 2026 14:05:27 -0600
Message-ID: <6aeec523-3088-4f37-accc-c900953393f6@deltatee.com>
Date: Tue, 25 Aug 2026 14:05:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net,
 skhan@linuxfoundation.org, christian.koenig@amd.com, sumit.semwal@linaro.org,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
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



On 2026-08-25 00:28, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
> 
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
> 
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

