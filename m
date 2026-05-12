Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB70BCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0C510E2AC;
	Tue, 12 May 2026 17:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dx/RlZ20";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FE710E2AC
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:11:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BBC53408FF;
 Tue, 12 May 2026 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B3FC2BCB0;
 Tue, 12 May 2026 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778605893;
 bh=PM7Hsk7rCZ7i7ss0DWokkdpyP/aaxTsbqAbCbIJEgO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dx/RlZ20DHNQSDtLHsoojSgNx5+PmGzfx6uY+qJpWhuz9d4XDZqu1YIQcpSCyyxjs
 4akB56wGOcega4tbyEQ1CNnW/foikCpjYjj5hNglKjM6d/QRS0aMHioQMpyJtSrz/r
 8K3W7/VJBIIpVjq6MoN/e+J1UcvE4GetAimajeSBYCHa4+uQBUwunbD+4Q6DDfYLYR
 i1FeJFd+DnPmJ3KXturPPx5uRUAPrkGX7U1114grF1oHAFZmcktaMXNz/GjZdFPQeb
 33jEyLQatlsAtya1GEtTpoxhay1gozyGmDqRZukaVKxXhihm4ForjIdaPg307qba8m
 4fvM5Ftlo9Xng==
Date: Tue, 12 May 2026 18:11:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: display: rockchip: analogix-dp:
 Add per-clock descriptions
Message-ID: <20260512-unmoral-jacket-265a50cb4ea8@spud>
References: <20260512095644.1946084-1-damon.ding@rock-chips.com>
 <20260512095644.1946084-3-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xz/8nfi28M2rs0iV"
Content-Disposition: inline
In-Reply-To: <20260512095644.1946084-3-damon.ding@rock-chips.com>
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


--xz/8nfi28M2rs0iV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--xz/8nfi28M2rs0iV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNfPgAKCRB4tDGHoIJi
0sU8AP4vxmovvT1OpZFfAxAwr95num10Rou4WT2dmzmv35Q8YwD/ZdnsttL9jh2J
o7mrpvcV9tKvqbzCroKr/tILpzRIHAY=
=kWPn
-----END PGP SIGNATURE-----

--xz/8nfi28M2rs0iV--
