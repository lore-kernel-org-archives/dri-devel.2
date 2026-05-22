Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D05CCD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 15:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66BC10E41E;
	Fri, 22 May 2026 15:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bspYsZr8";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E17810E41E
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 15:26:20 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso78493075e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779463579; x=1780068379; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1vEySuvchtiTT5/Luvk9UxfuyTrDBUvQ3fx5cuplJao=;
 b=bspYsZr8I7z72mJllzVl0f+Rg+qiaS5SxcXp9kAE6vrs7zBZLLud0YCjd5s0S9hkME
 0qZtpRc8vGqPXo2KCNKl50IUrIW3SIgynvSZahD7/pw9LSooznmVYpFIFL2ul60Q4T7C
 /g+9xPWTOA+WSWWcBVO2HyzSXWE2IEL5Tb4Pn3W4u4XXSj2pDv7irYgJhA5UOc9r35RK
 RuPEr4M53sOLlC9I3H1SsBopNSZqC3ATnWQk9cuTjJanMH3hH9N3l+sRaw+frgB63BV5
 OWQciOQ8pHTCO7wcMQlfrROVBI6qCv3obcok9jT3NSAbO0yM8CIx5/0QLBJOrXi1X2dd
 +v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779463579; x=1780068379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vEySuvchtiTT5/Luvk9UxfuyTrDBUvQ3fx5cuplJao=;
 b=Pa2Hre2DzoHe72BFKkp7tKKhSiRY0FEGEZBIIQQK6waFahySQjy7t5YCUuGjlA8Oj6
 2uwt/15Np10rKq6/ARY2IvbRsfSDb3CheoFXi2mfRRdTnLakXxnYpsFjKVqxEKgW9f4d
 R6dm6EnpaivjSgThMj4Vldiwh2L0l8YliFWd4ZZO1UWAiq2rHz3XKpjPj/8ZLVjeH/9Y
 Ezqs7FLy+bMbH5G5gvzZDRr+RucYimOQIu2FSQsOZMOScqILNvwGdtwo7ObB5Z6t23V6
 +opaPoXHszaeuSW7nzDzatcaUyFc6xpLs1Y/puJZciBhL/+gRt6+JrIyXUdbO75ocISt
 1IlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BTMc1vVzvzpA/ZglcHB+4D39MHXhmn83rL6sm8Fp7A6oyVgdwQ3BCYEf0coXtgk0hgGD9A07xGyI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbXwBu+uzTIpWSUGG8mtxmgYGER2gZJrLRggwkBCGfaEIrISTU
 ymvdIjFlLDa+QBecYoYg3OFKXPsUf3z7kfUvGvJSSJOy7ijefcobmPqAofOlijGVQNM=
X-Gm-Gg: Acq92OF/gwM5Fkfd9x+NL0AsjuGyo1WWj3h2Foht9wDMS32Zc/sx7GL5+fHH4fGbaDk
 +v/F/Bw+34tpaRu0JqBNW1PQeDdwwq9k9BgNxdOu+bwwBWypwzai4QcYX5tu3jqDdy1AzWChWbz
 4RJrxAACdKah8D4dTePBHFbzEwPU9Yzprsmfzf1ZxqGO+5AYpfq2cUtr4kNQXKK/EHLF8CphAb4
 9n6hMTzIboKpHHMT3PNZ8UYFXIpqMCWMnkbOk9Vjx+xbfbBubn6OcT+wazMvmUBR6tnAdVfNr4S
 1gXEN1DhUxYqphgQv+gJgSR+sXkL+MbD9NQOpseKkgPby+SHirSl3d3/OMUUoeMTSo7csB5I//r
 BrGEXDi/yGm96dytk1seislCh9ymt6UgR2SGlRS+cyTRR81KBShzwxe2by6qaDRoxmDyqak+1Ec
 YhwWUrvq6Eb4CuylaxPqnHE1YVKHYZ3RJJE8hv0cjE4YA25D4VOeViSedhuho=
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-490424b3c7fmr53184145e9.11.1779463579036; 
 Fri, 22 May 2026 08:26:19 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b82sm53694435e9.9.2026.05.22.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:26:18 -0700 (PDT)
Date: Fri, 22 May 2026 17:26:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <ahBxB5a9sX9DEWvl@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="af2hel7jza3hmfqp"
Content-Disposition: inline
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
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


--af2hel7jza3hmfqp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
MIME-Version: 1.0

Hello Eric.

On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> configure whether allocations in a dmem region should also be charged to
> the memory controller.

This kinda makes sense as it is not unlike io.cost.* device
configurators.

Just for my better understanding -- will there be a space for userspace
to switch this? (No charged dmem allocations happen before responsible
userspace runs, so that the attribute remains unlocked.)

(I'm rather indifferent about the actual double charging/non-charging
matter.)


>=20
> To handle inheritance, dmem adds a depends_on the memory controller,
> unless MEMCG isn't configured in.
>=20
> Double-charging is disabled by default. Once a charge is attempted, the
> setting is locked to prevent inconsistent accounting by a small 4-state
> machine (off, on, locked off, locked on).
>=20
> The memcg to charge is derived from the pool's cgroup, since the pool
> holds a reference to the dmem cgroup state that keeps the cgroup alive
> until it gets uncharged.
>=20
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
>  kernel/cgroup/dmem.c                    | 158 ++++++++++++++++++++++++++=
+++++-
>  2 files changed, 178 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a89=
14d3033e8e42359 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2828,6 +2828,29 @@ DMEM Interface Files
>  	  drm/0000:03:00.0/vram0 12550144
>  	  drm/0000:03:00.0/stolen 8650752
> =20
> +  dmem.memcg
> +	A readwrite nested-keyed file that exists only on the root
> +	cgroup.

Strictly speaking this is not nested-keyed but flat keyed [1],
which leads me to realization that this is the first instance of a boolean.
All in call, such a composition comes to my mind (latter is RO):

	drm/0000:03:00.0/vram0 enable=3D0|1 locked=3D0|1




> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char=
 *buf,
> +				       size_t nbytes, loff_t off)
> +{
> +	while (buf) {
> +		struct dmem_cgroup_region *region;
> +		char *options, *name;
> +		bool flag;
> +
> +		options =3D buf;
> +		buf =3D strchr(buf, '\n');
> +		if (buf)
> +			*buf++ =3D '\0';

I recall there was a discussion about accepting only a single device per
write(2) (at the same time I see this idiom is still present in other
dmem.* files, so this is nothing to change in _this_ patch).

Thanks,
Michal

[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format

--af2hel7jza3hmfqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahB1lBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhJyQEA4ebIAV+4wgYjb7Cax+hS
43nEgrk4mA0GQOKjivEd/KMA/A581miemqm16N6I0lzKn9Fm64QJ/G5K9t45IDQW
dr8L
=9Z82
-----END PGP SIGNATURE-----

--af2hel7jza3hmfqp--
