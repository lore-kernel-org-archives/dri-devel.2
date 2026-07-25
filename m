Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C626C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 02:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD5510E0A4;
	Sat, 25 Jul 2026 02:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SUSTD1X+";
	dkim-atps=neutral
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC2810E0A4
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 02:11:41 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-7475a4f8b05so573353137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784945500; x=1785550300;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ITWgm3LbruDN95S8X4TMqb36NkMYZxZKrEm7Vc1Llhw=;
 b=SUSTD1X+GI6Z1E2WUFjeDjJN5TCaJshb3d1H4t+7Id7TPP46+zWnkFFbd9QB8AMLq5
 ZVEyIQOLGk9l+0jFWGetOqzM/N5v3v9ICOumNTa2rJyf+nwfeWbyVaUHDRUWW0uH4N8w
 wFqokDnI/WqaVIK8jLwYkxyOw2GVg7d1aqHkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784945500; x=1785550300;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ITWgm3LbruDN95S8X4TMqb36NkMYZxZKrEm7Vc1Llhw=;
 b=LzR4Q7ZNS8Atfb+FeuG2+SAF9hg+cmRwGivoKPJt20T80kTkEbSRk2YvZ6fQwC8Nyk
 6Yv4qXfYGyGKd6VX64dIcD6VJQc4yvRrOnXiEaO/8XcKLPxL/CDChIZZ1cM80/4dmA+m
 AMpMTCz9Es586t8kxWN6H/+mkpNfYWiGXd/mrXDW+5aGwtiibruDPfjuXcVhNToP3jFZ
 r8aUQQkclkMC4aTzPPhHs1P+a/nwMFfvRvunbwJH1AZC4d8Y/szMGgSkldcGJd8IweEh
 yE69WbIq6GzuF5wcOFJChvt1L8w/dSKARbCcz45xBI5t81fb75Bj+fBG/P8CAaeMtJOG
 SGMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro03DvpF94UjE3M+pJY2mq2c2ocFCQCZ+Q1KqWi4wMP6EWcJyPAiiGwG/sANFWlHC7CAZJKu5WyB+E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9N1ofjXdZxlQQ5+CWEJGo7y5EbfSOcqIUSBslnVr0JLIpwJB4
 QRX5xWsoxwjFYPdm1+O5Y59QnLAbpfMNVLETYmhmkWRct1y0ULqJnTaHno0OKBP3CHsguiijYJZ
 klZI=
X-Gm-Gg: AR+sD10X19uQ6BofDnnM2r/3L71hLiC7tLxWSA883BgdI9UUMKF+Ul/sJW3J8gHjM8+
 pDH1Q1pWHq0AXolmxWIRbrAI7uydzz2yDXxBZ3hik03svo/npGRk5UKXNLVIJGdluRfYdb+L0dy
 pj4+wdHa1CVE0r0ELf2SQ7JbAqjQfX8/bc1ODSc/MYqsoA6GUQfQOPK46ZoGVWx3McuBfcTWAhM
 GljqXS/YYSn9mXZ1YL9MzU5d1mWKbc/Q2POkVeaI50VILUZmM25BEI59+DrPvX9BqhugA5OAqsG
 wDVjELgm0MQwiwtPJVRwcf1R3BEsb8gO6cIbrdqFYaIjP7oWEHyB8SAhu/8BI93jnv84tGur6nU
 kUGQ8Rtpx72iJ76Jc3IVxqQ2QEO0M55u1RDUjnaotUUtg0DXa8fpB9UeNAhEWL5RI729btPGIQ3
 ib43d5UDwhB6+gsiCdiqJ0zyty/XBZdph32LwLy1A3C6fs
X-Received: by 2002:a05:6102:4bcb:b0:650:9174:32b with SMTP id
 ada2fe7eead31-7503e2562e9mr852635137.1.1784945499608; 
 Fri, 24 Jul 2026 19:11:39 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-75036705086sm541790137.12.2026.07.24.19.11.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 19:11:38 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5c2ae02f69eso638787e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 19:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rrpl31vvz/lBKXpl/XKiJ0D92EgxxrPere6iaDz+cS2Em0Bx3o85ceIogBu3OJFp0RThxsebuvB3Zo=@lists.freedesktop.org
X-Received: by 2002:a05:6122:1d11:b0:5bf:5edc:9aa0 with SMTP id
 71dfb90a1353d-5c306c6e6a0mr461779e0c.7.1784945497117; Fri, 24 Jul 2026
 19:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-11-panchuang@vivo.com>
In-Reply-To: <20260723131649.134127-11-panchuang@vivo.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 19:11:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
X-Gm-Features: AUfX_mwYBdpfV5llTrtZnWm9mscp0kId0KzN0JiFztTWZRgnb7phFSC1CRdZtvI
Message-ID: <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
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
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Thu, Jul 23, 2026 at 6:17=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wro=
te:
>
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"=
),
> devm_request_threaded_irq() automatically logs detailed error messages on
> failure. Remove the now-redundant driver-specific dev_err_probe() call.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to apply this to drm-misc-next in ~1 week unless anything comes u=
p.

-Doug
