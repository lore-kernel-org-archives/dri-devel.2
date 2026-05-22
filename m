Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C5CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EB810E0E5;
	Fri, 22 May 2026 14:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="QEkAkXx2";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B5A10E0E5
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779458514; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q0Y/svwWAd+ggRmWr8LCZTd3loLeTMTkUjBEdJIf3FayZzKew7Ax69N0hdmtyPgG30gNU6fYdf4T0cFyrCP1lFeANeKYYYs0z1sP9RBTIP2eGBhS+w6qYDIIcf/N3JjzN1SAwtR/aZ5vTipkoi0vtG0lq0LdoRBn4vtRjCEuQ68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779458514;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TFHf1mGctGoWT15eiWVxkvOGfYDzj1F3wi6YahWto9Y=; 
 b=azSjWygn2n3R8eGV0cLiFJyjKZjW33lYkB5Tj10vgUoUPiwJe/+X5a6YBJBVcX2aBkJVh3LQUHq9HaIX7CHhLak8ce5Widko7tHVYv5DJ3/KafQF2epktLKE0ngjA3XxEWIm4Ky84tGiUJAYSBSwScVeQ4anxDgo2+LKYqYCFy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779458514; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=TFHf1mGctGoWT15eiWVxkvOGfYDzj1F3wi6YahWto9Y=;
 b=QEkAkXx21nvlBbNvooADccjpx5DKAlEwUqkOwNLkfmqusR32TDWQ53vUG22dfvgk
 637WYSMTIN2PVPNxDNYSSp8Uf5ZnbMLFdOTEmbnrvI+UkV86/BzILM7kUFJpoz/Pj1R
 /OY1g0Gy3kCpW4NEaF9EPUwmlQRIebtrbyJq3H8eZCoMv8OgM12xDjW6c+6OsrvDTzW
 epfMMIKMbYUM7nUXVZcRv7y53NvxOT99AWct4AMtxjqx++2cW9kyhaJojvKM8q7w2qu
 ATI1NaRTxvqOwhYoauHX6KXDwtWgIHiGJ7N03BBm9yjX1htd1QJYK8iBBM5J+SjUECu
 JK3/6Zy/dw==
Received: by mx.zohomail.com with SMTPS id 1779458511972208.347943517541;
 Fri, 22 May 2026 07:01:51 -0700 (PDT)
Message-ID: <3219f779c2f3bd17348a70d6c8278b1b1ab317d1.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Thomas Zimmermann <tzimmermann@suse.de>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Fri, 22 May 2026 22:01:43 +0800
In-Reply-To: <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de> <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

=E5=9C=A8 2026-05-22=E4=BA=94=E7=9A=84 15:43 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 22.05.26 um 15:28 schrieb Ville Syrj=C3=A4l=C3=A4:
> [...]
> > > > > But why does your HW use CRTC 1 in the first place.
> > > > Could be eg. the enabled outputs can't be driven with CRTC 0.

Yes, for many embedded display solutions the CRTC-connector map is
totally fixed.

> > > >=20
> > > > I guess what you want to do is pick the first crtc from
> > > > modesets[]
> > > > which is enabled. Or perhaps even "pick the Nth enabled crtc
> > > > from
> > > > modesets[] based on the ioctl argument".
> > > The enable-status of each CRTC could change later on, which might
> > > lead
> > > to problems.
> > Sound like a locking issue if someone is changing the configuration
> > at the same time we're trying to do the vblank wait here.
>=20
> I mean that the connected outputs could change at a later point or we
> could have multiple CRTCs in use. Today, someone in #intel-gfx
> reported=20
> a problem with panning if multiple CRTCs are in use.
>=20
> Therefore picking a CRTC freely could be a problem. Let's say we=20
> configure modes from one CRTC, but later wait/pan/flush with another=20
> CRTC. I would not trust this to work correctly.
>=20
> Hence, my suggestion is to select a primary CRTC during the fbdev=20
> client's probe and use it for all later operations until the next
> probe=20
> happens.=C2=A0 All other CRTCs would mirror the primary one.

What will happen if the "primary CRTC" is then disabled because of no
connected connectors can be driven with it?

Thanks,
Icenowy

>=20
> Best regards
> Thomas
>=20
>=20
> >=20
> > > Picking the one CRTC/output with the lowest spec and
> > > mirroring it to the others might work. This CRTC would then be
> > > the one
> > > to wait for.
> > >=20
> > > Best regards
> > > Thomas
> > >=20
> > > --=20
> > > --
> > > Thomas Zimmermann
> > > Graphics Driver Developer
> > > SUSE Software Solutions Germany GmbH
> > > Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> > > GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809,
> > > AG N=C3=BCrnberg)
> > >=20
