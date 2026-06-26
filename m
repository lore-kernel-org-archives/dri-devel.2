Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE97CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C65E510E337;
	Fri, 26 Jun 2026 10:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="FDDLJO1G";
	dkim-atps=neutral
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com
 [115.124.28.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CF710E337
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782468514; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=VZGeb3GZ31mNdxvxOX7X62UaE8AM0c27Ouv1C4wppo8=;
 b=FDDLJO1GQ/5rL71QuoR6N/SiQhteZ8eF7jmvYOCpE/Z6HkYKcq6H3PYqlUifxhT+oBAKPtk8TwmJkH4k2cccSPfof77OBiq0qRl56Qk+XXnqpHu1JL4Jv1Unrm4iCAJwJyS3YBnCT2s2iCxxFMCu8ExrjptuXNuylp1o+9jh/0M2lUoDaT/hSdavmbesQqJqlSKLAGkH5X5hxzM3lMgH4wVuzXpBeHkBPTQwr7reQeMkk21vJy0IGYTSS3nr7ldIxM5wFz81FzY+YZ8OJ7X+4+wOP+1NpUoWpe9wIgIWdjRdztGLB1Imd1z/945kZpBnnzPvyc+6nVbcijp0kroFiA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0506618-0.00407068-0.945268;
 FP=18253458976429696266|3|1|2|0|-1|-1|-1;
 HT=maildocker-contentspam033068005250; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i6MHhM1_1782468511; 
Received: from mail-ot1-f48.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i6MHhM1_1782468511 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 18:08:32 +0800
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7e6da33a561so503269a34.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 03:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8/tfXeqJOEIon7yS0pDcvDtY5m+RdqaDc3u17fkF3Wyc8EvKyyCPqH5HWHdGyxeC6eugUCrQfi5HA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLVKTNKcmI/Ddg3WnvmcbuIZIzPNYnctqD+gqWlh5hByZ7+emF
 8x4H07OB8JZb9IZiqV9WAHANTsqt2wuq7Vcl3joXUV8a1TOZ6nf5xMNYPMPOunDHxmjQjO2IZFD
 PTVuY7axP7qFqVwf5W+ZfZdWquX5FZss=
X-Received: by 2002:a05:6808:5092:b0:493:b22c:9fb4 with SMTP id
 5614622812f47-493b22ca525mr1102704b6e.6.1782468510919; Fri, 26 Jun 2026
 03:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
 <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
 <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
 <20260626-zippy-affable-hamster-22101d@houat>
 <CAFQXuNbN1bW3DVGUtVf7--dW_UhSk4LZdk+v14P=VSbDU4ZzsQ@mail.gmail.com>
 <20260626-flawless-axiomatic-slug-c480c9@houat>
 <CAFQXuNa330ctD3VgAVxDSzovwyy0hwVPTfm6pKzeLZDGeq=_=Q@mail.gmail.com>
 <CAFQXuNYh95wTQex9zEUfxGBCsfK72+8eM3Mzm8pC2CFn6bJdGA@mail.gmail.com>
 <20260626-tungsten-capuchin-of-serendipity-24c0a9@houat>
 <CAFQXuNYOcvaiknrFwmxKQdiuWMOZo7mV_Rv7TrMScO_7Y_p8_Q@mail.gmail.com>
 <20260626-hopping-savvy-seagull-cc9626@houat>
In-Reply-To: <20260626-hopping-savvy-seagull-cc9626@houat>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 18:08:19 +0800
X-Gmail-Original-Message-ID: <CAFQXuNbdNTF9bHyy4Nf1kmAAGOAfs-zf6GjshBesTFtdcvMJTg@mail.gmail.com>
X-Gm-Features: AVVi8Ce8rt0fSPDRWAx-y8-HstlVzKAFQA4XVT6NBkr6po8PWM0gPNx7CpplnoM
Message-ID: <CAFQXuNbdNTF9bHyy4Nf1kmAAGOAfs-zf6GjshBesTFtdcvMJTg@mail.gmail.com>
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

Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 17:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 26, 2026 at 05:45:08PM +0800, Sunyun Yang wrote:
> > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 17:31=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Jun 26, 2026 at 05:05:38PM +0800, Sunyun Yang wrote:
> > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 16:40=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > >
> > > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=BA=94 16:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Fri, Jun 26, 2026 at 04:13:18PM +0800, Sunyun Yang wrote:
> > > > > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8826=E6=97=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote=
:
> > > > > > > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > > > > > > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > >>
> > > > > > > > > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=
=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > > > > > > >>>
> > > > > > > > > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > > > > > > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E202=
6=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > > > > > > >>>>>
> > > > > > > > > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > > > > > > > > >>>>>> +
> > > > > > > > > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt961=
1c)
> > > > > > > > > > >>>>>> +{
> > > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gp=
io, 1);
> > > > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > > > >>>>>> +
> > > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gp=
io, 0);
> > > > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > > > >>>>>> +
> > > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gp=
io, 1);
> > > > > > > > > > >>>>>
> > > > > > > > > > >>>>> This is just plain wrong. Why do you assert, then=
 de-assert and then
> > > > > > > > > > >>>>> finally assert AGAIN the reset leaving the device=
 in powerdown stage?
> > > > > > > > > > >>>>>
> > > > > > > > > > >>>> I am using software to emulate the hardware RESET =
button on our EVB.
> > > > > > > > > > >>>> When the hardware RESET button is pressed while ou=
r chip is running,
> > > > > > > > > > >>>> the signal level changes from HIGH to LOW and then=
 back to HIGH.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Of course, we can also use the following:
> > > > > > > > > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > > > > >>>> {
> > > > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, =
0);
> > > > > > > > > > >>>>     msleep(50);
> > > > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, =
1);
> > > > > > > > > > >>>>     msleep(20);
> > > > > > > > > > >>>> }
> > > > > > > > > > >>>
> > > > > > > > > > >>> Makes no sense either and you just did not get the =
point and did not
> > > > > > > > > > >>> answer my question. I asked WHY you leave asserted.=
 Answer "we emulate"
> > > > > > > > > > >>> is just plain wrong.
> > > > > > > > > > >>>
> > > > > > > > > > >>> So again please answer:
> > > > > > > > > > >>>
> > > > > > > > > > >>> Why do you leave device with reset asserted?
> > > > > > > > > > >>>
> > > > > > > > > > >>
> > > > > > > > > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIV=
E_HIGH>;
> > > > > > > > > > >>
> > > > > > > > > > >> GPIO_ACTIVE_HIGH:
> > > > > > > > > > >>
> > > > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   =
------   reset pin
> > > > > > > > > > >> is Low level : Clear the register configuration in t=
he chip to stop
> > > > > > > > > > >> the chip from working.
> > > > > > > > > > >>
> > > > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   =
------  reset pin
> > > > > > > > > > >> is high level:  The chip resumes operation.
> > > > > > > > > > >>
> > > > > > > > > > >>
> > > > > > > > > > >
> > > > > > > > > > > Our purpose is: pull the level low to clear the regis=
ter configuration
> > > > > > > > > > > in the chip, and then pull it high to allow the MCU i=
nside the chip to
> > > > > > > > > > > re=E2=80=91initialize the registers.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > And you do completely opposite... so that confirms your=
 code is just wrong.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just =
following the
> > > > > > > > > rule of this device tree. If I modify the device tree to =
use
> > > > > > > > > GPIO_ACTIVE_LOW,
> > > > > > > > > and use the following code in my driver, then my driver w=
ould be correct.
> > > > > > > > > However, would the existing kernel drivers lontium-lt9611=
uxc.c and
> > > > > > > > > lontium-lt9611.c be affected?
> > > > > > > >
> > > > > > > > It might, but then it's a DT problem. The GPIO API for driv=
ers always
> > > > > > > > considers the logical state of a GPIO, so if you need to as=
sert a
> > > > > > > > signal, you'll always need to set 1. That's what Krzysztof =
was trying to
> > > > > > > > explain.
> > > > > > > >
> > > > > > > > The DT will provide with GPIO_ACTIVE_* how that logical sta=
te translates
> > > > > > > > to a physical GPIO state.
> > > > > > > >
> > > > > > > > If the DT says that this particular GPIO is active-high, th=
en it means
> > > > > > > > that we need to set the GPIO to 1 to assert reset. Now of c=
ourse, it
> > > > > > > > might not make sense for the controller itself, but it migh=
t for the
> > > > > > > > board if there's a GPIO inverter in the middle for example.
> > > > > > > >
> > > > > > > > Anyway, in the case you're raising, the issue definitely li=
es in the DT,
> > > > > > > > and that's what would need to be fixed.
> > > > > > > >
> > > > > > > > I also wouldn't be too concerned about lontium-lt9611.yaml,=
 it's just an
> > > > > > > > example.
> > > > > > > >
> > > > > > > > Maxime
> > > > > > >
> > > > > > > thanks Maxime, I will modify this code in the next version of=
 the
> > > > > > > driver, and I hope you can accept these changes.
> > > > > > >
> > > > > > > Maxime:
> > > > > > > I have another question I would like to ask you
> > > > > > > regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes=
 has
> > > > > > > opinions that differ from yours, whose advice should I follow=
?
> > > > > > >
> > > > > > > If I do not adopt sashiko-bot's suggestions, will my patches =
still be
> > > > > > > accepted into the upstream Linux kernel?
> > > > > >
> > > > > > I can't give a blanket answer. It depends on what you ignore ex=
actly.
> > > > > >
> > > > >
> > > > > Okay, another question: sashiko-bot is an AI bot. Are its review
> > > > > comments optional, or must they be followed?
> > > > >
> > > >
> > > > For example, in my driver, there is a function for upgrading the ch=
ip
> > > > firmware. During debugging or production, upgrading the chip firmwa=
re
> > > > will acquire a lock, which will block the DRM callback and affect
> > > > display. It will be fine after the upgrade is completed and some
> > > > devices are restarted. As long as there is no subsequent upgrade,
> > > > display can work normally.
> > > >
> > > > From a purely software perspective, the AI bot considered this
> > > > approach unacceptable and proposed synchronizing the pre-upgrade st=
ate
> > > > to the DRM framework. From my personal perspective, I think the AI
> > > > bot's suggestion would only make my driver more complex and redunda=
nt.
> > > > Do you think I need to adopt the AI bot's suggestion?
> > >
> > > You're right it's wrong, but there's also no reason to allow that
> > > firmware upgrade during the driver lifetime either through a debugfs
> > > file. So you should get rid of the debugfs file and now you won't hav=
e
> > > to bother with that comment anymore.
> > >
> > > > In addition, if I follow the AI bot's suggestion, the
> > > > lontium-lt9611uxc.c and lontium-lt8713sx.c drivers that have been
> > > > merged into the upstream Linux kernel would not meet the AI bot's
> > > > requirements.
> > >
> > > Maybe, but it's not relevant either way. These drivers are merged, yo=
urs
> > > isn't. Feel free to fix these if you spot any issue though.
> > >
> > > > When I get a reviewer's Reviewed-by flag, can I ignore the opinion =
of
> > > > sashiko-bot (the AI bot)?
> > >
> > > Again, it depends on the comment. If you feel like one can be ignored=
,
> > > you should at least argue why.
> > >
> >
> > sashiko=E2=80=91bot (AI bot) does not communicate or interact with me.
> > Even if I explain the reasons, the AI bot never replies to me, and it
> > only sends its review comments to me alone.
>
> Then put it into the cover letter?
>

thanks Maxime,
I will modify the driver patch, include the relevant explanation in
the cover letter, and then submit it.



> > If I do not make changes according to the AI bot's suggestions, will
> > that affect my driver being merged into the upstream Linux kernel? I
> > would like to know the answer to this question.
>
> I told you twice already.
