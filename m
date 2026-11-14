Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AD606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjpteExJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D3D10E649;
	Sat, 14 Nov 2026 18:55:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C5F10E590
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:54:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B3F845A6A;
 Sat, 14 Nov 2026 18:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2601F000C5;
 Sat, 14 Nov 2026 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682497;
 bh=klBgaalKgQAl1KlAABtT3hSSeOoMEmMSHb+szwhcuFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PjpteExJ4BqRNd65kh0hThnZ39Vtbmb1n6wuwcyEhTeugvH/kquYhLDZfVNTNs1bw
 c/0TsZsVTHYp1Iew789rNG9kzd7jIKGFRZUrUnL0kCZ28GKCMRJbnLkjGg9qAoZnrz
 vAB3QXJ1ViE/9gEVia1hmU4HpSe7+lqPNBCYgRO46eXr5Fhm4f3XEYXuOqI87zzPRs
 hH8KmxxJ58dpeGjNjdhcOEIfb0YLrjbuvxTALuLdfI/96tOzjOElvrDQTLW+anBHeh
 gpETgHeEZebSRazIit143CZ9cVAUx3MKE8IxW7w6efuJ6Z39GR7W2K4XWf5yA++H5G
 5JRptUg/pPcmA==
Message-ID: <sashiko-outbox-214916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-6-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:56 +0000
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
- [Medium] media: venus: PAS metadata buffer leak in venus_load_fw() and
  venus_boot()
--

commit 82fbd4dcc81174e35cd1220225cd23273f0e119b
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: venus: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_=
prepare_and_auth_reset()

This commit migrates the TrustZone firmware loading path in the Venus
driver to use a PAS context with qcom_mdt_pas_load() and
qcom_pas_prepare_and_auth_reset().

> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media=
/platform/qcom/venus/firmware.c
> index 3a38ff985822f..704343e241dc6 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -117,21 +117,22 @@ static int venus_load_fw(struct venus_core *core, c=
onst char *fwname,
>  		goto err_release_fw;
>  	}
> =20
> -	mem_va =3D memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> -	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, =
*mem_size);
> -		ret =3D -ENOMEM;
> -		goto err_release_fw;
> -	}
> -
> -	if (core->use_tz)
> -		ret =3D qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> -				    mem_va, *mem_phys, *mem_size, NULL);
> -	else
> +	if (core->use_tz) {
> +		qcom_pas_context_init(&core->fw.pas_ctx, dev, VENUS_PAS_ID,
> +				      *mem_phys, *mem_size);
> +		ret =3D qcom_mdt_pas_load(&core->fw.pas_ctx, mdt, fwname, NULL);
> +	} else {
> +		mem_va =3D memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> +		if (!mem_va) {
> +			dev_err(dev, "unable to map memory region %pa size %#zx\n",
> +				mem_phys, *mem_size);
> +			ret =3D -ENOMEM;
> +			goto err_release_fw;
> +		}
>  		ret =3D qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
>  					    *mem_phys, *mem_size, NULL);
> -
> -	memunmap(mem_va);
> +		memunmap(mem_va);
> +	}
>  err_release_fw:
>  	release_firmware(mdt);
>  	return ret;
> @@ -237,7 +238,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys =3D mem_phys;
> =20
>  	if (core->use_tz)
> -		ret =3D qcom_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret =3D qcom_pas_prepare_and_auth_reset(&core->fw.pas_ctx);
>  	else
>  		ret =3D venus_boot_no_tz(core, mem_phys, mem_size);

[Severity: Medium]
As reported by Konrad Dybcio on v1 [1], does this leak the PAS metadata
buffer stored in core->fw.pas_ctx.ptr?

Unlike qcom_mdt_load(), which passes a NULL context to
qcom_pas_init_image() so the metadata buffer is freed immediately,
qcom_mdt_pas_load() passes &core->fw.pas_ctx and retains the metadata
allocation in core->fw.pas_ctx.ptr until qcom_pas_metadata_release() is
called.  Because qcom_pas_metadata_release(&core->fw.pas_ctx) is never
called after qcom_pas_prepare_and_auth_reset() or on error in
qcom_mdt_pas_load(), every boot and system error recovery cycle in
venus_sys_error_handler() -> venus_boot() overwrites core->fw.pas_ctx via
qcom_pas_context_init() and leaks the buffer.

[1] https://lore.kernel.org/r/ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D5
