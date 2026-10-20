Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C6606A325
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=jWTWioPH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42A410EBF2;
	Tue, 20 Oct 2026 14:01:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3FD10EBF2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=0bUQjAy/+HgHeFngLeIpJDoghjVcttx7fZ4ozEEqOMw=; b=jWTWioPHjWdtEUPywVH7ZhPBhh
 AHxvaOS9uxIQLdfJk/KzSgO4X6c72R5uHznY2428ow6HPgYOmA3eN1SSBNitSgthcvxjHWNN3wLwr
 rLM2159dqLgwBTJ2eT5KwoaQ3F4r8zZpFgQ0H0k2IFz0dAZkQoyKapydj3v5tq6S5E4c/TX2ddR7M
 yMa9vKjnt1xlxnD+NLj/k5XORRKcnrivhfchTpgqHWQGVhZyHCdbbf0m/NTVx6Hj26CjBqTrh1PY9
 98zFZx0ZDtzeVWjlwHFoa9MfrpN8/LJ+ha2e6PAovaOD041UjzNcGwh6cKhhCpEJRURfFoFng+6Dx
 LYDI9w1g==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Igor Paunovic <royalnet026@gmail.com>,
 Jan =?UTF-8?B?Q2xhdcOfZW4=?= <jan.claussen10@web.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Maxime Ripard <mripard@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Diederik de Haas <diederik@cknow-tech.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
Date: Tue, 20 Oct 2026 16:01:11 +0200
Message-ID: <2318151.NgBsaNRSFp@diego>
In-Reply-To: <2070944.yKVeVyVuyW@diego>
References: <20260805153416.8459-1-royalnet026@gmail.com>
 <20260909112543.6913-1-royalnet026@gmail.com> <2070944.yKVeVyVuyW@diego>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 20. Oktober 2026, 15:59:18 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Heiko St=C3=BCbner:
> Hey Igor,
>=20
> Am Mittwoch, 9. September 2026, 13:25:40 Mitteleurop=C3=A4ische Sommerzei=
t schrieb Igor Paunovic:
> > Gentle ping on this one - it has been a month without review.
> >=20
> > I re-checked it today rather than assuming: it still applies cleanly on
> > drm-misc-next (8ce26b09f652), with no offset and no fuzz, and nothing
> > merged since attaches the Colorspace property for this connector. So the
> > gap is still there: without it KWin reports the outputs as "HDR:
> > incapable" on RK3588 even though the sinks and the rest of the kernel
> > side are ready.
> >=20
> > The patch is independent of Cristian's dw-hdmi-qp HDMI 2.0 series; that
> > series is not in drm-misc-next yet, and when it lands its patch 34 will
> > touch the first context line of my hunk, so I will rebase and resend as
> > v3 at that point. The change itself does not overlap with it.
> >=20
> > Happy to respin if you would rather have it on top of that series.
>=20
> yes, the hdmi2.0 series landed meanwhile.
>=20
> But there is also=20
>     https://lore.kernel.org/dri-devel/20261018143135.5745-3-jan.claussen1=
0@web.de/
>=20
> which does way more to that colorspace thing, especially doing something
> into the direction of HDR support it seems.
>=20
> So really no clue how that all is supposed to work ;-)

and of course there is also your HDR'ish-series in
	https://lore.kernel.org/dri-devel/20260808095749.9428-1-royalnet026@gmail.=
com/

way confusing.


