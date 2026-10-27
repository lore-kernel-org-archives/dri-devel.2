Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C32606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFC7IhuO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E682910F558;
	Tue, 27 Oct 2026 13:53:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0083D10F558
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1E664108A;
 Tue, 27 Oct 2026 13:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A011F01825;
 Tue, 27 Oct 2026 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793109183;
 bh=FaqJPeJsb4R7FWBq36p22c6DRyoNLVlBk26f9NSmuQE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZFC7IhuO9dXf7o4UCJmiKZbZ6lSdtITezHqb6a6wXiEyAcXdgbKGvqSzJRpyeyShs
 uN9+UTa0ExJQR9FCwaHEQFynUkemxRbVXg22aAH4bTaCryFai7cU/1mOcnUoCepVEI
 Pal/6IOFC9bCEjcbdN4U4pNqGQ+ohNaybPOlIXDL4smD4Ro1Wy1eNPBXefDiU9tM91
 EhneX+YrfvDjSc+Jvsxynl3aiS0DugbNDqaFgtsixJCkyJP1Gfwsu3hKA33+tBfkpY
 K9QdBN5d42+1u2rrpKuEp4QtU8AOy8H+FsUFY2Imfex/ZHaM3tJY66FhBAcTw0ZDuT
 mCL6AlmtGIEiQ==
Message-ID: <sashiko-outbox-186670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/18] drm/bridge: analogix_dp: Move IRQ
 enable/disable to bind/unbind
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027132810.1746118-15-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
 <20261027132810.1746118-15-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:53:03 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: analogix_dp: level IRQ storm when pm_runtime_resume_an=
d_get() fails
- [Medium] drm/bridge: analogix_dp: pm_runtime_resume_and_get() in IRQ clea=
rs HPD status
--

commit 2a41fb565a5b1a6da39d3e4bf4efd7dfc99b3b81
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Move IRQ enable/disable to bind/unbind

This commit moves enable_irq() and disable_irq() from the bridge enable/dis=
able
handlers into analogix_dp_bind() and analogix_dp_unbind(). It also converts=
 the
interrupt handler to a pure threaded IRQ handler that acquires a runtime PM
reference before accessing controller registers.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index a8a2d5d615aea..e92d86c678947 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -700,24 +700,22 @@ static int analogix_dp_enable_scramble(struct analo=
gix_dp_device *dp,
>  	return ret < 0 ? ret : 0;
>  }
> =20
> -static irqreturn_t analogix_dp_hardirq(int irq, void *arg)
> -{
> -	struct analogix_dp_device *dp =3D arg;
> -	irqreturn_t ret =3D IRQ_NONE;
> -	u32 irq_type;
> -
> -	irq_type =3D analogix_dp_get_irq_type(dp);
> -	if (irq_type)
> -		ret =3D IRQ_WAKE_THREAD;
> -
> -	return ret;
> -}
> -
>  static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
>  {
>  	struct analogix_dp_device *dp =3D arg;
>  	u32 irq_type;
>  	bool hpd_detected;
> +	int ret;
> +
> +	/*
> +	 * The device may have been runtime suspended since the interrupt
> +	 * was raised. Hold a runtime PM reference before touching the
> +	 * registers, as the controller clocks are only guaranteed to be
> +	 * enabled while the device is runtime PM active.
> +	 */
> +	ret =3D pm_runtime_resume_and_get(dp->dev);
> +	if (ret)
> +		return IRQ_HANDLED;

[Severity: High]
Can returning IRQ_HANDLED when pm_runtime_resume_and_get() fails cause a
level-triggered IRQ storm or unclocked MMIO access during system suspend and
resume?

On Rockchip and Exynos platforms, the native DP controller interrupt is a
level-high interrupt (IRQ_TYPE_LEVEL_HIGH) requested with IRQF_ONESHOT.
Moving disable_irq() from analogix_dp_bridge_disable() to
analogix_dp_unbind() leaves dp->irq enabled across system suspend and resum=
e,
where rockchip_dp_pm_ops and exynos_dp_pm_ops use pm_runtime_force_suspend()
in dpm_suspend and pm_runtime_force_resume() in dpm_resume (outside the
dpm_suspend_noirq and dpm_resume_noirq window where device IRQs are masked).

If an interrupt fires when dp->dev is runtime-suspended and
dev->power.disable_depth > 0 (or if analogix_dp_resume() fails at runtime),
pm_runtime_resume_and_get() returns a negative error code such as -EACCES.
Returning IRQ_HANDLED here without clearing or masking the hardware interru=
pt
status registers causes irq_thread_fn() to increment desc->threads_handled
and irq_finalize_oneshot() to unmask the still-asserted level IRQ line. That
immediately re-triggers the interrupt while preventing note_interrupt() in
the spurious IRQ detector from ever disabling the screaming line.

Furthermore, if dev->power.usage_count > 1 during pm_runtime_force_suspend()
(such as when a later commit in this series, "drm/bridge: analogix_dp: Mana=
ge
pm runtime and IRQ for native HPD pin detection", holds a runtime PM
reference in analogix_dp_bind(), or when runtime PM is forbidden via sysfs),
pm_runtime_force_suspend() disables the DP clocks via analogix_dp_suspend()
while leaving runtime_status and last_status set to RPM_ACTIVE with
disable_depth > 0. In that state, rpm_resume() returns 1 and
pm_runtime_resume_and_get() returns 0, allowing analogix_dp_irq_thread() to
perform MMIO accesses on an unclocked controller.

> =20
>  	irq_type =3D analogix_dp_get_irq_type(dp);
>  	if (!dp->hpd_gpiod && irq_type)

[Severity: Medium]
If the device has actually runtime suspended before analogix_dp_irq_thread()
runs, won't pm_runtime_resume_and_get() wipe the pending interrupt status
registers before analogix_dp_get_irq_type() can read them?

When dp->dev is runtime suspended, pm_runtime_resume_and_get() invokes the
runtime resume callback (rockchip_dp_resume() or exynos_dp_resume() ->
analogix_dp_resume()):

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_resume() {
	...
	if (dp->plat_data->power_on)
		dp->plat_data->power_on(dp->plat_data);

	phy_set_mode(dp->phy, PHY_MODE_DP);
	phy_power_on(dp->phy);

	analogix_dp_init_dp(dp);
	...
}

On Rockchip, dp->plat_data->power_on() calls rockchip_dp_poweron() ->
rockchip_dp_pre_init(), which asserts and deasserts dp->rst and dp->apbrst,
wiping all controller registers.

On all platforms, analogix_dp_init_dp() then resets the controller and clea=
rs
all pending interrupts:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_init_dp() {
	analogix_dp_reset(dp);

	analogix_dp_swreset(dp);

	analogix_dp_init_analog_param(dp);
	analogix_dp_init_interrupt(dp);
	...
	analogix_dp_init_hpd(dp);
	analogix_dp_init_aux(dp);
}

Both analogix_dp_init_interrupt() and analogix_dp_init_hpd() explicitly cle=
ar
ANALOGIX_DP_COMMON_INT_STA_4 and ANALOGIX_DP_INT_STA. By the time
pm_runtime_resume_and_get() returns to analogix_dp_irq_thread(),
analogix_dp_get_irq_type() reads cleared registers (0), so irq_type is 0 and
the hotplug event is silently dropped. Note that the later commit in this
series ("drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD
pin detection") only keeps runtime PM active across bind/unbind on
RK3576_EDP and RK3588_EDP, leaving EXYNOS_DP, RK3288_DP, RK3399_EDP, and
other configurations susceptible to runtime suspend while the IRQ is enable=
d.

Conversely, when dp->hpd_gpiod is used, analogix_dp_get_irq_type() (as well
as analogix_dp_get_plug_in_status() in commit "drm/bridge: analogix_dp:
Declare DRM_BRIDGE_OP_HPD for hotplug reporting") only reads the GPIO level
via gpiod_get_value(dp->hpd_gpiod) and never touches DP controller MMIO
registers. Does analogix_dp_irq_thread() need to call
pm_runtime_resume_and_get() when dp->hpd_gpiod is present, since doing so
powers on, resets, and reinitializes the DP controller and PHY on every GPIO
HPD interrupt while the display is off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027132810.1746=
118-1-damon.ding@rock-chips.com?part=3D14
