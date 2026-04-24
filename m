Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25893FED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746C710E3E8;
	Fri, 24 Apr 2026 16:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="MpeN7uA0";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF8510E3E8
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:33:28 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48374014a77so104902945e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777048407; x=1777653207; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
 b=MpeN7uA0ovuhwgxNHdX/E81XG0oUWtMlL3XIy3B3pXjmPD6sQobgfC147vnatpUfAI
 U7PNYL4tvV8np1hUVp4LnM9WMx3sR356T0b1CbaHfBHnAAUSyWWiu0PfMWhsjAi93DK0
 w3VJTcaM+j81yXX1z8t3tcT80dL+r44E8GSxpk9n6lkXtLNX/XebIGO50HgBjuJGSXmY
 qa4SH4XVm2fxQCz3EHGsQWFV5pUTPyzMWJ2zj5rjKY0cLywx6e2DKN4Ptbynk7TOceD3
 AhOYMUj+cWstCiTmH79TGMZozvMA+aaNq07EQmOOfPacTne7isFBmxLuzE/eKLIyEzW3
 Ss3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777048407; x=1777653207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
 b=AWvNNaIjhaj1NHmWhXu/Tzt1hcWrVmGvV8X7RAP+Cs+oVIQSecJqphNVTUqRVixB+2
 au3U7ZsHk+w1/DWCVFtE2HRZyVmi2T7yLKCYBPlOjrSlHXf5azN13xUD3DdMjqzubSkD
 X//5x8S0r+gJVfHvJkgkc7KHlUdgiIpuey1o9jHsIekEOHMGHQQn+yCiJHAHuqF4TSfX
 8Cp4u9xyfFdE6gzSV35ujUWZ9KArdjH2YRxCZ69mGipcGfZrj3Eb/24ibuu4kreXs5uh
 LEnURt1tQMVKE8NuKReJMZm60St4mB5rhbaWIlacTw2UK3O7C6aQeP/GT8+hWGD9sVJg
 F9Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Bej6/3qML4Hkl/IE7LyjhlouDSx8oU/71pRpnP953VuF/jW2yz6IugJ34xOVHGd9msXu6Twbmz88=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyrml0SD1DhWqfoPx/w6kk49EDznOpioHkavF1lA1uXYyEE+5tZ
 k0dIEuaij63SBquBDoLYov4BeRiOftjQx73If9oNB3poQX8MNwoHZDa3l4/ZDzN2vqk=
X-Gm-Gg: AeBDiet0NIJtsPb6SB0FaLu04Y3aK/yHqjE+aaBPKoM2Wh8GlU86Mo41UjqioulRVD6
 sbIjYmOBkM/Xz2LFLGk2iB1/8mP7EjrolkHRAeHEsWPhsjbdF3iLYxi/AlVXIKi6OakNJMns3Z5
 MREeohnTr/ALyFIAtKSEwr1bYmdeV9T7Z990dvIx2dHFHuWlicpJ5DaZ8Y9m3FXFfmH7rnGi7b2
 PwHXajnlJp4YaUUbVY94m62Hokrm3zgk4pb8G6Q1sNIUoCsHcI8eJy14MSAqKqkVkma3vSZjbUY
 c8Y9j1DsKaOY3uIkeNR7CkBhpE5u6q3yJDhGT3DdmEqBs7uUvIseBXqal0ZxSwpEqO91/CMzcYO
 c5x15umHYZldiOeb+Gdkjuumm4r4FuwnSTbX9wOXJVZpgr6WxMYJJ8eF04IdbhhRv8Fou9sXrpc
 f0OXLg4Gr8Jvxi7D0hYcd77mHmLYAimRWsatXXpKECWvzd7FFKo28ikQ==
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488fb73d9ffmr351003145e9.5.1777048406745; 
 Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm702405535e9.1.2026.04.24.09.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 18:33:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, 
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
Message-ID: <soifu3hpmugejzevzggs57dreexuoammqkufegpjfvr6dzkt7u@7chmb3ppce6d>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
 <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
 <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
 <8ecda206-d290-4895-bf57-346419afdc3c@linux.intel.com>
 <3b662522e17e380953d9b981d8c2febecf42455e.camel@linux.intel.com>
 <4f74cacc-ff98-426f-ac31-c25e6cbec314@linux.intel.com>
 <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dosxmscoevitfoas"
Content-Disposition: inline
In-Reply-To: <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
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


--dosxmscoevitfoas
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
MIME-Version: 1.0

On Wed, Apr 22, 2026 at 12:36:50PM +0200, Thomas Hellstr=F6m <thomas.hellst=
rom@linux.intel.com> wrote:
> > The task writing to max will not trigger a reclaim,
> > only set the new max value.
>=20
> I still read *synchronous* reclaim.
>=20
> >=20
> > But when a process, part of the affected cgroup, tries to allocate
> > memory,
> > it will be forced to reclaim memory until below max again.=20
> >=20
> > This is a workflow where instead of the updater doing all
> > the evictions, the evictions handled by a process in the cgroup
> > itself.
>=20
> But kswapd is still used to do background per-cgroup reclaim in this
> case, right?

kswapd is driven by the global zone watermarks, it would only reclaim in
the cgroup proportionally to its usage to fulfill that global "limit".
The actual memcg's memory.max doesn't affect kswapd, it's really when
reclaim is triggered upon hitting the limit from within the memcg.

(The background per-cgroup analogy of kswapd for memcgs is proactive
memory.reclaim but there's no dedicated kthread, it's up to the user to
decide when and what to write into memory.reclaim.)

HTH,
Michal

--dosxmscoevitfoas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeubUBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai0HQD+Jgif2K031TYm0YfdjAty
B0TzqcqwBBNpvrgnUgC67EkA/14ZknnuVjDttRPWZYhls33OFy1aAPEoFVVOc+Zd
XuMF
=AICI
-----END PGP SIGNATURE-----

--dosxmscoevitfoas--
