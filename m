Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C1A108B8F7
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73CE10EAD1;
	Fri, 20 Mar 2026 11:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZuFD9QwF";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EBD910EAD1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:26:50 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-94ab69af6c8so1596566241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774006009; cv=none;
 d=google.com; s=arc-20240605;
 b=Aop0YooTNF4R+2xcu9wfxwRwpsVh1y21pcTdXRomVEWNVIVTyazAh+5TURdXhT2x6C
 8N6ge4cmAgmc3YU1ogmBUDi+FdyhgXRzB0jHhcXYKz11LJXH0Js9mWdOfCv74RRBuF3c
 DrDW2mYTl+/kt2lnMxOU3D4rJRZXy9Q/BenCo4igNh0Xjzy71FI52LvAvXo6mc+ZoD/N
 vY9x0YxA7EWG8UG3c95Oam80TOthAxZqxENjDvqA3M4tO/ZoiqH8GYZ19cvwemBGOXUu
 ZcTgpcLfoX8eVwQtF4GfPwZF8U2Ou/W6jsvOd47Qw1zYumzbeH0P9jf0vty1+QoQs+Wj
 MJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V1QVEp1NAJLSNLfoGBFW6OhL3H1i4QLW676hGym3nBY=;
 fh=x6xkgAiK1LZL/p1jaZdXj7t+Lp/yhSnx5mn8KtdaMRY=;
 b=LnoW9FxDNYPLyuF7ZJGsqkAU0s5v7W7SD0fe90u9uwzAwra9hhyIwZQ480IPxbGk7D
 AyAgcN+XQ7PeXvOJJ4pZu688XmwRw2LRLih976UOdJiLVAxFD3lV1JWjgJ3xoLQg57ho
 ddyq1w+H3LZI/xUZhm/enYF88djajhEMaIME9wAWr6/4ZehXR5fD6iBny79O49a3Zi91
 ro0Wz80liSMtnrr8GHf8Zo5DfB+33JvH/oWFYXhCs21UIwHZtfepjQuWCXk0V72rOcvk
 ir6tkktgZkHKXUaEzcknkPW2pIvFDk7Hm7cLxrBAe5uesFdgOd0jO6kos/6xa+4h8c+o
 VC0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774006009; x=1774610809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1QVEp1NAJLSNLfoGBFW6OhL3H1i4QLW676hGym3nBY=;
 b=ZuFD9QwFiGpUtd/db/dU/UK0g7naNtfWlA/AZZJ0ZzZB16OHEoVOrp541RA2B8p7ZP
 YadmRoAQ644Mx58T/XxsDv5FIlv9V943f5mrnrKhbof16TUCSc223/S2FH7AjlT1F1fI
 KSjg59PcP0x/oB7qbJ6a7HcXpGnHGT8Nbwe3BOI07Ueao8uzhC3O0pGYVXOw20VEVWH4
 pp5JAbh7xdl3LcvO1rT3kY39fSCHU3t/tS0X5KYamNXfevXEAM9L028TALO6/mKwI4kO
 K+hVBFb0KjI4gMZyXt8zh0nN8KGFSz+hmKBCQEzKYirOwSw2QqJi0ynUs5/i1+PBXz4x
 /4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774006009; x=1774610809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1QVEp1NAJLSNLfoGBFW6OhL3H1i4QLW676hGym3nBY=;
 b=US5frnuqUPfRlSwl6jRzsEsfbaB9/AsZKFhuP2XfmmWGpxZjhAwPn32yizxB1r+Whc
 6A2KpQ5SKJBRUTo8cMAsrZYVPRtJ/E/CdyT87oiokaoCMTTF+a5p5cLdJ1HlLwtQp2/0
 klIOWnzZkxb6+2kEtK3ysZ6ND2jQmJRANqbbwtMZcIwjT7jMaPURasYCyuqHQk1CnxAU
 zpH8c8W95iOEUbrdDk1jvKvJkVwtnLxktB6oieJkw2MqH5bLgNbXn3FatcNq7JREvEuX
 Y/emjvYccnZMwgFe3biwE8rf01tAwGCPkJFmJRnKY2333t+k6/JPtx/UQkzRn4N904Qr
 sVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgtWx1AEzJPZcRlPgqA2tIUczzyNhoH1jKP32E7HglB2cD8WJqvz5CSyFM8hGp9xYj5TzZUaU4GXc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdarX+N+GTwAfYWasDfsYVcQYJLd3liUXYvfeppbLOFevv5SRA
 vtnazcyjUzOHUtlJcfuNsqgGCwM/B4Mz1Xl4n41TfivolzKl0tTSBkTRCDsgmYApC+7hwMp6C0Y
 iJelY2q5xDW34rojIAEjSM9QZIddgpTM=
X-Gm-Gg: ATEYQzylnNuiN6rkRrwmbkTNxAkqoINiBzaKRl7cznrg/4s5kyYhgxwPsPHa2QEBgXN
 sYD+p8bt5FMaKfomi/F4PildIa1smVf0R/FmnJG1hmjzAj0dwpQP86xQOv1Rpp3PfKJX1vFYh3Y
 RdyWDD9BuyivDBiEQmypaLqzRYajiIWNp+JsVw6Gn7jgIlneSteGK2uISDIKnKiJxEXjaX1I9Kc
 OeITwEq8DT377Y3hm0ZbhR9oFtrqmToM9BmJ+2w4xS2+vXBN/rlWUX2twtzYcrvNePXRACAXyuN
 1lyDtbMmX8hcTbJbWRo=
X-Received: by 2002:a05:6102:8017:b0:602:896a:84ba with SMTP id
 ada2fe7eead31-60295f9905emr3268532137.17.1774006009050; Fri, 20 Mar 2026
 04:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org>
 <CAH2e8h4qnF3UxWFrU59BrStWMDc-=Vz9ZNmuq8Q3smhHeUzxyw@mail.gmail.com>
 <a2xtesu626vmfetdoykojm33at44h7zxgvo6ytf2txlg6gn7ls@34jctkwswjnk>
In-Reply-To: <a2xtesu626vmfetdoykojm33at44h7zxgvo6ytf2txlg6gn7ls@34jctkwswjnk>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 19:26:22 +0800
X-Gm-Features: AaiRm51EcYplGbV3dSE_DXh3DQrzYh4J3puFHwKOmm3oxqdDTptp9H77tGPLNmE
Message-ID: <CAH2e8h4p4fyoPXTcjbhSXVgWEm54PH_=yCWiCGWOsDaMZu1bvw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Restore widebus calculation for CMDMode
 panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
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

On Fri, Mar 20, 2026 at 9:59=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Mar 12, 2026 at 01:10:07PM +0800, Pengyu Luo wrote:
> > On Thu, Mar 12, 2026 at 6:31=E2=80=AFAM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > Commit ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when
> > > programming dsi registers") makes a false and ungrounded statement th=
at
> > > "Since CMD mode does not use this, we can remove !(msm_host->mode_fla=
gs
> > > & MIPI_DSI_MODE_VIDEO) safely." which isn't the case at all.
> > > dsi_timing_setup() affects both command mode and video mode panels, a=
nd
> > > by no longer having any path that sets bits_per_pclk =3D 48 (contrary=
 to
> > > the updated code-comment) all DSI DSC panels on SM8350 and above (i.e=
.
> > > with widebus support) regress thanks to this patch.
> > >
> > > The entire reason that video mode was originally omitted from this co=
de
> > > path is because it was never tested before; any change that enables
> > > widebus for video mode panels should not regress the command mode pat=
h.
> > >
> > > Thus add back the path allows 6 bytes or 48 bits to be sent per pclk
> > > on command mode DSI panels with widebus, restoring the panel on devic=
es
> > > like the Sony Xperia 1 III and upwards.
> > >
> > > Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when prog=
ramming dsi registers")
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> >
> > Apologies, I messed up, I had sent the same fixes days ago.
> > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-2-mitltlatl=
tl@gmail.com/
> >
> > > In addition I can't say I understand the original commit message
> > > at all; it mentions a BPC=3D10 mode however the highest format that
> > > mipi_dsi_pixel_format_to_bpp supports is RGB888 thus it won't
> > > ever return anything above 24, which is the original amount the
> > > non-command-mode path defaulted to (regardless of widebus)...  Was th=
at
> > > patch doing anything for video mode at all?
> > >
> >
> > RGB888 is the dst bpc, which is tied to qcom,mdss-dsi-bpp in the downst=
ream.
> >
> > Actually, we should use src bpc here, another fixe
> > https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlatl=
tl@gmail.com/
>
> I'm really torn between your two patchsets here.
>
> Marijn, Pengyu, what are your testing platforms and are you testing
> video or command mode panels?
>

SM8750, I am testing on a native 10-bit video mode panel.

My thoughts are we should restore 6 for the cmd panel, and we should
fix video mode too.
As I mentioned, I overlooked something, I thought the cmd panel didn't
use the value, which
made the value for the cmd panel wrong. So we can restore it for the
cmd panel (though I can't say why 6).

Best wishes,
Pengyu
