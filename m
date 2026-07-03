Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EEEC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA7710F928;
	Fri,  3 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aiQRNQq5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC0010F926
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:57:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06BF7600AF
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F451F00A3E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783112246;
 bh=Y25vXV3t1GCxqlAl1osZrotdon2GGO2WDyL2Qc56+ao=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=aiQRNQq55eymVHbQFXIbokkf0/A9R+VyD0Z+MDi8MICBy9t/74ZLuWnb/dXsxG+C5
 eDUmpx5nsmQEj4OEEfHqck8a0skRlyEVrSUKFMuLngmUujWUaPl18K853LeZ0MzCxo
 0/+HPcavAynqDpu8D2TifjvhRoGGPrq6mWcO9WpOp72gTR2qQ2SmBRiSBwvsq93bGf
 g4lruNT3uSvWaJEgqd50kLkg1vPHKDUuHRiVhglt6c3icWQrD0f21rmNzlvHxC2Zei
 VayNErRxc1Mre1pbvHBRqyVjjI4hAENAbNYfLfh8XHz7G/v5O7OC/tlNWcViN7DtPQ
 /A+zIaGrhja/w==
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aeb11c7347so681199e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:57:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqddZJD0wedvjulFbuE/3yGWBxLavXEXv4BxS5cB3eabMaVVbDtyMV61seuzUPPGe8PmY7bcpvV0aI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjsS8LohkpAxqDIgxvr+ypkEy7BPBzBfbp/8ro13xg76J4Jr3M
 7tfRFajNoyYaXXl/CMBp4yMyXqIoXbEFsj7CmjEv1Rr/9IZIYLkFf3BW01PyV9aj9/CIYgQkBbO
 t+/HBxfw+XwY7xNMxItnL1Um3j07tpP8=
X-Received: by 2002:a05:6512:4041:b0:5ae:bba5:aee8 with SMTP id
 2adb3069b0e04-5aed50953famr82424e87.24.1783112245519; Fri, 03 Jul 2026
 13:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
 <20260702155113.GW2108533@google.com>
In-Reply-To: <20260702155113.GW2108533@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 22:57:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
X-Gm-Features: AVVi8CfHunFNc0klBzqgomE1zDWiF88K1FZrzxv0woj_6dulz5xhJDaFP-6xKg4
Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org
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

On Thu, Jul 2, 2026 at 5:51=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Thu, 18 Jun 2026, Linus Walleij wrote:
>
> > Remove the obsolete DB8500 PRCMU regulator drivers.
> >
> > Drop the regulator build hooks now that EPODs are power domains.
> >
> > Keep the MFD cell around because a later patch reuses it for a
> > small compatibility regulator driver.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> >  drivers/mfd/db8500-prcmu.c             | 239 +---------------
> >  drivers/regulator/Kconfig              |  12 -
> >  drivers/regulator/Makefile             |   2 -
> >  drivers/regulator/db8500-prcmu.c       | 501 -------------------------=
--------
> >  drivers/regulator/dbx500-prcmu.c       | 155 ----------
> >  drivers/regulator/dbx500-prcmu.h       |  55 ----
> >  include/linux/regulator/db8500-prcmu.h |  38 ---
> >  7 files changed, 1 insertion(+), 1001 deletions(-)
>
> Any deps?

Not really, was planning to split off the stuff that can go
directly to MFD and resend it with all the ACKs.

Yours,
Linus Walleij
