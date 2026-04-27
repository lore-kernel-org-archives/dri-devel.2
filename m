Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A11FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E758410E721;
	Mon, 27 Apr 2026 12:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3uUE9Mz";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E5D10E720
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:19:55 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso82888071cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 05:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292395; cv=none;
 d=google.com; s=arc-20240605;
 b=UIDtE1WhSuITPu/LjuV2POSK59MeIf6/WfKi5IrqSm5Ne9O/yaEXclJczX9DnRORv8
 3pQ63vctJyETOmQKvIpbcWcRxkh7aNmsTavuyVXRx179//ZFvgKiFK7qEiAdgsBfT6F3
 LlHEvyWESMq9yUfKDzekx5zakpD956sTwDEB08RnowGSGX06GZpcgkm9sMUSzhdTE434
 Z1q61zZLR3imNzJNcmlfToMZLfkmmiAIDQkpaEAmNudIB3BmjXUhB/engKpm0RZimzdI
 OUqV3/JTmoFCKLUKX+nNYp1HTDcd1J89QaHRsW3jFjTtXCC7mF+UBU+mTq4WH68ukQej
 tupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PJcxGiVkZlfjJqmXJdSpcQcuZLHP2CGOgvZ7uSde88A=;
 fh=zsxDAraH7ovCU1Ru1C+zsdcf27AcS5kGktcBCjaxgSc=;
 b=hXGP2+hE+AW4kEbsTVWbLG32pJGp4E5m4K1WvbpiMiyyDBDU++RoTIfEL+rL5gVuZI
 212liwV4uVwtLaN7qFr+fUMuzh0nHgcQ3cDLTOeE8Eht83ihx8XMPMVcHH4GH2Cr7FWm
 zc6Em1ZYOKFhRfktuTp6sQTclTZDvUpI2ISeRvH8DvpHna+61BdvneQlPFVr1b4N4HNu
 rSrpDiN3qjHYvnvjCiBY687q05WNiNIjxOpIQiG9u4mCepfUJrrHOIWSLZHw2NJpZYDZ
 sowIJR6LDgB2Fq1I+9ihXHsEYN0nMt4adZjsOZWJ/FW4TH0LTwsUgRLAPotNtTkmFyqk
 nlng==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777292395; x=1777897195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJcxGiVkZlfjJqmXJdSpcQcuZLHP2CGOgvZ7uSde88A=;
 b=V3uUE9MzI180kmHtqMeHGc12gU2t/shpORwmfEzs03fd1hG2ZlSCG2bt50+qOIKoxA
 ZOW78EbHs+c+QJxWddMWEQItSeU4h0qtxnAXjsKSzKYqYrOsEX5MkojYlQp8ZV+Veuci
 sOSFZ0Lb12mKWSSVbPXkxYVAvj/V3WzY7+LaxUbDxZGnWJHSJUDkPXfxPfaOc42mppKE
 EF7Cc/lxY1PpnZIGbHQNk+drQCC152J1JTFvopTv54NPtSnS5/BPbltYEloZX0SadVlK
 nwggDt8MJjxM0nFthxd6P4gXezuSe7Ru+odoO50dqbSa0EfAy6XyP+kJVvi8HPPRQ/lW
 VL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777292395; x=1777897195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PJcxGiVkZlfjJqmXJdSpcQcuZLHP2CGOgvZ7uSde88A=;
 b=ea1u6+xkrli7dEuhBhf46YQNgFm+z6WziCkCiHZClNFU6oHsxtBd5MMFRjAKdPpDkD
 8CBEoMHo3/gge107YvBS5lI2QrE951aVBTJYThPlHm6rnHkka1bvcT125c3woHxaM4du
 r0BUuYv7ODIwGzPQqAoZBdrDgTg7qRZ/yzkfI8IEJPiUKZl6pYCfVdhE9sCLBH5B0kw2
 511UAme1iihtcTLSHKc1N61cb6f2Q/IchfMgA+JzQptPqyG29/oOkLfG9MLGS53pBxrU
 ZUg9+V/ss5oMy7gzuJGS65igF8AZgLYCmnMfMy62KxSCi2Jar9lTJT/LtfODGbD366bK
 6Q3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CrGsAl3MMhXstpAhXnn+FbwbYCKsaF6X0t7rQ3StcggNQjyb8lKtPOuLY/3c2a6ZIka/4M6M+9F4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5BGajQidiiEzPaxDTbcKLHclNDSseWvp7PGENtulCVFk4qZiG
 eQDo0mNvnT8jsVgYNvy9Vh2xA0gjySA2ifeVZKDTU40IrtIGsMCxRBvYOb6sFfpkWXuLpk54mrf
 +SgnhF2CmE2aQ5/fkqslH45CXxuxYU+Y=
X-Gm-Gg: AeBDieuwPilmQyZStNaQg3rb2o05u3WGMZfO3GCJ33LM6EOCQSLw0R2abTr9UhRVcc5
 xvYcVZ0YmKXyJGz1UvCy3Vg9FylCX6YFHSWirOmZmwnrLBrjT9ZaE/3z9QFSCY9InuIosC6jbtZ
 eAa3CMO7w0Sr40azlaJt1oaKXUfY4c8JqbIp3TFrhV9YV48ALd1AYwb+BDYZe7tuS71aVYZMPOT
 Bw5R1lu/gG+RbKti41vFGYlogmoRz1OcHQbY0jQHPAQsb0KhS73hYJkr14dr4DtAcCwh6GlgNv5
 f4HRziYkjSiaD1s6bw==
X-Received: by 2002:ac8:7e8f:0:b0:50f:817c:5d45 with SMTP id
 d75a77b69052e-50f817c676cmr442478311cf.23.1777292391770; Mon, 27 Apr 2026
 05:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260425031011.2529364-1-dennis@ausil.us>
 <20260425031011.2529364-7-dennis@ausil.us>
In-Reply-To: <20260425031011.2529364-7-dennis@ausil.us>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 27 Apr 2026 16:19:37 +0400
X-Gm-Features: AVHnY4JMQA7P3RUKZV7Q2ZiP4ijZr_0utVOWXuWYUEbZIgaWmckkoQwwj3mXN60
Message-ID: <CABjd4Yw_bqi-Lj5MX--y34X_4GZPwa+ajwRGim7=nLGdqEOjEA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] arm64: dts: rockchip: Add Orange Pi 5 Pro board
 support
To: Dennis Gilmore <dennis@ausil.us>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Sat, Apr 25, 2026 at 7:10=E2=80=AFAM Dennis Gilmore <dennis@ausil.us> wr=
ote:
>
> Add device tree for the Xunlong Orange Pi 5 Pro (RK3588S).
>
> - eMMC module, you can optionally solder a SPI NOR in place and turn
>  off the eMMC
> - PCIe-attached NIC (pcie2x1l2)
> - PCIe NVMe slot (pcie2x1l1)
> - AP6256 WiFi (BCM43456) via SDIO with mmc-pwrseq
> - BCM4345C5 Bluetooth
> - es8388 audio
> - USB 2.0 and USB 3.0
> - Two HDMI ports, the second is connected to the SoC's DP controller
>   driven through a Lontium LT8711UXD bridge.
>
> Vendors schematics are available at:
> https://drive.google.com/file/d/1qs1DratHuh7C6J6MEtQIwUsiSrg8qgTi/view
>
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 440 ++++++++++++++++++
>  2 files changed, 441 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.d=
ts

Reviewed-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey
