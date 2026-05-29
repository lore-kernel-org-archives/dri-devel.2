Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06295CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8D511204D;
	Fri, 29 May 2026 14:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="F7moANIB";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4676E11204D
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:52:21 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4905529b933so56705305e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780066340; x=1780671140; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pmSOuhBgxBhu7Is1B1Rw2/yoQpGrUuGnNNhQRjRyvrQ=;
 b=F7moANIBJrvGrmWhHkgCD2SvwJVS0qzj4C+K/fueJwxYICwxG876iY2I+XUt9tGdk4
 v0iUcKJMXSYVVkKIQf62UkrpDBiXJcovoOaVxnDZP+z9Cc/ob4To6o3DNat39uxPBSUW
 aMclv1IP7FQB+8OA3UBNV3SEPQFI87KaU+OgIihxfKPzzwTMies30RELRq7j/fX0dCc2
 Qp2B20HJNI17HEc+PiqL+GAX+Ca/U5c6HMD3PtRa8E22eJDKli55SkVsr43vXSdbnK/H
 tx4b0lT9xgBPPNSadTlwR1mxXha8vCiMBujBfkuunl3mcnJb8+vUKONsaNysxio8btmM
 bjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780066340; x=1780671140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmSOuhBgxBhu7Is1B1Rw2/yoQpGrUuGnNNhQRjRyvrQ=;
 b=HyQhF9Ka7hvZw0GU0zHj/XwfRO8Hk+jJkkAEa3rsMGaq/nAzhFMUHEMRmF8VKqcHME
 CqD287968sPG0tSUTPhL90/OLZIgxXNyFsEMX3v8sS2N8MuviF49YVFUnaXjuPNGX1pe
 V7lK5h30dSGmsd/wR07lgfumx5kJByGUmBy0IWgQPz966TmyzkeyKIHltpOFPpc1iZn4
 cFS9Kmx9ZfOl2Mv5TyQCOp/I5buJw1vLRYj1ZVIJHleC1Rds1yzveHekYSwOTZ4+C3Ka
 WiK7gdgbfyDGr95AlSfLp1WO4ePlyGULWZcXa6GM1Gw5LTI3tsvyXYN4+QQuoRqopJgH
 TlLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mVWSw6oYOGFDgHj3cS0Kw8FMuDaPsXMsNTIqxHKzu/7rh5hJ4JdaNGn5TWUHqIqByJPzGqU679ns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2KpZeMeosGhzmvXduP7sWHwc/+OUhYpAUloQJYItEwVpNjdxv
 4OEFEkgO7xzA5NkgA+DBIpD3z5Wt0RIuE/LcabUw8H4/r291XXnTDyQEb51f2A55KRM=
X-Gm-Gg: Acq92OEdmmMettaAIJ3xr7+35DKx/e7Ha5LD/uBI+rHacuqiuzOTyY+C92XnTNsEsST
 H84D/mONmz8ydSGXByluiwT+Rxm1jCebglMsRmYV4DlrrOoN9fHwl5Gct7cOMOPe9afWkVPxXnI
 uFGEp/3A8nPtN2yEMSIAXhfHYXa+KlSZxGulo/UNhoy7eUfbaxbQUAaWtlFGyagxZNua7uzPtGv
 BcUjpvQUlQwMUEcjCgFki04fisIcPLR7cAl9GGy8+xQEofT+Jj7gXh8oCSjnSAkeASJr8hMVvsQ
 zfISEPohCPxQdxwVv07hN45d3tfBXM8JMXUsIMYINJ4zL5sl2T1fwJEpTKDtvVElAsPvaB3AJ9h
 7eeiHOLGdLqdtd15rnNoKJSJAjnKGLr3pjEpUb9+cyEsX16ROd0+CzJjdI8cflr4BnLEeFqlPIX
 bpTcoAiwGU4pdoBpi7yKN2aEMUfvPk5Fiv3vXbsxAxr6qjVlyyz2/Rg/MNBE6jHx96tmCFog==
X-Received: by 2002:a05:600c:1453:b0:490:9536:c513 with SMTP id
 5b1f17b1804b1-4909c0b0012mr41744015e9.19.1780066339778; 
 Fri, 29 May 2026 07:52:19 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d696f25sm62858365e9.5.2026.05.29.07.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:52:19 -0700 (PDT)
Date: Fri, 29 May 2026 16:52:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahmceQfFPpXa_6Qe@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev> <ahWfypvuTVsB-pHQ@x1nano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rw7fy7kfpwloyodg"
Content-Disposition: inline
In-Reply-To: <ahWfypvuTVsB-pHQ@x1nano>
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


--rw7fy7kfpwloyodg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
MIME-Version: 1.0

On Wed, May 27, 2026 at 03:10:47PM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> but that made me realize there is a catch with
> this patch set, with something like:
> A: +memory{max:32M}/+dmem
> A/B: +memory{max:16M}
>=20
> It gets the CSS from the dmem's cgroup with
>   cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
>   mem_cgroup_from_css(mem_css);
>=20
> Which would resolve to A's memcg and not enforce the memory.max limit
> set in B when dmem.memcg is set for that region.

One perspective is that this is in accordance with dmem's limit granularity.
If the user wanted to distinguish dmem charges below A, they need to
enable the controller there too. IOW, the depends_on in one direction is
correct. dmem is primary when it comes to those charges and memcg
secondary.

Another possibility would be to always use the highest precision
available (wrt where current resides) and then the API should refer to
struct cgroup from task_dfl_cgroup(current) (and make this only
available on v2), or to struct css_set and extract respective subsys
csses in the double charging function.

In either case, it's worth mentioning the behavior in the dmem docs.

HTH,
Michal

--rw7fy7kfpwloyodg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmoHRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ahb7AD/ReCU/1qelso4Se3AlOZq
R+fmGmGVDlgPYs7gBkJUqqEBALvZg8zd4ig7QW/B4SdBdSv8RGm7SPB7R9vTNMP8
dKYO
=3pZx
-----END PGP SIGNATURE-----

--rw7fy7kfpwloyodg--
