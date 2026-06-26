Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD2ECDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB9D10F522;
	Fri, 26 Jun 2026 09:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="YVIcQqV+";
	dkim-atps=neutral
Received: from out28-109.mail.aliyun.com (out28-109.mail.aliyun.com
 [115.124.28.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C9A10F522
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782467124; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=CG0uZ5A5RTYEzLxzd6lkXQE6XVuOPEvqVTPQNsDi92U=;
 b=YVIcQqV+IpG+1VGem+nbU/rGsld7vy/dS5E3YeYK8HJ/+xmqNX3XsZckiB8c2lTbY/zd85pd5h3g5v++S6qZfPb9/jJMKPDSxCh/e1xMhlkkR9SrOfuo3eME7+ibMEOyIdL2O64HEd9NImLxrhHjMAfuZrw27MC/KLrbeAlREi3LMW9N/kQMFr7qtpb3a3SzqIJHDUF+8JMTFg8rovmqOCTQ0VJW4dcD4NbXGPAFNgz31a3ZNU/S+hGA9PUln9CHTCgsWnoSXObQpPcD8Fi9Ryr3XYy6eN4qeLtuWxnrBrQXnSVEk6DHP+P2JqrSeS4mPrDE51y+bu8olAh/STOZWg==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_system_inform|0.0287316-0.00247526-0.968793;
 FP=18253458976430204170|3|1|3|0|-1|-1|-1;
 HT=maildocker-contentspam033037031241; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i6Mukg2_1782467122; 
Received: from mail-oa1-f47.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i6Mukg2_1782467122 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 17:45:23 +0800
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-44747d96185so397631fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:45:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/+EiMM9vwlu3bXE0JmTf95RHM91ulQCB4fH1u59Rv/gFd7F6IfX8jKxNK48vAVfRAtDgs+n4hWre0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywwb+CMOV08pdpn6Njo4LGVGH6BcigLJ969CFIBl9itbuyX+Wnt
 gBoWtFXmyU4YdoN/64i0moQgMimgLEn6UsJVMEgLBNRT00EhUzPNqIhwcYZJ5JeVbboVW4xjT4o
 0UD6zawUUVQALfbzlqYtEa0Sm1Ot8TXQ=
X-Received: by 2002:a05:6809:359:10b0:492:542e:c9a8 with SMTP id
 5614622812f47-492542f0b75mr3339955b6e.39.1782467122106; Fri, 26 Jun 2026
 02:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
 <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
 <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
 <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
 <20260626-zippy-affable-hamster-22101d@houat>
 <CAFQXuNbN1bW3DVGUtVf7--dW_UhSk4LZdk+v14P=VSbDU4ZzsQ@mail.gmail.com>
 <20260626-flawless-axiomatic-slug-c480c9@houat>
 <CAFQXuNa330ctD3VgAVxDSzovwyy0hwVPTfm6pKzeLZDGeq=_=Q@mail.gmail.com>
 <CAFQXuNYh95wTQex9zEUfxGBCsfK72+8eM3Mzm8pC2CFn6bJdGA@mail.gmail.com>
 <20260626-tungsten-capuchin-of-serendipity-24c0a9@houat>
In-Reply-To: <20260626-tungsten-capuchin-of-serendipity-24c0a9@houat>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 17:45:08 +0800
X-Gmail-Original-Message-ID: <CAFQXuNYOcvaiknrFwmxKQdiuWMOZo7mV_Rv7TrMScO_7Y_p8_Q@mail.gmail.com>
X-Gm-Features: AVVi8Ce2k_tbAS6eWi4Ugrn8WcziFU1FfSkgFbI2qqA9t-k0_fRwCzHphfxoC3w
Message-ID: <CAFQXuNYOcvaiknrFwmxKQdiuWMOZo7mV_Rv7TrMScO_7Y_p8_Q@mail.gmail.com>
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
=A5=E5=91=A8=E4=BA=94 17:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 26, 2026 at 05:05:38PM +0800, Sunyun Yang wrote:
> > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=94 16:40=E5=86=99=E9=81=93=EF=BC=9A
> >
> > >
> > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 16:26=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, Jun 26, 2026 at 04:13:18PM +0800, Sunyun Yang wrote:
> > > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote:
> > > > > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > > > > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >>
> > > > > > > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=
=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > >>>
> > > > > > > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > > > > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=
=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > >>>>>
> > > > > > > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > > > > > > >>>>>> +
> > > > > > > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > > >>>>>> +{
> > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, =
1);
> > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > >>>>>> +
> > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, =
0);
> > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > >>>>>> +
> > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, =
1);
> > > > > > > > >>>>>
> > > > > > > > >>>>> This is just plain wrong. Why do you assert, then de-=
assert and then
> > > > > > > > >>>>> finally assert AGAIN the reset leaving the device in =
powerdown stage?
> > > > > > > > >>>>>
> > > > > > > > >>>> I am using software to emulate the hardware RESET butt=
on on our EVB.
> > > > > > > > >>>> When the hardware RESET button is pressed while our ch=
ip is running,
> > > > > > > > >>>> the signal level changes from HIGH to LOW and then bac=
k to HIGH.
> > > > > > > > >>>>
> > > > > > > > >>>> Of course, we can also use the following:
> > > > > > > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > > >>>> {
> > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > > > >>>>     msleep(50);
> > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > > > >>>>     msleep(20);
> > > > > > > > >>>> }
> > > > > > > > >>>
> > > > > > > > >>> Makes no sense either and you just did not get the poin=
t and did not
> > > > > > > > >>> answer my question. I asked WHY you leave asserted. Ans=
wer "we emulate"
> > > > > > > > >>> is just plain wrong.
> > > > > > > > >>>
> > > > > > > > >>> So again please answer:
> > > > > > > > >>>
> > > > > > > > >>> Why do you leave device with reset asserted?
> > > > > > > > >>>
> > > > > > > > >>
> > > > > > > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HI=
GH>;
> > > > > > > > >>
> > > > > > > > >> GPIO_ACTIVE_HIGH:
> > > > > > > > >>
> > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ----=
--   reset pin
> > > > > > > > >> is Low level : Clear the register configuration in the c=
hip to stop
> > > > > > > > >> the chip from working.
> > > > > > > > >>
> > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ----=
--  reset pin
> > > > > > > > >> is high level:  The chip resumes operation.
> > > > > > > > >>
> > > > > > > > >>
> > > > > > > > >
> > > > > > > > > Our purpose is: pull the level low to clear the register =
configuration
> > > > > > > > > in the chip, and then pull it high to allow the MCU insid=
e the chip to
> > > > > > > > > re=E2=80=91initialize the registers.
> > > > > > > >
> > > > > > > >
> > > > > > > > And you do completely opposite... so that confirms your cod=
e is just wrong.
> > > > > > > >
> > > > > > >
> > > > > > > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just foll=
owing the
> > > > > > > rule of this device tree. If I modify the device tree to use
> > > > > > > GPIO_ACTIVE_LOW,
> > > > > > > and use the following code in my driver, then my driver would=
 be correct.
> > > > > > > However, would the existing kernel drivers lontium-lt9611uxc.=
c and
> > > > > > > lontium-lt9611.c be affected?
> > > > > >
> > > > > > It might, but then it's a DT problem. The GPIO API for drivers =
always
> > > > > > considers the logical state of a GPIO, so if you need to assert=
 a
> > > > > > signal, you'll always need to set 1. That's what Krzysztof was =
trying to
> > > > > > explain.
> > > > > >
> > > > > > The DT will provide with GPIO_ACTIVE_* how that logical state t=
ranslates
> > > > > > to a physical GPIO state.
> > > > > >
> > > > > > If the DT says that this particular GPIO is active-high, then i=
t means
> > > > > > that we need to set the GPIO to 1 to assert reset. Now of cours=
e, it
> > > > > > might not make sense for the controller itself, but it might fo=
r the
> > > > > > board if there's a GPIO inverter in the middle for example.
> > > > > >
> > > > > > Anyway, in the case you're raising, the issue definitely lies i=
n the DT,
> > > > > > and that's what would need to be fixed.
> > > > > >
> > > > > > I also wouldn't be too concerned about lontium-lt9611.yaml, it'=
s just an
> > > > > > example.
> > > > > >
> > > > > > Maxime
> > > > >
> > > > > thanks Maxime, I will modify this code in the next version of the
> > > > > driver, and I hope you can accept these changes.
> > > > >
> > > > > Maxime:
> > > > > I have another question I would like to ask you
> > > > > regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes has
> > > > > opinions that differ from yours, whose advice should I follow?
> > > > >
> > > > > If I do not adopt sashiko-bot's suggestions, will my patches stil=
l be
> > > > > accepted into the upstream Linux kernel?
> > > >
> > > > I can't give a blanket answer. It depends on what you ignore exactl=
y.
> > > >
> > >
> > > Okay, another question: sashiko-bot is an AI bot. Are its review
> > > comments optional, or must they be followed?
> > >
> >
> > For example, in my driver, there is a function for upgrading the chip
> > firmware. During debugging or production, upgrading the chip firmware
> > will acquire a lock, which will block the DRM callback and affect
> > display. It will be fine after the upgrade is completed and some
> > devices are restarted. As long as there is no subsequent upgrade,
> > display can work normally.
> >
> > From a purely software perspective, the AI bot considered this
> > approach unacceptable and proposed synchronizing the pre-upgrade state
> > to the DRM framework. From my personal perspective, I think the AI
> > bot's suggestion would only make my driver more complex and redundant.
> > Do you think I need to adopt the AI bot's suggestion?
>
> You're right it's wrong, but there's also no reason to allow that
> firmware upgrade during the driver lifetime either through a debugfs
> file. So you should get rid of the debugfs file and now you won't have
> to bother with that comment anymore.
>
> > In addition, if I follow the AI bot's suggestion, the
> > lontium-lt9611uxc.c and lontium-lt8713sx.c drivers that have been
> > merged into the upstream Linux kernel would not meet the AI bot's
> > requirements.
>
> Maybe, but it's not relevant either way. These drivers are merged, yours
> isn't. Feel free to fix these if you spot any issue though.
>
> > When I get a reviewer's Reviewed-by flag, can I ignore the opinion of
> > sashiko-bot (the AI bot)?
>
> Again, it depends on the comment. If you feel like one can be ignored,
> you should at least argue why.
>

sashiko=E2=80=91bot (AI bot) does not communicate or interact with me.
Even if I explain the reasons, the AI bot never replies to me, and it
only sends its review comments to me alone.

If I do not make changes according to the AI bot's suggestions, will
that affect my driver being merged into the upstream Linux kernel? I
would like to know the answer to this question.


> Maxime
