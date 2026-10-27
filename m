Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E05606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Kl3T2azV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A00689A77;
	Tue, 27 Oct 2026 17:52:04 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA68689A77
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 17:51:57 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-483c607ccb4so116618fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123517; cv=none;
 d=google.com; s=arc-20260327;
 b=LdV5sNrsn0iiv0/72hZPx/ieM9syMMPvwnuslQFk8wXPMb2Qu742lnhjBelGSpnesB
 IO/Tzjlu5ba+5pu2GOKhEKAvW/eIZNjUTrRPf/PQs2iTG+/estruLLi3TPBbDP5dD/FN
 3fDG8ETmZ3yi+YOE3uQNM/iOB3zQTGPSyPYz2mSEwRulCb/OH8RTYvr77CNPdzMWm5pB
 e0cIhiorI3K/ypRUdJ5PbhKChOPc2pE2wYg01EXhwnqmZKXfgQ+hJopD3yRENboV543T
 4IX4jlQBZ56wvz6f1ZSE3CXdK4+ty/vKRicz05S6w+wl/9P7q1lu2LHO4pxQf27Xpe0K
 OaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GGr5j5Bzi08+rjV4DuhZvfvPzAyD+nxpZaxVOzmJBZY=;
 fh=asJ1H7DzqjhKNG6su/ZAW1JQCyKf1/hWH94M76pNSeE=;
 b=YE6ohzD2AaVYCNe/yXyC37w4r7u57eZcy8BUHt9PpTBL82KfSZSZVIuIl9IWE5+uL1
 JR+uqTpn9/v2TIVPdsfH2WRqfDbrBc1zr/qjbIesaJ3KNlOepJVojpXqECNcB+SEAZNQ
 3a/x7zaEY7oUk+PGvti+NDQS70Z4Dn8xM4Kx5BBv1pJJynuYofBxIE2bLCc9ITEGLLz5
 uHEJ5u1hVOV1Aj5drDVp/0hd13vStypGjm+4cMv9wABoaIq10aCTCJ9dIX6HS+dIYJLF
 VOMW6MIcCbGiZCXO7Ka42OCMmGhycABFa0a1mQOTEZLtpJyiuPgyzIgTDeszM5qcq1ZG
 1NZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793123517; x=1793728317;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GGr5j5Bzi08+rjV4DuhZvfvPzAyD+nxpZaxVOzmJBZY=;
 b=Kl3T2azVE43AZfy1dd2kEWtXz4XZfSnBaEfigBfuAbCUNNqcUmsBhH1rvWEFYRZi2U
 X5Kea6qIrLyUud1WhEePXnUfUh2WvJ/61G7N4Fc/UeivBWagz7Ll7fP/ht7QmyTl5cg7
 +BUmlinJaFeo05liik5r8+lHXKsx6iMGyrOhfKwQfvJMgInz7yZYzxDMBMsc7vndndGZ
 ZBt/Ma7BdRVwuI2PoxD5H8VtGAyPRvcYrDf0N4EzqDeCJhe2lkeec+g21vdQFarfxk4w
 ZPtzwW2x5gjOOsq26fDacQoTbSpPN3wkx8bHiqhgAWBTPao3FrHbYdQ7pW4h2Ml+uToF
 WZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123517; x=1793728317;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GGr5j5Bzi08+rjV4DuhZvfvPzAyD+nxpZaxVOzmJBZY=;
 b=HEpusQraQlNv+rBjix3ME/KDXIFRZu2w3hvqdJuuO/AFqYoaaTd6KfjqR1e96VbM/Z
 5PIQh4QqJ8BdeKTNX+WA4M5QI4J1BtM85QHWK1oYnqvITo3ISGR7JdKnrJitXSNtsq3/
 79Ts2a2p9bAjJcD90Rid0Vwhx2AU5/j+E30LowLTpZ/TXkCzjlbgs6gSZhDUx0mJqzUK
 z6Foio2MP0N4y9Bxh17AxaO8RvCGT/RAnZRpnTCFd4Dyq6lxgZcXLIYl2DwUxyUkL1tn
 0oFdfI76gXcr/nQH7Is86Ty52Jz7tnJLxBBx+3g7fNN1EKLyrmZ3oioznPNZRNExrekm
 jJ9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB6ndrDKmlJFW80sml0aGQOZiY8+0GDl5M+O9f1W32Db1nRcc2Cm+coVNLBi8hoJk8WYr4YlHt1+o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKM6cUh6bOQGwPSmFpS99NWIWa2T75fup3hWFYR+0y/lZANZaGx
 Guimu2msVziYDxF1D8lbD1sJVcDmo9w/97f273//HGV1LoI+f125hmJ5CL3h4GPc9b7G+6l77Fw
 l7XU5EAvBMHOh4XU1eFV1X+PRkRAUwgTqk9+wh4ZlBw==
X-Gm-Gg: AYBFou0DIxU9afYQ5rmaHQsJOiPgL7CqnhIlJH2L3byGEedsUbd44UT21v6eGnD1oUh
 D5gWhpFU8lRLqK03WVMGnhHJB44lFy+180vIm60jzWn+fTzFT5Acg7Ww4de8HPCtNARPbtk58hf
 Z2oTPkBORFf6tnU0EojUOfPJja74wstbug7fYgxDPBoGCoo9uJKfBeSjTk1O9IPybxmhsckliNu
 iGJeJazs8pPjf3FZevM2lX3yP/upyLSY7vOjNGae2okvWknRAm1ZUipP+PqyNck0f+wIsdFnTgJ
 IbArdkx2BBfHPghIUbCnNW1DwqHF6k69fcfLEFH/JN5g9eXGbF911aaAh1zB8/RmxrhdcbNNYVs
 fCAur1aSDWZLSVqolIj+WUpsaFR1fuwu7gWR4Ib4MqnpWIMsCrUMIq/mzCzn/0ELAgjSvI46ROh
 88xAllPQnCijRMluTowmQwrrxycYD7x52VR0nQwFBscrxI1LsRJW/Qp9gYrF55yRkPrFY4EiSDX
 /w=
X-Received: by 2002:a05:6870:32d4:b0:4a7:2ba2:61e3 with SMTP id
 586e51a60fabf-4a8bb68a9cdmr212651fac.38.1793123517141; Tue, 27 Oct 2026
 10:51:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-8-c68d58d959a2@collabora.com>
In-Reply-To: <20261014-vc4-common-scramb-v3-8-c68d58d959a2@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 27 Oct 2026 17:51:40 +0000
X-Gm-Features: AclHuK8ZKJ_JTVubRk5FXQa86W3jtd6tziWTz8u6Qiv1FIRrgy2UTs2WpYRya4I
Message-ID: <CAPY8ntCPZBwg3ynaoQPM=EJFeWYCeueFNN_MD_4+sZuj3csMEQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165
 MHz
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 at 02:03, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Historically, the HSM clock for BCM2835 was fixed at 163.7 MHz.  Since
> the pixel clock had to be at least 1% below the HSM clock, it was capped
> at 162 MHz.
>
> Since commit cd4cb49dc5bb ("drm/vc4: hdmi: Adjust HSM clock rate
> depending on pixel rate"), the HSM clock rate is set to pixel clock *
> 101 / 100.  For a 165 MHz pixel clock, this gives an HSM rate of 166.65
> MHz, which, per Dave Stevenson, the hardware can handle without issues.
>
> Increase the max pixel clock to 165 MHz, which matches the maximum TMDS
> character rate of HDMI 1.0 through 1.2.
>
> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 0a95e14792e8..5b7dedd7a9a1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1319,7 +1319,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>          * users are able to use pixel clocks closer to HSM's, namely for
>          * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
>          * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
> -        * 162MHz.
> +        * 165MHz.
>          *
>          * Additionally, the AXI clock needs to be at least 25% of
>          * pixel clock, but HSM ends up being the limiting factor.
> @@ -3190,7 +3190,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi_regs",
>         .card_name              = "vc4-hdmi",
> -       .max_pixel_clock        = 162000000,
> +       .max_pixel_clock        = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
>
> --
> 2.55.0
>
