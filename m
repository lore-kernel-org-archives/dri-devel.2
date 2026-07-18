Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7A9C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B416110E4D9;
	Sat, 18 Jul 2026 17:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CUAM55eL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB83D10E4D9
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:32:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7DB960018;
 Sat, 18 Jul 2026 17:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8081F000E9;
 Sat, 18 Jul 2026 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784395934;
 bh=2woI8UlJ/agzS+TZ9JB/DztVoJJwsqjhtQ7cir/nOKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CUAM55eLIwXYqjev9IbRZJSmqt92Pd+ceBZm2SO7ujhkzH/YeikFPBqtlpPoiPtie
 N9Ka8FnW5Nj1MVCHkPNgL53KfXKctxb//peqsdI/uHA8qYc26tLPGhu7hIKOMsNu1U
 TrfCun6DbHtrRIhQKaplZBUC1UutSTXFJ12MNu8aBoo3ejcIwHy1oTlo2BAKQ+jYwy
 9ZWBBtSeLlmKyYW8xTVRMlyBQ7Fnmu7eBD8JEqYOSC84tfoGrQrK3Nqfk76IHR8DRr
 FrnvTZbgGmzwLpUSijJgSSGI+lHSkoOLszyvLcav7pXeQXs9CFlINxkwrcc2pa86kw
 7sTFU6Rwi6BeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: it6505: Don't reject audio hw_params
 without an encoder
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <4efccd2179cadef2209ef6ecc0c898025276117d.1784393979.git.daniel@makrotopia.org>
References: <cover.1784393979.git.daniel@makrotopia.org>
 <4efccd2179cadef2209ef6ecc0c898025276117d.1784393979.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 17:32:13 +0000
Message-Id: <20260718173214.4C8081F000E9@smtp.kernel.org>
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
- [High] Uninitialized `channel_count` due to the early return can lead to =
an out-of-bounds stack array access in `it6505_enable_audio_infoframe()` if=
 a hotplug race condition occurs.
- [Medium] Returning early when `bridge.encoder` is NULL bypasses audio par=
ameter caching, causing DP audio to use stale or incorrect hardware paramet=
ers when a display is later hotplugged.
--

--- Patch [2]: [PATCH 2/2] drm/bridge: it6505: Don't reject audio hw_params=
 without an encoder ---
commit 716c566c9be6893ad8cd2b80d06ce9aa0a5b67df
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: Don't reject audio hw_params without an encoder

it6505_audio_setup_hw_params() returns -ENODEV when the bridge is not
attached to a DRM encoder. Now that it6505 registers an hdmi-audio-codec,
this callback runs whenever a stream is configured on the I2S DAI it is
wired to, including when that DAI is shared with another codec.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 698ae01b3a474..e88960c82a239 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2979,7 +2979,7 @@ static int it6505_audio_setup_hw_params(struct it65=
05 *it6505,
>  			     params->cea.channels);
> =20
>  	if (!it6505->bridge.encoder)
> -		return -ENODEV;
> +		return 0;

[Severity: High]
Can this early return lead to an out-of-bounds stack array access during a
hotplug race condition?

If the early return prevents it6505->audio.channel_count from being
initialized, it will remain 0. If the stream is unmuted and delayed_audio is
queued, a subsequent DP hotplug within 180ms could unblock it6505_irq_hpd().

If delayed_audio fires before it6505_irq_hpd() executes
it6505_variable_config() to set channel_count to 2, it will call
it6505_enable_audio_infoframe() with channel_count=3D0:

it6505_enable_audio_infoframe() {
        ...
        it6505_write(it6505, REG_AUD_INFOFRAM_DB3,
                     audio_info_ca[it6505->audio.channel_count - 1]);
        ...
}

Would this result in reading audio_info_ca[-1] from the stack?


[Severity: Medium]
Will returning early here bypass the audio parameter caching?

If an ALSA stream on a shared DAI is played with non-default parameters
while DP is disconnected, it6505_audio_setup_hw_params() will return 0 and
skip updating the it6505->audio state.

When a DP display is later hotplugged, could it6505_irq_audio_fifo_error()
auto-enable audio using stale or default parameters instead of the active
stream's parameters?

> =20
>  	if (params->cea.channels <=3D 1 || params->cea.channels > 8) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784393979.gi=
t.daniel@makrotopia.org?part=3D2
