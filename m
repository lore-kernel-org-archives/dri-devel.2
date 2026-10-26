Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E242606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFFPQDxY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BFB10EBD9;
	Mon, 26 Oct 2026 07:21:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC78C10EBF6;
 Mon, 26 Oct 2026 07:20:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DADA8600CB;
 Mon, 26 Oct 2026 07:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE0C1F01825;
 Mon, 26 Oct 2026 07:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999257;
 bh=7F8/Dw2IEZGp7meIs3INlSoTvSdn/zEE5T/r1TSFuKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nFFPQDxYfmgp6kQwjsXqGbcRzO+yrHuqedwXfacF/KBfjO7uhpOkGb0gSK/ee+BK6
 oFJAC7NLIgWtdEnk5/pc0ZXWvIyHfh+05CR9EyL7p8Z0oiKkStBWFtqGHHsqyVxOxD
 LZ4aD1rkR+r0fosVpepP5fJes7IoX0LAObfiFtCTfCnFPN2NoY7ccEcFHdQ436Xcq0
 mNNxKd0ZhzUOTBtcLYFn8Gnawz5zBVGE3yT207ijR/8SV6utAHyYXevWAHNKd9TIVl
 GggDHQ3YRMuFmLLybrUEA55mjatB6okfKn5cpVG6mwwGtAooE3zpcegoNnNbiLqys/
 h7uYz8hb3I50w==
Message-ID: <sashiko-outbox-184656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/26] dma-buf: Add dma_buf_mapping_attach()
To: "Alistair Popple" <apopple@nvidia.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261026053623.202642-4-apopple@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-4-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:20:56 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma-buf: NULL pointer dereference of importer_ops in dma_buf_dynam=
ic_attach()
--

commit 4415ca9de8f7d7c189e76efc4aa022c3564f88f1
Author: Jason Gunthorpe <jgg@ziepe.ca>

dma-buf: Add dma_buf_mapping_attach()

This commit introduces dma_buf_mapping_attach() to match importer-supported
mapping types against exporter-supported mapping types during attachment. It
also converts dma_buf_attach() and dma_buf_dynamic_attach() into wrappers
around dma_buf_mapping_attach().

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef5..16a7fbb8aaabe 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c

[ ... ]

> @@ -1025,31 +1035,55 @@ dma_buf_pin_on_map(struct dma_buf_attachment *att=
ach)

[ ... ]

> -	attach->dev =3D dev;
>  	attach->dmabuf =3D dmabuf;
> -	if (importer_ops)
> -		attach->peer2peer =3D importer_ops->allow_peer2peer;
>  	attach->importer_ops =3D importer_ops;
>  	attach->importer_priv =3D importer_priv;

[ ... ]

> @@ -1068,23 +1103,53 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, st=
ruct device *dev,

[ ... ]

> +/**
> + * dma_buf_dynamic_attach - Add the device to dma_buf's attachments list
> + * @dmabuf:		[in]	buffer to attach device to.
> + * @dev:		[in]	device to be attached.
> + * @importer_ops:	[in]	importer operations for the attachment
> + * @importer_priv:	[in]	importer private pointer for the attachment
> + *
> + * Wrapper to call dma_buf_mapping_attach() for drivers which only suppo=
rt SGT.
> + */
> +struct dma_buf_attachment *
> +dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
> +		       const struct dma_buf_attach_ops *importer_ops,
> +		       void *importer_priv)
> +{
> +	struct dma_buf_mapping_match sgt_match[] =3D {
> +		DMA_BUF_IMAPPING_SGT(dev, importer_ops->allow_peer2peer ?
> +						  DMA_SGT_IMPORTER_ACCEPTS_P2P :
> +						  DMA_SGT_NO_P2P),
> +	};

[Severity: High]
Can importer_ops be NULL when passed to dma_buf_dynamic_attach(), causing a
NULL pointer dereference when evaluating importer_ops->allow_peer2peer?

Previously, dma_buf_dynamic_attach() guarded this dereference with
if (importer_ops). In-tree callers still rely on passing a NULL importer_ops
pointer here, such as xe_gem_prime_import() when running the non-dynamic KU=
nit
test cases in drivers/gpu/drm/xe/tests/xe_dma_buf.c:

drivers/gpu/drm/xe/xe_dma_buf.c:xe_gem_prime_import() {
	...
	attach_ops =3D &xe_dma_buf_attach_ops;
#if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
	if (test)
		attach_ops =3D test->attach_ops;
#endif

	attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, obj);
	...
}

Note that a later commit in the series, 77ea3fee521c ("dma-buf: Rename
dma_buf_dynamic_attach() to dma_buf_sgt_dynamic_attach()"), renames this
function while keeping the unconditional importer_ops->allow_peer2peer
dereference.

Should dma_buf_dynamic_attach() check importer_ops &&
importer_ops->allow_peer2peer before dereferencing importer_ops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026053623.2026=
42-1-apopple@nvidia.com?part=3D3
