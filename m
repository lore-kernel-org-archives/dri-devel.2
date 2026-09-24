Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCAC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A7410F8FA;
	Fri, 25 Sep 2026 07:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxsw.ie header.i=@nxsw.ie header.b="PPSFoIhA";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F224410E9D5
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
 s=protonmail2; t=1790246194; x=1790505394;
 bh=F/ZACrV0aO4tIi1yz6r8avu0F7Wz4cAKOEl6OlC0s8M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PPSFoIhAHCReWnNEt/yAkqwhMU4gOeJGrRwd/T5v1b/abU2dTq79+izGTsXdrVqxF
 LHxR8f7LDAVZh5X07ZY2qrfmQA7LTN4ufjJFpWVg+RRWKpxpMrBM9OdujSDzTIuUFg
 bQNOX4PmLowms8RYAMU+B37XZL8aKeRfi4aJ5lfpXwIZpo1bEEOyNud+UOzIrh0N7G
 SOwL98xWljNdYX/R1oIVj05NIBoA/DuqwKDAWCjaPLwcEWqYMZKufQAsdsaoxEVxd/
 5ysghwseELMjho+iQA8F5uhHm2ZbIot/05lXqS3N0UQBUhFv0Zxi+ag8KTt/0M6k5d
 78eqpEcda6SJA==
Date: Thu, 24 Sep 2026 10:36:28 +0000
To: Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>
Subject: Re: [RFC PATCH v1 2/2] drm/msm: reject dma-buf imports without struct
 page info
Message-ID: <bfd744b0-c51a-4b9a-9f30-0d5aa9c79512@nxsw.ie>
In-Reply-To: <20260923074256.9357-3-liujianfeng1994@gmail.com>
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
 <20260923074256.9357-3-liujianfeng1994@gmail.com>
Feedback-ID: 136405006:user:proton
X-Pm-Message-ID: 43bcfb19f2be4ecc4f397510c6eb20c44cd61e73
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:43 +0000
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

On 23/09/2026 08:42, Jianfeng Liu wrote:
> msm_gem_import() fills the GEM object's page array with the deprecated
> drm_prime_sg_to_page_array() and stores the attachment sg_table for
> later mapping into the GPU's own pagetables via iommu_map_sgtable().
> Both need the struct page of the sg_table:
>=20
>   - iommu_map_sg() maps sg_phys() of each entry, and
>   - drm_prime_sg_to_page_array() iterates with for_each_sgtable_page,
>     which walks sg->length.
>=20
> When CONFIG_DMABUF_DEBUG=3Dy, dma_buf_map_attachment() hands importers
> a copy of the sg_table with the page pointers stripped and sg->length
> zeroed.  In that case drm_prime_sg_to_page_array() "succeeds" while
> filling zero entries, leaving msm_obj->pages uninitialized garbage
> (kvmalloc_objs() does not zero).  The buffer is imported anyway, and
> the first VM_BIND map of it fails asynchronously in the scheduler job
> run - after userspace has already enqueued GPU work referencing the
> mapping.  Userspace then observes arm-smmu translation faults from
> UCHE, e.g. hardware video decode in clapper/chromium:
>=20
>    gpu fault: ttbr0=3D000000088a889000 iova=3D000000010741c000 dir=3DREAD
>    type=3DTRANSLATION source=3DUCHE
>=20
> Replace the deprecated helper with an explicit loop so that a missing
> or short page list is detected at import time and rejected with
> -EINVAL.  This turns the silent memory corruption into a clean import
> error, letting userspace fall back instead of crashing the GPU.
>=20
> Note that msm fundamentally cannot map a page-less sg_table into its
> per-process GPU pagetables (it needs the physical addresses), so
> imports of such buffers can never work until msm is converted to
> build its GPU mappings from the attachment's DMA addresses.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>=20
> ---
>=20
>   drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.=
c
> index c4cff3d53d81b..0d5a91181d05b 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1307,7 +1307,8 @@ struct drm_gem_object *msm_gem_import(struct drm_de=
vice *dev,
>   =09struct msm_gem_object *msm_obj;
>   =09struct drm_gem_object *obj;
>   =09struct dma_buf *dmabuf =3D attach->dmabuf;
> -=09size_t size, npages;
> +=09struct sg_page_iter piter;
> +=09size_t size, npages, filled =3D 0;
>   =09int ret;
>=20
>   =09size =3D PAGE_ALIGN(dmabuf->size);
> @@ -1333,8 +1334,32 @@ struct drm_gem_object *msm_gem_import(struct drm_d=
evice *dev,
>   =09=09goto fail;
>   =09}
>=20
> -=09ret =3D drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
> -=09if (ret) {
> +=09/*
> +=09 * Fill the page array ourselves instead of using the deprecated
> +=09 * drm_prime_sg_to_page_array(), so that we can detect sg_tables
> +=09 * that carry no struct page at all.  Those must be rejected:
> +=09 * msm maps imported buffers into the GPU's own pagetables with
> +=09 * iommu_map_sgtable(), which needs the physical pages, so an
> +=09 * import without page information could never be mapped.  The
> +=09 * most prominent case is the page-stripping sg_table wrapper that
> +=09 * dma_buf_map_attachment() hands out when CONFIG_DMABUF_DEBUG=3Dy.
> +=09 *
> +=09 * drm_prime_sg_to_page_array() would "succeed" with zero entries
> +=09 * filled in that case and leave msm_obj->pages uninitialized,
> +=09 * which later blows up as arm-smmu translation faults from UCHE.
> +=09 */
> +=09for_each_sgtable_page(sgt, &piter, 0) {
> +=09=09if (WARN_ON(filled >=3D npages)) {
> +=09=09=09ret =3D -EINVAL;
> +=09=09=09goto fail;
> +=09=09}
> +=09=09msm_obj->pages[filled++] =3D sg_page_iter_page(&piter);
> +=09}
> +=09if (filled !=3D npages) {
> +=09=09DRM_DEV_ERROR(dev->dev,
> +=09=09=09      "import of dmabuf from '%s' rejected: sg_table has no/mis=
aligned struct page info\n",
> +=09=09=09      dmabuf->exp_name ?: "?");
> +=09=09ret =3D -EINVAL;
>   =09=09goto fail;
>   =09}
>=20
> --
> 2.47.3
>=20
>=20

This very much looks like an LLM generated patch - the commit log, the=20
large comment in the code and TBH the solution too.

Why is the fix Adreno specific ?

Shouldn't this function be ammended with

 > +=09if (filled !=3D npages)

instead ?

/**
  * drm_prime_sg_to_page_array - convert an sg table into a page array
  * @sgt: scatter-gather table to convert
  * @pages: array of page pointers to store the pages in
  * @max_entries: size of the passed-in array
  *
  * Exports an sg table into an array of pages.
  *
  * This function is deprecated and strongly discouraged to be used.
  * The page array is only useful for page faults and those can corrupt=20
fields
  * in the struct page if they are not handled by the exporting driver.
  */
int __deprecated drm_prime_sg_to_page_array(struct sg_table *sgt,
                                             struct page **pages,
                                             int max_entries)
{
         struct sg_page_iter page_iter;
         struct page **p =3D pages;

         for_each_sgtable_page(sgt, &page_iter, 0) {
                 if (WARN_ON(p - pages >=3D max_entries))
                         return -1;
                 *p++ =3D sg_page_iter_page(&page_iter);
         }
         return 0;
}
EXPORT_SYMBOL(drm_prime_sg_to_page_array);

All the LLM seems to have done here is copy the code out of=20
drm_prime_sg_to_page_array() and then add a check for filled !=3D npages

But if that is a valid check for Adreno - then it is a valid check for:

  grep drm_prime_sg_to_page_array drivers/* -r
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:=09=09ret =3D=20
drm_prime_sg_to_page_array(src->ttm->sg, src_pages,
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:=09=09ret =3D=20
drm_prime_sg_to_page_array(dst->ttm->sg, dst_pages,
drivers/gpu/drm/omapdrm/omap_gem.c:=09=09ret =3D=20
drm_prime_sg_to_page_array(sgt, pages, npages);
drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c:=09ret =3D=20
drm_prime_sg_to_page_array(sgt, etnaviv_obj->pages, npages);
drivers/gpu/drm/drm_prime.c: * drm_prime_sg_to_page_array - convert an=20
sg table into a page array
drivers/gpu/drm/drm_prime.c:int __deprecated=20
drm_prime_sg_to_page_array(struct sg_table *sgt,
drivers/gpu/drm/drm_prime.c:EXPORT_SYMBOL(drm_prime_sg_to_page_array);
drivers/gpu/drm/msm/msm_gem.c:=09ret =3D drm_prime_sg_to_page_array(sgt,=20
msm_obj->pages, npages);
drivers/gpu/drm/xen/xen_drm_front_gem.c:=09ret =3D=20
drm_prime_sg_to_page_array(sgt, xen_obj->pages,

and should live in the helper function with an appropriate Fixes: tag=20
for backporting...

---
bod

