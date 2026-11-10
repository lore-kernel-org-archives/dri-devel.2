Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322F606A337
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827A210E1C1;
	Tue, 10 Nov 2026 17:05:14 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89DE10E1C1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:05:12 +0000 (UTC)
Message-ID: <c763b6e7f130d329242c098807957c4c88ca2262.camel@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: Allocate and register the internal bridge
 separately
From: Paul Cercueil <paul@crapouillou.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, 
 "H. Nikolaus Schaller"	 <hns@goldelico.com>, Paul Boddie
 <paul@boddie.org.uk>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,  "open
 list:INGENIC JZ47xx SoCs"	 <linux-mips@vger.kernel.org>, "open list:DRM
 DRIVERS"	 <dri-devel@lists.freedesktop.org>
Date: Tue, 10 Nov 2026 18:05:07 +0100
In-Reply-To: <avMt5CTevTANpXqO@houat>
References: <20261105203517.2293404-1-f.fainelli@gmail.com>
 <fb84cd36838875ccd2530b9e3983700fbd23eb3c.camel@crapouillou.net>
 <avMt5CTevTANpXqO@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

Le mardi 10 novembre 2026 =C3=A0 15:45 +0100, Maxime Ripard a =C3=A9crit=C2=
=A0:
> On Mon, Nov 09, 2026 at 08:46:40PM +0100, Paul Cercueil wrote:
> > Hi,
> >=20
> > Le jeudi 05 novembre 2026 =C3=A0 12:35 -0800, Florian Fainelli a =C3=A9=
crit=C2=A0:
> > > The LCD controller's internal bridge is embedded in an object
> > > allocated
> > > with drmm_encoder_alloc(). This initializes the encoder but leaves
> > > the
> > > bridge's reference count at zero. Since drm_bridge_attach() takes a
> > > reference, probing the CI20 display produces addition-on-zero and
> > > underflow warnings and fails to attach the HDMI bridge chain.
> > >=20
> > > Allocate the internal bridge with devm_drm_bridge_alloc() and
> > > register
> > > it with devm_drm_bridge_add() before attaching it. Keep the encoder
> > > in a
> > > separate DRM-managed allocation: encoder cleanup can drop the final
> > > bridge reference before it has finished accessing the encoder. Find
> > > the internal bridge through the encoder's bridge chain during mode
> > > setting, and use the bridge argument directly in bridge callbacks.
> > >=20
> > > Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in
> > > drm_bridge_attach/detach()")
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >=20
> > Looks like I lost my commit rights to drm-misc-next, I guess for
> > inactivity.
> >=20
> > So I'll ack it (LGTM) and let someone else (Maxime?) commit it.
>=20
> I just checked, your account still have access to drm-misc, and the last
> activity was yesterday.
>=20
> Did you lose access to that account?

I connected to gitlab.freedesktop.org yesterday, that was me.

I get a "denied publickey" when trying to sync the branch with dim, which i=
s
weird because my SSH public key set on gitlab is the correct one.

Cheers,
-Paul
