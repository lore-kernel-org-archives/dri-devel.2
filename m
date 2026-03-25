Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B09FEA82F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD7410E4EB;
	Wed, 25 Mar 2026 07:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MtKR+4/N";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933E310E4EB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774425586;
 bh=PTuVLC810FJkWrnp0A25MJbJvkbbV8qem0z7qZzM1xM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MtKR+4/NBlB1s+PmmgiQwMPTYH44IBM2hLal2aGywpKK2mV/8OU4eCC+L4V/3p6sX
 cgQUlc5o6hUfeQhPFg/1tjVJ5g31dunXpJ3jAqkNGP5KkW5wukL10S6+45x548m4Sw
 a9x+WY48OAU4kGJN7LGMFiLY0JmPqioRNf7USG5akobAhwcBpiU5GRVEt1Bs2HSV7N
 whhI14+rrqM6kcv10DNsh0QhGStnaqdyYdTxO2CPKY7WEbE4dpXM189K4GEqKMS0h8
 fMIiYDJLyYA5TRb+9mhNtnACMzMZlWWPqX5eDegXzwIjz60hYS2dteDZZb3HyVE9BZ
 PSpDWCFeb0EOQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F0A817E51F4;
 Wed, 25 Mar 2026 08:59:45 +0100 (CET)
Date: Wed, 25 Mar 2026 08:59:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad Dybcio
 <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, Chris Diamand
 <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v5 5/9] drm/panthor: Part ways with drm_gem_shmem_object
Message-ID: <20260325085941.2bb68de5@fedora>
In-Reply-To: <acMpCVRIV2E4KqJB@sobremesa>
References: <20260309151119.290217-1-boris.brezillon@collabora.com>
 <20260309151119.290217-6-boris.brezillon@collabora.com>
 <acMpCVRIV2E4KqJB@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 25 Mar 2026 00:24:14 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 09.03.2026 16:11, Boris Brezillon wrote:
>  [...] =20
>=20
> I suppose this should be drm_dbg_driver() instead.

Will fix in v6.

>=20
>  [...] =20
>=20
> I think you forgot to remove this comment in the last commit in the serie=
s.

Oops, again. Will drop it in v6.

>=20
> > +	ret =3D panthor_gem_backing_get_pages_locked(bo);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	sgt =3D drm_prime_pages_to_sg(bo->base.dev, bo->backing.pages,
> > +				    bo->base.size >> PAGE_SHIFT); =20
>=20
> I've always wondered why this function is called drm_prime_pages_to_sg() =
and not just
> drm_gem_pages_to_sg(), since it's not only used for populating exported p=
rime objects,
> and also I suspect it might better fit into drivers/gpu/drm/drm_gem.c (sa=
me place as
> drm_gem_get_pages). Anyway, this is probably beyond the point of this ser=
ies.

I'll keep it a prime helper for now. Feel to propose a patch to
rename/move this helper though.
