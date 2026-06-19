Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F029CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F25610F63C;
	Fri, 19 Jun 2026 14:41:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDA410F63C;
 Fri, 19 Jun 2026 14:41:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F992601E2;
 Fri, 19 Jun 2026 14:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3941F000E9;
 Fri, 19 Jun 2026 14:41:39 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: jgg@nvidia.com
Cc: airlied@gmail.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 patches@lists.linux.dev, rodrigo.vivi@intel.com, simona@ffwll.ch,
 sumit.semwal@linaro.org, tursulin@ursulin.net,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/5] dma-buf: Change st-dma-resv.c to use kunit
Date: Fri, 19 Jun 2026 16:41:37 +0200
Message-ID: <20260619144137.1582409-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1-v1-0a349a394eff+14110-dmabuf_kunit_jgg@nvidia.com>
References: <1-v1-0a349a394eff+14110-dmabuf_kunit_jgg@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

	Hi Jason,

> Modernize the open coded test framework by using kunit.
> 
> The kunit tool can be used to build a kernel and run it in a VM with:
> 
> $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/dma-buf/.kunitconfig
> 
> Along with the other ways to run kunits.
> 
> To make the kunit tool work like this the DMABUF_KUNIT_TEST kconfig must
> select DMA_SHARED_BUFFER to get it turned on without building a driver
> using it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for your patch, which is now commit 15b9bde78baddc27 ("dma-buf:
Change st-dma-resv.c to use kunit") upstream.

> --- /dev/null
> +++ b/drivers/dma-buf/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=y
> +CONFIG_DMABUF_KUNIT_TEST=y
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 8d4f2f89f24e3c..7d13c8f4484dd3 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -54,6 +54,14 @@ config DMABUF_SELFTESTS
>  	default n
>  	depends on DMA_SHARED_BUFFER
>  
> +config DMABUF_KUNIT_TEST
> +	tristate "KUnit tests for DMA-BUF" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	select DMA_SHARED_BUFFER

This select means that enabling KUNIT_ALL_TESTS also enables extra
functionality, which may not be desirable in a production system.
Unfortunately DMA_SHARED_BUFFER is invisible, so just changing this from
"select" to "depends on" may not be the most desirable solution.

> +	default KUNIT_ALL_TESTS
> +	help
> +	   Enable kunit tests for DMA-BUF
> +
>  menuconfig DMABUF_HEAPS
>  	bool "DMA-BUF Userland Memory Heaps"
>  	select DMA_SHARED_BUFFER

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
