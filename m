Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18B5CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4843E10E643;
	Wed, 10 Jun 2026 17:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="gVUaFQTu";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3AB10E643
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:55:13 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-9155183b42cso20842685a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1781114113; x=1781718913;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TFzr6Ap8q6XOCl46PeL7Sqp+9/TMWSjPVAD+5M0vgVw=;
 b=gVUaFQTu8kffZkUdkm2f/c59mLCKFgpeJ0XZGSJ5d2t1oYmyM0d18PHNQSgWf4bZxD
 yTDQuImBCWGiFI0IVXXbWZkN+c4y7vH2E4xlcVBIN2xLAmcK5wbHpBVhQYM3r2gi73Vj
 Q5lu5QbYDtVwUpGjRRhl+YY5AR3WHAIhdekFDwXvQZ12H7INXfeN7RRUTWbl7aQlYKJz
 DcSeVH1wV3kxVXf4cQYZ7DBWYZLP2gh2W34nNglw94a1lpHKwwVUYuyrTsQoRGhHKrbU
 YeICzJ6F/0nqJuctt72Qmhsr6uC3dKIYtEPHKGe83Dr/FyzQrOsJ5gS4PML+Qyut0jzL
 wFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781114113; x=1781718913;
 h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
 :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFzr6Ap8q6XOCl46PeL7Sqp+9/TMWSjPVAD+5M0vgVw=;
 b=oqovpNShkp5CvtmV7IyAKQls841vQ1sdJJN7S8ThHtQOiYTYRuC/JfgiXURLPoIlkW
 Fwhko15yG8c52E5tjyiWWy6/fdljzosp6k9fGA8iutdTQ90kKdxi0emvQEeexPGgziA4
 PuDZjT27p4xKNkzmbG8yc98/mYgrLqJaPzhnoA3GaNj5xRVextKkcCwKLLHG5VC1+RXa
 OpUYGO1DcZgVha+2pIV6jaQSxd98NGobDLVtWljyh2NxdHY3Qe7zXBwXPRNPnrJBJqSw
 XFBjNt0nEy56CrOgvRoWRDG73QMljE3eRBbLcw6rPOlDZH+70om6EhkR9AG9VsD2ohs6
 1vsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BTqfUi8yCv6sikuQMSDZI7t4u8x8/hdbEyo7PzVCGySJs1phMCgnR6Bmog6yEg2J8luYaUYTUy2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtJJGOM3BoyftJoK7L6D4Jv1UVig7ZMGO5r7JyPvfIyF9SVRur
 68eBA7hQ9e8/pn35/37EzWdA7Rb+Wotcwy9KsllHtsG5FP8p3nSicIXXF/cdBRKY+MU=
X-Gm-Gg: Acq92OHEaBN8dAeCSlxrAY38pT6XlB4bdx/7wneDe/vm3oYHnYTpfbQk7W0gacRHDcQ
 GrE/F4X4VHfxLjO69BHRMBEg1Lmxn26uo6qUi/Hx9o7W28bH1jn0srmL5VDHLVA1Rofh1toSLCk
 gYhwIPI25jU11FqvkKX1W/ZT8B7mjWuKOh+ypDf4IzNeIskaVvsjgYko+clLd0EhNEdtdKt5AKc
 2Sdfn1KxCWpSm917wR2i8VgPvPnM3Y00wVD09QBIWcf1dNXolh8AZ0fAm479NRrhVDCFtKE0rEy
 SbCR3AU/7Sf7ejIw0VmHOpphBbznRkrGo4Pqf6eRif1hCW3RzirDSuwmvaAHzHPc1AoZUOaiee4
 98DgQVsW5QH6P44yIiph2h8eXQB7ulS4Kpd7h8Zpgd8KrAHx1BQT3Aa6UVVtG+2NGu9czoi4W9A
 //Fp3L06Rc5MROwzOl9uaxC4xy9MSLcxeMtGPWvkisUwD+h+52VVqmnd5dp1vNnyqvcnp2fz1ey
 c8AHjc=
X-Received: by 2002:a05:620a:4625:b0:913:dcd2:f117 with SMTP id
 af79cd13be357-915ad2f40aamr3123760185a.24.1781114112689; 
 Wed, 10 Jun 2026 10:55:12 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b:3a7c:76ff:fea1:2ac0?
 ([2606:6d00:15:e06b:3a7c:76ff:fea1:2ac0])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a21f871sm2515222585a.12.2026.06.10.10.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:55:11 -0700 (PDT)
Message-ID: <0e3b9cdb9d8bd692290dfabafb32d7faa5bd50f8.camel@ndufresne.ca>
Subject: Re: [PATCH v6 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: ZhaoJinming <zhaojinming@uniontech.com>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 stable@vger.kernel.org
Date: Wed, 10 Jun 2026 13:55:09 -0400
In-Reply-To: <20260610071045.3414828-1-zhaojinming@uniontech.com>
References: <20260610061915.1CA281F00893@smtp.kernel.org>
 <20260610071045.3414828-1-zhaojinming@uniontech.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Xq/WDBnnQBcMXRcBkujo"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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


--=-Xq/WDBnnQBcMXRcBkujo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 10 juin 2026 =C3=A0 15:10 +0800, ZhaoJinming a =C3=A9crit=C2=A0=
:
> In rocket_job_run(), after taking an extra fence reference for
> job->done_fence via dma_fence_get(), the error paths have three bugs:
>=20
> - The dma_fence reference held by job->done_fence is never released,
> =C2=A0 causing a reference leak.
> - pm_runtime_get_sync() increments the usage counter even on failure,
> =C2=A0 but the error path does not decrement it, leaking the runtime PM
> =C2=A0 reference and preventing the NPU from suspending.
> - A valid but unsignaled fence is returned to the DRM scheduler,
> =C2=A0 which triggers WARN("Fence ... released with pending signals!")
> =C2=A0 when the scheduler drops its reference.
>=20
> Fix by replacing pm_runtime_get_sync() with pm_runtime_resume_and_get()
> which auto-balances the usage counter on failure, releasing both fence
> references on error, and returning ERR_PTR(ret) instead of the
> unsignaled fence.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---

This is a lot of versions within the same day. You should slow down a littl=
e so
a human can provide a review, and also document the differences in this sec=
tion,
after the ---, or using a cover letter.

Nicolas

> =C2=A0drivers/accel/rocket/rocket_job.c | 19 ++++++++++++++-----
> =C2=A01 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c
> b/drivers/accel/rocket/rocket_job.c
> index ac51bff39833..e8a073e22ac2 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct
> drm_sched_job *sched_job)
> =C2=A0		dma_fence_put(job->done_fence);
> =C2=A0	job->done_fence =3D dma_fence_get(fence);
> =C2=A0
> -	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> -		return fence;
> +	ret =3D pm_runtime_resume_and_get(core->dev);
> +	if (ret < 0) {
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
> =C2=A0
> =C2=A0	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group)=
;
> -	if (ret < 0)
> -		return fence;
> +	if (ret < 0) {
> +		pm_runtime_put(core->dev);
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
> =C2=A0
> =C2=A0	scoped_guard(mutex, &core->job_lock) {
> =C2=A0		core->in_flight_job =3D job;

--=-Xq/WDBnnQBcMXRcBkujo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaimk/QAKCRDZQZRRKWBy
9GXRAQCaqFjOga0b8AcWUWyj7n1hBiojgtP5sEJWopdr9ZDLTQD6A7XpFDMgyJa4
NJEu5ngUhgE6hDlNbS+w6OnOyC7oRQI=
=G0Lr
-----END PGP SIGNATURE-----

--=-Xq/WDBnnQBcMXRcBkujo--
