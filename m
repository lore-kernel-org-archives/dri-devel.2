Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C865C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6546810E4A1;
	Tue, 18 Aug 2026 09:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAqeyd49";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475FA10E4A1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:02:31 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-836c590b61eso65663927b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787043750; cv=none;
 d=google.com; s=arc-20260327;
 b=NFKbBCQ72AoaOGYXDmwH5TDn4fZccVXMCfPES1L+USrwetKro2WU+VvdUkwpES80O4
 0uWiJDscU9aIJmlK6b5TJNaZD8jfIk/2SNF3cSZSHpxyE5UwEs1uNk8VKyGhfrKvOooi
 WKSkJRLP4gwf66Lt7+G+YBE026GfLVupxC/k21eMwiPL6xvzq82mg1y3QvZ5+Ww6rPCa
 GhrLzorXbSToJZpu5KWHJs/bxOwVLbC5gG4Qtl7pjzUDNQX295m8g6M9PAkpBMTE6Ksd
 NtJ7kCaV6Jh16dslyHfytbUgKjGcQpzDPxcRvVwCyxLFkUuzykU4e2xeUx2C1qGfc/Qd
 cxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=43T59eiMeEBqyiuFYn6FTkO3jC8cfs8+5ByV4p3O2EQ=;
 fh=R0KOxsQMVWZB0HRpPV24fd8zmhrRR4NvCPWqYAh/6II=;
 b=ZvaXk68+Y6WpcxHFPW+NTELKsyBjs+ywVh7avw9CXPHhXQdhi+o21UUMZnXCYx6tXq
 4VN6ReaCC22+n+bdVzUguOxDJK3Wv0FO+eS5v98NQ5eZxu+zjd23G/BjyJinTPa7CAnN
 bSAODCzt5PtgFqxwPFOT22JdSCBI93sO41nfRoOc/CApCDi5Je8h4PXfY6to2PdhCmFs
 BlvLXC6WWB+a1nBR5f/dxUSy+iDmcQgMeIsr8IXoewXmPRfKO1LDZwO/1kOjNfIcbEtw
 94FTDdmSltn4Plhz1n4Ag1SYCfmdKXIrxIyuDnnbKiR82QMP8oRgK502zpEtTz0GafNA
 2BvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787043750; x=1787648550;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=43T59eiMeEBqyiuFYn6FTkO3jC8cfs8+5ByV4p3O2EQ=;
 b=hAqeyd49CsdfFs3hU6gsdsmCyM9K5+LQaQE9tPjNujr8PYOblhf36T++tX+97iXsNZ
 A2kCXbRKK07bBK2SyBAxxQ5zboftbNMzwIAK289ZEw2lzwgYUu77rcpil3YrDd+nsuge
 +aHnRP3RRCEzkr7db2XPWMgF75XfAB4j3i7gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787043750; x=1787648550;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=43T59eiMeEBqyiuFYn6FTkO3jC8cfs8+5ByV4p3O2EQ=;
 b=nzMz+++BoYM/gr6EnKBeQPGfd4XBL54735PIpWWhPgy3s/lJwKublo1KY1eyFOFF+g
 Q2Zdg0MVqKafrrtcb7gTpSoxRfa3VsSs4gP6JkJbDCKRWMgmB3rmpqysiHhdoO/bGkdV
 VALP/HM6wl2aelOWyxw7F9o3uY3boGacGUCE3mbP7wns0RVLkhH0x+ihdaOyt5rxnp94
 6Adjdb07C9r7ZPI+c/mmYs718WxHv1elyvMNqf4NX3+fb2ilUDkfjDtudr3IepoRZqco
 dbWN8LLE11WD64Dp1LfQ5p5KL+3+ZYU/C5yJk4fEySqhfJHHwAYA5DT1xUrLkg0pLbZp
 RAmA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+J/j6igBRMSQfpRlLi0K/lLJrA9KFKwk0mBNx+P1vEuid1cvMblSDXkLcb/8eiGYmLQg9D7ooMec=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCbXMQZAhUcb/LwzLbeNA64M2yUObLV73JRwJQbmcPeY9k6jCI
 ep4QffFHJ3KCc+Q1xfYuKHkwcLLXt2v3eBdV+wtmURT4RTkBasKAPbBjG8w2bKR54GPSx3CKbpZ
 m2QQNF1a+YmwgLbUH4yMi98GvQUTEQFmLizLjtNKb
X-Gm-Gg: AR+sD13TjS2UJNhHzQ4sme96h6JF6BFhHOTSdGgCytEQ6gjNUOe8yIS4twY7sbEW+UN
 zHyWbrHslwb42Co3gv4/+JT5Cyj5eym2Jb490tARxuBdeVDCBX10AjNWNV+pS+XkVR8g5HQ5K64
 WzC6nwbcVocDatkX1T/HgffP85uAdU55gvbf7GsNDw93sFFH6gAKpj2peir/tUs3Qin9NWGm5ao
 JSH608dewez2XiYhrFnhVWrA9tOs6Qn/+RjvMxHgSTLhYYNFRgq5AVQjm94o6aGAodzsJ+nYcxg
 F/bJQSm5l4CmYY50+5l1mXyWU9eZmp8aOXGDP/AbgYsVfndDKIDJk1z2yxgsOGM5bpcxt3jkNg=
 =
X-Received: by 2002:a05:690e:190f:b0:664:ca89:3f3 with SMTP id
 956f58d0204a3-66c72cdbb73mr10245466d50.40.1787043750081; Tue, 18 Aug 2026
 02:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <20260818020559.961335-2-xji@analogixsemi.com>
In-Reply-To: <20260818020559.961335-2-xji@analogixsemi.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 18 Aug 2026 17:02:18 +0800
X-Gm-Features: AcwNN1WjZq7G8waiiZ8ebKNL-eUMGKvHTYXfhQfLpBrx8evVSIy0FVBp7CudiOk
Message-ID: <CAGXv+5H8_-vFh3KJTsjkkOfoUAAQ02BC0Jszb9rk6vDfnPHEVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
To: Xin Ji <xji@analogixsemi.com>
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
 r.mereu@arduino.cc, bliang@analogixsemi.com, jhuang@analogixsemi.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 10:06=E2=80=AFAM Xin Ji <xji@analogixsemi.com> wrot=
e:
>
> The default audio data stream is left justify. When the
> property "analogix,audio-right-justify-enable" is detected,
> the code enables right justify.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index c3af88e14f8b..f4bce0000676 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1883,6 +1883,9 @@ static int anx7625_parse_dt(struct device *dev,
>         if (of_property_read_bool(np, "analogix,audio-enable"))
>                 pdata->audio_en =3D 1;
>
> +       if (of_property_read_bool(np, "analogix,audio-right-justify-enabl=
e"))
> +               pdata->audio_right_justify =3D 1;
> +
>         return 0;
>  }
>
> @@ -2083,6 +2086,12 @@ static int anx7625_audio_hw_params(struct device *=
dev, void *data,
>                 ret |=3D anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
>                                 AUDIO_CHANNEL_STATUS_6, ~AUDIO_LAYOUT);
>
> +       /* Right justified */
> +       if (ctx->pdata.audio_right_justify)

As Sashiko already mentioned, this should check against the format
(fmt->fmt here).

Is the right justified format you want to support for I2S or TDM or both?
For I2S you can check if format =3D=3D HDMI_RIGHT_J. There is no right just=
ified
format for TDM in Linux, so you would need to add that to ASoC.

ChenYu


> +               ret |=3D anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> +                                       AUDIO_CONTROL_REGISTER,
> +                                       RIGHT_JUSTIFY_CTRL);
> +
>         /* FS */
>         switch (params->sample_rate) {
>         case 32000:
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/=
bridge/analogix/anx7625.h
> index 957d234ec07c..9dd9970d2172 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -154,6 +154,8 @@
>  #define HPD_TIME               54000
>
>  #define AUDIO_CONTROL_REGISTER 0xe6
> +#define RIGHT_JUSTIFY_CTRL     BIT(0)
> +
>  #define TDM_TIMING_MODE 0x08
>
>  #define I2C_ADDR_72_DPTX              0x72
> @@ -444,6 +446,7 @@ struct anx7625_platform_data {
>         int is_dpi;
>         int mipi_lanes;
>         int audio_en;
> +       int audio_right_justify;
>         int dp_lane0_swing_reg_cnt;
>         u8 lane0_reg_data[DP_TX_SWING_REG_CNT];
>         int dp_lane1_swing_reg_cnt;
> --
> 2.25.1
>
