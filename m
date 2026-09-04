Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880AAC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A3F10E176;
	Fri,  4 Sep 2026 08:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h3WQWv0B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E352110E176
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:07:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 693E340316;
 Fri,  4 Sep 2026 08:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E788C1F00A3D;
 Fri,  4 Sep 2026 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509257;
 bh=tRFTNUnn6GAgwLF+dDXH8KOzt+6ethYbcvp+YgyOtfc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h3WQWv0B9eoJXGc7PgYDj3lJR7j2sv1PcxgSZZG42yOsE39RcFdUBsdV+6148ZBg9
 zWV6kZNpYugRU6NYSUDw6bWbh8aQHGLPoV54C2D0FoZAF+CNPlPqEpHnJobwKvE89U
 +GHmi+6xOWuHeq6n5UOuOdmHN8QvKaoJ1fYXqMN1mYZ2f1BMzbHOtRBN907vNTZ0nN
 N31mQjHqqcLMIrIQltl+gb85LwoA99R+aW6pn5buvx5WuddqY+t04GiDoLVBwrzN/v
 ndwRUxnF4tZ/HVsPgdEmg5oJAZjWt+Q0rEGw86+9G2fMph3Y2pNCfaq6M053gIg5k1
 wYDcBWhTfsTRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] drm/imx: dc: Add DPR channel support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, Frank.Li@kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-imx8-dc-prefetch-v6-6-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-6-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:07:36 +0000
Message-Id: <20260904080736.E788C1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Shared IRQ handler accesses hardware registers without checking ac=
tive state and unconditionally returns IRQ_HANDLED.
- [High] Missing synchronize_irq() in runtime suspend for shared IRQ.
- [High] Probe error paths leave a dangling pointer in the PRG component.
- [High] Error paths in dc_dprc_configure cause severe PM usage count imbal=
ances and leaks.
- [High] IRQ_MASK_STATUS is omitted from regmap write ranges, causing IRQ c=
lear to fail and leading to an IRQ storm.
- [Medium] PRG component lookup returns an unprotected pointer and lacks a =
device link, risking concurrent use-after-free.
- [Medium] Probe fails to propagate -EPROBE_DEFER from platform_get_irq_byn=
ame.
- [Medium] DPU_DRPC_MAX_STRIDE allows 0x10000 which overflows the 16-bit PI=
TCH field.
--

commit ea99f0b5916b7bb189b9194ca08c426f78af7ec3
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add DPR channel support
   =20
Display Prefetch Resolve Channel(DPRC) is a part of a prefetch engine.
It fetches display data, transforms it to linear format and stores it
to DPRC's RTRAM. Add a platform driver to support the DPRC.

> diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc=
-dprc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c
[ ... ]
> +static const struct regmap_range dc_dprc_regmap_write_ranges[] =3D {
> +	regmap_reg_range(SYSTEM_CTRL0, SYSTEM_CTRL0 + TOG),
> +	regmap_reg_range(IRQ_MASK, IRQ_MASK + TOG),
> +	regmap_reg_range(IRQ_NONMASK_STATUS, MODE_CTRL0 + TOG),

[Severity: High]
Does this missing regmap range cause an IRQ storm? The write ranges cover=20
0x20-0x2C and 0x40-0x5C, but IRQ_MASK_STATUS is at 0x30. When the IRQ=20
handler tries to clear the interrupt by writing to IRQ_MASK_STATUS, won't=20
regmap reject the write and leave the level-triggered interrupt asserted?

[ ... ]
> +void dc_dprc_configure(struct dc_dprc *dprc, unsigned int stream_id,
> +		       unsigned int width, unsigned int height,
> +		       unsigned int stride,
> +		       const struct drm_format_info *format,
> +		       dma_addr_t baddr, bool start)
> +{
[ ... ]
> +	if (start) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get RPM: %d\n", ret);
> +			return;
> +		}

[Severity: High]
If pm_runtime_resume_and_get() fails, we return early here without taking=20
a PM reference. Since the caller has no way to detect this failure (the=20
function returns void), won't the eventual teardown call to dc_dprc_disable=
()=20
unconditionally invoke pm_runtime_put() and cause a usage counter underflow?

[ ... ]
> +	switch (format->format) {
[ ... ]
> +	default:
> +		dev_err(dev, "unsupported format 0x%08x\n", format->format);
> +		return;
> +	}

[Severity: High]
If an unsupported format is provided, this returns early while still holdin=
g=20
the DPRC PM reference and bypasses the PRG setup. When dc_dprc_disable() is=
=20
called later, it will invoke dc_prg_disable() which puts the PRG PM referen=
ce=20
(causing an underflow there), while the DPRC PM reference could end up leak=
ing.=20
Should these error paths be handled to keep PM counts balanced?

[ ... ]
> +static irqreturn_t dc_dprc_wrap_irq_handler(int irq, void *data)
> +{
> +	struct dc_dprc *dprc =3D data;
> +	struct device *dev =3D dprc->dev;
> +	u32 mask, status;
> +
> +	scoped_guard(spinlock, &dprc->lock) {
> +		/* cache valid IRQ status */
> +		regmap_read(dprc->reg, IRQ_MASK, &mask);

[Severity: High]
Since this is registered as a shared IRQ, could it fire while this device i=
s=20
runtime suspended and its clocks are off? If so, reading from the registers=
=20
without first checking pm_runtime_get_if_active() could cause an external=20
abort or bus hang.

[ ... ]
> +		/* clear status register */
> +		regmap_write(dprc->reg, IRQ_MASK_STATUS, status);
> +	}
[ ... ]
> +	if (status & IRQ_DPR_CRTL_DONE)
> +		dc_dprc_ctrl_done_handle(dprc);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Does this unconditionally return IRQ_HANDLED even when the interrupt wasn't=
=20
for this device? If the read status was 0, returning IRQ_HANDLED masks=20
spurious interrupts and violates shared IRQ conventions.

[ ... ]
> +bool dc_dprc_stride_supported(struct dc_dprc *dprc,
> +			      unsigned int stride, unsigned int width,
> +			      const struct drm_format_info *format,
> +			      dma_addr_t baddr)
> +{
> +	unsigned int prg_stride =3D width * format->cpp[0];
> +
> +	if (stride > DPU_DRPC_MAX_STRIDE)
> +		return false;

[Severity: Medium]
Since DPU_DRPC_MAX_STRIDE is defined as 0x10000, this permits a stride of=20
0x10000. However, the PITCH macro used in dc_dprc_configure() uses=20
GENMASK(31, 16) which is a 16-bit field that only holds up to 0xFFFF.=20
Won't a stride of 0x10000 silently truncate to 0 when written to the hardwa=
re?

[ ... ]
> +static int dc_dprc_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	wrap_irq =3D platform_get_irq_byname(pdev, "dpr_wrap");
> +	if (wrap_irq < 0)
> +		return -ENODEV;

[Severity: Medium]
Can this mask deferred probing? If platform_get_irq_byname() returns=20
-EPROBE_DEFER because the interrupt controller isn't ready yet, overriding=
=20
it with -ENODEV will prevent the driver from loading properly.

[ ... ]
> +	dprc->prg =3D dc_prg_lookup_by_phandle(dev, "fsl,prgs", 0);
> +	if (!dprc->prg)
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				     "failed to lookup PRG\n");
> +
> +	dc_prg_set_dprc(dprc->prg, dprc);

[Severity: High]
If the probe function fails in a subsequent step (like devm_request_irq or=
=20
devm_pm_runtime_enable), the devres cleanup will free the dprc struct.=20
However, won't this leave a dangling pointer in the PRG component since=20
dc_prg_set_dprc(dprc->prg, NULL) is never called on the error paths? This=20
could lead to a use-after-free later.

[Severity: Medium]
Additionally, dc_prg_lookup_by_phandle() locates the PRG in a global list=20
and returns a raw pointer without incrementing the device reference count=20
or creating a device link. If the PRG device is dynamically unbound (e.g.,=
=20
via a DT overlay removal) after this lookup, couldn't this unprotected=20
pointer become a use-after-free risk?

[ ... ]
> +static int dc_dprc_runtime_suspend(struct device *dev)
> +{
> +	struct dc_dprc *dprc =3D dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(dprc->num_clks, dprc->clks);
> +
> +	return 0;
> +}

[Severity: High]
Because the IRQ is shared (IRQF_SHARED), it could be triggered concurrently=
=20
by another device. If the handler is executing mid-flight on another CPU,=20
it might attempt to read registers just as the clocks are turned off here,=
=20
potentially causing a system crash. Should synchronize_irq() be called=20
before powering down the hardware to ensure no handler is executing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-imx8-dc-pr=
efetch-v6-0-26643e3f6cb7@nxp.com?part=3D6
