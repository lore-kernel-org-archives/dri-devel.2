Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A52606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRVirGcB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE44810F021;
	Mon,  9 Nov 2026 05:16:11 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E97610F021
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:16:05 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c434376dbebso79022966b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794201363; cv=none;
 d=google.com; s=arc-20260327;
 b=LxW+a2vasesxvG5RMkKBKJ/+b99wlSUBy/fMHkUrjP6y/qnDrjndc2IRPgtPigM3Ru
 9mDEnONCTeRdGr2OK0S1sG/EUFgrReUrzVhrTYq0vcjvgeL0QzmAU9J3Fdq+0jozcZxe
 zIHN7ZzzYW+gnVUqIVLCGiBieOHyTnHl9YcaeZpOctxa5eIyFU9KLOmS1NHINmMZywZe
 XI02p1VhYitKN4VYRek5XKx7BRNYuxAQfz/Sv6alIamsO3CQLeeKaHPsZZZ5aNd4wpgI
 +re/QN4gmKnbSBDL1M48e6XX8fWq4ce6+MYeSxxCxh7BuAdvSxtpDlQzX7oHf6FlZ+pf
 9qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+H+W40F3xi/JoWhY4dp3q7kYo1VTM28uEFHWyVVy0qE=;
 fh=g60LB5rgeE44ALaGG1OIFJmu4f+JJ5fqOW6nYP1SEL8=;
 b=Y+ZY0mcs3wTv/YSNhJPjA9Gu5PyCECsWpI0zD4xGq8H5mb6fxt2tiOYghaYNj8o1IR
 MgXl4JjM31e75tI75QelEKjkagr67VvQHAt4mXnOqqCKhOnEwHS00lu9lIQs3a43g3zv
 KLQLS0Wh3HvfskEtSDidjpPqiHCudGM9p3gOt8Mo7hf0yu5USek5/eh2VMJksBzb2El7
 IBv1Rquj+BVfKftYM8yBErIah8NZg5dLXGFmKhbp+CRg+0EKlbIZf324USQp/6jHNmzr
 kM2itsktrvUyInYDFa0NTkKUK77jlUqc/th5d925OaHMUz0Tbd3opJdvnZ5BqxqDw6os
 BncA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794201363; x=1794806163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+H+W40F3xi/JoWhY4dp3q7kYo1VTM28uEFHWyVVy0qE=;
 b=PRVirGcBmEOZFr3qjuwJ9uVBmSVMm02vsiCdtCaRK0jITTWbDkhRiacuQeE1BHAaE6
 6RmLdEdnICtHOSXCVCs7h0T2ZSFcImjvPdcAlUahJf9gXEKkdiRA7I8EkmG8epybDKfm
 pnZi1+MM+23CTkWID49Wr7oUSjTBW8Ma/XRYmfM5591vGOgbGkbaytfE4IJ22+ZDqzcK
 JAkZfu46sC7y/sbZnhZGNjF2LjJlxrt4vA3dUTWWIwAsfH63e+R/A0mee5vanC7p5gbW
 oOGy14zLFI+yncfI8BQIdF9VUo5emukG7Yqm4f6Ft9mJ+8DV+4fQzvwL/4l/Wk3UZi1H
 SG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201363; x=1794806163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+H+W40F3xi/JoWhY4dp3q7kYo1VTM28uEFHWyVVy0qE=;
 b=qXk9o1aYOG4FPgY6hNYMEuV+eZ95Ro2CBUmALmYURCRtsz3epWUYv81PJNoQ7UOdUo
 +UWsCrL0wHqAyZX5khdTRw3pNyDRd3EBFFevz5ZyZ0wJbp/HPEbJrUd3nB3gq2Qv5Q/1
 EnUtHWW9nGkkpoCqA3QyRNF021/d5f7lb65YFC0QfxVzfnLDzR2DMHj+9ddG2FQSH5u6
 4f5e//1OqtrLrBgA1qeGGypByA15tKMAQoQ6cxVrQ91GXEGzqbCQvfCsBo16X8Ik4O+J
 1l49DU1DQZiLejC8VH/jbcQeaLTOtzO5h8hsLtKzZNMIKIvcdi+ayOUnuqhvyxpereta
 xl7g==
X-Forwarded-Encrypted: i=1;
 AL+hErEY8W0ELauBRZVUXvJkY1FMt3dcx2WDpMNjkSuocCHicYXDOdp+a3i5hULhGkrmjNWxQYyJTZoJuN8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+n+KYKBrNUdFsrsPf37eFVCviOjJZrLv/+tOk1y1riYaxcoroJ
 9JT1hUmVjlEKyy1HfH3HVs8AQ7FxCg5e+YxW5dGWBs0wjCCb47U8ygXo1T4pFDOXhMYcx7+Q78i
 KtJttr156FoZkRKDi/zQzliSWU+D2hJY=
X-Gm-Gg: AYBFou0JsezBNQ15rwySOrScOzGsXJOrGN1gEL3b9nj+h3n9ImPXOpSmkKRIoYTeb6Z
 qO0lmCSNAiCGq1sQZvTzlybFu+rPC5yyV/tTpyxTsrSQcGPrxjLVR7Gve3ececjPNMcKh0XMzd2
 mzZLc2MXF1RwCepfa+q/T7IU/IOyBA7y2FyWHNpdl6f9oDL5QNH2cvrSoVzLbPUahDjedMDz464
 mYzjpaHuH5hlNK1flGWxlfnCFUCFx56XZUvtMS7VLDFPsLREMt/YAht/MTHNE7q1DWFKrHY7oGU
 YhNIgBwaoMCyOBboSYvrhk30MEZHgLtNuHxCDewQRb6JoAuXNlWYkwvtk/TJDjHI3hA2NTfNWWZ
 UetBHA+STKTTaMhy3SqmffeI66jpv9mdTdbVuYmUGetWQeofIS16Kg8AwQnfWh+DQUJU=
X-Received: by 2002:a17:907:94cc:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c4d5278459amr332595566b.14.1794201363497; Sun, 08 Nov 2026
 21:16:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 9 Nov 2026 14:15:25 +0900
X-Gm-Features: AclHuK-Znic_YSiZSxmlzXLOPryrS4zIPNf3mp5uhFcTlxhpKBhiJT7EHmt8c3E
Message-ID: <CAAQKjZPYAn98+8Wtjesr7GCh1s_pX8mWizW=HoY5Pj9xO9St=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: analogix_dp: deassert DP_PHY_PD on
 power-on for exynos
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

2026=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:17, =
Alexandre Marquet via B4 Relay
<devnull+tb.a-marquet.fr@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Alexandre Marquet <tb@a-marquet.fr>
>
> On exynos platforms at least, calling
> analogix_dp_set_analog_power_down() to power on (with enable=3Dfalse) CH0
> to CH3 or the AUX bus currently produces no effect, unless the function
> is first called to power on everything (by setting block to POWER_ALL or
> ANALOG_TOTAL). The reason for this is that DP_PHY_PD being asserted
> (which is its default state) renders every other register bit
> ineffective.
>
> This is particularly an issue for AUX bus initialization, that tends to
> happen before anything else (e.g., to request EDID), and thus, before
> anything has any chance to request a power on of the whole analog
> section of the chip.
>
> This commit allows analogix_dp_set_analog_power_down() to power on any
> block, by deasserting DP_PHY_PD if needed.
>
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 +++++++++++++----=
--
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index c1344a3f013a..9f634d4e4793 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -256,6 +256,19 @@ void analogix_dp_set_analog_power_down(struct analog=
ix_dp_device *dp,
>         if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_t=
ype))
>                 phy_pd_addr =3D ANALOGIX_DP_PD;
>
> +       reg =3D readl(dp->reg_base + phy_pd_addr);
> +
> +       if (dp->plat_data && (dp->plat_data->dev_type =3D=3D EXYNOS_DP)) =
{
> +               /* On exynos, register AUX_PD and CH[0-3]_PD have no effe=
ct if
> +                * DP_PHY_PD is asserted. So, when powering any of them u=
p, we
> +                * need to deassert DP_PHY_PD first.
> +                */
> +               if (!enable && (reg & DP_PHY_PD)) {
> +                       reg &=3D ~DP_PHY_PD;
> +                       reg |=3D AUX_PD | CH0_PD | CH1_PD | CH2_PD | CH3_=
PD;
> +               }

When DP_PHY_PD is set, this path clears it but leaves the bandgap
power-down bits unchanged. If the register retains 0xff from
POWER_ALL(true), an AUX_BLOCK, false call produces 0xcf; both
DP_INC_BG and DP_EXP_BG remain set. Could you check whether AUX can
operate in that state?
I suggest limiting the new handling to AUX_BLOCK and CH[0-3]_BLOCK.
When the bandgap bits are set, keep the other blocks powered down,
release DP_INC_BG, wait as the existing POWER_ALL(false) path does,
and then release the remaining required bits and the requested block.
This also avoids changing ANALOG_TOTAL, false, which currently only
clears DP_PHY_PD.

Thanks,
Inki Dae

> +       }
> +
>         switch (block) {
>         case AUX_BLOCK:
>                 if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_dat=
a->dev_type))
> @@ -263,7 +276,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 else
>                         mask =3D AUX_PD;
>
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>                 if (enable)
>                         reg |=3D mask;
>                 else
> @@ -272,7 +284,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 break;
>         case CH0_BLOCK:
>                 mask =3D CH0_PD;
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>
>                 if (enable)
>                         reg |=3D mask;
> @@ -282,7 +293,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 break;
>         case CH1_BLOCK:
>                 mask =3D CH1_PD;
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>
>                 if (enable)
>                         reg |=3D mask;
> @@ -292,7 +302,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 break;
>         case CH2_BLOCK:
>                 mask =3D CH2_PD;
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>
>                 if (enable)
>                         reg |=3D mask;
> @@ -302,7 +311,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 break;
>         case CH3_BLOCK:
>                 mask =3D CH3_PD;
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>
>                 if (enable)
>                         reg |=3D mask;
> @@ -321,7 +329,6 @@ void analogix_dp_set_analog_power_down(struct analogi=
x_dp_device *dp,
>                 else
>                         mask =3D DP_PHY_PD;
>
> -               reg =3D readl(dp->reg_base + phy_pd_addr);
>                 if (enable)
>                         reg |=3D mask;
>                 else
>
> --
> 2.43.0
>
>
>
