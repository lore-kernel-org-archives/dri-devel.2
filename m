Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE20A105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4432B10E153;
	Fri, 13 Mar 2026 14:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="EOtiwYCy";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852BA10E153
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:16:37 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso19318155e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773411396; x=1774016196; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mnpDHzgOe74WRGFTIk3h6ic8yUsqzDKHhMjCVfJQlWo=;
 b=EOtiwYCy1qwSoWduiq31m5X/u6vB0yfMxObg4Z1dzVsSqc9Qig4m6RWf7U51B+8XZT
 ZPgFVphqh9vj5rbtQnhrH63SqLtgaRdhh0nX8XKHNIj2bcvKHJ4cDK5cPAXzxQYphYLj
 VklZehpmJbEtIch268NmDuVG2/OB2nVkpUdDA4O1BqNemjY07OSE+eRfzvONErX3Pwd7
 pKu79BAOptcUQtKaxOZqbJQyE8QitnAekXFKrhHjiUTVM5du9iELS9yHLywOK7Gk6ERD
 5xrLc6s1SpU5ba7S/dvqdshhoMiSNxIYjWQwNTXc3J04A92ERy4DnqXmNbsBMmVzaLAR
 OcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411396; x=1774016196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnpDHzgOe74WRGFTIk3h6ic8yUsqzDKHhMjCVfJQlWo=;
 b=oaT1EaPgop9A5KYm2OEqsK/CBQh1IFdEV33v/EljjNrD1max3DZCfRRXak2IJJh95R
 DcgOIccjZDWkT2vgB7RUtNV24ZqWnZpK09Jnan7kN4lGgN1sH4WUIae7K2YnneB1Qq/W
 orA76YPA2JtdXTonmNkM3gwubQvz7AOxekTO8rJBX8Uxev4DCHBdJ1uhyjMetyhxkCBZ
 QmrRc6BoZi1Ehj+I6AOLs3X/bbZWqIclvaW5z7SAJqSZZEBFqvJL5og3Q/kaDUKflGuR
 CjeixV2PePROJo5xcrcl9UQUEGsCjVeiegTDHaREiNwgYhalILxX/r+VEi2LBxzgwdWr
 DD7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4CaS9uJRlCAnbgq9CAwDrjzHTjlsJXC+N1TC9Npxb7DI1ORRRfmbACDbv9M4uiduL7kM+88DDy1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/AmXvQtY0PcUErADJLPTY2NzmEQ9e6kE+CD4VE6dN3VuRbNR3
 X2ETLmiWTvqPgpj5agMO9OgoPPGs/fBur4WacbGdOC47oIV4Hqi8kP1sD+GfLhueUio=
X-Gm-Gg: ATEYQzxtqtZZ9GraWkk1CA++W1srRl1PZpnHdico7fWpAxY6u5IIHH8usuAtrPqTwTx
 swYcJP7MldVxa1NBfxna3vXnsvJfVyVe/X6ng5oCp8zqtGnCbJt0q+PoMCkAQyEILe0gHYaBpvu
 uADplQBJBU19DYnhxsVYd56nVlvAxnb1hYDgtcgtC4ZosP9w73A/ObSpa2YTKdxwX1l/gWa4Ua7
 GkmtRaI3sF7d5Kc3E9MmlF4bMRhqgjiO55P+asJbUQfcjA5SJyEGRt2+/xMzXqMGOD3WNxLv2G9
 j1aG4wl88LDd+fUKgLO6ExKr4569iO2oXOMPrEJ9J2YYCk5KOtYjpQv4gAewSdmpu2IOb1JS0RW
 M+90+BEyJSDN0+BSTCp28AsMbup+b02Jom7GRUdVa9FNy8lpwAckrvOM2Vo0TlP+B9/Fx12PVBg
 0zbF3lvhzXv9OEw+Xq0NGc+bMxdqwtiEWFLpS9YTB11iA=
X-Received: by 2002:a05:600c:c8f:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-485567102dbmr54306245e9.31.1773411395841; 
 Fri, 13 Mar 2026 07:16:35 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a7473fsm20378915e9.14.2026.03.13.07.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:16:35 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:16:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
Message-ID: <i2n5xfy5fmb2vwbh7xvyjmrz5vn35i7m7yw6uom3vmgb2l6xzm@rpgdwahd2lt4>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qk7fhcgdatjkm2b3"
Content-Disposition: inline
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
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


--qk7fhcgdatjkm2b3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
MIME-Version: 1.0

Hi.

On Fri, Mar 13, 2026 at 12:40:05PM +0100, Natalie Vock <natalie.vock@gmx.de> wrote:
> However, if we always calculate protection from the root cgroup, this
> breaks prioritization of sibling cgroups: If one cgroup was explicitly
> protected and its siblings were not, the protected cgroup should get
> higher priority, i.e. the protected cgroup should be able to steal from
> unprotected siblings. This only works if we restrict the protection
> calculation to the subtree shared by evictor and evictee.

When there are thee siblings A, B, C where A has protection and C is
doing a new allocation (evictor) but hits a limit on L, what effective
values to A would be applied in the respective cases below?

Case 1)

  L    dmem.max
  `- A dmem.low
  `- B
  `- C (alloc)

Case 2)

  L       dmem.max
  `- M    // dmem.low=0
     `- A dmem.low
     `- B
     `- C (alloc)

I think it should be the configured A:dmem.low in the first case but
zero in the latter case because M has no protection configured. -- Is
that correct?

Thanks,
Michal

--qk7fhcgdatjkm2b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabQcPRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AihigEA7S5/eGi7CUo6G5Djg4xg
9dznGGlnhpGROtGoQKrUZ4IBALiR7cNoDRQmN9UVosOVh7epArBPYmPoYaZ9MjNw
ZBgI
=polY
-----END PGP SIGNATURE-----

--qk7fhcgdatjkm2b3--
