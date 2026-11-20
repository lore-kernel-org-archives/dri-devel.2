Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87197606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwiYZhxe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B616B10E8A4;
	Fri, 20 Nov 2026 00:23:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AB610E8A4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 00:23:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5606C601D7;
 Fri, 20 Nov 2026 00:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6B11F000C6;
 Fri, 20 Nov 2026 00:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795134181;
 bh=lunv6wnsibEvo5DNcAsgxnZ91lhiZ8MdD0eb0YGrLoE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mwiYZhxeNPpEn96LtiVqymgHy8qvMI26zpCNgDeAICt1VJ7Edt9pfxxc09xYqaNeT
 IzoqoAQkAP46o4+UOmO+kGCWcwGBIFLcJzbBUfFttIrQr6b/+BpmH5JBD96QxUVwJR
 Qg0Urx+A++UZ2yseBI+XsXeUroCPoCnQiICgNZ2QiHDpdgpW0u9kedCDqkb1nFSJyH
 IELOwTEhemoN/NPWsCE0fqyRxrMEVPeyEf7z0MWVj3T38BVqxJ8rm0bJ7cUy97Fog5
 924L3vFqvSP9027XOxkad6R/W0cMa2LaBEZmhj5MoP9vI80CylN5RA4RzPw9rk4kr6
 fkc5MJPfJyVSg==
Message-ID: <sashiko-outbox-224265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/14] drm/bridge: it6505: Add audio support
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <9fa6e149442b5f7294814762b858ecabc3db4d38.1795132452.git.daniel@makrotopia.org>
References: <cover.1795132452.git.daniel@makrotopia.org>
 <9fa6e149442b5f7294814762b858ecabc3db4d38.1795132452.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 00:23:00 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/bridge: it6505: audio not enabled in
  it6505_link_train_ok() when unmuted
- [Medium] drm/bridge: it6505: unlocked chip reset in
  it6505_process_hpd_irq()
- [Medium] drm/bridge: it6505: uncanceled delayed_audio on HPD low in
  it6505_irq_hpd()
--

commit 9525a8456c7b3a8b8b712a90e98e5ba9c8adfe1a
Author: Jiaxin Yu <jiaxin.yu@mediatek.com>

drm/bridge: it6505: Add audio support

This commit registers an hdmi-audio-codec platform device for it6505, wires
up the hdmi_codec_ops callbacks, and serializes audio state and hardware
register updates with an audio_lock mutex.

Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek=
.com/

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 2da58d94127c3..eedc46eaf974b 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c

[ ... ]

> @@ -2326,19 +2337,12 @@ static void it6505_stop_link_train(struct it6505 =
*it6505)
> =20
>  static void it6505_link_train_ok(struct it6505 *it6505)
>  {
> -	struct device *dev =3D it6505->dev;
> -
>  	it6505->link_state =3D LINK_OK;
>  	/* disalbe mute enable avi info frame */
>  	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, 0x00);
>  	it6505_set_bits(it6505, REG_INFOFRAME_CTRL,
>  			EN_VID_CTRL_PKT, EN_VID_CTRL_PKT);
> =20
> -	if (it6505_audio_input(it6505)) {
> -		DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
> -		it6505_enable_audio(it6505);
> -	}
> -
>  	if (it6505->hdcp_desired)
>  		it6505_start_hdcp(it6505);
>  }

[Severity: Medium]
Does removing audio enablement from it6505_link_train_ok() completely leave
audio disabled in hardware whenever link training finishes after the ALSA
stream is already unmuted?

With this removal, __it6505_enable_audio() is only called from
it6505_delayed_audio() (scheduled once, 180 ms after it6505_audio_mute()
unmutes the stream) and from it6505_irq_audio_fifo_error() (which cannot
fire while AUDIO_RESET is asserted and M_AUDIO_I2S_EN is cleared).  If an
active stream is interrupted by an HPD low-to-high pulse (where
it6505_irq_hpd() calls it6505_disable_audio()), or if ALSA unmutes the
stream more than 180 ms before it6505_poweron() and link training complete,
it6505->audio.mute is false when it6505_link_train_ok() runs, yet nothing
re-enables audio.

Should it6505_link_train_ok() still enable audio (or schedule
it6505->delayed_audio) when !it6505->audio.mute?

[ ... ]

> @@ -2785,11 +2791,13 @@ static int it6505_poweron(struct it6505 *it6505)
>  		usleep_range(25000, 35000);
>  	}
> =20
> +	mutex_lock(&it6505->audio_lock);
>  	it6505->powered =3D true;
>  	it6505_reset_logic(it6505);
>  	it6505_int_mask_enable(it6505);
>  	it6505_init(it6505);
>  	it6505_lane_off(it6505);
> +	mutex_unlock(&it6505->audio_lock);
> =20
>  	enable_irq(it6505->irq);

[Severity: Medium]
it6505_poweron() holds it6505->audio_lock across it6505_reset_logic(),
it6505_int_mask_enable(), and it6505_init(), but what about
it6505_process_hpd_irq()?

drivers/gpu/drm/bridge/ite-it6505.c:it6505_process_hpd_irq() {
    ...
	if (it6505->branch_device && dpcd_sink_count !=3D it6505->sink_count) {
		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
		it6505->sink_count =3D dpcd_sink_count;
		it6505_reset_logic(it6505);
		it6505_int_mask_enable(it6505);
		it6505_init(it6505);
		it6505_remove_edid(it6505);
		return 0;
	}
    ...
}

When a branch device signals a downstream sink-count change via HPD_IRQ,
this runs the same ALL_LOGIC_RESET and register init sequence while
it6505->powered is true without holding it6505->audio_lock, so it can
interleave with __it6505_enable_audio() or __it6505_disable_audio() and
corrupt the audio, mute, and InfoFrame register configuration.

[ ... ]

> @@ -2979,25 +2990,28 @@ static void it6505_remove_notifier_module(struct =
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

[Severity: Medium]
Can it6505_delayed_audio() re-enable audio and Audio InfoFrames after HPD
has gone low and the link has been shut down?

CPU0                              CPU1
it6505_audio_mute(..., false, ...)
  it6505->audio.mute =3D false
  queue_delayed_work(...,
    &it6505->delayed_audio, 180ms)
                                  it6505_int_threaded_handler()
                                    it6505_irq_hpd() /* hpd_state =3D=3D fa=
lse */
                                      it6505_disable_audio()
                                      it6505_stop_link_train()
                                      it6505_lane_off()
it6505_delayed_audio()
  if (it6505->powered &&
      !it6505->audio.mute)
    __it6505_enable_audio()  <-- enables audio with link and lanes off

When HPD goes low in it6505_irq_hpd(), it6505->delayed_audio is not
cancelled and it6505->powered remains true until extcon or runtime PM powers
the chip off.  it6505_delayed_audio() does not check it6505->hpd_state or
it6505->link_state =3D=3D LINK_OK before calling __it6505_enable_audio().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795132452.gi=
t.daniel@makrotopia.org?part=3D13
