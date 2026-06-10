Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846AECD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48A710E503;
	Wed, 10 Jun 2026 16:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="FVRd6WQp";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC1310E503
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:55:11 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490afc47455so37625555e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781110510; x=1781715310;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk3r5GhcXgLdVr2P38hzuKv670yr4eRz8wtw8OMK83s=;
 b=FVRd6WQp5hfYpXbyjHSMuiA9fIie0v4NH1qQMkAmLWZEUPf4Am9zsG45R55LRooPG7
 vvuZliUWSHUF24PTnRVyrBSCwSVcRk9lE23iYXbcIpcdSsrytxzXx2+8zD+4ZjTE7V0B
 DmRGCKxCq5IkLIoBCf5p3ctZMF9S4aywEa4cwXK53bIAyYMl/wca26tu41nH1dSb5l+U
 c8GFLjBXkVkr8kP4g7b5v8QoxRGfnOnhKTdTahOkszhL/OcbsHJy4BG0CgjPFfViGeH5
 vXUuZuENrjIaSosHfWmqKBt41tC699gz9ROXBU4olt3LzaAUbG0XgQOrfMkWGsWI906h
 YV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110510; x=1781715310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk3r5GhcXgLdVr2P38hzuKv670yr4eRz8wtw8OMK83s=;
 b=BO/4aWJyTvenR+aQ8QrNTHSBHetYu4QuXokJtvKe5wWz5k5yzWMw/Z82Gh90jeqd7k
 zeLFwQAEL7ZRQK4inFeuj6xwOT6L9RCg2SlGd8/xmlGAxxgGPjifqd0Sje/ZDV5pG0ka
 3DsafrS8PhmbqW9E7+q1zfzZbJBT1yXNzFjiN4VR2ev6tvsvjBMcBOjckEfcLLl4lQkX
 qK6vOr3P/BCcf0nwf05mDUEYY/QUO6YMB9QZOABe5akLnqqEFRi8YxzgOSQHNHITHEks
 W6rPm/hN3L3Dg9+ErcZvkFXMBKx0Uh256SGOxuRMZvpccCY1m7OlQTOFyI92SlQTtSRA
 YZqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L0Z+TaPzk8Faw76RCxVHnnl0X/y+h+7MZ9qESwW3EzCIl3enFnAOsxAUyOCBhjtkxKMjDO4uccf4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOJis1ospLtK6nul21DFd/Q3J+nCEFF2TzmwhXOjLgrLmX7NnW
 Ckn13nyEpKusJCHuH6ZoHpz336QF4dsPAzq8TaBZtlaSThYfr+9uysyYu5PRdP/K7ZU=
X-Gm-Gg: Acq92OE/nhdaj2YTp23VTa/OZE7jHk/hbo6XgYcHI9+Y+VHCv/wltWUWe9Ok8IzYKD2
 AdJmoTnMN5jZBNT5zMsMez7VbUywE9ivY/xjKhsWZ5jweNKiVUM4TjBk+4M+pshhDXM69wzC66T
 djvdJDAd0jcmTPZ76thzO0VwQFVyZ8A8gpJTMeFOhu4nCmqLw2XFFEilIH4XAflOSZXOBIqwG9s
 xOUUyCK/v9YbxjDdvFsOVn8a4v4f3Tf3eI3E25/KonK9LKPDDJAc9iJ/AcEzyGnawtiY1Aa62/x
 55X+IvOBZ3XLip4XhMK+xAeevCB6uWzrIE94+FSaQGLXt2nJqfsXssKv4SIPvQ756+fhAuOhF/7
 vJqz8PqlZyBYmbl/xC5bLDLNKvVptC8iQ0Cm4mOwS+w1UNrKaF6rR39fLcL8Qux5XCL8eeZFcgp
 OBIxnNt5GSNvjEr45ehyKqpnHu9CV6x7ajiS7iS5civ1MB88acElCv6bUGVPi4JZYGsioJmQ4JK
 iFdwP3XSnindPHesHhQbaDzPZmcYWFVj8kZ
X-Received: by 2002:a05:600c:4e0b:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490d71ed39fmr101101355e9.5.1781110509773; 
 Wed, 10 Jun 2026 09:55:09 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490e284bae4sm2171525e9.5.2026.06.10.09.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:55:08 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:55:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
Message-ID: <aimWvtBTQvd7O2F0@monoceros>
References: <20260429171644.8406-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r2bfywcea7kmegy3"
Content-Disposition: inline
In-Reply-To: <20260429171644.8406-2-u.kleine-koenig@baylibre.com>
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


--r2bfywcea7kmegy3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello,

On Wed, Apr 29, 2026 at 07:16:44PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> ... and PCI device helpers.
>=20
> The struct pci_device_id array of supported device was initialized
> by list expressions. This isn't easily readable if you're not into PCI.
>=20
> Use PCI_DEVICE* helper macros and named initializers which is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>=20
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
=2Ecom/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Gentil ping! I'd like to work on changing pci_device_id, but that
requires that this patch hits mainline first ...

Thanks for considering it
Uwe

--r2bfywcea7kmegy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoplucACgkQj4D7WH0S
/k5G4gf+K+Bth6+S4Oo8ga07nkWVOMnNU7IxWEU6lQBaBaSjdUxnVgxDI0k6c6Ts
sS/tzHaBkdPt7ob/NfWvaHFQ0MlMaJ7BmAOXj+dXkAwY8UOBE4ezbPZT8F79tMw/
ptRDfKanfdEGc46Ky4+KXZmmbncZMtetsrY7yk9qhNdNySXchxEJhkW7kzLMSC5A
f0vYuIBYnrNWo3gyUFQqU/hdSy9tyujE+dceY06cFfbo6qagWgi87hBQOLWlwY1D
vpk6x9qdvXGus6l4x0TrJ9UBafO/KSnEdqH8SQRmFWntE8V/spEmtsGH/E9JXIZq
EX6CXFepKvu5BNJAHETHktgKqmxeCA==
=VWoE
-----END PGP SIGNATURE-----

--r2bfywcea7kmegy3--
