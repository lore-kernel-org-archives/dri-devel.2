Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F22EC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CED10E2E7;
	Mon,  7 Sep 2026 02:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DyNl2YfY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C06A10E2E7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 02:05:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B7B1601F9;
 Mon,  7 Sep 2026 02:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D671E1F00A3D;
 Mon,  7 Sep 2026 02:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788746717;
 bh=P+z10ld7S73QpAbtTqNeYfHImBCXLvCxssVLuYKtWIk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DyNl2YfYHFxHCUyF+dKeI7rQJom3sJBckFSOcYS/l51EsR9v7qw7coklO3txBEsLJ
 fLtrFPP/Wf//REDXsvGqf8Cvof2s6JwUF9pAWAfv/4jQMzWISQAEyogoeOAdOaKorl
 nMzt9+nFao4+fA+rcK/m8etShtnMjW9yrSXpD8K3NEtJYTm7s11Bylde8ZpgcX7Gfk
 QIvX5+DiJVISBFeBxO+VRNa1NcER2S9+/Z9u7vs2pfYVPbMeILJZqjaC5aVvmVTCd6
 2UUG3V2BpxGDc6PvSvZstGpyoFuJkICJtYPpKsVfVUHh3G+V6HUz9ZVS6PQbLmemPB
 8DbXJTqxMdpdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL
 kernels
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260907020015.24719-1-kmehltretter@gmail.com>
References: <20260907020015.24719-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:05:16 +0000
Message-Id: <20260907020516.D671E1F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using DEBUG_KERNEL as a default trigger for DMABUF_DEBUG uninten=
tionally enables performance-degrading debug checks on production kernels.
--

commit 35e36d45a9285f1874efd2a5212588eb662aa118
Author: Karl Mehltretter <kmehltretter@gmail.com>

dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels

This commit replaces the non-existent DEBUG Kconfig symbol with DEBUG_KERNEL
to ensure DMA-BUF debug checks are enabled on debug kernels.

> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 7efc0f0d07126..e4f078a326a41 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -43,7 +43,7 @@ config UDMABUF
>  config DMABUF_DEBUG
>  	bool "DMA-BUF debug checks"
>  	depends on DMA_SHARED_BUFFER
> -	default y if DEBUG
> +	default y if DEBUG_KERNEL

[Severity: Medium]
Will tying this default to DEBUG_KERNEL unintentionally cause a performance
regression on production kernels?

Because DEBUG_KERNEL is a top-level menu toggle enabled in virtually all
production configurations and standard distributions, DMABUF_DEBUG will now
be universally enabled by default.

This introduces unnecessary dynamic heap allocations and scatterlist copying
in dma_buf_map_attachment() via dma_buf_wrap_sg_table() during frequent map
and unmap operations.

Could this be tied to a more specific debugging option instead to prevent
this regression on production systems?

>  	help
>  	  This option enables additional checks for DMA-BUF importers and
>  	  exporters. Specifically it validates that importers do not peek at the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907020015.2471=
9-1-kmehltretter@gmail.com?part=3D1
