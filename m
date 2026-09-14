Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A068C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8C310E649;
	Mon, 14 Sep 2026 12:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X1bmKEdC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9095A10E649
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:37:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42F9643587;
 Mon, 14 Sep 2026 12:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E949E1F000FF;
 Mon, 14 Sep 2026 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789389475;
 bh=Ptl0sDnlE0u4f00ICSbplcnT4JPemiUrzPRtvOyKrws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X1bmKEdC5x02jOBQDI4ydoJcQRmwzLMMMpUOrYdClQJ1ACnC41Zh397xW0r/QX2x2
 AWjXd8m1gEsdGCm3E2GABPeMaQ0U0CM4FQ2u/5fKklOk9LDXIBdtP7RTyFG8P248UI
 gEThQd5hZNMn+zCNsgT4ap1He96Laj1V0J1ALOktVoohB9MM6SRjyuH5ckEJUvp1q/
 b9j853cdq1/LYnoq40eD5uFx15KJMLIxFw62tzZB/Ltdqpfu9jkifumbWw/fdNrgu2
 gTXZxMtHSfrAJEnZAV7USpkYTfVttGxYxncVBQ+EtKiRTu0+XWhzw1m+W5BIw85inc
 FD3a9DGpwgGWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/13] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260914115812.22751-12-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:37:54 +0000
Message-Id: <20260914123754.E949E1F000FF@smtp.kernel.org>
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

New issues:
- [High] Enabling PM runtime leaves the DSI device perpetually suspended be=
cause `mtk_ddp_comp_power_on()` is only invoked for the first component in =
the display pipeline, never for the DSI device.

Pre-existing issues:
- [High] Bridge properties are initialized after registration, exposing an =
uninitialized state to concurrent lookups.
- [High] Read-modify-write race on `dsi->irq_data` between process context =
and IRQ handler context leads to lost interrupts.
--

commit 18651040b7788a002a5585acda6d5cf89879837e
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
drm/mediatek: mtk_dsi: Enable PM Runtime on probe

This commit enables PM runtime at the end of mtk_dsi_probe(), placing the
DSI IP under PM domain control. It expects mtk_ddp_comp_power_on() and off
functions to resume and suspend the device appropriately.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index d930cb3c4d74e..b668814b92000 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1734,6 +1734,10 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)

[ ... ]

> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Does this leave the DSI device perpetually suspended?

The commit message states that mtk_ddp_comp_power_on() is expected to
call pm_runtime_resume_and_get() for the DSI device. However, tracing
mtk_crtc_atomic_enable() reveals that the power-on mechanism operates
strictly on the first component in the display pipeline:

drivers/gpu/drm/mediatek/mtk_crtc.c:mtk_crtc_atomic_enable() {
        ...
        struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[0];
        ...
        ret =3D mtk_ddp_comp_power_on(comp);
        ...
}

Since the DSI device is at the end of the pipeline and is never ddp_comp[0],
its PM usage count wouldn't be incremented. Because the driver accesses
hardware registers in mtk_dsi_poweron() while the device is still considered
RPM_SUSPENDED by the PM framework, could this regression cause bus faults
or unclocked access crashes?

>  	ret =3D mipi_dsi_host_register(&dsi->host);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to register DSI host\n");

[Severity: High]
This is a pre-existing issue, but does this expose an uninitialized bridge
state to concurrent lookups?

In mtk_dsi_probe(), mipi_dsi_host_register() is called before the bridge
properties are initialized:

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_probe() {
        ...
        ret =3D mipi_dsi_host_register(&dsi->host);
        ...
        dsi->bridge.of_node =3D dev->of_node;
        dsi->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
        ...
}

Because mipi_dsi_host_register() can synchronously probe child panel
devices, the child's attachment sequence triggers mtk_dsi_host_attach(),
which calls drm_bridge_add(&dsi->bridge).

This publishes the bridge to the global list before of_node and type are
set. Could concurrent iterations over the global bridge_list (like
drm_of_find_panel_or_bridge()) observe a NULL of_node and encounter lookup
failures or spurious -EPROBE_DEFER errors?

Additionally, while reviewing this code, I noticed another pre-existing
issue in the same file:

[Severity: High]
This is a pre-existing issue, but can the read-modify-write pattern on
dsi->irq_data lead to lost interrupts?

The variable dsi->irq_data is updated from both process context and
hardware interrupt context using unprotected read-modify-write operations:

Process context:
mtk_dsi_irq_data_clear() {
        dsi->irq_data &=3D ~irq_bit;
}

Hardware interrupt context:
mtk_dsi_irq_data_set() {
        dsi->irq_data |=3D irq_bit;
}

If a hardware interrupt fires between the load and store instructions of the
process context update, the process context will immediately overwrite the
IRQ handler's updated value with its stale loaded value.

Could this erase the interrupt flag and lead to missed wakeups and timeouts
in wait_event_interruptible_timeout() during display initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D11
