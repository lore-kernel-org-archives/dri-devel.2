Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1781DCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1132D10E6B0;
	Wed, 10 Jun 2026 03:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="buw65NS/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C15D10E6B0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:01:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDB9C6024D;
 Wed, 10 Jun 2026 03:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2DF1F00893;
 Wed, 10 Jun 2026 03:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781060514;
 bh=5ayOPeYHF9Nsof9FS2Ga+hKvXFOimYZ0jzIRKz1fsAc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=buw65NS/NU+lbatgUtCk6rlo5Z2wdnzthBkCaG4M8PZ0PEDnnY9wvS1VtOc1FOrjQ
 OUhKvWBI7HjjTwA+/nVed7+W/NbfdQleN1ybN7FX/a/EtOm973wbr6uCwOZ/Ql7ryk
 BKlNaqwFXo3Uxj8BV8UIxx1AM0NPzsloLhMqsdcu2A7A7nTr0/1OrzudAk/uE11ny6
 NXBuMqvYeUYpvTgAcxGcgsCa8pca36aH8Ft0w0H5SfiKoOcJpZcJi9Rj4/kGDK0kDr
 yyruhUuFv/gA70h0hlRj+zFbEqzi7l1+iGcFRjV99OMnxIRh92rXI+XkDF84bEdX8V
 VJhrLHEN19A0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
To: "Dawei Feng" <dawei.feng@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
References: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 03:01:53 +0000
Message-Id: <20260610030154.4E2DF1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checking when parsing firmware headers allows out-o=
f-bounds memory accesses.
--

commit 72846afc6e077321cb6e56447e8430295e342e68
Author: Dawei Feng <dawei.feng@seu.edu.cn>

nouveau/firmware: fix memory leak on BL load failure

This patch addresses a memory leak when loading the HS bootloader blob
fails. It routes the failure to the done label so that the partially
initialized firmware state can be properly cleaned up rather than returning
immediately.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/n=
ouveau/nvkm/falcon/fw.c
> --- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c

[ ... ]

> @@ -277,19 +277,20 @@ nvkm_falcon_fw_ctor_hs(const struct nvkm_falcon_fw_=
func *func, const char *name,
>  	fw->dmem_sign =3D loc - lhdr->data_dma_base;
> =20
>  	if (bl) {
> -		nvkm_firmware_put(blob);
> +		const struct firmware *blob_bl;
> =20
> -		ret =3D nvkm_firmware_load_name(subdev, bl, "", ver, &blob);
> +		ret =3D nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
>  		if (ret)
> -			return ret;
> +			goto done;
> =20
> -		hdr =3D nvfw_bin_hdr(subdev, blob->data);
> -		desc =3D nvfw_bl_desc(subdev, blob->data + hdr->header_offset);
> +		hdr =3D nvfw_bin_hdr(subdev, blob_bl->data);
> +		desc =3D nvfw_bl_desc(subdev, blob_bl->data + hdr->header_offset);
> =20
>  		fw->boot_addr =3D desc->start_tag << 8;
>  		fw->boot_size =3D desc->code_size;
> -		fw->boot =3D kmemdup(blob->data + hdr->data_offset + desc->code_off,
> +		fw->boot =3D kmemdup(blob_bl->data + hdr->data_offset + desc->code_off,
>  				   fw->boot_size, GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does the firmware parsing
code in nvkm_falcon_fw_ctor_hs() lack bounds checking?

The offsets (such as hdr->header_offset, hdr->data_offset, and
desc->code_off) and sizes (like desc->code_size) are read directly from the
firmware blob. Because functions like nvfw_bin_hdr() and nvfw_bl_desc() do
not take the buffer size as an argument, they cannot perform structural
validation.

Could a malformed or corrupted firmware file cause an out-of-bounds memory
access when kmemdup() tries to copy data, or trigger an unusually large
allocation if desc->code_size is excessively large without being validated
against the total firmware size (blob_bl->size)?

> +		nvkm_firmware_put(blob_bl);
>  		if (!fw->boot)
>  			ret =3D -ENOMEM;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610025037.4115=
412-1-dawei.feng@seu.edu.cn?part=3D1
