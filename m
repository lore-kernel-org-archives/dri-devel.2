Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FA606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S15uyzTZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D3A10F87E;
	Tue, 27 Oct 2026 23:18:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA5010F87E
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:17:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAE1140674;
 Tue, 27 Oct 2026 23:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8053F1F01825;
 Tue, 27 Oct 2026 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793143077;
 bh=IIuJgDWw7mUHZpklLFT39HRKEsS5iczQ7OKLVVgiuto=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=S15uyzTZIxxeOI7wEomfjFZhQcEvlNh1yY7UGFYmwfaspCYGNaxXphmlBpfhIo/8z
 m/IhdpPikBwnXzXrhUFo34pAVRWLgEBzAYXHTnu/9naYae77x2Ku+zEFqfKjbg2+VA
 ycE6YH2kYJedjCyaqy7+D1TYTuvz//obouqjHJz8TnxQTvhez0IUDlGnzDIDup3tSg
 TWTy6L5l6wFh//+i/KoFkYsfhXY6zz/UAS1RvYQqEyod56vb94O28JZ4mgh/hUKAr6
 r6YnDT3YxwLQeKPWnHsDCE0s4IJUvRYA0AyTAsQ9G++2xGEiU2cZLhRifsSMGNDPyI
 +EcM/uf2g8Lzw==
Message-ID: <sashiko-outbox-187203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/msm: Treat !mapped as an error
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027230452.130031-7-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:17:57 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/msm: __do_map() still returns 0 when sg_table maps nothing o=
r short len
--

commit 363087af17cd51ea419c705b08215e2c785556f3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Treat !mapped as an error

This commit treats zero mapped bytes after an ops->map() call in __do_map()
as -ENOMEM so that mapping nothing is handled as an error rather than
silently ignored.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index c2950d32c5075..255972323f9a9 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -186,6 +186,10 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, stru=
ct sg_table *sgt, size_t off
>  			size -=3D mapped;
>  			len  -=3D mapped;
> =20
> +			/* If nothing was mapped, consider it an ENOMEM. */
> +			if (!ret && !mapped)
> +				ret =3D -ENOMEM;

[Severity: Medium]
Can __do_map() in drivers/gpu/drm/msm/msm_iommu.c still silently return 0
without mapping anything (or after mapping fewer than len bytes) when called
via vm_map_op() -> msm_iommu_pagetable_map() or msm_iommu_map()?

The new !mapped check is placed inside the inner while (size) loop, which
only executes when size =3D sg_dma_len(sg) > 0 (and where ret =3D=3D 0 with
mapped =3D=3D 0 would previously have caused an infinite loop rather than
silently returning).

However, if sg_dma_len(sg) =3D=3D 0 (for example, when an sg_table is not
DMA-mapped, or analogous to the sg->length =3D=3D 0 case under
CONFIG_DMABUF_DEBUG before commit b6b3547f9503 ("drm/msm: Convert map helper
to use dma-address")), the outer loop in __do_map() skips the inner while
(size) loop altogether because 0 <=3D off is always true for unsigned size_=
t:

drivers/gpu/drm/msm/msm_iommu.c:__do_map() {
	for_each_sgtable_dma_sg (sgt, sg, i) {
		size_t size =3D sg_dma_len(sg);
		phys_addr_t phys =3D sg_dma_address(sg);

		if (!len)
			break;

		if (size <=3D off) {
			off -=3D size;
			continue;
		}
		...
		while (size) {
			...
		}
	}

	return 0;
}

Similarly, if sgt->nents =3D=3D 0 or the total DMA length across sgt is sma=
ller
than off + len (which msm_iommu_map() checked via return (ret =3D=3D len) ?=
 0 :
-EINVAL before commit efc83727eef1 ("drm/msm: Convert iommu map/unmap to
helpers")), for_each_sgtable_dma_sg() finishes with len > 0 and __do_map()
still returns 0 without unmapping addr - iova via __do_unmap() or marking
the VM unusable.

Should __do_map() also check if len !=3D 0 after the for_each_sgtable_dma_s=
g()
loop and unmap any partial range before returning an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027230452.1300=
31-1-robin.clark@oss.qualcomm.com?part=3D6
