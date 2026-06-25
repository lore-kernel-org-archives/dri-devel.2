Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C7CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1416310F2B7;
	Thu, 25 Jun 2026 13:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="KqqsH+Yf";
	dkim-atps=neutral
Received: from out28-111.mail.aliyun.com (out28-111.mail.aliyun.com
 [115.124.28.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3012910F2B7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782394022; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=gRSJ4CRS8OCB04rZdFrPRMpEbw/Vc3lgI3K6YTTYbew=;
 b=KqqsH+YfVBA+ArSVB4deJQn8HgQ0YWsFEWeMqjTHKSCmH3hNVtvcfR4KIUbdUDq1bGQkplPxJSRgNqco7W7iP1jUV7AJjhF/G+oJ/vYr3BJKodDvMmx+N2j57HBszXWvJhuMUPJykyMdz7Kz+e0WoP2VpJcpbLND3jpishNy5n22+Xb3sIt/RPA9h1BNMflSmy7twcboVumib1xNlRzkQVXi1b3yEtCcd+HjHx3N4rHn5CPp8kKhpnyk/pmwX5boXZpES4a3UNGkjHkhXn+Zp3t9ul8f0P+IovRzQJi2OzISEqPrQLgOrEeL8V1s6ZR0YbkddiXobgPJfeivy0zkBA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07516154|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.110469-0.00242109-0.88711;
 FP=18109304622815978754|1|1|2|0|-1|-1|-1;
 HT=maildocker-contentspam033037028158; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i5Op77I_1782394020; 
Received: from mail-oi1-f176.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i5Op77I_1782394020 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 21:27:01 +0800
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-48611ccd5aeso1486797b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:27:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/M+Yzs+K2krydZQSb3Gguzi3KrY8XZzUroJZwGZJ2MtGDdNrScluQLz3B1XS9MKoRdo0TaHE4fSYs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgqqTtQEpz5TOXBLukMrlW4gwlHwmaTf8pV9jmVe50buFC4uev
 IsQSuio09fpzzjeJ4RjhzEgif+lqjtxeOKyiF8cK6ukqxnQzMCfeyZGtvSLHxyc3TKlH5Z8Itxi
 PQV4KMSOSadVpYloL8/Q86zSN5W1ks6c=
X-Received: by 2002:a05:6808:c2b6:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4921791c07bmr2492458b6e.16.1782394019404; Thu, 25 Jun 2026
 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
In-Reply-To: <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 21:26:47 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
X-Gm-Features: AVVi8CdcsgeQPjqxnZ4gT207zSP4WZU_6qclErTnYRUAvVG4BxkgLFK7wlIGlqc
Message-ID: <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
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

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On 25/06/2026 15:14, Sunyun Yang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=882=
5=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 08/05/2026 15:40, syyang@lontium.com wrote:
> >>> +
> >>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> >>> +{
> >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >>> +     msleep(20);
> >>> +
> >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> >>> +     msleep(20);
> >>> +
> >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >>
> >> This is just plain wrong. Why do you assert, then de-assert and then
> >> finally assert AGAIN the reset leaving the device in powerdown stage?
> >>
> > I am using software to emulate the hardware RESET button on our EVB.
> > When the hardware RESET button is pressed while our chip is running,
> > the signal level changes from HIGH to LOW and then back to HIGH.
> >
> > Of course, we can also use the following:
> > static void lt9611c_reset(struct lt9611c *lt9611c)
> > {
> >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> >     msleep(50);
> >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >     msleep(20);
> > }
>
> Makes no sense either and you just did not get the point and did not
> answer my question. I asked WHY you leave asserted. Answer "we emulate"
> is just plain wrong.
>
> So again please answer:
>
> Why do you leave device with reset asserted?
>

 devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;

GPIO_ACTIVE_HIGH:

gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset pin
is Low level : Clear the register configuration in the chip to stop
the chip from working.

gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset pin
is high level:  The chip resumes operation.



> Best regards,
> Krzysztof
