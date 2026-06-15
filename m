Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557FFCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4A410E583;
	Mon, 15 Jun 2026 16:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LsaqlJAT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB56E10E52D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8ABDF4019D;
 Mon, 15 Jun 2026 16:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEB11F00A3A;
 Mon, 15 Jun 2026 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781541194;
 bh=fkQPAZgZZwAbqSRI0KfOHSZXsP8fGZyj42X3x9rHBWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LsaqlJATciWEK5UnwpkIBNur+kpnSlTQnXd5pAwU0UwvY5AfloJRYqx/03fiKKJPB
 LglkSs/LDVC5qgKsB8nPyNzaQJrS4AwNA73Zj9n0FE8E9K1kperNYNDORtwwgofM1O
 JqMwVAvBfMCL3INF/gFRNkEcqS01/qO2/8eyTvrn1Z/oncKWkuWTcl3dsWFKkgdmEJ
 7n9saHD/q/oMNRhidhhmqAMIQM1uX2lH0UC98Stvy//4czQ0uufmwZXVlIk4BecTqf
 RjU33OnCGPeH+MABNJQatsL002hdQ4BBM4smk2OSqoCw0lG8nrHJiJ1QvkJfS/ZhOe
 KUavl2hA55ISQ==
Date: Mon, 15 Jun 2026 18:33:11 +0200
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
Message-ID: <20260615-mature-frog-of-certainty-d05f99@houat>
References: <20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com>
 <ae219b64-c8ce-4798-995a-cd8fdd74d8a4@kernel.org>
 <5DBSVhedT12K_nGj0amyCw@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gndckay7c2utsyk6"
Content-Disposition: inline
In-Reply-To: <5DBSVhedT12K_nGj0amyCw@collabora.com>
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


--gndckay7c2utsyk6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/4] Add SCDC information to connector debugfs
MIME-Version: 1.0

On Mon, Jun 15, 2026 at 10:07:02AM +0200, Nicolas Frattaroli wrote:
> On Saturday, 13 June 2026 08:57:29 Central European Summer Time Hans Verk=
uil wrote:
> > Hi Nicolas,
> >=20
> > On 11/06/2026 14:57, Nicolas Frattaroli wrote:
> > > HDMI uses the DDC I2C bus for communicating various bits of link stat=
us
> > > out of band with the actual HDMI video signal. This information can be
> > > useful for debugging issues like questionable cables sabotaged by fel=
ine
> > > teeth, Enthusiast Grade cables made of cow fencing wire, and other su=
ch
> > > problems that ruin one's media viewing plans.
> > >=20
> > > Consequently, this series exposes various bits of pertinent informati=
on
> > > from the SCDC protocol in an HDMI connector's debugfs. To continually
> > > poll the link status, userspace can poll the debugfs file.
> >=20
> > Something is not quite right: I've been testing this series with my i915
> > based laptop with HDMI connector, and I never see the scdc_status file.
> > And that's because CONFIG_DRM_BRIDGE_CONNECTOR is not set for my config=
uration.
>=20
> That's to be expected. i915 does not use bridge connectors, and neither
> does amdgpu iirc. I am working on embedded boards that do use bridge
> connectors, along with all the rest of the HDMI state helpers.
>=20
> Implementing something new in DRM usually involves having to triplicate
> certain parts of the work in order to have i915 and amdgpu behave the
> same as everyone else.
>=20
> > So I think you are creating the debugfs entry in the wrong place.
>=20
> I can't create it for all drm_connectors as Maxime suggested due to the
> cyclical dependency that would create. If someone has any idea on how
> to break that dependency cycle, I'm open to suggestions.

Back when we introduce the audio support, we floated the idea to
de-midlayer this and turn it into a debugfs_init helper. We don't have a
lot of users yet so it might be the best time to do so, and would solve
your issue.

Maxime

--gndckay7c2utsyk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajApQgAKCRAnX84Zoj2+
di4QAX9xT6RbeI7/fQ3riVjJLYSlrJjamj2r68YFphuOaDO1sEx0MxlLosvnarvt
99Y/ttIBgOlmb/SK0vs4CFxqwsappIvDFFcgzpk/0BZwP82Br3YWWoXErl9kxJgE
16tMW1Qkrg==
=hMNS
-----END PGP SIGNATURE-----

--gndckay7c2utsyk6--
