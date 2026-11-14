Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912E606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmWNL+2k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8F510E789;
	Sat, 14 Nov 2026 18:55:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DBC10E6F7
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:55:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7445945B34;
 Sat, 14 Nov 2026 18:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC1D1F000C5;
 Sat, 14 Nov 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682499;
 bh=x0suZMqUZombL7FtCyQmS1vyDtWujulgrOLcNZf0x3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WmWNL+2ktjp2UoA3SKynZHx6VwKLiyPHuFrK9YkqIdk5atMYVzUwsbCD2tDeAXhcq
 cWXCSb0zI6n8Rp2S7QgMLeBN4P8ALgaOlVbWauSK0Y9yL7UUum5qt6c2pRgsfeELb0
 c+bVHbh2kQdhbDrKKKY4C+sCAm0aPeQnzMjTHmKkhk25q8fKJzz6SP0P9UjDkDkN+1
 WuWtlak0YNASArt9u6LA8n/XU8LdV/gLSHjWIsfcjKz5nym+G1bk2C+eER6TiIvuEz
 z1fH/zxVvoc6veHbKKkU3QUFtXnmB8av6iGkWsTzeZWqFAxo52aTh1TvLT9W/2lnr2
 +GSwnob3hwpgQ==
Message-ID: <sashiko-outbox-214919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] soc: qcom: mdt_loader: remove qcom_mdt_load()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-9-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-9-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:58 +0000
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

commit 1090e40402733b5aabfbf149a8510b247a28a308
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

soc: qcom: mdt_loader: remove qcom_mdt_load()

This commit removes the unused qcom_mdt_load() helper and moves memory
region mapping from qcom_mdt_pas_load() into qcom_mdt_load_no_init() when
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
>  EXPORT_SYMBOL_GPL(qcom_mdt_pas_load);

[Severity: Medium]
Why move the ioremap_wc() mapping from qcom_mdt_pas_load() into
qcom_mdt_load_no_init() when this patch is only supposed to remove the
unused qcom_mdt_load()?

qcom_pas_ctx_map() in include/linux/firmware/qcom/qcom_pas.h already
encapsulates this exact ioremap_wc() and dev_err() sequence for PAS
callers:

include/linux/firmware/qcom/qcom_pas.h:qcom_pas_ctx_map() {
	void __iomem *ptr =3D ioremap_wc(ctx->mem_phys, ctx->mem_size);

	if (!ptr)
		dev_err(ctx->dev, "unable to map memory region: %pa+%zx\n",
			&ctx->mem_phys, ctx->mem_size);
	return ptr;
}

Open-coding it inside qcom_mdt_load_no_init() duplicates qcom_pas_ctx_map()
and drops the !mem_region -EINVAL check for non-PAS callers (such as
venus_load_fw(), adsp_load(), and q6v5_wcss_load()), so a caller that
passes a NULL mem_region after an unchecked mapping failure will silently
remap the region instead of failing with -EINVAL.  None of these changes to
qcom_mdt_load_no_init() and qcom_mdt_pas_load() are mentioned in the commit
message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D8
