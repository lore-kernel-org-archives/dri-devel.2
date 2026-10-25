Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D67606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=puri.sm header.i=@puri.sm header.a=rsa-sha256 header.s=smtp2 header.b=imsWa+T3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB72E10E762;
	Sun, 25 Oct 2026 07:04:23 +0000 (UTC)
X-Greylist: delayed 540 seconds by postgrey-1.36 at gabe;
 Sun, 25 Oct 2026 07:04:16 UTC
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5DA10E762
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
 t=1792911314; bh=w71AOpYV4KpXNAjp5dKcP/PzJQbMMVW/4xVNb5ORZE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=imsWa+T3NwRKj8oDtY5T56XNFve2MS+TUd02sJYs5aeVoSrQDQy4zZ8UUbXRqWOB9
 kmBbKYJcREts1A6Ub3FykMs/zZT4RbOkFz3rF4f9nhxEDKGZgG6JzwQf8rfVHwqjiV
 feInWMkQ6iXChh8Qi2JJLmsXORXxEo1ELGeco6LaXPdtM501mq/ED6rBJtQQ7/LbJB
 HLS9qTS387y90wDm4ti1z28sy72ZCOt+3XXeaTukVOzdnJVQFpgsFSkdLQBg9raZNm
 XyynV6FouwPU7AU8okfXdkmzdCr3uwHaTKxsJfqHcJZqWa9QikBh/3lO31Z2ExhLvR
 6PvDQvTS62Unw==
Received: from pliszka.localnet (83.24.9.32.ipv4.supernova.orange.pl
 [83.24.9.32]) by ms.puri.sm (Postfix) with ESMTPSA id 1F7131F6F8;
 Sat, 24 Oct 2026 23:55:13 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>,
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Subject: Re: [PATCH RESEND v4 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI
 horizontal sync timing
Date: Sun, 25 Oct 2026 07:55:10 +0100
Message-ID: <DCOT4twKSTiyzo8_8SFRJQ@puri.sm>
In-Reply-To: <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On =C5=9Broda, 14 pa=C5=BAdziernika 2026 09:44:45 czas =C5=9Brodkowoeuropej=
ski standardowy=20
Esben Haabendal wrote:
> The NWL MIPI Host controller registers specifies the horizontal front
> porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
> not in pixel clocks).
>=20
> The calculation for this is (mostly) described in section 13.6.3.5.1.2 of
> the i.MX 8M Dual/8M QuadLite/8M Quad Applications Processors Reference
> Manual (rev. 3.1). The formula shown there does not take packet header si=
ze
> into account though.
>=20
> The formula implemented here converts the hfp, hsa, and hbp to DSI packet
> bytes and then subtracts the number of packet header bytes.
>=20
> It is worth noting that these values only needs to match approximately,
> according to the reference manual.
>=20
> Based on commit in NXP vendor tree
> commit f2a61699749d ("LF-7981-4: drm/bridge: nwl-dsi: Correct MIPI DSI
> horizontal sync timing")
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>

This lets the Librem 5 screen be driven without additional timing hacks.

Tested-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>


