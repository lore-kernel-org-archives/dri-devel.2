Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED33C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FA410E3E2;
	Wed, 12 Aug 2026 08:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pt++/yAo";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2C910E3E2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786521654;
 bh=8FZs2qDJkHpSRY6VBSiWaumhXiSgB5nzJDMwENS0Q1E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pt++/yAoBy6Vh3vdGJrvKR95+ZLmSJ0ng2xJrMHyDNNAS4xRK36waRfq4jBAuuV44
 fFBh/krIPyNdcFmaMPoHrMqZXQ82H9GyM/E6syLIQzGGOmBEAQ9DrOIVgzoO5ZQr7f
 x0DMdU+CuQzBK7zwhkaRCDztyU5nyri5WZDbfWM+ID1qm0t0yFTcEVzQz9BrlypZiI
 BR0KScRFIonHDSjuK9tHelIn5AQGcs78DOWS5MFfxf9ozSCK3u30fyiCqJzoF+SXD2
 xXxBeLcI1Y1ej3JUJT+CYrRNSQWAp5f/6mbGmdU6Ejw34WNDpfm731T4knnNJdHEVQ
 dRuO2rZG8cvuw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 24C8017E0E95;
 Wed, 12 Aug 2026 10:00:54 +0200 (CEST)
Date: Wed, 12 Aug 2026 10:00:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 03/11] drm/panfrost: Remove unnecessary header file
 include
Message-ID: <20260812100044.62572c24@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-3-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-3-3d692c9e98c2@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 11 Aug 2026 22:42:12 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> None of panfrost_features.h definitions are used in panfrost_device.c
>=20
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 7fed22d555a5..d8421fd6a662 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -11,7 +11,6 @@
> =20
>  #include "panfrost_device.h"
>  #include "panfrost_devfreq.h"
> -#include "panfrost_features.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_issues.h"
>  #include "panfrost_gpu.h"
>=20

