Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B0C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978E010E385;
	Tue, 11 Aug 2026 20:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WD7qhZGV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB45310E385
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:55:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72EEA41853;
 Tue, 11 Aug 2026 20:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFD91F000E9;
 Tue, 11 Aug 2026 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786481747;
 bh=hIvJEInyyWyEQR8xW4MeUHGiXX1ux5+mx5Qqwh2CB4E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WD7qhZGVSda8r0I6MvPfyBhCdMXKIoTroXj83oQEHG1R5yvguV1Kww38MvMXJWkYX
 +rCtJ0jAV/PhrGvMyCL2BGTnWyBbJmyY9LC6Xsd3Uium2LPNMjsmcNqa2g/1HWPwGC
 CYWFPA2HPRCDfNG2uvGzTgOY4mnW/hckMEMnwvD4ahOo8/O0BFEsJ/kqmgFBMZJC3i
 RrJJeCYpG7h54lwC53MRKODsSVFDGWtIqF+5xeuV1WhrmT36mFh2udoOj/rwjgNxqa
 3VFrqHGpFvCklhdaXIKphl3lZei6BHPCCa+XO9k+uSv4EhICoOI0DrCGmfXEAUdtQZ
 5dp1vOTxdoWDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260811204556.875037-2-taimuraz@kaitmazov.com>
References: <20260811204556.875037-1-taimuraz@kaitmazov.com>
 <20260811204556.875037-2-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:55:46 +0000
Message-Id: <20260811205547.1DFD91F000E9@smtp.kernel.org>
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
- [High] Missing `amdxdna_gem_put_obj()` on the error path in `amdxdna_cmd_=
set_error` leaks a GEM object reference.
--

--- Patch [1]: [PATCH 1/3] accel/amdxdna: refuse an I/O memory mapping of a=
n imported BO ---
commit c573f7ee611c1dede95280b62a62d7abef0e2670
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: refuse an I/O memory mapping of an imported BO

amdxdna_gem_obj_vmap() accepts whatever dma_buf_vmap() returns and only
rejects a NULL vaddr. struct iosys_map is a union discriminated by
is_iomem, so an exporter that answers with an I/O mapping leaves a
void __iomem pointer in map->vaddr, and amdxdna_gem_vmap() stores it in
abo->mem.kva, which callers use as an ordinary kernel address:
amdxdna_cmd_set_error() memsets and memcpys through it.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 1f190b319bb6e..b66ec9e482894 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_obje=
ct *obj, struct iosys_map *ma
> =20
>  	dma_resv_assert_held(obj->resv);
> =20
> -	if (is_import_bo(abo))
> +	if (is_import_bo(abo)) {
>  		ret =3D dma_buf_vmap(abo->dma_buf, map);
> -	else
> +		/* Callers use mem.kva as an ordinary kernel address. */
> +		if (!ret && map->is_iomem) {
> +			dma_buf_vunmap(abo->dma_buf, map);
> +			return -EOPNOTSUPP;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but refusing the mapping here
exposes a reference leak in amdxdna_cmd_set_error().

If unprivileged userspace imports an IOMEM DMABUF and submits it as an
ERT_CMD_CHAIN command that causes an error, we reach this code in
drivers/accel/amdxdna/amdxdna_ctx.c:

	if (amdxdna_cmd_get_op(abo) =3D=3D ERT_CMD_CHAIN) {
		cc =3D amdxdna_cmd_get_payload(abo, NULL);
		cc->error_index =3D (cmd_idx < cc->command_count) ? cmd_idx : 0;
		abo =3D amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
		if (!abo)
			return -EINVAL;
		cmd =3D amdxdna_gem_vmap(abo);
		if (!cmd)
			return -ENOMEM;
	}

Because amdxdna_gem_vmap() will now return NULL for the IOMEM BO, the code
returns -ENOMEM immediately. Does this leak the GEM object reference acquir=
ed
by amdxdna_gem_get_obj() since it bypasses the amdxdna_gem_put_obj() cleanup
located at the end of the function?

> +	} else {
>  		ret =3D drm_gem_shmem_object_vmap(obj, map);
> +	}
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811204556.8750=
37-1-taimuraz@kaitmazov.com?part=3D1
