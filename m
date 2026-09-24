Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1642C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4E010F749;
	Thu, 24 Sep 2026 19:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kBgOKafZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B54410F749
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:01:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E009A403AF;
 Thu, 24 Sep 2026 19:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25911F000FF;
 Thu, 24 Sep 2026 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790276478;
 bh=pikNbJ+t/doj+FzzMRIaV1f6mNTlxdWMyA1RgUlXbhM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kBgOKafZte2b/BVrjCfjVJW20JOw2K+EO4viLN0bJaDbzm0+WH19X6M1l+OHroEnw
 1LeHOvInVGX5TUR4if+56pZkcmvsQxUCQ4wZbFCmnqCH97oR8E/r4adzGzADVH4GXR
 11jnNmEzQgQdH+qKE2OWZ9KLaYLAcNyt01S8Y2exLRhkBdFltKv/4QGQ3pSBjxDHYq
 3ujgUVZ3GhWFvUSP+SXbJazdO936lqWcOGUsUnzY2ZcJzAjgd+RhquDv0pD8RLhs3O
 EDShEWvUuX31KSy9KHNxzrqsyL5ZG+qRVd/9dpA6q+c3abgoZcoQ12f+CvvRxHpNkY
 ctsWH3KYa2zAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <9467f1fde989ec3914344c129a039fe7b7ed91e1.1790275151.git.daniel@makrotopia.org>
References: <cover.1790275151.git.daniel@makrotopia.org>
 <9467f1fde989ec3914344c129a039fe7b7ed91e1.1790275151.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:01:18 +0000
Message-Id: <20260924190118.A25911F000FF@smtp.kernel.org>
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
- [High] drm/bridge: it6505: missing audio_lock in it6505_poweron() causes =
I2C data race
--

commit 180d8c850bc807b0a0b106e27c0aef15c059c696
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support
   =20
This commit adds audio support for the it6505 bridge. It registers
an "hdmi-audio-codec" platform device, wires up audio helpers, and
introduces an audio_lock mutex to serialize audio enable/disable
against other tasks.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2823,6 +2829,8 @@ static int it6505_poweroff(struct it6505 *it6505)
>  	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
>  	cancel_delayed_work_sync(&it6505->hdcp_work);
> =20
> +	mutex_lock(&it6505->audio_lock);
> +
>  	if (pdata->gpiod_reset)
>  		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
> =20
> @@ -2842,6 +2850,7 @@ static int it6505_poweroff(struct it6505 *it6505)
> =20
>  	it6505->powered =3D false;
>  	it6505->sink_count =3D 0;
> +	mutex_unlock(&it6505->audio_lock);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -2988,25 +2997,28 @@ static void it6505_remove_notifier_module(struct =
it6505 *it6505)
>  	flush_work(&it6505->extcon_wq);
>  }
> =20
> -static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
> +static void it6505_delayed_audio(struct work_struct *work)
>  {
>  	struct it6505 *it6505 =3D container_of(work, struct it6505,
>  					     delayed_audio.work);
> =20
>  	DRM_DEV_DEBUG_DRIVER(it6505->dev, "start");
> =20
> -	if (!it6505->powered)
> +	if (it6505->enable_drv_hold)
>  		return;
> =20
> -	if (!it6505->enable_drv_hold)
> -		it6505_enable_audio(it6505);
> +	mutex_lock(&it6505->audio_lock);
> +	if (it6505->powered && !it6505->audio.mute)
> +		__it6505_enable_audio(it6505);
> +	mutex_unlock(&it6505->audio_lock);
>  }

[Severity: High]
Does it6505_poweron() need to take the new audio_lock as well?

While this patch adds audio_lock to it6505_poweroff() to serialize with the
new it6505_delayed_audio() worker, it6505_poweron() sets it6505->powered =
=3D true
and performs hardware initialization without holding the lock:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_poweron() {
    ...
	it6505->powered =3D true;
	it6505_reset_logic(it6505);
	it6505_int_mask_enable(it6505);
	it6505_init(it6505);
    ...
}

If a device is runtime resumed and it6505_poweron() is called, could
it6505_delayed_audio() run concurrently? Since it6505->powered is set to tr=
ue
early, it6505_delayed_audio() can acquire the audio_lock and execute
__it6505_enable_audio() while it6505_poweron() is still doing
it6505_reset_logic() and it6505_init().

For example, this sequence might occur when the bridge is powered off and an
ALSA stream is unmuted, queuing it6505_delayed_audio() with a 180ms delay.
If the device is runtime resumed shortly after (e.g., via cable hotplug),
it invokes it6505_poweron().

If it6505_delayed_audio() fires exactly as it6505_poweron() sets
it6505->powered =3D true, it can grab the audio_lock and begin I2C writes.
Meanwhile, it6505_poweron() continues concurrently because it doesn't take
the audio_lock.

Can this lead to a regression where the audio configuration is wiped out or
causes general I2C race conditions since the __it6505_enable_audio()=20
configuration could be interleaved with it6505_init() or wiped out by the=20
ALL_LOGIC_RESET in it6505_reset_logic()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790275151.gi=
t.daniel@makrotopia.org?part=3D13
