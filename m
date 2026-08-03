Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45656C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F87810E089;
	Mon,  3 Aug 2026 20:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dyxas8Vx";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27EF10E355
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 20:03:07 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-7473e927969so992939137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785787386; x=1786392186;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uof2fBunpwjuy+95Qrd807tlF5VuWSAH+/o2IO99jyY=;
 b=dyxas8Vxm+hs+XqxuiKtRnJWqxYfCzJPprziFrZiBA+xA/XWkQpVStTerTR5NWaOl/
 qAI4sZZdwieXh2c1WS2Pg1bQnNobg+BTC4D0ZRwi0swe6E/+dr97JgdXlfmHClX4IWrf
 1gsWpxso3i9Q9o8GIIyJgNRQVMWKhbtKOVZ0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785787386; x=1786392186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uof2fBunpwjuy+95Qrd807tlF5VuWSAH+/o2IO99jyY=;
 b=o6pPnYLDnwIhsoBQIyBcLT9BA1srcFguZGt6ZPLv73U1XhmpAXVdvqZyOXv+hYNZoB
 P1WkZnQMP5br5R9E5kmcgFaIaPg90F3KgDP48Wv+sqzW2smltxoUll0D6+D0cQvm3QIt
 zf9RHCCD0Iy0yjzaupjL07ZVFKdlo34iNpPHbuo4I2IolO/0wSNdDx4Yx4aUl5q1Eqmi
 4MA3TZptpVaUN01WSR2XQK8evDdnUKejDXsfa4FsbyNjSS39pISzDnjk0nMAHoHOPphN
 hlrZsw6EHlSzlAegHuqaiyqN5f/xM4z9suQwsclwhf/fUTQbovxTcjKwqXnRe6QpMW3L
 ySxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdfHBRIKO15gQZZABm+2U4mar7t2vPaa0vnKbgQoDNbpwyH56xfK3j/XjLHpOMxCCK/qRohz51UJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWPejw5Zf2iL/u2uaZzTDTW0vlAkvSRXYCpwMDaRms2niATXTM
 u6skTrtpYnuUZYCpkAonOiKxSX/KfmXuotLTqQ9fV5Zp3nIPSF9+xakoUzB/MOeuOW3N+Dr0shE
 y8+Q=
X-Gm-Gg: AR+sD12FSxB/7nkkFaCJbuaxor2BILkPmFSIZuIr/ApFr+TEaYgQaMxAe58b7DCLWHp
 gbuMRCyBzKTonHUBHtGkUbPcRoRywwJHGZT7i+mbt/SUoAbn57PigDax60qS4g81WXws+YFR3QZ
 vQWCMhaw6OJppOV1ns0RDyOtSwWGR760d+eFiw49xEVPNrXFEwxZzD+xKLiIWxvb5jt7DRTy0vF
 /MilooDiDFaJuTwTjwN28oD4sQgk0vpdDKasOefyv6dcDwFKXFzE6c8BwZcbfL1BRHiVKGV9uAu
 Czi/9GDx+FmWXB716E3KJn5G05Ui8luTa7QGlolue+HkDcfEqMvN1FP0xU8unQyqOBkx52xM34C
 apvgL8JsPE2srlORym9HydgAokmukIg6bI7gCO6y5fs+BNCPjORCwFYqIDKUlWLqhWsJ6+ief83
 DpGCzv4Q6kDK8jGWRCgCClkZfZFoLjVdfTCUaOyu273350A8yRW2T4OTfLNSR12gb8yxtW3bwjQ
 PV+YEFfvMdKKBsxGU3r33BkW0/ZZdA=
X-Received: by 2002:a05:6102:809c:b0:74a:992e:84f6 with SMTP id
 ada2fe7eead31-75b23b6aa90mr8440344137.10.1785787386237; 
 Mon, 03 Aug 2026 13:03:06 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com.
 [209.85.221.176]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e61a485csm6753402241.2.2026.08.03.13.03.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 13:03:05 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5c38565e774so793516e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 13:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrQGrBEnIrwPaWof/hHBuBitNwdgvs2Krzcdm5/6eb3uKIo38vkEiw7ZGS3Q+ajSMPijKwgogIsbl4=@lists.freedesktop.org
X-Received: by 2002:a05:6122:8f84:b0:5bf:b500:c4f4 with SMTP id
 71dfb90a1353d-5c38761f684mr3079807e0c.2.1785787384073; Mon, 03 Aug 2026
 13:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260731115127.15140-1-info@humanlearning.ch>
 <20260802135107.4420-1-info@humanlearning.ch>
In-Reply-To: <20260802135107.4420-1-info@humanlearning.ch>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 3 Aug 2026 13:02:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6ZOavAM_G2OX2kqpK5fweJR0e8sMXiJXXRvWpKqWAbg@mail.gmail.com>
X-Gm-Features: AUfX_mwpr-2-6nuaVJeXvtbsDEa5xqZjNtkIA7EawaPt7YsCN1ha9hX0MJBkUqk
Message-ID: <CAD=FV=X6ZOavAM_G2OX2kqpK5fweJR0e8sMXiJXXRvWpKqWAbg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add Sharp LQ120P1JX51 (Surface Pro 12in
 1st Ed.)
To: =?UTF-8?Q?Fran=C3=A7ois_Roux?= <info@humanlearning.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
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

On Sun, Aug 2, 2026 at 6:51=E2=80=AFAM Fran=C3=A7ois Roux <info@humanlearni=
ng.ch> wrote:
>
> The internal eDP panel of the Microsoft Surface Pro 12in 1st Edition
> (Snapdragon X Plus, X1P42100) is not in edp_panels[], so every boot
> produces the deliberate WARN_ON splat in panel_edp_probe() and the panel
> falls back to conservative timings:
>
>   WARNING: drivers/gpu/drm/panel/panel-edp.c:814 panel_edp_probe+0x53c/0x=
56c
>   panel-simple-dp-aux aux-aea0000.displayport-controller:
>       Unknown panel SHP 0x15a7, using conservative timings
>
> EDID, read over the panel's DP AUX DDC bus:
>
>   00 ff ff ff ff ff ff 00 4d 10 a7 15 a0 00 00 1f
>   31 22 01 04 a5 19 11 78 07 ee 91 a3 54 4c 99 26
>   0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
>   01 01 01 01 01 01 62 53 94 a0 80 b8 2e 50 18 10
>   3a 00 fe a9 00 00 00 18 13 7d 94 a0 80 b8 2e 50
>   18 10 3a 00 fe a9 00 00 00 18 00 00 00 fd 00 18
>   5a 88 88 21 01 00 00 00 00 00 00 00 00 00 00 fc
>   00 4c 51 31 32 30 50 31 4a 58 35 31 0a 20 00 69
>
>   Manufacturer: SHP
>   Model: 0x15a7
>   Made in: week 49 of 2024
>   Display Product Name: 'LQ120P1JX51'
>   DTD 1: 2196x1464 60.001799 Hz 3:2 (254 mm x 169 mm)
>   DTD 2: 2196x1464 90.002698 Hz 3:2 (254 mm x 169 mm)
>
> Timings are deliberately cautious rather than datasheet-derived. The
> conservative fallback sets unprepare=3D2000 and enable=3D200; unprepare=
=3D2000
> is a safety margin for unknown panels only and is the single occurrence
> of that value in the file -- no real panel entry uses it.
> delay_200_500_e200 keeps the same generous 200 ms enable delay while
> using the 500 ms unprepare shared by every actual panel in the table. A
> shorter enable delay may well be fine, but has not been validated here.
>
> Signed-off-by: Fran=C3=A7ois Roux <info@humanlearning.ch>
> ---
> Changes in v2:
> - Read the EDID over the panel's DP AUX DDC bus and included it in the
>   commit message, as requested. My v1 claim that the EDID was not
>   obtainable was wrong: the connector does not export it
>   (/sys/class/drm/card0-eDP-1/edid is 0 bytes) and
>   CONFIG_DRM_DP_AUX_CHARDEV no longer exists, but the AUX bus is
>   registered as an i2c adapter, so a plain DDC read works:
>       i2ctransfer -y <bus> w1@0x50 0x00 r128
>   (i2cdump in byte mode does not: it drops a header byte and yields a
>   block with a bad checksum.)
> - The EDID carries a Display Product Name, so the entry is now
>   "LQ120P1JX51" instead of "Unknown".
> - Timings unchanged (delay_200_500_e200).
> - Now sent under my real name, as you asked. v1 went out as
>   "franzelverbier"; same person, same address.
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 13ce277d7..4defef820 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2145,6 +2145,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ=
116M1JW10"),
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ=
134Z1"),
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ=
134N1"),
> +       EDP_PANEL_ENTRY('S', 'H', 'P', 0x15a7, &delay_200_500_e200, "LQ12=
0P1JX51"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add Sharp LQ120P1JX51 (Surface Pro 12in 1st Ed.)
      commit: 6ed8d820cea9cae226f500d3af86e156eede27f6
