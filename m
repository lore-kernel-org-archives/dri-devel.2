Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22F606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrdEYpWD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5C710F25C;
	Mon,  9 Nov 2026 12:40:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A1B10F25C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:40:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D6C740AFC;
 Mon,  9 Nov 2026 12:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA231F0089F;
 Mon,  9 Nov 2026 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794228035;
 bh=4dvLub1pdCJ38JQehYcBBTcy8OHJQsDKMiovhr1MrSc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YrdEYpWDD1kmlxWcw9w7VS/VHOBdd/ADKYITIurzKU8pPIusXgvgUqxnQQQxl268S
 DaKt1/kDjFcvqBfSsRkbcY66EPh0+6WV5VKHK2tiHPcTMdXmFKbE15JP2gayGPOjWa
 6xCGYc3JgXzeC++nYaApweYNx4eTyrii/bh+WViiOHONpAN8qabpy2o/5idmf6kX0p
 mG/XH0AyG+3XVe33cmMKOY9i2cGdhFUv06uRjVyBth7PeDWN5qd6T0L+jW2aNBV9aE
 EaEu6n+otBh8fW3nYtkbZGzSMR+xm25pOkiT7HKviyYj1ZWFSHqZ4/qa+wxYxweqzN
 5Zc0JRh7TuXXA==
Message-ID: <sashiko-outbox-204968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dsi: avoid pinning the command buffer on every
 transfer
To: "Michael McAllister" <me@michaelmcallister.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:40:34 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/msm/dsi: double free in msm_dsi_tx_buf_free() [1]
--

commit da2da22a4a147766651afbdf0137d05a0c119858
Author: Michael McAllister <me@michaelmcallister.org>

drm/msm/dsi: avoid pinning the command buffer on every transfer

This commit replaces msm_gem_get_and_pin_iova() with msm_gem_get_iova() in
dsi_dma_base_get_6g() so that fetching the DSI command buffer's DMA address
does not take an additional pin on every transfer.

> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index d92659d80f172..64fc54dff4839 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1428,7 +1428,8 @@ int dsi_dma_base_get_6g(struct msm_dsi_host *msm_ho=
st, uint64_t *dma_base)
>  	if (!dma_base)
>  		return -EINVAL;
> =20
> -	return msm_gem_get_and_pin_iova(msm_host->tx_gem_obj,
> +	/* The command buffer stays pinned from allocation until teardown. */
> +	return msm_gem_get_iova(msm_host->tx_gem_obj,
>  				priv->kms->vm, dma_base);
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can msm_dsi_tx_buf_free()
double free msm_host->tx_buf across component unbind cycles [1]?

drivers/gpu/drm/msm/dsi/dsi_host.c:msm_dsi_tx_buf_free() {
	...
	if (msm_host->tx_gem_obj) {
		msm_gem_kernel_put(msm_host->tx_gem_obj, msm_host->vm);
		drm_gpuvm_put(msm_host->vm);
		msm_host->tx_gem_obj =3D NULL;
		msm_host->vm =3D NULL;
	}

	if (msm_host->tx_buf)
		dma_free_coherent(dev->dev, msm_host->tx_size, msm_host->tx_buf,
			msm_host->tx_buf_paddr);
}

msm_host persists across component bind and unbind cycles, and unlike
msm_host->tx_gem_obj, msm_host->tx_buf is not cleared after
dma_free_coherent().  If a later bind fails before reallocating the buffer,
the resulting unbind calls dma_free_coherent() on the stale msm_host->tx_buf
pointer a second time.

[1] https://sashiko.dev/#/bug/linux-6f5085d3-ef49-482c-86e4-a2438bc1b91f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179422752570.88190.=
13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org?part=3D1
