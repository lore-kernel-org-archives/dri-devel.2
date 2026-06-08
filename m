Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B6CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07F110EDF2;
	Mon,  8 Jun 2026 07:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="c07N35Mw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358E710EDF2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uxWMdDQNZd4UfZyTS00VcDDEjXirdFSg2ZTIGKoEq8A=; b=c07N35Mw2iABFxs1O/FQuH2zhc
 F7hK7cTsjAZ0BlRVP1Jqo6HnbpITgtTKFTYXfltzpt1nFqD1eQVVZW2UzHL3ZTtraG1dLSb/yjcva
 SZe3JNxQUDmDM9vwBnKwMD49lXvKIUO9VaQzGWGSp4nf/z5KgxmT85YJQxs379loy4dks7uZIcgYJ
 5I0cOUF+TbA73ZBN2n7ume2Sl5Wj1ucB9vH0juBINhXaQWyLQ6VJu+aq1GD6j4wPrLWBVwI/2uA8e
 Jo636AdMGm+d9OkYubIMDy43PwbD9NaH7TUSBQfDoAy2v5bIa0cIpaFWCPpSboKVLM5W5hmtk2OY/
 PgZczcCw==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWU4J-00EDwS-Ml; Mon, 08 Jun 2026 09:06:43 +0200
Message-ID: <86bfd93837dceebb889929c8213e6bd78de9af1a.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Deprecate V3D 3.3 and 4.1 support
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Emma Anholt <anholt@igalia.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Mon, 08 Jun 2026 09:06:31 +0200
In-Reply-To: <20260606185616.694188-2-mcanal@igalia.com>
References: <20260606185616.694188-2-mcanal@igalia.com>
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

Thanks Ma=C3=ADra:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El s=C3=A1b, 06-06-2026 a las 15:55 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> V3D 3.3 (Broadcom BCM7268) and V3D 4.1 (Broadcom BCM7278) has had no
> in-tree userspace since Mesa dropped support in 2024, on the grounds
> that those generations were no longer being tested. The situation in
> the kernel is similar: the maintainers don't have this hardware, the
> hardware is not available for purchase, and there is no known user of
> these GPUs.
>=20
> With no userspace left to drive it and no known users, maintaining
> the
> ver <=3D 41 code paths is a cost without a benefit, considering that
> these
> paths are not being exercised on real hardware.
>=20
> As a first step toward removal, emit a deprecation warning at probe
> for
> V3D versions earlier than or equal to 4.1. The hardware remains
> functional for now; this only warns. If any real user appears and
> explain its use-case, support can be retained.
>=20
> Schedule the removal of V3D 3.3 and 4.1 support to the next kernel
> release.
>=20
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25851
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.c | 18 +++++++++++++++++-
> =C2=A01 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c
> b/drivers/gpu/drm/v3d/v3d_drv.c
> index 805d84435ee0..8d914dbc3315 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -4,7 +4,11 @@
> =C2=A0/**
> =C2=A0 * DOC: Broadcom V3D Graphics Driver
> =C2=A0 *
> - * This driver supports the Broadcom V3D 3.3 and 4.1 OpenGL ES GPUs.
> + * This driver supports the Broadcom V3D 4.2 and 7.1 GPUs.
> + *
> + * Support for V3D 3.3 and 4.1 GPUs is deprecated and it will be
> removed
> + * in the next kernel release.
> + *
> =C2=A0 * For V3D 2.x support, see the VC4 driver.
> =C2=A0 *
> =C2=A0 * The V3D GPU includes a tiled render (composed of a bin and rende=
r
> @@ -414,6 +418,18 @@ static int v3d_platform_drm_probe(struct
> platform_device *pdev)
> =C2=A0	 */
> =C2=A0	WARN_ON(v3d->ver !=3D gen);
> =C2=A0
> +	/* V3D 3.3 and V3D 4.1 has had no in-tree userspace since
> Mesa
> +	 * dropped support in 2024 (MR#25851) and they have no known
> users.
> +	 * Due to that, support is scheduled for removal in the next
> release.
> +	 */
> +	if (v3d->ver <=3D V3D_GEN_41) {
> +		dev_warn(dev,
> +			 "V3D %u.%u support is deprecated and will
> be removed "
> +			 "in the next kernel release. If you rely on
> this hardware, "
> +			 "please report it to
> dri-devel@lists.freedesktop.org.\n",
> +			 v3d->ver / 10, v3d->ver % 10);
> +	}
> +
> =C2=A0	v3d->cores =3D V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
> =C2=A0	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
> =C2=A0

