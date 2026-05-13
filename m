Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DEBCD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF41810E0C5;
	Wed, 13 May 2026 11:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="ZdTW+gar";
	dkim-atps=neutral
Received: from out28-135.mail.aliyun.com (out28-135.mail.aliyun.com
 [115.124.28.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E4F10E2A3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778671347; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=2GEjtbOwCpnwfl5unavGXJwIGKcEY37Y89VSrNZXIGE=;
 b=ZdTW+garzMbHUxkUXis//EpxJXc4eXb0gkA4/H6HGqqGmqlquKKoVG+s5ZDn8VsSPUTvJtmnAtgxhpwL+sVWrV2qLuE8U+gGoVZIc448GiPJoE8ISltwZ+blDfrNR76aFeZmtprQzYDXRB1mFkt777kiO/psASt8chhYYYib5iPudnRhYWfTha7R59/poscZeGKMBtsoKWRXce+2yfdqO+A+0nE4bV7xsNHRm2ND/nhCHFQ2ovZ9MVfp7joYG5jtaYxSk+3CJLySUs7hLC5ojH7lCPf+diTpFWeEk0+vF2xawNyJgkcnQ+OhwWntaZJ917UGB/k1uSs30GSjNzdDzg==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1161461|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.0291599-0.00153537-0.969305;
 FP=9029467269343933129|11|1|8|0|-1|-1|-1;
 HT=maildocker-contentspam033068016216; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.hWJS.Ge_1778671344; 
Received: from mail-oo1-f47.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hWJS.Ge_1778671344 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 13 May 2026 19:22:25 +0800
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6948e6bc30cso1964190eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+SdNapD/PEb5aqpRR57VZqhCKmjHjU5ODv6zyiHdryVcjYn0FM6rDqq5aDnecgQNkvyebRXCt3tvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywLfT8SHwIKu0QMryXD55oAF9HbrqPGQ/pV4fc8LF7H+urKam3
 CfJ89Xuiv2WK+AjMZBUzUyNsirKG2f0xqeP73Jzr6c4qmZoPFymQx89x6Z+sG3NIoJrezTi0ZpQ
 0Az+5vQnRyueKa0QI1viaPfWadO8FWIw=
X-Received: by 2002:a05:6820:c85:b0:69b:5fcb:1d7f with SMTP id
 006d021491bc7-69b78d0200cmr1590836eaf.12.1778671343548; Wed, 13 May 2026
 04:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
 <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
 <0636aa3c-5240-44a7-a551-4740956ba5cd@oss.qualcomm.com>
In-Reply-To: <0636aa3c-5240-44a7-a551-4740956ba5cd@oss.qualcomm.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Wed, 13 May 2026 19:22:11 +0800
X-Gmail-Original-Message-ID: <CAFQXuNb8w-+xEYeDSxaqK-2hxdu5ADo_Vtvy4iVBzSgNzRmSuw@mail.gmail.com>
X-Gm-Features: AVHnY4KI3alC15mWANB2wEv_Zcci0uD8DwE8pUCjDOC6tt2QhYXUaTBcMAGJGWg
Message-ID: <CAFQXuNb8w-+xEYeDSxaqK-2hxdu5ADo_Vtvy4iVBzSgNzRmSuw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com
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
5=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 19:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/05/2026 14:07, Sunyun Yang wrote:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B45=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 18:24=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
> >>> <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> From: Sunyun Yang <syyang@lontium.com>
> >>>
> >>> Gentle ping.
> >>> Thanks.
> >>
> >> You've posted the bindings on May 8th. Please give maintainers some ti=
me
> >> to react. Not to mention that you posting the bindings 4 times in a ro=
w
> >> (once together with the driver and other 3 times separately) doesn't
> >> help maintainers.
> >>
> > Sorry, when I submitted the patch on May 8th, I received bounce
> > notifications from devicetree@vger.kernel.org and conor+dt@kernel.org,
> > which is why I sent the patch again.
>
> And some patch trackers will now have incomplete series, others will
> have duplicate entries, etc.
>
> In future please use `b4 --resend` to resend the whole series at once.
>

Isn't it recommended not to use 'git send-email' ?

> >
> >> See https://lore.kernel.org/dri-devel/?q=3Dbindings+Lt9611c+v6
> >>
> >>>
> >>>> 2.34.1
> >>>>
> >>
> >> --
> >> With best wishes
> >> Dmitry
>
>
> --
> With best wishes
> Dmitry
