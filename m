Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CA8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AA810E965;
	Mon, 20 Jul 2026 13:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iMwl7Bfv";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C480D10E943
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:50:46 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so79758765e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784555445; x=1785160245;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8DVbCeTyRtwdNp19NwSytzMSLYxtjLSi1mLI2nXn1O0=;
 b=iMwl7BfviMJ6GKlHdkmc5kJ/TRyUqDwOFcLX+gQLTJfNIDQgoynOSIQ1ZHtUWPICA2
 GksVzHKCi1SvjDSbm4cwbwtOdC4I+JT0oH0d91VqxszSiT5h0dEYH2llKLhFvINp4O9A
 jckFtwlVzRbrWEGLEYtTF8EXXiYvputvuoGQwSDQHDm1riizTh6NPMolLm70WLCLCXv9
 UvsDrb4d2/aleCZM7hlHeo+GdGdb/ZX9rsbMiNeCJnfc269nOzWfYBgZ90Nwy8lH6dRN
 MU7lfGiJxOKvtp4uSZnMbP9TbAuYNPbRILs27spCHRWBGVixiuY5Mk+TZQNPsnhyma4+
 BYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784555445; x=1785160245;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8DVbCeTyRtwdNp19NwSytzMSLYxtjLSi1mLI2nXn1O0=;
 b=cRxdLbe6hXyTV99lhKMMxY3F/I7ajP9qZtE5dPnnwntm0797lTDmvL3EXGNVYBoV92
 Z8crIC4QOjbBDJ2JHym58KixIHYnl3CUbwtEMVGs11y+D+pPjvCOX/xoqzIguI9cogul
 pIN4lOYvWZhm+2EjlPvRXsTqYMw9EmDSOyb3JuWqKuArJrukyOZmUrY39FvM8Vnkrb1f
 kYHKifnLAWsDAQf6V6ar8VqeQP0/p8pxDMOcEAvvVlFbKijjcegruDcjQrNanx2mQR7z
 Q5vKmMTP1vEXT/w1Hgttqq493pbqyymJ2870PVLA53YKhkyHCVWET2P2nRz83dnptKGf
 5cIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpYjo1+/YOuX1+5jNXKoBujsGHsRWLe4d8n+Lc0an0kzgc4Ss88rKvfN3rvnmkH7t/5WxqcN5I5iM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEsPJOexd8rtCfwHEr9XNWRNCN90/OLYuzOIDMjFSWZHH6rinh
 dHHmOvKJrdkZZxERv8xxhKU/vBjnFMTEq/HzuQnnWzZL3lSp1WGq8vH10DQ2PQobVmw=
X-Gm-Gg: AfdE7cmOj6IT2KcoJ6fzokxYING6rpNMKm7pRMBySdAJ4PTue0sDLXqN0sODBfNA4oM
 wq2HBWfisxuqmeNBa3cJiwNFdEi5k+PaT6TbkNSAbAjGN890STDH8Xf+xgDY1NsdiRnQjF5CHPd
 ypnzc8VcztSzFa2j4PZ/R/N3n0BrNn3wsCwwtkDtphLP9lnVmU+brx3qH0TJp5n9F3Zg1hmYWC/
 +K0CVdVB5Rvz/S/SnyeMe46UC1UsAO5zK//KmNb10EZ87V9LabF06X8mf0zuCN1yMNK5PBxQW1Q
 4nYu6KiPyZw8hNsYd6r9N8BeiEWDY+S7Vvn72IDDvN4CvXKEfiX2IOydmAOrA7yi84YN7eoAnDh
 6xACQ8dc3cWg24fjIVlHbZwGH7YCeEUNzJ+v5GE5uM6mpsPwDsODDYFv9ezTnCd9aLbRAFDEvx4
 O8dqgSlQwPtq035gDvV2EYpfQubn2KOdbF8dixfsbsU6JzQH/yuG6kQ/kUvZ9j/g8sng==
X-Received: by 2002:a05:600c:4714:b0:495:3f84:a792 with SMTP id
 5b1f17b1804b1-4954a3ed494mr165288685e9.12.1784555444675; 
 Mon, 20 Jul 2026 06:50:44 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49563e60fd9sm12792045e9.0.2026.07.20.06.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:50:43 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:50:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Message-ID: <al4ncjnbM58fyYoM@monoceros>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bnxhjx2ywetn23n3"
Content-Disposition: inline
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
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


--bnxhjx2ywetn23n3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
MIME-Version: 1.0

Hello,

On Wed, Jul 01, 2026 at 07:05:18PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> while working on a tree-wide cleanup I found a few issues in the
> drm/hyperv driver that are addressed here.
>=20
> While the first patch is a fix, the issue is so old (from 2021, included
> in v5.14-rc1) that applying the series during the next merge window is
> probably the right choice.

I wonder who feels responsible to pick up this series (maybe without
patch 3)?

Best regards
Uwe

--bnxhjx2ywetn23n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeJ68ACgkQj4D7WH0S
/k4IVAf/UbF3ZUuZ0pOeIM1PofAbO0V+GVHAmpdZRUKVVB/dGoZNleA5QRj1tkhh
iQY670n22CpAnQFeLr/V7T6tFirLKkbsq2gG1xBZSlLRHdVSH6VyCbyYq49RGl6w
GemB8U83rR6YbhXeLRPFxYJvBgC0z8IO1K5ayIlHHaLVEhuDMsdUysIYKkRNBynd
0UpQ910loOMxEVD1m52qL7r+59BTNDwHcz1M+AmJpSN2jmpSb+9B5YJmqUeptbLY
hgKbGFkwD7Vio7+cGNY3RbaAfXEsyNj1Osc/bmJDjuV3W7iC2C58MVj6BeQGgs3v
eCnbtwbUaP8y4VJSrBUk6grj6zVKag==
=Ey1H
-----END PGP SIGNATURE-----

--bnxhjx2ywetn23n3--
