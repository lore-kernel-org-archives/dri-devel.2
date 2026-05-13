Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B42CD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B185F10E078;
	Wed, 13 May 2026 11:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="OEZpdfXM";
	dkim-atps=neutral
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com
 [115.124.28.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F1110E078
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778670471; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=GkarI6ZblIDma97DgwkVvqcAqBw37bL17SZaqHtfXfQ=;
 b=OEZpdfXM+0U8tBh/OXRDtHDxRWAa94Y018muePO4SU3tKbhYENgiRh+CRZYJ0/zPRAll5PEO6jw6oUUWeSdAdbfcCo9SF5WfvFXsWH3Sdn6CK+Al297l043rfiPA58gVfls3YFr8LfkClM4MyxDJ8mhbo5YrhV4lX0FOlYWdUBOEdKlhwDPDyyiL9em04oIzE8qf9cfjp1lbRiWm5KYYF3MRnXrEJ20BuYdkS8WXJGTXyfux50D1iveUM/M7JAq+Mgofk/lvlduVWTMiaPphfbxKdSqJfu2tcGf9q6sUYWxc1LGYG1ss3AJ5KP/MnKFMoxC2a0bswnJjvlyzevBd/Q==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1722893|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00473021-0.000276695-0.994993;
 FP=9172997517233803977|5|1|6|0|-1|-1|-1; HT=maildocker-contentspam033037022039;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=1; RT=1; SR=0;
 TI=SMTPD_---.hW9SB1w_1778670469; 
Received: from mail-oo1-f51.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hW9SB1w_1778670469 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 13 May 2026 19:07:50 +0800
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6949831a7bcso3392429eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:07:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Dnh9KyKyjP8jK/hCsWcbZDe1ErrUBNl7CqvQ0QZQ5O2orGEBmdBo4OTI6PufE1lOd+l/UNpl/YLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOhTRxoIh1hOapmasLcNoxfTLG1Mrrvsjsp9MLYkHk0Ee3TQES
 IAa3eP5b68lvyc7TyhpSQpBv5jOGQxW8ybqWK9KSSaQo9ujKV1sURJa8YZW83MUDbcBNcQ6RFdU
 ixZ3EbR0VdGxKMQDnVAFbkcPP8OiH+QM=
X-Received: by 2002:a05:6820:2210:b0:68c:5bdb:8c12 with SMTP id
 006d021491bc7-69b78e41c2dmr1573421eaf.45.1778670468510; Wed, 13 May 2026
 04:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
In-Reply-To: <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
From: Sunyun Yang <syyang@lontium.com>
Date: Wed, 13 May 2026 19:07:35 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
X-Gm-Features: AVHnY4Lcwpe-EsCtpzpHKhV1BURraPYP_0FYiNqHf3gHIfe2BtoSG9_tFV907DU
Message-ID: <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
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
5=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 18:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
> > <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > From: Sunyun Yang <syyang@lontium.com>
> >
> > Gentle ping.
> > Thanks.
>
> You've posted the bindings on May 8th. Please give maintainers some time
> to react. Not to mention that you posting the bindings 4 times in a row
> (once together with the driver and other 3 times separately) doesn't
> help maintainers.
>
Sorry, when I submitted the patch on May 8th, I received bounce
notifications from devicetree@vger.kernel.org and conor+dt@kernel.org,
which is why I sent the patch again.

> See https://lore.kernel.org/dri-devel/?q=3Dbindings+Lt9611c+v6
>
> >
> > > 2.34.1
> > >
>
> --
> With best wishes
> Dmitry
