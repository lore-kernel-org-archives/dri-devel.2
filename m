Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA7606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INqPc1Km
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056BF10E186;
	Sat, 14 Nov 2026 18:55:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C003210E186
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:54:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C95545541;
 Sat, 14 Nov 2026 18:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376851F000C7;
 Sat, 14 Nov 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682495;
 bh=yVROt/8jyfedo4q4lPtvEFqLCWK9XqTWRfg12EsypxQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=INqPc1KmlBNnyla2qVP5K4e26B5pcNFSIqXWBrhXEB3jsCb5fIur5wl007dbtKxFf
 mcu73gtPEnvYOjxm9aciAqa4y9gASlTz4WSoBrvuOKL9UxH+SwwqyO2JoK9cjWpT2p
 FMWJmYvRATbGFYYNxZBMW/3AMe8Z1FPKYkyX9N+Zq+M065zudzuCgOidzCKKCkiFVG
 7J+qmVIgwkIpCM7SMNXfYcwMEyqNVUQyyp+tuAZLJhtblSgzGqOiFZ0PfFA72pC7Vb
 SQiKueKbSCacbxewZQTSw03ruwwnM4U4CaJ0yKdDeRpN3KXAeO3g4Ecw7FKWMYpQq7
 Nni+y98VnoziA==
Message-ID: <sashiko-outbox-214913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] remoteproc: qcom_wcnss: migrate to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-3-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:54 +0000
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
- [High] remoteproc: qcom_wcnss: pass &wcnss->mem_reloc pointer to
  qcom_mdt_pas_load()
--

commit bbce99972cf43472e018d3d98b3d4c3750b4305e
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and qcom_pas_prepare=
_and_auth_reset()

This commit allocates a PAS context in wcnss_probe() and migrates
wcnss_load() and wcnss_start() to qcom_mdt_pas_load() and
qcom_pas_prepare_and_auth_reset().

> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wc=
nss.c
> index c856a92af43ce..750395922ef63 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -96,6 +96,7 @@ struct qcom_wcnss {
>  	phys_addr_t mem_reloc;
>  	void __iomem *mem_region;
>  	size_t mem_size;
> +	struct qcom_pas_context *pas_ctx;
> =20
>  	struct qcom_rproc_subdev smd_subdev;
>  	struct qcom_sysmon *sysmon;
> @@ -157,9 +158,7 @@ static int wcnss_load(struct rproc *rproc, const stru=
ct firmware *fw)
>  	struct qcom_wcnss *wcnss =3D rproc->priv;
>  	int ret;
> =20
> -	ret =3D qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> -			    (__force void *)wcnss->mem_region, wcnss->mem_phys,
> -			    wcnss->mem_size, &wcnss->mem_reloc);
> +	ret =3D qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, wcnss->m=
em_reloc);

[Severity: High]
Should the fourth argument to qcom_mdt_pas_load() be &wcnss->mem_reloc
instead of wcnss->mem_reloc?

qcom_mdt_pas_load() takes a phys_addr_t * for reloc_base, so passing
wcnss->mem_reloc by value fails to build with -Werror=3Dint-conversion (or
dereferences the physical address as a pointer in
qcom_mdt_load_no_init()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D2
