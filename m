Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70C6C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114F510E9B3;
	Mon, 20 Jul 2026 16:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MAu1qKg1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCF210E9B3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 16:06:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92605405EA;
 Mon, 20 Jul 2026 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9581F000E9;
 Mon, 20 Jul 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784563604;
 bh=TnCCxKQTIbg/rpbFFgLp/hNHJfvP1lAi32pZPDQ61Ew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MAu1qKg1QHu6azOZxv8ebiDOx6s1IeyrHEkGqI4k1t5Foxi4CIloZjkg9pPtAQV3N
 Gco5swtEzvPKy8EZvY3sjP0QiVJ9El1CT3a2SoqKVg5ejpNclB8fDu0I7rOn5sKNuH
 zEB7gdNwB/BbGXA5OpR/zrR5z57+ixVTehQ/nkuPULPYerkAk+xcs3cnX39c2fwwMg
 qWX850QauLTEJCHFd0WblYKuzAQ6teq2HqkE4iN0e+v2OZMvTNlT3N+OVd32Ntk/L0
 Ao8yfqRUnghfwyfWg141gBX3/2vrYsiOACp9oFZqy+F1rrfK7iaEp+LJ4kl1eLNWQG
 6UHqmECe/7ORQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/bridge: it6505: Don't reject audio hw_params
 without an encoder
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <11d86a39a66ad81f29bb6d9274419e993d58337a.1784561622.git.daniel@makrotopia.org>
References: <cover.1784561622.git.daniel@makrotopia.org>
 <11d86a39a66ad81f29bb6d9274419e993d58337a.1784561622.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:06:43 +0000
Message-Id: <20260720160644.4C9581F000E9@smtp.kernel.org>
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
- [High] Missing bounds check for `channel_count =3D=3D 0` causes an out-of=
-bounds stack read in `it6505_enable_audio_infoframe`.
- [High] Missing cancellation of workqueues in the driver's remove path lea=
ds to Use-After-Free.
--

--- Patch [2]: [PATCH v2 2/2] drm/bridge: it6505: Don't reject audio hw_par=
ams without an encoder ---
commit 283dcf1804abd2952ffc7edbd9e7c45ae0570f87
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: Don't reject audio hw_params without an encoder

This commit drops the encoder check in it6505_audio_setup_hw_params() so
stream parameters are always cached. Previously, returning early left
it6505->audio.channel_count at 0, which could cause an out-of-bounds access
if a display was hotplugged while a stream was running.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index d84441926e8e0..e20edbbb7c133 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2979,9 +2979,6 @@ static int it6505_audio_setup_hw_params(struct it65=
05 *it6505,
>  			     params->sample_rate, params->sample_width,
>  			     params->cea.channels);
> =20
> -	if (!it6505->bridge.encoder)
> -		return -ENODEV;
> -

[Severity: High]
This is a pre-existing issue, but if the SoC's I2S controller continuously
drives clocks (e.g. from an active shared speaker backend), could the IT6505
hardware audio FIFO overflow and trigger the INT_AUDIO_FIFO_ERROR interrupt
before ALSA configures the audio stream parameters?

If this happens, it6505_irq_audio_fifo_error() would call
it6505_enable_audio_infoframe() while it6505->audio.channel_count is still 0
(zero-initialized during probe).=20

In it6505_enable_audio_infoframe(), it6505->audio.channel_count - 1 evaluat=
es
to -1, causing an out-of-bounds stack read:

    audio_info_ca[it6505->audio.channel_count - 1]);

>  	if (params->cea.channels <=3D 1 || params->cea.channels > 8) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
>  				     it6505->audio.channel_count);

[Severity: High]
This is a pre-existing issue, but does the driver's remove path miss cancel=
ling
several workqueues, leading to a potential use-after-free?

In it6505_i2c_remove():

    static void it6505_i2c_remove(struct i2c_client *client)
    {
        struct it6505 *it6505 =3D i2c_get_clientdata(client);

        platform_device_unregister(it6505->audio_pdev);
        cancel_delayed_work_sync(&it6505->delayed_audio);
        drm_bridge_remove(&it6505->bridge);
        drm_dp_aux_unregister(&it6505->aux);
        it6505_debugfs_remove(it6505);
        it6505_poweroff(it6505);
        it6505_remove_edid(it6505);
    }

Only delayed_audio is explicitly cancelled.=20

If other background work items (link_works, hdcp_wait_ksv_list, hdcp_work,
extcon_wq) are pending or running when the device is unbound, could they ac=
cess
the it6505 structure after it has been automatically freed by devres?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784561622.gi=
t.daniel@makrotopia.org?part=3D2
