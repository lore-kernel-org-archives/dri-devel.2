Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A7606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GW0FEGfj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DA510F306;
	Tue, 17 Nov 2026 16:24:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB9110F0C3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:24:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EBAD60F97;
 Tue, 17 Nov 2026 16:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52811F000C4;
 Tue, 17 Nov 2026 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932652;
 bh=8RyOF8LaC+8CLA4XafFg4R6Oj7PEEwS3GUTt5nGMZkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GW0FEGfj+OIeEJGtu2N5YkX8kidMa2lIgufzGEoE0VrvIs6ZEmzUZb2+eKbmYXafe
 zsqJsbwvh21kw5AiC3QGq+K9FyQEluWo2EEnTzA9BhpijP4n5KP3IDLxrhcA+6XsGx
 Qwx2Tc5BOS6ZOPlJWnz+lfKYxr+MKJM5WYitC2QuDceGQTdJg7DLM7qp1Nm9PojWoJ
 1KMYHeIoJ/Hv6OKe4fy3Jqs6Pmydd6Kd+/spGZdplIWA/5gxAIkJ8f4WGlIkFZUflK
 ipL/Wr4pnf7aBtOymY/kkbwXcnalCIndtBwQkIlLQgKz1SEmQ7QbZ0jQmeIHkzF7hK
 Hx6mJXMRcoB4w==
Message-ID: <sashiko-outbox-219164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-6-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:24:11 +0000
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

commit 197c5c883871fbbcc35bb55913a4e0eb4bf2cd11
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: venus: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_=
prepare_and_auth_reset()

This commit embeds a struct qcom_pas_context in struct video_firmware and
switches the TrustZone firmware loading path in venus_load_fw() and
venus_boot() to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().

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
buffer in core->fw.pas_ctx.ptr?

Unlike qcom_mdt_load(), which passes a NULL context to
qcom_pas_init_image() so the metadata buffer is freed immediately,
qcom_mdt_pas_load() passes &core->fw.pas_ctx, causing
qcom_pas_init_image() to retain the metadata allocation in
core->fw.pas_ctx.ptr until qcom_pas_metadata_release() is called.
Nothing calls qcom_pas_metadata_release(&core->fw.pas_ctx) after
qcom_pas_prepare_and_auth_reset() or if qcom_mdt_pas_load() fails after
qcom_pas_init_image() succeeds, and subsequent recovery boots via
venus_sys_error_handler() -> venus_boot() overwrite core->fw.pas_ctx in
qcom_pas_context_init().

[1] https://lore.kernel.org/r/ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116162148.2864=
501-1-mukesh.ojha@oss.qualcomm.com?part=3D5
