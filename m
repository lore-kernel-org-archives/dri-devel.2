Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C6606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXHuV+nu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E20F10E5CC;
	Sat, 14 Nov 2026 18:55:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5097610E649
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BAD561CFB;
 Sat, 14 Nov 2026 18:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41401F000C5;
 Sat, 14 Nov 2026 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682498;
 bh=J6cW65eThHtGVOFXjimhk5/gjH4eo9kyKFi45jNILag=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YXHuV+nuYuLUvaxQx2v6kTTNH96kOzOpRTQ2KAosqyR5BbWtKkb4NrGR/o2GxUlsp
 nhoXqVjq1vEwH8kcejer73hlYmnMEB3bunh3ATMhBATMaYsPrdp5wvF+Eoz89ncmAw
 Aj7Tbcc9faW7IGacnsHP1gVPuy61DTqtD8JH9JjliGPpuSpt4A/bYbY1OvtpLTJxiJ
 YgzMCmy2oBmeIAW/cA40pH4vWezmzb2r58fAhPk4dbz1iEZ4uXoAOUglVERgIWCFIp
 qIyaoXQ0OY/5c3DfMrbo0GpnFZD+yh6cgNM0w+EWrcRIi4uAjF7Pp+WzPFdrqzR5zl
 biJElLrutZ6Yg==
Message-ID: <sashiko-outbox-214917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-7-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:57 +0000
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
- [Medium] net: ipa: missing qcom_pas_metadata_release() in
  ipa_firmware_load()
--

commit 5c113c8e8e89734c8d281cbb95db1ce83f9398ac
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

net: ipa: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prep=
are_and_auth_reset()

This commit replaces the memremap(), qcom_mdt_load(), and
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
Does this leak the firmware metadata buffer stored in ctx.ptr?

Previously, qcom_mdt_load() called __qcom_mdt_pas_init() with a NULL contex=
t,
so qcom_scm_pas_init_image() freed the coherent DMA metadata buffer before
returning:

drivers/firmware/qcom/qcom_scm.c:qcom_scm_pas_init_image() {
    ...
	if (ret < 0 || !ctx) {
		dma_free_coherent(dev, size, mdata_buf, mdata_phys);
	} else if (ctx) {
		ctx->ptr =3D mdata_buf;
		ctx->phys =3D mdata_phys;
		ctx->size =3D size;
	}
    ...
}

Passing a non-NULL &ctx to qcom_mdt_pas_load() retains that buffer in
ctx.ptr.  Because this tree does not include 2aa8fafc08e7 ("firmware: qcom:
pas: Make MDT buffer retention explicit"), qcom_pas_init_image() does not
release ctx.ptr on its own, and ipa_firmware_load() returns without calling
qcom_pas_metadata_release(&ctx), leaking the allocation when ctx goes out of
scope.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D6
