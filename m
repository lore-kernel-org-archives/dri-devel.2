Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9F606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5390E10E3BD;
	Tue, 17 Nov 2026 15:13:01 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A31610E3BD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:12:59 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5eafb65e169so3721760e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928378; x=1795533178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lXzAHAHuyb7ljn+BW0UDmcAkjyTtMTKu31hzJUVD5x8=;
 b=ZE8fPuYpoR9lKJy8Wz05QNYVkCDWRtXjlrdn+DmAhhooMvV1mWLMpeN31BQRxGdvdA
 LkGELzCG00CiNqLr15Zh1yj2B9sI3jBaqgo87D7LHg59bl+0yww4yJFhiHhQ4AYEZk9q
 yMQ/UBdWQcyjir7vnRYmAfKqDYDbTCVXjKguLwrpmTdYfQW2YZVAz5/IdU/gO3t2dcbY
 LH/jOgk9qmfUuWuYwWeW/u4xZ68shVUD1Lw1dLfkdiExPQugumOyQ4FSd/UQKWuWjR4a
 drEOYHYi1zyOUPKQuheg/ygO4H14jqpFNqjC/Tu2pAa0GTUPr1tOU/nrGd2lrmfl3l50
 y5Sg==
X-Forwarded-Encrypted: i=1;
 AL+hErGUsi6ahYyt39sxfrQcowJTwbq4cGEZJ2g590t8f8fW/hJ4ge4ocjKyZ/rSJtlCyhFn822TfcoyZaQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9snnyEhp+vwuwvmji6bwNNFgzI/X71D+NSn/qB/8Tea2ysCME8
 csRJ3J6oACgTaiUlGu3rCzvrADcboK2V/ywTvgIaCkn6/rNFnmuJok+Abp9Fte0H
X-Gm-Gg: AYBFou3G/WRHYBNdoYCPZuRb7autBUwwSpmR8JXImbQr0rrHD5xMjPhkE4vtCFv3KKY
 VNDeGJUwfIAmhJNeiEXxxL/jGts45FO8K2c1XnvR/YUN+B3oOOXbq5SMb86jEUfoOkfI3RAS9gH
 aJ/iZ16l+MAKwVonCdW3MVJ/dDXk2TNaxdrunXeMxp+lRzlt+hg8bFq6l49Dkzx3ZLUWQdNbmg3
 W0EydVJ19tNdEiLJ8ln/xTG0LDq0OlHX/DWg+JHCbt++bwzXJyXXBYHmgmHbCwdxk7fQpcGbmmZ
 8ZxFOtk36YAwbCku7xRBpu5LslSuJrx1D4SqCrD256iappskfLwA66M4xIKetptG/zRDT+d2eVW
 nPbfGr5w8985fm3VZUGuo2E+ncP6+3+qYjeCvUOia6AqEgoCWji7zLOLJzSKisKYEdFfXoAR5NV
 NFdCORNMIER6wbRV5AtfRKnehrAWI7Loja2vnCM51ltu6sYvQKU+YjkaxJG2jnUHxU4tTlTjF+P
 Sf5smifWKwpQ9+nXvzezqyuJ16Vm+0ftmrJjjNe2RtrPDO2OpFyFKrANplXyZR2+vha7SeQSdj+
 XeBqjHkBdKB/LqtQxYW4+9fa73vOmHNAoiy9PbxmITyP3LOQ/oNb1eLYWfQNi8gudsA=
X-Received: by 2002:a05:6123:2e9:b0:5ea:c722:b3a with SMTP id
 71dfb90a1353d-5ee34a62054mr6227672e0c.7.1794928378251; 
 Tue, 17 Nov 2026 07:12:58 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com.
 [209.85.222.54]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee34e67eeesm8373691e0c.10.2026.11.17.07.12.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 07:12:56 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-996eeadfbeaso3443767241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:12:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGdAzPZZyPXpR0msJfNpakUNlejiGeB0btg1v6e6OTNRiAPn9Q7spJzXKzfPEUWz+XsXz6W640Gk0E=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4202:b0:5ec:c180:e1a1 with SMTP id
 71dfb90a1353d-5ee3468bc3dmr6118113e0c.2.1794928376130; Tue, 17 Nov 2026
 07:12:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
In-Reply-To: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 16:12:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
X-Gm-Features: Aa3M54ptylXmhL6SzM56Sx5LCXa21m2jXwzZpxrJX2kGuRvWvlxVM_ksOElm6ig
Message-ID: <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: Add suspend/resume support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tomm.merciai@gmail.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tommaso,

On Thu, 12 Nov 2026 at 09:31, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Add suspend/resume support to the RZ/G2L DU driver.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -140,6 +140,27 @@ static const struct drm_driver rzg2l_du_driver =3D {
>         .minor                  =3D 0,
>  };
>
> +/* ---------------------------------------------------------------------=
--------
> + * Power management
> + */
> +
> +static int rzg2l_du_pm_suspend(struct device *dev)
> +{
> +       struct rzg2l_du_device *rcdu =3D dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_suspend(&rcdu->ddev);

error: passing argument 1 of =E2=80=98drm_mode_config_helper_suspend=E2=80=
=99 from
incompatible pointer type [-Werror=3Dincompatible-pointer-types]

The "&" should be dropped...

> +}
> +
> +static int rzg2l_du_pm_resume(struct device *dev)
> +{
> +       struct rzg2l_du_device *rcdu =3D dev_get_drvdata(dev);
> +
> +       return drm_mode_config_helper_resume(&rcdu->ddev);

... likewise.

> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> +                               rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> +
>  /* ---------------------------------------------------------------------=
--------
>   * Platform driver
>   */

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
