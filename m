Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4848606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9c4GV3w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DC810F4B9;
	Tue, 17 Nov 2026 16:24:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB4A10F156
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:24:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D2BC60A59;
 Tue, 17 Nov 2026 16:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5F81F000C4;
 Tue, 17 Nov 2026 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932654;
 bh=nnE7gZEXiHtcsYIm1VlvFrJqU+spDES/J69MX7It/v8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z9c4GV3wB6qT7hIy2EvUU3veq3pWrbGIMr3NLHvsEwPTu8rFdm6lMl7T+Xoo5uBwY
 Q3y88eY/ecPiifNRerPJCaVufdwbAMe17zCF9JwELIcBUUJbBqF8x+l6jEenjT56z+
 vpxJ59lJvEQUELd0mIQTVVurTpPkhXCEbNmoolexCatrSFnvtqMQUAevHa5+80yvo1
 yfku1Q9E7bTEnWQiOETXrbNs2v1yaiLRVEXi+N0Hi9KRR29dv8ee3WPWNiWT2r3l3t
 GEFYxrbpTqU95++ujgIPOGkqkgKnzBanUlHPEVaoEL9u3bMrgO8pLqzpovLH/4Q9tn
 mnYdY4Gw3fm5g==
Message-ID: <sashiko-outbox-219167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] soc: qcom: mdt_loader: remove qcom_mdt_load()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261116162148.2864501-9-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-9-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:24:13 +0000
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
- [Medium] soc: qcom: mdt_loader: undocumented mapping change in
  qcom_mdt_load_no_init()
--

commit eab28e4077f6ee900ea4fd6648711acdb8ef064c
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

soc: qcom: mdt_loader: remove qcom_mdt_load()

This commit removes the unused qcom_mdt_load() wrapper and moves memory
mapping from qcom_mdt_pas_load() into qcom_mdt_load_no_init() when
mem_region is NULL.

> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index aafa83466b92b..436d8bc4847a3 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -326,7 +326,8 @@ static bool qcom_mdt_bins_are_split(const struct firm=
ware *fw)
>   * @dev:	device handle to associate resources with
>   * @fw:		firmware object for the mdt file
>   * @fw_name:	name of the firmware, for construction of segment file names
> - * @mem_region:	allocated memory region to load firmware into
> + * @mem_region:	virtual address of the memory region to load firmware in=
to,
> + *		or NULL to have the region mapped internally with ioremap_wc()
>   * @mem_phys:	physical address of allocated memory region
>   * @mem_size:	size of the allocated memory region
>   * @reloc_base:	adjusted physical address after relocation
> @@ -341,6 +342,7 @@ int qcom_mdt_load_no_init(struct device *dev, const s=
truct firmware *fw,
>  	const struct elf32_phdr *phdrs;
>  	const struct elf32_phdr *phdr;
>  	const struct elf32_hdr *ehdr;
> +	void __iomem *mapped =3D NULL;
>  	phys_addr_t mem_reloc;
>  	phys_addr_t min_addr =3D PHYS_ADDR_MAX;
>  	ssize_t offset;
> @@ -350,12 +352,22 @@ int qcom_mdt_load_no_init(struct device *dev, const=
 struct firmware *fw,
>  	int ret =3D 0;
>  	int i;
> =20
> -	if (!fw || !mem_region || !mem_phys || !mem_size)
> +	if (!fw || !mem_phys || !mem_size)
>  		return -EINVAL;
> =20
>  	if (!mdt_header_valid(fw))
>  		return -EINVAL;
> =20
> +	if (!mem_region) {
> +		mapped =3D ioremap_wc(mem_phys, mem_size);
> +		if (!mapped) {
> +			dev_err(dev, "unable to map memory region: %pa+%zx\n",
> +				&mem_phys, mem_size);
> +			return -ENOMEM;
> +		}
> +		mem_region =3D (__force void *)mapped;
> +	}
> +
>  	is_split =3D qcom_mdt_bins_are_split(fw);
>  	ehdr =3D (struct elf32_hdr *)fw->data;
>  	phdrs =3D (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
> @@ -434,39 +446,13 @@ int qcom_mdt_load_no_init(struct device *dev, const=
 struct firmware *fw,
>  	if (reloc_base)
>  		*reloc_base =3D mem_reloc;
> =20
> +	if (mapped)
> +		iounmap(mapped);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);

[ ... ]

> @@ -486,21 +472,14 @@ EXPORT_SYMBOL_GPL(qcom_mdt_load);
>  int qcom_mdt_pas_load(struct qcom_pas_context *ctx, const struct firmwar=
e *fw,
>  		      const char *firmware, phys_addr_t *reloc_base)
>  {
> -	void __iomem *mem_region;
>  	int ret;
> =20
>  	ret =3D __qcom_mdt_pas_init(ctx->dev, fw, firmware, ctx->pas_id, ctx->m=
em_phys, ctx);
>  	if (ret)
>  		return ret;
> =20
> -	mem_region =3D qcom_pas_ctx_map(ctx);
> -	if (!mem_region)
> -		return -ENOMEM;
> -
> -	ret =3D qcom_mdt_load_no_init(ctx->dev, fw, firmware, (__force void *)m=
em_region,
> -				    ctx->mem_phys, ctx->mem_size, reloc_base);
> -	iounmap(mem_region);
> -	return ret;
> +	return qcom_mdt_load_no_init(ctx->dev, fw, firmware, NULL,
> +				     ctx->mem_phys, ctx->mem_size, reloc_base);
>  }

[Severity: Medium]
Why does this patch move the memory mapping from qcom_mdt_pas_load() into
qcom_mdt_load_no_init()?

The changelog only describes removing qcom_mdt_load(), which was already a
simple wrapper around __qcom_mdt_pas_init() and qcom_mdt_load_no_init().
Moving the mapping into qcom_mdt_load_no_init() duplicates the ioremap_wc()
and error logging already provided by qcom_pas_ctx_map():

include/linux/firmware/qcom/qcom_pas.h:qcom_pas_ctx_map() {
	void __iomem *ptr =3D ioremap_wc(ctx->mem_phys, ctx->mem_size);

	if (!ptr)
		dev_err(ctx->dev, "unable to map memory region: %pa+%zx\n",
			&ctx->mem_phys, ctx->mem_size);
	return ptr;
}

All direct callers of qcom_mdt_load_no_init() manage their own mem_region
mapping.  Dropping the !mem_region check means a non-PAS caller that
inadvertently passes a NULL mem_region after a mapping failure will
silently trigger an internal ioremap_wc() instead of failing with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116162148.2864=
501-1-mukesh.ojha@oss.qualcomm.com?part=3D8
