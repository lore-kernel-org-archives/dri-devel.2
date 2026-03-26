Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E034A109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A5910E9DA;
	Thu, 26 Mar 2026 07:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RkDKnAyi";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ukwtk/3e";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1746910E9ED
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774509472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=jiAy5WF94udF9XSc7HvqXP/pL3x/y3FMYCC0P8YcHII=;
 b=RkDKnAyiUese+DZGo+FLBq3sa1u3p/iV6tLXn6bXfwQTjKkpWaAC7KCVukMUyq5H20uAU2
 2DDTZ6dSAS5ZkNFIZZ5qlO55V+NsYyO2BJr43ORw2c26WiihG2DDF7dEhQzWU5PgDyLcHu
 fzV7e40XUwjN70K4C+AlNPQcA0B2a2c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-bz6HhpkHOPO2xLg2USJtPQ-1; Thu, 26 Mar 2026 03:17:50 -0400
X-MC-Unique: bz6HhpkHOPO2xLg2USJtPQ-1
X-Mimecast-MFC-AGG-ID: bz6HhpkHOPO2xLg2USJtPQ_1774509469
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48542d5aa9eso4899035e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774509469; x=1775114269; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jiAy5WF94udF9XSc7HvqXP/pL3x/y3FMYCC0P8YcHII=;
 b=Ukwtk/3eGpKE/qd/8IUnUVS8qQbrvXEGahb+hFIMFUiz5W4hTG7t0ahnJ5VA1+kRCP
 ZWegKy6EwmjV1oP5C6q98Y1/JCkLQGtHgAc6bW31wzk+6fHPrmmE0r1EIJ3J8ksTfdk/
 KIo3W03M3U0+DtCeVwbsy4aOyifEA05C1gjRWyZ6D4yOygDdG4fTf6aHzohPPC9eB3v2
 UQOzrLI2u+WR/JYlYBcTlpfZAhMPyK5G/G7iy2WIPw8Y17IK8FPiu9IPOWMpsKy7cTwE
 yQr1S+BXeJEUBhuSpwvL4f52JBGekIqH5AYzUBVB9mX7MmCbNZ2BPou6HFYnNB1/iX4P
 +nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774509469; x=1775114269;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jiAy5WF94udF9XSc7HvqXP/pL3x/y3FMYCC0P8YcHII=;
 b=bj7OSEDlK5LvqIsswAmwMDFn/jxjqaDGGrBtlIIJ8MKM/pMzSK6glGBBoMHSWMDpYv
 X7UJpnUSNzFCOiZDhm1oSLeawd2qOkO2XK+pPelWUWU5cYZafe1mVrzFKqkeq6/wYkQU
 jiYfqWbx5Fkid65Rf+yxT2CizzlOTvlOLwHJPkZEGpKFHIrwOwOWfuTjQCihl/54FFLo
 rx2Jq+KTD/50PTImALUI9nV7eQz8sBTr/XyTrWxYKEVE6o1z7ycUAYk7cxv13XvjesuE
 9oMcFtvqaORhFSN/45GrNdJYB8Qx1MIm9wYb8BVR9vh1AE9k3pOPyXd2IEYO4XS4lOgt
 vvxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF5f1BVjQPhqwWW0uz3maF+nRo5GgRDKxLc7dWhyuW4d6/D+vfZVjNlu/WvYXjauVBUVdtK+joyBI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyye61v6gOZLjrUHgIoVlOua9T4ylbIdLzh0CF7lsPF0ZQ5veoc
 pIEE5p5beXrU7IEr499Wx0JUXt3svhSUao+sdd5zRNYr1oA0i3z6fr1Zm5HU4p9LaPWl26ZPuum
 e4EYuVd9z6edn10PPXhoGUH/7I1DbQD2l7hKWHe9LZ/+bfsVNydNOuwzv3xC82MXTvZz1UQ==
X-Gm-Gg: ATEYQzzA0gDLe4xaP5D+o6j5KbhUCwgZ1MRK9gJkXMNcyEHpwU7CY2+VwmXEa9XqbNl
 eSDqZItkiQH8QlGhjeX54ZCazwUYJQrVjdQl4qA37BRlOfRB/Ub7PIE4oJ62GIj4oSbAYdNBCL1
 ndMOiW9AWfzlLUkfZHBCJ0FMHBs/GOaNNPDLuXu6KWApJz+8UnU0rNhY/iAAc4/88QVkmqVHSLx
 JITnXOnExZ2bWs9aPo+M5jk3dEe66agDx6LN/CnCsm4ZajhSEb6fVb7ptx/CwxV/rFnSMirlx2n
 8f7F7AdqHaR1jVegsWxvwJF+HwocKvZPKT1AVyFQNL0Av0WzIdp/IXf27p0rD7TVKyAltl+Ydg=
 =
X-Received: by 2002:a05:600c:1f13:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-48715f03a9dmr96582365e9.0.1774509468597; 
 Thu, 26 Mar 2026 00:17:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1f13:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-48715f03a9dmr96581895e9.0.1774509468078; 
 Thu, 26 Mar 2026 00:17:48 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722cb10fcsm11225905e9.14.2026.03.26.00.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 00:17:47 -0700 (PDT)
Date: Thu, 26 Mar 2026 08:17:46 +0100
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
Message-ID: <20260326-lush-cuddly-limpet-ab2aa9@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cwnmwkle24ojkev6"
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


--cwnmwkle24ojkev6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Sima,

Here's the drm-misc-fixes PR for this week.

Maxime

drm-misc-fixes-2026-03-26:
A page mapping fix for shmem fault handler, a power-off fix for ivpu, a
GFP_* flag fix for syncobj, and a MAINTAINERS update.
The following changes since commit cffcb42c57686e9a801dfcf37a3d0c62e51c1c3e:

  drm/bridge: dw-hdmi-qp: fix multi-channel audio output (2026-03-17 18:15:16 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-03-26

for you to fetch changes up to 87a70013be7d1b96e7e160aea6dad4564b459868:

  MAINTAINERS: Update GPU driver maintainer information (2026-03-25 15:10:30 +0100)

----------------------------------------------------------------
A page mapping fix for shmem fault handler, a power-off fix for ivpu, a
GFP_* flag fix for syncobj, and a MAINTAINERS update.

----------------------------------------------------------------
Jianmin Lv (1):
      MAINTAINERS: Update GPU driver maintainer information

Karol Wachowski (1):
      accel/ivpu: Add disable clock relinquish workaround for NVL-A0

Pedro Demarchi Gomes (1):
      drm/shmem-helper: Fix huge page mapping in fault handler

Tvrtko Ursulin (1):
      drm/syncobj: Fix xa_alloc allocation flags

 MAINTAINERS                            |  8 +++++-
 drivers/accel/ivpu/ivpu_drv.h          |  1 +
 drivers/accel/ivpu/ivpu_hw.c           |  6 +++--
 drivers/gpu/drm/drm_gem_shmem_helper.c | 48 +++++++++++++++++++---------------
 drivers/gpu/drm/drm_syncobj.c          |  4 +--
 5 files changed, 41 insertions(+), 26 deletions(-)

--cwnmwkle24ojkev6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCacTdmgAKCRAnX84Zoj2+
dg+wAX9OxIUCGifj+s86KPwDPO7VokI6o4YIxsIq4FaVEYDG06aP28ONJvOY16cE
S0H32/QBf2hW02MSDiCy3kCfkMqK7JklR835I6AxFwArcH9ET57QPYCbbbx3QxSz
hJCioCi4Cw==
=7e8m
-----END PGP SIGNATURE-----

--cwnmwkle24ojkev6--

