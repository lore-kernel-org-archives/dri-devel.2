Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546CECD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 10:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B9E10E186;
	Thu, 21 May 2026 10:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="okq0EC+E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC8210E186;
 Thu, 21 May 2026 10:10:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 531B143A64;
 Thu, 21 May 2026 10:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE341F000E9;
 Thu, 21 May 2026 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779358209;
 bh=ZeXhl0TRrGYSsEZfs+4x0l3uj5e6YbKaAiSvSza6FxY=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=okq0EC+EJjMhNoSfVdE1iCsiL6EFtXZpjy2usMT+6gxjcqsdNkiMyigjtrCGorbs5
 ipsXm38tXHr1j8rX3IbV/X1XTdwtVKcatCSrB5jD2HQXeDWoaS4pDf6pD9rH7ZRzlU
 MkgJPe7+X3jGLkY54PquqVM27yTfKV+Qk3SH872bvWNVB+Kl5olkpliF0tjS/EbNkE
 bVyvSdU68++0tcVcbuVXp/Sl06MOgC8IOOgm6qyJ2LvkHq742M+TpS3L1UM3XJcCE0
 YV5lDZqvF39BBl0eR4lNVK+1pDOOsAs1bbj/FCW5UQyoTqjvsHMqqkP12I2s1k4K4s
 HUz9ABIdtst1w==
Date: Thu, 21 May 2026 11:10:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
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
Message-ID: <d7764149-e710-4133-894c-67471e0b5b3c@sirena.org.uk>
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
 <a1920a93-ac61-4246-a57c-b10bada3d70c@sirena.org.uk>
 <20260519135153.42c3f4a0@fedora>
 <ag7LVI2mia92Oa8L@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="297fsb/DOnRjNva8"
Content-Disposition: inline
In-Reply-To: <ag7LVI2mia92Oa8L@phenom.ffwll.local>
X-Cookie: No shirt, no shoes, no service.
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


--297fsb/DOnRjNva8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2026 at 11:07:32AM +0200, Simona Vetter wrote:

> The assumption is that committers will ask maintainers for help if they're
> trying to push a patch that results in tons of conflicts when applying
> (since development should happen on top of linux-next or drm-tip). Could
> probably improve that a bit. But also, often it's only clear after
> applying that a fixup is needed, and then it's pushed already. And with
> committers there's no undoing pushed patches. So it's just part of the
> deal with having lots of committers imo that history is a bit more a mess
> at times.

What I see frequently in -next is people just cherry picking the fixes
into the development branch instead of doing a merge, this leads to
pointless conflicts as soon as someone adds new code on top of the fix.
I gather the stable people also aren't terribly enthusiastic about this
workflow.  There also seem to be repeated situations where people mail
me saying they're going to introduce a bunch of conflicts that are
sufficiently non-obvious they're sending me fixups in whatever random
form, even where people seem to think it's a big problem themselves
there seems to be a helplessness about actually doing the merge.

--297fsb/DOnRjNva8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoO2fkACgkQJNaLcl1U
h9Cu5Qf/WnjWw7DjKwglXy52V//1/IpDdLuFDCPJ0FnN7pa0uy+3CM1jmKYjNGh2
2/zrv+0yw4wjddi48ikA5Hbx6jDe/Z2aqyuSovglKmPYToyp4BQgaiFxjM9mFLAM
60VZHPzOGUdB+ANu1nc3J59tCJkaJA1YYrRdIKbjgZdvZ1axUxRFUWeB9AD6/75e
ulR+T245pWRI+WTipd0Ce8lJxb75/nG2+Pl8HreR1zWORI6wXuQrRPs6YqU3irO8
03M1bxVCOU4AnY8OHoyhOa34FQ86Ak9Cp6Jk9cu/y13bzbkJ4mUkx+RVHQdADyDp
lvHBOrK9io2gFUL6feDQ1+23MzOXDA==
=/K87
-----END PGP SIGNATURE-----

--297fsb/DOnRjNva8--
