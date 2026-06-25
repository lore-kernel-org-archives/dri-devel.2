Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D6FCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D2D910F32C;
	Thu, 25 Jun 2026 16:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZVSyqXmS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C291910E22A
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B631600AE;
 Thu, 25 Jun 2026 16:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40571F000E9;
 Thu, 25 Jun 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782404352;
 bh=cwlz6DXkJh5bTDTJuqHu3tOZMgpskrhak8DTNmeTZck=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZVSyqXmS+SvYPCpfX0888NpFXWd/Z/firFR26nZHuHnwFm/gO9LHpWrJwbqYOoiPM
 mJNOvxZCDiovETPJkDI9sWeulbeBsbIJBqLy3YSUph9MDEvks4S5ty7w80yzoI58DF
 eBZ29Wsp/MWAQfRF/f75SZYgkLUWMRp4qJP4R6zRnKupTKRLtSfmf2FmlRYP9SuBig
 BXozySGkP+rChKJZ0vK4DaAQtKqqoiwlKQ5VWUqXZ40CODNX1eElWUAZpI9CAYEVVN
 PlQiHs6475iNZ02R0P8MNXRWI/mfcIN1ulMRXOGJ0QJGyae94hJ8zQCsm7aDtiu+89
 PLuS0bSc/LWNg==
Date: Thu, 25 Jun 2026 18:19:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Daniel Stone <daniel@fooishbar.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v6 0/4] Add SCDC information to connector debugfs
Message-ID: <20260625-tangerine-vicugna-of-purring-e95ce3@houat>
References: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
 <5DBSVhedT12K_nGj0amyCw@collabora.com>
 <20260615-mature-frog-of-certainty-d05f99@houat>
 <GWBGXfaiTF64ibliB2zCRg@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="yijabvvzevni7pdb"
Content-Disposition: inline
In-Reply-To: <GWBGXfaiTF64ibliB2zCRg@collabora.com>
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


--yijabvvzevni7pdb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/4] Add SCDC information to connector debugfs
MIME-Version: 1.0

Hi,

On Tue, Jun 16, 2026 at 02:04:13PM +0200, Nicolas Frattaroli wrote:
> On Monday, 15 June 2026 18:33:11 Central European Summer Time Maxime Ripa=
rd wrote:
> > On Mon, Jun 15, 2026 at 10:07:02AM +0200, Nicolas Frattaroli wrote:
> > > On Saturday, 13 June 2026 08:57:29 Central European Summer Time Hans =
Verkuil wrote:
> > > > Hi Nicolas,
> > > >=20
> > > > On 11/06/2026 14:57, Nicolas Frattaroli wrote:
> > > > > HDMI uses the DDC I2C bus for communicating various bits of link =
status
> > > > > out of band with the actual HDMI video signal. This information c=
an be
> > > > > useful for debugging issues like questionable cables sabotaged by=
 feline
> > > > > teeth, Enthusiast Grade cables made of cow fencing wire, and othe=
r such
> > > > > problems that ruin one's media viewing plans.
> > > > >=20
> > > > > Consequently, this series exposes various bits of pertinent infor=
mation
> > > > > from the SCDC protocol in an HDMI connector's debugfs. To continu=
ally
> > > > > poll the link status, userspace can poll the debugfs file.
> > > >=20
> > > > Something is not quite right: I've been testing this series with my=
 i915
> > > > based laptop with HDMI connector, and I never see the scdc_status f=
ile.
> > > > And that's because CONFIG_DRM_BRIDGE_CONNECTOR is not set for my co=
nfiguration.
> > >=20
> > > That's to be expected. i915 does not use bridge connectors, and neith=
er
> > > does amdgpu iirc. I am working on embedded boards that do use bridge
> > > connectors, along with all the rest of the HDMI state helpers.
> > >=20
> > > Implementing something new in DRM usually involves having to triplica=
te
> > > certain parts of the work in order to have i915 and amdgpu behave the
> > > same as everyone else.
> > >=20
> > > > So I think you are creating the debugfs entry in the wrong place.
> > >=20
> > > I can't create it for all drm_connectors as Maxime suggested due to t=
he
> > > cyclical dependency that would create. If someone has any idea on how
> > > to break that dependency cycle, I'm open to suggestions.
> >=20
> > Back when we introduce the audio support, we floated the idea to
> > de-midlayer this and turn it into a debugfs_init helper. We don't have a
> > lot of users yet so it might be the best time to do so, and would solve
> > your issue.
>=20
> I agree and will be happy to do that. I need some more concrete info
> though on what "de-midlayer" means here. From what I can tell, the
> core problem is that drm_connector.c directly calls into
> drm_debugfs_connector_add of drm_debugfs.c, which if it did also
> do a direct call into drm_scdc_helper.c would mean drm_scdc_helper.c
> needs drm_connector.c but drm_connector.c needs drm_scdc_helper.c.
>=20
> So I guess the de-midlayer and turn it into helper part is that
> drm_connector does an indirect call to a function pointer instead,
> which is default-filled at runtime with the helper debugfs_init
> function? I don't know if we can then do this by default for all
> drivers in drm_connector.c or if it needs to be done per-driver
> like some of the other helpers. If the latter, then we don't
> really gain much over what I'm doing with bridge connector.

I'd promote the hdmi_debugfs_add() call in drm_debugfs_connector_add to
an debugfs_init helper for drivers that use the HDMI state helpers,
because it's only useful for those anyway.

> The other maybe less intrusive change is that
> drm_scdc_debugfs_init and scdc_status_fops travels to drm_debugfs.c,
> while the actual implementation of the read op remains in
> drm_scdc_helper.c. I think that would solve it without a big refactor?

Then, depending on what makes the most sense, you can either create
another debugfs_init helper for scdc that would be called by the new
hdmi state debugfs_init helper or any other relevant driver, or put it
directly into that new helper.

Maxime

--yijabvvzevni7pdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaj1U+QAKCRAnX84Zoj2+
drRhAYCOPLwZMIlhU+n2hqtG6w1PG2M+xnnZ/NBwDYdaEJDyqs7K+pmaLZRIfRHM
GVpKf3IBf3/EjOGi8RVCosAA2agJ9Ni4UjtDDMtLdaqL84ev7uQV29tTeM5MYQtT
4d3eSwfSoQ==
=VpRD
-----END PGP SIGNATURE-----

--yijabvvzevni7pdb--
