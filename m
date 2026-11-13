Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8311606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbsdM43R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3AB10EC0E;
	Fri, 13 Nov 2026 08:50:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C97710EC0E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:50:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3551F43B6D;
 Fri, 13 Nov 2026 08:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02831F000C4;
 Fri, 13 Nov 2026 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559824;
 bh=vR+jY+drmaGWZO9DLL22TvgEhyf7XsILXQsZRgYRlj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VbsdM43R8zn1uN3OjaoEt3efWyUIAwk1m13eVcFJGI6YWZq1w5kWCyiEMvn7j7NQx
 N7bXY1ahNMZiCspxUF32PHtGsrTVgHnHvNl4AYdGwyRC6HbzqroVJbEtHmTq9hTZ+x
 xVlq0isJMKEV5RmSNC1qdbORio+fqh00/9y53hX8rVcAUe9/MFHdXgHvMOI5qPd9Fj
 GwhHiMKX3mBGlNK//1UQbILX9Ve+Gqv1QVghEFTsb0TTj5oMuf3c4a7imd4GlMV05f
 kb+5O5rsg9sagM80Fh6sXOgP5ojazYKTF4UpZw+gUMwyy5vjIwRVytmef5Oi+bJIMm
 yzIYuVvrGRA7g==
Message-ID: <sashiko-outbox-212466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/18] drm/bridge: analogix_dp: Move IRQ
 enable/disable to bind/unbind
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-15-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-15-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:50:23 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/bridge: analogix_dp: IRQ storm and unclocked MMIO on PM
  suspend
--

commit a4a512968af1f8f658769af2378618f972e953d9
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Move IRQ enable/disable to bind/unbind

This commit moves enable_irq() and disable_irq() from the bridge enable and
disable callbacks to analogix_dp_bind() and analogix_dp_unbind(), and
converts the interrupt handler to a threaded handler that acquires a
runtime PM reference.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index b14a8aa12394e..7f6346d45a01c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -700,24 +700,25 @@ static int analogix_dp_enable_scramble(struct analo=
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
> +	 * The device may have been runtime suspended since the interrupt was
> +	 * raised. Hold a runtime PM reference before touching the registers,
> +	 * as the controller clocks are only guaranteed to be enabled while
> +	 * the device is runtime PM active. The GPIO HPD mode needs no such
> +	 * reference, since it only reads the GPIO level.
> +	 */
> +	if (!dp->hpd_gpiod) {
> +		ret =3D pm_runtime_resume_and_get(dp->dev);
> +		if (ret)
> +			return IRQ_HANDLED;
> +	}
> =20
>  	irq_type =3D analogix_dp_get_irq_type(dp);
>  	if (!dp->hpd_gpiod && irq_type)

[Severity: High]
Can analogix_dp_irq_thread() race with pm_runtime_force_suspend() during
system sleep, or trigger an interrupt storm when pm_runtime_resume_and_get()
fails?

Both rockchip_dp_pm_ops and exynos_dp_pm_ops use DEFINE_RUNTIME_DEV_PM_OPS(=
),
which wires pm_runtime_force_suspend() and pm_runtime_force_resume() as the
system sleep callbacks. Previously, analogix_dp_bridge_disable() called
disable_irq(dp->irq) during drm_mode_config_helper_suspend() before
pm_runtime_force_suspend() ran. Keeping dp->irq enabled across bind/unbind
leaves the interrupt active during dpm_suspend() and dpm_resume():

CPU0                                    CPU1
analogix_dp_irq_thread()
  pm_runtime_resume_and_get(dp->dev)
                                        pm_runtime_force_suspend(dp->dev)
                                          pm_runtime_disable(dp->dev)
                                          ...
                                          analogix_dp_suspend(dp)
                                            clk_disable_unprepare(dp->clock)
  analogix_dp_get_irq_type(dp)
    readl(dp->reg_base + ...)  <-- unclocked MMIO access

pm_runtime_disable() waits for in-flight runtime PM transitions, not active
usage_count holders, so analogix_dp_suspend() gates the controller clocks
while analogix_dp_irq_thread() accesses registers, causing an external abort
on ARM64. In addition, when pm_runtime_need_not_resume() is false during
pm_runtime_force_suspend() (whenever usage_count > 1), the clocks are turned
off without setting the runtime status to RPM_SUSPENDED; if an interrupt
fires before suspend_device_irqs() or after resume_device_irqs(),
pm_runtime_resume_and_get() sees RPM_ACTIVE and returns 0 while the clocks
are still gated.

Separately, when dp->dev is runtime-suspended and pm_runtime_resume_and_get=
()
fails (for example, returning -EACCES while runtime PM is disabled by
pm_runtime_force_suspend()), returning IRQ_HANDLED without clearing the
level-triggered interrupt status causes irq_finalize_oneshot() to unmask the
still-asserted IRQ line, re-triggering analogix_dp_irq_thread() in a tight
loop while preventing the spurious IRQ detector from disabling the line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D14
