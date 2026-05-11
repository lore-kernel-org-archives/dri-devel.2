Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915D0CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 09:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD8D10E500;
	Mon, 11 May 2026 09:04:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF3C10E151
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:04:46 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1]) by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1wMMZ8-0004bk-7y; Mon, 11 May 2026 11:04:42 +0200
Message-ID: <3e298ed6a361a0aa5526d859b0f3a98c0cd47090.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Honor userptr read-only at the GPU MMU
From: Lucas Stach <l.stach@pengutronix.de>
To: Ziyi Guo <guoziyi114@gmail.com>
Cc: linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com, 
 airlied@gmail.com, simona@ffwll.ch, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ziyi Guo
 <n7l8m4@u.northwestern.edu>
Date: Mon, 11 May 2026 11:04:41 +0200
In-Reply-To: <20260508180518.1417371-1-n7l8m4@u.northwestern.edu>
References: <20260508180518.1417371-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Am Freitag, dem 08.05.2026 um 18:05 +0000 schrieb Ziyi Guo:
> The IOMMU mapping for a userptr BO was installed with a hard-coded
> ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE, ignoring the read-only
> attribute set when the BO was created without ETNA_USERPTR_WRITE.
> Build the prot mask from etnaviv_obj->userptr.ro so MMUv2 clears
> MMUv2_PTE_WRITEABLE for read-only userptr BOs.
>=20
> MMUv1 PTEs carry no R/W bits and its fast path skips the MMU, so
> read-only cannot be enforced there; refuse such a mapping with
> -ENODEV.

I don't think it's a good idea to completely reject those mappings on
MMUv1. We can always force a BO to be mapped through the
translation/protection region of the MMUv1 by adding the
ETNA_BO_FORCE_MMU flag, which is what you might want to do when
constructing a ro userptr BO.

Regards,
Lucas

>=20
> Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index e3572461b599..28f26d60ac05 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -269,10 +269,18 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_cont=
ext *context,
>  {
>  	struct sg_table *sgt =3D etnaviv_obj->sgt;
>  	struct drm_mm_node *node;
> +	int prot =3D ETNAVIV_PROT_READ;
>  	int ret;
> =20
>  	lockdep_assert_held(&etnaviv_obj->lock);
> =20
> +	if (!etnaviv_obj->userptr.ptr || !etnaviv_obj->userptr.ro)
> +		prot |=3D ETNAVIV_PROT_WRITE;
> +
> +	if (etnaviv_obj->userptr.ptr && etnaviv_obj->userptr.ro &&
> +	    context->global->version =3D=3D ETNAVIV_IOMMU_V1)
> +		return -ENODEV;
> +
>  	mutex_lock(&context->lock);
> =20
>  	/* v1 MMU can optimize single entry (contiguous) scatterlists */
> @@ -301,7 +309,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_contex=
t *context,
> =20
>  	mapping->iova =3D node->start;
>  	ret =3D etnaviv_iommu_map(context, node->start, etnaviv_obj->size, sgt,
> -				ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE);
> +				prot);
> =20
>  	if (ret < 0) {
>  		drm_mm_remove_node(node);
