Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E89C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F0610E7BD;
	Mon, 10 Aug 2026 11:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TAi5N8oQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E45110E7BD
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:26:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B184644F66
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B231F0155E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786361170;
 bh=wZoyj/bcYqq2WaFoOPNolBM0q0on9gdK76aAsSvObhU=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=TAi5N8oQgDU3uxlgGdhWfEn9nNC7rXCuv4yN2uZImZ5Qe473HPVo3p50VUpSWiPHG
 IoiTod5iPqxiSXKiITSq8Z8zTmwJc5HZ5uz7xmOpQ3Jkb0fyrve6APE8i9wcqXWbG9
 lXGMKZJiKDjBF9o//Mpr0RyCf4KxJ0hU7mN22P+i0Mg5N9bg3iRDxEVPL+nUuBavi3
 AGideJY+Jza/asFc16Mup/MjDB2acqh/PegxslqsJ6Ggp5t9N4qp8PgknMdViirGgS
 A8bpR8iBlt1Pwb4LwILd9Hw6sRCpa0GAj9fkI0FlOKyQ95A6k8YjbPxxtVg2uxyHNg
 fWwlAMzpEDWvA==
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b3119957f0so1174467e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 04:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoEEqkBJEFiH7/VZsL2bPijF3CnggDp7YIALtyHs6zEb1yEcy9qvOxihoZr/PBWCI8LR1HdF1XEmPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF6MAK/Ia8NjAS++XfgEAk9SbgTiLdKrcrRoczdLMp1ZZBPJfr
 DUw5xMpvvSwjEOarocg2hzDpCB+uRbDV0NV1/1muJtKdBNX3m0x3DWUAC4zHEOQ808oJ6+LpIdz
 nZzJ0BMZUcbwo7ADmdYXBukVcmk0RfgY5XVhC3piIGA==
X-Received: by 2002:ac2:4d18:0:b0:5b0:1b0f:7a60 with SMTP id
 2adb3069b0e04-5b2f4cc8da0mr3704106e87.32.1786361168649; Mon, 10 Aug 2026
 04:26:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 06:26:07 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 06:26:07 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
References: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 06:26:07 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeiXHL-1i31q-+wuibK5qM1=xV+4qn0z+CWFXjt3CdrCQ@mail.gmail.com>
X-Gm-Features: AUfX_myd-9E67e5jDYYEWIDd_Fhka4yTI8ar0CZ3ucq5EUGNAu2R2AhAZ0we-FI
Message-ID: <CAMRc=MeiXHL-1i31q-+wuibK5qM1=xV+4qn0z+CWFXjt3CdrCQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Correct white-space style
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Lee Jones <lee@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>, 
 YC Hung <yc.hung@mediatek.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sean Wang <sean.wang@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-arm-msm@vger.kernel.org, 
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, mfd@lists.linux.dev, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 1 Aug 2026 21:56:14 +0200, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> said:
> Correct a few white-space issues, like double space after '=' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> Patch applies on Rob's for-next branch.
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         |  8 +-
>  .../devicetree/bindings/arm/psci.yaml         | 18 ++--
>  .../bindings/arm/qcom,coresight-tnoc.yaml     |  2 +-
>  .../devicetree/bindings/ata/st,ahci.yaml      | 22 ++---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 12 +--
>  .../bindings/display/ti/ti,j721e-dss.yaml     | 96 +++++++++----------
>  .../bindings/display/ti/ti,k2g-dss.yaml       | 36 +++----
>  .../bindings/dsp/mediatek,mt8195-dsp.yaml     |  2 +-
>  .../bindings/gpio/st,nomadik-gpio.yaml        |  2 +-
>  .../devicetree/bindings/i2c/st,sti-i2c.yaml   |  2 +-
>  .../bindings/mailbox/st,sti-mailbox.yaml      |  2 +-
>  .../bindings/mfd/maxim,max77620.yaml          |  2 +-
>  .../bindings/net/wireless/qcom,ath10k.yaml    | 34 +++----
>  .../devicetree/bindings/opp/opp-v2.yaml       | 28 +++---
>  .../pinctrl/mediatek,mt7988-pinctrl.yaml      |  2 +-
>  .../devicetree/bindings/ptp/fsl,ptp.yaml      | 12 +--
>  .../devicetree/bindings/pwm/pwm-sifive.yaml   |  2 +-
>  .../bindings/usb/ti,twl4030-usb.yaml          |  2 +-
>  18 files changed, 142 insertions(+), 142 deletions(-)
>

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
