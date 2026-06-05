Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E79CD6E6E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FCA11A3C2;
	Fri,  5 Jun 2026 02:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5zQmPQV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5225411A3C2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 02:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D4886001A;
 Fri,  5 Jun 2026 02:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35A41F00893;
 Fri,  5 Jun 2026 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780626778;
 bh=R1TBpo6jBHAgilraoULW+Q48luIKP8/Gby4LNmsGMS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z5zQmPQVciEDzdy9TtXrOyUlvUyZqRqVRCxcpjwkOK2uqnrxf6SjMBT5zfxOOw11V
 f1YAqN/AY0JIm5eMaenB7i6/xDuUOE01R2TlhBelG6bQL/HM5GRVOfa3GDyq/cT88a
 7ZHhPSdmMXYf+kueEalid6LrBF6jCBB46ZA5ZnUX43KR7WQKO80rGAUoW/nE3C8jdc
 8IfNDSzbi1lJ32RKOuRitxmJiLyyDkd9KV8AyqATJW/UbxroWD2QCgs5hVwVqrRL9N
 9/WyFHyGrO42Bxly+G47Ps97SIBq8umNka91QoQUXZZXWVIivW2wfAMOef24ZBHdFE
 cYMBxOZds1nlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
To: "Dawei Feng" <dawei.feng@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
References: <20260605020752.1707562-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 02:32:57 +0000
Message-Id: <20260605023257.D35A41F00893@smtp.kernel.org>
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
- [High] Missing bounds checking on firmware blob offsets allows out-of-bou=
nds kernel memory reads.
--

commit 69b65113e7205835c286bfc4a8d86163010bab77
Author: Dawei Feng <dawei.feng@seu.edu.cn>

nouveau/firmware: fix memory leak on BL load failure

If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
immediately, skipping the common cleanup path and leaking firmware state.
This patch routes the load failure to the 'done' label to properly clean up
the partially initialized state and clears the original blob pointer.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/n=
ouveau/nvkm/falcon/fw.c
> index 4e8b3f1c7e25d..71f55c5b08374 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
> @@ -278,10 +278,11 @@ nvkm_falcon_fw_ctor_hs(const struct nvkm_falcon_fw_=
func *func, const char *name,
> =20
>  	if (bl) {
>  		nvkm_firmware_put(blob);
> +		blob =3D NULL;
> =20
>  		ret =3D nvkm_firmware_load_name(subdev, bl, "", ver, &blob);
>  		if (ret)
> -			return ret;
> +			goto done;
> =20
>  		hdr =3D nvfw_bin_hdr(subdev, blob->data);
>  		desc =3D nvfw_bl_desc(subdev, blob->data + hdr->header_offset);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing=20
issue with bounds checking when parsing the firmware blobs.

Does this code safely handle potentially malformed firmware files? When the=
=20
firmware headers are parsed, offsets and sizes like hdr->data_offset,=20
desc->code_off, and desc->code_size are extracted without being validated=20
against the actual blob->size.

Just after this hunk in nvkm_falcon_fw_ctor_hs(), the unvalidated values=20
are used to calculate the source pointer for kmemdup():

    fw->boot =3D kmemdup(blob->data + hdr->data_offset + desc->code_off,
                       fw->boot_size, GFP_KERNEL);

Could this lead to an out-of-bounds read on the kernel heap if a corrupted=
=20
firmware blob is provided? If the read crosses into unmapped memory, it=20
might trigger a kernel oops.

Similarly, earlier in the same function, nvkm_falcon_fw_ctor() is called=20
with unchecked offsets:

    ret =3D nvkm_falcon_fw_ctor(func, name, subdev->device, bl !=3D NULL,
                              blob->data + hdr->data_offset,
                              hdr->data_size, falcon, fw);

Would it be helpful to add validation checks against blob->size before=20
these header values are consumed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605020752.1707=
562-1-dawei.feng@seu.edu.cn?part=3D1
