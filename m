Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BECCA5FDB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED07C10E271;
	Thu,  1 Oct 2026 16:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QkRttIQ8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F4F10E13E;
 Thu,  1 Oct 2026 16:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F41A40E27;
 Thu,  1 Oct 2026 16:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACAF1F000FF;
 Thu,  1 Oct 2026 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790871502;
 bh=N+M+cgKXaDqhq9d6SkwE4OLZ8CA6fSFx+8zX82uX/kc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QkRttIQ8ot6iOfNn5zvCAep23uwzPgy2VcI548MV6506wUMByhx7WQyXPvQpxCC5B
 I2AuwNfNiTspT2AC+8YjjRoUokwPee+2VYOYO5Lm19Px6AZRbCXT4jBHZnZ05uSTYs
 +zT51A4NDT9ddxAtnjoYNNP0wxVsDpC8Fz6uZUdA76UKcAIEbEKgGeL+hNxfjD6rX7
 eVsgwTMPI87wBM+81wBsSCa1gRS74d0gV1N13v2S4U984C0oK3X4cvWX5cfz3VWHyL
 L8fMcqT6oXXFSdVvmiWiDjMmV0huGoeU2hou3qpYGs+5JvF2D4MFk15SFboZF+cILp
 KaWD/smNXUxhw==
Date: Thu, 1 Oct 2026 18:18:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
Message-ID: <ar6GxMRwcsTX8IaF@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com>
 <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de>
 <arJ0huW356NjqpGR@houat>
 <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6yw5c3qcqaahffil"
Content-Disposition: inline
In-Reply-To: <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
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


--6yw5c3qcqaahffil
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 10:07:16AM +0200, Xaver Hugl wrote:
> > Couldn't we make a sysfs write trigger an atomic commit then? That way,
> > it would always go through the atomic commit path, no matter whether
> > you're on a "legacy" compositor or not.
>
> That could cause stutter.

Is it really that bad? I mean, it would be only in scenarios where the
legacy API is being used and I would expect it to become the standard
pretty fast anyway, no?

> > It probably would, but it would create a precedent I'm not really
> > familiar with. Hotplug events are kind of separate because it really is
> > a hardware event most of the time: you get an interrupt, and report it
> > to userspace. And it's largely outside of the properties space (except
> > maybe for things like edid).
>
> If there's any property changes, userspace does need to be notified
> about it. Whether the change is caused by hardware or software doesn't
> matter.

Yeah, it turns out we already have a precedent for this for HDCP so it's
not too bad I guess.

> > If we start having the argument that a property changing must trigger a
> > uevent, then it means that we can expect *any* property to do so
> For anything modified outside of the compositor's control, yes.
>
> The client cap avoids needing uevents for the luminance property
> though, since backlight control is exclusive to DRM if the compositor
> supports it.
>=20
> > "the compositor needs to be in control of it" can apply to many, like
> > color formats, positions, tiling, etc.
>
> If there were other APIs that desktops relied on for controlling color
> formats and similar, we would indeed also need a client cap for those
> things, until definitely all software is ported away from the old API.

I really think this series should be split. We obviously need to address
this, but it's kind of decoupled from the UAPI itself, and is only
relevant for a small subset of its usage. And yet it's all we talk
about. It'll be easier to merge in chunks and decoupling the legacy API
handling from the new uapi.

Maxime

--6yw5c3qcqaahffil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar6HywAKCRAnX84Zoj2+
dqvGAX9OoWUyh+Ye1cYmMTZL0gm7cVNMzyjj1DougHRXC2vcZqajoipFsCpF1Ocb
yF6CyHsBf23jduRmSRoASLezynmkAe4rumrz/oqiDKKt0K0XnAZLVcSv9ZeOK+hH
AGKiQTdMvg==
=e4xj
-----END PGP SIGNATURE-----

--6yw5c3qcqaahffil--
