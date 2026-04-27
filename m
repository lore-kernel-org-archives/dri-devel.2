Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10266FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B92D10E5C2;
	Mon, 27 Apr 2026 07:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="KhE9M0j9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742B210E5DC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777274623;
 bh=Qi6qI6BiZnWfSvCRtvIcDQP7yPAT/kFoKGo4NEHYVeQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KhE9M0j9OkpMRPiGRnyijbj4Rgt/rxOvWC4Vwr9fkhC3qL23pZb0sFnZRDewRMm2o
 94AnzFzOJC75xjH+Xl9U6mJxGl7TIKBgt/7a79Fd76s7PaD/FrnyLSqsOitUSz48tj
 5MZIO9LD/+exadNWRC4EUcg3zV43uKiCPPmFISW6OL9lwoMVNvlNWf+ey0F6RBdO1a
 aoDGie0N7MtAnFMUJahTekruCqap5fs9i4IWWsGChugQu3Hel5advBwtlSIanTDBaa
 kZJ0HuDVxTvoqa8Tum46ysdG4NdPUXB23EmPm5lh+zKfLnmgnTu099s5PV4O2y76Pg
 ofigN1tS0tTpw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FA0317E1313;
 Mon, 27 Apr 2026 09:23:42 +0200 (CEST)
Date: Mon, 27 Apr 2026 09:23:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Benno Lossin
 <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 work@onurozkan.dev, alvin.sun@linux.dev
Subject: Re: [PATCH v4 02/20] drm/tyr: select required dependencies in Kconfig
Message-ID: <20260427092338.4e083a55@fedora>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-2-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260424-b4-fw-boot-v4-v4-2-a5d91050789d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 24 Apr 2026 16:38:56 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Tyr depends on DRM_GPUVM, RUST_DRM_GEM_SHMEM_HELPER, MMU, IOMMU_SUPPORT,
> and IOMMU_IO_PGTABLE_LPAE. Select or depend on these symbols in Kconfig so
> the required infrastructure is enabled when Tyr is built.
> 
> Introduce DRM_TYR_STATIC_DEPS to keep the built-in DRM dependencies
> selected even when Tyr is built as a module.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/Kconfig | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
> index e933e6478027..443ce988b570 100644
> --- a/drivers/gpu/drm/tyr/Kconfig
> +++ b/drivers/gpu/drm/tyr/Kconfig
> @@ -1,5 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0 or MIT
>  
> +config DRM_TYR_STATIC_DEPS
> +	bool
> +	select DRM_GPUVM

IIRC, Danilo said we should have some boolean RUST_DRM_GPUVM option
selecting DRM_GPUVM for us, just like RUST_DRM_GEM_SHMEM_HELPER does.

> +	help
> +	  Ensure required DRM infrastructure is built-in when enabling Tyr
> +	  even if Tyr is =m
> +
>  config DRM_TYR
>  	tristate "Tyr (Rust DRM support for ARM Mali CSF-based GPUs)"
>  	depends on DRM=y
> @@ -7,6 +14,11 @@ config DRM_TYR
>  	depends on ARM || ARM64 || COMPILE_TEST
>  	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
>  	depends on COMMON_CLK
> +	depends on MMU
> +	select DRM_TYR_STATIC_DEPS
> +	select IOMMU_IO_PGTABLE_LPAE
> +	select RUST_DRM_GEM_SHMEM_HELPER
> +	depends on IOMMU_SUPPORT
>  	default n
>  	help
>  	  Rust DRM driver for ARM Mali CSF-based GPUs.
> @@ -16,5 +28,5 @@ config DRM_TYR
>  	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
>  	  be supported with the panfrost driver as they are not CSF GPUs.
>  
> -	  if M is selected, the module will be called tyr. This driver is work
> +	  If M is selected, the module will be called tyr. This driver is work
>  	  in progress and may not be functional.
> 

