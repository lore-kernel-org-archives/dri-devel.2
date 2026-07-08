Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F3DC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36D410EFF3;
	Wed,  8 Jul 2026 06:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dgGWqRG1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA54D10EFF3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:54:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 110546001D;
 Wed,  8 Jul 2026 06:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D401F00A3A;
 Wed,  8 Jul 2026 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783493657;
 bh=/OWAtOOvX1V+EJx3D6dsYzPRv62GbTzz4nU3E38ft20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dgGWqRG11B65pwO37tuqv0PjfjoeKlIftYJZNrtDc8+mFCOpEDrxLXvRWXdcEzU+Z
 FR+bPXWkNuWDd6xXnh3wNQcg633kbbZpezKBkTF+D9H1myBtxv6HGxDhVGlgKxKfxr
 QgBFSWtSKssLVsbuuR9jqi0fx5rrH9QMsuPeFCnQ3UK00fll9uh0Os5j3k6t9idk8A
 TKTgPth+zRCtX84HSIKKYrf34DhrDwwSvKDafI18oMQ7VBQ0UCg9BQAC6syUPJrccw
 vp6Lt6RRBaLj2jc9elfnDzgORYq63nkPshm5jeORMs4+L4kNAZCL8WT7MsRAmsfJ+E
 JxdnxkVuBqcbg==
Date: Wed, 8 Jul 2026 08:54:12 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach
 instead of probe
Message-ID: <20260708-fresh-malamute-of-resistance-eeded4@houat>
References: <20260707084655.2206320-1-paul.geurts@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cjk2dvz4remg5vm4"
Content-Disposition: inline
In-Reply-To: <20260707084655.2206320-1-paul.geurts@prodrive-technologies.com>
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


--cjk2dvz4remg5vm4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach
 instead of probe
MIME-Version: 1.0

Hi,x

On Tue, Jul 07, 2026 at 10:46:55AM +0200, Paul Geurts wrote:
> When connecting the sn65dsi83 device to the Samsung MIPI DSI host
> controller found in i.MX8M Mini, probing the host and device
> infinitely defers, waiting for each other to appear. on probe of the
> host, it tries to attach to the device, which has not been probed yet.
> It therefore does not register the host, and defers. When the sn65dsi83
> probes, it tries to attach to the host, which is not registered as it is
> deferred, and thereofore it defers as well, without registering. This
> means the two drivers are infinetely waiting for each other to appear.
> This is the case on the Samsung MIPI DSI host controller, but might be
> the case with other host controllers as well.
>=20
> Only register the sn65dsi83 on probe, and attach to the host later. This
> means the host has a bridge to attache to in probe. When the host
> attaches to the bridge, the bridge can attach to the host, breaking the
> infinite defer.
>=20
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> Fixes: 6ef7ee48765f ("drm/bridge: sn65dsi83: Register and attach our DSI =
device at probe")

I think the problem is actually that DSIM doesn't attach the bridge in
its MIPI-DSI host attach hook, as documented here:

https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#special-car=
e-with-mipi-dsi-bridges

If it doesn't fix the issue either, we should revise the doc further.

Maxime

--cjk2dvz4remg5vm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCak30FAAKCRAnX84Zoj2+
dqYlAX9rDtQpZ/1WFOWPd7JSRNmF0wCB0VJKeDHuds0whhL7C/vSBx80fb3P8qoU
QOWfk1wBfi6maUp3qdHJLT7pFyGWHozTdk7jjaYyqmvl/yps7pXthAEfzvcwsbuE
sdBA3BjZBA==
=DeEi
-----END PGP SIGNATURE-----

--cjk2dvz4remg5vm4--
