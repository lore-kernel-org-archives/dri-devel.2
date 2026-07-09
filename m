Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40884C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD55110F512;
	Thu,  9 Jul 2026 11:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O7nxkOYg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F4810F512
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:49:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEE776001A;
 Thu,  9 Jul 2026 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B611F000E9;
 Thu,  9 Jul 2026 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597740;
 bh=05L0JJIY6mJX59erNIBr+MFmvKx8LMAmktooty4tt3o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O7nxkOYg3MTRciY2sRmixAqgTCig7KnmTOL+gfIB/UP7vyrMPxWZK1Bqn18iN979P
 OtsH2AOssHYDbFqcVkAwWOt5SZEkCx66Jnyqzs4lXTV7LoSbagTSMKgY6SBwXNgf7x
 OCIh9c3IwFAURJrjkyRcVXl+Hby2y39LCL5/i7R3Se27hKUJ872LToZHuDwqCIUkUZ
 SoC7ymmahweZ5LzmI7Mct00hREHHGXWXtieP1a+MM1QSGX+qslljl6pqJdREcOF1KN
 JYp9MCs7HAQaaVXb3i2g310I7pk2IksRbwdmh85LTfKVo1P9Va98k0q5N6Dmt2deCk
 WUZcs09R+70VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709113148.49090-5-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:48:59 +0000
Message-Id: <20260709114900.41B611F000E9@smtp.kernel.org>
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
- [High] The hardware interrupt is not disabled during driver unbind (`mtk_=
dp_remove`), allowing the IRQ handler and thread to execute while resources=
 are being destroyed, leading to use-after-free, timer re-arming, and bus e=
rrors.
- [High] The ALSA `get_eld` callback can dereference a NULL `mtk_dp->conn` =
if called between a hotplug event and a DRM modeset.
--

--- Patch [4]: [PATCH v4 04/12] drm/mediatek: mtk_dp: Fix hdmi codec and ph=
y driver unregistration ---
commit 6ce33bac50c12bbd077cc2e659b77509b20cd720
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration

This commit converts the unregistration of the HDMI Codec and DisplayPort P=
HY
platform devices to use devm actions. This ensures they are properly cleaned
up even during probe deferrals or failures.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 0d0507890d993..8399a6b411689 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -2680,18 +2687,28 @@ static int mtk_dp_register_audio_driver(struct de=
vice *dev)
>  		.data =3D mtk_dp,
>  		.no_capture_mute =3D 1,
>  	};
> +	int ret;
> =20
>  	mtk_dp->audio_pdev =3D platform_device_register_data(dev,
>  							   HDMI_CODEC_DRV_NAME,
>  							   PLATFORM_DEVID_AUTO,
>  							   &codec_data,
>  							   sizeof(codec_data));

[Severity: High]
This is a pre-existing issue, but does the ALSA get_eld callback have a
potential NULL pointer dereference race with hotplug events?

When a display is plugged in, mtk_dp_hpd_event_thread() unconditionally sets
the enabled flag before the DRM core populates mtk_dp->conn during a modese=
t:

mtk_dp_hpd_event_thread()
    ...
    mtk_dp->enabled =3D true;

If userspace or the sound subsystem queries the ELD via mtk_dp_audio_get_el=
d()
in the window between the hotplug event and the DRM modeset, it seems we
dereference mtk_dp->conn without checking if it is NULL:

mtk_dp_audio_get_eld()
    if (mtk_dp->enabled)
        memcpy(buf, mtk_dp->conn->eld, len);

Could this lead to a crash if a local user probes ALSA mixers before the
modeset completes?

[ ... ]
> @@ -2870,9 +2890,6 @@ static void mtk_dp_remove(struct platform_device *p=
dev)
>  	pm_runtime_disable(&pdev->dev);
>  	if (mtk_dp->data->bridge_type !=3D DRM_MODE_CONNECTOR_eDP)
>  		timer_delete_sync(&mtk_dp->debounce_timer);
> -	platform_device_unregister(mtk_dp->phy_dev);
> -	if (mtk_dp->audio_pdev)
> -		platform_device_unregister(mtk_dp->audio_pdev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying driver
removal, is there a risk of the hardware interrupt firing during or after
mtk_dp_remove()?

The hardware interrupt is managed by devres and remains active until after
mtk_dp_remove() returns. Since pm_runtime_disable() is called here, the
device power domain might be turned off.

If a hotplug interrupt fires during this window, mtk_dp_hpd_event() will
attempt to read hardware registers:

mtk_dp_hpd_event()
    u32 irq_status =3D mtk_dp_swirq_get_clear(mtk_dp) |
                     mtk_dp_hwirq_get_clear(mtk_dp);

Could this cause a bus error or crash if the power domain is already off?

Furthermore, if the interrupt handler schedules the IRQ thread,
mtk_dp_hpd_event_thread() could re-arm the debounce timer or attempt to
access the PHY during training after it has been unregistered by devres,
leading to a use-after-free:

mtk_dp_hpd_event_thread()
    /* Training */
    ret =3D mtk_dp_training(mtk_dp);

Should the IRQ be explicitly disabled in mtk_dp_remove() before deleting
the timers and disabling pm runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709113148.4909=
0-1-angelogioacchino.delregno@collabora.com?part=3D4
