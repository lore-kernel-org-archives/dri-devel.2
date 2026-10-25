Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9C606A31B
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvQ1yNta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C46610E116;
	Sun, 25 Oct 2026 21:19:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBAB10E116
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 21:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 108E843BC5;
 Sun, 25 Oct 2026 21:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E821F01825;
 Sun, 25 Oct 2026 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792963155;
 bh=0jNJ58iAQV5cnCFP7dgvzoEk8R0fr8+/p2dzb8K2IIY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bvQ1yNtaKdUAAAFAERRy0tLO8LE8fjR/bWWSYHD4DDtffdNd3CIP+mWSnBSlLBavS
 1akpJFeAysWBqFBDAdSQ479nMz8fHLP+G/vh/mlu9n59pEW2du4P6IlyIZj6DWuxr0
 mri5Od9YlEDGmk5MR9QoD+iFrd92mLuUNNb8ssm9Vb1+V/HmRnr4AydFID3EJhFU+y
 bV9bQu10+2CEZgRb8pfPjHxlbqGH4n+QGRgNNdK9kI7WBW3oJ5eQAxLgLtn7aHrw7/
 cGC++knVbYmBGYzu+cisHFFeDOYipGEQ+9Yv9BGdgT6VIh/fZo6vPc9ONKVwZxvtqB
 GLLsOEMKGhkSw==
Message-ID: <sashiko-outbox-184454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi-i2s: support the S/PDIF audio input
To: christian.koever-draxl@student.uibk.ac.at
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261025192436.209908-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192436.209908-1-christian.koever-draxl@student.uibk.ac.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 21:19:15 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: dw-hdmi-i2s: duplicate Capture DAPM widgets when spd=
if is enabled
--

commit 566412f94af4997a1eb5d5114c6f602dc558da39
Author: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>

drm/bridge: dw-hdmi-i2s: support the S/PDIF audio input

This commit adds support for the S/PDIF audio input on the DesignWare HDMI =
TX
controller by allowing platforms to set spdif_input in dw_hdmi_plat_data,
registering the hdmi-codec S/PDIF DAI when enabled, and configuring the aud=
io
sampler for S/PDIF in hw_params.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/driver=
s/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 2c903c9fe8052..304ef881e06c8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
[ ... ]
> @@ -197,6 +244,7 @@ static int snd_dw_hdmi_probe(struct platform_device *=
pdev)
>  	memset(&pdata, 0, sizeof(pdata));
>  	pdata.ops		=3D &dw_hdmi_i2s_ops;
>  	pdata.i2s		=3D 1;
> +	pdata.spdif		=3D audio->spdif;
>  	pdata.max_i2s_channels	=3D 8;
>  	pdata.data		=3D audio;

[Severity: Medium]
When plat_data->spdif_input is true, dw_hdmi_probe() sets audio.spdif =3D t=
rue,
and snd_dw_hdmi_probe() in drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audi=
o.c
registers hdmi-audio-codec with both pdata.i2s and pdata.spdif set while
leaving pdata.no_i2s_capture and pdata.no_spdif_capture set to 0.

In sound/soc/codecs/hdmi-codec.c:hdmi_codec_probe(), both hdmi_i2s_dai and
hdmi_spdif_dai retain their default capture stream definition
(.capture.stream_name =3D "Capture") unless no_i2s_capture and no_spdif_cap=
ture
are set:

	if (hcd->i2s) {
		daidrv[i] =3D hdmi_i2s_dai;
		...
		if (hcd->no_i2s_capture)
			memset(&daidrv[i].capture, 0,
			       sizeof(daidrv[i].capture));
		i++;
	}

	if (hcd->spdif) {
		daidrv[i] =3D hdmi_spdif_dai;
		...
		if (hcd->no_spdif_playback)
			memset(&daidrv[i].playback, 0,
			       sizeof(daidrv[i].playback));
		if (hcd->no_spdif_capture)
			memset(&daidrv[i].capture, 0,
			       sizeof(daidrv[i].capture));
	}

When the sound card probes the component via
soc_probe_component()->snd_soc_dapm_new_dai_widgets(), does having two DAIs
with the same capture stream name "Capture" on the same component create two
duplicate "Capture" snd_soc_dapm_dai_out widgets in the same DAPM context,
triggering a debugfs file collision error ("debugfs: File 'Capture' in
directory 'dapm' already present!") in
snd_soc_dapm_new_widgets()->dapm_debugfs_add_widget() and causing duplicate
"RX" -> "Capture" DAPM routes to resolve to the first DAI's widget?

Since the DesignWare HDMI TX controller is transmit-only, should
snd_dw_hdmi_probe() also set pdata.no_i2s_capture =3D 1 and
pdata.no_spdif_capture =3D 1, matching other HDMI TX drivers that enable bo=
th
I2S and S/PDIF such as drm_connector_hdmi_audio_init() and
tda998x_audio_codec_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025192436.2099=
08-1-christian.koever-draxl@student.uibk.ac.at?part=3D1
