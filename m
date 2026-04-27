Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B2FFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6BA10E8B6;
	Mon, 27 Apr 2026 18:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MDqNenH6";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9D110E8B6
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:24:30 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6746d0b2b4aso13596497a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777314266; x=1777919066;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvuj3YSEPZyGvcr1TEAUS7dVv2gZaigkbV2JoEaXzA0=;
 b=MDqNenH6ckLtfsVGmtucIzv5ywtjZD9b79cTOFKmascbquZ3AMdRBHsjVR8L2ZdpjA
 jHXS9lrrat+IvfLtIvim2Kf9Abe365xrXCOyKkm4HwjHJld5tkpUAde1GkNMCXQWNitd
 g3fojQv5zNLRQ6qQfwMuj9aENrVtt+VkoYopY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314266; x=1777919066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xvuj3YSEPZyGvcr1TEAUS7dVv2gZaigkbV2JoEaXzA0=;
 b=kbKNEVWR/d0la6B5dEHGs2mUWY0gSJk8Xy+ufznNLzi+qQUhXMyzaYLfXtARY2puPr
 skz62fgbZoneXRXSGWzolpTNhK6tbpPFNqMzesJ/6KOkjE8IRppQ0EARSF2I5FASliPl
 Yf87VGMuZK2ucOgMRMyUg40yYk0deMhK7AOYnsVzKPIiCVJFD9M6uy58O+0onr1DT8mT
 /5plc4wcu6U2Jq42Ev/VNKGtO9SxlPDtZGQJmviLDwjvnyUf4zmHIuNE8Bu1u+I1YqzR
 8G5geRcaeSoqX53Gw8Eyq0pgAGlwFupY/+lXpC2oNxKYGMY4iDNKNs7S4L0N0Vyp/5N4
 PiAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/iA6sVvSDVFB9BrLIwfudKZ0+6ClggUXnyDTlkdyYWjDPUDZWC8D7uN8YwWp057UD8jZaOYjhPMc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrtOBJtKUCPTwrrX4a3xuYnzTWcU0Tq5hu2Ps/Qsg7NSXpAneJ
 zt3zyos+gxfBghAL4tQ9EAYyVsoM2nWQa46IlzX+PYhDRqIRLaC119syXVmjhBO1MU+ooXerpkx
 4m0hFlYjN
X-Gm-Gg: AeBDietWB68JWKvwOX+bOooeWWhMvacTryJTZyZtV1TnTiWOGFeZJ1uV52TljgiXe0C
 ShPyP0eRK+lJkgf1HVvmPbOKziCnbsjkk/NZtCdos2Q4h3AOrrzjfvqGhP5MiwvltMkvQoK7Ddf
 PUTqxqwe1bkvXdFcWSdt4FUkAUi4Jeo+joY9/lwXT6eK9g4RgGFj0mqofVqofimzQujOw3J9dkG
 JYvqKBQdACs2NYy5TfCnjG5JonrW29W5MUkq1T6rW2WAiwYbtEXoAJdMKsaAuLAIbTVvTz25R05
 gvYT45tnYleh43PJNWFdK/BTUoyzjIFaUvRwXVfE3mZ4B5CXM/S6Wy7+zet2PG7taQ3ktCHvdI9
 6TJ9LywCLqT0fdWFR3LIvwa4PjJH7cq/m3ALJvm74RsnFvEbMxfLAmD498X1nijjWEN5yODvdsl
 VJs5q2wYbjGLZU8HjRRflR4CzRqGeup6XRk1dnEh2oPzCPdGsw+LHTVY5JaFAGJ2IgHE6BNIuY
X-Received: by 2002:a17:907:a686:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-bb7fc8a2e8bmr821966b.43.1777314266197; 
 Mon, 27 Apr 2026 11:24:26 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com.
 [209.85.128.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba538429115sm1110796166b.15.2026.04.27.11.24.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 11:24:24 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so179535145e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/tcndH3DvxcIj4+WnZOKZIeas3zrzEH609Nq0zEPrOhq7c2W4A7qYLlhnsqvIbYPD7vQWh51WxeIw=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1e8b:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-48a76f45b2bmr6693935e9.3.1777314264104; Mon, 27 Apr 2026
 11:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 27 Apr 2026 11:24:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
X-Gm-Features: AVHnY4JXQvB4BQntOl3N3TJZoYXk7_aI9YhJcn_qUMOasoRsv3c94qqHiyJrmwQ
Message-ID: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
>
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
>
> This fixes screen unblanking (after blanking once) on
> mt8188-geralt-ciri-sku1 device.
>
> Cc: stable@vger.kernel.org # 6.11+
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate dri=
ver")

This "Fixes" looks wrong. The bug was still there even before the
driver was broken out. ...and it looks like the driver that this was
broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?

-Doug
