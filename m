Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE97FD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E747F10E565;
	Wed,  8 Apr 2026 08:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EdzAMEba";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E9710E565
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D62843F5C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA64C2BCAF
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775636127;
 bh=xZTSZRs0sbRDgY1K81wjxHHQ/9DUVcEHhVIDQRsGRhI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EdzAMEbaoAnwjaLYx0qzcbimv03/A8Yk6Fbq3r0R1iFfdf4Z6C7AG85cLOUpTbzB3
 0IMj4KLokxXA8A/AunIVVsYNUkMz1qGzZ9lSlZhKexHjmCZOsMsmso2fWhlzIdAxpk
 yDbFfRTCHmB6hMFHnmhldWEbWIT1Swb4JT3AEv4g6uaTTkzD3Zn3UiWCr3ku/SaHCa
 rbpiJZtAoSx6CdbB2ul9eI937QKOMmZgJnCJqOTCYl+kT1koFVUF7RXgGcQGSmhi6E
 Od45wUmL4X6+Ci5KINf5W4Mdl3Ri9XvnVFzaPrZrHCgrljyvGSw1DH360UFLKnpGlQ
 e14xIoWW85i4w==
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7986e0553bdso58961727b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 01:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUvR/X7nzQsL9dY4BdM/S2z20rQrlsel1rzF8laI/MMDpfObhsY9oa3xcFtkP6RH7TXd8UIziTrMs8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZcffleF9EWVZt25km9njPsprWfN+DHj+PZx+j/mKHhV3KANgW
 axSTGiJEfWCchgq/iHTDt5O0gWvQ0wnA9mtUXpc3hZPUia33vAanDPAUlvprbLt193Q06/OoIR7
 xFCzDYp+xQT1abVQFkTtOuNR1D1Kd7MM=
X-Received: by 2002:a05:690c:6c13:b0:79b:e346:fcfb with SMTP id
 00721157ae682-7a4d536d25amr203296817b3.32.1775636126528; Wed, 08 Apr 2026
 01:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-12-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-12-5e9119b5a014@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 8 Apr 2026 10:15:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLnAaUzHun-i7PBLzFQmsKCXXfRO+4hAgTFCZtLm_Bu6iw@mail.gmail.com>
X-Gm-Features: AQROBzDPMsTo8Q-h8qP3H_WTkRwwClJVDSsQZesP_kI3xg0qbihfSen8BjVkm48
Message-ID: <CAD++jLnAaUzHun-i7PBLzFQmsKCXXfRO+4hAgTFCZtLm_Bu6iw@mail.gmail.com>
Subject: Re: [PATCH 12/19] drm/panel: jadard-jd9365da-h3: support variable DSI
 configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

Hi Dmitry,

thanks for your patch!

On Wed, Apr 1, 2026 at 9:27=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Several panels support attachment either using 4 DSI lanes or just 2. In
> some cases, this requires a different panel mode to fulfill clock
> requirements. Extend the driver to handle such cases by letting the
> panel description to omit lanes specification and parsing number of
> lanes from the DT.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
(...)

> +       if (dsi_ctx->dsi->lanes =3D=3D 2)
> +               mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x01);
> +       else
> +               mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);

If lanes 2 we do unexplicable magic A else we do unexplicable magic B?

Do we know more about what is actually going on here?

Can you check the datasheet?

The patch is nice anyway and no big deal so, so +/- that fixup:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
