Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084CCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6589B10E01F;
	Thu,  9 Jul 2026 11:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N1mGwHXe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4431C10E01F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:42:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E3F66001A;
 Thu,  9 Jul 2026 11:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F6C1F000E9;
 Thu,  9 Jul 2026 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597349;
 bh=ea25fSWQJ+PLUWKyg+knrAfpCEbYTM76MsTqOxi30sA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N1mGwHXecbs/9Yh026CbhukHj1jKjsBrlut/kJN4eo+HMiK3S+C49cEhgEmf+aYXM
 uPRUb+XeUd5dNyOFKbRwLZRpLwcAU2TXWTSQ1JqkqMOHpJnyDXeBGjp9l3UIHB3YSL
 ml7i5kZxmsFtBYxgfv2h2GHik3toBuCl3KeBe4jemDqd5I5zAPpLNAH3Z53tbkXWTz
 406CAAYKBYMu/R8U+rFtPNq54sX53Kckxa5pbu7lfBJgE3Cv9ifogiOoX8iMPuXrQz
 YiPrOh9KZYaUqwqXW717GcSVORbyaeotkFeR4zsDMbJlXuKmx4bvYB5lcL/kzKcqZW
 CRQHbIzeaN5LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] drm/mediatek: mtk_dp: Call
 pm_runtime_put_sync() in removal path
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709113148.49090-4-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:42:27 +0000
Message-Id: <20260709114228.32F6C1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Replacing `pm_runtime_put()` with `pm_runtime_put_sync()` sync=
hronously powers off the hardware before tearing down child devices, DRM br=
idges, and IRQs, causing system crashes when they access unpowered register=
s.

Pre-existing issues:
- [High] Using `timer_delete_sync()` instead of `timer_shutdown_sync()` in =
the remove path allows the timer to be re-armed by the concurrently active =
IRQ thread, leading to a use-after-free.
--

--- Patch [3]: [PATCH v4 03/12] drm/mediatek: mtk_dp: Call pm_runtime_put_s=
ync() in removal path ---
commit f976047da5b8089ab1d0475df94302360f23d7f2
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Call pm_runtime_put_sync() in removal path

Since pm_runtime_put() queues an asynchronous suspend, calling
pm_runtime_disable() right after will cancel the pending suspend
work.

Call pm_runtime_put_sync() instead during mtk_dp_remove() to
overcome to this issue, making sure that the suspend ops execute
and that the hardware correctly powers off before module unload.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index f656b85b84212..0d0507890d993 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2866,7 +2866,7 @@ static void mtk_dp_remove(struct platform_device *p=
dev)
>  {
>  	struct mtk_dp *mtk_dp =3D platform_get_drvdata(pdev);
> =20
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);

[Severity: Critical]
Does changing this to a synchronous put cause a regression where the
hardware is powered off before child devices and IRQs are torn down?

Because the driver uses a devm-managed IRQ, the interrupt can still fire
and execute mtk_dp_hpd_event() which reads hardware registers:

mtk_dp_hpd_event() {
        u32 irq_status =3D mtk_dp_swirq_get_clear(mtk_dp) |
                         mtk_dp_hwirq_get_clear(mtk_dp);
        ...
}

Additionally, child platform devices like the audio codec are still active.
If they are torn down later and trigger mtk_dp_audio_shutdown(), it also
accesses hardware:

mtk_dp_audio_shutdown() {
        mtk_dp_audio_mute(mtk_dp, true);
        ...
}

Will accessing these registers after the PM domain is synchronously powered
down result in a bus fault or system crash? Should the PM operations be
moved to the end of the teardown process after explicitly disabling IRQs
and unregistering child devices?

>  	pm_runtime_disable(&pdev->dev);
>  	if (mtk_dp->data->bridge_type !=3D DRM_MODE_CONNECTOR_eDP)
> -		timer_delete_sync(&mtk_dp->debounce_timer);
> +		timer_delete_sync(&mtk_dp->debounce_timer);

[Severity: High]
This is a pre-existing issue, but could this timer_delete_sync() result in
a use-after-free?

Since the hardware interrupt is managed by devres, it remains active
throughout mtk_dp_remove(). If the IRQ thread is executing concurrently,
it can unconditionally re-arm the timer:

mtk_dp_hpd_event_thread() {
        ...
        mod_timer(&mtk_dp->debounce_timer,
                  jiffies + msecs_to_jiffies(100) - 1);
}

If mod_timer() is called right after timer_delete_sync() finishes, the
timer is successfully re-armed. Once mtk_dp_remove() returns, devres will
free the mtk_dp structure. When the timer expires, won't it access freed
memory?

Should this be updated to use timer_shutdown_sync() instead to permanently
prevent the timer from being re-armed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709113148.4909=
0-1-angelogioacchino.delregno@collabora.com?part=3D3
