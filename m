Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDD7C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C7510E8E0;
	Mon, 13 Jul 2026 10:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GxNvFjYQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632D210E8DF
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:23:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB3156132C;
 Mon, 13 Jul 2026 10:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5BA1F00A3D;
 Mon, 13 Jul 2026 10:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783938189;
 bh=+e3CTCf4aSRG0U8Lx9oR45akZsrFOTfpaOFmTeAii8s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GxNvFjYQBMNljqUutkSilmxnqW8ljZ/R6b6VAhUYglIcsCn5t9koZ/naZX+pnWzUd
 eqdUUztO4ni07tktCCxEUZMnVF/afQZ1s7JBOsieYWn0g3cEfKZRtJ99HP9qkKroxL
 K26qKrA6hTKPdR50f+dwtNRpD1+c9fTXTrovhCeMa4/PRJb5Xumk/MZoqB17faGMy1
 oObRKuMjhl8C+iFzSfNijA/ajIdywOvelUIxEZcVbyP0lqUruVCh0uR6PuO6I8LLQj
 cN+MZhvf9078KnVXYPJZ1evohkytLWdn2YxSrqUrjmAsZvYHAtZQTw26F+RkvPuSa4
 c18f3jK425kRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260713095837.16590-9-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:23:08 +0000
Message-Id: <20260713102309.4E5BA1F00A3D@smtp.kernel.org>
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
- [High] Missing cleanup of DSI host registration on devm_pm_runtime_enable=
() failure.
- [High] The DSI device is never runtime-resumed by mtk_ddp_comp_power_on()=
, leaving its power domain off and causing hardware access faults.
- [High] devm_pm_runtime_enable() is called too late in the probe sequence,=
 creating a race condition with DRM device binding.
--

--- Patch [8]: [PATCH v2 08/10] drm/mediatek: mtk_dsi: Enable PM Runtime on=
 probe ---
commit a3706ccca44411c23c1950cb6ce7edfa10269c16
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable PM Runtime on probe
   =20
Enable PM Runtime at the end of mtk_dsi_probe() so that the
mediatek-drm mtk_ddp_comp_power_on() function is able to do
pm_runtime_resume_and_get() and, analogously, the function
mtk_ddp_comp_power_off() to pm_runtime_put() for the DSI
device.
   =20
This makes sure that the power domains for the DSI IP are
turned on and off when necessary.
   =20
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

> Enable PM Runtime at the end of mtk_dsi_probe() so that the
> mediatek-drm mtk_ddp_comp_power_on() function is able to do
> pm_runtime_resume_and_get() and, analogously, the function
> mtk_ddp_comp_power_off() to pm_runtime_put() for the DSI
> device.

[Severity: High]
Does mtk_ddp_comp_power_on() actually get called for the DSI device?

Looking at mtk_crtc_atomic_enable(), it only powers on the first component =
in
the pipeline:

drivers/gpu/drm/mediatek/mtk_crtc.c:mtk_crtc_atomic_enable() {
    ...
    struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[0];
    ...
    ret =3D mtk_ddp_comp_power_on(comp);
    ...
}

Since the DSI device is an encoder/bridge at the end of the pipeline (e.g.,
ddp_comp[6]), it won't be resumed here, leaving it in RPM_SUSPENDED state.
Will this cause hardware access faults when DSI registers are subsequently
accessed?

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 5af44c13bd5ac..5fbaa7d580d35 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1684,6 +1684,10 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>  	dsi->bridge.of_node =3D dev->of_node;
>  	dsi->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
> =20
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

[Severity: High]
If this returns early, will it leak the DSI host registration?

Earlier in mtk_dsi_probe(), mipi_dsi_host_register(&dsi->host) adds the host
to a global list. Since there is no mipi_dsi_host_unregister() call on this
error path, and the devres-managed mtk_dsi structure will be freed, does th=
is
leave a dangling pointer in the MIPI DSI host list that could lead to a
use-after-free?

[Severity: High]
Is it safe to enable PM runtime after registering the DSI host?

By calling mipi_dsi_host_register() earlier in the function, the DSI host
becomes visible to dependent panel drivers that may probe synchronously:

mtk_dsi_probe()
  mipi_dsi_host_register()
    -> panel probe triggers
      mipi_dsi_attach()
        mtk_dsi_host_attach()
          component_add()
            -> DRM master bind triggers if all components are ready

Since devm_pm_runtime_enable() hasn't executed yet, PM runtime isn't ready
when the display pipeline starts initializing. Would it be better to move
devm_pm_runtime_enable() before mipi_dsi_host_register() to avoid this race?

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D8
