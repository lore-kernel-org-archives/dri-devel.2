Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42FACDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E1110E298;
	Thu, 25 Jun 2026 13:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="uwbzrkfE";
	dkim-atps=neutral
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com
 [115.124.28.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C59810E320
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782394849; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=r6Xx0NfFQAySM0PRNTDErUFEPOAC05qJkfQxdCWSqzE=;
 b=uwbzrkfETB2mbpFq8JFkpIUiHwf3+fFIV1EnWN3NXjyLXakJcHirh+gE9Aomnn5iWT8biJ1LoeD/DhAjzez1NF34DzBPt5t++w5fJiaS2RLFOOA44HoM4yGRSAuOMi0YAAegtinIjYG8gbwYDlznpIHs20WwGEEpKASaYa5tu36jGVGQg17bzCFgXWKQcAYjJVWGV+Z/L9Cr9Eu/oWJib6zlXpF1taAq/q5ohz9IPVpjMNiHufV7CkV6YcR1lUJARG+yACgbwJ9Z0ioNNFIx2svp6bnOpVoHuRgBNjidTQsVGqedJYtbvsimFcZb8flCtPArOOLZrt2gOI3X05ApbA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0746977|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.145739-0.00323627-0.851025;
 FP=18109321665246209298|6|1|5|0|-1|-1|-1;
 HT=maildocker-contentspam033045213054; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i5OkmuU_1782394846; 
Received: from mail-ot1-f45.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i5OkmuU_1782394846 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Jun 2026 21:40:47 +0800
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7e9784666b3so1758786a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:40:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8X/3o0UxqmBe22jOZRsvXZjSDYzPlkIDAiszaYQ6CT3xeCMPPfLKYLLxBARkRYAhFrRaAHVeQbemo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxn9OigeDYhoSM5slDMjAGJLSZGBlZ8s45tBbPO+vjSqc/M7g2Y
 KumYZWQdgnE86GyQ5ubqJ9Uqt2pHOjnwfXxi3b0wIPZ/GPoQplJIFQnuWuT36Q6WqQ83+Nl0gm4
 Mwj04j90+M5NiXHshuZ6EZCloXLJN6GM=
X-Received: by 2002:a05:6808:2f10:b0:492:c931:4d66 with SMTP id
 5614622812f47-492c9316c66mr544834b6e.18.1782394845754; Thu, 25 Jun 2026
 06:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
In-Reply-To: <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 25 Jun 2026 21:40:33 +0800
X-Gmail-Original-Message-ID: <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
X-Gm-Features: AVVi8CcVIOgE8ToOf8-IAnxNW55nWpBwzycER8it0Uh4EDS4UnWSE0MAl-bvPXA
Message-ID: <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
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

Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 25/06/2026 15:14, Sunyun Yang wrote:
> > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> > >>
> > >> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > >>> +
> > >>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > >>> +{
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >>> +     msleep(20);
> > >>> +
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > >>> +     msleep(20);
> > >>> +
> > >>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >>
> > >> This is just plain wrong. Why do you assert, then de-assert and then
> > >> finally assert AGAIN the reset leaving the device in powerdown stage=
?
> > >>
> > > I am using software to emulate the hardware RESET button on our EVB.
> > > When the hardware RESET button is pressed while our chip is running,
> > > the signal level changes from HIGH to LOW and then back to HIGH.
> > >
> > > Of course, we can also use the following:
> > > static void lt9611c_reset(struct lt9611c *lt9611c)
> > > {
> > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > >     msleep(50);
> > >     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > >     msleep(20);
> > > }
> >
> > Makes no sense either and you just did not get the point and did not
> > answer my question. I asked WHY you leave asserted. Answer "we emulate"
> > is just plain wrong.
> >
> > So again please answer:
> >
> > Why do you leave device with reset asserted?
> >
>
>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;
>
> GPIO_ACTIVE_HIGH:
>
> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset pin
> is Low level : Clear the register configuration in the chip to stop
> the chip from working.
>
> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset pin
> is high level:  The chip resumes operation.
>
>

Our purpose is: pull the level low to clear the register configuration
in the chip, and then pull it high to allow the MCU inside the chip to
re=E2=80=91initialize the registers.

>
> > Best regards,
> > Krzysztof
