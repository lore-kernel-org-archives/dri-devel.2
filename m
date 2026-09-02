Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2F9C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16EA10E659;
	Wed,  2 Sep 2026 20:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mqc8Bz65";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D288210E659
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:31:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A45E640A1E;
 Wed,  2 Sep 2026 20:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC791F000E9;
 Wed,  2 Sep 2026 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788381091;
 bh=lnQaqVTyJYJK7sE/j3Sk7RRNpP0ZN9etWyG0iI2NfhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mqc8Bz65pWxed9e+4ZWUfq1zduONDseLtyhxN+ZaEEvNe7la4d8DSuw1W9p50HVS5
 JhyyN9xoii6/IXt9zthBqAkfhenGgFYFA31/WHKoaG9K1DwF+c3xfSdbtekV8o/NAg
 3paq72NRJ8w5P/FXyB9SmKW7XycoB8phUoxf9bPFCPEZQpdxqpVihA+KA5ILtoDgwG
 S7fIhu8sp+HVvX4GQlQ/ROnt55UjdQ2Ha+pIXpczfGkB8Ed0Ljfqm87YhPYjuTnEhZ
 N5sAb1itAN82gQQPn7P9/U5ALMEeDd/vabEE7Es6TdlCmS6VkTagONyRpknq0dI4YF
 eRJRTDE8WgHNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/11] drm: xlnx: zynqmp_dpsub: Use
 devm_of_reserved_mem_device_init()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
 <20260902201640.2024648-10-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:31:30 +0000
Message-Id: <20260902203131.5AC791F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] CMA area is released while DRM GEM objects might still be aliv=
e, leading to memory corruption when freeing DMA memory.
- [High] The APB clock (`apb_clk`) prepare and enable counts are leaked on =
multiple error paths during probe and clock initialization.
- [High] The allocated `dpsub` structure is leaked if `dma_set_mask` fails.
--

commit 608bb00e624e20e20a7867fa3c7bb9e1c899263d
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()

This commit replaces the manual of_reserved_mem_device_init and
of_reserved_mem_device_release pair with the devres-managed
devm_of_reserved_mem_device_init, letting the device resource manager
handle cleanup automatically.

> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/z=
ynqmp_dpsub.c
> index 53ab1a2a5aafa..e93a7a299b525 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
> @@ -203,7 +203,7 @@ static int zynqmp_dpsub_probe(struct platform_device =
*pdev)
>  	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
> =20
>  	/* Try the reserved memory. Proceed if there's none. */
> -	of_reserved_mem_device_init(&pdev->dev);
> +	devm_of_reserved_mem_device_init(&pdev->dev);

[Severity: Critical]
This is a pre-existing issue, but does tying the CMA area release to the
platform device's devres cleanup happen too early for DRM GEM objects?

When a DRM device is unbound while userspace holds an open file descriptor,
the GEM objects can outlive the platform device. When userspace eventually
closes the file descriptor, drm_gem_dma_free() calls into the DMA API.
Because the CMA area is already cleaned up upon platform device removal,
can the DMA API fail to recognize the memory as CMA and incorrectly free it
into the buddy allocator, causing memory corruption?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the earlier
sections of zynqmp_dpsub_probe(), we have this error path:

    ret =3D dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
    if (ret)
        return ret;

Does this early return leak the dynamically allocated dpsub structure?
It returns directly instead of jumping to an error handling label where
zynqmp_dpsub_release() or a free operation would be called.

[ ... ]

> @@ -255,7 +255,6 @@ static int zynqmp_dpsub_probe(struct platform_device =
*pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(dpsub->apb_clk);
>  err_mem:
> -	of_reserved_mem_device_release(&pdev->dev);
>  	if (!dpsub->drm)
>  		zynqmp_dpsub_release(dpsub);
>  	return ret;

[Severity: High]
This is a pre-existing issue, but does this error handling correctly clean =
up
the apb_clk resource?

If zynqmp_dpsub_parse_dt() fails earlier in the probe function, the code
jumps to the err_mem label. Jumping here skips the err_pm label where
clk_disable_unprepare() is called, which seems to leave the clock enabled
permanently.

Similarly, in zynqmp_dpsub_init_clocks(), if it successfully enables apb_clk
but then fails to acquire vid_clk with -EPROBE_DEFER:

    else if (PTR_ERR(dpsub->vid_clk) =3D=3D -EPROBE_DEFER)
        return PTR_ERR(dpsub->vid_clk);

Does this return the error immediately without unwinding and disabling the
clock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902201640.2024=
648-1-mukesh.ojha@oss.qualcomm.com?part=3D9
