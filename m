Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254C6C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9E910E073;
	Sun, 19 Jul 2026 17:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="oGXuo9qb";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B795D10E073
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 17:49:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso1380595e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784483366; x=1785088166;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=86HhMRRfdsPj7rZkjXytS3Mu9qX4PJ6Wk4AuPeu5cfA=;
 b=oGXuo9qb511IUGuMlaNnhtlxVQX869FUGeiJiYd5jzV1cRSh3iaKNDxtBQ1z3OS195
 hNJifOA5LzLNv24bou8EQit2PJb3lRpDkVyEJ95PyXoPZmbX86FdC5AbCsQ3aktvOE52
 /i2YJtJdk3AifyOzP0YnXuaw0oX8AyQ3JObWXYfLPUOBvE8GiC2rxHz6HvbmSc52eNBw
 IABuRerm0Pkl1HOcaJlcr7EGOqGlI1yWEzRMhem8aoG7KTgAA9o4lpb+XVATP3r1bW9+
 AT6FXbPD7+6KgFzFceuvSwkdmo94FZGr5aAk15xRX/SuEZDavHPu6n0Q4iVYDADcBCJL
 uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483366; x=1785088166;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=86HhMRRfdsPj7rZkjXytS3Mu9qX4PJ6Wk4AuPeu5cfA=;
 b=gtIhPvX9VyuA1yn4RNvUBAe8iEkp+bgfLj9ADeRv4B5ApJ6qEpT+TUTiKWqF5CSdAP
 FnK4tgQuRzjDZQAC8HuEcU+QyPyP/9yGu+yzo3warj/Sjw7qJNMLUC/kTjlXMx5hHGIG
 eydr2h2w0fnwKsiQnpBconwE8Fs5st1/t7e6hKqPYIDJzcaKU17BnRNzy9/kqyiu4kxF
 qdLBvau7swF2DlD/2AAsiFG0clkqC25kW10sH/6xRNyfZWuWca2i27Jda4AckyOs+8v4
 U95MrrHsofW9NI7oHnn3YeQkL2lqZp/NGDzHAZhsC18vGIoigRyWaJ/as74RBkslZBCT
 gOrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhuGXB/CD1ibv7kC72ghDzcmS1ARzmCURhbRCR4omNtZvhgb3sZiNzGFysGdcalSeiwpqdip7PPAI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfAp8zHZZb2v9gcqHDXl5u94GrdFIkSFpE51mboaVxJgjt78ca
 lOxLErAQmCiOUX+/Bn1QDvYTC4bcT9HbFhYgfNgQT1BZoqte0s5n9cRkvGgMc8DVRBI=
X-Gm-Gg: AfdE7cmzJZuNI2VkFkOfotomyDuP+Ty1cqmzNoBsPNGQ24kSUlLDE6m5QZDmehFR4gj
 e2MNGCi5s84JueCFzmUzPOet/gOCe4911FGD6aD9a0UgxT6JRW3rvXAila29tjGWV2TGgA/JLo1
 w/ml5Zjo1qNxU++z1G+IsPpQgUlJYj0wlcXgZyD0SBrO+vtdzvUDV9Sd7WGcFlcjcG1dadB450L
 6bQsyW7xbyK/3ef8+ivbR40G3rZoGzvl6Av9dFnfv1y3ClKu3F+7sNZRJcl0CM0ZpV2JjUNUKMV
 pf9FAuFU0W/CcpSiSmAAWFwBd08GHhq0HpCgWqqcuwShl2Q3AAAv/gkB+IbPB51A5EKkvXVyrjZ
 IAdm7AFkg4qgsXB1+Qppc6JhNfztXKfb+ITiXxckLQomqiEyjVSbEHlmZj0QRjiD+Qpwx/rCEjY
 aimYCONVU75t1FTCeWtg==
X-Received: by 2002:a05:600c:4f86:b0:495:3e81:76fa with SMTP id
 5b1f17b1804b1-4954e1e065cmr91065505e9.15.1784483365886; 
 Sun, 19 Jul 2026 10:49:25 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49549a3e2a9sm213858545e9.4.2026.07.19.10.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:24 -0700 (PDT)
Date: Sun, 19 Jul 2026 19:49:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
Message-ID: <al0N1wqMD-_z8Uf1@monoceros>
References: <20260504073422.1130008-2-u.kleine-koenig@baylibre.com>
 <de7acf2e-e07c-4a94-92c7-ae0c9311c8a5@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dhcya4xl7urvfsmv"
Content-Disposition: inline
In-Reply-To: <de7acf2e-e07c-4a94-92c7-ae0c9311c8a5@broadcom.com>
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


--dhcya4xl7urvfsmv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/vmwgfx: Don't use UTS_RELEASE directly
MIME-Version: 1.0

Hello Maaz,

On Wed, Jun 10, 2026 at 03:04:07PM -0700, Maaz Mombasawala wrote:
> Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
>=20
> Sorry for missing this patch earlier. Unfortunately our maintainer Zack
> is out for two weeks so we'll merge this patch at that time.

You're saying I can expect this patch to land in next around end of
June?

Best regards
Uwe

--dhcya4xl7urvfsmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpdDiAACgkQj4D7WH0S
/k4SUAf/berxeE3JW3IGQInSzpNZXV5GFj4oudq413fd9gidTnBH1A859E0BgeIe
sKxIxW6Yk+bxJC5e9GiWOIEWCrGXATTFqyAE/Oc94B6E6pGYElRAprozy2LsTKSh
tDIKlXOFyHmQqRWCU7gDzreBQNOEsGZu+XrpiAXmVUidMTdXilWPYaBVnfiIMrmY
S5ZyhhDa47hgCtfDNT1ROgXvONjBDNxq7pO49cvseg9HumjpXXfjOyxhJ/BMCT2F
UzU5zcuOOvch3PyVesq3W0sC4PkkPaXrSVysa/l0rkhex4ChAlLzODUeT2EBZCGb
v0X4ii/bj7NFiUyot5dOUvPGAZ42JQ==
=obhY
-----END PGP SIGNATURE-----

--dhcya4xl7urvfsmv--
