Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06DECC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DE110EA1C;
	Tue, 13 Oct 2026 20:34:52 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0821610EA1C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:34:46 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so553809866b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791923684; x=1792528484;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRyXOA+JX7lgigl5HRlTXnjpTB1Jlu2dYiEEb0X10kw=;
 b=b15l55Q9kMicf8AOT+LZekbIW9dTQ4UVVDdFRiYHOvovqojfI5NT26P8CBJtJmUasW
 Bb7ATkfU11214VgU4GfMBH2HnYWRE4SHIcKk2WjYWFRx6Q8sGvx3c2c2LGKrsTSdJuEa
 w8PXFokfnK/8nDJVqpl6HddoyGfCv4QwFsDhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791923684; x=1792528484;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRyXOA+JX7lgigl5HRlTXnjpTB1Jlu2dYiEEb0X10kw=;
 b=QE/9uuU5J8JMyCTr2MZixRSNpB525kYEhnZqMRe00qR/grt1vAoK0Rs0g/r3AMBfs8
 +gXPV1EHpbMC6I8hjHC4E8SUyX5KaTZ8wiFVC6+Wsr63IArDPf2FtTJQ2ez7Ogeff4Qs
 2FW5ZpcRCkPwBRMb4N+TINydomuj2cOXKHL9cWNa2cOG4EulBANf+Sik62kC1WTklQjj
 rBjVKAZJlnX0Tad304JSDchwysr0NBNH283Mme9DOdQ4R27GzLxGem6AtVHUFefhQbLO
 E6Yu9RbsUq/NaANdex0iSUco95Co1LYtZWg4mJ+mZwc7AxCbg2FdURrkX7v1FSJIuXlm
 UoDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5reGy8cAC5KpeURosVdL1qVkop3dUxuZTxE2KokRtJvbMSIgjtaRKkgXcFSozeC0Yol/EthTmpv8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJWL5EYUEgQtTIyxMQDXsALc2jZ5wQ2sJc5oAnoQE5VbixDZKX1
 wTx84JI0pTWXs6dQqwwmLBYPazLsDqWFHlxaTpQ303WPQVd3f8cIrRPrdw1Z0ymlFPpUx/IkF36
 A3X8ifw==
X-Gm-Gg: AYBFou1JwXFB0CVWeEJGCjrQJrjWW7kuvXhA4Gyy3xyqxSmlt3XMwfVm8+4493Q7E0g
 IFBwbqwqFoW2udgi2Y+tvlW8dl80ZG2pdWpKs40YzKqJhtafUURTHKHd9yHC2EzxV792RKexznc
 LJJV4o/WEGNL5lsWkq7RwQD0n8IsMs1bjQmlUcTaaUDNVhFjZ1mSSt3Td+uRZ1PEgl8II6EAgOc
 rDd4+40mgVs+u/fcBkirbtOZmg6/abrMqJjx2+WMLKzUc2WIrN6wvt25nr4LSeV6sTFMv4H9aph
 O7pL48fsHTv01L9cgiAmNxoseypsu59rf8yOJOr+gHqahBQPb1FaixnQQJ0UrVfoT6ocVl/KXgS
 yfKdj1GxargKwd9+WNAgyRsvq1nwlY7xwWQfbD7f4uBNZHm4kQmQAQjwFcBgkNTzmOTODpLFFPX
 5mTrEAY0ZHBmA+oVJtQbeqh6iGgjovAtufTOMTtT3j5liIPfEZUmxY+dFFcCF9hvcvCiQAIAIiI
 2PhqB6OcZ1YiR7B3nG41d2mVdZxJQ1Y2N2fvQ==
X-Received: by 2002:a17:907:9485:b0:c2d:f76e:f030 with SMTP id
 a640c23a62f3a-c31a9d09764mr1255434466b.13.1791923684295; 
 Tue, 13 Oct 2026 13:34:44 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac9ecfsm651458566b.74.2026.10.13.13.34.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:34:43 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2111645f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByeMQ7qzUzHWs2Cbkrd0IS/6NagMZulRHZqNmKWACa9iI1qFvJVoX5My4rytQbA8gU44sE1R8TdAXM=@lists.freedesktop.org
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-48dbaae8af0mr23584550f8f.22.1791923681866; Tue, 13 Oct 2026
 13:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-panel-edp-add-auo-v1-1-c04bfe6cd9ba@canonical.com>
In-Reply-To: <20261013-panel-edp-add-auo-v1-1-c04bfe6cd9ba@canonical.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Oct 2026 13:34:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdYtt9Mbuf6iiLAcanP03q08mp4CsYr5OjBZsVaZtQ0A@mail.gmail.com>
X-Gm-Features: AclHuK-L4h7J7FdW0srYMBeoFtuGBdzje0hch3mXxOZFm9S4lHHCQE5Jh0nhQro
Message-ID: <CAD=FV=UdYtt9Mbuf6iiLAcanP03q08mp4CsYr5OjBZsVaZtQ0A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add AUO 0x0db3 panel
To: juerg.haefliger@canonical.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 13, 2026 at 8:57=E2=80=AFAM Juerg Haefliger via B4 Relay
<devnull+juerg.haefliger.canonical.com@kernel.org> wrote:
>
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
>
> Add an entry for the AUO 0x0db3 eDP panel used in the HP EliteBook 6 G1q.
>
> The EDID does not contain a product name descriptor nor detailed timings,
> so list as "Unknown" and use the standard AUO power sequence delay which
> works fine.
>
> FWIW, this is likely a panel from the B140UAN series.
>
> Raw EDID:
>
> 00 ff ff ff ff ff ff 00 06 af b3 0d 01 01 00 00
> 1b 22 01 04 a5 1e 13 78 03 f4 75 91 56 58 93 2a
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 0e 3d 80 a4 70 b0 32 40 30 20
> 35 00 2d bc 10 00 00 18 b4 28 80 a4 70 b0 32 40
> 30 20 35 00 2d bc 10 00 00 18 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 10 3c ff 0f 3c 96 0d 0c 1e 96 00 00 20 01 e8
>
> 70 20 79 02 00 22 00 14 8b 62 02 85 7f 07 a3 00
> 2f 80 1f 00 af 04 31 00 02 00 04 00 25 01 09 8b
> 62 02 8b 62 02 28 3c 80 2b 00 0c 27 00 28 3b 00
> 00 27 00 28 3b 00 00 81 00 15 74 1a 00 00 03 01
> 28 3c 00 00 53 51 53 51 3c 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8e 90
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 2b455369ed70..6fb60b2b8894 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1958,6 +1958,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x0290, &delay_200_500_e50, "B140X=
TN07.5"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122U=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x0ba4, &delay_200_500_e50, "B140Q=
AX01.H"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x0db3, &delay_200_500_e50, "Unkno=
wn"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next.

[1/1] drm/panel-edp: Add AUO 0x0db3 panel
      commit: 34081b8bbbbfb9adbe04f764f718de04df23a84a
