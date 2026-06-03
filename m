Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C739ECD6E56
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1997D10FC2C;
	Wed,  3 Jun 2026 11:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Sc1909QH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DABB10FC2C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S122oRCX1Ekc4rAStFtQQeoCXITCol5NhaRa8tfLhus=; b=Sc1909QH+HE/+pjPeqTNvLoh77
 kFoOwyYwSZGxA7MG2UqHFWaWKeEwJhCCajFglIEnWHgg0cgmFlFM626qmRGgvbr8bu4/1kYYYFCHV
 kd2JF5tv3ZozUflZKj5HDaV7lFj1CBQexrgQYoDNAC4UL5RZKfpXB+Rf9R/3GghLzGBTyUcuwNy6P
 ODAvq0SNWqbAQqBiJlBZ+rKq6p4C1/8B0NPo5vQfVx4kSmqnC5hhDPg8gdI+7RmIH0JlUwA6WtcvV
 vbdS3AEYnTZAn9gDV0eZelslnXkscwh7BPlF82oqQFGw16oBP+MNac238HbjSgueawc7GNAhD5yq8
 4VlN1pCg==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUjZq-00C8oj-A9; Wed, 03 Jun 2026 13:16:02 +0200
Message-ID: <31966dd0b7fb1e87a64a049705dd054ffa44ad7e.camel@igalia.com>
Subject: Re: [PATCH v2 01/14] drm/v3d: Drop unused drm_encoder.h include
 from v3d_drv.h
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Wed, 03 Jun 2026 13:15:51 +0200
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-1-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
 <20260510-v3d-sched-misc-fixes-v2-1-ca4aba343ef6@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El dom, 10-05-2026 a las 19:11 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> The V3D driver has no display pipeline, so nothing in the driver
> requires
> drm_encoder.h. Remove the stale include.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h
> b/drivers/gpu/drm/v3d/v3d_drv.h
> index 4ebe175a8c6b..5a0b9da2c3aa 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -7,7 +7,6 @@
> =C2=A0#include <linux/spinlock_types.h>
> =C2=A0#include <linux/workqueue.h>
> =C2=A0
> -#include <drm/drm_encoder.h>
> =C2=A0#include <drm/drm_gem.h>
> =C2=A0#include <drm/drm_gem_shmem_helper.h>
> =C2=A0#include <drm/gpu_scheduler.h>
>=20

