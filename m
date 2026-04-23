Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC29FDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7158110EAF8;
	Thu, 23 Apr 2026 21:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BtCWfUKV";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6932C10EAF8
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:50:10 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso7276899a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776981007; x=1777585807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1fiSCPkq0DML3luJPuVMp7dn80QlXb/vZ8XRZ+msWc=;
 b=BtCWfUKVRx5VpeEX0nNouJpnRzZRfZElTmV6U1tYfwKebzv7Zn3VK3tCMea3snGpPM
 N52HZBmOMfc8xnHz2Is4wgUKe7L0Y15GsxWSYPKHUkhz31T2em8jNpVTWDqGe7a7zLJL
 vBH9R92ImTdFH5/g0Zozr49A+cTC2MU1uLmfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776981007; x=1777585807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G1fiSCPkq0DML3luJPuVMp7dn80QlXb/vZ8XRZ+msWc=;
 b=grbxGxKqEQ4IEJtRGRiArhqNCmh3zkCIo6ODq/xtApasI9dVKBvsEHdFSGYtERLj8z
 ZyDmHlkP6LMrlOSW/LdnlajTJyo28aqD6VAihHzTRER/MaKFcsR2MtSZFfLJEZfPBgBs
 nQsioFFplGNhFYcH0foLLECkft+yDjljHm+L5HS+fjHmsXR8xhGCI7om83TfD6MrAuF2
 P5KQzo6O/9Eg4m/CQfkOBRptQofHC51xfjihj/+UHMsGt0o7NFwI47atOPGrmotujWFi
 zJgWWrfuF2RJruBIctfb5DbMAMa0kAVOQy5KAm86QBujvnumDpbW4UDV4CRYua8bMm0f
 8iCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0NvJogwlSnHhXcgvKXVTi5e4T7VWp0mVi/yI9nwl+XybZN8zXX9puXneW7jfBotXSC1SBtmNDUJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmvO7XaXlQ3WyK3GFsRFtO057aZjg0icr7W4rreUymaBHwYzz3
 iU3bM9eZQACDzzH/+LGyBF73zC+HZePTx2PT4wwgW1BVmJ+93vRJiYhQ75AoprdYwXAXCUv8dM8
 mYjkg+Q==
X-Gm-Gg: AeBDiestaiH8qHFfNTeNIxVDaOnB0b2LRRRpRyRsg7LZBBJEPIbdytJ8XMpF31qujaJ
 Bx+n/4qiwT6uoFvcdESTvFmiqIrCBBeUjf4zgrSz+vxMuyupS4xmEvEoiZObEzl8CCVUxM+7Xsv
 5Whk+aSaDXjbhx25qxGqerURyhGien2yPnc54JmwqcsZ1+lrf76K1V+z7xpmRJ6IvYJ2xNl9Rdk
 ot5ySfp2NiKFzT5kldc44Gc852sSt9gntKK6XaS8gN5sazHv7din2XmOULI9Gz4ec7Dp7UAkOrf
 wnnkThe80MUKeqtX3p4+SA0VUg2AtsfW8Z2/tSBeu1C3btWcVoJakRml181v9Ukv4h4DdtNLp+X
 SGAJ2EJKUnTrbs2YU7bi5dd0VGwTXr8/FC/QZcLFtH4mWTZ3gJfv2XrNVXcygcUTujFSSfP5ngp
 V9U8Dpc/WyyEqB6ovxWJFaafSuOPfs9KW2qm9CfvIK0/8vVTtmaeDArbboR/fnTRAJ9hiD69bO
X-Received: by 2002:a17:907:15c5:b0:ba9:3f4a:1521 with SMTP id
 a640c23a62f3a-ba93f4a157amr519583266b.19.1776981006756; 
 Thu, 23 Apr 2026 14:50:06 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba45504441bsm697358066b.45.2026.04.23.14.50.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 14:50:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so4922465f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:50:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9JfQU7qaBYjaJrKQX3I3gKGnPvl/9SzZgvfdrF8/K+ClG25v8WvT2/NZKPf63v4eMrxANUHq0Jb5M=@lists.freedesktop.org
X-Received: by 2002:a05:6000:208a:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-43fe407383cmr43673395f8f.11.1776981004287; Thu, 23 Apr 2026
 14:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
 <20260423-manta-display-v1-2-196f80c5673a@timmermann.space>
In-Reply-To: <20260423-manta-display-v1-2-196f80c5673a@timmermann.space>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 23 Apr 2026 14:49:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNvPtG_f1W942SKJfM4ptK8Wvd-nZs4geBCG3bO_A0BA@mail.gmail.com>
X-Gm-Features: AQROBzBZ12eQ8JPtoHklunZA7baGhpheKR11CnReOtZ62TdnznxZp2PUusIRrN4
Message-ID: <CAD=FV=VNvPtG_f1W942SKJfM4ptK8Wvd-nZs4geBCG3bO_A0BA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/panel-edp: Add support for Samsung LTL101DL02-002
 panel
To: Lukas Timmermann <linux@timmermann.space>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Alexandre Marquet <tb@a-marquet.fr>
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

On Thu, Apr 23, 2026 at 2:15=E2=80=AFPM Lukas Timmermann <linux@timmermann.=
space> wrote:
>
> From: Alexandre Marquet <tb@a-marquet.fr>
>
> Add a panel entry for the Samsung LTL101DL02-002 panel, as found in
> Samsung Manta (Google Nexus 10).
>
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> Signed-off-by: Lukas Timmermann <linux@timmermann.space>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Adding new panels like this is discouraged these days. Is there a
reason you can't use the generic "edp-panel" compatible? I know that
the exynos5 driver is pretty old, but a quick glance shows that it's
based on the same analogix-dp core that "rockchip,analogix-dp" is, and
that seems to have support for aux-bus...

-Doug
