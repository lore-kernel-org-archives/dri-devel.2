Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C003DC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D823610E013;
	Sat,  8 Aug 2026 14:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nyil7soq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9821010E013
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:46:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C42DF6001A;
 Sat,  8 Aug 2026 14:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D31F000E9;
 Sat,  8 Aug 2026 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786200390;
 bh=x7yEimdBDGefL0tKKrBx9OkTaSAvwgLwsvDPPPBeMxQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nyil7soqyFtakhWQKIj3WaIPi8l86jn3c0282AzufJOATxKu0FzfoQWDTBYvutjdw
 MW91gafRHd/MkjfQccD+ZGUnDV5BD8eD8KnjPWcEvtI02zqpy12Z9YZWB3rKv5fDzq
 TYT+mlSrmyurqLe+lO4jV9UqdhnWpJK+Ln9wypfKKkGIVzkiY8u0wxsM33kYB5wbuD
 LpmLXU6TTibbs8n6gwWSnoffIpxURQakwRztNZARlhGLYJQGBTIEXSxPVFquGw2RAJ
 srP6GXSobdBRiTYKDrui5buI48C4y21N+0bwxPc+zTsoqDnb/Ca4qNeK19anV28oQq
 NBPIyiW/iYKTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: nvdec: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808142756.2898271-1-lgs201920130244@gmail.com>
References: <20260808142756.2898271-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 14:46:29 +0000
Message-Id: <20260808144630.527D31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced `pm_runtime_disable()` in `nvdec_remove()` and `nvdec_e=
xit()` leads to a permanent `disable_depth` leak across bind/unbind cycles.
- [High] Unconditional `dma_unmap_single()` of unallocated firmware memory =
causes DMA API violations and potential IOMMU corruption.
--

--- Patch [1]: [PATCH] drm/tegra: nvdec: fix autosuspend cleanup during tea=
rdown ---
commit f6356a1a5e1501d81058f59a7327814564c32066
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/tegra: nvdec: fix autosuspend cleanup during teardown

This commit fixes a reference count leak by adding a missing call to
pm_runtime_dont_use_autosuspend() in nvdec_remove(). Without this, the
runtime PM core increments usage_count if autosuspend is enabled with a
negative delay, preventing runtime suspend during teardown.

> diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
> index 7a38664e890e3..cb52459b2d79a 100644
> --- a/drivers/gpu/drm/tegra/nvdec.c
> +++ b/drivers/gpu/drm/tegra/nvdec.c
> @@ -546,6 +546,7 @@ static void nvdec_remove(struct platform_device *pdev)
>  {
>  	struct nvdec *nvdec =3D platform_get_drvdata(pdev);
> =20
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but does this sequence cause a permanent
disable_depth leak across bind/unbind cycles?

When nvdec_remove() calls pm_runtime_disable() here, it increments the
disable_depth counter. The very next line calls host1x_client_unregister(),
which triggers nvdec_exit().

If nvdec_exit() calls pm_runtime_force_suspend(client->dev) without a
matching pm_runtime_force_resume() later, it seems the depth is incremented
a second time but only decremented once on the next probe.

Will this prevent the device from powering on after a re-bind?

>  	host1x_client_unregister(&nvdec->client.base);

[Severity: High]
This is also a pre-existing issue, but is it safe to unconditionally unmap
the firmware memory during this teardown sequence?

When host1x_client_unregister() triggers nvdec_exit(), it looks like
nvdec_exit() unconditionally calls:

drivers/gpu/drm/tegra/nvdec.c:nvdec_exit() {
    ...
    dma_unmap_single(nvdec->dev, nvdec->falcon.firmware.phys,
                     nvdec->falcon.firmware.size, DMA_TO_DEVICE);
    ...
}

If the driver is unbound before the firmware is loaded (or on platforms
where falcon firmware is never loaded), size and phys will be 0.

Could calling dma_unmap_single() on an unmapped address violate the DMA API
and cause IOMMU faults?

This pattern appears to exist in the vic and nvjpg drivers as well.

>  	falcon_exit(&nvdec->falcon);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808142756.2898=
271-1-lgs201920130244@gmail.com?part=3D1
