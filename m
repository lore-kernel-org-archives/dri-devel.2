Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA80606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APQhs4kp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB891120F4;
	Thu, 19 Nov 2026 08:24:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869D11120EE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75B8A61B5D;
 Thu, 19 Nov 2026 08:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D5E1F000C6;
 Thu, 19 Nov 2026 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795076684;
 bh=xvI41P0CWZLADxhw7CqGl/n3oVsf8C6A1cksUJMmt40=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=APQhs4kpE9uvOHdvpI63QW8LegiJQogQolFxr/iBedzLom+ILlbYO/gPqBaYErUkx
 +Ggf5NjX4Iz9y2nxjw339mYrvrpBzDve4kVI/3n+/XYJ1l/y/FuV4ODIA4BBmhEpqD
 mBH6P/r8iiyeXrxPlX5PvEj2qDUXQAojKqTnbpnVY/rP2Zw56fl+vaJLOqFk5C++rk
 F/wRSuyqbSStMMzFeIy6kHfVGfYOxKaTTfzP4xbUCa2wY7dDDQnWTIT1EuNh2RpPID
 BxBRhdT7IL4AMD19U0+q33Nkw+d6VJpTSxA40CI6CeeiVnKFCfcOLycoE92VbK+eHU
 ZXio2VyG0kqYQ==
Message-ID: <sashiko-outbox-222665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: hold the dma_resv lock when mapping
 imported buffers
To: "Wang Haoran" <wanghr2026@mail.zgclab.edu.cn>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <1795076088845-1-b103cfa7@mail.zgclab.edu.cn>
References: <1795076088845-1-b103cfa7@mail.zgclab.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:24:43 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] accel/qaic: open-coded dma-buf unlocked map/unmap helpers in
  qaic_data.c
--

commit 393bb58da0dd7ba519229334f4b5698ecdaba857
Author: Wang Haoran <wanghr2026@mail.zgclab.edu.cn>

accel/qaic: hold the dma_resv lock when mapping imported buffers

This commit acquires the buffer reservation lock around
dma_buf_map_attachment() and dma_buf_unmap_attachment() in
qaic_prepare_import_bo() and qaic_unprepare_import_bo().

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index be3ceb8c51a09..8879ffe647c52 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -895,7 +895,9 @@ static int qaic_prepare_import_bo(struct qaic_bo *bo,=
 struct qaic_attach_slice_h
>  	struct sg_table *sgt;
>  	int ret;
> =20
> +	dma_resv_lock(obj->resv, NULL);
>  	sgt =3D dma_buf_map_attachment(obj->import_attach, hdr->dir);
> +	dma_resv_unlock(obj->resv);
>  	if (IS_ERR(sgt)) {
>  		ret =3D PTR_ERR(sgt);
>  		return ret;
> @@ -936,7 +938,9 @@ static int qaic_prepare_bo(struct qaic_device *qdev, =
struct qaic_bo *bo,
> =20
>  static void qaic_unprepare_import_bo(struct qaic_bo *bo)
>  {
> +	dma_resv_lock(bo->base.resv, NULL);
>  	dma_buf_unmap_attachment(bo->base.import_attach, bo->sgt, bo->dir);
> +	dma_resv_unlock(bo->base.resv);
>  	bo->sgt =3D NULL;
>  }

[Severity: Low]
This isn't a bug, but could qaic_prepare_import_bo() and
qaic_unprepare_import_bo() call dma_buf_map_attachment_unlocked() and
dma_buf_unmap_attachment_unlocked() directly instead of open-coding the
dma_resv_lock() and dma_resv_unlock() sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1795076088845-1-b10=
3cfa7@mail.zgclab.edu.cn?part=3D1
