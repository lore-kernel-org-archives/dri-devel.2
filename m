Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C541606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=V89C8aNc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B7E10E3FC;
	Thu, 22 Oct 2026 08:03:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F6910E3FC
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=INuDZfQLSGGX4SjuADx37jtG3bQYUiFimPOWaTFB1b8=; b=V89C8aNcqKYHKuPuw+BubPoiIH
 EUsXCPuM+zIMeYn7h7w9it8uHOy0o88AhKETjaxS4USQyeb9J3UW6/z8dSi0MURl8xhxUxnSKguJV
 vzVuhCwVD8OISr7LCllNxbmSu0pHMvugXqhuqLqp+Tr14H9qT6yZO3uMowFB7LuOZYKdSqzyyDUzJ
 gHmd2It6fbRGqvmwKCL9j3L1ieoQfD+Yu+fo9sPN4k+rE9W8DZvwGRQE1R4UjUEiJLH5RTjin0n89
 flkfNQzn/6X7d7ita4Ok8Xp97/7VxehyufoFC+4w26gNxEE4Bx7bmZ2b/KBcijj/o1WqSDRLlJdHF
 OyMBzKIg==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJnll-006Snu-6e; Thu, 22 Oct 2026 10:03:25 +0200
Message-ID: <c3ff98f07b9ea2c3332526b2a7afcc843ecef53f.camel@igalia.com>
Subject: Re: [PATCH 0/3] drm/v3d: Add TFU constant colour support for V3D 7.x
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Thu, 22 Oct 2026 10:03:25 +0200
In-Reply-To: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
References: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mi=C3=A9, 21-10-2026 a las 11:55 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> The V3D 7.x TFU can fill its output with a constant colour, which
> lets
> userspace offload buffer fills to the TFU. However, so far, the
> kernel
> didn't expose this hardware capability.
>=20
> Expand the UAPI to obtain constant colour data from the userspace and
> configure the CCOL0-3 registers.
>=20
> The series contains three patches:=20
>=20
> =C2=A0 1. Patch 1 implements validation of the v71 fields of the TFU
> submit
> =C2=A0=C2=A0=C2=A0=C2=A0 ioctl.
>=20
> =C2=A0 2. Patch 2 only writes the TFU coefficient registers on V3D 7.x
> when
> =C2=A0=C2=A0=C2=A0=C2=A0 ICFG.YVCS_RGBP selects user-provided coefficient=
s. This avoids
> =C2=A0=C2=A0=C2=A0=C2=A0 writing to COEF0-3 when it's not needed.
>=20
> =C2=A0 3. Patch 3 adds the CCOL0-3 registers and ccol[4] to
> drm_v3d_submit_tfu.
> =C2=A0=C2=A0=C2=A0=C2=A0 It also adds DRM_V3D_PARAM_SUPPORTS_TFU_CCOL for=
 userspace to
> detect
> =C2=A0=C2=A0=C2=A0=C2=A0 support.
>=20
> The Mesa counterpart of this feature is available in [1].
>=20
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45487
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Validate the v71 fields of the TF=
U submit ioctl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Only program TFU coefficients whe=
n used on V3D 7.x
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Add TFU constant colour support f=
or V3D 7.x
>=20
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0drivers/gpu/drm/v3d/v3d_regs.h=C2=A0=C2=A0 | 19 ++++++++++++++++++-
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0 | 30 +++++++++++++++++++++++-=
------
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c |=C2=A0 9 +++++++++
> =C2=A0include/uapi/drm/v3d_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 +++++
> =C2=A05 files changed, 58 insertions(+), 8 deletions(-)
> ---
> base-commit: b3de601e57d983e4a42e27d499516041c11c2bde
> change-id: 20261015-v3d-tfu-ccol-18d9632751bd
>=20
>=20

