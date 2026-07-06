Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B3C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B2B10EAC3;
	Mon,  6 Jul 2026 21:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NowApdTn";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870AE10E27C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:20:04 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-966d4748ad5so2420443241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783372803; x=1783977603;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUL7t+APH3oXBDBDeWSIILUsf2eovo+enLhGB6+dI7I=;
 b=NowApdTnSk/AtHO3gK/zy5A41YEfxT1eozzz9JMEgSHmJVGkunmXZ9G23/reGPCBZp
 2ups1kyBygbThwuBbOoITOiG2LKaenGGBKtxYHGwmqKzC+Es/qWS+D/dsyNqqi9NTeid
 XDwOFambRTD8zEIgzjEWiSeiO7jEi0HyG+KTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372803; x=1783977603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NUL7t+APH3oXBDBDeWSIILUsf2eovo+enLhGB6+dI7I=;
 b=Dk5Z7oASu796lBy9kqsnF7r1E74zigLajUcvAiXfPUioNDBYDiJnLVlYhMH1SSNm4/
 EqN/8rdwQHDIPEQRs4jrqMNk/a0uKtCBtxHADfJ7Vh/oF8GcBO89niP4c7gIWHJZe3jF
 q62cGiT/7HWLxOjJgz1AqjnvdlD6VPsoptn9rLCC8iPnIn5lUrgG6QsiXvC2Fk+yxys/
 54qT1Fgmn3mTucJcqEsOxXLffGBot94q1lPugRXxdxoYYJ0hhHhfpCqJCKJXFq9oge9V
 4A4g+YcEKBSydBEWpDQUCpaQwdMrDJLV5gZI9pMHICXSev49vtjqCw+9Kd48YD7isgxn
 Q/VA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ81PKJUjYSJfc63U0Xnao64Q0DPL/l49iQYLfzWkOg6tS9OoJWhjBOBpaSPE8Tbw8BXvEiiSG4/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPiBrKn2URLaJvpYILTIjF8E7944fVDzgGlw4vk0fHVk/8TyKJ
 8VX26nvEplRACRK6eLWTdFgUzhubq/DaaHalYrGjuhCLPjLZYmVh8ThRQWDQkd3cj5VciBVURdV
 Hc5A=
X-Gm-Gg: AfdE7cnlIdFKwsAM8Q5qXYoYzngPvWCcGvAG+5sRXKrr8B7bvXJRBDEpioBpgxFI1Cb
 VRoq31L2Q1siymtyuJK58DfHVZltj36Eg/A0Nkiy0H5OxfunZDL32S8ppE8yU4VGbSlpuWcz06l
 2pem3efDa5LLxsi6RBUvHP4rBqtGqFg1xyIBHwur5GfHiZ+PX0Bvk7KP0hRfIrWV+PEEwh07tJx
 aEUS3Mnf8zalOglF+UVb+e0dcSqEoS4P1bBIBokB2FZCBSzaU28gC5Dg0V30vEs7BNrxC4rUR4g
 iJCtdMXPQ5xRcufSohqi8XE6B3/P5D1XdTLe83bJMz6f+5CwGZuRvIHWUK16DToXakx8fgfL57J
 jZ9zi4vAEHy5ND5BXpvNfNJc9lTlOyhCspYZ3GWbWqkv9bUMGLCS55eXW6slhAsytjYesdWXXcl
 XztZUL9cuk4epnvd95iBQEkN7GwI679wiLyMCdEesqT09ZSmg6vHw=
X-Received: by 2002:a05:6102:688a:b0:739:d787:bed with SMTP id
 ada2fe7eead31-744b7a79118mr1415927137.5.1783372803292; 
 Mon, 06 Jul 2026 14:20:03 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96d61852cf9sm252624241.4.2026.07.06.14.20.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:20:02 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id
 a1e0cc1a2514c-96730906293so2347396241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:20:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RolTMV4tpkl+u3sm2oISlKlPGkSh2cKAJXcHHciYVkv2zZ8ZLWHMfuUC9ISO+SEEps5FqaVe5z+yco=@lists.freedesktop.org
X-Received: by 2002:a05:6102:c51:b0:740:127:c7f5 with SMTP id
 ada2fe7eead31-744b7b1c541mr1295589137.12.1783372800532; Mon, 06 Jul 2026
 14:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260706080333.41426-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260706080333.41426-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Jul 2026 14:19:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_wbetEhbDHtAR2ugxLZ1hSwBXBTgKMny-Yprru80xDw@mail.gmail.com>
X-Gm-Features: AVVi8CdEjifl5XmRYGzr9CyDMF5MKVIhMsLSY1s2aCRWXsfVsv_wUW_mRX_-66A
Message-ID: <CAD=FV=W_wbetEhbDHtAR2ugxLZ1hSwBXBTgKMny-Yprru80xDw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Support MNE001BS6-2 and MNF601BS4-1 edp
 panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

Hi,

On Mon, Jul 6, 2026 at 1:03=E2=80=AFAM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> MNE001BS6-2 raw edid:
> 00 ff ff ff ff ff ff 00 0e 77 86 14 00 00 00 00
> 0f 24 01 04 a5 1f 11 78 03 2c c5 94 5c 59 95 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 af 2b 80 a0 70 38 28 40 30 20
> 66 00 36 ad 10 00 00 1a 00 00 00 fd 00 28 3c 43
> 43 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 4d 4e 45 30 30 31 42 53 36 2d 32 0a 20 01 80
>
> 70 20 79 02 00 21 00 1d 15 0c cc 06 80 07 38 04
> 80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
> 5c 00 42 12 78 22 00 14 03 22 02 84 7f 07 9f 00
> 2f 80 1f 00 37 04 27 00 05 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
> 00 53 ff 53 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 01 01 53 53 ff 00 00 00 00 00 00 00 00 00 70 90
>
> MNF601BS4-1 raw edid:
> 00 ff ff ff ff ff ff 00 0e 77 3f 15 00 00 00 00
> 0f 24 01 04 a5 22 13 78 03 2c c5 94 5c 59 95 29
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ae 2b 80 a0 70 38 28 40 30 20
> 36 00 58 c1 10 00 00 1a 00 00 00 fd 00 28 3c 44
> 44 0e 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> 4c 20 20 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> 00 4d 4e 46 36 30 31 42 53 34 2d 31 0a 20 01 b6
>
> 70 20 79 00 00 21 00 1d 72 0d 90 07 80 07 38 04
> 80 3f 79 5c 9e 05 95 9c f2 1d 02 45 54 b0 5c b0
> 5c 00 42 12 78 22 00 14 04 22 02 84 7f 07 9f 00
> 2f 00 1f 00 37 04 27 00 02 00 05 00 2b 00 0c 27
> 00 28 3b 00 00 27 00 28 3b 00 00 2e 00 06 00 42
> b0 5c b0 5c 81 00 1e 72 1a 00 00 03 01 28 3c 00
> 00 4b ff 4b ff 3c 00 00 00 00 e3 05 04 00 e6 06
> 01 01 53 53 ff 00 00 00 00 00 00 00 00 00 e1 90
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index bb8ca80929254..e70d2615b3722 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2208,8 +2208,10 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE00=
7QB2-2"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MN=
E007QB3-1"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "=
MNE007QB3-1"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x1486, &delay_200_500_e50_d100, "=
MNE001BS6-2"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "M=
NF601BS1-3"),
>         EDP_PANEL_ENTRY('C', 'S', 'W', 0x1529, &delay_200_500_e80_d50, "M=
NF307QS3-2"),
> +       EDP_PANEL_ENTRY('C', 'S', 'W', 0x153f, &delay_200_500_e200_d50, "=
MNF601BS4-1"),

Seems like quite a long "enable" delay. It really needs 200 ms?

In any case, I guess it's fine. If you double-check and find that it
really needs less, we can always do a followup patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Support MNE001BS6-2 and MNF601BS4-1 edp panel
      commit: 1f223eb221eeefcc7425881d139d9b252fba4fab
