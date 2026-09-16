Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF1C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BEF10E79E;
	Wed, 16 Sep 2026 13:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="akBX6LHe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5BD10E79E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:14:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3845F6053A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0E1F00893
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789564442;
 bh=pihBz4gn+5eleCo7xhCNM4+VAMRmVbSp72bOE4FVM2U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=akBX6LHe38VpRRHRDqiXVGPbMIsT3Yvr6/pzNS0JkAZrMjBTpCLNe5Nzosrt8JRJw
 xL46ZYU3+BMGiAqj2fgONy8QFMuPGCs+VKLN8fzxnODpsFtdPf8st5sNvtY9tkBjGl
 txwWpE/VQA67nOUOxEbNtrZr0i6SrSbn/oLPQhzAYMJZfKoaDt4JS+69OMKHr+nbug
 ibwx+BtWbBoTcK4zu5q1of+pRz2V0ruyep29Edi2mfNc9x8kFMIZbF0OwFF58h4Ehj
 6PoCDCNtVNanRVqdT2TS+4mLUtan5L6jCaaB4+Hz3oOm+sJIcJ34PAx8j7Tu/yJnl5
 ml0caq6d/uV0A==
Received: by mail-lr2-f12.google.com with SMTP id
 38308e7fff4ca-3a2ff00b8d8so7816221fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:14:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwjX5jG03JD6Ydke5eYEkXZZRNqRRFf7cOLLd67pzZwjTBETdQpSY8Z7rOpoIHbfuYwO/c2mbNjjN4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++losDi0j/A440qO0L+vVI0h8xy2QJ7jaquyFOavcu3YJFF0d7M6
 Em4PhZchT2b967lyl4WRFxr+KSNEqP9qI8IOQbRfDR1B32vWg7uenxjwG6KBxBzaSCR7cKYYMm4
 P/PK+tlNULUjMMrOiIBnnsHopYw3IpGM=
X-Received: by 2002:a05:6512:3e07:b0:5b7:651b:1cc0 with SMTP id
 2adb3069b0e04-5b8b660c2bfmr761601e87.4.1789564441313; Wed, 16 Sep 2026
 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 15:13:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLnuNCcaY+GW5Qzv1caSZfi0CGx_3Hx33x8MVpR6iS0wtg@mail.gmail.com>
X-Gm-Features: AcwNN1Vw67ZSGXweqRIWzw8TAfqqxjv5DWNR5PtBCdGSa2CfcBJrR47asGFCEnY
Message-ID: <CAD++jLnuNCcaY+GW5Qzv1caSZfi0CGx_3Hx33x8MVpR6iS0wtg@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,
 sc8280xp-tlmm: allow gpio-line-names
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
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

On Tue, Sep 1, 2026 at 10:48=E2=80=AFAM Xilin Wu <sophon@radxa.com> wrote:

> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sophon, right I got that reference ;)

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
