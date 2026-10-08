Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60737CA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4A510E21B;
	Thu,  8 Oct 2026 18:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="tu4O+kVn";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F31310E21B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 18:01:51 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4af7283bf83so1456035b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 11:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791482511; cv=none;
 d=google.com; s=arc-20260327;
 b=BonhHdzIBArThwUYAupMGc7hKaeF3ipX6tSorJFeeDIVy9hQD9Pwj5PcZUfd3mNgso
 GEpKSTjFkSPDsqai7JWBfWlnPJjiLTWQm64EiqHhnQBX2ttEgiK62idwle7Ptjw8/Ln2
 6XTsBSAwzcHzJzzUpWw+3kyqf/vKc7kKqFeGo2L8s2zkTW35nMfV0KK9D9z4JFGjwlx1
 5NUTb/HipO2s9MPFeNvFVaFl5IqSc42XgbXnRbPivcrpdM74GTFcuRhFOwD6qEZbVPE6
 Xw+kRHctToTlhAw7J+EOxxPoG/7e9kG/VsJFBrFLDLCn6xMkiPauZc1BRigchdy6wFaW
 33+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rj9LeI1dDZhOR4KJgKOQs0yMX4hB0yDaMikxwJmFK1U=;
 fh=rJpgGA56fiZpQTX1cXV2XKsdUTiJehG+2LFdi70jDBw=;
 b=m6HKSjgF/SzpXtuGUYIfE/mik/V2b1gRJ5NmB5rJkqMLzFKlNPA25ddUS24vOxzIXw
 D2aCwLk1jMU75ExMlhTf8HpFXj/HLSf6PdQjIQ6nZsx1pPM62/fiKzPnm5nzgVw9EiDi
 tgimaoMUPrcoLSK2o4TThZEyTEnoeaczaQqIgOAVb+cF69bZItjoi3Sc3Qr3XJfCzI78
 rt4/jQmIQP/Iwj7CEJhdqFQ6j45xpGbBRKInHD0oNT2te4BJtAQWp4ZxuUEuAC5iT0f3
 JxCjQKKwm8npJntLXac6GfuSCVNWNE+7WwU4zt26muaDTgOqrJZ9X66869O/tNwdeLyO
 Hmvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1791482511; x=1792087311;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rj9LeI1dDZhOR4KJgKOQs0yMX4hB0yDaMikxwJmFK1U=;
 b=tu4O+kVnoFI23FAT4xoFM5tlcP8BXAaCmjbrjw4MHZNTg6RTnCyfxulOJkUDtrb//1
 74Q9JT85rSBtlX9M6qA+uVHKm4Oeq8x2+575VH4STASoLlp5c0WOV6H78cEh5FBvk1vb
 RjX7KlsvHwQKrh5ke4E1qXedLzJFY8MHlaUAmEF0Y9h2mAyWE1puHiH8SObs9ubsTMz5
 jW4DXsGGMHnJC0AVmBLUjxs+Utl1FuOTUl2z2ZOopU22lkIy/MOVeSJyyS/ENbiIie/9
 Ze0MJ/YdkK5v74HjHJiBgjWjgl142aL0O0iYriVamBE2oVElwpkWDeejaGbFw4wITapq
 qAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791482511; x=1792087311;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rj9LeI1dDZhOR4KJgKOQs0yMX4hB0yDaMikxwJmFK1U=;
 b=z7BegGhfr9vS2QWMkzXSuWH2bd/fYuuBCvSFZ9EXt11F4qx6YqZMTCGPmQTKQR6VvH
 uhvAE4AuYwFkzvcZqsDHOSt+K8z19nkX0/47uLXRJpFsnqRmxokEj9pn+8KI3RkjmPZ6
 h5HYmSt6Fezxd/LeAehCUWMWLyhFyFd9EVsyQBJeSwlzbTbbXdIAPvTKxgoergaBi5Zo
 HOJAnbgDQE50yCHo8dQWaVlwKqviADrGQFsTRoUKIJ1CLwb1sXVDCyI1hV7kTx61wLFl
 UVEAP3UnrMgUQ1/r9TC/VlVc8AdStcqiJil+piaiRJXijZBaKi63Z9mK2mp785fjSj7c
 wHng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAzjHdPlWIVQZgjUJ/Joj5TU9AZsgs5tHhHoUi7ugN4OPk8t+r86AUpscLJ409UZGCkG1bodzUul8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m74ud7qwgEXqdJ1RljOSAECE/sURWVMWT0S2WchEoJYsjeaVjp
 n+6unMNh7gYAYd/zAxOXn1NEXS90zWl4QQaNihWzHb3SWDDfzytacf4541G01YRXx4WlPkN0k5k
 dMI/Kd3tuD3qn2gCoje3YAKKxuRCsbWp3ZvDKOmR4gQ==
X-Gm-Gg: AYBFou1H5+gQLoLvL4Fxps0SxGc78S7NwjbUpVXh+lxj0feboWF0XVhdkJ+nirvc0J+
 HbsrwoU6ltT3+JaYh+O+wdplCTfqaNjmubmm1OL6Av3omsIeEioZ7YKljxRPrkd21tvAzOGOPGR
 V7AOGHRwBTsMg0cUtPzw/VMH9szdepS7ZkPQ1kcBr1Jvyrx88JczuH9LRHzkwyQ5bcqEiiy4rGi
 2jLmzlcdccp9rhqnwpIhZjS5B1CFeV9Rd8KDopDVeuDKyCp2+w4dds3xFa/pUYW9OruwXrBlbIx
 If/eo+COcsqsnZ02EhNLNtl09gUOOhbEDg2dThsy+03OQeq3D1ePudEA4lh+pC71dnlook+cWBY
 NAVZFiPq5qbh5q1WkL/XETd+J1aVlzIIkVM7FD93TCOvg7mneYiEI5T9eZAP3RhBV9muFns6o
X-Received: by 2002:a05:6808:23cc:b0:489:5d05:552c with SMTP id
 5614622812f47-4fc46683267mr5689930b6e.18.1791482510745; Thu, 08 Oct 2026
 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-vc4-common-scramb-v1-0-51280460194b@collabora.com>
 <20261001-vc4-common-scramb-v1-7-51280460194b@collabora.com>
In-Reply-To: <20261001-vc4-common-scramb-v1-7-51280460194b@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 8 Oct 2026 19:01:34 +0100
X-Gm-Features: AclHuK-Sewui8Y7baQx_PKz1CfNAZ_l90MYcHcLJ8IU6I2i_vyOwGlo2uLO65MI
Message-ID: <CAPY8ntDCU80hkxdDEGphQCX362ut4AdWJUTGkDOwOHWfkPW6BQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/vc4: hdmi: Defer pixel clock validation to HDMI
 helpers
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Cristian

Sorry for coming in late on this one.

On Thu, 1 Oct 2026 at 01:27, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> drm_atomic_helper_connector_hdmi_check() rejects modes whose computed
> TMDS character rate exceeds the connector limit before invoking the
> driver's .tmds_char_rate_valid() hook.
>
> BCM2835 is capped at 162 MHz, slightly below the 165 MHz limit of HDMI
> 1.2.

Nothing I have says that BCM2835 is HDMI capped at 162MHz.
Working back through the history, originally the HSM clock was always
set to 163.7MHz and the pixel rate had to be >1% below that, hence
below 162MHz.

However that was reworked so that the HSM clock rate is now set to the
pixel clock * 101/100.
The HSM clock can run at 166.65MHz without issue, so a pixel clock of
165MHz is fine.

  Dave

> Set supported_tmds_char_rate in vc4_hdmi_connector_funcs_hdmi10 so
> that the limit inferred from supported_hdmi_ver is overridden by the
> lower hardware constraint.  All other chip variants rely on the standard
> HDMI 1.4/2.0 limits, so the default validation suffices.
>
> This allows vc4_hdmi_connector_clock_valid() to be simplified by
> dropping the now-redundant max_pixel_clock field from struct
> vc4_hdmi_variant.
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 10 +---------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  3 ---
>  2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 2451ff85e759..6d3db0d24c38 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1529,12 +1529,8 @@ vc4_hdmi_connector_clock_valid(const struct drm_connector *connector,
>                                const struct drm_display_mode *mode,
>                                unsigned long long clock)
>  {
> -       const struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
>         struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
>
> -       if (clock > vc4_hdmi->variant->max_pixel_clock)
> -               return MODE_CLOCK_HIGH;
> -
>         if (!vc4->hvs->vc5_hdmi_enable_hdmi_20 && clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
>                 return MODE_CLOCK_HIGH;
>
> @@ -1579,6 +1575,7 @@ static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi12 = {
>         VC4_HDMI_CONNECTOR_FUNCS_COMMON,
>         .max_bpc                = 8,
>         .supported_hdmi_ver     = HDMI_VERSION_1_2,
> +       .supported_tmds_char_rate = 162000000,
>  };
>
>  static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi14 = {
> @@ -3185,7 +3182,6 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi_regs",
>         .card_name              = "vc4-hdmi",
> -       .max_pixel_clock        = 162000000,
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
> @@ -3205,7 +3201,6 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi0_regs",
>         .card_name              = "vc4-hdmi-0",
> -       .max_pixel_clock        = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
>         .registers              = vc5_hdmi_hdmi0_fields,
>         .num_registers          = ARRAY_SIZE(vc5_hdmi_hdmi0_fields),
>         .phy_lane_mapping       = {
> @@ -3234,7 +3229,6 @@ static const struct vc4_hdmi_variant bcm2711_hdmi1_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI1,
>         .debugfs_name           = "hdmi1_regs",
>         .card_name              = "vc4-hdmi-1",
> -       .max_pixel_clock        = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ,
>         .registers              = vc5_hdmi_hdmi1_fields,
>         .num_registers          = ARRAY_SIZE(vc5_hdmi_hdmi1_fields),
>         .phy_lane_mapping       = {
> @@ -3263,7 +3257,6 @@ static const struct vc4_hdmi_variant bcm2712_hdmi0_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi0_regs",
>         .card_name              = "vc4-hdmi-0",
> -       .max_pixel_clock        = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
>         .registers              = vc6_hdmi_hdmi0_fields,
>         .num_registers          = ARRAY_SIZE(vc6_hdmi_hdmi0_fields),
>         .phy_lane_mapping       = {
> @@ -3290,7 +3283,6 @@ static const struct vc4_hdmi_variant bcm2712_hdmi1_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI1,
>         .debugfs_name           = "hdmi1_regs",
>         .card_name              = "vc4-hdmi-1",
> -       .max_pixel_clock        = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ,
>         .registers              = vc6_hdmi_hdmi1_fields,
>         .num_registers          = ARRAY_SIZE(vc6_hdmi_hdmi1_fields),
>         .phy_lane_mapping       = {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index f6159c9e6144..61486e7b4ba2 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -29,9 +29,6 @@ struct vc4_hdmi_variant {
>         /* Filename to expose the registers in debugfs */
>         const char *debugfs_name;
>
> -       /* Maximum pixel clock supported by the controller (in Hz) */
> -       unsigned long long max_pixel_clock;
> -
>         /* List of the registers available on that variant */
>         const struct vc4_hdmi_register *registers;
>
>
> --
> 2.55.0
>
