Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAC606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLmeWB/b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7928A10E8F3;
	Fri, 30 Oct 2026 21:54:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA57110E8F3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:54:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 151F860233;
 Fri, 30 Oct 2026 21:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990971F000C1;
 Fri, 30 Oct 2026 21:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793397283;
 bh=m10VQPyxgYwll6llfWjczwyIcOTNZs4OCPMKmN2LgEg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SLmeWB/b+mwLMkyyqCs+VL6zn6VG+cNyZ0O6hci39nYJSrrlQ0/q4TmhNB5tvUvp/
 +0mTBniKysBMxYMISrz6cjM23LIqhte9J/oYNGIckO2+JSu1g78kxlzIYm0LQe6MOv
 0kLfeM8szhgEO5vCrCO3/VKxaId4+eLr6/jn9/+/0iRirD7uLkGLLc26VABhyVki5D
 BGM8fmmxsEt57NXtwVw5Er2rVAEyqzUHr1mCtxOCPEGPg+EsOLnoRG0LWp7qwBLu9v
 3WCsBChGTSpoNmRSu2oZn9mm/Np+x1OmvSwaSQYOSsJ7ls30Go8MpkAg5icI8wMfpw
 Tq3aS1JdaoqxQ==
Message-ID: <sashiko-outbox-191554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] drm/msm: Treat !mapped as an error
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261030213251.55365-7-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
 <20261030213251.55365-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:54:43 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

commit 9f62bb971f89fec6afb029cd8bd570abb08a5696
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Treat !mapped as an error

This commit treats a zero-byte mapping result in __do_map() as an error so
that the caller can mark the VM as unusable rather than silently mapping
nothing.

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
> +
>  			if (ret) {
>  				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, ops);
>  				return -EINVAL;

[Severity: Medium]
As reported by Sashiko on v3 [1], can __do_map() in
drivers/gpu/drm/msm/msm_iommu.c still silently return 0 without mapping the
requested range when sg_table entries have zero or short DMA lengths?

The new check is inside the inner while (size) loop, where size is already
non-zero (and where ops->map() returning ret =3D=3D 0 with mapped =3D=3D 0 =
would
previously have spun in an infinite loop rather than returning early; note
also that setting ret =3D -ENOMEM is immediately overwritten by returning
-EINVAL).

However, when an sg_table entry has size =3D sg_dma_len(sg) =3D=3D 0 (for e=
xample,
an unmapped sg_table when CONFIG_NEED_SG_DMA_LENGTH is enabled), the earlier
check in __do_map():

	for_each_sgtable_dma_sg (sgt, sg, i) {
		size_t size =3D sg_dma_len(sg);
		phys_addr_t phys =3D sg_dma_address(sg);

		if (!len)
			break;

		if (size <=3D off) {
			off -=3D size;
			continue;
		}

evaluates 0 <=3D off as true for unsigned size_t off and continues past the
while (size) loop without ever reaching the !mapped check.

Similarly, if sgt->nents is 0 or the total sg_dma_len(sg) across sgt is less
than off + len, the outer for_each_sgtable_dma_sg() loop finishes with
len > 0 and __do_map() unconditionally returns 0 at the end of the function:

			if (ret) {
				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, ops);
				return -EINVAL;
			}
		}
	}

	return 0;
}

without calling __do_unmap() on any partially mapped range or returning an
error to mark the VM as unusable.

Should __do_map() check whether len !=3D 0 after the for_each_sgtable_dma_s=
g()
loop (unmapping [iova, addr) and returning an error if so), and should the
sibling while (len) loop in msm_iommu_pagetable_map_prr() also guard against
!ret && !mapped?

[1] https://lore.kernel.org/r/20261027230452.130031-7-robin.clark@oss.qualc=
omm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030213251.5536=
5-1-robin.clark@oss.qualcomm.com?part=3D6
