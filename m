Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F70CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 00:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B80010E011;
	Sun, 10 May 2026 00:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cowI7enV";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B287810E011
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 00:13:21 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso3882369a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778371996; x=1778976796;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiZ7BjG4NTjl/vEBJJRxsUYSlPszgMUxNIvT/H/FJy0=;
 b=cowI7enV4hBodwNpXAqKNgCLCStHQu15QbH7SerSqtLLXSDst7Go4VWhVwuzIJl3Ap
 57A0n+tLiDJJQ4NIJBwxSowqY3tcef5r4rCMoPMryQmm4dISoDXXyRTINaA3MBOKisHZ
 WNKAEUcCFH9KCkhw7Yh7XXzcEXOensOycVMIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371996; x=1778976796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yiZ7BjG4NTjl/vEBJJRxsUYSlPszgMUxNIvT/H/FJy0=;
 b=mFxNtNpueO6Uuw9T2mui0chfWBQmS49PonRfWGwQyI1T6EkgZIWt79LSrQ4BIJ5jnD
 LN4bChk4TtHPUZJn/cbI+upm1m0YxpzNLr3a0JmfVjY1aFvvaVVGwxEIQaV7zD6+q1Ur
 5O+e7rTNIHbs2xbpE2e16tagyBBQhh/Y1B9kvx4cHpdsX179NofvfsiWhW3cAJkD6LY1
 vhD3gjkZhZ0pN611DmEYlqhfFHONu7oS9uT9J7sbECa5he75b9VGvrlQNS8awKzrd3tl
 3ya8Z6DcBLlCu+5W4PGEsJh9yuI1XT4D0i8XEFLtqk+mRG/JbYhS571IotvUU7cOiqe3
 KdhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3zgu8beIqzbv3gcU2X4RcG0ldGPxVjXMsoCBr5UpdfJz7Zmen/MhbtSnOogjXUVWG7K9I22gyV5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzA896vNkXxo9E/SChdVX2InVANba0CHkzzyvhppLqxmDkPwVfy
 a/sSItEGVZ5NThdoMu8JTrXE3+h+WRqQjWKkB6GzQ3DYJ9DrZ/F2QFCTDCdhLQ5sJ0hoA8oFz1D
 wvQ3tHw==
X-Gm-Gg: Acq92OF/z7ReZ2HNdfJrR1/nARFSrhfnI1Vtr9k5Xu8pswjM4J/RZdRrwnRNVeoehya
 MZbClsyJv/QD3mknyUEe96oKFmNxNOe709Xq/4DL99Xlu+kfjxEq15KN9TquQCVQWJm6ri4/vVR
 5NgWqNj+oKmvd28dJAYhtVzbn75FVIfisarhkqmikNGdNmTwdYwCSIFfmuv4EKiojEElEd3OXs8
 fF/mzLeYQFTDPAU8w+AEP/Lnr1QjShp/UwOLNn8EOmHtvhX0mEEpH5RHM3AHtx8n3QUZ0qTDzUw
 KQnHtU8ieAPDB5kSQATgphj+zTQ4WAlRDTaCQLXgG9HyXbqGGJkji4rLZFBnc99EO+ei/udIhH3
 /pVQpSwQVwiiyT8vqCSckGQc9m54vRtNCzW4rFFf3CrXj+z05N0Ctw1JuTJC1GAVDyv3UKNKxCu
 WvlOOAAgdry42LWNcaslxY2++owWmDUtS/5ZaU0J/Zj+bAeyauQ+waFqWLubHxkw==
X-Received: by 2002:a05:6402:5407:b0:67d:2d17:da25 with SMTP id
 4fb4d7f45d1cf-67d642b04e8mr8865090a12.13.1778371996226; 
 Sat, 09 May 2026 17:13:16 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0b3b904sm2074788a12.1.2026.05.09.17.13.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 17:13:15 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so2451901f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+WdDrEEQPd37ykB22XVj0+mS07L8UIXxkGM5oMeURTThVyoEiLAXwUSHzRhyOSUtGYExMglP9xT6k=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2507:b0:43f:e7c4:a36e with SMTP id
 ffacd0b85a97d-4515b525d56mr30073665f8f.16.1778371993324; Sat, 09 May 2026
 17:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
 <20260506170607.10813-2-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260506170607.10813-2-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 9 May 2026 17:13:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVThCiGDwLNMRHNXTajxs1B=2kwBRS54DsJcEak1OEZw@mail.gmail.com>
X-Gm-Features: AVHnY4KRY6KJ4HA4JSdLXREIe9r7ulh-Haw6_UGXBSZWsoK8KbRIWZ8iV1CXoS4
Message-ID: <CAD=FV=VVThCiGDwLNMRHNXTajxs1B=2kwBRS54DsJcEak1OEZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] drm/panel-edp: Add AUO B140XTN07.5, AUO
 B140HAK03.5, AUO B116XTN02.3, AUO B140XTK02.4, AUO B140HAN07.7
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
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

On Wed, May 6, 2026 at 10:06=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The raw EDIDs for each panel:
>
> AUO B140XTN07.5
> 00 ff ff ff ff ff ff 00 06 af 90 02 00 00 00 00
> 00 1e 01 04 95 1f 11 78 03 c0 d5 8f 56 58 93 29
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
> 36 00 35 ad 10 00 00 18 df 13 56 e2 50 00 1e 30
> 26 16 36 00 35 ad 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 48 0f 1b 7d 20 20 20 00 09
>
> AUO B140HAK03.5
> 00 ff ff ff ff ff ff 00 06 af 9f 3c 00 00 00 00
> 00 1f 01 04 95 1f 11 78 03 f5 65 8f 55 5a 93 2a
> 1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 b0 36 80 a0 70 38 24 40 10 10
> 3e 00 35 ae 10 00 00 18 75 24 80 a0 70 38 24 40
> 10 10 3e 00 35 ae 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 14 0e 1e 7d 20 20 20 01 02
>
> 70 20 79 02 00 22 00 14 df 22 02 84 7f 07 9f 00
> 0f 80 0f 00 37 04 23 00 02 00 0d 00 25 00 09 df
> 22 02 df 22 02 28 3c 80 81 00 10 72 1a 00 00 03
> 01 28 3c 00 00 60 50 60 50 3c 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3f 90
>
> AUO B116XTN02.3
> 00 ff ff ff ff ff ff 00 06 af ba 49 00 00 00 00
> 00 23 01 04 95 1a 0e 78 02 6b f5 91 55 54 91 27
> 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
> 36 00 00 90 10 00 00 18 df 13 56 e2 50 00 1e 30
> 26 16 36 00 00 90 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 50 05 18 7d 20 20 20 00 7f
>
> AUO B140XTK02.4
> 00 ff ff ff ff ff ff 00 06 af a8 67 00 00 00 00
> 28 20 01 04 95 1f 11 78 03 c0 d5 8f 56 58 93 29
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ce 1d 56 e2 50 00 1e 30 26 16
> 36 00 35 ad 10 00 00 18 df 13 56 e2 50 00 1e 30
> 26 16 36 00 35 ad 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 48 ff 0f 3c 7d 11 23 21 6e 20 20 20 00 8e
>
> AUO B140HAN07.7
> 00 ff ff ff ff ff ff 00 06 af ad c7 00 00 00 00
> 21 21 01 04 a5 1f 11 78 03 fa 95 92 56 5a 92 2a
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 56 37 80 bc 70 38 28 40 10 10
> 3e 00 35 ae 10 00 00 18 e4 24 80 bc 70 38 28 40
> 10 10 3e 00 35 ae 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 3c ff 0f 3c 96 23 10 28 96 20 20 20 01 66
>
> 70 20 79 02 00 22 00 14 5b 29 02 84 7f 07 bb 00
> 0f 80 0f 00 37 04 27 00 02 00 0d 00 25 01 09 5b
> 29 02 5b 29 02 28 3c 80 81 00 10 6f 1a 00 00 03
> 01 28 3c 00 00 8b 11 8b 11 3c 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0 90
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/4] drm/panel-edp: Add AUO B140XTN07.5, AUO B140HAK03.5, AUO
B116XTN02.3, AUO B140XTK02.4, AUO B140HAN07.7
      commit: 4c34cdb93ea187b46d287a77a8946268a7d24286
