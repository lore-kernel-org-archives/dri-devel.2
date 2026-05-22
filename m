Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F4CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9C210F5F6;
	Fri, 22 May 2026 17:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="SG95T8OY";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B251710F5F6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:38:36 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so3795048a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779471516; cv=none;
 d=google.com; s=arc-20240605;
 b=deZF7tLqeu0JLAAkqFfUWjj9GmhDMPKOhE46plLj2vLg8y3V+twyjj84Zz7SynZPOb
 oTyZH8z5pKQH1NewdMtI8/CMijauB/t1M+ayT2p6WaHYi6+3l7BsGIL6MKIfZS0TSKpR
 HX91NrQexWIW2vXPApb8nIR/M0MqHJkStFiiFQKUAtbcrm23I9aVn+12buKm00KrEi5V
 z+4qu6ajasqHRshbZ/QijZkqsfKBmExVOD9LDRhp+ONYv7gahacOtYLV8SQZqY/UIICa
 L4bHNV3nLFo6PO5q9ZtcLdhOniaLxKUXsLIY3uL8QYM8oA+cHoDIhxNsGChUf1AxddAK
 HIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IVnvoAxveeXVkX6pNtnMesdFolHZTT6TJssbfAAnj1Y=;
 fh=mVORzFE1zHogb7ctfe3A+C68ceMLn8FCBftrBT//juM=;
 b=WdURDHd+kMXEbqYz7cR86U3b33b6Zm/7fZ2GM8u/H+Os2ok+46luvvc8/pT7YXh5BW
 VtmHRTov/iE9vQPk22GsmLQwTzBAAnEFz9wCUU+isWncH6Jc9mux73bElsYqIkg3IJwg
 ppvgZVXz7GKv8fv2lpxKrHurZbajpUsCrzQdpVJkFpG2kUgjlVtYZcsZutODtQqLC7Lg
 n/GCVrLEL/mEUg92KXro8/FztKJMeYoBLbaUApyvGbnckNspVfSN+yMuwW8AC/4CMeU3
 07xhkN2m0g6I4gWSTAce9Zula+H/MrQWtpEzaruBA/avTTzXQGqqdHJWmH65kp0d4B/U
 1dIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779471516; x=1780076316;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IVnvoAxveeXVkX6pNtnMesdFolHZTT6TJssbfAAnj1Y=;
 b=SG95T8OYQzLc2vzyuOlDfBsWS/wzj8MP3L9azMLik+EnvpAWLbmqCmbN1q7iG+eFix
 owJEUjjKQ6OP6p+raSmebUzWlQgwOccgPPYAX7BAPDewXlliPFejI4ySq1HMTLULU43S
 rRSx1/DJAlFBZe6lUAnoEKmpVr2HtZ/tof1reF+WD9uqpDW8x7KLZ7YfLbg70ioPIaI+
 7mAIH5mi/KDpGdyfLptCqwBiw3UAcF4Hg2cQIpqzbhGITAqT/V0+y97dUdkPzfGNXa4b
 ZRH+7D4uXmAkQoWbrgpoSBk6ulcLr4Sd48Kz7vzGDQFkFmEfmpk0hY7FciYczF05c6uv
 NhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471516; x=1780076316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVnvoAxveeXVkX6pNtnMesdFolHZTT6TJssbfAAnj1Y=;
 b=UczIviyE7yEBwtZ0jIcz7sc7sEPb8I2aB44Nd9Ditsw4NhxLYRfxPbzcGv7RpQwqtg
 0wrPbTW3CxZ/mxHsFjVgwmoZTpi5dYwdwIoNlt7J5J+mCCpQfADjzwa639XblTNMGwvA
 16P6/mrz9TT0lMx7Gr8q9Ec1WE9/RKzfb2iZLJqLq8sM2Mt6G0M0q218+UtSptdJEL0V
 sc4+XeHHYeHkTk35wRr6sTMhYoYZP2dnkX962j4k9WTN6An2kuP6STCYUe6qPevUHtmI
 40wKIs/nBLgE/eas/gS0LW4viKGbaVcVaZ12+V8WlnmevAxs9PG9Cq5Vk/rOKjS7QDja
 ba+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ94alZ4sLlpFRYpi3MUSROiunZEBu8dbu6GXBjN1iym48lXEIHHjBx70kTsvaRVShfWtVsULpKXu78=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzK/A/NAKDArX55koCkTrI7kocJLYVbzUwlc+zs4fKO3q8q5ur6
 gE6wKSramA3WNWWe+4smkV/yL6hls9/wF4kLkZBtcsD76Y+WfTNV3MkVH/b2GY/0BdnNS0NGU9p
 0r871YfDlBkXm5vo8LFIuI1aTb3FB6XP+YuqaKt9meg==
X-Gm-Gg: Acq92OEzlje2HwxeSIDhvVfA/rHcI4k80S3JLq7s11+o4N8fngE6gK1yu/oEuHZ00+F
 xYOIRzE4/EEGv7aAdp3ShtKoSlzcrMV4c+LS4S289ziCEo1Rj2xrHc06yfPp29rXUEscCyxaigR
 XS/Xai4XVm/RqJ/IL+Majhl4CLcblFiXNddu7Lgme/c08WKhap46dmvLS6+dmJ/5YUKNILS60OW
 qsnviSDPd9kKTaoD2UOtxPQKhqoWBVDRTn4S6YSbp95KAsk++IlPanXot2o7RYq1eqPlmAgbB5F
 VLS7xug=
X-Received: by 2002:a05:6300:210e:b0:3a2:cf6d:aa04 with SMTP id
 adf61e73a8af0-3b307bde7b0mr8345335637.8.1779471516101; Fri, 22 May 2026
 10:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
 <20260520-scdc-link-health-v2-3-511af18cd64b@collabora.com>
In-Reply-To: <20260520-scdc-link-health-v2-3-511af18cd64b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 22 May 2026 18:38:24 +0100
X-Gm-Features: AVHnY4Iyy7zGNtQMTS3djgL0PzThMuauBSUo8jnZn2Vn7HzLcmAjq7TCihnYb_4
Message-ID: <CAPj87rMe_oOR66uBE1PpNq4oMgpw_XhAbQit3tohTQbUD2dPdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Nicolas,

On Wed, 20 May 2026 at 14:36, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> -       for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
> +       for (i = 0; i <= ERR_DET_OFF(SCDC_ERR_DET_2_H); i += 2) {
>                 if (buf[i + 1] & SCDC_CHANNEL_VALID)
>                         counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
>                 else
> @@ -355,9 +433,15 @@ int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]
>                 buf[i] = 0;
>                 buf[i + 1] = 0;
>         }
> -       buf[ARRAY_SIZE(buf) - 1] = 0;
> +       buf[ERR_DET_OFF(SCDC_ERR_DET_CHECKSUM)] = 0;
> +
> +       if (num_lanes == 4)
> +               counter[3] = buf[ERR_DET_OFF(SCDC_ERR_DET_3_L)] |
> +                            (buf[ERR_DET_OFF(SCDC_ERR_DET_3_H)] & ~SCDC_CHANNEL_VALID) << 8;
> +       else
> +               counter[3] = 0;

I get that this is separate from the loop above because it's
discontiguous, but is it also missing the validity check? I mean,
lane_count == 3 means 'fsvo 3 which may be 1 or 2' so have to check
SCDC_CHANNEL_VALID there, but if we have 4 lanes explicitly specified
then we are we missing the check for the valid bit, or is it just
always valid / we shouldn't check?

tbh having it separately is a bit messy. I half-wonder if unrolling
the loop wouldn't be cleaner, e.g.:
#define GET_SCDC_ERR_CNT(c) { \
        bool valid = (buf[(c) * 2 + 1] & SCDC_CHANNEL_VALID; \
        if (valid) {  \
                counter[c] = buf[ERR_DET_OFF(SCDC_ERR_DET_ ##x _L)]; \
                counter[c] |= (buf[ERR_DET_OFF(SCDC_ERR_DET_ ##x _H)]
& ~SCDC_CHANNEL_VALID) << 8; \
        } else {
                counter[c] = 0;
        } \
}

GET_SCDC_ERR_CNT(0);
GET_SCDC_ERR_CNT(1);
GET_SCDC_ERR_CNT(2);
if (num_lanes == 4)
        GET_SCDC_ERR_CNT(3);
else
        counter[3] = 0;

Up to you though. It's a messy format, with no objectively great solution.

With or without that suggestion, series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Thanks for pulling all this together!

Cheers,
Daniel
