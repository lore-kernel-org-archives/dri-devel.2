Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D4CCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF99410E2D9;
	Fri, 26 Jun 2026 01:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="ARPU7WTH";
	dkim-atps=neutral
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBD710E2D9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 01:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782438956; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=qB8OQzAb/UAgfdSh0zhlBdG9PWiLGbf3G8yQApzy3Rs=;
 b=ARPU7WTH/FH0HqZIkQtIxe2xEBmCoLVZ5dtUxZw7uzvLc3EGzZCU1IeYu+LIvyLRb/ROLg+9bDf0G5K95TYnpZ1pM7Cz9R5azIdmLcswcYVf/x7yaM5EnGB4bBGSImZ00z3hPIoNcOuiG16lMXCae6J7tD8BGPlqA2heGdaiBMlRmJ4GLXb7sH7Unh5konYcNw2J6VBKuOVeX8DKFgRRpaADJymlLpevKrkPFPb+/qZdTR9djidLQZ+cRLFKBYg72zS4QpiRRLAAosRVFwzyGuCnjva5RKhE5o2uLQnNiHyI4CCOAs2wLsW3dpGgDngHUTetiztUuq2fDLpZFU7+yQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437244|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0543176-0.00480501-0.940877;
 FP=16812355890543396106|7|1|7|0|-1|-1|-1;
 HT=maildocker-contentspam033037071049; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i6.9NQO_1782438951; 
Received: from mail-oi1-f171.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i6.9NQO_1782438951 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 09:55:52 +0800
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-48b7df4b4ccso915265b6e.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 18:55:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+YlJPjF4DEGAWsXmyEk5NGOB2qIQUiLBFDqV1S/BifzYgddJO5ATBSZq/T3iFd0CFjrZw/e9IHfWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdRJy36IBxXsgJUcUoFKYUazeLL6cq2mDDBuHP80DDiihvUM/G
 lNWovQ48mFVt4+cwRi1nsF21Bf3URsAw/frS8sMkujizhQaJb6spO6HyuAoroQ4psys4jzn3aug
 f0aExavOKTDzFxmDfUhgBYdu70BKSsf8=
X-Received: by 2002:a05:6808:3505:b0:48a:a666:e763 with SMTP id
 5614622812f47-48ee556a028mr8634888b6e.30.1782438951020; Thu, 25 Jun 2026
 18:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
 <tpqutwzasfwhraxzymorkiot7uryef4l2n32fyo3i3fp337sak@fugghdkcqfrj>
In-Reply-To: <tpqutwzasfwhraxzymorkiot7uryef4l2n32fyo3i3fp337sak@fugghdkcqfrj>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 09:55:39 +0800
X-Gmail-Original-Message-ID: <CAFQXuNaOkDADrnUNMWt9JL0R9yAPrSUN1M08Z5CT=J3uXqwhkw@mail.gmail.com>
X-Gm-Features: AVVi8CcBMJd5tnV9CcZVmih9yHEbFd_Nru3jA9XKcANqlxTU-8aU2AoO7h8XO8A
Message-ID: <CAFQXuNaOkDADrnUNMWt9JL0R9yAPrSUN1M08Z5CT=J3uXqwhkw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
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
6=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 22:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 25, 2026 at 09:26:47PM +0800, Sunyun Yang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=882=
5=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> > > >>
> > > >> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > >>> +
> > > >>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > >>> +{
> > > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >>> +     msleep(20);
> > > >>> +
> > > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > >>> +     msleep(20);
> > > >>> +
> > > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >>
> > > >> This is just plain wrong. Why do you assert, then de-assert and th=
en
> > > >> finally assert AGAIN the reset leaving the device in powerdown sta=
ge?
> > > >>
> > > > I am using software to emulate the hardware RESET button on our EVB=
.
> > > > When the hardware RESET button is pressed while our chip is running=
,
> > > > the signal level changes from HIGH to LOW and then back to HIGH.
> > > >
> > > > Of course, we can also use the following:
> > > > static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > {
> > > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > >     msleep(50);
> > > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >     msleep(20);
> > > > }
> > >
> > > Makes no sense either and you just did not get the point and did not
> > > answer my question. I asked WHY you leave asserted. Answer "we emulat=
e"
> > > is just plain wrong.
> > >
> > > So again please answer:
> > >
> > > Why do you leave device with reset asserted?
> > >
> >
> >  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;
>
> It should be GPIO_ACTIVE_LOW, if the pin as active-low.
>

Yes, I understand that.

I used GPIO_ACTIVE_HIGH intentionally, because I did not want to
modify the existing reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>
property in the lontium-lt9611.yaml device tree file that was
submitted by others. If I used GPIO_ACTIVE_LOW, I would have to change
that line in the device tree binding, and also update the driver files
lontium-lt9611.c and lontium-lt9611uxc.c accordingly. That would add a
significant amount of extra work for me.


Moreover, in much earlier versions, I had added a separate
lontium-lt9611c.yaml file to decouple this new chip from the existing
lontium-lt9611 / lontium-lt9611uxc support. However, Dmitry Baryshkov
considered that unnecessary and asked me to merge lontium-lt9611c
together with the existing drivers. He also told me that the
differences in reset=E2=80=91pin and VDD/VCC supply did not matter.


The existing device tree and driver code already had issues, and I had
raised them with you before. At that time, you did not seem to care,
and the community reviewers insisted that I must follow your
directions. So I did exactly what you told me to do.

> >
> > GPIO_ACTIVE_HIGH:
> >
> > gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset pin
> > is Low level : Clear the register configuration in the chip to stop
> > the chip from working.
> >
> > gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset pin
> > is high level:  The chip resumes operation.
> >
> >
> >
> > > Best regards,
> > > Krzysztof
>
> --
> With best wishes
> Dmitry
