Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13EACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432BA10F4CE;
	Fri, 26 Jun 2026 08:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="SNbUL4Or";
	dkim-atps=neutral
Received: from out28-91.mail.aliyun.com (out28-91.mail.aliyun.com
 [115.124.28.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CFB10F4CE
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1782461613; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=Hz7GoxRrDOeP6izzI+KPGlftBZo8WhaNw4ObLmMqKhs=;
 b=SNbUL4OrY9iTZXYpwQJBU/7i+T8UrjCYJfdQeG9/A9qLm8B6N+5Z6HosMLhTNrNsJujrKvtljRU78fEKb6ekbu7dl+3SeGP3q4W0mPGVbIfvwiWzJK1qoZbTVa2qQYrAkmgnRYThAn8u371hmNV6CPsCZwx5/nRJgONZGJuDrqPrNTHyb1nctgl3S/1OMcLrWit6O6wzNLK8ZpxEkkXWdW5Gb4EnjBU4I+wwhBhjNPTPi5GZ9roReAMejpNiPU9R0DREVNhuLkDn0Eg9aOZoySOaEuIa9ip1odd/TZLsCgSW/72RYynx4oQDbuimVyrJ0D+ol5Qi5j++cBJGtTH87g==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436325|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.230135-0.00832398-0.761541;
 FP=18253502819858982146|10|1|8|0|-1|-1|-1;
 HT=maildocker-contentspam033037021217; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.i6HmC0C_1782461610; 
Received: from mail-ot1-f43.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.i6HmC0C_1782461610 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 26 Jun 2026 16:13:31 +0800
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7e6e9408e30so623616a34.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 01:13:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+ffJBWAYduQKlf3WWtV9WPuzM0hW4tE3M1ppMtL5mb56FWqK4dVM7JKk3vuSPVWN4Z+4TBrAukxKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwshiA/iw42OHe0Mnkho1sjQPKXlvzgKC3Aue9sQXBSgLTsMQXo
 vogXXwvXmQZ3k8pr3Xxrqbp9zL74+91GN2+6/+WtlDUkyRnesGUtwvaeyZgtlL+IUR5NNU9w0Xr
 DZNMEYd9AT17SZjbZ/lklUyBnxyGlqrc=
X-Received: by 2002:a05:6808:c185:b0:490:a66f:9aac with SMTP id
 5614622812f47-492190fc5b3mr5591967b6e.14.1782461609193; Fri, 26 Jun 2026
 01:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260508134009.4582-1-syyang@lontium.com>
 <20260508134009.4582-3-syyang@lontium.com>
 <3188f63f-5358-48d7-b934-af20a8f95c6f@kernel.org>
 <CAFQXuNbKBfyeQL3N3P5QY=6BWoD3O6DSbXN-WMA1rRG9vCs3Kg@mail.gmail.com>
 <a0352a42-15db-4c7a-ae73-8a4e1543cd50@kernel.org>
 <CAFQXuNZVE6cZJGwrGKGtWnB-seSJLHFh8zW3jjAs6U4JLZFWng@mail.gmail.com>
 <CAFQXuNa8bJCpZBkMs_3mtbK_pjVzDdaDaoGk0KDxiG_Pf7txdg@mail.gmail.com>
 <6371d1d8-cdfb-40fa-84c7-ba3ec4e2ac00@kernel.org>
 <CAFQXuNZtzBu+WiG8n0BeN47zagQmL-iz_6Af7prk-xHLAeRBwg@mail.gmail.com>
 <20260626-zippy-affable-hamster-22101d@houat>
In-Reply-To: <20260626-zippy-affable-hamster-22101d@houat>
From: Sunyun Yang <syyang@lontium.com>
Date: Fri, 26 Jun 2026 16:13:18 +0800
X-Gmail-Original-Message-ID: <CAFQXuNbN1bW3DVGUtVf7--dW_UhSk4LZdk+v14P=VSbDU4ZzsQ@mail.gmail.com>
X-Gm-Features: AVVi8Ccy1Vot-JXWqeZuZ9hQ6HBLxv1b4oTaGEUoItSLAk3USIt4bCYDgyYi4Os
Message-ID: <CAFQXuNbN1bW3DVGUtVf7--dW_UhSk4LZdk+v14P=VSbDU4ZzsQ@mail.gmail.com>
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
=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=882=
5=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8825=
=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > >>
> > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> > > >>>
> > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=9A
> > > >>>>>
> > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > >>>>>> +
> > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > >>>>>> +{
> > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >>>>>> +     msleep(20);
> > > >>>>>> +
> > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > >>>>>> +     msleep(20);
> > > >>>>>> +
> > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >>>>>
> > > >>>>> This is just plain wrong. Why do you assert, then de-assert and=
 then
> > > >>>>> finally assert AGAIN the reset leaving the device in powerdown =
stage?
> > > >>>>>
> > > >>>> I am using software to emulate the hardware RESET button on our =
EVB.
> > > >>>> When the hardware RESET button is pressed while our chip is runn=
ing,
> > > >>>> the signal level changes from HIGH to LOW and then back to HIGH.
> > > >>>>
> > > >>>> Of course, we can also use the following:
> > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > >>>> {
> > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > >>>>     msleep(50);
> > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > >>>>     msleep(20);
> > > >>>> }
> > > >>>
> > > >>> Makes no sense either and you just did not get the point and did =
not
> > > >>> answer my question. I asked WHY you leave asserted. Answer "we em=
ulate"
> > > >>> is just plain wrong.
> > > >>>
> > > >>> So again please answer:
> > > >>>
> > > >>> Why do you leave device with reset asserted?
> > > >>>
> > > >>
> > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH>;
> > > >>
> > > >> GPIO_ACTIVE_HIGH:
> > > >>
> > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------   reset=
 pin
> > > >> is Low level : Clear the register configuration in the chip to sto=
p
> > > >> the chip from working.
> > > >>
> > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------  reset =
pin
> > > >> is high level:  The chip resumes operation.
> > > >>
> > > >>
> > > >
> > > > Our purpose is: pull the level low to clear the register configurat=
ion
> > > > in the chip, and then pull it high to allow the MCU inside the chip=
 to
> > > > re=E2=80=91initialize the registers.
> > >
> > >
> > > And you do completely opposite... so that confirms your code is just =
wrong.
> > >
> >
> > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just following the
> > rule of this device tree. If I modify the device tree to use
> > GPIO_ACTIVE_LOW,
> > and use the following code in my driver, then my driver would be correc=
t.
> > However, would the existing kernel drivers lontium-lt9611uxc.c and
> > lontium-lt9611.c be affected?
>
> It might, but then it's a DT problem. The GPIO API for drivers always
> considers the logical state of a GPIO, so if you need to assert a
> signal, you'll always need to set 1. That's what Krzysztof was trying to
> explain.
>
> The DT will provide with GPIO_ACTIVE_* how that logical state translates
> to a physical GPIO state.
>
> If the DT says that this particular GPIO is active-high, then it means
> that we need to set the GPIO to 1 to assert reset. Now of course, it
> might not make sense for the controller itself, but it might for the
> board if there's a GPIO inverter in the middle for example.
>
> Anyway, in the case you're raising, the issue definitely lies in the DT,
> and that's what would need to be fixed.
>
> I also wouldn't be too concerned about lontium-lt9611.yaml, it's just an
> example.
>
> Maxime

thanks Maxime, I will modify this code in the next version of the
driver, and I hope you can accept these changes.

Maxime:
I have another question I would like to ask you
regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes has
opinions that differ from yours, whose advice should I follow?

If I do not adopt sashiko-bot's suggestions, will my patches still be
accepted into the upstream Linux kernel?
