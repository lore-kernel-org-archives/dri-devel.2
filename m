Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1949ECDE00B
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 02:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6500110E2DF;
	Fri, 26 Jun 2026 02:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="i/TB4qIH";
	dkim-atps=neutral
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com
 [115.124.28.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E2910E2DF
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782440119; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=Wb7F0HgHSsOQi1v3oh8YOg8rPkXbeVLfr1rGV3IZM3A=;
 b=i/TB4qIHF4OIECz6iisgouLUrrw0IUUtW4Jj1itPHSSuYgEjn6UHDnoQ6d3Yl5p0VVRAkVoMDFyC/v9qEnkb6F3RA08ePxX9snNQ9YgWo+MKIMa6hhVsYfp6ZB+cu25F2M9rPOW+K0HgDtdL1e3H6n7m42s5UHdfzv2ohUQKw6uKu88RsHEPBzQ15IUSOhbYXa/RaKcFvvhEVUoMVtZ8sWFrr9zRiuBcGx3mQr9ioUYhslPh2gMQ6Fkiyz8ngzqTRrjzX6TtTqhRn7T5EGFy/GXk1xqUyMrWH5/tFfBxWxVIMi4Bz+EqqpS2xxXs7SJ2XG302s/ufQDcJs3iFsHL8w==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07438967|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0504687-0.00160094-0.94793;
 FP=17965206477170353410|7|1|6|0|-1|-1|-1;
 HT=maildocker-contentspam033045220102; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i60vgeP_1782440115; 
Received: from mail-oi1-f177.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i60vgeP_1782440115 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 10:15:16 +0800
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-485ecc0f2dfso339364b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9v0N4M+6+MMy8MFaA0iTSddTtVxuF8FgC/RDdBe8HzHV8gHpIohG4ZfOE1Idf+ggcAdpBeCnJFYjw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx6B2xr9rDnI9un1/lolufbFtAnH3PzgvlVB8+IcN+jCRO/Wps
 Joj9QyClH/1bdIb95xYiBkz6nu2B7kcb3uSCRBDwplavbaQaJWfNLDaaDr7cwZD16l45S1ofN3f
 cBxA9V3qQWjVc/sVqoVfbtMh9E4z92BI=
X-Received: by 2002:a05:6808:e87:b0:485:41fc:71e1 with SMTP id
 5614622812f47-49217d271fcmr4756254b6e.21.1782440115200; Thu, 25 Jun 2026
 19:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
 <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
 <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
In-Reply-To: <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 10:15:03 +0800
X-Gmail-Original-Message-ID: <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
X-Gm-Features: AVVi8Cf8o4UMoK0nnWXG70UOOa3TP4xvy7_Ao2U944dWAm89fBUWaicxN-xgha8
Message-ID: <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
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
=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 25/06/2026 15:40, Sunyun Yang wrote:
> > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=88=
25=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>
> >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> >>>>>> +
> >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> >>>>>> +{
> >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >>>>>> +     msleep(20);
> >>>>>> +
> >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> >>>>>> +     msleep(20);
> >>>>>> +
> >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >>>>>
> >>>>> This is just plain wrong. Why do you assert, then de-assert and the=
n
> >>>>> finally assert AGAIN the reset leaving the device in powerdown stag=
e?
> >>>>>
> >>>> I am using software to emulate the hardware RESET button on our EVB.
> >>>> When the hardware RESET button is pressed while our chip is running,
> >>>> the signal level changes from HIGH to LOW and then back to HIGH.
> >>>>
> >>>> Of course, we can also use the following:
> >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> >>>> {
> >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> >>>>     msleep(50);
> >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> >>>>     msleep(20);
> >>>> }
> >>>
> >>> Makes no sense either and you just did not get the point and did not
> >>> answer my question. I asked WHY you leave asserted. Answer "we emulat=
e"
> >>> is just plain wrong.
> >>>
> >>> So again please answer:
> >>>
> >>> Why do you leave device with reset asserted?
> >>>
> >>
> >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;
> >>
> >> GPIO_ACTIVE_HIGH:
> >>
> >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset pin
> >> is Low level : Clear the register configuration in the chip to stop
> >> the chip from working.
> >>
> >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset pin
> >> is high level:  The chip resumes operation.
> >>
> >>
> >
> > Our purpose is: pull the level low to clear the register configuration
> > in the chip, and then pull it high to allow the MCU inside the chip to
> > re=E2=80=91initialize the registers.
>
>
> And you do completely opposite... so that confirms your code is just wron=
g.
>

The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just following the
rule of this device tree. If I modify the device tree to use
GPIO_ACTIVE_LOW,
and use the following code in my driver, then my driver would be correct.
However, would the existing kernel drivers lontium-lt9611uxc.c and
lontium-lt9611.c be affected?
static void lt9611c_reset(struct lt9611c *lt9611c)
{
    gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
    msleep(50);
    gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
    msleep(20);
}



>
> Best regards,
> Krzysztof
