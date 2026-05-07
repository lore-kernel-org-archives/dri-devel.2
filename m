Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0026CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 16:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AFB10E2AC;
	Thu,  7 May 2026 16:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJsTwLMr";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D2B10E2AC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:26:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso737849f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171165; cv=none;
 d=google.com; s=arc-20240605;
 b=D1CfEZ2w4qVk/6eess+RBE8wWVbYrlt0OHui97oiizW5Cyo1adtEni+RBW0s2aF+9T
 wuz1zmo45pO4nBdGLbauJbrVxaV7wE3OeKm6DcdpEqQarr7SomNaF7aN896iV5f0zv4p
 +ilZWRLa1twjk7x1lqovGv/i7Z+zJJ8j4KjXcY2zlaBFox7Pd8l8PU8ZMYdVb4UvqdMZ
 3ExbV8jdlNzBXwjs8YssObosJ3BSf2RxBBE39PL2ppwBGaUNeuaoLLxB4IzfsXgR82ia
 ceq65oOnrcJCm42fWnRj2xza0EubTGo7XryyCfWZJmuJdbmulSMPQEoxn7E4lmSfNln9
 s+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Int/Ioom6uDImBPOoRcQOfqmGnwZxp9cr18IQ5rmQ0A=;
 fh=muRhCHkdnpW8qBw+Q8g6WjCEjyWup+VZ54dvvJuxAJY=;
 b=T8tZ44+PdC7uAP5Kh2Z3QETZCM5htSHfUO2ZRDrZM2pLO0bpNoTwUcGpYDloI7PFj+
 7Ap6Yd+4ZH7i2ksQEmSwsUTva/dZbwRa/8H1ik5j23SXpNkKU4NhMPc2iJ2IxNXd+RcZ
 VZ3NsS+5b/xHT5/Q1GzF7nd/kqf165RInkh+/U1MXLQw0hAbu7RVm6tIYV/IcKwmmgPN
 KD2EOGjh67vfKreOEwHBMF/ilTC0mI8Jr1hzjWe29zw3Qv2BpuX6CMrZRg/NjPFBJUdF
 I1LvgWXgUA5XavI3pO+OSKZ+UxlTkxjy92aQavMhX4su25o8yWWADbYXjb8jX8lW0Ter
 0XSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778171165; x=1778775965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Int/Ioom6uDImBPOoRcQOfqmGnwZxp9cr18IQ5rmQ0A=;
 b=PJsTwLMr610KJLUPctYQvSPOahNgvuyOCKBgFAMddZuX5IJebWCM2vLCwY6ieRZAXY
 L3B7LMehGI3BBFe9s9KHD4YbGbVS0nP8m9y0iFGJEe1ZoXPlZXf1onRfLAC2/Lxkd8j1
 DS02RnSNeHzURDQVHVpNNxBh//t0v8a/ZZa2/E6PvQVhrhJEtnsxFSr2c9BtO5QW5/SR
 clbI9lN/AKY/SXIkoX1xP18aUdZegSO+pId/uS4q9T1b67CUMHuxuNNHcdNtRnJS1B+K
 xmAjmaXuU9XK1S+MNChbWY5zgyquRZN/iLmwtv2n6pGqoT/h5ssXJBHkAaVxfkvDDlg4
 Fg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778171165; x=1778775965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Int/Ioom6uDImBPOoRcQOfqmGnwZxp9cr18IQ5rmQ0A=;
 b=jQoUFe7C7vCoF+rmhVNextulSOtCOtWbaZfxXssba4CTmpLknEHMNZEILYoSE1HHir
 9OmigqArGEcbGEGt/zdSiq8Z4tz3IYGM+s0vgKJS6ft0dpZm4PRsgJy9D1km8qaqFLPi
 5RJL6A+uBeNkzhvpioCOL9KNKWwjzR0zJjb1c9lXLAooWAKllUrCFL78qHyeDnw8pWPH
 ocu28h9Bc0mIGPAKKcOjZHCDLK0hKxcJLJYy1u5tm7Y0X0kydWHWxDnrh7W+Yn1AhqUU
 94T4aVbFqj2Hp3MpYefTzgLj8vmW4n6sqnuVQ1DYVtjAA0h/nAN/bN06d5g8qytnW/Jp
 BXUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zp3qQWZtXdudbYo0LtvufAMHjUYAEKuxPL/QfDwmakUH/FNLxWGXg1xmz8WSxabxH3HEEcNbDxp4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyP9FOTT3Q6eBJ+8NCxmbCau9qdy+Ii1AogjRNbK7Xq5EfozEKC
 wzbtQcax3FSYA1Rso4jLhsH2j1CKmWGuyyTiSmzGFBUHzkQiC6Bin3ZOVg2ykyripnz42bYFUX3
 8cuEQ8by4uQcmuCTFj4tAZ7ldJYNmTtc=
X-Gm-Gg: AeBDies+i99xzpjeuZdZNy2XuaaGWnh5jhQCci+FS8blx5B40GGSeEzAsBGtt9tTcFB
 HeEfRAYCa3lzC+0Kg1g460IPRIbrbWF+QiXKO5AsxwPi7jbvGSun25v7uJlv5iKTsjJrsnXym9M
 D+MitN1cEbwx5R8aXnMb0mmEJGqrPf42n9QM/p9xrdY+Jaxeey9GW2gyJlB6H0pilb3/kQyqYkb
 n2mZIU/gva+CnkC+46ARFFz5+2szyWE93MTCRXZbyIm5WRLIP7ONlKchcRVrQtPtrJFTVMJroTS
 uIjsxEl7yQNh0V1rId4xDHlfqenBeg0LYdD3uxDO9vF0f7fLNks7Dj/cLBzKm1W2myKZz6UV4zk
 iq0zx
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48e51e097fcmr139299195e9.3.1778171165189; Thu, 07 May 2026
 09:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506200826.GB1652535@killaraus.ideasonboard.com>
In-Reply-To: <20260506200826.GB1652535@killaraus.ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 May 2026 17:25:38 +0100
X-Gm-Features: AVHnY4J0DaxPufqdFXqftS14umWBtVlA89V6qUT2eHHlB5Fn79fAtb5gBsvy_HQ
Message-ID: <CA+V-a8vKuDzJ-ZCZFohDm2nTur4wvnQEQnZsZc0OUaJh=MwVSA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm: renesas: rz-du: Make DU reset control optional
 for RZ/T2H support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Laurent,

Thank you for the review.

On Wed, May 6, 2026 at 9:08=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Apr 29, 2026 at 06:00:10PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Update the DU CRTC initialisation to request the reset control using
> > devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block d=
oes
> > not expose a reset line, and treating the reset as mandatory prevents t=
he
> > driver from probing on those platforms.
>
> This assume a device tree compliant with the bindings. In case of a
> non-compliant device tree on platforms other than RZ/T2H, the driver may
> silently fail to work as it won't complain about the lack of reset. I
> think that's acceptable, as the reset should be specified in the SoC's
> .dtsi. If if was the responsibility of board DT authors I would be a bit
> more concerned.
>
I agree. Since the reset is expected to be defined in the SoC-level
.dtsi and dtbs checks do complain if it is missed.

Cheers,
Prabhakar
