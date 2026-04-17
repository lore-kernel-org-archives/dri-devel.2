Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07188F436BD
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502CF10EA6E;
	Fri, 17 Apr 2026 16:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xkn3oK+0";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1040210EA6E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:40:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 695274E42A30;
 Fri, 17 Apr 2026 16:40:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2CC9060497;
 Fri, 17 Apr 2026 16:40:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 844F310460A9C; 
 Fri, 17 Apr 2026 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776444008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rx5tO6nrlgQSuT60zm34ASmO6RYlpPybCsbC4KvuVBA=;
 b=xkn3oK+0n9O+HsFqdjBSG3KBAIQFUyPzsT+ppKxB6VrMLv8S4a0o5VYpOCFfEej3prd+Cj
 ltWVcQlytqoaP2dFFAeMQhTck9HwvIg8AD4J9eLTvDA65VXrGI6Ek7lV0f3Qrea1FnPIwq
 Cp0LNxzVWbb4dHNgxXt1jZejbnpo3khU74ksAjpni9/dNCh14UMN86JubUZr/MUViSFc7Q
 IEWWhhIHb9BmGJ1d+54o5jjxLPv0lL9rUMPc3F3pQPr/KGUmtZH+UfOUsczNV/5JBNUaXN
 lmJbuBboXW+wv1v67usvDochaM63PnfZR+cwDfkuperolnKh+g+4VWgWoOZ4WA==
Date: Fri, 17 Apr 2026 18:40:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Jyri Sarha" <jsarha@ti.com>, "Russell King"
 <rmk+kernel@armlinux.org.uk>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Bajjuri Praneeth" <praneeth@ti.com>,
 "kernel test robot" <lkp@intel.com>, <thomas.petazzoni@bootlin.com>,
 "Russell King" <linux@armlinux.org.uk>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/bridge: tda998x: Use __be32 for audio port OF
 property pointer
Message-ID: <20260417184001.12dde35e@kmaincent-XPS-13-7390>
In-Reply-To: <DHVKE9YSS22L.27G2WXWHP0DGK@bootlin.com>
References: <20260417155545.1069280-1-kory.maincent@bootlin.com>
 <DHVKE9YSS22L.27G2WXWHP0DGK@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 17 Apr 2026 18:19:03 +0200
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> On Fri Apr 17, 2026 at 5:55 PM CEST, Kory Maincent wrote:
> > From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
> >
> > of_get_property() returns a pointer to big-endian (__be32) data, but =20
>=20
> Where is this stated? of_get_property() is declared as:
>=20
> | extern const void *of_get_property(const struct device_node *node,
> | 				const char *name,
> | 				int *lenp);
> (https://elixir.bootlin.com/linux/v7.0/source/include/linux/of.h#L365-L36=
7)
>=20
> I don't see __be32 mentioned there.

It is not stated in the declaration as we don't know the property type but =
OF
value are always in Big Endian.
And the value is converted later to u8 here:
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/bridge/tda998x=
_drv.c#L1719

Maybe my commit message is a bit inaccurate on this. I can rephrase it if
needed.

> > port_data in tda998x_get_audio_ports() was declared as const u32 *,
> > causing a sparse endianness type mismatch warning. Fix the declaration
> > to use const __be32 *.
> >
> > Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and a=
dd
> > audio DT binding") Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@intel.c=
om/ =20
>=20
> Wrong link?

No, it's just that I fixed the second sparse warnings reported by the kernel
test robot, but maybe quoting this link is wrong.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
