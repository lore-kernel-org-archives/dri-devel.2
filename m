Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADCFCD37A7
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A80710F079;
	Thu,  7 May 2026 10:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="UXxummdl";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B6910E53E
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=ALRJ1pB6abLXPKSXPKELTZOnLk8mbd0FdETyNGeJpdY=; b=UXxummdlQHjt2QqzLWWrPKmVHg
 LHgbdg6SG9bEGj3lbjH3oD80+vlds+0sUChQ0qdWYpHsEkkNnDEvv+47MIyNN49l85hYUv51d2Kbu
 yh58oVEUS07oeJf1vzGYdmHFXC3gIwEgxn9Rv6qOjylCKLsLuKnHhkMHJ1TsG3M+5JY6LaABpup2l
 lpPHfQ70btPNF+TSjz69+w0oRTYbizHdBWPiyDtbxGAX84eIvfM56RrSY0v5j3x2fvjAzY8qMiEgh
 npcZM3CE9m5vj/S78zQNBgHgXmtY1xn3BFYAjMj+QBmFriXGfBVWRtvygYs4vyKKSiQS2acxYD3iZ
 qF1Jjp3Q==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1wKgDB-003lDx-0P
 for dri-devel@lists.freedesktop.org; Wed, 06 May 2026 17:39:05 +0000
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-130c653cce4so5081596c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:39:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+vSiSkavnV6si1XE53cbC8IVDi8D8vUjV3NYvkR4A/DMbc9UjyO+ziLqjKLYrRBA2Va5xrW7WdOTA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8Ogk4W5LX+5RYyTgfaXkfpr3M32QXVhp6OvJr1zx3Ep1Rw3I7
 okRAQbmp4VRrZEufVXY7hoPUm6C/nV9YnzXJtpa5K1XgfIZ+tmAB9Kly6BXWagHaLuKKtNy+6M6
 vejTpLEl91pgv8Rg7q3dLWrAjheoS1lM=
X-Received: by 2002:a05:7022:981:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-1319cd3eb1fmr2336725c88.32.1778089142116; Wed, 06 May 2026
 10:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042631.1916555-1-domibel@debian.org>
 <9f7eaea02c2cb52afac4f59fb78224e9acc1f160.camel@iscas.ac.cn>
 <CAAvaLCyZfdo+h+gYjEd6=kDug0A77rqH2e4U7JzpUEEGo_mvDA@mail.gmail.com>
 <de419b42100ae55bfc1d6db44cac3d763c57247b.camel@iscas.ac.cn>
In-Reply-To: <de419b42100ae55bfc1d6db44cac3d763c57247b.camel@iscas.ac.cn>
From: Dominique Belhachemi <domibel@debian.org>
Date: Wed, 6 May 2026 13:38:49 -0400
X-Gmail-Original-Message-ID: <CAAvaLCznuRK86JkQA0EaFswyagnmaOnDCCEWDoC86+_Gc0wYqQ@mail.gmail.com>
X-Gm-Features: AVHnY4JLclX532b5SQnBzx4giWWUwaOEBxhzXmUtqw12fZHoPtlAb5mIxzkJ45k
Message-ID: <CAAvaLCznuRK86JkQA0EaFswyagnmaOnDCCEWDoC86+_Gc0wYqQ@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Debian-User: domibel
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

On Wed, May 6, 2026 at 1:14=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.ac.=
cn> wrote:
>
> =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 18:25 -0400=EF=BC=8CDominique Belh=
achemi=E5=86=99=E9=81=93=EF=BC=9A
> > On Tue, May 5, 2026 at 5:03=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > =E5=9C=A8 2026-05-05=E4=BA=8C=E7=9A=84 04:26 +0000=EF=BC=8CDominique =
Belhachemi=E5=86=99=E9=81=93=EF=BC=9A
> > > > Wire up the standard non-coherent path matching the ingenic DRM
> > > > driver.
> > > >
> > > > Tested on StarFive JH7110 (VisionFive 2 v1.3B).
> > >
> > > Interesting, I am curious about other patches added to test this.
> > >
> > Hi,
> >
> > I tested this on Debian unstable with a slightly patched 7.0.3 kernel
> > [1].
> > The test branch contains your verisilicon series, Michal's JH7110
> > display series [2],
> > and a JH7110 ccache change [3], which was also required to
> > communicate
> > with the BXE-4-32 firmware [4].
>
> BTW did you run any rendering? I think the way currently powervr open
> source driver works requires "coherent memory" (although it's usually
> implemented as uncached memory).

Yes, GPU dispatches run with [4].
Compute shaders run fine, but rendering crashes after a few frames.

> >
> > This change here is only used to remove the ugly framebuffer stripes
> > on the console and in the desktop environment.
>
> But I still think it'd be better to implement proper uncached memory
> support instead of flushing caches with dirty tracking.

Maybe, this patch is just a working alternative.

Dominique

> >
> > [1] https://github.com/domibel/linux/tree/jh7110_dc8200_hdmi_v7.0.3
> > [2]
> > https://lore.kernel.org/lkml/20251108-jh7110-clean-send-v1-0-06bf43bb76=
b1@samsung.com/
> > [3]
> > https://lore.kernel.org/lkml/20260430035259.3402954-1-domibel@debian.or=
g/
> > [4]
> > https://github.com/domibel/linux/tree/powervr_on_jh7110_visionfive2_v7.=
0.3
>
> The POW_RASCALDUST thing looks quite interesting, maybe I should
> investigate it further.
>
> Thanks,
> Icenowy
> >
> > Dominique
>
>
