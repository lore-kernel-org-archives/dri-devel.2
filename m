Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A85CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6E310F53B;
	Fri, 26 Jun 2026 09:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PKpzEiAK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DDB10F53B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 09:53:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 899014178D;
 Fri, 26 Jun 2026 09:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1471F000E9;
 Fri, 26 Jun 2026 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782467584;
 bh=BwhGw1glQpujHGTnmhunMAkIlX1zQ8yXGqHL7ZYe3QM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PKpzEiAK9vUXQoeKThpOlrGvnekM24IDguR+/Qi/Frqsmmm4ssDm3TfVbCET2B4bR
 uEhiGnlHT9nV1LsKyMhbdHf1AVwKcPRK0yhqUo5ISXI9mtqGiNZbFqgs0NVWaNSDNp
 FvhKixJAqrSXlSWn4349D38RjQgqQtp2acRM7K+TY/dkbzPO0NYDwivVtXgNGcd5OS
 1GU2NP6ejneQUMKgQUhYU26aX5MgDIIxL/WTiGSqiaZ5vIwfh43JmJuHTnDeDjUDDZ
 ecJRVsIr9Fucye1r7cCDFE7Gu5bB9iJNztMwcTaBSny+C0iDfZdNjJDqZm9O03Fnv/
 wgAByXz31nf3w==
Date: Fri, 26 Jun 2026 11:53:01 +0200
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
Message-ID: <20260626-hopping-savvy-seagull-cc9626@houat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="muia4nl7v6z733kr"
Content-Disposition: inline
In-Reply-To: <CAFQXuNYOcvaiknrFwmxKQdiuWMOZo7mV_Rv7TrMScO_7Y_p8_Q@mail.gmail.com>
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


--muia4nl7v6z733kr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
MIME-Version: 1.0

On Fri, Jun 26, 2026 at 05:45:08PM +0800, Sunyun Yang wrote:
> Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=BA=94 17:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Jun 26, 2026 at 05:05:38PM +0800, Sunyun Yang wrote:
> > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=BA=94 16:40=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > >
> > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=88=
26=E6=97=A5=E5=91=A8=E4=BA=94 16:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Fri, Jun 26, 2026 at 04:13:18PM +0800, Sunyun Yang wrote:
> > > > > > Maxime Ripard <mripard@kernel.org> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8826=E6=97=A5=E5=91=A8=E4=BA=94 15:49=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Fri, Jun 26, 2026 at 10:15:03AM +0800, Sunyun Yang wrote:
> > > > > > > > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=
=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On 25/06/2026 15:40, Sunyun Yang wrote:
> > > > > > > > > > Sunyun Yang <syyang@lontium.com> =E4=BA=8E2026=E5=B9=B4=
6=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > >>
> > > > > > > > > >> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=
=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 21:17=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > > >>>
> > > > > > > > > >>> On 25/06/2026 15:14, Sunyun Yang wrote:
> > > > > > > > > >>>> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=
=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 20:54=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> On 08/05/2026 15:40, syyang@lontium.com wrote:
> > > > > > > > > >>>>>> +
> > > > > > > > > >>>>>> +static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > > > >>>>>> +{
> > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio=
, 1);
> > > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > > >>>>>> +
> > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio=
, 0);
> > > > > > > > > >>>>>> +     msleep(20);
> > > > > > > > > >>>>>> +
> > > > > > > > > >>>>>> +     gpiod_set_value_cansleep(lt9611c->reset_gpio=
, 1);
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> This is just plain wrong. Why do you assert, then d=
e-assert and then
> > > > > > > > > >>>>> finally assert AGAIN the reset leaving the device i=
n powerdown stage?
> > > > > > > > > >>>>>
> > > > > > > > > >>>> I am using software to emulate the hardware RESET bu=
tton on our EVB.
> > > > > > > > > >>>> When the hardware RESET button is pressed while our =
chip is running,
> > > > > > > > > >>>> the signal level changes from HIGH to LOW and then b=
ack to HIGH.
> > > > > > > > > >>>>
> > > > > > > > > >>>> Of course, we can also use the following:
> > > > > > > > > >>>> static void lt9611c_reset(struct lt9611c *lt9611c)
> > > > > > > > > >>>> {
> > > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > > > > > > > > >>>>     msleep(50);
> > > > > > > > > >>>>     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > > > > > > > > >>>>     msleep(20);
> > > > > > > > > >>>> }
> > > > > > > > > >>>
> > > > > > > > > >>> Makes no sense either and you just did not get the po=
int and did not
> > > > > > > > > >>> answer my question. I asked WHY you leave asserted. A=
nswer "we emulate"
> > > > > > > > > >>> is just plain wrong.
> > > > > > > > > >>>
> > > > > > > > > >>> So again please answer:
> > > > > > > > > >>>
> > > > > > > > > >>> Why do you leave device with reset asserted?
> > > > > > > > > >>>
> > > > > > > > > >>
> > > > > > > > > >>  devicetree:   reset-gpios =3D <&tlmm 128 GPIO_ACTIVE_=
HIGH>;
> > > > > > > > > >>
> > > > > > > > > >> GPIO_ACTIVE_HIGH:
> > > > > > > > > >>
> > > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);   --=
----   reset pin
> > > > > > > > > >> is Low level : Clear the register configuration in the=
 chip to stop
> > > > > > > > > >> the chip from working.
> > > > > > > > > >>
> > > > > > > > > >> gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);   --=
----  reset pin
> > > > > > > > > >> is high level:  The chip resumes operation.
> > > > > > > > > >>
> > > > > > > > > >>
> > > > > > > > > >
> > > > > > > > > > Our purpose is: pull the level low to clear the registe=
r configuration
> > > > > > > > > > in the chip, and then pull it high to allow the MCU ins=
ide the chip to
> > > > > > > > > > re=E2=80=91initialize the registers.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > And you do completely opposite... so that confirms your c=
ode is just wrong.
> > > > > > > > >
> > > > > > > >
> > > > > > > > The lontium-lt9611.yaml uses GPIO_ACTIVE_HIGH. I am just fo=
llowing the
> > > > > > > > rule of this device tree. If I modify the device tree to use
> > > > > > > > GPIO_ACTIVE_LOW,
> > > > > > > > and use the following code in my driver, then my driver wou=
ld be correct.
> > > > > > > > However, would the existing kernel drivers lontium-lt9611ux=
c.c and
> > > > > > > > lontium-lt9611.c be affected?
> > > > > > >
> > > > > > > It might, but then it's a DT problem. The GPIO API for driver=
s always
> > > > > > > considers the logical state of a GPIO, so if you need to asse=
rt a
> > > > > > > signal, you'll always need to set 1. That's what Krzysztof wa=
s trying to
> > > > > > > explain.
> > > > > > >
> > > > > > > The DT will provide with GPIO_ACTIVE_* how that logical state=
 translates
> > > > > > > to a physical GPIO state.
> > > > > > >
> > > > > > > If the DT says that this particular GPIO is active-high, then=
 it means
> > > > > > > that we need to set the GPIO to 1 to assert reset. Now of cou=
rse, it
> > > > > > > might not make sense for the controller itself, but it might =
for the
> > > > > > > board if there's a GPIO inverter in the middle for example.
> > > > > > >
> > > > > > > Anyway, in the case you're raising, the issue definitely lies=
 in the DT,
> > > > > > > and that's what would need to be fixed.
> > > > > > >
> > > > > > > I also wouldn't be too concerned about lontium-lt9611.yaml, i=
t's just an
> > > > > > > example.
> > > > > > >
> > > > > > > Maxime
> > > > > >
> > > > > > thanks Maxime, I will modify this code in the next version of t=
he
> > > > > > driver, and I hope you can accept these changes.
> > > > > >
> > > > > > Maxime:
> > > > > > I have another question I would like to ask you
> > > > > > regarding sashiko-bot@kernel.org. Since sashiko-bot sometimes h=
as
> > > > > > opinions that differ from yours, whose advice should I follow?
> > > > > >
> > > > > > If I do not adopt sashiko-bot's suggestions, will my patches st=
ill be
> > > > > > accepted into the upstream Linux kernel?
> > > > >
> > > > > I can't give a blanket answer. It depends on what you ignore exac=
tly.
> > > > >
> > > >
> > > > Okay, another question: sashiko-bot is an AI bot. Are its review
> > > > comments optional, or must they be followed?
> > > >
> > >
> > > For example, in my driver, there is a function for upgrading the chip
> > > firmware. During debugging or production, upgrading the chip firmware
> > > will acquire a lock, which will block the DRM callback and affect
> > > display. It will be fine after the upgrade is completed and some
> > > devices are restarted. As long as there is no subsequent upgrade,
> > > display can work normally.
> > >
> > > From a purely software perspective, the AI bot considered this
> > > approach unacceptable and proposed synchronizing the pre-upgrade state
> > > to the DRM framework. From my personal perspective, I think the AI
> > > bot's suggestion would only make my driver more complex and redundant.
> > > Do you think I need to adopt the AI bot's suggestion?
> >
> > You're right it's wrong, but there's also no reason to allow that
> > firmware upgrade during the driver lifetime either through a debugfs
> > file. So you should get rid of the debugfs file and now you won't have
> > to bother with that comment anymore.
> >
> > > In addition, if I follow the AI bot's suggestion, the
> > > lontium-lt9611uxc.c and lontium-lt8713sx.c drivers that have been
> > > merged into the upstream Linux kernel would not meet the AI bot's
> > > requirements.
> >
> > Maybe, but it's not relevant either way. These drivers are merged, yours
> > isn't. Feel free to fix these if you spot any issue though.
> >
> > > When I get a reviewer's Reviewed-by flag, can I ignore the opinion of
> > > sashiko-bot (the AI bot)?
> >
> > Again, it depends on the comment. If you feel like one can be ignored,
> > you should at least argue why.
> >
>=20
> sashiko=E2=80=91bot (AI bot) does not communicate or interact with me.
> Even if I explain the reasons, the AI bot never replies to me, and it
> only sends its review comments to me alone.

Then put it into the cover letter?

> If I do not make changes according to the AI bot's suggestions, will
> that affect my driver being merged into the upstream Linux kernel? I
> would like to know the answer to this question.

I told you twice already.

--muia4nl7v6z733kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaj5L/QAKCRAnX84Zoj2+
dqkDAYDnnIkdKdTBNWvR7Q3lZBaQkrzXZ6HovSxKMX1YmTQXRRCsi2Q1uSqSBfWB
bMWtpewBgPqa6slzgeEqwVTSEh4o0Ey3Pk/rlZy2NNh3UinTcatYIRrWFPmiEZCk
jo1JJPN2lw==
=CcaV
-----END PGP SIGNATURE-----

--muia4nl7v6z733kr--
