Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FD7C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3923C10E2FB;
	Sat, 26 Sep 2026 15:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzBq9BPY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB15810E19A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDE41600D1;
 Sat, 26 Sep 2026 15:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624D11F000FF;
 Sat, 26 Sep 2026 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438377;
 bh=zeIvHuonCtrbK4rUmfxQVDloDE9CqNKMoaMsSkWlGoQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nzBq9BPYKweEJfYNpD2Raxci6zaeZp7dYIVNk3lMBv/Y5CLzWBvfA0Hc7C39sbjLD
 Zbk6AUZam9/+HyHAAK4ooOtz2/39pHZnGcGBdeiQNNLrH01UwEg556D85+kCtgPfDh
 D0SFpLtQ1Av9TEG7bojL7bksjBGTeu9+rHIKFt9dyXMNQdNjLg8B84U2MYCxi3/1Nt
 IEsOGjKryUPRFKQc3KbVUXbda3kMg/VlCLDNW3hYfXOroKK+PTeLMGZgpkMnMHVs/+
 TvE9maoJFDIESd5wfMy/c0oBuiPJ6XvOcFvq2m2ZhjMpPeM/j1VspTHNTSgXnVMTXk
 dfb3MPkO4EAWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:36 +0000
Message-Id: <20260926155937.624D11F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: ipa: shmbridge setup bypassed due to uninitialized ctx->use_t=
zmem flag
- [Medium] net: ipa: memory leak of PAS metadata DMA buffer due to missing =
qcom_pas_metadata_release()
--

commit 5216b43b65b5b9e8f76798ae9a011c6d5ce85515
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
net: ipa: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prep=
are_and_auth_reset()

This commit replaces open-coded memory mapping and firmware loading
sequences with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load().
It then uses qcom_pas_prepare_and_auth_reset() with the goal of
performing the shmbridge prepare step required before TrustZone
authentication.

> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 14ac2d2faf7c2..6964395caedd9 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c

[ ... ]

> @@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
>  	}
> =20
>  	phys =3D res.start;
> -	size =3D (size_t)resource_size(&res);
> -	virt =3D memremap(phys, size, MEMREMAP_WC);
> -	if (!virt) {
> -		dev_err(dev, "unable to remap firmware memory\n");
> -		ret =3D -ENOMEM;
> +	ctx =3D devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
> +					  resource_size(&res));
> +	if (IS_ERR(ctx)) {
> +		ret =3D PTR_ERR(ctx);
>  		goto out_release_firmware;
>  	}

[Severity: High]
Does allocating the context here leave the use_tzmem flag implicitly
initialized to false?

The commit message states the goal is to execute the shmbridge prepare
step. However, since devm_qcom_pas_context_alloc() allocates the context
using devm_kzalloc(), the ctx->use_tzmem boolean defaults to false.

When qcom_pas_prepare_and_auth_reset(ctx) is called later, the backend
evaluates this flag. If it is false, it falls back to the legacy
authentication path and completely bypasses the intended
qcom_tzmem_shm_bridge_create() logic.

Should ctx->use_tzmem be explicitly set to true after allocation?

> =20
> -	ret =3D qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL=
);
> +	ret =3D qcom_mdt_pas_load(ctx, fw, path, NULL);
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
> +	ret =3D qcom_pas_prepare_and_auth_reset(ctx);
> +	if (ret)
> +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +
>  out_release_firmware:
>  	release_firmware(fw);
> =20

[Severity: Medium]
Will returning from this path leak the DMA buffer containing the firmware
metadata?

When qcom_mdt_pas_load() is called, it triggers the allocation and mapping
of a DMA buffer for the metadata, storing its address in ctx->ptr. While
the context structure itself is devres-managed, the underlying PAS backend
requires callers to explicitly free the metadata buffer.

If the function returns without calling qcom_pas_metadata_release(ctx),
does this result in a permanent memory leak of the metadata buffer on
every probe attempt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D5
