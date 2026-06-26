Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC20CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E0F10E347;
	Fri, 26 Jun 2026 09:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UbvqnHBS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164A910E347
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:31:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B984943A47;
 Fri, 26 Jun 2026 09:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2904A1F000E9;
 Fri, 26 Jun 2026 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782466283;
 bh=yZMzc2D+59qeL+1CYcFEVOT21y4gLjtR6W19ZGAjHTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UbvqnHBSUBtQzqFvTMaeYBphmCXLHQQmuOmLuyrKgbgv4bXQkefCHDeEbO/BCYNVZ
 G3dDXHU4uaZqhWZwtFibHetZhY3QIjuXxr/leBJVaCyett8n/zFWBt8/29H1UXJX59
 116mwL5qRCaILWdKYMIBquN1EBMa2hYCrtZryEdKl++uPHuEo2Z/l5uSQfs+cG1R7s
 pxOA585DJA3nNjubnRgg10GeW69Fn/1kvzm1sA2FnT7GSO0hK4jWXoBlpYvCJJXo5/
 pABUgfzHKzY1tunbuvneSnBbgvTzxvZpTqPkaHy8hqj8VSJWKqE38zcDyiZQ68d2xC
 Ountxkw8KtDPg==
Date: Fri, 26 Jun 2026 11:31:21 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sunyun Yang <syyang@lontium.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, 
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com,
 xbpeng@lontium.com
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <20260626-tungsten-capuchin-of-serendipity-24c0a9@houat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7a6od7fn56ge3tan"
Content-Disposition: inline
In-Reply-To: <CAFQXuNYh95wTQex9zEUfxGBCsfK72+8eM3Mzm8pC2CFn6bJdGA@mail.gmail.com>
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


--7a6od7fn56ge3tan
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
MIME-Version: 1.0

On Fri, Jun 26, 2026 at 05:05:38PM +0800, Sunyun Yang wrote:
> Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=94 16:40=E5=86=99=E9=81=93=EF=BC=9A
>=20
> >
> > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 16:26=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Jun 26, 2026 at 04:13:18PM +0800, Sunyun Yang wrote:
> > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=88=
26=E6=97=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote:
> > > > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B46=
=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > > > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >>
> > > > > > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >>>
> > > > > > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > > > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=
=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > >>>>>
> > > > > > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > > > > > >>>>>> +
> > > > > > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > >>>>>> +{
> > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > > >>>>>> +     msleep(20);
> > > > > > > >>>>>> +
> > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > > >>>>>> +     msleep(20);
> > > > > > > >>>>>> +
> > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > > >>>>>
> > > > > > > >>>>> This is just plain wrong. Why do you assert, then de-as=
sert and then
> > > > > > > >>>>> finally assert AGAIN the reset leaving the device in po=
werdown stage?
> > > > > > > >>>>>
> > > > > > > >>>> I am using software to emulate the hardware RESET button=
 on our EVB.
> > > > > > > >>>> When the hardware RESET button is pressed while our chip=
 is running,
> > > > > > > >>>> the signal level changes from HIGH to LOW and then back =
to HIGH.
> > > > > > > >>>>
> > > > > > > >>>> Of course, we can also use the following:
> > > > > > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > >>>> {
> > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > > >>>>     msleep(50);
> > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > > >>>>     msleep(20);
> > > > > > > >>>> }
> > > > > > > >>>
> > > > > > > >>> Makes no sense either and you just did not get the point =
and did not
> > > > > > > >>> answer my question. I asked WHY you leave asserted. Answe=
r "we emulate"
> > > > > > > >>> is just plain wrong.
> > > > > > > >>>
> > > > > > > >>> So again please answer:
> > > > > > > >>>
> > > > > > > >>> Why do you leave device with reset asserted?
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_HIGH=
>;
> > > > > > > >>
> > > > > > > >> GPIO_ACTIVE_HIGH:
> > > > > > > >>
> > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   ------=
   reset pin
> > > > > > > >> is Low level : Clear the register configuration in the chi=
p to stop
> > > > > > > >> the chip from working.
> > > > > > > >>
> > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   ------=
  reset pin
> > > > > > > >> is high level:  The chip resumes operation.
> > > > > > > >>
> > > > > > > >>
> > > > > > > >
> > > > > > > > Our purpose is: pull the level low to clear the register co=
nfiguration
> > > > > > > > in the chip, and then pull it high to allow the MCU inside =
the chip to
> > > > > > > > re=E2=80=91initialize the registers.
> > > > > > >
> > > > > > >
> > > > > > > And you do completely opposite... so that confirms your code =
is just wrong.
> > > > > > >
> > > > > >
> > > > > > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just follow=
ing the
> > > > > > rule of this device tree. If I modify the device tree to use
> > > > > > GPIO_ACTIVE_LOW,
> > > > > > and use the following code in my driver, then my driver would b=
e correct.
> > > > > > However, would the existing kernel drivers lontium-lt9611uxc.c =
and
> > > > > > lontium-lt9611.c be affected?
> > > > >
> > > > > It might, but then it's a DT problem. The GPIO API for drivers al=
ways
> > > > > considers the logical state of a GPIO, so if you need to assert a
> > > > > signal, you'll always need to set 1. That's what Krzysztof was tr=
ying to
> > > > > explain.
> > > > >
> > > > > The DT will provide with GPIO_ACTIVE_* how that logical state tra=
nslates
> > > > > to a physical GPIO state.
> > > > >
> > > > > If the DT says that this particular GPIO is active-high, then it =
means
> > > > > that we need to set the GPIO to 1 to assert reset. Now of course,=
 it
> > > > > might not make sense for the controller itself, but it might for =
the
> > > > > board if there's a GPIO inverter in the middle for example.
> > > > >
> > > > > Anyway, in the case you're raising, the issue definitely lies in =
the DT,
> > > > > and that's what would need to be fixed.
> > > > >
> > > > > I also wouldn't be too concerned about lontium-lt9611.yaml, it's =
just an
> > > > > example.
> > > > >
> > > > > Maxime
> > > >
> > > > thanks Maxime, I will modify this code in the next version of the
> > > > driver, and I hope you can accept these changes.
> > > >
> > > > Maxime:
> > > > I have another question I would like to ask you
> > > > regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes has
> > > > opinions that differ from yours, whose advice should I follow?
> > > >
> > > > If I do not adopt sashiko-bot's suggestions, will my patches still =
be
> > > > accepted into the upstream Linux kernel?
> > >
> > > I can't give a blanket answer. It depends on what you ignore exactly.
> > >
> >
> > Okay, another question: sashiko-bot is an AI bot. Are its review
> > comments optional, or must they be followed?
> >
>=20
> For example, in my driver, there is a function for upgrading the chip
> firmware. During debugging or production, upgrading the chip firmware
> will acquire a lock, which will block the DRM callback and affect
> display. It will be fine after the upgrade is completed and some
> devices are restarted. As long as there is no subsequent upgrade,
> display can work normally.
>=20
> From a purely software perspective, the AI bot considered this
> approach unacceptable and proposed synchronizing the pre-upgrade state
> to the DRM framework. From my personal perspective, I think the AI
> bot's suggestion would only make my driver more complex and redundant.
> Do you think I need to adopt the AI bot's suggestion?

You're right it's wrong, but there's also no reason to allow that
firmware upgrade during the driver lifetime either through a debugfs
file. So you should get rid of the debugfs file and now you won't have
to bother with that comment anymore.

> In addition, if I follow the AI bot's suggestion, the
> lontium-lt9611uxc.c and lontium-lt8713sx.c drivers that have been
> merged into the upstream Linux kernel would not meet the AI bot's
> requirements.

Maybe, but it's not relevant either way. These drivers are merged, yours
isn't. Feel free to fix these if you spot any issue though.

> When I get a reviewer's Reviewed-by flag, can I ignore the opinion of
> sashiko-bot (the AI bot)?

Again, it depends on the comment. If you feel like one can be ignored,
you should at least argue why.

Maxime

--7a6od7fn56ge3tan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaj5G6AAKCRAnX84Zoj2+
dsiuAYC4vMklaH2PYwaa/lq7c74jgXOC+Rrkl+8HU1o3zFK9dUR5BFniXL2YBq/p
rHx0P7gBgI4IYvo6PZdKvsETVZB5iHXMrETA6DDYdcNzjRJ/7nDhVKV4qcm6zJKa
TShiXE7YXg==
=t2bD
-----END PGP SIGNATURE-----

--7a6od7fn56ge3tan--
