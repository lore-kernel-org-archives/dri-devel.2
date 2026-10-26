Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B695606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5bSxxsP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C105710E035;
	Mon, 26 Oct 2026 11:52:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048F210E035
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:52:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DE7143AC3;
 Mon, 26 Oct 2026 11:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307661F01829;
 Mon, 26 Oct 2026 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793015550;
 bh=xiNiV3/Fn9pkCMcojVCfH4/GvX7RaJ2QCUCBSHpfmOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5bSxxsPGJgN7ZyvjqmxBVSzMAktsjoo8r9nLpm3yO1DCSmM5O1ql8i5PQq8xPxQ6
 xBT9377wo5bFJ7bPAeGXM8fF0pAs6DaLp2A6KgiGpsy8TD1gYbZIlnINgvPxuatwZb
 a3vz/SgkabTIkEF70SX9q7HC/zL05YEpq3LL2fvgjCj++beZiv2DnjCxayyRSI6vGX
 MXbAQjp4+Zh/vGumttIVIF8r2p0zEZ7MpjJGEdDD6vejc/DjlG705iyRe8/KpptzHa
 00uJxV59Ot/thD5RKeKGLpKHsE8St65V+j/7Ah4WT0n5Px8a5kDhIXKSzkBZiLJqi9
 yC7hrVvj1zrZA==
Message-ID: <sashiko-outbox-185122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] drm/imx: dc: Add DPR channel support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-8-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:52:29 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/imx: dc-dprc: unsafe runtime PM and IRQ sync in dc_dprc_wrap_i=
rq_handler()
- [High] drm/imx: dc: race between dc_dprc_ctrl_done_handle() and DPRC disa=
ble
- [Medium] drm/imx: dc: missing error handling and RPM cleanup in dc_dprc_c=
onfigure()
- [Medium] drm/imx: dc: unchecked device_link_add() and unbind race in dc_d=
prc_get()
--

commit af166b9c0f4a6b977aa85b013620057bbb1169c8
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add DPR channel support

This commit adds a platform driver for the Display Prefetch Resolve Channel
(DPRC) in the i.MX8 Display Controller, working alongside the PRG to fetch
and transform display data into RTRAM.

> diff --git a/drivers/gpu/drm/imx/dc/dc-dprc.c b/drivers/gpu/drm/imx/dc/dc=
-dprc.c
> new file mode 100644
> index 0000000000000..a8ddcd117a52b
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-dprc.c

[ ... ]

> +void dc_dprc_configure(struct dc_dprc *dprc, unsigned int stream_id,
> +		       unsigned int width, unsigned int height,
> +		       unsigned int stride,
> +		       const struct drm_format_info *format,
> +		       dma_addr_t baddr, bool start)
> +{
> +	unsigned int prg_stride =3D width * format->cpp[0];
> +	unsigned int bpp =3D format->cpp[0] * 8;
> +	struct device *dev =3D dprc->dev;
> +	unsigned int p1_w, p1_h;
> +	u32 val;
> +	int ret;
> +
> +	if (start) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get RPM: %d\n", ret);
> +			return;
> +		}
> +
> +		dc_dprc_set_stream_id(dprc, stream_id);
> +	}

[ ... ]

> +	switch (format->format) {
> +	case DRM_FORMAT_XRGB8888:
> +		/*
> +		 * It turns out pixel components are mapped directly
> +		 * without position change via DPR processing with
> +		 * the following color component configurations.
> +		 * Leave the pixel format to be handled by the
> +		 * display controllers.
> +		 */
> +		val |=3D A_COMP_SEL(3) | R_COMP_SEL(2) |
> +		       G_COMP_SEL(1) | B_COMP_SEL(0);
> +		val |=3D PIX_SIZE_32BIT;
> +		break;
> +	default:
> +		dev_err(dev, "unsupported format 0x%08x\n", format->format);
> +		return;
> +	}
> +	regmap_write(dprc->reg, MODE_CTRL0, val);
> +
> +	if (start) {
> +		/* software shadow load for the first frame */
> +		val =3D SW_SHADOW_LOAD_SEL | SHADOW_LOAD_EN;
> +		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
> +
> +		/* and then, run... */
> +		val |=3D RUN_EN | REPEAT_EN;
> +		regmap_write(dprc->reg, SYSTEM_CTRL0, val);
> +	}
> +
> +	dc_prg_configure(dprc->prg, width, height, prg_stride, bpp, baddr, star=
t);
> +
> +	if (start)
> +		dc_dprc_enable(dprc);
> +
> +	dc_dprc_reg_update(dprc);

[Severity: Medium]
Can dc_dprc_configure() leak the runtime PM reference on dprc->dev or perfo=
rm
unclocked register writes to dprc->prg->reg on error?

When start is true, dc_dprc_configure() calls pm_runtime_resume_and_get(dev)
before checking format->format. If the switch hits the default branch, it
returns early without calling pm_runtime_put(dev) and before
dc_prg_configure() acquires a matching runtime PM reference on dprc->prg->d=
ev.

In addition, dc_prg_configure() can fail in pm_runtime_resume_and_get() when
start is true:

drivers/gpu/drm/imx/dc/dc-prg.c:dc_prg_configure() {
	if (start) {
		ret =3D pm_runtime_resume_and_get(dev);
		if (ret < 0) {
			dev_err(dev, "failed to get RPM: %d\n", ret);
			return;
		}
	}
}

Because dc_prg_configure() returns void, dc_dprc_configure() still proceeds=
 to
call dc_dprc_enable() -> dc_prg_enable() and dc_dprc_reg_update() ->
dc_prg_reg_update(), writing to prg->reg while prg->dev remains suspended a=
nd
unclocked, and leaving the runtime PM reference counts unbalanced between
dprc->dev and prg->dev.

> +
> +	if (start)
> +		dc_dprc_enable_ctrl_done_irq(dprc);
> +
> +	dev_dbg(dev, "w: %u, h: %u, s: %u, fmt: 0x%08x\n",
> +		width, height, stride, format->format);
> +}
> +
> +void dc_dprc_disable_repeat_en(struct dc_dprc *dprc)
> +{
> +	regmap_write(dprc->reg, SYSTEM_CTRL0 + CLR, REPEAT_EN);
> +	dev_dbg(dprc->dev, "disable REPEAT_EN\n");
> +}
> +
> +void dc_dprc_disable(struct dc_dprc *dprc)
> +{
> +	dc_prg_disable(dprc->prg);
> +
> +	pm_runtime_put(dprc->dev);
> +
> +	dev_dbg(dprc->dev, "disable\n");
> +}
> +
> +void dc_dprc_disable_at_boot(struct dc_dprc *dprc)
> +{
> +	dc_prg_disable_at_boot(dprc->prg);
> +
> +	clk_bulk_disable_unprepare(dprc->num_clks, dprc->clks);
> +
> +	dev_dbg(dprc->dev, "disable at boot\n");
> +}
> +
> +static void dc_dprc_ctrl_done_handle(struct dc_dprc *dprc)
> +{
> +	regmap_write(dprc->reg, SYSTEM_CTRL0, REPEAT_EN);
> +
> +	dc_prg_shadow_enable(dprc->prg);
> +
> +	dev_dbg(dprc->dev, "CTRL done handle\n");
> +}

[Severity: High]
What prevents dc_dprc_wrap_irq_handler() -> dc_dprc_ctrl_done_handle() from
racing with dc_dprc_disable_repeat_en() and dc_dprc_disable()?

When dc_dprc_configure() runs with start set to true, it unmasks the control
done interrupt via dc_dprc_enable_ctrl_done_irq(). If the plane or CRTC is
subsequently disabled, neither dc_dprc_disable_repeat_en() nor
dc_dprc_disable() masks that interrupt or synchronizes with
dc_dprc_wrap_irq_handler():

1. dc_dprc_disable_repeat_en() clears repeat_en in system_ctrl0 with local
   interrupts disabled, without taking dprc->lock or masking the control do=
ne
   interrupt. If the control done interrupt is already pending or running on
   another CPU (or in an interrupt thread on preempt_rt),
   dc_dprc_ctrl_done_handle() can run right after and write repeat_en back =
to
   system_ctrl0.

2. dc_dprc_disable() calls dc_prg_disable(dprc->prg), which puts the PRG in=
to
   bypass mode and calls pm_runtime_put(prg->dev), and then calls asynchron=
ous
   pm_runtime_put(dprc->dev). While dprc->dev is still runtime-active or an
   interrupt handler is in flight, dc_dprc_ctrl_done_handle() can call
   dc_prg_shadow_enable(dprc->prg), writing to prg->reg after prg->dev has
   already been disabled and had its runtime PM reference dropped.

> +
> +static irqreturn_t dc_dprc_wrap_irq_handler(int irq, void *data)
> +{
> +	struct dc_dprc *dprc =3D data;
> +	struct device *dev =3D dprc->dev;
> +	u32 mask =3D 0, status =3D 0;
> +	irqreturn_t result;
> +
> +	pm_runtime_get_noresume(dev);
> +	if (!pm_runtime_active(dev)) {
> +		result =3D IRQ_NONE;
> +		goto out;
> +	}

[ ... ]

> +	result =3D IRQ_HANDLED;
> +out:
> +	pm_runtime_put_noidle(dev);
> +	return result;
> +}

[ ... ]

> +struct dc_dprc *dc_dprc_get(struct device *dev, struct dc_dprc *dprc)
> +{
> +	struct dc_dprc *iter;
> +
> +	guard(mutex)(&dc_dprc_list_mutex);
> +	list_for_each_entry(iter, &dc_dprc_list, list) {
> +		if (iter =3D=3D dprc) {
> +			device_link_add(dev, dprc->dev,
> +					DL_FLAG_AUTOREMOVE_CONSUMER);
> +			return dprc;
> +		}
> +	}
> +
> +	return NULL;
> +}

[Severity: Medium]
Should dc_dprc_get() (and dc_prg_lookup_by_phandle() when called from
dc_dprc_probe()) check whether device_link_add() returns NULL, and can
dc_dprc_get() race with driver unbind?

If device_link_add() fails and returns NULL, dc_dprc_get() and
dc_prg_lookup_by_phandle() still return a valid pointer without establishing
the consumer-supplier teardown link. Because dc_dprc_driver is registered
before dc_prg_driver in dc_drivers[], platform_unregister_drivers() unbinds
dc_prg_driver before dc_dprc_driver when no device link exists, so
dc_dprc_remove() calling dc_prg_set_dprc(dprc->prg, NULL) would write to a
freed dprc->prg.

Furthermore, during supplier unbind in __device_release_driver(),
device_links_busy() runs before dc_dprc_remove() acquires dc_dprc_list_mutex
and removes dprc->list from dc_dprc_list. If a consumer calls dc_dprc_get()
during that window, dprc is still on dc_dprc_list, device_link_add() creates
the link after device_links_busy() has already passed, and dc_dprc_get()
returns dprc right as it is being unbound and freed.

> +
> +static int dc_dprc_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D devm_request_irq(dev, wrap_irq, dc_dprc_wrap_irq_handler,
> +			       IRQF_SHARED, dev_name(dev), dprc);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request dpr_wrap IRQ(%d): %d\n",
> +			wrap_irq, ret);
> +		return ret;
> +	}
> +
> +	dev_set_drvdata(dev, dprc);
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");

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
Could dc_dprc_wrap_irq_handler() access unclocked registers or leak the
runtime PM active state when using pm_runtime_get_noresume() and
pm_runtime_active()?

There appear to be three issues with how runtime PM and the shared wrap_irq
interact across dc_dprc_wrap_irq_handler(), dc_dprc_probe(), and
dc_dprc_runtime_suspend():

1. In include/linux/pm_runtime.h, pm_runtime_active(dev) evaluates to true
   whenever dev->power.disable_depth is non-zero:

   static inline bool pm_runtime_active(struct device *dev)
   {
       return dev->power.runtime_status =3D=3D RPM_ACTIVE
           || dev->power.disable_depth;
   }

   Because dc_dprc_probe() registers the shared interrupt with
   devm_request_irq() before calling devm_pm_runtime_enable(dev),
   disable_depth is non-zero while the handler is live during probe and
   during reverse devres teardown (as well as during late system suspend). =
If
   another device sharing wrap_irq raises an interrupt during these windows,
   pm_runtime_active(dev) returns true and dc_dprc_wrap_irq_handler() reads
   dprc->reg while dprc->clks are disabled.

2. Even when runtime PM is enabled, pm_runtime_get_noresume() and
   pm_runtime_active() do not serialize with rpm_suspend() under
   dev->power.lock, and dc_dprc_runtime_suspend() disables dprc->clks witho=
ut
   calling synchronize_irq(). An interrupt arriving after rpm_suspend() has
   checked usage_count =3D=3D 0 can see runtime_status =3D=3D RPM_ACTIVE an=
d access
   MMIO registers while dc_dprc_runtime_suspend() turns off the clocks.

3. If dc_dprc_wrap_irq_handler() increments usage_count from 1 to 2 via
   pm_runtime_get_noresume() while dc_dprc_disable() concurrently calls
   pm_runtime_put(dprc->dev), dc_dprc_disable() drops usage_count from 2 to=
 1
   without triggering idle/suspend. When dc_dprc_wrap_irq_handler() then ex=
its
   via pm_runtime_put_noidle(dev), usage_count drops from 1 to 0 without
   running rpm_idle(), leaving the device stuck active with its clocks left=
 on.

Would it be safer to call devm_pm_runtime_enable() before devm_request_irq()
in dc_dprc_probe(), use pm_runtime_get_if_active() paired with
pm_runtime_put() in dc_dprc_wrap_irq_handler(), and synchronize the interru=
pt
in dc_dprc_runtime_suspend()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-imx8-dc-pr=
efetch-v7-0-a0b50cc4fc65@nxp.com?part=3D8
