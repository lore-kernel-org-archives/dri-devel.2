Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D5606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr5XONFw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69D810E8C3;
	Mon,  9 Nov 2026 20:31:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301CC10E8C3
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:31:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 260E4611E5;
 Mon,  9 Nov 2026 20:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF6B1F0089F;
 Mon,  9 Nov 2026 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794256298;
 bh=FJoDa9wz9XzvY9w6y77OOd0io38jmhgmSiRUcMxPUUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jr5XONFwCUzkmlIfk1tGPq41PP5kMdJKEcsd73aBOIH7sEOTaXUOFw3iWWxg7Rn32
 kL45OcMazcOP6EMUv903X+5K5X4Fxk40lPUitQabxyCB6JpwZSDPiQljDDpM9pidFO
 t0sr+CwajdaBkm+ys927mntXTnchvjPXqUZUlaD+O33nK+UlCpoisHCNmbujvsZoAh
 P9LHWRT1UC4d0//bDhAhYXlXmC0IFoPoO8fw37Z3YacE8olu6ZfMt/KUZp6m0+D3tt
 gxN9/3QZl/2Ky399S+l0azfToosGZuSd39oMCHBEk1EJ6EzLep5impwlPwwmuMmcc3
 tvtscAX4O7L4g==
Date: Mon, 9 Nov 2026 12:31:37 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V
 DRM driver
Message-ID: <20261109203137.GA3536171@liuwe-devbox-debian-v2.local>
References: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 11:00:04AM -0500, Hamza Mahfooz wrote:
> I have been informally co-maintaining the driver for some time now,
> so make it official.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

Please take it via your tree.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c10342aa32f3..63b70f3da896 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8359,6 +8359,7 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
>  
>  DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
>  M:	Dexuan Cui <decui@microsoft.com>
> +M:	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>  M:	Saurabh Sengar <ssengar@linux.microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
> -- 
> 2.56.0
> 
> 
