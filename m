Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A23C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB7210E0A5;
	Mon, 21 Sep 2026 18:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bNIVzhLZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB3310E0A5
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BD8340775;
 Mon, 21 Sep 2026 18:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240F51F000FF;
 Mon, 21 Sep 2026 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790016939;
 bh=ISJsik+jH56QkHsc4zu30qeOoph6ZEzepYBnhhcl2Y4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bNIVzhLZF309a83lVYwmhdh5Rq3ZT6VWt4Sj33FQ/Tw+gBjpc7czHmeDecKaFADd9
 YrJskXUU7py1G82sFyTisseVLWCy4hskfb+9EOz9thGov2/B0lUVpU9P1X6fRCqPh5
 Eh6nuGpcur+w5hdGxTQ+g9dHLGuLEXpr/HClfoG1MHh/TC/H95J4nEUPSDPtX8jqF3
 h3fLGT464Kkyg3J1d2VZt1ebWoQOqNpT8PMyntsoJnW5m7YcDrwx2sDeHCbK4P76Dv
 Qzsw8tLbTfZEIRGV+OzE4phmOwcRYZQGh1sNzjsZgWNO1R3Zi0bwFOMDQYkmV17Gir
 lNb2noD+w5uTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Drop dma-buf wrapping for ubuf
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921184226.18941-1-lizhi.hou@amd.com>
References: <20260921184226.18941-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:55:38 +0000
Message-Id: <20260921185539.240F51F000FF@smtp.kernel.org>
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
- [High] drm/amdxdna: long-term mm_users reference leak in UBUF BO
--

commit 8ad12f14d7bf542056a227118a3d6363ee9a9c90
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Drop dma-buf wrapping for ubuf

This commit makes ubuf a DRM GEM private object and tracks the user VA with
HMM instead of a long-term pin. It creates the BO directly from the VA table
without going through dma-buf.

> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna=
/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..cff5d319ad605 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -35,16 +32,13 @@ static void amdxdna_gem_ubuf_obj_free(struct drm_gem_=
object *gobj)
>  {
> +	struct amdxdna_gem_obj *abo =3D to_xdna_obj(gobj);
> +
> +	amdxdna_hmm_unreg_umaps(abo, true);
> +	cancel_work_sync(&abo->hmm_unreg_work);
> +
> +	if (abo->mem.mm)
> +		mmput(abo->mem.mm);

[Severity: High]
Does this code leak the process's entire virtual address space if the BO
outlives the creating process?

A process calling the create BO ioctl to create a ubuf BO uses
mmget_not_zero() in amdxdna_alloc_ubuf_bo() to store an mm_users reference
on the creating process's mm.=20

If the process then forks or passes the DRM file descriptor to another
process and exits, the GEM object outlives the original process. The mm_use=
rs
reference is held here until the BO is freed, preventing __mmput() from
executing and tearing down the original address space (VMAs, page tables,
anonymous memory).=20

Could a malicious application repeatedly create processes, allocate ubuf BO=
s,
pass the DRM fd to a daemon, and exit, rapidly exhausting system memory?

> +	drm_gem_object_release(gobj);
> +	amdxdna_gem_destroy_obj(abo);
>  }

[ ... ]

> @@ -91,31 +95,28 @@ struct amdxdna_gem_obj *amdxdna_alloc_ubuf_bo(struct =
amdxdna_client *client,
> +	abo->type =3D AMDXDNA_BO_SHARE;
> +	abo->mem.uva =3D va_ent->vaddr;
> +	to_gobj(abo)->funcs =3D &amdxdna_gem_ubuf_obj_funcs;
> +	drm_gem_private_object_init(&xdna->ddev, to_gobj(abo), bufsize);
> +
> +	if (!mmget_not_zero(client->mm)) {
> +		ret =3D -EFAULT;
> +		goto put_obj;
> +	}
> +
> +	abo->mem.mm =3D client->mm;

[Severity: High]
Is it safe to establish this persistent mm_users reference? This ties the
BO's lifetime to the process's full memory footprint, leading to the leak
described above in amdxdna_gem_ubuf_obj_free().

> +
> +	ret =3D amdxdna_ubuf_hmm_register(abo, va_ent);
> +	if (ret)
> +		goto put_obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921184226.1894=
1-1-lizhi.hou@amd.com?part=3D1
