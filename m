Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B5CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9927910ED5E;
	Thu, 11 Jun 2026 07:55:41 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5E610ED5E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:55:40 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-59bbe027424so6162251e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164539; x=1781769339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2NiokGN/wizVGUGbdWYAqnmeeSP+HB1QCep5aAksHU=;
 b=fBO1m6m59TnuMtvE7W+VVRR97Kpcu6qVqzXVzuPFxP57xB0aa1Qe9wUsyeqo7v8G1o
 pqyZu16HMnYeHYb+uhqdhuAING82NeG+d/VxYIPxI5qLgm98Jx/wnaFNdNjloElUFN24
 k3rT8/NdBRnvU+RlN9p6moYDoQrlfz7u4SW7oJgjY3LJETRatkrFK3pFiDBoruMIaQXs
 JcAsjM+/Y+kAWA+zu4q+ejj9ydHwdebOcclBv9wrzfhBT7XFdzJm1cC9CbJRcDc1fpbE
 6bCf/obJG1pIJbxVPzhd6XI1LG3dKzkjTJwzQNvsOqrz2s0Qldm7K6kXK5mZeRN5ekCE
 PJ/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OMtaAexxnyZdxJOul5m2J21a8PEk0crFpculJLNjXtj1Zf9Z9oAf9pAE2EZcEzc7XhzCdYNSqY5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9lmZamCkSdFMbtgR4nYrX94jmbAPDTfZUtEhvfVLr6SMTVAiT
 E97l+sYe1Gw5gOVc1HZwtGPNsPk13LVYGOaHas/a5J3znIHl7us8hV5041AQ5YhLzMU=
X-Gm-Gg: Acq92OEQNI2m7PRHOHpuXs9ll6ynGqUiz2SqaGm/AOOM/XO/muieC921oFRKVqjjTFQ
 WVQ5rtHi8oXhSHWrjQEvzvujpJ7aOIsxs+ejGE8H4yXN1zO31ZqiuqJ6rzyz+z0Hf3llj8NNWoF
 HGay0E9nWMsXJqTdtKkt38UA+yacwY9DsYV5isO+/AwjkgY0ysm+IQKWa7BCTBSLIJDci0glzge
 CKv35wATgMcbaHEha0cE9LcAU59sLfg6OFicgYIHysQKnN/W5S11qvivMZfl1w1Kvh3pxRo1aCR
 sGlei1RbvjNxuAELqKOMsxNzi9e0q057zdlbH/lXrEsHEf556ThUQ1/MX0YlWUO2frx+dnL/+qI
 QNXrZIG+VavHckoOeO0Do9jNkrm8IPnnEbvrjNIuiIpHPtgrX8qwtVUszdeDNOs8DeQ0FJCGPMg
 14lKXPiIY3h9aY1Fot1P9FfdFzgZu8P4NxnJq7DL1bBF0ZAwX1VyyEZ/JeE7zCI/1C7BtEcNTyQ
 FM=
X-Received: by 2002:a05:6122:6606:b0:575:2072:54d1 with SMTP id
 71dfb90a1353d-5bb004a9332mr495686e0c.8.1781164539460; 
 Thu, 11 Jun 2026 00:55:39 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb0d9b4a20sm728599e0c.13.2026.06.11.00.55.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 00:55:38 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-59d07df448bso5777257e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:55:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9lX3mvKNd344MXGWQb/CEQj/AeXaWOpg4Gnt3s7rXjSh72O7zw5zvZQZf2hkNo3cVonL3Y07w/Fhw=@lists.freedesktop.org
X-Received: by 2002:a05:6102:419e:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-71d5ca6f14emr533723137.20.1781164537632; Thu, 11 Jun 2026
 00:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
 <20260611005952.146825-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260611005952.146825-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jun 2026 09:55:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVU=msc6f3KpW1PeC1mB4dLKhAdqRaFx2i7GMRNDv+4vg@mail.gmail.com>
X-Gm-Features: AVVi8CctB5g3lahw0kyIeWwLgXx3I55B4rJDSwSay_Z70zWBy3E0yh5vjNFIWN4
Message-ID: <CAMuHMdVU=msc6f3KpW1PeC1mB4dLKhAdqRaFx2i7GMRNDv+4vg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77965-salvator-xs: Enable GPU
 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Frank Binns <frank.binns@imgtec.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>, 
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
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

On Thu, 11 Jun 2026 at 03:00, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on Salvator-X 2nd version with R-Car M3-N.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
