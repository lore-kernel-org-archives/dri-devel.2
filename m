Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A83ACDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE0110F502;
	Fri, 26 Jun 2026 09:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="NTR8qU/c";
	dkim-atps=neutral
Received: from out28-89.mail.aliyun.com (out28-89.mail.aliyun.com
 [115.124.28.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B20410F3F5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782464753; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=XMkWZnrnMHOAE3mkxY5ebC2iolTMQWzDtKUvohsFa8w=;
 b=NTR8qU/cIfOK50l6GTaEwstB5ka/6bn/iev8LT6FFxwTXAFX+xU5fF3SEgN2sXzfOe3NZzG7rGDDdRFyRn7zdMoRnobkXny6C27AS+gE7aXfF9ROIPyfDrlubxhovyRrszi/xIQ9cLC2y/4UmJi5hbTKNV8YWqnIEZ3ImsfDhA8xi6tvwVGd6sqVbAMYuAgT5LlneKOVmu8uGGJIESinPY4ttupOmDom1eIvCgDw1KUWpP1epSYqZiQ74kN4aRLjPjUpKdGo6LkU9YqoZwhr/9aRcozyjSc1WELt+s6izu62XImBa7nRNKOu2zxoM2+AgvtpdbeWLJnLchRjJn0w5Q==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436261|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0287501-0.000691216-0.970559;
 FP=18181436566898058530|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037028158; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i6M0baF_1782464750; 
Received: from mail-ot1-f52.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i6M0baF_1782464750 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 17:05:51 +0800
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7e936c2473dso962511a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:05:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/I1CgK7hVs1EozMOgNrp1aosTQtRrBQc0a+cKLErYlWhOJNJMFZP+UndrXqWpA1wRwQPSdmivFHGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy98dMyb0flaWTw+0OE6RcP2kQs39OIydDW2fkSRJtXKImTOw5a
 bY4H+Ak7mVH4QKh+cjsZi3CUzLfNMMgLZ37FxD+6gFBEuZs8Qf8uXrjJlwCHJwzQNvd0P1LK+SW
 aaavi/Px6KsiBG00ps9DTOPgxCyTRNiQ=
X-Received: by 2002:a05:6808:e88:b0:491:c51e:189c with SMTP id
 5614622812f47-491c51e51b0mr5127603b6e.24.1782464750060; Fri, 26 Jun 2026
 02:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
 <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
 <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
 <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
 <20260626-zippy-affable-hamster-22101d@houat>
 <CAFQXuNbN1bW3DVGUtVf7--dW_UhSk4LZdk+v14P=VSbDU4ZzsQ@mail.gmail.com>
 <20260626-flawless-axiomatic-slug-c480c9@houat>
 <CAFQXuNa330ctD3VgAVxDSzovwyy0hwVPTfm6pKzeLZDGeq=_=Q@mail.gmail.com>
In-Reply-To: <CAFQXuNa330ctD3VgAVxDSzovwyy0hwVPTfm6pKzeLZDGeq=_=Q@mail.gmail.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 17:05:38 +0800
X-Gmail-Original-Message-ID: <CAFQXuNYh95wTQex9zEUfxGBCsfK72+8eM3Mzm8pC2CFn6bJdGA@mail.gmail.com>
X-Gm-Features: AVVi8Cd2loEjLqclxX3eCQWR3hFwiUWskK08RYcxj5EouvmaDGarTUCg5EMDB2w
Message-ID: <CAFQXuNYh95wTQex9zEUfxGBCsfK72+8eM3Mzm8pC2CFn6bJdGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: Maxime Ripard <mripard@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
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

Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 16:40=E5=86=99=E9=81=93=EF=BC=9A

>
> Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=94 16:26=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Jun 26, 2026 at 04:13:18PM +0800, Sunyun Yang wrote:
> > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote:
> > > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >>
> > > > > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B4=
6=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >>>
> > > > > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >>>>>
> > > > > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > > > > >>>>>> +
> > > > > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > >>>>>> +{
> > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > >>>>>> +     msleep(20);
> > > > > > >>>>>> +
> > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > >>>>>> +     msleep(20);
> > > > > > >>>>>> +
> > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > >>>>>
> > > > > > >>>>> This is just plain wrong. Why do you assert, then de-asse=
rt and then
> > > > > > >>>>> finally assert AGAIN the reset leaving the device in powe=
rdown stage?
> > > > > > >>>>>
> > > > > > >>>> I am using software to emulate the hardware RESET button o=
n our EVB.
> > > > > > >>>> When the hardware RESET button is pressed while our chip i=
s running,
> > > > > > >>>> the signal level changes from HIGH to LOW and then back to=
 HIGH.
> > > > > > >>>>
> > > > > > >>>> Of course, we can also use the following:
> > > > > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > >>>> {
> > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > >>>>     msleep(50);
> > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > >>>>     msleep(20);
> > > > > > >>>> }
> > > > > > >>>
> > > > > > >>> Makes no sense either and you just did not get the point an=
d did not
> > > > > > >>> answer my question. I asked WHY you leave asserted. Answer =
"we emulate"
> > > > > > >>> is just plain wrong.
> > > > > > >>>
> > > > > > >>> So again please answer:
> > > > > > >>>
> > > > > > >>> Why do you leave device with reset asserted?
> > > > > > >>>
> > > > > > >>
> > > > > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;
> > > > > > >>
> > > > > > >> GPIO_ACTIVE_HIGH:
> > > > > > >>
> > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------  =
 reset pin
> > > > > > >> is Low level : Clear the register configuration in the chip =
to stop
> > > > > > >> the chip from working.
> > > > > > >>
> > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  =
reset pin
> > > > > > >> is high level:  The chip resumes operation.
> > > > > > >>
> > > > > > >>
> > > > > > >
> > > > > > > Our purpose is: pull the level low to clear the register conf=
iguration
> > > > > > > in the chip, and then pull it high to allow the MCU inside th=
e chip to
> > > > > > > re=E2=80=91initialize the registers.
> > > > > >
> > > > > >
> > > > > > And you do completely opposite... so that confirms your code is=
 just wrong.
> > > > > >
> > > > >
> > > > > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just followin=
g the
> > > > > rule of this device tree. If I modify the device tree to use
> > > > > GPIO_ACTIVE_LOW,
> > > > > and use the following code in my driver, then my driver would be =
correct.
> > > > > However, would the existing kernel drivers lontium-lt9611uxc.c an=
d
> > > > > lontium-lt9611.c be affected?
> > > >
> > > > It might, but then it's a DT problem. The GPIO API for drivers alwa=
ys
> > > > considers the logical state of a GPIO, so if you need to assert a
> > > > signal, you'll always need to set 1. That's what Krzysztof was tryi=
ng to
> > > > explain.
> > > >
> > > > The DT will provide with GPIO_ACTIVE_* how that logical state trans=
lates
> > > > to a physical GPIO state.
> > > >
> > > > If the DT says that this particular GPIO is active-high, then it me=
ans
> > > > that we need to set the GPIO to 1 to assert reset. Now of course, i=
t
> > > > might not make sense for the controller itself, but it might for th=
e
> > > > board if there's a GPIO inverter in the middle for example.
> > > >
> > > > Anyway, in the case you're raising, the issue definitely lies in th=
e DT,
> > > > and that's what would need to be fixed.
> > > >
> > > > I also wouldn't be too concerned about lontium-lt9611.yaml, it's ju=
st an
> > > > example.
> > > >
> > > > Maxime
> > >
> > > thanks Maxime, I will modify this code in the next version of the
> > > driver, and I hope you can accept these changes.
> > >
> > > Maxime:
> > > I have another question I would like to ask you
> > > regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes has
> > > opinions that differ from yours, whose advice should I follow?
> > >
> > > If I do not adopt sashiko-bot's suggestions, will my patches still be
> > > accepted into the upstream Linux kernel?
> >
> > I can't give a blanket answer. It depends on what you ignore exactly.
> >
>
> Okay, another question: sashiko-bot is an AI bot. Are its review
> comments optional, or must they be followed?
>

For example, in my driver, there is a function for upgrading the chip
firmware. During debugging or production, upgrading the chip firmware
will acquire a lock, which will block the DRM callback and affect
display. It will be fine after the upgrade is completed and some
devices are restarted. As long as there is no subsequent upgrade,
display can work normally.

From a purely software perspective, the AI bot considered this
approach unacceptable and proposed synchronizing the pre-upgrade state
to the DRM framework. From my personal perspective, I think the AI
bot's suggestion would only make my driver more complex and redundant.
Do you think I need to adopt the AI bot's suggestion?

In addition, if I follow the AI bot's suggestion, the
lontium-lt9611uxc.c and lontium-lt8713sx.c drivers that have been
merged into the upstream Linux kernel would not meet the AI bot's
requirements.

When I get a reviewer's Reviewed-by flag, can I ignore the opinion of
sashiko-bot (the AI bot)?


> > Maxime
