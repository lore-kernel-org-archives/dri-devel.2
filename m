Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D085C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AA010EEB6;
	Wed, 12 Aug 2026 08:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JU6uYaE3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8474210EEAB
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786521591;
 bh=IP65GVh5iliVMfpmakpvzbSYWId+HtkY3xuM6WIn/QI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JU6uYaE3mdyV97MiTuv/yTRW2fPAVrv/qNDCEYpCGlVntxkwJk8KZX6AM2opJP+lX
 VEuyjPa5WI/qdLfA4aJFSVj83+5pc3XbceuA5+lUccN5kqC1kd3oG1/+sO4fwgDYyO
 czToL2ej/8K+OkQpu3w1vk0ntpm82OVb6Vbkn+GEOk/MLAbbyjqKs9ZzDijjsrMT1E
 1HBwixdWeSqslKCTW5WBDCylLHSyfK64JWqdktodkA6n8tdbNff6zrC8lX0cfdVCoJ
 piloTnb5hGKJigPQmcgTA6IxPFCbe7OmoZs7Qm/DOk60grozhqSxCQgNFzXCKYivvA
 n5cTizevCP+dA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E555017E0E95;
 Wed, 12 Aug 2026 09:59:50 +0200 (CEST)
Date: Wed, 12 Aug 2026 09:59:45 +0200
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
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH v5 02/11] drm/panfrost: Prevent division by 0
Message-ID: <20260812095945.62199da1@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-2-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-2-3d692c9e98c2@collabora.com>
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

On Tue, 11 Aug 2026 22:42:11 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When updating and debug-printing devfreq stats, in the very unlikely
> off-chance that total device time is less than 100 ns, division by 0
> would happen. Fix the divisor when relevant and rearrange operands.
>=20
> Reported-by: Claude <noreply@anthropic.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index b51c30778811..0fe81d259274 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->busy_time * 100 / MAX(status->total_time, 1),
>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;
>=20

