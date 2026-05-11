Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB4CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDFC10E76A;
	Mon, 11 May 2026 13:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="fTG+69tn";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8158510E74E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:03:04 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso3775973f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778504583; x=1779109383; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cxhetvbt5aC7n/fJp1v/wYxNwfJm1Klb1mbxzE4ftzI=;
 b=fTG+69tnoRVs1MS34KtLYaTiw0I+Gckod0bAujndQInvzD1cMcVqvc8uucp99G9mK+
 q4XEp4ldH1RAd0guFFxei4zM37aQwo94Ehc2lBvAxI+5IsKa0TzpVcgCUMVelUKuMFwt
 FcPSHRKCFWgUjMsdcGl3UjMr2lmmQiiZJNPT4JQaneQWW+NpgcFGxnO2TJcbDcvkmYeg
 2MFVI+1+NI6fUTgvaUAlvMPmWZpSBvUhsz7wgQgSvGDOLY3jEsmb+lpAyFp2DmV4Brjh
 cQkuZL8WOatVyW/PX8DdcDzjWXTwKgux/KHqqEH1mLI1mj+WM6odAKGxgNDxhkuHtR35
 K3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504583; x=1779109383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cxhetvbt5aC7n/fJp1v/wYxNwfJm1Klb1mbxzE4ftzI=;
 b=OkKLhQ19BPTHM/aWbN8COw3atWGL1jXhLMMlcCufOOKaCph9v48MHXAuIKUFfEzlGQ
 m/L73lT0Oepl3xzTbXSskNHROkx5gxcuY9viX9GvqsA89Wp5Ft5PM4/mfbYd4K+6mfpw
 x8I7cve5IKi7sUKYmDfU2JFQmSxH1+25scnjGX6KTWNz9T1ohaa8ThWCRm8YcFI2rK5U
 i+wb14rWycdqk+0OU5MgPGB/VDcdTm9x12W2mWCGaHy/T9ZQQugKnamMDucAjjdpq6Bc
 XLgdLWjsU0WiIeQva1f/ysB1Zm8o/4ZkCRT2N5vaEFMXy4mmC5cV+KmhgCcX7Swh+6vx
 PGLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8echqkAlugDG83t4Wgxbt1k+GV+PROrvUM74SKogy0oHgWGrWHK782AwPghUHimK7dmn858aEVtMY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF9oVElqiH+w9/H5BhTY/FC++iBFRYnWaWvrQQf78Vd6Hm+tcX
 kSBkkVznS8mwN8avCoHKanWtLcXXClfRxrb8yqAF+KqcCtBBq39IeRUnFigRFk2vQ/w=
X-Gm-Gg: Acq92OFO5RTBmgb8/rkOAsDN7w1tNSyuOoUT+nVlKtGLb1dGvhbmOcv/3fqVa35juqI
 t76X//yzkJPyNpzdWRtevkqK4wj11IvFuW8mkHPghafOXYW36+Hu8b6x6wRUzD/S+xKVOeQiP6p
 NhFqdnw63tAipPmU7uUpHILsPSKjHQtfU9jyB8NBd43Br3fCghmhBJM4U/hV+5Kn3T58jI/adoq
 X4c9d50sCTCyuf8o1ry/HMrZxvlZ7X/9vmHKwO3Jnh6eJDkxufWj6BdLiFeLGoXW51yHG4O9zcK
 eU7Ssr4RNf+nkJ+itf06EaAKgWoVAWMMhS3Fo0nK6ttY3fZ8g4J0kGTsWIohnt2JGHC0dMZglG5
 kWWLoy8ucgyK9S9GBgpaioPiXokoAiMjTW2j5PzXfZyXHHk55GQAQJnnHUo6PY4TnnIXFgDdNCI
 NTNVhuHbZJhuKIbJFNmSW0fYtdseEslW/fJddT3MRxTCzNB5lt
X-Received: by 2002:a05:6000:4203:b0:441:1fa5:457e with SMTP id
 ffacd0b85a97d-4515b61a4b9mr36482771f8f.13.1778504582762; 
 Mon, 11 May 2026 06:03:02 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm24633058f8f.20.2026.05.11.06.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:03:02 -0700 (PDT)
Date: Mon, 11 May 2026 15:03:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
Message-ID: <agHRj-idlMvSgB-O@localhost.localdomain>
References: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6uinpelgye7jcdhk"
Content-Disposition: inline
In-Reply-To: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
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


--6uinpelgye7jcdhk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
MIME-Version: 1.0

On Mon, May 11, 2026 at 09:31:50AM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> get_cg_pool_unlocked() handles allocation failures under dmemcg_lock by
> dropping the lock, preallocating a pool with GFP_KERNEL, and retrying the
> locked lookup and creation path.
>=20
> If the fallback allocation fails too, pool remains NULL. Since the loop
> condition is while (!pool), the function can keep retrying instead of
> propagating the allocation failure to the caller.

This implies that it's OK when the function keeps retrying with
allocpool !=3D NULL (and repeated WARN_ON()s)?

> Set pool to ERR_PTR(-ENOMEM) when the fallback allocation fails so the
> loop exits through the existing common return path. The callers already
> handle ERR_PTR() from get_cg_pool_unlocked(), so this restores the
> expected error path.

If the callers can handle it, maybe there's no need to retry at all.
Perhpas dmem fellows can step in here.

>=20
> Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  kernel/cgroup/dmem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f271..4753a67d0f0f 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -602,6 +602,7 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct =
dmem_cgroup_region *region)
>  				pool =3D NULL;

This 2nd pool zeroing seems pointless.

>  				continue;
>  			}
> +			pool =3D ERR_PTR(-ENOMEM);
>  		}
>  	}


HTH,
Michal

--6uinpelgye7jcdhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCagHTgBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgqmwEA5wxJxSP0xvsQWLhF6DF6
/dRYA2b3b0PxB8id+ffvCxABAJ76IV2uz63OS6i6C7A39HK9vC4KPqs7EQ8Gzz2K
YGwJ
=8kDw
-----END PGP SIGNATURE-----

--6uinpelgye7jcdhk--
