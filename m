Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4387AC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C78610EF1F;
	Tue,  1 Sep 2026 20:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wbf4crxE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1894710EF1F
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:17:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EDAB6022E;
 Tue,  1 Sep 2026 20:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E6B1F000E9;
 Tue,  1 Sep 2026 20:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788293845;
 bh=smhDEfC12MEZA/NJarLx2eOIC5aQwJ+j6eKrLuBuhF8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wbf4crxEE9V29tm/pVv6spK/ZrsLU/1oKuy2ECjmvB0F7C3h9vX3yQpOl5nRsSmo5
 boX6kmfz6t6/F/IPZDjNwZcVSAfc1ZSuqgI2IrwTzD5AOsJjSOQeQje+kNRs+Bg0NY
 IaAdczOtHCrv6IOogN4/hX8Zs/LZyBiKl5e+62pE8xFB2oxnbMk9XcD5A7LUQ5rD6b
 Ggawy+9SEc6dRui2SqG0QpxX0AiC3Ms+bfVB8VBnROoeCKGrbFd03ywIiuHdOhILPG
 +IGuM/tl/Ex1RxYqsrIt5pkNRgA6szzHD0ck/Jm64/PHfUAX7lRl4hDpJY1Xe8x1PQ
 Gzwp1k1u5wZqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 50/74] drm/bridge: adv7511: Advertise HDMI 1.2
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-50-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-50-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:17:24 +0000
Message-Id: <20260901201724.D2E6B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IRQ disablement and workqueue cancellation in driver remov=
al and probe error paths.
--

commit e3d22519d26e84f17c45f704d4c2a1fc871e1036
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: adv7511: Advertise HDMI 1.2 capabilities

Bridges using DRM_BRIDGE_OP_HDMI are now expected to provide a supported
HDMI version. This commit advertises HDMI 1.2 as the supported version
and sets the bridge's max_tmds_char_rate. It also drops the redundant
adv7511_bridge_hdmi_tmds_char_rate_valid() hook.

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 038b852405b54..c3ef44074477b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c

[ ... ]

> @@ -1359,6 +1341,8 @@ static int adv7511_probe(struct i2c_client *i2c)
> =20
>  	adv7511->bridge.vendor =3D "Analog";
>  	adv7511->bridge.product =3D adv7511->info->name;
> +	adv7511->bridge.supported_hdmi_ver =3D HDMI_VERSION_1_2;
> +	adv7511->bridge.max_tmds_char_rate =3D 1000ULL * adv7511->info->max_mod=
e_clock_khz;
> =20
>  #ifdef CONFIG_DRM_I2C_ADV7511_AUDIO

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free in the error handling and driver removal paths of this drive=
r.

In adv7511_probe(), the driver registers a shared interrupt via
devm_request_threaded_irq() and initializes adv7511->hpd_work.
However, in the err_unregister_audio probe error path, the devm-managed
IRQ can still fire because the resources are manually freed before the
devm cleanup runs:

adv7511_probe() {
    ...
err_unregister_audio:
	drm_bridge_remove(&adv7511->bridge);
	i2c_unregister_device(adv7511->i2c_cec);
	clk_disable_unprepare(adv7511->cec_clk);
err_i2c_unregister_packet:
	i2c_unregister_device(adv7511->i2c_packet);
    ...
}

Similarly, adv7511_remove() manually unregisters I2C devices while the
devm-managed IRQ remains active until devres cleanup:

adv7511_remove() {
    ...
	i2c_unregister_device(adv7511->i2c_cec);
	clk_disable_unprepare(adv7511->cec_clk);

	i2c_unregister_device(adv7511->i2c_packet);
	i2c_unregister_device(adv7511->i2c_edid);
    ...
}

Could a hotplug or CEC interrupt firing during or just after these
cleanup paths attempt to access the freed I2C clients?

Furthermore, since cancel_work_sync() is never called for hpd_work, could
any scheduled work execute after the adv7511 structure has been freed by
devres, leading to memory corruption or a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D50
