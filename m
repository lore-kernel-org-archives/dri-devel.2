Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9C9CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C66D10E036;
	Fri, 22 May 2026 16:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="TtOF40G1";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3746310E036
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:48:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso4523210f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779468516; x=1780073316; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RkkB0hffRR69qMLvhInPQn8c5SMOFLnLZE8s1HedbWk=;
 b=TtOF40G1TqMJFrsFSkjDn446sU4B6ew7JzVPodV+wC1/L2guPq7BIYu7HrJ0UBdENx
 IhXhMla02ZJ5P2Pc5ZwOuGakA3HnqI5i8AtPeDnDlrqwRBuc6WrR+wcaz1U+HghKhK0+
 lLxFUKzZqnaijAvyr6Z0AJnLaFqOZkg/1mxuighvs4MwYGmMLdemkhw3Fn8LzZbLdik/
 jM2psmFXAybXsnd0jWPQRgMsXF5LMKIdgltAdnMgbP2G+/wyXFWke9TkL2NfBIb8mPx5
 TAA6yUBTbeA22IE8Uk9SGG1glGD6vHzB7WZC7YOcdiaGvPUinCw+G86JSIUGpOqeV94x
 04BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779468516; x=1780073316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkkB0hffRR69qMLvhInPQn8c5SMOFLnLZE8s1HedbWk=;
 b=AXr8rYEkaRpDpPRrlLKscitablsEA/ZiCSh/U+8l3dHZyZcqVh7UFuiw8OTWa3HZhd
 GnLxRZj0BMRyIBffEGBmwaCM6p9q+8xeIenJr+58b1RPpFu+W5aZo9xHCN6Z5iQWLXIe
 WFl3CQ8b9Os7hOfutY3QCIH3vTG0yZGG2EOhG+sTcNW/0Pq3XXSVqMXGGh/1iZVxwj+b
 gvAiUb6QD37EZTry2MfxVjyjl/hVptJDLhXBjBzxa4bCGTI3q9XE9R/ewCXsOg6x7NIO
 jmTQVQWcbNhTGChBT+qdxxkaiRxEgTc0rKNyjOXsUA4kQB7F/z4LsGFmQYCDYfncZxHL
 DF1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w1u1aN2zHG84D2KXXsZUxalsFCK4wOtIVGacYD2NrOL7D2zjLun15wF6PvzafKgKC0noBK86aErA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBqxj3keowClru14sEZysS07yBtnqX+bL+sJZFsn38peFVVaZf
 lMdFNVTQBbzum/QPVmrDDgadYBGuh+R/+39UvRzI7s4OxvFeW8TKoy/nmetFWPo3Iiw=
X-Gm-Gg: Acq92OE0Epv6UsFGvkNatjlNvFRxhOub0ntNSG70fwuRv6MOuC2VsLLye+GpoEFIqwG
 LQX5/eziN+36XVKXHDFLAwklwqA9GruRZa8Ir0pAaZ0TYlsTJ/00vbwJ4qKFmXaed55pTpiSGTu
 0itFoG9VqTybrnYU1f/2U2UljsyqapQnx9h/n44jW29A4OOUi7KblhHeLzZ3S+a5R/vzDro8mvk
 fmdh2Ez1pP/Rrgc5taGgmyN6YJbApzIV3YGPDYTAsVjJDa5uv0ZD7D3V6Kdb/Kpb6XtGsy5Jn5B
 4XVBTdx41xyEZfGdaOXJhSUw5CxHD7zsN/+Ob4t5IRb0M8tj6tCWJYRipPfDBhoOht5dPi2HPwX
 ZbFygCgmxjjGLIUoFpp4R6J+1quBDL/rjE1Zhw6Xs2EN3Mkxfl0sNcVDo0ZeX/lMC/ZDApeaHEW
 CbSoDnrxDb1dmlCsGslgS6FRC7eDSYnbcUFT3x8VU25q0ltVFu
X-Received: by 2002:a05:6000:4283:b0:45d:8c16:5566 with SMTP id
 ffacd0b85a97d-45eb38baadbmr7082103f8f.18.1779468516497; 
 Fri, 22 May 2026 09:48:36 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70d89sm5769908f8f.37.2026.05.22.09.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:48:35 -0700 (PDT)
Date: Fri, 22 May 2026 18:48:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
Message-ID: <ahCISfTlN10gD8e6@localhost.localdomain>
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="27zcqpjzhteuelt3"
Content-Disposition: inline
In-Reply-To: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
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


--27zcqpjzhteuelt3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Thu, May 14, 2026 at 02:36:08PM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> Just like we have memory.peak, introduce a dmem.peak, which uses the
> page_counter support for that.
>=20
> For now, make it read-only.
>=20
> This allows for memory usage monitoring without polling dmem.current when
> the information needed is the maximum device memory used. That can be used
> for capacity planning, such that dmem.max can be properly setup for a giv=
en
> workload. It can also be used for debugging to determine whether a given
> workload would have caused eviction or system memory use.
>=20
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> Changes in v3:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v2: https://patch.msgid.link/20260513-dmem_peak-v2-1-dac06999db=
9e@igalia.com
>=20
> Changes in v2:
> - Make it read-only for now and adjust documentation accordingly.
> - Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb344=
9c@igalia.com
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>  kernel/cgroup/dmem.c                    | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed99..d103623b2be4 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2808,6 +2808,12 @@ DMEM Interface Files
>  	The semantics are the same as for the memory cgroup controller, and are
>  	calculated in the same way.
> =20
> +  dmem.peak
> +	A read-only nested-keyed file that exists on non-root cgroups.

s/nested-keyed/flat-keyed/


With that

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--27zcqpjzhteuelt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahCI3RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah3WAEA8jNoGbM+jfh2AQM8AaCh
AP+xdJvR4lj+FHVIyhs6qukA/0scDz7iwckNV/NU40VipKTbHw6vIv1Uo6Y97PJu
d5kF
=dGdF
-----END PGP SIGNATURE-----

--27zcqpjzhteuelt3--
