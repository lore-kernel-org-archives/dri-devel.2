Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B418DCD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 08:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0E610E74A;
	Sat,  6 Jun 2026 08:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y7o22a/s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E31610E74A
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 08:47:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CAB6441F0;
 Sat,  6 Jun 2026 08:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB21F00893;
 Sat,  6 Jun 2026 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780735665;
 bh=argSOqRU3vYw9E9jaEWZmvtuSJ/crFNhjykWHncvgu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y7o22a/sAGE/945MPSCDAaBjxXvfF8JvescMXLPeKWy608x0YvqcPzgj6lQBqsRdX
 bb7toLJ6frwRoxx/EpC9RawjW6EvGTZXTPmpHx0UbCWeIuxzWoXID+hFq3kkShlJiL
 FbKTB555Y1RpCyLT/fVaeJK9dyRJSvNdgByujCO77fefhfo7VH5iT9nP4vIL0qqYlA
 h8uVvL1Vcq5RRtrBVjH/LN5KUCc0e9H5wulSHXBvRI0PhHQiWwyTYF54sdd1mAZ936
 nm6X+GQSYZvhJD/3zbE6suNnQKaEYWeiVETOsG7A8dKwaevQ5RI0lW/fT9Ueoa73lF
 dELqMPlGGBfpg==
Date: Sat, 6 Jun 2026 10:47:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: wangdich9700@163.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 wangdicheng@kylinos.cn
Subject: Re: [PATCH] drm/connector: add CRTC state change callback to HDMI
 audio helpers
Message-ID: <20260606-hopeful-yak-of-beauty-fa1fe3@houat>
References: <20260604-adaptable-myna-of-courage-7ffeae@houat>
 <20260605060946.435082-1-wangdich9700@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xfdeicbojgpsud4u"
Content-Disposition: inline
In-Reply-To: <20260605060946.435082-1-wangdich9700@163.com>
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


--xfdeicbojgpsud4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/connector: add CRTC state change callback to HDMI
 audio helpers
MIME-Version: 1.0

On Fri, Jun 05, 2026 at 02:09:46PM +0800, wangdich9700@163.com wrote:
> Hi Maxime,
>=20
> Thank you for the feedback. You're right - showing the driver usage is
> important to validate the API design before merging framework changes.
>=20
> I'm preparing follow-up patches to demonstrate how this would be used
> in practice. Here's the plan:
>=20
> 1. DRM driver side: Show where to call drm_connector_hdmi_audio_crtc_noti=
fy()
>    in the CRTC enable/disable paths (using i915 as an example)

i915 doesn't use the audio helpers, so I'm not sure what good that would do.

That being said, that patch and answer sure looks AI generated, and you
have to disclose that in your commit log.

Maxime

--xfdeicbojgpsud4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiPerQAKCRAnX84Zoj2+
dtJzAYCi65gzqt4Ls1DBqWsS+wJajF7lYkvb5Bk7+i6osvSK8IVfx/y2gwYGEAPO
NFvf51EBfiF4zHiiujhXDfoF3vB67Gk/S33LNOwdnEUL3Mj3zaTeg5ADsxaSNE8V
6uj67etsJQ==
=HcJO
-----END PGP SIGNATURE-----

--xfdeicbojgpsud4u--
