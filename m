Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122C8CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB0D10E0B4;
	Fri, 16 Oct 2026 07:23:50 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B99112612
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792135422;
 bh=cXYta/SdbAfhvxOFTW9Ci6MQaKBb5fwjWdyuX0HxoIY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S2UUEXIoPD64zicHqiajshxy7U366+LBYKzPr5Sbzu+KYT4gzGiPXnsGRsShCRu5Y
 iQcETmqLZbGX8KGLpdG2yPOk9QJj3spZLPRwd5KZVekspIUa0tIVGq9uvvs1ZbHcQ1
 CMgZKO1MKLRDs60nQBDp1yO9/T6qF5VU5PJ+zf5CYFhS8s+A6/7HxnCtuhbMdpC1Wx
 LTLx8kGaPCQkCPNWVtEIlCuCoYlljvRhFq4Z+JOU0h7BMLreBuv2mcLGfgoEUWLU4I
 x7Yor2D/j8bDYWBsiYiT66LbqdPx/H1bxxWKqh2Ko1HoND0aDcvyYQEG3NYtoJtzDP
 lulYJgwa5lj5g==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F49117E0036;
 Fri, 16 Oct 2026 09:23:42 +0200 (CEST)
Date: Fri, 16 Oct 2026 09:23:36 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
Message-ID: <20261016092336.10ed78da@fedora-21.home>
In-Reply-To: <20261015-panfrost-reset-races-fixes-v1-1-bb74c1786a0b@collabora.com>
References: <20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com>
 <20261015-panfrost-reset-races-fixes-v1-1-bb74c1786a0b@collabora.com>
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

On Thu, 15 Oct 2026 19:22:31 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> If we don't do that, we end up with invalid timestamps in the block
> headers.
>=20
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through u=
nstable ioctls")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Let's make sure this is merged in the same release the perfcnt uAPI
changes are in, so userspace can check the driver version to know if
the fix is present or not (we have a workaround in mesa for that which
we can drop when the fix is in).

> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index a9def452d5ef..b26da057a1a0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -17,6 +17,7 @@
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
>  #include "panfrost_gem.h"
> +#include "panfrost_gpu.h"
>  #include "panfrost_issues.h"
>  #include "panfrost_job.h"
>  #include "panfrost_mmu.h"
> @@ -52,6 +53,7 @@ static void panfrost_perfcnt_hw_disable(struct panfrost=
_device *pfdev)
>  	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> =20
>  	if (perfcnt->owns_as_ref) {
> +		panfrost_cycle_counter_put(pfdev);
>  		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  		perfcnt->owns_as_ref =3D false;
>  	}
> @@ -84,6 +86,7 @@ static int panfrost_perfcnt_hw_enable(struct panfrost_d=
evice *pfdev)
>  		return ret;
> =20
>  	perfcnt->owns_as_ref =3D true;
> +	panfrost_cycle_counter_get(pfdev);
> =20
>  	as =3D ret;
>  	cfg =3D GPU_PERFCNT_CFG_AS(as) |
>=20

