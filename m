Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D07CCD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2E610F213;
	Thu, 21 May 2026 06:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="U9L7vLvK";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8E610E02E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1779268300;
 bh=SKF9y/VCvDiRtVvxnS/6y5curRxqR5zcuxz7knzPRLs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=U9L7vLvKqrj2Nf3xtMMB2eaO3sOoZTX81QCzZNr87KKEPm3wvPeZP6D+z0LSMR+PT
 wM72SiV5iSlCZGU59+PzSrKZznopld9X8hOOv4ZYZ3sDGqWlPX+8+5TjwesyOGExLd
 Jo8srqs1GxV7J9YQtQElKIzGIayyzvXuIOQ49YuY=
Received: from [IPv6:2409:8a4c:e16:ee91:34b6:918e:ddbb:ba7a] (unknown
 [IPv6:2409:8a4c:e16:ee91:34b6:918e:ddbb:ba7a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id A6BD56597E;
 Wed, 20 May 2026 05:11:37 -0400 (EDT)
Message-ID: <788292607f1d81531f27b6fb616debc2d0ec1da1.camel@xry111.site>
Subject: Re: [PATCH v2] drm/loongson: fix pci_dev refcount leak in
 lsdc_get_dedicated_vram()
From: Xi Ruoyao <xry111@xry111.site>
To: yaolu@kylinos.cn, markus.elfring@web.de
Cc: chenhuacai@kernel.org, dri-devel@lists.freedesktop.org, jeffbai@aosc.io,
 linux-kernel@vger.kernel.org, lvjianmin@loongson.cn,
 wuqianhai@loongson.cn, 	zhengxingda@iscas.ac.cn
Date: Wed, 20 May 2026 17:11:26 +0800
In-Reply-To: <20260520014721.32696-1-yaolu@kylinos.cn>
References: <8ba844ab-9851-4045-a4e8-a96e6d1511e2@web.de>
 <20260520014721.32696-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

On Wed, 2026-05-20 at 09:47 +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
>=20
> Need to call pci_dev_put() after pci_get_domain_bus_and_slot().
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> v1->v2: add fixes tag and parentheses to function names suggested by
> Markus.
> =C2=A0 Link: https://lore.kernel.org/dri-devel/8ba844ab-9851-4045-a4e8-a9=
6e6d1511e2@web.de/#R
>=20
> =C2=A0drivers/gpu/drm/loongson/lsdc_drv.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 34405073c4d4..6cd21480c979 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -183,6 +183,7 @@ static int lsdc_get_dedicated_vram(struct lsdc_device=
 *ldev,
> =C2=A0	ldev->vram_size =3D size;
> =C2=A0	ldev->gpu =3D pdev_gpu;
> =C2=A0
> +	pci_dev_put(pdev_gpu);

It looks suspicious as pci_dev_put will immediately invalidate pdev_gpu
that we just assigned to ldev->gpu.

From what I can tell it seems nobody is using that value though.  IMO we
should remove the assignment and also drop the gpu field in struct
lsdc_device.


--=20
Xi Ruoyao <xry111@xry111.site>
