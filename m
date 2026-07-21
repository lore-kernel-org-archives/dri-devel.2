Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3526C44524
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 03:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E50410E1E2;
	Tue, 21 Jul 2026 03:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DyMCWVHc";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF50A10E1E2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 03:08:51 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-81ee6b2da98so48983697b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784603330; cv=none;
 d=google.com; s=arc-20260327;
 b=qytG15H4BzYQbp/ZUT9y1N6hzJCcgql7Fz7eUV+YO2G+Ir8oyR5jJbEI4PsZd/iFPb
 vss6YLbvq8jgTwdOvRrHcahgn1FETBQudR/C0XgzpxlJ2A12CV4NSrjR98SttWICNzAY
 y5+Q0wrLK7GPMv4j1wfwCZ3pNDQWse58YkZ7j56FgjtLCnGsTEGdP4C0DTJXPdJa5Tib
 SGaxbc1t6AE8Zr3AwsoHHpVtZkHSZ7pQY5KiybhC5DiIQDVSjQum65QuJa4jDsV2oe0R
 jwl0mSakfy4oUkr6MuxV8yYQBiE6iRG1/t+p1R+lYCMJveNPjF7C/+/zzfEGsXJSwN9Y
 eOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XR3KYJTpiBWw0+V3gZDjHv2XkYH8NffsgkJP+nAma/0=;
 fh=cy12p5XWH9PaurnuSlO+ZYkS+8AdWHiHorXCKFUhlus=;
 b=gvD7YJBry3XPaFdIBx6A6cMKHUMLOBiWVvZFDSA27wl2fFBPGJf0h1pNjsIOSxe9uN
 zbYzVsnAEiT1pOLva2DQv9kkiYKHGpyJNa+EJ1V/IgMjnSQm5QWS61fzCxpe3tX2S0Kg
 amekJx7KjnUgMZ1J9zWCl753P4puHSJ849LETMzesy2T3bU9SHy4ihIxGU5HCrn2kYWg
 /5KPHJ+8YbkW8pTEjE3/unfEPZlz9piuoHNce3iVZ56pT3HjPoBx6D/FaxpmzES83z3J
 suaPr15wBmSWApuFXQCEOQNlaVF7JhdsY1tXmWbrYFU9THSxa3drATH06AWnp0TpSUuh
 JtYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784603330; x=1785208130;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XR3KYJTpiBWw0+V3gZDjHv2XkYH8NffsgkJP+nAma/0=;
 b=DyMCWVHcOS+Qs+bUeX5HYsuTs5XxQvNs/2XRx/pCbvbYn8KlUpK2cWa5oZ7/UGeFrF
 egpaeziNZCFymTQqqG2BnWyf5hEZjlCqJBWAktqBAslErai+eQVVzlNfPDUORpzbacdg
 K13b2RnrYpc/1vnGWWl4E7CFGybXknmykhyAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784603330; x=1785208130;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XR3KYJTpiBWw0+V3gZDjHv2XkYH8NffsgkJP+nAma/0=;
 b=bb/5p+vtsu+MqLnXIz2qKZs9nGpmB92tDdlz+7PcBKiBmHxsQY2QT2guFnTIxfygNg
 G78Oqjur0kGUUQzCUsGyDW2jAqLAzftPafQ4jLirEOtSVWyZy3pSDlquxE3JXDESKogj
 qwTrDY6Xdz+eWpH1qqm5g04USj8zYIa8fVHygTMHa8dLDZL4J5j9bvIq0KdfCmU9TiEh
 HZIrs3feZqoFhcU5RAXflYWnmFyLnKqhHlgV5C3y0Bwwog5vZXhEjYmmpsa2BDSGg442
 MlNDM5NHiOZqZtEhtgrIgwwiV9lUV9F6qJA++ic6TsbtGRCfHIsLVSlTuMmRDDt4OV2N
 ZRJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RryQDTJIQ/Ul5tn+pMLvpm6vszOtMFWnSFGNxYiS+54MlzrcHbvqb3WHtwBhjFbdAPWJl89abgJ5aY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgGe/27kNrCSXAebmwxVAoUc4eK7BGe3mnwec4aqWTrK9Acvv3
 XleolLYjK8MXH0q5fQKB5SnDk77QltpfPFdHQePJA0TxPly9ZQDRkNRCV+5HgRO8itfTtl39uHU
 q9SkYj6SrTSvq3PqIgNiIlkjJ4XGfoPFrxW2Dv4pa
X-Gm-Gg: AR+sD125g4y8/SDtm1YwWiMdEIESjlfFE3xUVxiZzUIsiAj9MjHSXAKMp5X0ZB0pfOW
 vF72SoR/C9zJcvTJ0ryiqgWEZzOra/TR863kAAHs5gDPQLwDyRER/nIWKXm2E8ccB2VXuN0Yasw
 Ggju/2Nh6xSR3UvEVpuXKyzSDGaJaq7uZjzvAVHNnpIWXIYyT07GGZhFuPnMjAlPCkeUAOcQR8c
 fMkhbHeQTJD32KDfgzfXQ7/oLXDVLW1M7KaNY+viF8mWCJDrbpiB7yP+JZdKhgYxviusHMXhGfo
 Yg73tm390Wl0np5A
X-Received: by 2002:a05:690c:6e11:b0:80d:78bd:7a37 with SMTP id
 00721157ae682-81ef260c8d6mr52675177b3.49.1784603330663; Mon, 20 Jul 2026
 20:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784600387.git.daniel@makrotopia.org>
 <e7c7944f7ab37332c2afcc808aa8e105e4752a43.1784600387.git.daniel@makrotopia.org>
In-Reply-To: <e7c7944f7ab37332c2afcc808aa8e105e4752a43.1784600387.git.daniel@makrotopia.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 21 Jul 2026 11:08:38 +0800
X-Gm-Features: AUfX_mzmSRPeYPFPJC8VuKfMiw-bdx8XSXW3n2innYVifkRGLxhR_ScL03w_tUM
Message-ID: <CAGXv+5GOhYnziQnKeUYVJVr1Hn3vtE0Jbcqp3FoyT2eJpUEzMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/bridge: it6505: guard against zero channel
 count in audio infoframe
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Jul 21, 2026 at 10:26=E2=80=AFAM Daniel Golle <daniel@makrotopia.or=
g> wrote:
>
> it6505->audio.channel_count is zero from allocation until either DP
> link training has run once (it6505_variable_config()) or a valid
> hw_params call has cached a channel count. it6505_enable_audio() can
> be reached before either of those has happened, e.g. from the
> audio-FIFO-error IRQ, which is unmasked unconditionally at poweron.
> it6505_enable_audio_infoframe() then indexes the 8-entry
> audio_info_ca[] table with channel_count - 1, an out-of-bounds stack
> read when channel_count is still 0.
>
> Bail out of it6505_enable_audio_infoframe() when channel_count is not
> yet known instead of indexing with it.
>
> While here, fix the debug print in it6505_audio_setup_hw_params(): on
> the invalid-channel-count path it logged the previously cached
> channel_count instead of the actually-rejected params->cea.channels.
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
