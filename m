Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BA6E9DE68
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7748B10E76E;
	Thu,  9 Apr 2026 08:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HAXYGnzN";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DL5Ht5qp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1904C10E769
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775722520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=cgrA7bBT8ZXCQqWY+bO1JlCg1Ecm798GETsxCdNk+V4=;
 b=HAXYGnzN1jmlSW8Q8yZSRhphJLwq6JZYUuyb+64tqlqxQeZi//T78nfGc55WSrh+y/fN7T
 5nIYHhtRNkz3SdxDuX4huye8L3V/tHvoOXgIK5hOSA/tqtOWthb0cY0tqEOlgUzWHXjoCU
 SMTJDY9I7ylTnz9XYYYZ4/UL/5vnJ6w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-tTDh0Yt9PWC63AxfHkf3-w-1; Thu, 09 Apr 2026 04:15:18 -0400
X-MC-Unique: tTDh0Yt9PWC63AxfHkf3-w-1
X-Mimecast-MFC-AGG-ID: tTDh0Yt9PWC63AxfHkf3-w_1775722517
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c82b4701so3757705e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775722517; x=1776327317; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgrA7bBT8ZXCQqWY+bO1JlCg1Ecm798GETsxCdNk+V4=;
 b=DL5Ht5qpgzhCKvaQvy2rYKJQKgmZOQrfrdg+yGc90z6upgyrSnO84xj2GzQCeei4eV
 CPTStztFqwAf9f+91FKgLTMmRq/ZgfaqbI5HLUixA27iVVcDbORnBEwmgoRTTtBnbR8Z
 g1D1I6NAJmEl9B0YIGL/Hok+hbOowSOrnoZtT7ATCYzk3OrMhoORgbNDeFf0ne1R3moI
 99f/nrfzZsPC1EVLCHge7I1Vjl7wnHtruIsGuj4oIVtrg2nLi7pWw71KcFdgWjk8R8rA
 39xG0hErPqX3G7KagLZgDgCeoGGSU/CnXOx4kTakhPbqXEV3XpD/vES2wt0xjnFkGr8J
 UD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775722517; x=1776327317;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgrA7bBT8ZXCQqWY+bO1JlCg1Ecm798GETsxCdNk+V4=;
 b=dSJiGLqeAZNy2/qrXFkJVJuMdwVJiQUKT3jbucLBv4CNoTIdHzcZFPyCVw/bZWtMA5
 WPxagku0OgQMUNobI3pvlt8eHFC/EiOgmioNgO+1qOboTUcioGdqsKFpt+V8JSLdcZE0
 whx0KRF0JAafp/KaXX1DEY/q8Xv4pFvHqJcHEYwZq7bfnyccbhL5U3RLabQJIgviKkcA
 Uzvck1fYax25ThKrlzT/MTLViEGZqBwHF5+kEtWB+Pm6vytaHFUHYZGIrF7YCO6R37Wp
 FuxOESi7ZgrxdCXAY1ysJ17JwS3lTjFW1pb/OTuhjH1lHm0Mxci03hhSOGvcpu5ptzy4
 AwCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZMWCBjv6OzZHC7irdv4BLweFHpSP/13/t4pncVAgmlfk0C5eBG0HDJEcM9ymkvy3GjsYqEpJYlLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmi1jHA1MMm4QUXEEieZ+krDUpW3kee/FwTigWOAvbg8ABcQrT
 +7I7qNM+J3o0FhOndQkMNHbIsypmY2BIN04g0eq4nbScFtOibCULN+N897Alc1olC3RyvWSseaK
 r6Ff6/JDeDxRs9K4LECZaVSq/TbdwxaeoEHEWIFf/EHCBL+sx/B3sz75fiWaEffRmhAGVNg==
X-Gm-Gg: AeBDiet32z0kMYuOTARDqgyRZYnRq/7/OzQCyAJaPS/Z+7ixhWLWM70tyU3alDJqCxU
 mOz/PwVc849PffF89IMZ10wFpwj0yldYbcUiaypc0FjxSUtsBLOrmD4ANso/CNRnRBR2VBfPN/z
 +DsCuoEZCg0RWSIDVcNcikJT5Pi/zHKhLPSHhRrSS3EHSbJf2R2vg9gOmGmjwaQnWm73CAqRpeJ
 G/zRYVqH3YLWi7OroUV6M5x6nWnV4syu7m2GplsyOQ6VHCew8S6gBEY3Pk38DDlYXyK5MGjYR1P
 Fmevxpawfri0GmjbCpolFOLoFQPI+RvvHKJyg2OEFhljjQsQTMcLVqDmtRwpPBobY50kQuWp7o1
 njcxCEZr800Hgy0tC
X-Received: by 2002:a05:600c:c087:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488cd50f45dmr21727355e9.2.1775722516982; 
 Thu, 09 Apr 2026 01:15:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488cd50f45dmr21726855e9.2.1775722516410; 
 Thu, 09 Apr 2026 01:15:16 -0700 (PDT)
Received: from localhost ([37.221.85.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd2492e8sm54399245e9.15.2026.04.09.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 01:15:15 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:15:10 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Dave Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-fixes
Message-ID: <20260409-omniscient-tomato-coucal-edbadc@penduick>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zyi5rrtfb4irsvwy"
Content-Disposition: inline
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


--zyi5rrtfb4irsvwy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi,

Here's this week drm-misc-fixes PR.

Maxime

drm-misc-fixes-2026-04-09:
Several fixes for v3d about memory leak, runtime PM, and locking, and a
Kconfig improvement for ethosu.
The following changes since commit f8995c2df519f382525ca4bc90553ad2ec611067:

  drm/ioc32: stop speculation on the drm_compat_ioctl path (2026-04-02 08:2=
4:55 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-20=
26-04-09

for you to fetch changes up to 857fa8f2a5b184c206c703a3d9ce05cea683cfed:

  accel: ethosu: Add hardware dependency hint (2026-04-02 15:18:14 -0500)

----------------------------------------------------------------
Several fixes for v3d about memory leak, runtime PM, and locking, and a
Kconfig improvement for ethosu.

----------------------------------------------------------------
Jean Delvare (1):
      accel: ethosu: Add hardware dependency hint

Ma=EDra Canal (4):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

 drivers/accel/ethosu/Kconfig  |  1 +
 drivers/gpu/drm/vc4/vc4_bo.c  |  3 +++
 drivers/gpu/drm/vc4/vc4_gem.c | 19 +++++++++++--------
 drivers/gpu/drm/vc4/vc4_v3d.c |  1 +
 4 files changed, 16 insertions(+), 8 deletions(-)

--zyi5rrtfb4irsvwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaddgDQAKCRAnX84Zoj2+
dq+8AX9h1JYGdlhW52Zj4EWdoRxaJBWxFCZNyc2xQBtzzr6NTN0KeIhc8MqhmQND
y5WSyc8BfjOYEMehb2BhpAw/A0qZZRSRQKeXskcw87pwZN0wPA1CLGL2lEl4E/RP
Hy3M+KMS/w==
=ebgs
-----END PGP SIGNATURE-----

--zyi5rrtfb4irsvwy--

