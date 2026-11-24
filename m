Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE3606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Y3peUFXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F4D10F67B;
	Tue, 24 Nov 2026 14:18:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB5910F67C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:18:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 04EDE1A17C3;
 Tue, 24 Nov 2026 14:18:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C3F97601E1;
 Tue, 24 Nov 2026 14:18:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2A9C11E680B3; Tue, 24 Nov 2026 15:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795529925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=46BX4oLS8fj8nv8LSmObDobgH5Uq6ZuRpVuuI9FlxbY=;
 b=Y3peUFXaf8Uyr482w/PrenOXIwd4bwsG9VtUekHP08HQq/4RjxY22vUm6F+m+rc0BHZ/g2
 jq5WbHnvFXtrDDPF/BlHbxXXoIaIlLfJLGBgpe53AiH6lBfZ0NN4ehivQcGGAAl3TGUbPL
 vT00lVaXOj6ZbXNno4bAhzLPhtMEzbZyDGJF0v/HFFfxgdrMyegwsfACWI1VRwM4OgL9db
 9DVDUwEWghc717rmgWmWNjg/rUM73bBUGtv0QN/3wQTBBb2AW7uUzmQG6nBIM/QWqn3gn9
 zOg6eaZ04h5yR/mmF6djOx2eb2CDEeM15VBgYZZulNPwwnCAc+lo5we5ImTj2Q==
From: Benjamin Robin <benjamin.robin@bootlin.com>
To: Abhash Kumar Jha <a-kumar2@ti.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 s-jain1@ti.com, y-d@ti.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, devarsht@ti.com,
 u-kumar1@ti.com, sjakhade@cadence.com
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Power on/off the PHY in
 probe/remove
Date: Tue, 24 Nov 2026 15:18:37 +0100
Message-ID: <sHjduanPT-iixJKPff7sVg@bootlin.com>
In-Reply-To: <df69d165-3750-4b64-b458-a2be7a3ca0e1@ideasonboard.com>
References: <20261124101747.2432344-1-a-kumar2@ti.com>
 <GrHOVCfQTneYbXFLczyyAA@bootlin.com>
 <df69d165-3750-4b64-b458-a2be7a3ca0e1@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

On Tuesday, November 24, 2026 at 2:26=E2=80=AFPM, Tomi Valkeinen wrote:

> >> However, I fear there's something wrong with the torrent driver itself.
> >> I didn't study it carefully, but looks like it supports bootloader
> >> enabled PHY, and it then sets 'already_configured' field. When that's
> >> set, all these calls, and dp_configuration() are ignored. And that fie=
ld
> >> is only cleared on system suspend hook. So it looks quite broken, if t=
he
> >> PHY is enabled when the torrent driver probes, the DP driver can't
> >> configure it at all. Blanking the display or even unloading/loading the
> >> DP driver does not affect it.
> >=20
> > Hello Abhash,
>=20
> It wasn't Abhash.

Oups, sorry. Hello Tomi.

> > I am currently rewriting the torrent driver in order to fix various iss=
ues.
> > But I am not sure to fully understand what you mean by
> >=20
> >> if the PHY is enabled when the torrent driver probes
> >=20
> > This is not possible. The DP PHY is only available at the end of the pr=
obe
> > of the torrent PHY. So maybe I am missing something, could you clarify =
by
> > what you mean by that. But yes this flag 'already_configured' is quite
> > dangerous since it assume that all the registers are properly configured
> > by the bootloader.
>=20
> I meant that if the DP PHY hardware is enabled (so was enabled by the=20
> bootloader) when the torrent driver probes, 'already_configured' will be=
=20
> set by the driver, and then when the MHDP driver later probes, MHDP=20
> driver won't be able to configure the PHY at all.
>=20
> But all I did was a quick read, feel free to correct me =3D).

No, you're right. I'm not sure why, but I was convinced otherwise.
I=E2=80=99ll add this to the list of points to be corrected.

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



