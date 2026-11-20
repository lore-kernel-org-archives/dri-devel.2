Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A753606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=hzChnzqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24A310E292;
	Fri, 20 Nov 2026 08:44:21 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5F510E292
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=UxmBx3Rz1ImbRcmIwlXmykyvtl7+nbEutG+sEKlD5uk=; t=1795164255; x=1796373855; 
 b=hzChnzqGiBJfiBIhFcTJ71Ukwl765xrG6ZNEm8C7fKbQi9SCCbkd88UiVEIS+cenBBUlN8Qj/hv
 SOuG1gCRo3+OnlA1DLr3eGuWwbOhDNX2gVkeC+AGbdCclwKTb4gvGKiPpBZuDtDRd1phUI6ICKNmu
 BDwOPw4NN320aRQVviPmPWHexf127XZWV+x567E4tdEHQ6pILO+FT7C2nyvstHhsTOJ9QJgeeAP7j
 6k0ipIinvOeLrp+MiWhEcLerwKs0As61JaUijehggX8+WsgXW1NufAtoKVAYeP5otjkIONz02TwO2
 wg87PCUyUKJLjs+Ll8TFNdVU2JolZFmPIlEg==;
Date: Fri, 20 Nov 2026 09:43:20 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Geert Uytterhoeven <geert@linux-m68k.org>, ettore.chimenti@linaro.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley
 <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Ulf Hansson
 <ulfh@kernel.org>, linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
Message-ID: <20261120094320.442d064b@kemnade.info>
In-Reply-To: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
 <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 08:49:05 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andreas,
>=20
> On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrot=
e:
> > On Thu, 19 Nov 2026 14:40:38 +0100
> > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > =20
> > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > used for power management, so the latter show up as "deviceless" in t=
he
> > > consumer column of the clk_summary file in debugfs.
> > >
> > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > the consumer device, too.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > Compile-tested only.
> > >
> > > The first change is probably OK.  The second change may fail if anyth=
ing
> > > in the oh->od->pdev->dev chain is not available yet at this point. =20
> >
> > Test on OMAP3: =20
>=20
> Thanks for testing!
>=20
> > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > @@ -1,17 +1,17 @@
> >                                   enable  prepare  protect             =
                   duty  hardware                            connection
> >     clock                          count    count    count        rate =
  accuracy phase  cycle    enable   consumer                         id
> >  ----------------------------------------------------------------------=
-----------------------------------------------------------------------
> > - oscillator                          0       0        0        2600000=
0    0          0     50000      Y   deviceless                      of_clk=
_get_from_provider
> > + oscillator                          0       0        0        2600000=
0    0          0     50000      Y   deviceless                      dev_cl=
k_get_from_provider
> >                                                                        =
                                     deviceless                      no_con=
nection_id
> > - secure_32k_fck                      0       1        0        32768  =
     0          0     50000      Y   deviceless                      of_clk=
_get_from_provider
> > + secure_32k_fck                      0       1        0        32768  =
     0          0     50000      Y   deviceless                      dev_cl=
k_get_from_provider
> >                                                                        =
                                     deviceless                      no_con=
nection_id
> > -    wdt1_fck                         0       0        0        32768  =
     0          0     50000      Y      deviceless                      of_=
clk_get_from_provider
> > +    wdt1_fck                         0       0        0        32768  =
     0          0     50000      Y      deviceless                      dev=
_clk_get_from_provider
> >                                                                        =
                                        deviceless                      no_=
connection_id
> >      gpt12_fck                        0       1        0        32768  =
     0          0     50000      Y      48304000.timer                  fck
> >                                                                        =
                                        48304000.target-module          fck
> > -                                                                      =
                                        deviceless                      of_=
clk_get_from_provider
> > +                                                                      =
                                        deviceless                      dev=
_clk_get_from_provider
> >                                                                        =
                                        deviceless                      no_=
connection_id
> > - dummy_ck                            0       0        0        0      =
     0          0     50000      Y   deviceless                      of_clk=
_get_from_provider
> > + dummy_ck                            0       0        0        0      =
     0          0     50000      Y   deviceless                      dev_cl=
k_get_from_provider
> >                                                                        =
                                     deviceless                      no_con=
nection_id
> >   mcbsp_clks                          0       5        0        0      =
     0          0     50000      Y   deviceless                      mcbsp_=
clks
> >                                                                        =
                                     deviceless                      mcbsp_=
clks =20
>=20
> Hmm, so the passed device is always NULL, and thus there is no point
> in making the change.
> Do you know if these come from the first or second change in my patch
> (I guess the second)?
>=20
=46rom the first change, The second piece is nowadys only used by the dm81*
devices.

I would prefer to have this tested on dm81* too.

Regards,
Andreas
