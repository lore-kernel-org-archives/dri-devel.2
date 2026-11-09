Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60A606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LB5+w76c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8BD10F032;
	Mon,  9 Nov 2026 05:23:14 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5407810F032
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:23:08 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c49c32650adso62451966b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794201787; cv=none;
 d=google.com; s=arc-20260327;
 b=gLb8+svHZ8cDQWB86kCLDSK1n/FdADhD5wdPY5GTwiS1Sf5L41eQkLCaz9XiNDCgoW
 GMCHgrh18ebibg+yGQE3OuHnwyraCwF1NX+M+zOR7b59RKv1PQZSoHln5xYFLwCWgLvv
 8KjDrsvxD7rp6qbNL8xJOXn293jYEfa8W8kYGJoNZPd5VfRbQ295RZNZjPVNufx7qf37
 c3wLbNuD4EYyJL59X0m391YXtObBClGJtFuUbzFouWVX8RzcWsQmj4UxZoeqBf4o+R3m
 ed9g08yajdJVKx2pjtaVQRIHJqXH9yL8XnQ1N2pTPO+2+94uyZ9WWq3MyJOGB+nA1D1J
 J2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WIf0dJI3704E56UOzqLD2NIWJwb6NLuXPSl2wIJw8fs=;
 fh=U4uP9QfhNkXGvrMQzVp741/LrLW7nqWLDh7hpaTUGfY=;
 b=gwte/x5EM7EDybyFPYQ0WSNWH0iOmy77mfrU6DZIYTQuOgEY5Ek2ke+FTotU0ZT9oe
 vArx0MpAJjySncRY9YD9tHjxP58MMO5VXdwpHAvS8MJW3eLa3wYuFWhTEA1FWQYS60Mx
 /zs8Lfxpw2VpxGaehN/TZagvaIUT2KXoJPenjJNshtsz8s0xwt+7ve2Ew+AxkqqzG3kk
 yUTx4iHkssafWIl6fBD07KFYE2yaMIQq72+5geM0GLlsUL6L5IFQ9r6YhTp3KB0doTQX
 wQ6KIWniTICfcFgycWDa4dl5xubuocjboPVl8ORfvVwZ+WnngqGaEIB6D6iyUyvYUDff
 DPkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794201787; x=1794806587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WIf0dJI3704E56UOzqLD2NIWJwb6NLuXPSl2wIJw8fs=;
 b=LB5+w76cKSHOEVBcLBbSxtmQmTyW8gbim1FKoi36QIluTU5oUG8LyJG9u3xWBIxZfm
 yO3HSr6iITWcp7Ox5Zm8OlvlJl5x5Y1QzPRatpxzqnrULRCExDLeyWArddUtp4Ry/37z
 ELgvwZlEJbILwRUpWgxyhwkGK90ZYxGjvOF403QcrPWUESXGhuiAZJfiHg1MZm/ZSnF7
 mEPEBcM1RW8sTx3VOGDY62vtOkpooH7kqBV+arsUrFED15YglwVSxNNrv1JYOcbGUMP3
 C1MZXwakvv0Qsw6Edv+BDMngptjVqpf+PrCyksAHbUjCGfEJ0N3cxiZ+IueLi0JIEQnf
 AwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201787; x=1794806587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WIf0dJI3704E56UOzqLD2NIWJwb6NLuXPSl2wIJw8fs=;
 b=x7qiws2rdeyM/8vTKhUUFFFjltTkMD4Xnk3pTPFSfM0Ea9TTDopm8aX39uytGRh9up
 FmmZOrEe5aoibAfWokFOuIKtwRUOU8tzX4SdZbB46mcUrgNsUOQ6G9Z4Yp2B2CtmOeky
 s4nE+e6taCeEW2Su6Sy2NhMGR/izC01AuMtv8jShueFgNkGdHUB4KMGhPCVZL4vjzIXj
 OJIiZUel4MzVCe3Flczxn6CETV5HyhYR6KiOr2o7Q68DuUL5a/fDvW8y7hoZB1r5sLkF
 86GPZExhCntdaKV1aLkU7KY9qXjjvpW68b3tGH1H5W2ao1/cDwKd0IHCiMC+NdyeHdSg
 Z2og==
X-Forwarded-Encrypted: i=1;
 AL+hErEvOM6qjjwZUwK+REXCYiP62zS6X0TUjrnZNwbSCGVEmRIGzPq1ctnXJq8/qPYqzEcIc5118J+ZYis=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/C5+QBHOVwat11ftPS4N8Un2JiAgXqZ+41GaMqYHjaLyzSQs1
 I2B162VvB0hviirfXOCaMKGY+7xpoyLOklySjzzheGbnqtUQTWKkiAsGVEpZP3ij+tSC8VoxtSL
 buP4X5+Uspar6f0XCjD73V2jtd/HKXus=
X-Gm-Gg: AYBFou1tBlRgirjNhuf50YBfBitAYI5jOMGWS2I6YfE3BmMJYuuuD1BsgHTbV/n5qX2
 dOwu1m/o8Buos4ibQMpPqSOJuQpRCPeRcEyj+ibhSMj5AEwwXX3fFpj4+hRc8oeOO9BtZ4RqBtv
 YzdxcHN1DhiFl7GLlUuH35lb1vuKRUDxYD/13rZDUfpjNg3dnnDr0ZDA6uOMDaNA5ebTqrSShn1
 H/lK2/IFwDZjw55wz6ZsvKIKzRfcIY4Fkx72pL9JVf6DSmeWgi97mYKc7YPteiX95dPMeIZaswe
 XBk0tUeGs/+H8AsmEKK8Gym5mV1fMhufhzb2/svE1A3+eUH+1AcssCtpMmhbZNL1zUjR3P8BkcG
 KGGnbQIKR9+YwjjgtqekbSAqEHABDKI8ZVF1lxOYm35ng39VKYCisFovu/RyVcR6eXFrS
X-Received: by 2002:a17:906:99c4:b0:c40:80eb:c541 with SMTP id
 a640c23a62f3a-c4d6d162393mr200408166b.2.1794201786662; Sun, 08 Nov 2026
 21:23:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-2-3a45c3cf531d@a-marquet.fr>
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-2-3a45c3cf531d@a-marquet.fr>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 14:22:29 +0900
X-Gm-Features: AclHuK81atJWOGvLDgXq9hG63fw54it5ISsaMjIoBGuiYyjTASlvmDvAtFTGEpY
Message-ID: <CAAQKjZNBb4CnhBn-TSD=8zbrOtWbu7fdpJDjOOvfAZQmAhNcYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/exynos: exynos_dp: change poweron/off to encoder
 enable/disable
To: tb@a-marquet.fr
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
 Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Lukas Timmermann <linux@timmermann.space>, Henrik Grimler <henrik@grimler.se>, 
 Hendrik Noack <hendrik-noack@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

2026=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:09, =
Alexandre Marquet via B4 Relay
<devnull+tb.a-marquet.fr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Alexandre Marquet <tb@a-marquet.fr>
>
> Current functions exynos_dp_poweron()/exynos_dp_poweroff(), that
> supposedly powers on/off the device, actually only enable the encoder
> clock. This cause issues where poweron() calls fail silently in
> analogix_dp_probe(), leading in some cases to a state were the encoder
> is never enabled but the rest of the driver assumes that it is.

Moving the FIMD DP output clock control to the encoder callbacks makes
sense. Analogix runtime resume can occur for AUX access before
encoder->crtc is assigned, so its power_on callback is not a reliable
place to enable the display pipeline clock. The DRM atomic helpers
call encoder enable before enabling the bridge, and encoder disable
after disabling the bridge. That ordering keeps the clock on while the
display link needs it.
The change looks good to me.

Thanks,
Inki Dae

>
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> ---
>  drivers/gpu/drm/exynos/exynos_dp.c | 40 +++++++++++++-------------------=
------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/=
exynos_dp.c
> index 82c238829921..16b00aacd55b 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -43,39 +43,27 @@ struct exynos_dp_device {
>         struct analogix_dp_plat_data plat_data;
>  };
>
> -static int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *pla=
t_data,
> -                               bool enable)
> -{
> -       struct exynos_dp_device *dp =3D to_dp(plat_data);
> -       struct drm_encoder *encoder =3D &dp->encoder;
> -
> -       if (!encoder->crtc)
> -               return -EPERM;
> -
> -       exynos_drm_pipe_clk_enable(to_exynos_crtc(encoder->crtc), enable)=
;
> -
> -       return 0;
> -}
> -
> -static int exynos_dp_poweron(struct analogix_dp_plat_data *plat_data)
> +static void exynos_dp_mode_set(struct drm_encoder *encoder,
> +                              struct drm_display_mode *mode,
> +                              struct drm_display_mode *adjusted_mode)
>  {
> -       return exynos_dp_crtc_clock_enable(plat_data, true);
>  }
>
> -static int exynos_dp_poweroff(struct analogix_dp_plat_data *plat_data)
> +static void exynos_dp_crtc_clock_enable(struct drm_encoder *encoder,
> +                                       bool enable)
>  {
> -       return exynos_dp_crtc_clock_enable(plat_data, false);
> +       if (encoder->crtc)
> +               exynos_drm_pipe_clk_enable(to_exynos_crtc(encoder->crtc),=
 enable);
>  }
>
> -static void exynos_dp_mode_set(struct drm_encoder *encoder,
> -                              struct drm_display_mode *mode,
> -                              struct drm_display_mode *adjusted_mode)
> +static void exynos_dp_enable(struct drm_encoder *encoder)
>  {
> +       exynos_dp_crtc_clock_enable(encoder, true);
>  }
>
> -static void exynos_dp_nop(struct drm_encoder *encoder)
> +static void exynos_dp_disable(struct drm_encoder *encoder)
>  {
> -       /* do nothing */
> +       exynos_dp_crtc_clock_enable(encoder, false);
>  }
>
>  static const struct drm_encoder_funcs exynos_dp_encoder_funcs =3D {
> @@ -84,8 +72,8 @@ static const struct drm_encoder_funcs exynos_dp_encoder=
_funcs =3D {
>
>  static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_fu=
ncs =3D {
>         .mode_set =3D exynos_dp_mode_set,
> -       .enable =3D exynos_dp_nop,
> -       .disable =3D exynos_dp_nop,
> +       .enable =3D exynos_dp_enable,
> +       .disable =3D exynos_dp_disable,
>  };
>
>  static int exynos_dp_bind(struct device *dev, struct device *master, voi=
d *data)
> @@ -171,8 +159,6 @@ static int exynos_dp_probe(struct platform_device *pd=
ev)
>
>         /* The remote port can be either a panel or a bridge */
>         dp->plat_data.dev_type =3D EXYNOS_DP;
> -       dp->plat_data.power_on =3D exynos_dp_poweron;
> -       dp->plat_data.power_off =3D exynos_dp_poweroff;
>         dp->plat_data.ops =3D &exynos_dp_ops;
>
>         dp->adp =3D analogix_dp_probe(dev, &dp->plat_data);
>
> --
> 2.43.0
>
>
>
