Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DBCCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0728C10E2FD;
	Wed, 13 May 2026 11:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="ty5itgjz";
	dkim-atps=neutral
Received: from out28-115.mail.aliyun.com (out28-115.mail.aliyun.com
 [115.124.28.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFEA10E2FD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778672146; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=M8zeVEfjBDW34iL0F6fTCPJeNaBBq8G+h0BQnTdBWZk=;
 b=ty5itgjzYju5aITbJnPhH7f/YGmdPFH0lrLtoV37XmdIy7v14C08erHLwyxf0IRCyUt4rNhkNa2X+scDHi2KnjiW8VEG5Zp+TCs5dYw/njgUUwe4JG2gStcHHM4pO5A3+LzHvxvSPIfsSsiX6LCME30UgRVOor4wxEYMdubVDrnoePK2KZU6N7jxYO2O9h2g9ats+cKNfL41bzvS2oECK6LT9aLR03/M0FR8+MmU+isKUrPQLzBOzoXAUuxnJDV+1CZQFM33hzuSmGFNfvXRtSfT0XmMmx7jXKNETXPV950INfkpb+7gb+C0EuFFcwiB3ZU2gPAdKUm42U4BwxgzCQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08028814|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.0345328-0.00169345-0.963774;
 FP=7875452850044925897|14|1|10|0|-1|-1|-1;
 HT=maildocker-contentspam033045018182; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.hWM7KmL_1778672142; 
Received: from mail-ot1-f54.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hWM7KmL_1778672142 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 13 May 2026 19:35:43 +0800
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so7130043a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/RcDQt3YUqpsu9IkY/9fG7U7NPDvKWMRutXCB3E1jNtGnp8Jg7PFdleWX7nveW4etSJmyk7Qb+RBU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhLgiTeEh7zgG1Ho5vc94vzpvOKoTAvhKjXbVz3psRrmda89pU
 pJr1d9Doab1UpqdKNhQFH3z7YIXcuxy6Lz2BlF1NS/jz7eFEn8R5U5Odq1dh6ZRRYBc8oTdgYnZ
 QEmOOLP283yJ3nhTRwM4wLv5nb4Srw0M=
X-Received: by 2002:a05:6820:1606:b0:69b:3a3c:1e4c with SMTP id
 006d021491bc7-69b7ab67b96mr1189462eaf.50.1778672140987; Wed, 13 May 2026
 04:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
 <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
 <0636aa3c-5240-44a7-a551-4740956ba5cd@oss.qualcomm.com>
 <CAFQXuNb8w-+xEYeDSxaqK-2hxdu5ADo_Vtvy4iVBzSgNzRmSuw@mail.gmail.com>
 <b951a99a-bddf-4fe7-8ed0-4861d93aaf4e@oss.qualcomm.com>
In-Reply-To: <b951a99a-bddf-4fe7-8ed0-4861d93aaf4e@oss.qualcomm.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Wed, 13 May 2026 19:35:28 +0800
X-Gmail-Original-Message-ID: <CAFQXuNYwdbqTzEop0WtVyCEnKaOWLV72yCBHtN3H+jcXnV8U0A@mail.gmail.com>
X-Gm-Features: AVHnY4LfMuOH_31yB6a3LxhFungtv4P-uelzOpALQfnP9pmpiZSY5RfdsqScGcA
Message-ID: <CAFQXuNYwdbqTzEop0WtVyCEnKaOWLV72yCBHtN3H+jcXnV8U0A@mail.gmail.com>
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
5=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 19:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/05/2026 14:22, Sunyun Yang wrote:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B45=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 19:10=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> On 13/05/2026 14:07, Sunyun Yang wrote:
> >>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B45=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=89 18:24=E5=86=99=E9=81=93=EF=BC=
=9A
> >>>>
> >>>> On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
> >>>>> <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> From: Sunyun Yang <syyang@lontium.com>
> >>>>>
> >>>>> Gentle ping.
> >>>>> Thanks.
> >>>>
> >>>> You've posted the bindings on May 8th. Please give maintainers some =
time
> >>>> to react. Not to mention that you posting the bindings 4 times in a =
row
> >>>> (once together with the driver and other 3 times separately) doesn't
> >>>> help maintainers.
> >>>>
> >>> Sorry, when I submitted the patch on May 8th, I received bounce
> >>> notifications from devicetree@vger.kernel.org and conor+dt@kernel.org=
,
> >>> which is why I sent the patch again.
> >>
> >> And some patch trackers will now have incomplete series, others will
> >> have duplicate entries, etc.
> >>
> >> In future please use `b4 --resend` to resend the whole series at once.
> >>
> >
> > Isn't it recommended not to use 'git send-email' ?
>
> The 'b4' tool is generally recommended over raw usage of 'git
> send-email'. It saves you from some of the troubles and catches several
> typical errors.
>
thanks.

Please ignore patch v6. Due to some issues with the driver, i will
send patch v7.
(Sashiko AI:   When built into the kernel, probe executes before the
root filesystem is
mounted, which would cause this to fail with -ENOENT. Because the error
is propagated without returning -EPROBE_DEFER, the subsystem might not
retry the probe later.)

Please let the maintainers handle patch v7.

> --
> With best wishes
> Dmitry
