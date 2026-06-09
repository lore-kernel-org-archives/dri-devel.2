Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305BCD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321B010E2AF;
	Tue,  9 Jun 2026 13:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kk8//qlO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C645210E2AF
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:19:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1869601DC;
 Tue,  9 Jun 2026 13:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E961F00893;
 Tue,  9 Jun 2026 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781011180;
 bh=VHnUMXaKMgmTCLPobXcvNC2mI+uZWn5dBhC0nj908Sw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kk8//qlOGPmyZPD1Y/8VkWDyTXUpWaI4EtApdZgPymQVUlAIjMSwoAIzeb6oeKA1J
 /8foNdCrk08cQVoNS3xMA+M0xLrGYv1MlLo5tERyMhqt/8wOX/2S/AaskKWm7ChdQI
 fA3FnqEpqj/15mijozgXpQOEpQyL/2mNPqKchZdhM39nlOceESEEo5YKeUZiBx8D0V
 ZuuSf3kvhumAvcrBLbG/F2wGnzcImqkt4/xAz1ElidddURIALO4pmfc7fY4Q2wtYiB
 QvXAJe/4WAirA48QpCsHv8h4u9NMUEZdWiFEe/byogFt/0A/mN6x6/ci4IB/Pq49+C
 HRVKm4RFff+QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/arm/malidp: use clk_bulk API in runtime PM
 resume and suspend
To: =?utf-8?b?R3VzdGF2byBLZW5qaSBNZW5kb27Dp2EgS2FuZWtv?= <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609130812.1065699-1-kaneko.dev@pm.me>
References: <20260609130812.1065699-1-kaneko.dev@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 13:19:39 +0000
Message-Id: <20260609131940.75E961F00893@smtp.kernel.org>
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
- [High] Unhandled error from malidp_runtime_pm_resume() and pm_runtime_get=
_sync() leads to kernel panic.
- [High] Missing synchronize_irq() in the runtime PM suspend path for share=
d IRQs causes a race condition.
- [High] Asynchronous pm_runtime_put() races with pm_runtime_disable(), lea=
ving the hardware in an incorrect power state.
--

commit 15b02ca295e5d2b2ae68c0ebcf65a7fa13cad1b6
Author: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>

drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
   =20
malidp_runtime_pm_resume() calls clk_prepare_enable() three times
without checking the return value. If any clock fails to enable, the
driver silently proceeds with unclocked hardware, leading to undefined
behavior.

> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malid=
p_drv.c
> index 9abe800f598ac..23fa942ae4bbe 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -670,6 +670,11 @@ static int malidp_runtime_pm_suspend(struct device *=
dev)
[ ... ]
>  	malidp_se_irq_fini(hwdev);
>  	malidp_de_irq_fini(hwdev);
>  	hwdev->pm_suspended =3D true;
> -	clk_disable_unprepare(hwdev->mclk);
> -	clk_disable_unprepare(hwdev->aclk);
> -	clk_disable_unprepare(hwdev->pclk);
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);

[Severity: High]
This is a pre-existing issue, but does this missing synchronize_irq() in the
runtime PM suspend path for shared IRQs cause a race condition?

The driver registers its DE and SE interrupts with IRQF_SHARED.

If a shared interrupt triggers concurrently on another CPU, could the IRQ
handler (malidp_se_irq() or malidp_de_irq()) pass the pm_suspended check
just before the clocks are disabled here, and then attempt to read
hardware registers while the clocks are off, resulting in a synchronous
external abort?

>  	return 0;
>  }
> @@ -689,10 +692,17 @@ static int malidp_runtime_pm_resume(struct device *=
dev)
[ ... ]
> +	err =3D clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
> +	if (err)
> +		return err;

[Severity: High]
This isn't a bug introduced by this patch, but since we are now correctly
propagating the clock enablement error from malidp_runtime_pm_resume(), do =
we
need to update the callers to handle it?

In malidp_bind(), the code ignores the return value:

	if (pm_runtime_enabled(dev))
		pm_runtime_get_sync(dev);
	else
		malidp_runtime_pm_resume(dev);

	ret =3D hwdev->hw->query_hw(hwdev);

If clock enablement fails, it seems the driver unconditionally proceeds
to read hardware registers (e.g., in query_hw()). Could this cause a
synchronous external abort when it accesses unclocked hardware?

Similarly, malidp_pm_resume_early() does not check the return value
and proceeds to mark the device as active:

static int __maybe_unused malidp_pm_resume_early(struct device *dev)
{
	malidp_runtime_pm_resume(dev);
	pm_runtime_set_active(dev);
	return 0;
}

[Severity: High]
This is a pre-existing issue, but does the asynchronous pm_runtime_put()
race with pm_runtime_disable() in the driver removal paths?

In malidp_bind() (on the query_hw_fail error unroll path):

query_hw_fail:
	pm_runtime_put(dev);
	if (pm_runtime_enabled(dev))
		pm_runtime_disable(dev);
	else
		malidp_runtime_pm_suspend(dev);

And similarly in malidp_unbind():

	pm_runtime_put(dev);
	if (pm_runtime_enabled(dev))
		pm_runtime_disable(dev);
	else
		malidp_runtime_pm_suspend(dev);

Because pm_runtime_put() queues an asynchronous idle notification, the
subsequent pm_runtime_disable() barrier could cancel the pending suspend
request before it completes.

Could this leave the device's clocks enabled indefinitely after the driver
is unloaded? Should this use pm_runtime_put_sync() instead?

> =20
> -	clk_prepare_enable(hwdev->pclk);
> -	clk_prepare_enable(hwdev->aclk);
> -	clk_prepare_enable(hwdev->mclk);
>  	hwdev->pm_suspended =3D false;
>  	malidp_de_irq_hw_init(hwdev);
>  	malidp_se_irq_hw_init(hwdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609130812.1065=
699-1-kaneko.dev@pm.me?part=3D1
