Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A980CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF26F10E3A9;
	Tue, 19 May 2026 11:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZpRctH9z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3881A10E3A9;
 Tue, 19 May 2026 11:37:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C2B460129;
 Tue, 19 May 2026 11:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032E5C2BCB8;
 Tue, 19 May 2026 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779190643;
 bh=OJBSjd637ql62zBgLjB/YJLsQQEAm3qjj8G1mI1PLXc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZpRctH9zxDPSCKxi+g15b9wfB7AYYizVKqhmd2fIRUnUSmDPKv2OTjUIoMmzjda2j
 ILRZIjN7kpSFrcmKD5dB5Mx6q689w5ytMvcJkidhF4aqZ1/HZcyoYn0KauhSzmYtgc
 Sxx4rS0DmnGaA29BqRYkKwOg/t8SH4fWgjevAT7tM+36H7gcj+8/HAe9P26mqsYJAU
 y16eFaO8CGbfrLIJ2zDYRWnCQFDYGQ2r4ueJc5PGYX77bTijbYFgEvJ0G2whpTFUXr
 ntZ28FzbhgQRcB4RvTNsBcgMlxh3Zu8ZiwFgD9A0kDVQqKvfPD8IbwltJTZ5w/JQ1u
 dGFPS8p2nRoiA==
Date: Tue, 19 May 2026 12:37:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH v4] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <a1920a93-ac61-4246-a57c-b10bada3d70c@sirena.org.uk>
Mail-Followup-To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <rob.clark@oss.qualcomm.com>
References: <20260518-panthor-shrinker-fixes-v4-1-1920234470d5@collabora.com>
 <20260518165225.145175b1@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DC4QcwTjvNAADHMt"
Content-Disposition: inline
In-Reply-To: <20260518165225.145175b1@fedora>
X-Cookie: Huh?
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


--DC4QcwTjvNAADHMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 04:52:25PM +0200, Boris Brezillon wrote:
> +Mark for the silent conflict resolution needed to reconcile
> drm-misc-fixes and drm-next/drm-misc-next.

This doesn't appear to be a drm-misc thing, I was seeing issues on the
DRM tree.  The patch does seem to ahve resolved things though.  Please
consider topic branches!

--DC4QcwTjvNAADHMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMS2sACgkQJNaLcl1U
h9BZaAf/fOh8rbQA70JLxdT/rc15Ihlk/YbtBsQ4087/9mw6gogTRhqFYtgy67ln
n/8aYFIUjhmkO0ca8rMeW65Ydj3YNT4MAWbdOYPzvzoPc02Q5X1jXLy/slMeKax4
YhPAtL5gd4923nCR1BDg6wTcMaiGaeJUQXzR+8aK0TSw+L+Y7DZjVROHL35UgYgd
mvu2kgEsLldWXfpikUvUZy8VTlz4zhtNd0J/VPALth3pa7YgH5lJVOgRDgCFpzc+
mBVbl52XgzPyiWkA0/KY+thiyjk/T0nYRR5CYPPiItbsghO3W3DB5Q76jo8f3XIB
NcGlupeD91GdKqezozeKjbhf9s0caw==
=zKZw
-----END PGP SIGNATURE-----

--DC4QcwTjvNAADHMt--
