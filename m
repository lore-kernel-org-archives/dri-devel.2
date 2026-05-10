Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B77CD3447
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 00:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB39F10E1B4;
	Sun, 10 May 2026 00:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJnCO18k";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2745910E1B4
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 00:13:53 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so8392966b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778372029; x=1778976829;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCPtbe4gEP74AZhGwPIgxtRmuTvAy4qgOmZMPRaZAP8=;
 b=gJnCO18kfKh5sv3/UAQDECbirLpyQ1UAUeJtihRwr58ooN9h8Wz2+lyeu3SmzUfCHo
 gwCj8dAej0piHXnAftNEDa3w7RCl9mS4g+OyX6BKNBsQST5vM/JK92iNbMflIdI300El
 HKodnsLxPauNBuRdGGNBkamQeMDGzPBHpVfhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778372029; x=1778976829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GCPtbe4gEP74AZhGwPIgxtRmuTvAy4qgOmZMPRaZAP8=;
 b=l72Dfkjajx9/mr/6VbnuR5BLIz3uPGtL1S/Y3jpVJRhuxz133qQnSG7MeHnZ0pEjur
 ugpOWd3EyIxW8ktppO3RztUSfSGVdGbHO+I35KDDEpRCeGh6GWk+0OuS24H01WA4ed/8
 ZGUd8qYglZg0z2l4rooloGyRF6z7sWhxab644U8LamxP5S86r0Le/ft4T8SW+T28ueI5
 u4/aj7toHNB/+1AzomYqy2iArmA/yBQcJr8czUXWFPhcVcU7TPh4Y/8V4wfNYfY1TWm/
 o4fcuVHex82zI6790HkQeaqb0y1brXxiB7+loZlq3xsRL3Sxjmv/c9J7qnPvD26TYzQT
 qQcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Z7p/4Qz9OimnFaABUyklxjXfOzVIO8izS2zbvJA1FCc8YlOzgiLGag0jVtrikFV8KaqyaO3IKk90=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaVM33Pgc51v+NhMmVBed2HPP2umVWIHUTX/jk0qJCXI3mFBQp
 QfCKHXBY2tIiwphZPX0HqIAtZtav3Tb2FqmqvzRwlnSRYSIKbvZ8dzxBYDfLGypssSPx3+yW+Ay
 oeK+v7g==
X-Gm-Gg: Acq92OFXT0n7tBVJa15xCWYPtRKGpmZPi24I3I3FW20VRrzew8NGfWYZfVTwaF/NrAh
 hR+Zh44tuXnUASlzhLdSiK4BjOjzqu+boZSIhsIC+Z41d/0EZzQj5eoKFNgdIpf73stVrzrsHJv
 wdMJiYmlzaUs6g1Zq/YIG6yhQmXZOX6+aRd9KsQAsx055PDEA/qjdUM+GanDTxuLSWahK8wkEYc
 tRc5QiKFeGGKwQ1DSruk+BMnP8QU+PYaGUN0ECdt33atEuz68yfzh2c9P4QmmjtJX/YSomsYluk
 7n8Vx1nw9T030MqFcOFYGItymXkUP1OJMVVvnSI97VN8rhgMTo7Nt/uH+ENmIhULLeBjwTr0tj/
 H6H1TtXGzpnQ2iBq7UeQLTPRkIMAdymkaVWgESUixRFBFFnBGWtkgSbY+mvuGZTjOfCvjoXUFe+
 PTg8+v/yvZY5VgSYtAD7cgMAeU6VAJoXtO/8GNIWs28sEC5jfdd7HRzaAGAwGAQQ==
X-Received: by 2002:a17:906:5185:10b0:bab:f568:38ea with SMTP id
 a640c23a62f3a-bc84ce740c1mr511279866b.7.1778372028858; 
 Sat, 09 May 2026 17:13:48 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcac4942068sm282922566b.62.2026.05.09.17.13.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 17:13:48 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d75312379so2654626f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:13:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ81L892uLc08z2SDOe/H+t4bT2wp7I/9Hmq3v2e3PpvKW2dCMnHK8F1OFw8YPcgwGakRWJuDDx/om4=@lists.freedesktop.org
X-Received: by 2002:a05:600c:3b20:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-48e5dfcd4a9mr180784515e9.3.1778372025494; Sat, 09 May 2026
 17:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
 <20260506170607.10813-4-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260506170607.10813-4-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 9 May 2026 17:13:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4JAs6ejcSXJcQfkSKci9PHC8PQBBF5kd7wfXFXyipRQ@mail.gmail.com>
X-Gm-Features: AVHnY4J0hzjN2jVUgl4e4WddNsSsXNVuDow9LAqhpacWVNTpjIcNxQCJR5HTxaI
Message-ID: <CAD=FV=X4JAs6ejcSXJcQfkSKci9PHC8PQBBF5kd7wfXFXyipRQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/panel-edp: Add CMN N116BCN-EA1, CMN
 N140HCA-EEK, IVO M140NWFQ R5, IVO R140NWFW R0
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
> CMN N116BCN-EA1
> 00 ff ff ff ff ff ff 00 0d ae 69 11 00 00 00 00
> 0a 24 01 04 95 1a 0e 78 03 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 88 1e
> ae 00 00 90 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0d 3c 7d 07 0a 16 7d 00 00 00 00 2e
>
> CMN N140HCA-EEK
> 00 ff ff ff ff ff ff 00 0d ae c7 14 00 00 00 00
> 2f 23 01 04 a5 1f 11 78 03 28 65 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 36 36 80 a0 70 38 20 40 30 20
> a6 00 35 ad 10 00 00 1a 24 24 80 a0 70 38 20 40
> 30 20 a6 00 35 ad 10 00 00 1a 00 00 00 10 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 33 ff 0f 3c 96 0c 09 16 96 00 00 00 01 76
>
> 70 20 79 02 00 25 01 09 1c 1e 02 1c 1e 02 28 3c
> 80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 00 00
> 00 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 90
>
> IVO M140NWFQ R5
> 00 ff ff ff ff ff ff 00 26 cf d5 8c 00 00 00 00
> 00 20 01 04 a5 1f 11 78 0b 05 f0 97 57 54 8f 28
> 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9c 36 80 a0 70 38 28 40 18 30
> 5a 00 35 ae 10 00 00 19 68 24 80 a0 70 38 28 40
> 18 30 5a 00 35 ae 10 00 00 19 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 33 ff 0f 3c 96 0a 0b 1b 96 00 00 00 01 6c
>
> 70 20 79 00 00 25 00 09 ff 21 02 ff 21 02 28 3c
> 00 81 00 09 68 1a 00 00 01 01 28 3c 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 af
>
> IVO R140NWFW R0
> 00 ff ff ff ff ff ff 00 26 cf e6 8c 00 00 00 00
> 00 20 01 04 a5 1f 11 78 0b 24 10 97 59 54 8e 27
> 1e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 38 36 80 a0 70 38 20 40 18 30
> 3c 00 35 ae 10 00 00 19 22 24 80 a0 70 38 20 40
> 18 30 3c 00 35 ae 10 00 00 19 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0f 3d ff 0f 3c 7d 16 11 22 7d 00 00 00 00 24
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[3/4] drm/panel-edp: Add CMN N116BCN-EA1, CMN N140HCA-EEK, IVO
M140NWFQ R5, IVO R140NWFW R0
      commit: 0333bfa70852b153e5f59a447abdfc6352dbb11d
