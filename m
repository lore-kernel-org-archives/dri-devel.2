Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A0606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=pPi3DAbO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB6C10E22E;
	Tue, 27 Oct 2026 17:50:55 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553DA10E22E
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 17:50:49 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-4a76f63b243so980113fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123448; cv=none;
 d=google.com; s=arc-20260327;
 b=e34U7LmWINFkV6aQF4eZ/x/F4grD/HKUrSFIhgkFdy37GUKivaNYG0kU6UaAQiG6RZ
 M5qvc/AYjMgcjiAixiu2XO2rcYs1se/17hWvwcVS9OJon8Mj/vHCV/tLtKAe7/5ExfcN
 5/Q8HKqfg4iLvkMd1y7l6X2FaVV0AryRKaW1Qg8aJGoJYiEQiSXoHvuF1HHoGrH/weMX
 WHQJOwh7G2QmvTYcMrrXWVvcoTJMh2Vp8Smhq+DeqNBDoRJkVE8kIUlAefiXnyPVBOpH
 dmKIrRTm971T6EYLv3u7K3vxj8q//JRArxMyOjkhno3DYFDfAZ2IN8kEjwsjXCqGsgFE
 cUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EV/47UjyvEtLQbjYDkN466Fly+arTuIDMnysTk3prZ4=;
 fh=xSIxGzx/VlAtLg1bcYIzzn44tulHPKnuoLl0S6+FySQ=;
 b=C4bTYpD9zr5Oaq+LLvXMxaehyPWIzX26e/8/RSRGfTA9UmHhkdJmn+2KpEmGnGEYz/
 tPhqRj8G6RED/wooHOTqCOjdtemEvEseoJmsFVU3CODinJjoop/P0VMX7xFemun8z71P
 n1tHd/OUDdcNwuEoWOf05fUNkGxvKmLHrDdfYaX95UXACOU8AmxsbAh3EiccSTjPZvtt
 MUcFoncfbx18yj4mfEf69K4cUpm4xMqxSUBC98XC7vLizKR6RtPpdBYzXVUXmqhFYVYm
 8pC3QUME85XQnQlwWJRugWoehghb3gQMrjIz/suMmJcxk1xXKafsVQ2gZGuJWDfznxbj
 83BQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793123448; x=1793728248;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EV/47UjyvEtLQbjYDkN466Fly+arTuIDMnysTk3prZ4=;
 b=pPi3DAbOAaPpH3/CcSmZXu3myJpwFrFVWyHBPFTQ6n0X00vV5iOKoLoX705YaDJFxE
 6rLK52R83/uqvqaGxYk76Jf5gqMJYTcgPA/rZ0eNZ7xJmVZSgyCAVOZuVJyRLzaDrONt
 uiCPSFCsoKalCvCH7oXHMy9WYZK3G7Q0DT1q3HI0mrDm5D086jg7WddKM8Hc7tMc+bve
 tR5UJRaSaE7cauYrUY/CzuhPMhrVvQUT7sTgyeyb7+KHOKIG8gGYkVeADDfzJJd3E5dl
 PloSXwJstagkS5FCVw1t9ntF+M6h5MvDYJGTW3KwP5OIu9N5gPahTwFoE4SaqhL2o6R1
 tmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123448; x=1793728248;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EV/47UjyvEtLQbjYDkN466Fly+arTuIDMnysTk3prZ4=;
 b=A3cAHa3r2F8KHhuQY6v1+/AzF22ydb8Nv1AOsxxZhB273ZqCMwvWEvXH9X+0GKnpkb
 5FeZ1fpkoGipE29O/U2SeY8toW6qZOHx+AEhWwdSLuLsuBXimC8mXbNMxpHcCAzi/mF8
 JvX7Xqu1tkbwNli8Cq4j4Clc03jP7U15I3JE65QiVwt7O3qpo506MhEtYykgls5eVHvj
 35k7lpteVhNcvZBOgqBeqYlLmpOT7gcM+GJsCKyazRtQ0vyzqK8cQgLaKmr4PBOs2pww
 FcHKby32KAN0Z6Cu8/S5z+rmGoN8TbfuikqWZJAw8s6auqEmVx+1zECPc0WxtIFkTzp1
 pN/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHcHND1kTLKHeXJa0FmLxHtm9S0asEAKG4LXIwQn9g2LeECir758Zx4VIUShlx8P7/t96oIj9EPqU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUkpOcTTMMUihM0S1morDHxPAHGeerKYeOZb3gRL81d1B9Ci+1
 qNyv5fZmIxfBjHMAKUi8VJfzve8i1pGMLFd4qW/FyKcgNUm5I0Te26btmOag9nLMhxI3njUPCRr
 0E8zG7rbbHSSHcna4vrg7oqf9DRau3wouDFqAC7G52g==
X-Gm-Gg: AYBFou2Mtu4KLGQvQsh8/P4nzukqfMOdCBD0wYVC6kRfm5Y4vbcC1o0DxfR5qpuBnh2
 tc9zR/GgzTYsFiYRGfoqzqj+xiMe0o31HavM7bEoC2q+uSTr4xZkkbfTBRn+NISgZ2CylyVkQf6
 js2OvXKnkX6+TPj0lfSz6u46Z+bcbFL7Y/hwhfnzSURN7ys14aYOnNa+/JHjg29mTq71gOOx0SO
 ifz21z2Niafvo6MmAEbAxPw1uNhENBv44Y9Rea8qEA/wgmsyMO09t2JA4aVr33nQHoy4H1GmsT6
 zAHKHnX1fY0u21/IqIcUsCc53s+vL2/9JWVjksNqrHL0KoweAXpvxMSPX4RSzqDvYs5j91+jNuu
 0akSxWx2O+jiMEqu59IeMVh9aNXH51tFgmImArfrIm+XFb3FPtxaOFm+UEOZkLt7EiDnwBm1oNO
 +WnuLOceuUInpWhJ++rJpMZIU2QQ+zWfG1323+f4gpNTNyBSzZyYZnqA==
X-Received: by 2002:a05:6870:36c9:b0:49d:d318:c12 with SMTP id
 586e51a60fabf-4a89b8fc3a3mr1775504fac.32.1793123448237; Tue, 27 Oct 2026
 10:50:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com>
 <20261014-vc4-common-scramb-v3-7-c68d58d959a2@collabora.com>
In-Reply-To: <20261014-vc4-common-scramb-v3-7-c68d58d959a2@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 27 Oct 2026 17:50:29 +0000
X-Gm-Features: AclHuK9QePu5dfzFpjyvRzZ61mYTzHhRQlgWJ8M2sWAiOXGhDxVqz0HepknjYFs
Message-ID: <CAPY8ntBKv9HRADVTsaZ6QkBKx_3b1_NHLy=Dvb7Zjx0t=9FZog@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] drm/vc4: hdmi: Clamp CEC clock divider to its
 register field width
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
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
> The CEC clock divider computed in vc4_hdmi_cec_update_clk_div() is
> written unmasked into the 12-bit DIV_CLK_CNT field of the CEC_CNTRL_1
> register.  On BCM2835, the CEC clock is obtained by dividing the HSM
> clock, which in turn is scaled to 101% of the pixel clock.  For HSM
> clock rates above 163.8 MHz, the divider exceeds the field limit (4095),
> corrupting the adjacent CEC_ADDR field and truncating the effective
> divider, which breaks CEC entirely.
>
> The BCM2835 maximum pixel clock of 162 MHz yields an HSM clock of 163.62
> MHz, so the overflow cannot currently be triggered.
>
> Clamp the divider to the field maximum.  This is a prerequisite for
> raising the BCM2835 maximum pixel clock to 165 MHz, which pushes the HSM
> clock up to 166.65 MHz.  The CEC bit clock will then run up to ~1.75%
> faster than the nominal 40 kHz, i.e. ~40.7 kHz, which is still within
> the CEC bit-timing tolerances.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-168686@kernel.org/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 2451ff85e759..0a95e14792e8 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -231,9 +231,14 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
>
>         /*
>          * Set the clock divider: the hsm_clock rate and this divider
> -        * setting will give a 40 kHz CEC clock.
> +        * setting will give a 40 kHz CEC clock. Clamp the divider to
> +        * its 12-bit field to avoid corrupting CEC_ADDR; for HSM rates
> +        * above 163.8 MHz, the CEC clock runs marginally faster, but
> +        * still within CEC timing tolerances.
>          */
> -       clk_cnt = cec_rate / CEC_CLOCK_FREQ;
> +       clk_cnt = min_t(unsigned long, cec_rate / CEC_CLOCK_FREQ,
> +                       VC4_HDMI_CEC_DIV_CLK_CNT_MASK >>
> +                       VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
>         value |= clk_cnt << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT;
>         HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
>
>
> --
> 2.55.0
>
