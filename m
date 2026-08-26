Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB559C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D657210E31E;
	Wed, 26 Aug 2026 16:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="exNb096A";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5401E10E31E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:49:10 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b2fso1642507a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787762949; x=1788367749; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W8JEQqy428qGExbskvHYXyCkGoNGQ6fhaTCMz84957Q=;
 b=exNb096At3Nqsn0HuL//3oh9wi8ocfEIxU3U71fwEvk5/TSz/kAo1mo16whP36IrDN
 JOH1XbgZecGWNBTfuzrfUU535oGTCuy4l1hOS33B5Gpeef8gfvqCqs71KYz1XHFuTwMd
 ANNdXzBzZJH8ARJDAC+O/thIAiuZvuhSGueD3/QZF6KQiYwY9c8jw4ey4rCr/KlUiyWA
 EPlwKeei9gueQeAVKfTE0YOYp4VaKJEA0WdPNTNjMFbcOB9/m4g672egzgoF2Lluzrl3
 /v7Vi8SV+ZmmD5uifmZuNaEx2eYg+KMThRcsAcacaHJKNiJbwd2gTfTAo10vZ0gwKlek
 Avfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762949; x=1788367749;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W8JEQqy428qGExbskvHYXyCkGoNGQ6fhaTCMz84957Q=;
 b=QKOrKEnmMSF4QVBzOQvkncUPAbhcl55A5GZaNj2ef55B4h7nZE27PTg9xlEKuk5nfu
 yD/zzmoIEeH7PNASsPDwM8aWvDmlRxgJ307/8CPkP1Er+Hp5SQxT3fWGTLc0DU+q89XN
 6T2gI9dLB/6+LEreiOP1TlCtnuG8rvACBxciEzgoTA73ILGQ5ZerEIFat/toV4MQd7/8
 HIa+f2cz+vS5MekASoh2COk3O4PosYhI0zlglDseeqJkC7rY9n0ZHBq22LRrOzaI823j
 gXVEdAwNFyAwT1kQK6EZugfTKOpxNhyU1oNtg0aZOBl3PEo0OowEKk7ZefXP8KvQic2J
 PRaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf69NrQYw/0gcrFtAR97dbdX8IOGI7cRPuQT1jhegkOl3v0zrZqlQtF4X8Yu2B/iT40dcMofx8IZY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kSO8Igo24znyZGiwa2F5KpQ+jLW0N1jlxC83ltnrL0Wsg41wpg
 DlDjtK1d+4yQjGi/CxwLWs3X6rgYQjIsUqmezlLrnBYeAp93fCzhpwjT
X-Gm-Gg: AR+sD10YfyiMZZamgL2MaMefsWVidPXlJKdKoZt6wuyMWwh3JMqXP/L40Yn0Hw8O6lm
 WL1xyV3Mz3QXOecnUmgCOGKkYjm/A8R9diWHrortW2D3wVUcp81W1Dx4dU3ySBO/cMk+Egb/463
 ebfJWsHUYa+flS5jInITEkF6MZojkFuvw+Ipgxz2FFKqvvTorNltrVQgoyX4FthkwEdtVXBvoc8
 aGBm/i8nQLuf68el9s9s3YsWWPTkSZ43ROk+1v/bx8hv+BBU0yknnUJJ9ludEMdzkQQcIibCZU/
 BKF7SIir/s0amK01W8yo/hzuQS+GQT7bBcOat79oFSKgaFuAbSE5KoK/PVJG+3D/DTeLgqsnoH7
 IAhjw7NKtaCqfBtHWxrQiqCqmK/0Hl0eeuDj3F0uBMqnJ75x4QzKszB8nRJMQOf78GK4ObA3rLL
 s+WH25btUovBB+ItPxKcxfIOsPmUzsYDYk8D01M0rJtCqeC9EIFRsZIObeVE+e9lN8CHFrwnmtS
 eMV/RUazsXoMU9zlTMCAIAk38lIPoSioJHCPg==
X-Received: by 2002:a17:907:b041:10b0:c25:2de6:f063 with SMTP id
 a640c23a62f3a-c252de6fd5dmr425537866b.5.1787762948254; 
 Wed, 26 Aug 2026 09:49:08 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC5BC.dsl.pool.telekom.hu.
 [94.27.197.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c251b7a9936sm431212066b.49.2026.08.26.09.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:49:07 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com, leandro.ribeiro@collabora.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de, Melissa Wen <mwen@igalia.com>
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 Viktor =?UTF-8?B?SsOkZ2Vyc2vDvHBwZXI=?= <viktor_jaegerskuepper@freenet.de>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/3] drm/atomic-state-helper: fixes for blend-mode-prop
 warning
Date: Wed, 26 Aug 2026 18:49:05 +0200
Message-ID: <OBTNak9WT7OSHXS1TK53DA@gmail.com>
In-Reply-To: <20260826104143.39077-1-mwen@igalia.com>
References: <20260826104143.39077-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, August 26, 2026 12:37:04=E2=80=AFPM Central European Summer T=
ime Melissa=20
Wen wrote:
> PREMULTI was the default DRM blend mode until 9813e158d13d
> ("drm/drm_blend: allow blend mode property without PREMULTI") introduced
> the possibility of exposing the blend mode property without PREMULTI
> being supported. However, __drm_atomic_helper_plane_state_init() still
> resets pixel_blend_mode to PREMULTI (hardcoded), ignoring the supported
> mode in this property. In the same series, 860e748bddcc ("drm: ensure
> blend mode supported if pixel format with alpha exposed") starts warning
> drivers that supports alpha formats in a given planes but doesn't
> support blend mode property, which includes AMD primary and cursor
> planes.
>=20
> For AMD DCN families, overlay and primary planes support the three blend
> modes, and therefore PREMULTI is still the default mode. So the warning
> can be fixed by just creating blend mode properties for primary planes
> too. PREMULTI is the default/unique mode for cursor planes in DCN and
> DCE driver. However, looks like PIXEL_NONE is the unique blend mode
> supported by DCE-generation driver. I don't have the hardware to check
> it out, but looking at the code I understand that, even if the hardware
> can do PREMULTI or COVERAGE, the way it programs registers doesn't make
> these other blend modes actually available.

Hi Melissa,

Thanks for noticing and fixing this.
To make the code a bit easier to follow, I recommend moving the considerati=
on=20
for blending and alpha properties to a smaller helper function. That's just=
 my=20
personal preference though. The way you wrote it in the series is also good.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Bearing this in mind, this series is organized as follow:
>=20
> - Patch 1 fixes the pixel_blend_mode reset when the blend mode property
>   is advertised without PREMULTI support. It's needed for AMD
>   DCE-generation (patch 3) and I think with this we can also remove a
>   workaround in nouveau nv50_wndw_default_state() caused by the
>   hardcoded PREMULTI default value [1].
>=20
> - Patch 2 fixes the missing-blend-mode-property warning for DCN primary
>   plane and for DCN+DCE cursor plane. The alpha property keeps only on
>   overlay planes because looks like this is not supported by AMD primary
>   planes and it doesn't affect the blend mode warning we are targetting.
>   Enabling alpha properties to primary was also causing -EINVAL on IGT
>   alpha tests because it started testing primary planes and disabling it
>   (which is not allowed by the AMD display driver).
>=20
> - Patch 3 fixes the warning for DCE primary plane, but I detached this
>   solution from the previous patch because I don't have hardware to
>   validate if my assumption about PIXEL_NONE-only is correct. Also, I
>   added PREMULTI to the list of supported blend mode to avoid uAPI
>   regressions since it was the required/default mode for many years and,
>   without overlay plane, PIXEL_NONE and PREMULTI are equivalent for
>   primary on top of a black blackground.
>=20
> [1]
> https://lore.kernel.org/dri-devel/20260720215058.398210-3-lyude@redhat.co=
m/
>=20
> [v1]:
> https://lore.kernel.org/dri-devel/20260722183240.626522-1-mwen@igalia.com/
> Changes:
> - new patch for pixel_blend_mode default value other than PREMULTI.
> - remove DCE11 which supports per_pixel_alpha but doesn't support
> DCN_UNIVERSAL_PLANE. - new patch for the primary plane blend mode on
> DCE-generations
>=20
> [v2]:
> https://lore.kernel.org/dri-devel/20260804140758.107683-1-mwen@igalia.com/
> Changes:
> - keep alpha property only for overlay planes (looks like primary plane
>   doesn't actually support it) - alpha prop in primary planes causes IGT
>   test failures with RX 7900 XT on a 4k60 HP U27 as reported by Daniel
>   Wheeler.
> - improve readability of if conditions (Alex H)
> - add Leandro's r-b tags.
>=20
> [v3]:
> https://lore.kernel.org/dri-devel/20260813143605.106104-1-mwen@igalia.com/
> Changes:
> - add Daniel's, Mikhail's and Viktor's tested-by tag, accordingly
> - add Alex H r-b tag
> - add PREMULTI to the DCE list of supported blend modes to avoid
>   uAPI regression reported by Viktor.
>=20
> Best Regards,
>=20
> Melissa
>=20
> Melissa Wen (3):
>   drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
>   drm/amd/display: fix missing blend-mode-prop warning for DCN
>   drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE
>=20
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 +++++++++++++++++--
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  7 +++++
>  2 files changed, 35 insertions(+), 3 deletions(-)




