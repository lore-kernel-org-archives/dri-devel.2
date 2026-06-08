Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFFACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5792910F682;
	Mon,  8 Jun 2026 16:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XIwDP4eZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A3910F682
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:06:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6383434D9;
 Mon,  8 Jun 2026 16:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1631F00893;
 Mon,  8 Jun 2026 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780934791;
 bh=k8eEHNk5V2Dx8vcrglKxGZVmD5Ir3MJRTEqprQTSb9E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIwDP4eZwupgs5/QB/XuzAfd2FCFspvrVP+rOH7OUC7cUm+fAoxLFJZPN3LqHhWJK
 tsu8zQy2+ce1LzVRXUgfcnyk5bGBli5Obp6XwAc/qk9c4+ghPr0KGEgpgyw5JB7e0H
 i3y9+YaqgDatQH3kA6oWieP6KD0VAWsHq8+zZw8yOUkhtKy62tWBAP/OcwyMbgI2dB
 LYQOm+fjZaNqDoyZurFGf1OV4O9NTC2Fmm8rVE4hafXsFyGakTprTQgVXQkn+6byD2
 AKJR6txtEdgul1Fxl/3y6qNwEMkDfWfCaXhbD1vjbJk9JwXv9eznne53qvPG5j9Izr
 EajQxuulj9Unw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cgroup/dmem: accept only one region per limit write
To: "Eric Chanudet" <echanude@redhat.com>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, dri-devel@lists.freedesktop.org,
 tj@kernel.org
In-Reply-To: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
References: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:06:30 +0000
Message-Id: <20260608160631.1D1631F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite spin loop in `get_cg_pool_unlocked` if memory allocation =
fails under memory pressure.
--

commit 04831a5f7efe525cb1eb2645936fd7233c21b4bf
Author: Eric Chanudet <echanude@redhat.com>
Subject: cgroup/dmem: accept only one region per limit write

This patch changes the UAPI for dmem.max, dmem.min, and dmem.low to accept
only one region value pair entry per write. This simplifies the logic and
prevents partial limit applications that could quietly change state before
failing on a later entry.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f2711..542a5d387b551 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
[ ... ]
> @@ -728,57 +728,38 @@ static ssize_t dmemcg_limit_write(struct kernfs_ope=
n_file *of,
[ ... ]
> -		err =3D dmemcg_parse_limit(options, &new_limit);
> -		if (err < 0)
> -			goto out_put;
> +	err =3D dmemcg_parse_limit(buf, &new_limit);
> +	if (err < 0)
> +		goto out_put;
> =20
> -		pool =3D get_cg_pool_unlocked(dmemcs, region);
> -		if (IS_ERR(pool)) {
> -			err =3D PTR_ERR(pool);
> -			goto out_put;
> -		}
> +	pool =3D get_cg_pool_unlocked(dmemcs, region);

[Severity: High]
This is a pre-existing issue, but while reviewing this call to
get_cg_pool_unlocked(), I noticed it might spin infinitely under memory
pressure instead of returning an error.

Looking at the allocation fallback inside get_cg_pool_unlocked():

kernel/cgroup/dmem.c:get_cg_pool_unlocked() {
    ...
    while (!pool) {
        ...
        if (pool =3D=3D ERR_PTR(-ENOMEM)) {
            pool =3D NULL;
            if (WARN_ON(allocpool))
                continue;

            allocpool =3D kzalloc_obj(*allocpool);
            if (allocpool) {
                pool =3D NULL;
                continue;
            }
        }
    }
    ...
}

If the system is out of memory and kzalloc_obj() returns NULL, the loop
condition while (!pool) remains true because pool was explicitly set to NULL
right before the allocation attempt.

Will this continuously loop and re-acquire the global spinlock without ever
propagating the -ENOMEM error back to the caller here?

> +	if (IS_ERR(pool)) {
> +		err =3D PTR_ERR(pool);
> +		goto out_put;
> +	}
> =20
> -		/* And commit */
> -		apply(pool, new_limit);
> -		dmemcg_pool_put(pool);
> +	apply(pool, new_limit);
> +	dmemcg_pool_put(pool);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-cgroup-dme=
m-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com?part=3D1
