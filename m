Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1357C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0904610E1BC;
	Fri, 17 Jul 2026 10:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="b8Qam9Oz";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C14110F4D3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:52 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso10149165e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784282690; x=1784887490;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Yhw0dInsGeTj4F3fnFaxZZDS+mO0VoDjtgnr4yzlww=;
 b=b8Qam9OzvZRL8/A6hdIhNo33J6lBnvji46nq01dv9qrMdlr2NeiaQmqsMXWQzyM0Bq
 ZFmDZi4DkDx7Qq6m263v5FK4ekphU38FIco4CtNzdjFuSJaeKSQqLz+wWNW97w1tFZsK
 1T0mlgKQpBgaP68/KrYauQGT/7mccn8i6cYFbiGgUg2daFv3HMB/KkSMpD2XSX5/qAY8
 cIhN36LGNfNV9RufUygFlwhTozlfPCavhqWZh77OU3uOPNDC4RScUzsrDTXwMDc+S0mF
 Z3W2ODnBEqZ0UpBLV0ozZE6xPUUhn6RB47vSi3umNBUHf+wL/6GxBUxnl2YGRT3OgENU
 SPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282690; x=1784887490;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Yhw0dInsGeTj4F3fnFaxZZDS+mO0VoDjtgnr4yzlww=;
 b=iSCMA02fxNcwiTblL+Mzn2Wr5OdtdS/fo4EEfJwjZw1HIrrhQ1c7WbIqjeynp/LrZD
 sMXu/MbiY4L3GwYj1pUYuII0coPCVt1iUBA2as0uHCqIY6JWEemYgZt2df/OCwox8+E9
 ptI7HkklFLjeXF0mhn68ClTU8+Z9AJ9ejMr2hgpm3G18GQn/s2+cPMVbRurCTQrT1Hh+
 22h0WXYgr+RWgWYTQJPzr7JjAXZe1N0kpC9ldpGj9FU9Dg07E8++znNDuggngQ0bpYhA
 q/SLWMCnOiHBGNbqAfg5tmJ+5p7F7e7c87kbzEdYe92O17gdgEw9kx9HS9Jfhh+Urbsu
 ItAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/jCGgTcrH4IeU289pqyRUG78ihFUZm+60e+UknLo8EBxxj2rtTUyujXoGIXnouY50aboq5L1k3Jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1bNMiWncrcemdRHsMisJOgsdvmhVNI1Oa4v2DFlU9F/ZrVXPv
 2sztdSzfHHMi3pRzTqr14OPvwClaB3lcubrPcOeyvtyBPUIZr+KX9IILHWK4bCLAhow=
X-Gm-Gg: AfdE7cn9xNquGLPvbLBERLWMH8xjhCiIllJh0qLIMiLBiEK+AF7Nf87RdJt7weT3mOY
 VaOkZ0+zzwtgoR60yA5hdQMEjIR87ylm3XdZ4SNvYu2q3VGVBxELOaMdPBSDi1EaUnII183SlUx
 k3OHZOZyb9sj3oRm7YOltw98V5UkrbDdyY3LQWtmMcrmr9KUKfCXEGpGQNYR8AIanELDGqcqjLf
 eiz4rJ92ZChUsKrtka+QApUv8jd1uw9kGyhoYFacp84+p1Mi4Wqvahx5LJB1d8SsWAlAxcLGP/j
 csMP3grbw1h2EWwiMdNevyZJClVEU4/cvgUMcj4EPjYyvncRlMhB7Elt99YXf9IKMhfv1aDEaLd
 5+vLzwwIeCvD5hxyV6pXq4el8aqWVSupou5ca0IluyL7Mn8DASFkixjaHMOQCvR0TakuLT9lMJx
 z1Xqbtot6iw6+C5Q8ikSjihJkDwIiT+UcyQ+ZlW2KbcAyL2xeg4jcGOIhwXKtlgQe/mA==
X-Received: by 2002:a7b:ca51:0:b0:493:e686:6134 with SMTP id
 5b1f17b1804b1-4954288e0ffmr54427165e9.7.1784282690333; 
 Fri, 17 Jul 2026 03:04:50 -0700 (PDT)
Received: from localhost
 (p200300f65f47db047d2d8b161e35ab77.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:7d2d:8b16:1e35:ab77])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63eea8afsm2585028f8f.33.2026.07.17.03.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:04:49 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:04:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v1 1/3] drm/amdgpu: Drop unused include of
 <drm/drm_pciids.h>
Message-ID: <aln9i5jDFwq-5mP2@monoceros>
References: <cover.1777545446.git.u.kleine-koenig@baylibre.com>
 <3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545446.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="omrg542u6n5yvpy2"
Content-Disposition: inline
In-Reply-To: <3205129f75aba48bd1ad8fc810cf6a18e718206d.1777545446.git.u.kleine-koenig@baylibre.com>
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


--omrg542u6n5yvpy2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/3] drm/amdgpu: Drop unused include of
 <drm/drm_pciids.h>
MIME-Version: 1.0

Hello,

On Thu, Apr 30, 2026 at 12:45:13PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The <drm/drm_pciids.h> header only defines radeon_PCI_IDS which isn't
> used in the amdgpu driver. So drop the useless include statement.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 8b71834a73df..1239fb32311f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -28,7 +28,6 @@
>  #include <drm/drm_fbdev_ttm.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_managed.h>
> -#include <drm/drm_pciids.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>

Patches #2 and #3 of this series was applied, but this one wasn't.

Is this still on someone's radar?

Best regards
Uwe

--omrg542u6n5yvpy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpZ/j0ACgkQj4D7WH0S
/k6UOAgAuvDRmjFRe/c+Yvwalkgkm1V2bTFEO+Y68kvArSjs3tPu91nAVku6dRh3
k9/kieLXUO8zqnxoGUNzrBt2NvgJiXqs2O18wbCBSuvgHzGS75GnIiqNaa0cC3a/
Ruf1D5hgtNG/yzx0EhTq9v7xbjnAs5exnJB+mCQtlmIevG+B6NXkyy7Edv/OBkI/
meLpqDk6cipFwid4f1ENTQ7p9vYirpHKYiFgsQIh2FMsfAw8QfPmOVY2G129eNDO
WoEIzwQqZgeEp/YrpvL7pEC+l8Ar6NgP+HXetR7Qw6WGYAAGxmXDNhPQ8CI+uYbL
Lcl/XrLFa8Th1GDQ8vdlul1ohKLb/g==
=wMWV
-----END PGP SIGNATURE-----

--omrg542u6n5yvpy2--
