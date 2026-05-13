Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B1CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 12:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D475310EE0A;
	Wed, 13 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ky5wpLDY";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D14010EE0A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 12:10:06 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-95f2b0bd920so2804482241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778674205; cv=none;
 d=google.com; s=arc-20240605;
 b=AXN33oO3lO+EtkJC79OcxWG2i6Ps6czqau9GYth8oQd/MaTl9fQdafyf8gXOTgFPZ/
 h1VZJLRD+vYgfxMfyYvKWwtRY6c/zSE2jtq50DzxBKp7QcrDoigSxAO7GqYAzP/MpgcO
 3wdJuVLoBbRFANOYyT4DJY69W8Fqg61uWDlp+kDfTt7pDUUJsp7/gQgrtuidzIuAT2qd
 /8Tl9iXrH1CbosADW9VvLoRrezMVFL0ByS173x24+d8wB8v29olke6bWT7kzrHMHfEPt
 zHD30lnp99Oough6d9GlTS6+ehC6t0WYzBxDaNqNSRATCrPRmdTqKLLtTY5stXBea8GV
 8IaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QJuK7DvHMj1EAy7tj/RVkf9fqNfoJVTMmH7EDF5zYKY=;
 fh=XYbx9Tz48LvBh7hK7qdA4VjuEUwho0WspYiTtsZ19cg=;
 b=eH8Sg3q1JwPdytRCeKrg6msrNtijqRd6CLiR6vDQs0fDDNO/6bl01Io/mOfpLGhpIe
 V3Utp+0JtPk1Fc8sMa2spsGZZwH74LyBs/v0fJopwDDdEbJCYyQ5mukewfYItVfArt15
 5fi76dbaOVFN/4X4XyElghOpj1pyTrJFlxkDOVErRtvacW5GVmmV73jzP6oFNvikxzYg
 Qbwy+8u0oayLGz2Xf7aj9CPEX5F45r4WHRVaiY6SYSlf8pemWLcy8DbNeu6AXUHuOhRR
 6pNlg87QVXJ7+34uJwTGkjGh8CyXSj7OvWbC1DSj1mET8vhpwyhQIuFzuuSakheu/k4I
 MA7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778674205; x=1779279005; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJuK7DvHMj1EAy7tj/RVkf9fqNfoJVTMmH7EDF5zYKY=;
 b=ky5wpLDYAp+jjksuPzqN4RUWRIFlHzfnEu+cQov+2He6G9bkTcnJ++TZp+K1Zs6u1j
 H6CX9ssPJB6Qc/z0leJ4xmTExu+cxkHjrKxbgXer+6p71jhYgGP0+5QbXz5scXu/JTvr
 C6dr9cywRDrEfYE37HeOl1PO04ys5Lztb/z7NkkiE6U1gWfI4w5lXvXwdc+xPzBykZMF
 7qTUk1H2zb4dR7X9w1GgNSVbJkin/7gEmdfweogkxEoWeU7Ag/t2kHcV8jYrOEOqi3LY
 9qpH0yKAEwXO+bFrhQlbdC6tW5NBjQ5r6wltw5k9x953qkITLPJT1YQr29X60m8sR4/C
 jIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778674205; x=1779279005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJuK7DvHMj1EAy7tj/RVkf9fqNfoJVTMmH7EDF5zYKY=;
 b=Zv9sGtQgcT8hvCHR6Wyi1ypKF+Zc7knSk4OznxwJn3l0ff7YfysKWxPmVeP+v3lCdc
 Un2C6jQuxkqqBblQEjuUj3nG4rX8oMcLwkFWBVFsBElHRD9/zCo6oOBtLiQrXMWBA3L5
 mQiWwqCdKFqx0YynQrGhP5rbuBMP6SM7U6S5JYKswdlD4VO6xC4DHT6+Gdybuh0lmD/P
 fYlsGMZytBxQE+MXOEvlJDnEXuXxvtKHDbvb7PYyAS6OuS4xKuyfSXlS1lBU1MGGoDuh
 iIbYlE8+wYgAQjwOIp3/NUg9b1zszGoq9quXzuCgo3tMdFK3uVPZ7GVYhtFedE24bYjv
 uSdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lhZEaNtlEJof8It/5ouBRG/TXDxKt5QKba7WP78qm8l2E9WGrrg1RCgOdU6dJz9p03wyaA4tIUjs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVrqcnLZURcAU2YHrkDwd+D00oyD2anp3AeY3r/d4u7W5Wsurj
 NMem1M2/MbWJ7oP03o3aCZhTM+jnjMJnkw1VIIwy5wQU9FpzLT59KzsOImLZglFm70W6k+zcuoA
 E43Ppd35uhV1BiteodWl1MnDVyCha6h4=
X-Gm-Gg: Acq92OHVHBz9JPmaECPxvOl80CkFhsjblAwQ6Nw7sSNap+G0WyhsCtpR7ut4ivu89+6
 nw0WmV8o/Q/mg89KL4BhltDY8FJmVStT/32BDfM900LrR8Eaqzr5P6TWsR6cQL0FQQsYikhIpNZ
 TXAPv205Qkxk/QlnH1DUEUIu5DnaykIixBnvkytlsph2exe+3GWvLX9/iaROdu3zNKOL7lsVtRH
 nWtPXWHEUvsvTflHv2OSrSfC4xUdVcE97TUhEWx+jZOEjM0+1dJBu+RQy30ADuthx3EmpWannLA
 UY04mtGO
X-Received: by 2002:a05:6102:38c7:b0:631:d445:171f with SMTP id
 ada2fe7eead31-6376463539amr1094442137.15.1778674204715; Wed, 13 May 2026
 05:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
 <177818605997.73000.9692910497119100760.b4-ty@kernel.org>
In-Reply-To: <177818605997.73000.9692910497119100760.b4-ty@kernel.org>
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Wed, 13 May 2026 15:09:53 +0300
X-Gm-Features: AVHnY4LglPfFc_nbVIjyAIVKXzzO_CSHQSJk1Zv3noSm1yMcp9X7Hz7jaJLq39s
Message-ID: <CAHuF_Zr0Z+rP72fLts5Ar56XyY8VMROzE0wQ_S5iyO+A4YoMSw@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for the Samsung S6E8FCO DSI
 and M1906F9 display panel
To: Bjorn Andersson <andersson@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 =?UTF-8?B?S2FtaWwgR2/FgmRh?= <kamil.golda@protonmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

On Thu, 7 May 2026 at 23:35, Bjorn Andersson <andersson@kernel.org> wrote:
>
>
> On Sat, 14 Mar 2026 23:46:20 +0200, Yedaya Katsman wrote:
> > This adds a driver to support the Samsung S6E8FCO DSI controller with the
> > M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
> > generated using linux-mdss-dsi-panel-driver-generator[0].
> >
> > The mdss reset dependency makes the screen work more reliably.
> >
> > [0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> > Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel
> >
> > [...]
>
> Applied, thanks!
>
> [3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Enable MDSS and add panel
>       commit: 493cb869874cd301c370adf9a3f9577942c4f0f1

Thanks for applying, but notice that this is an old version, the last
version is v7:
https://lore.kernel.org/all/20260320-panel-patches-v7-3-3eaefc4b3878@gmail.com/
The compatible string was fixed in v5, and other patches in the series
were applied with the new version.

The difference is in the compatible, 's6e8fc0' with a zero instead of an O.

> Best regards,
> --
> Bjorn Andersson <andersson@kernel.org>
