Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE7606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+BTABnB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABA110F0C3;
	Tue, 17 Nov 2026 16:24:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF8D10F303
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:24:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC26B41E4B;
 Tue, 17 Nov 2026 16:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA241F000C4;
 Tue, 17 Nov 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932652;
 bh=qrx9qE8zRd0IU362otKnR8Gq/q6GB0SlkwAX/o+csn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L+BTABnBMOrnoq/KAheTD9E5HTIBdsSkC84kLDPEpwTn5J9Guhp+gNXCnva+xNKnQ
 HmPsRGafbeDlQqb3gpK3ao6LnpAzhpSzknfX0F2jAI+Q1wkX+Fg9mon8H4RN95okpW
 USST1YJfW68UnH2C/YCSNu4ySG6YPXY3X1lSOAK+cUi5KiBhuAbT/r+a7MktOLGEF6
 dE4wMJUZQZZ7D8bjdDFibZUgAGX8HGuopidTz4EyvRnimbDTGxJnhoUsXZSJc2PDWZ
 h4Hx3d2Q7RutOEwpWzqPjMawOdD5EDnD3Ubh5jNkby7QBj6arFP+JTWejZgPr2QMwY
 SLZl7toNmxnDQ==
Message-ID: <sashiko-outbox-219165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261116162148.2864501-7-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:24:12 +0000
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
- [Medium] net: ipa: leak of PAS metadata buffer in ipa_firmware_load()
--

commit e29d8ec88fcd553654746e0eff27a3767cbabafc
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

net: ipa: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prep=
are_and_auth_reset()

This commit replaces the open-coded memremap(), qcom_mdt_load(), and
qcom_pas_auth_and_reset() sequence in ipa_firmware_load() with
qcom_pas_context_init(), qcom_mdt_pas_load(), and
qcom_pas_prepare_and_auth_reset().

> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 14ac2d2faf7c2..0a37741c22858 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
> =20
>  static int ipa_firmware_load(struct device *dev)
>  {
> +	struct qcom_pas_context ctx;
>  	const struct firmware *fw;
>  	struct resource res;
>  	phys_addr_t phys;
>  	const char *path;
> -	ssize_t size;
> -	void *virt;
>  	int ret;
> =20
>  	ret =3D of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> @@ -615,24 +614,18 @@ static int ipa_firmware_load(struct device *dev)
>  	}
> =20
>  	phys =3D res.start;
> -	size =3D (size_t)resource_size(&res);
> -	virt =3D memremap(phys, size, MEMREMAP_WC);
> -	if (!virt) {
> -		dev_err(dev, "unable to remap firmware memory\n");
> -		ret =3D -ENOMEM;
> -		goto out_release_firmware;
> -	}
> +	qcom_pas_context_init(&ctx, dev, IPA_PAS_ID, phys, resource_size(&res));
> =20
> -	ret =3D qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL=
);
> +	ret =3D qcom_mdt_pas_load(&ctx, fw, path, NULL);
>  	if (ret) {
>  		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	} else {
> -		ret =3D qcom_pas_auth_and_reset(IPA_PAS_ID);
> -		if (ret)
> -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +		goto out_release_firmware;
>  	}
> =20
> -	memunmap(virt);
> +	ret =3D qcom_pas_prepare_and_auth_reset(&ctx);
> +	if (ret)
> +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +
>  out_release_firmware:
>  	release_firmware(fw);

[Severity: Medium]
Does this leak the metadata buffer stored in ctx.ptr when
ipa_firmware_load() returns?

Previously, qcom_mdt_load() passed a NULL context to
__qcom_mdt_pas_init(), so qcom_pas_init_image() freed the metadata buffer
immediately.  qcom_mdt_pas_load() instead passes &ctx to
__qcom_mdt_pas_init() -> qcom_pas_init_image(), which retains the coherent
DMA or TEE shared-memory allocation in ctx.ptr until
qcom_pas_metadata_release(&ctx) is called.  Because ipa_firmware_load()
never calls qcom_pas_metadata_release(&ctx), the metadata buffer is leaked
on both the normal path and if qcom_mdt_pas_load() fails after
qcom_pas_init_image() succeeds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116162148.2864=
501-1-mukesh.ojha@oss.qualcomm.com?part=3D6
