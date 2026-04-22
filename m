Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C009FF9EDD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BEB10EA0C;
	Wed, 22 Apr 2026 14:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+26Fqpn";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A517410EA0F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:04:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so36126525e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776866642; x=1777471442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MB2D5LFDJfWK+z/VNsomGx4bgTK6cIcOio7NwwAtJ5A=;
 b=j+26FqpneNkIwCXzzfW9Ud0aX7chLZWKhumktQnAriv/CEd2712xBLou6R1GfgPC7g
 bQ+mk89c73SC2gc1/m7rV05hkEHkfpscV5893aPl4IKm7oduXRiNl30dVZl0Su7cpKAR
 1psaq0y4+HyyNHjYS75JZ0bPAG2BeVPamvzxIa5eXUB3gTSOaFurKsDBKMpip2BIXhB/
 5OS7zsx0s6QUt8nInu6e6CtGxnNcWRS2Li1HJe0fsPQVP4VOWCR/43rxWGo0qO0iUgMf
 Dbbc3MJkzWROpI9X0esW9HsdNi63jv+h+QNhG/R5CD01+XLq56a7c9xZkS3x/W38ghkc
 sGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776866642; x=1777471442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MB2D5LFDJfWK+z/VNsomGx4bgTK6cIcOio7NwwAtJ5A=;
 b=cJ47jl6tNdRARfaQtS+GF5wfr2Tw9ZTJRazz7oNK/ZzouWDDEyQVUb3Aydc3pnWQ7X
 yEqSNhxzrt5VPRZWh0qUayeoKMUXSVIEPsjvbOgAptSxVy3ZHAdpLf7DUvjB9iyRXmbz
 CN3/lQpPk3yxbajaJ2WgIdORtLodPdn6NEc3vY8gMYSex9FrRvj7Z1DRB0EhP3atOY7E
 cVSaP6333kyN/DYw2x/mUS5PVFVfjxFpFld004y1AXt32+M5HH7lvm0/gUhFLEBu7C9a
 FhOhffwAFB+O7P+HkDcL00rVpEslCvLL3GqSaF9A/M66NZ61A7SdFqVqiIPh3OkboNkN
 L5yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EO5rrBBuR1Hv+jnFGPjfdfpCJpHV0KK2TkdxhdrohOLzTpNEm9WrI+Z9O6QGcI6s17NjlGlMKbV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu43HTmKZpZIpqYlw6WxmYQw1ODzbyDT7PZOOjCEEJUYg3pZVQ
 LK4FRJxCRztJgDu5ydz6qFBG4tDyXk+9c0I0xst5geESi3gxu1hYQoPH
X-Gm-Gg: AeBDievKyXtgFVbuHJvIsxHeozSv33GrPVSc28Pei9+BHX0bk06ycrxLS1oz8nMHHFd
 PFc+SdYYWLS5NpFS3jYd990R6Da+d9eZJ3/ds+sot2qh3eXhO6889Uxg799855wpU6AWz8td+Hn
 UwkAvs4oGMACZz6dkBFBJghjMaURuMmKgOn4gxA5SMycJU8ZQTKVX5PNa9xTolB4hCSYFC8NMp4
 VEI5Ge4yMf5oN3bqQLuB4w6YJdpDUjcsIn08hSN0AN5byAbEfuG8JF0IzTUSJkw2AEFJ3vkq0HB
 OrWxibquPjQr+4SdRND0vCMRYlwbUnNSztGECTI6H9Y98gP7avEdbbrX37CFzxRFUhLmw5aB6BE
 +WY0Aj9a9Pzvx9YNVLmG7/1fBurgU+LMqtSkp2uBl5U8xu6wVKYBK6gRQjSB41upQvbrnXxHpRz
 UEV8A0iK2bw2yWjs6Q9hU388sZ53FEKpa21nnw6A9XWRlsuklyHCPpYmvOW3OTEvQhNt7WlOlcO
 oLx1NaVs4E=
X-Received: by 2002:a05:600c:4f92:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48a0f18edf7mr147574885e9.24.1776866641781; 
 Wed, 22 Apr 2026 07:04:01 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489393ddd69sm64867095e9.10.2026.04.22.07.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:04:00 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: stable@vger.kernel.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Garcia <rob_garcia@163.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>, 
 Robert Garcia <rob_garcia@163.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Wed, 22 Apr 2026 16:03:59 +0200
Message-ID: <7260936.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <20260417074010.1607496-1-rob_garcia@163.com>
References: <20260417074010.1607496-1-rob_garcia@163.com>
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

Hi,

In my opinion, this BUG_ON should NOT be removed.

Using the CE was never well-supported by amdgpu and can lead to serious=20
issues, so we are planning to remove it entirely. Userspace isn't using it,=
 so=20
there is no loss of functionality here.

Mesa (the official userspace drivers) have never used CE and never will.

Best regards,
Timur

On Friday, April 17, 2026 9:40:10=E2=80=AFAM Central European Summer Time R=
obert=20
Garcia wrote:
> From: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> [ Upstream commit 5d55ed19d4190d2c210ac05ac7a53f800a8c6fe5 ]
>=20
> Those can be triggered trivially by userspace.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [ Modified to gfx_v11_0.c only. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index 37f793f7d4d2..6e3a32779168
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5380,8 +5380,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct
> amdgpu_ring *ring, unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
>  	u32 header, control =3D 0;
>=20
> -	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
> -
>  	header =3D PACKET3(PACKET3_INDIRECT_BUFFER, 2);
>=20
>  	control |=3D ib->length_dw | (vmid << 24);




