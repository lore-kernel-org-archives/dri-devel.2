Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD7C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E1310F067;
	Thu,  6 Aug 2026 00:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Eyt4aTfq";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B97410F067
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785977607; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Jpedgj2Xv0w84RfTWOIEKEHDoQN726jvzIoC7FRHpg1n1cVUXLz15UT7uWK7I5AgCTt9QNTSR8S331aHM5uQMBP30EL5jjWYZYGKyALvCL2paqaPKS93OhTcU6h7Vj8WaqPG/XFHuntSVVOKbYnrFWESC0Da8cv8wvPI09Mxyik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785977607;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Y0o5aZmeUQ3l4Gcb28XZnKWO7jZtMVtIm69gJCsBCVM=; 
 b=iW6fO6pwOh4le/9HJDTe5y5ExvVnyH0aKadvfwRlU3DPlnBmECkMGQmyXsSVp4+uya+I3V/lqRkxY5RZOB1b4aT9rIXi+HjwLnIGjXHP74DApC5XaKGeA5tu3FEzEwktMIPZaBFIK91d6yh8Cyvf1hFQtvpzkP6fWSE7gbf4sYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785977607; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Y0o5aZmeUQ3l4Gcb28XZnKWO7jZtMVtIm69gJCsBCVM=;
 b=Eyt4aTfqq7B+CMdd/U3d8TCdoewcgR8RBWNW8r/+0Uy8D4MMHrsYiXu93a9f9z7p
 CG52LcW5KGFMROXNor2zgMoHRHR5eKsnUQ9MX+5bcqjg+gzTamiLB5AVvLG/W/aAdif
 0jbGZlcU/JNbUWELSr9VzFzDV609QOBtrQHihNhg=
Received: by mx.zohomail.com with SMTPS id 1785977605537152.33915577818743;
 Wed, 5 Aug 2026 17:53:25 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id F24E2180597; Thu, 06 Aug 2026 02:53:21 +0200 (CEST)
Date: Thu, 6 Aug 2026 02:53:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH v9 00/22] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
Message-ID: <anPXvyL4sBjANnhm@venus>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260804135641.17170-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lgiluf6bs5svv24h"
Content-Disposition: inline
In-Reply-To: <20260804135641.17170-1-royalnet026@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.956.17
X-ZohoMailClient: External
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


--lgiluf6bs5svv24h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 00/22] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
MIME-Version: 1.0

Hello Igor,

On Tue, Aug 04, 2026 at 03:56:40PM +0200, Igor Paunovic wrote:
> You wrote in the cover letter that parts of this are untested, and asked =
for
> comments on the out-of-band hotplug callback.  I have been running this s=
eries
> on real hardware, so here is a report from the USB-C DP AltMode side.
>=20
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, Orange Pi 5 Pl=
us, USB-C DP AltMode

Thanks. I've just send v10. I expect this to still work, but since
quite some patches changed I did not carry this over.

> Hardware and base
> -----------------
>=20
>   Board:  Orange Pi 5 Plus (RK3588)
>   Kernel: v7.2-rc6 + rockchip-devel, pinned at 8c70065a3207, which carries
>           this series at v9 - including 03/22 "Fix error handling in
>           dw_dp_link_enable()", so this is v9 and not an earlier respin.
>           No local changes on top of any dw-dp patch.
>   PHY:    your rockchip-usbdp v13 series, from the same branch
>   Sink:   4K120-capable display, reached both directly and through a USB-C
>           dock, DP AltMode over the Type-C port
>=20
> Results
> -------
>=20
> USB-C DP AltMode works.  I get 4K120 on the Type-C output, which on this =
board
> is a third display output that mainline does not otherwise light up at al=
l.
> The mode comes up at dclk 594 MHz, which is what 4:2:0 should give at that
> resolution (two pixels per clock), and it survives a live modeset - I can=
 go
> from 60 Hz to 120 Hz on a running desktop without unplugging the cable and
> without dropping to a black screen.
>=20
> That last part is the change I want to highlight.  On my previous kernel,=
 based
> on v7.0 without this series and without the usbdp rework, touching the ca=
ble
> while the link was up was something I had to actively avoid, and a live 6=
0->120
> modeset gave me a black screen that needed a hard reset to recover from. =
 Both
> of those are gone here.  Whatever the combination of the follow-up bridge=
 work
> and the PHY re-init on orientation change is doing, from where I sit it i=
s the
> difference between "usable" and "do not touch".
>=20
> I have not exercised the DP audio path (22/22) yet, and I have no board w=
ith a
> native DP connector or an HDMI bridge downstream, so I cannot say anything
> about the code path you flagged as untested.

heh, that's the most interesting ones regarding testing as I haven't
tested the related paths in the driver. USB-C AltMode should be more
or less the same on all RK3588/RK3576 boards.

> On the out-of-band HPD callback
> -------------------------------
>=20
> You asked for comments, and I have a data point rather than a design opin=
ion.
>=20
> On this board the AUX channel is dead at boot until something kicks the T=
ype-C
> port controller.  The cause is on the firmware side rather than yours: the
> board boots through EDK2, which has no TCPM, so it hands Linux a PHY that=
 was
> never brought into a sane state and a port controller that has never
> negotiated.  Nothing on the DP side can discover the sink until fusb302 is
> poked, after which the link comes up normally and stays up.

That's needs to happen anyways independent of the boot process,
since USB-C can be hot-plugged :)

> I mention it because it is exactly the shape of event your callback is fo=
r: the
> hotplug information arrives from outside the DP block, late, and the DP s=
ide had
> no way of knowing.  A separate callback rather than reusing hotplug_notif=
y seems
> right to me for that reason - the two really are different sources, and o=
nly one
> of them is something the DP block could ever have observed itself.  I can=
not
> tell you whether there is a cleaner mechanism, but I can tell you that the
> separation matches how the hardware actually behaves here.

I'm well aware how the hardware works. That does not necessarily
require a separate notifier, though. But the existing one does not
work anyways as it does not distinguish the information source. That
could be changed of course (but with quite some churn involved).

> One neighbouring finding
> ------------------------
>=20
> While bringing this up I hit a bug that is not in your series but sits ri=
ght
> next to it, so it may be useful to you and to Cristian.
>=20
> On RK3588, VP2's dclk was parented to the HDMI PHY clock.  When the HDMI =
PHY is
> not powered - which is the normal case if you are only driving the Type-C
> output - that parent is dead, and DP gets no usable pixel clock: nothing =
above
> 640x480 comes up.  Re-parenting VP2's dclk to V0PLL in DT fixes it, and t=
hat is
> what the 4K120 above is running on.
>=20
> I see Cristian's "Consolidate HDMI PHY PLL clock parent switch" (v3 09/14=
 of the
> DW HDMI QP YUV series) touches the same parent-switch logic from the driv=
er
> side.  I have not yet worked out whether that series makes the DT change
> unnecessary, or whether the two are complementary.  I will work that out =
before
> I send anything, but I would rather flag it here than have two people dis=
cover
> it separately.
>=20
> Happy to run any specific case you want covered, or to retest on later
> revisions.

Thanks.

> Thanks for the series - it turns a port that did nothing on mainline into=
 my
> main display output.

Great. It's obviously too late for 7.3 now, but I hope to get all of
this upstream in 7.4. It would be a nice start into 2027 :)

Greetings,

-- Sebastian

--lgiluf6bs5svv24h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpz2vYACgkQ2O7X88g7
+poa8g//V4lZXwFrUKn9W7pvGSKRbQKP4TMFkSKNnWNhOvBYSj9Lzsv9q/hhiVUZ
lQFGT6wK56WTj1SdcWNxI59e0orTSGSea6gYdMX5BIB6erEkA5NA7QqAKaBc7Pce
c2I94QDQ20waF3m6YUGdTHh6uBScK8PKtBcK80VYp0+CejhFIYj03aDkzGp6KGVF
sb+/QSZCfEVSAATdBfWV7UqBqh4jXov+sC3zewDfEYXqY3wg0B9/PSklujUCCECF
/aND5jg1s+vMqzxb7silXU0rJu5t5k8s4CU1ABtOc0KCKRuMHwif4yWeOlfcaSnJ
UL1bBqcUW50r2dFxhJsmcySL9ORVUX770vnUTRmJBHxF5k/LNavI9cK1yKKlTmuO
xfBwR8pJNh6ERdlcYqSsTUjvCdtbtVJUf4c+sagpg3tFX+zgxv2WXi5opJKZl7wc
uSSUvLrDlvRwEoqAle8BdV2Tu0n8CwbDA4EiE1xUIZh17GjI1FER44D+0Uq/Dw7V
IJjHoM7ek07RSBBwW9f8UGI4wMLrOGG78Fx50Fl+qOsuH19I9siKv2IaIqwRdudU
dZ36Vb1extrrNz1yhWmpub7onTCWs+1Cw/X5RSbR8+kFw+w30r3gKDiUo0+gkQOb
P4SFuJEmfglBS3UCQFTsuBVP9VnE2JsO4VQTcymOHRwEUf+QgLQ=
=FbcJ
-----END PGP SIGNATURE-----

--lgiluf6bs5svv24h--
