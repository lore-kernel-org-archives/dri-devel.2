Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59A9CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 13:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D3910E395;
	Sun,  4 Oct 2026 13:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUDk6s5N";
	dkim-atps=neutral
Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com
 [74.125.224.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2916810E395
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 13:58:17 +0000 (UTC)
Received: by mail-yx2-f39.google.com with SMTP id
 00721157ae682-8ac8e048735so4493857b3.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 06:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791122296; cv=none;
 d=google.com; s=arc-20260327;
 b=ZsvqzY+A/d44CVD9FOMXkWL2D0VkagrbiIMFwuTUwVQx7cYMLXi+3QHKgAFsh7I+9g
 2IL2R4vS4O/PkF1l/GC6cVLjUT6UTsmnm7XEYPaytvzLbvBwONsh6g7FP74HAfGSwxIs
 qUTw7YVdeZWRm5Z5Muw+K6xCtrNFByeGzl0xSXE5l2U6cGFzh735E51LDqdvOsC/fmxt
 ZPzaxvRe36djlLFgsjMzPaIWzWwdVTXj2ceiL1+mFeYOwCWH2kg+mLTMMeiRxYsNl4Zb
 M4PqY3Y4IWFzvBGSzv9Y9ttXfNmfOfkFW/QlgObmSYV0z8uE5udnyYafjpxl4HRSg9Ji
 TOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Sc47DcnOG4SbqUBdnELdeiSnIhxnStqddXLb/q6F8OA=;
 fh=x9quA3T4QcJMZokXOOfkSBvLfI9qivFd2yYj+saLl0w=;
 b=e4aqD5JvtMWBEpLtwxAwATalc5Pu7lBgwQ5oDnh3njSp7WfjA6VvMKL8a4lWjbndbC
 rV3kxfFhTNE+kfzP0XyLD3W7bB1RkK3C9e9Ko/4TyU1y1P3A+jd79s919wJsI7lwDeej
 QeyiAM89cKfaR8knkY5aUAuJHMgkEKkL67kVpS5t3VSBogpmh/g2yZhWq4vTLhPmuvvJ
 kkJNr9IZt3nU+wt+sC7/U3qRr6jL++I1ug0Qgfg0RFbBdlbMbF4cE4dbD7mIpjjUSRt3
 dKqMW1wSQLNWV9OJ82ycybzF+fyXIhGnXD4to3s0koqAjGWB/IdQhYaYPyMLGo3SiaNh
 A95w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791122296; x=1791727096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sc47DcnOG4SbqUBdnELdeiSnIhxnStqddXLb/q6F8OA=;
 b=QUDk6s5NbwNJ6z3cVt46NVU0Lv2vwhjtOiMxW4C5ZKhQBzwi+l081Si5kcb1cd5tm+
 LZ65+e3Ey3on/XRYtNB3tiEMOgGtmMMUWEz97Sx5vEWIzalkyfTfwRxbnwhUtb0X02t+
 Bgn5Ss8XoA3xjPRmLB0FR2JG/pjKKqo6ne54tEt3h19RMknRryDvc5Q9/cuqpbYgtHv4
 lS0brZ9YW/d+IkcUViUn2ylf4AXDDHFqsdxLymnurlLWc+W2MNBOdC1iM9nOpQy3jNqK
 b156MmOaON29beDwGksJ2kkvA0o/lDy62mWI+PEbyz9cwFbBpNx7ULrYdhcDoNNQNfbD
 AoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791122296; x=1791727096;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sc47DcnOG4SbqUBdnELdeiSnIhxnStqddXLb/q6F8OA=;
 b=DyEOCpr0RHwEzHDnop+WwdKu0V+7l5lo5WENFQOyMrtg42zR+BReNHDanoP1MTpqHn
 fTdaMUBVKEYF5Jd5WyWDqRg0N9D/QWTWU4F74lGlSIKkVuWBPzp4NPpozJbsc15tiAB4
 kXd5QyuEwCboYmOs/qHK5cZzzmWlYo5AaDN7Bc9qNQJ5T/TkaIg13dp7eeJaXZqdvjqW
 XZRl5pXnB39gyabEGHqd0QuKA1+veiG/DV/e3xEF33BcExBYtY0O0vEX5b62FDLRL3CU
 QjDfRV5rqIrSmXf6KjfIKMxk+rzAtkTrsg7JPR2geDMQ+hrO8JYEkfEWBiSyiju/3gqM
 u3SQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE2VKrk8SY0P8vkFW4rAKgMkSNTDmZ1HINBRvxFD1pEgT3uIYQt91JLt89OTyt2To+mtqJEoamjcQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKCURfgxGE6lmfwcVFxK4BBq1zpjKqc6k+PfIgJPfpJOO3RCt6X
 mZsr24/nqk2aZpJvvW4R7bVnVqQDYbF2yYA7b6KFsU+wrIyWdr2F3AJHLp/XpswYDhBW9twjcq2
 pxkDUvKxs+Y4hY1pdTc1cOP5FnKA3EpuFfA7CVBSm3w==
X-Gm-Gg: AYBFou1gW+sDUP+bXip3HgpaCWj/H10rz7A+bLTOc1BU9weWwHtAMuNR6Ry36tY7dXh
 Wc18Yd3V+UgM1Yw5lD6t2HbnSe8y0V3PBHnoB3huQE3OxM/j2Pdj7U50fVcgYxoEcnnn+aAIywH
 F7fQOnijoRlc+5Y2tQqjcnTxx4KZrhVbYhpWb2oPsqWqP9vJXDG58x6pzf/jaoC2Xf2+mWXAX31
 f/JbgvEu7cDKl3PTQTk+11bhrPnXIQ30iaEXQGh9ylUpUJXo6J6m0V4T2sl+T0MfLWRHvbx3bZa
 vovxo9RjDms3jm3ZX90MipHNksG5RJbphZoXJLe0EkR0y21GyKr/22efR6a0xXTm
X-Received: by 2002:a05:690c:c3ec:b0:8ac:b167:4877 with SMTP id
 00721157ae682-8ae39bbdff2mr22844037b3.36.1791122295720; Sun, 04 Oct 2026
 06:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-3-c042266b9eeb@linaro.org>
 <gu22hz3dnttzyu2eewpalgzxtocmlbfvnpwore36ufmyr3xtag@r5bbhafsn562>
 <CABymUCNtcgbcRNXdMUjVdnH_ybOxjFB31gd6AW-0HCFDSn9w4g@mail.gmail.com>
 <kgnrsnko7u4g6bpxudfo6yqubhd5gcyrdyovjfkohlgo63yrwn@xbgp7jgv6ns3>
In-Reply-To: <kgnrsnko7u4g6bpxudfo6yqubhd5gcyrdyovjfkohlgo63yrwn@xbgp7jgv6ns3>
From: Jun Nie <jun.nie@linaro.org>
Date: Sun, 4 Oct 2026 21:58:04 +0800
X-Gm-Features: AclHuK9hzkrn0hz5wdouvmEqGC_OxpKSvbDPHUzvFuTecXtty7kAzmgPFKXJfPw
Message-ID: <CABymUCMGT32A5gE+a3u7=-3scH_Nu7Amb22-FRfWiNrcEOnAgw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/mipi-dsi: Add flag to support dual-panel
 configurations
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
10=E6=9C=881=E6=97=A5=E5=91=A8=E5=9B=9B 03:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2026 at 09:52:48PM +0800, Jun Nie wrote:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B49=E6=9C=8830=E6=97=A5=E5=91=A8=E4=B8=89 00:05=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, Jul 27, 2026 at 04:08:42PM +0800, Jun Nie wrote:
> > > > Some devices treat two independent physical DSI panels as a single
> > > > logical panel from the CRTC's perspective. However, two separate DS=
I
> > > > hosts are still required to drive the panels individually.
> > > >
> > > > Introduce a `dual_panel` flag to the `mipi_dsi_device` struct. This
> > > > allows a panel driver to inform the DSI host that it is part of a
> > > > dual-panel setup, enabling the host to coordinate both physical
> > > > displays as one.
> > > >
> > > > This change does not force individual panel driver to manage
> > > > system-level display topology if the driver does not intended to
> > > > support dual panel topology. Only the driver that set the flag to
> > > > true need to take care of panel topology.
> > > >
> > > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > > ---
> > > >  include/drm/drm_mipi_dsi.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > Do you have a single MIPI DSI device, or are there two independent MI=
PI
> > > DSI devices? In the latter case, the flag is wrongly placed.
> >
> > Yes, there are 2 mipi devices, and 2 mipi hosts. This flag is used for
> > mipi device
> > to notify host they are one of dual panels, so that horizontal
> > configuration(width)
> > in mipi host can be handled correctly. Where do you suggest to put this=
 flag?
> > Thanks!
>
> Into the msm DSI structures. We already have several Qualcomm-specific
> flags. I'm thinking from the 'generic device' point of view. The
> 'dual_panel' doesn't mean anything if the device has more than two DSI
> hosts. You need to specify which hosts are mapped to L or R channels, etc=
.

How about to add below 3 members regarding multiple physical panels in
single logic panel. We have h*v panels in a panel wall. The index start fro=
m
0 when we iterate panel from left to right of the top array of panel wall. =
In
XR case, we have num_panel_h =3D 2;  num_panel_v =3D 1; and
panel_index =3D 0 for left channel, panel_index =3D 1 for right channel. Th=
e
original framebuffer is divided into width/num_panel_h and
height/num_panel_v for each panel's DSI link.

u32 num_panel_h;
u32 num_panel_v;
u32 panel_index;

>
> --
> With best wishes
> Dmitry
