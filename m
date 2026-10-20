Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492A606A339
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=NuocaDcd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9598410EBD8;
	Tue, 20 Oct 2026 13:59:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A8610EBD8
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=gi9h6MhKLI+8CbZxDZaO/TkusHfcYIiLvinII2k5EJA=; b=NuocaDcd6ItZMuXVkkKB8/vP/H
 9BR5Hz8P935IaaKjf1JUXV+rAOXRDTG9QztLvd5me3zro4yZsI0aWjutCK/HRrUTs37Xct/Iz4v9J
 MaqhSE8hsY4cBEw7iumXb5RVieP0cbPmYke5i1pFqbIGLR/9zBb6wxKIJOV2l+k1k7Jj6OxHc1zpH
 +khB7ofuq9HsL9nYI3AUgXJgda4lmnRdP3BXvea+p5bu8+GH/N4t6IIe2YC6R94h5x+iJEivNwqlV
 jK5xd+yEzhYmP/HM6B5U7dWW2dvyEdYXkVJg4iimA/B4qot60MUqs7hj/vNwnW/JS5wBKlItSnQWS
 NJLJp9eg==;
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
Date: Tue, 20 Oct 2026 15:59:18 +0200
Message-ID: <2070944.yKVeVyVuyW@diego>
In-Reply-To: <20260909112543.6913-1-royalnet026@gmail.com>
References: <20260805153416.8459-1-royalnet026@gmail.com>
 <20260909112543.6913-1-royalnet026@gmail.com>
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

Hey Igor,

Am Mittwoch, 9. September 2026, 13:25:40 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Igor Paunovic:
> Gentle ping on this one - it has been a month without review.
>=20
> I re-checked it today rather than assuming: it still applies cleanly on
> drm-misc-next (8ce26b09f652), with no offset and no fuzz, and nothing
> merged since attaches the Colorspace property for this connector. So the
> gap is still there: without it KWin reports the outputs as "HDR:
> incapable" on RK3588 even though the sinks and the rest of the kernel
> side are ready.
>=20
> The patch is independent of Cristian's dw-hdmi-qp HDMI 2.0 series; that
> series is not in drm-misc-next yet, and when it lands its patch 34 will
> touch the first context line of my hunk, so I will rebase and resend as
> v3 at that point. The change itself does not overlap with it.
>=20
> Happy to respin if you would rather have it on top of that series.

yes, the hdmi2.0 series landed meanwhile.

But there is also=20
    https://lore.kernel.org/dri-devel/20261018143135.5745-3-jan.claussen10@=
web.de/

which does way more to that colorspace thing, especially doing something
into the direction of HDR support it seems.

So really no clue how that all is supposed to work ;-)


Heiko


