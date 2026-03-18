Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E4103E173
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747C710E11F;
	Wed, 18 Mar 2026 13:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WMhK8zfB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0E510E11F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:16:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BE4E4428E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B724C2BCB0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773839815;
 bh=/eWfojWtaon7N9jiPqJtkgT9zn8IHMSeq4wvtscokks=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WMhK8zfB5MerU2d4OBBUcR9fwUqfmcshq98AskOAFxDD80kRT9BTfH2PcrPUzUOSN
 d5xcgZhE7DVkpwUBzpBTt7rabX/lIumHnMT/8FNDQRg4eJx2yuGQ4zshzhyUOSWbSH
 QNjeoBqlF+2IFWj5LlacoG9ElmJ8u1jOjKA8/T04D+lSdJHMyKBQqUGvewY04NEMj5
 bqNCbuVLYWspC/flnyBqvM74xvxdvEIThEsUql5lItRJJFbgAhWAYAl6i+mLKDDaAO
 AGXPDfiwOcLl3iZJB+AsYjBDvmEVu11ybLMWML1mCQGqkd/i15wtNckZnyuuj2+ksz
 wrTXeAlS/cCSw==
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b97b333673eso481474566b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 06:16:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2hDQUuqB8H/egKRySW/L2bnMifhIt6jifWctL7eMFd42aOGlxpGD8xrgtAnKAQT/p7sBdS6D7Cy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz78S6S+9U7W2vz9Da57/lx7cLLpSAeJC3F9zW9LoU6Q7HmebZI
 e0tekOEsiO8l+OZEQRxdda2gpa/Zod38s6WvufC338e8WikLh4+ggLCQoOGE+Lbz8BMgeWJJif6
 KAv/Xj5d/bOCe+x0wpvO62cnRkh4wbTo=
X-Received: by 2002:a17:906:4fc6:b0:b97:c492:15e7 with SMTP id
 a640c23a62f3a-b97f4a61badmr248041966b.41.1773839813346; Wed, 18 Mar 2026
 06:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260314165421.1201790-1-zhengxingda@iscas.ac.cn>
 <e716ebde-a4f3-4035-bb21-3c6ab2fe06a4@suse.de>
 <8b52a9190a237a8bb94a23bf06b6a0589394f553.camel@iscas.ac.cn>
 <27689c69-dca3-4d5b-b385-b9ee2391a9d9@suse.de>
In-Reply-To: <27689c69-dca3-4d5b-b385-b9ee2391a9d9@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 18 Mar 2026 21:16:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5OKuwfFmfZS_aOzW4Hd6zfxJ2xnsCreiKK1C0BtHv4Mw@mail.gmail.com>
X-Gm-Features: AaiRm514hcJIVjyPwArCAhYDUbuxNmBWUBJSg44YMQlluU6KuMPwgtbCCcAO3aA
Message-ID: <CAAhV-H5OKuwfFmfZS_aOzW4Hd6zfxJ2xnsCreiKK1C0BtHv4Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: stop to set get_vblank_timestamp for 7A1000
 CRTC
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Sui Jingfeng <suijingfeng@loongson.cn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi, Thomas,

On Wed, Mar 18, 2026 at 3:19=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 18.03.26 um 07:16 schrieb Icenowy Zheng:
> > =E5=9C=A8 2026-03-16=E4=B8=80=E7=9A=84 08:53 +0100=EF=BC=8CThomas Zimme=
rmann=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Am 14.03.26 um 17:54 schrieb Icenowy Zheng:
> >>> As there's no known hardware capability about querying vblank on
> >>> the
> >>> 7A1000 display controller, setting get_vblank_timestamp will
> >>> mislead the
> >>> kernel about the support of DC-backed high precision vblank query.
> >>>
> >>> Drop this function pointer in the CRTC function table for 7A1000.
> >>>
> >>> This solves a kernel warning when booting Linux 7.0-rc3 on a
> >>> 3A4000+7A1000 Haier Boyue G51 laptop (with injected EDID for
> >>> replicating
> >>> the display timing set by the firmware).
> >>>
> >>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Well, is my following understand right?
> >
> > - A hardware that does not have hardware vblank timing/counting ability
> > shouldn't set .get_vblank_timestamp .
> > - A hardware that supports vblank counting but not timing should set
> > .get_vblank_timestamp to the
> > drm_crtc_vblank_helper_get_vblank_timestamp helper to allow vblank
> > timing estimate with counter.
>
> Setting drm_crtc_vblank_helper_get_vblank_timestamp() also requires to
> read out the x/y positions. See get_scanout_position. You can leave out
> get_vblank_timestamp entirely and DRM will approximate the values with
> the system timer. For reading the vblank counter, there's
> get_vblank_counter if the hardware supports it.
> >
> > (P.S. There's a DisplayCurrentLocation register that is valid for
> > 7A1000, which returns the current X and Y positions; but I wonder
> > whether this is meaningful for vblank querying.
>
> That sounds like the functionality required for get_scanout_position.
>
> > In addition, this DC looks quite similar to Verisilicon DCNano, which
> > was used by i.MX8ULP (although many functionality on the i.MX8ULP
> > manual is missing, things until cursor0 match between LS7A2000 manual
> > and i.MX8ULP manual). I wonder whether NXP people abandoned the
> > mainlining of DCNano driver because of drm/loongson?)
>
> IDK anything about that.
>
>
> > P.S.2. I saw that Sui Jingfeng's mailbox is bouncing and the driver is
> > going to be orphaned. If he wouldn't react with other ways, maybe I
> > could try to maintain this driver? I have Loongson-3A4000 + LS7A1000
> > and Loongson-3A6000 + LS7A2000 hardwares at home.
>
> Yes, the driver is now orphaned.  No one else from Loongson has shown up
> to maintain it either. If you want it, just send a patch to add you as
> maintainer with a short rational.
New maintainers are coming:
https://lore.kernel.org/lkml/20260318092349.11651-1-lvjianmin@loongson.cn/

Huacai

>
> Best regards
> Thomas
>
> >
> >>> ---
> >>>    drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
> >>> b/drivers/gpu/drm/loongson/lsdc_crtc.c
> >>> index 587fbe285e9ef..b3af8e0cdb15f 100644
> >>> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> >>> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> >>> @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
> >>> ls7a1000_crtc_funcs =3D {
> >>>     .late_register =3D lsdc_crtc_late_register,
> >>>     .enable_vblank =3D lsdc_crtc_enable_vblank,
> >>>     .disable_vblank =3D lsdc_crtc_disable_vblank,
> >>> -   .get_vblank_timestamp =3D
> >>> drm_crtc_vblank_helper_get_vblank_timestamp,
> >>>     .atomic_print_state =3D lsdc_crtc_atomic_print_state,
> >>>    };
> >>>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
