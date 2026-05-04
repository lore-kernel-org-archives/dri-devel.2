Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C15CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 22:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5BA10E11F;
	Mon,  4 May 2026 22:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TwEsB1i4";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD9F10E11F
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 22:45:00 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-67bce1840f1so4656570a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777934695; x=1778539495;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCtqeJ6w5ygfROMjoa3DM/xPDegbtqzB5MET+XvOzy4=;
 b=TwEsB1i4v+GkmtDDbe9BFE/iUYofVePwSnX3hqaaCCALo1fXjpjCRMwaUMBb5jYPd4
 CMzKfxh2cjkZTURdT191FmlbzPSehQu7FpzcRxVqALuaeHWxh65qc0N61nwjBuZO7gpg
 lhL91TEfbaA1fVUC7P37QcmUc0EnrbLNOZHqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777934695; x=1778539495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCtqeJ6w5ygfROMjoa3DM/xPDegbtqzB5MET+XvOzy4=;
 b=l7CWmC8w0RRW4yy7YjqvZVpJoScfe0i2SARc10t6OSeVGVAxYzFvyqFhfy/aghJftz
 PkSU3WzLNKAP/jgwIGNxJ3rOYgGoUodt5rbzqJ7UGAyrJwU168eByNcQsDsiucmxUQUt
 iMHK/AC/PgudQDUnG5P2PhYYIbLv/sagw7kTNgL9+0lJjQpOYJ3bAPrvyVCXYc1ZHv2/
 PL6FNuJOPEmFtyIc00jXv3nRQjVc1P3hQ+imtTYffvXqBKWdhQ/sk+LDWmPi6a89AciJ
 lRq6JIDolcOxizkuTqvbfKn8dI+qB9XtBJTr92zhc2BFlSybcCPlE2lX4XWOZbqAMmuf
 64Wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9V7KO4ZbpPCFbz0GilAI3HZw8JlH5JLz15oxNZdETQCeIvkJw/gbpNz1lAN+INVCMjibCdNmM1TFU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDFBBYfTu+S1O3C13dc0xIVQY8lMEx+o/WMIedG+e3oY95kv5m
 SGl5VSNheO6zNskj74gLaREZ9Z6ex71e9exqJq4BTmNGFKeMMiq443DDnOV7YKXkWXXkDRI4M3R
 7B4ZwqQ==
X-Gm-Gg: AeBDieskQojqA0ZdvugzUSoQ67EyggH/eCdshoLDoI9xboJYxoHfMdB/1y6yn3IQJ6g
 /ZpFMsM+8PIDvAT+9rnPc06rUTIDhy2lTYfTZtnOKhnrsog38I50XkgmVg6/8A6MUsfZBgtwRgp
 hlxdv+2CEiXMJrN9tGJFxFxiSx97k7S5tZCLt8SoYDTd7tKIjOLR4GArspip4+2NcXr6wrPsuU/
 v9sAd0AXLer6BqyLC7OzBBZ+vmILmNhjRSglFETOa1EPPkU1cRy9c3pn9sGhoCQRvM62c867Gaa
 YFs0GWhcI8Rpyi1V9H2GfLZmB9kCiXKeQyYpY4FTKLCb+vr6eBZFS4wfMgJmuk9BwxVr4j7nfH6
 /geRoXPK+nv+0Zsq5bJF9Pt3V/w7X6WxlAJKpnJulBAWqvsLNg4N4uElmXgEXSGj0JjVJZWKJ2/
 IRLwGNC3yPxGpOtQEkNMEBgCp8miogxW4N4NzYITEDC+RJ3jQmn/53rXxlyXDiAgPWHsxX+NXI
X-Received: by 2002:a05:6402:2742:b0:670:3b53:9bc with SMTP id
 4fb4d7f45d1cf-67cca82f2camr275766a12.4.1777934695079; 
 Mon, 04 May 2026 15:44:55 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com.
 [209.85.128.52]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67cd731367dsm40907a12.24.2026.05.04.15.44.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 15:44:54 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so3346545e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ834Bbah4X331LM1T5b/vPmo1QSUVOngEHBPnxmBpRc18mft8QG6H5HwCq0mEsra9xuJ2YgygnzV64=@lists.freedesktop.org
X-Received: by 2002:a05:600c:a401:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48d18ceab19mr6062235e9.27.1777934692325; Mon, 04 May 2026
 15:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260503091708.1079962-1-zhengxingda@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 May 2026 15:44:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WP=VTg-AV6nmyA55+Vtr380Et=B-tPvz3GUso6cGVF1Q@mail.gmail.com>
X-Gm-Features: AVHnY4Jg0cHGDRcJW7kbYyloRz7Kb98N0jv6U-blFJnZEpx4hOJ1n6_1CgkshL8
Message-ID: <CAD=FV=WP=VTg-AV6nmyA55+Vtr380Et=B-tPvz3GUso6cGVF1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after
 sending disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jitao Shi <jitao.shi@mediatek.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Sun, May 3, 2026 at 2:17=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac.=
cn> wrote:
>
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
>
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
>
> This fixes error messages shown in kernel log when unblanking on
> mt8183-kukui-kodama-sku32 device.
>
> Cc: stable@vger.kernel.org
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi v=
ideo mode panel")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
