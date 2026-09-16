Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9141CC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB80D10E37D;
	Wed, 16 Sep 2026 11:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fI5XtVNR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C9210E37D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:28:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9D041829;
 Wed, 16 Sep 2026 11:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B941F000FF;
 Wed, 16 Sep 2026 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789558093;
 bh=78q69A30pXi9PHO6CW4rE0jmVPL3XptJMQs/3mMa5xc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fI5XtVNRDd7QpU+qYpnAePk0hlCmrU3Z0cpwfo7Z3n4zlus5Vf+xnWWaEGPpsdvqf
 bSiH3AQUfNy9xkOBU3t2LgxpUJk31s7VNgbawF2btdN2ifRu1I6L/+A3bjBXodH4wE
 K4FdFE7SECvD/5n1qWFfEl9R5RZbfuR3fHd3hG5nGWZ18LoohdVEHmpuQAz4cxmYvA
 hfqCqzMb3GOFsKl9jR0BogjDoWD15/NQvczermZ26tsetg67HklUkNiERnwALvFQuN
 O+/S/08+ZbUGzVDQ6cX/loo/LVB/jMXUQHxqftlijXV34VL7Lh+qUzyoXKkJIRtgVN
 jxtzA7+vcE6mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/13] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260916110825.102631-12-angelogioacchino.delregno@collabora.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:28:12 +0000
Message-Id: <20260916112813.11B941F000FF@smtp.kernel.org>
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
- [High] drm/mediatek: DSI device is perpetually suspended causing external=
 abort
- [High] drm/mediatek: mtk_dsi_host_transfer accesses unpowered registers
- [High] drm/mediatek: DSI IRQ handler accesses unpowered registers
--

commit 26652cbd743202a1f8035ecf743f6c0b1cf91008
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable PM Runtime on probe

This commit enables PM runtime at the end of mtk_dsi_probe() for the DSI
device to ensure power domains are turned on and off when necessary. The
commit message indicates that mtk_ddp_comp_power_on() and
mtk_ddp_comp_power_off() will handle the PM runtime resume and put.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3b33419aee2d9..4863d910511e9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1735,6 +1735,10 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
> =20
> +	ret =3D devm_pm_runtime_enable(dev);

[Severity: High]
Does enabling PM runtime here leave the DSI device perpetually suspended,
causing an external abort when mtk_dsi_poweron() accesses the registers?

The commit message assumes mtk_ddp_comp_power_on() will resume the device.
However, mtk_crtc_atomic_enable() in drivers/gpu/drm/mediatek/mtk_crtc.c
only calls mtk_ddp_comp_power_on() for comp[0] (typically OVL or RDMA).

Since the DSI component is always at the end of the pipeline, it is never
passed to this function and remains in the suspended state.

[Severity: High]
Can mtk_dsi_host_transfer() access unpowered registers when called
asynchronously?

This function is an exported MIPI DSI host operation that can be called by
panel drivers to send commands. With PM runtime enabled, the function
directly reads hardware registers without wrapping the access in
pm_runtime_resume_and_get() and pm_runtime_put():

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_host_transfer() {
    ...
    dsi_mode =3D readl(dsi->regs + dsi->driver_data->reg_main[DSI_MODE_CTRL=
]);
    ...
}

If the power domain is off, this could lead to a synchronous external abort.

[Severity: High]
Will the DSI IRQ handler access unpowered registers if an interrupt fires
while the domain is suspended?

The mtk_dsi_irq() handler directly accesses hardware registers:

drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq() {
    ...
    status =3D readl(dsi->regs + reg_main[DSI_INTSTA]) & flag;
    ...
}

Since the driver does not appear to call disable_irq() during suspend, a
pending or spurious interrupt firing while the domain is unpowered could
cause the handler to access unpowered registers.

Should the handler use pm_runtime_get_if_active() before accessing
registers, or should the IRQ be disabled during power off?

> +	if (ret)
> +		return ret;
> +
>  	ret =3D mipi_dsi_host_register(&dsi->host);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to register DSI host\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916110825.1026=
31-1-angelogioacchino.delregno@collabora.com?part=3D11
